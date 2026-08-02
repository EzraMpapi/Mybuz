-- ═══════════════════════════════════════════════════════════════════════════
-- SMART MANAGER — foundation
--
-- Tenancy model: the client never sends its own company_id filter. Every
-- query is scoped by RLS through current_company_id(), which reads the
-- authenticated session. That keeps the database the single authority on
-- which rows a session can see — a bug in the client cannot widen access.
-- ═══════════════════════════════════════════════════════════════════════════

create extension if not exists pgcrypto;

-- ── companies ──────────────────────────────────────────────────────────────
create table if not exists public.companies (
  id           uuid primary key default gen_random_uuid(),
  name         text        not null,
  category     text,
  tin          text,
  vrn          text,
  phone        text,
  email        text,
  address      text,
  city         text,
  country      text        not null default 'Tanzania',
  currency     text        not null default 'TZS',
  tax_rate     numeric(5,2) not null default 18.00,
  logo         text,
  join_code    text        not null unique default upper(substr(replace(gen_random_uuid()::text,'-',''),1,8)),
  created_at   timestamptz not null default now(),
  updated_at   timestamptz not null default now()
);

-- ── profiles: the user → company edge that RLS depends on ──────────────────
create table if not exists public.profiles (
  id           uuid primary key references auth.users(id) on delete cascade,
  company_id   uuid references public.companies(id) on delete set null,
  full_name    text,
  email        text,
  role         text not null default 'staff'
                 check (role in ('owner','admin','manager','staff','viewer')),
  phone        text,
  avatar_url   text,
  is_active    boolean not null default true,
  created_at   timestamptz not null default now(),
  updated_at   timestamptz not null default now()
);
create index if not exists profiles_company_idx on public.profiles(company_id);

-- ── the scoping function ───────────────────────────────────────────────────
-- STABLE so the planner caches it per statement rather than per row.
-- search_path is pinned: a SECURITY DEFINER function with a mutable
-- search_path is a privilege-escalation vector.
create or replace function public.current_company_id()
returns uuid
language sql
stable
security definer
set search_path = public, pg_temp
as $$
  select company_id from public.profiles where id = auth.uid();
$$;

revoke all on function public.current_company_id() from public;
grant execute on function public.current_company_id() to authenticated;

-- ── companies / profiles RLS ───────────────────────────────────────────────
alter table public.companies enable row level security;
alter table public.profiles  enable row level security;

drop policy if exists companies_select on public.companies;
create policy companies_select on public.companies
  for select to authenticated
  using (id = public.current_company_id());

drop policy if exists companies_update on public.companies;
create policy companies_update on public.companies
  for update to authenticated
  using (id = public.current_company_id())
  with check (id = public.current_company_id());

drop policy if exists profiles_self on public.profiles;
create policy profiles_self on public.profiles
  for select to authenticated
  using (id = auth.uid() or company_id = public.current_company_id());

drop policy if exists profiles_update_self on public.profiles;
create policy profiles_update_self on public.profiles
  for update to authenticated
  using (id = auth.uid())
  with check (id = auth.uid());

-- ── new auth user → profile row ────────────────────────────────────────────
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public, pg_temp
as $$
begin
  insert into public.profiles (id, email, full_name)
  values (new.id, new.email, coalesce(new.raw_user_meta_data->>'full_name', ''))
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ── RPC: create a company and make the caller its owner ────────────────────
create or replace function public.create_company_and_owner(p jsonb)
returns jsonb
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_uid uuid := auth.uid();
  v_id  uuid;
begin
  if v_uid is null then
    raise exception 'not authenticated' using errcode = '42501';
  end if;

  -- one company per user; re-running must not silently create a second
  if exists (select 1 from public.profiles where id = v_uid and company_id is not null) then
    raise exception 'user already belongs to a company' using errcode = '23505';
  end if;

  insert into public.companies (name, category, phone, email, address, city, tin, currency, tax_rate)
  values (
    coalesce(p->>'name', 'My Company'),
    p->>'category', p->>'phone', p->>'email', p->>'address', p->>'city', p->>'tin',
    coalesce(p->>'currency', 'TZS'),
    coalesce((p->>'tax_rate')::numeric, 18.00)
  )
  returning id into v_id;

  update public.profiles
     set company_id = v_id,
         role       = 'owner',
         full_name  = coalesce(nullif(p->>'full_name',''), full_name),
         updated_at = now()
   where id = v_uid;

  return jsonb_build_object(
    'company_id', v_id,
    'join_code',  (select join_code from public.companies where id = v_id)
  );
end;
$$;

revoke all on function public.create_company_and_owner(jsonb) from public, anon;
grant execute on function public.create_company_and_owner(jsonb) to authenticated;

-- ── RPC: join an existing company by code ──────────────────────────────────
create or replace function public.join_company_with_code(p jsonb)
returns jsonb
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_uid uuid := auth.uid();
  v_id  uuid;
begin
  if v_uid is null then
    raise exception 'not authenticated' using errcode = '42501';
  end if;

  select id into v_id
    from public.companies
   where join_code = upper(trim(coalesce(p->>'code','')));

  if v_id is null then
    raise exception 'invalid join code' using errcode = '22023';
  end if;

  update public.profiles
     set company_id = v_id,
         role       = coalesce(nullif(p->>'role',''), 'staff'),
         full_name  = coalesce(nullif(p->>'full_name',''), full_name),
         updated_at = now()
   where id = v_uid;

  return jsonb_build_object('company_id', v_id);
end;
$$;

revoke all on function public.join_company_with_code(jsonb) from public, anon;
grant execute on function public.join_company_with_code(jsonb) to authenticated;

-- ── storage: per-company prefixes, enforced by policy ──────────────────────
insert into storage.buckets (id, name, public, file_size_limit)
values
  ('company-logos', 'company-logos', true,  2097152),
  ('documents',     'documents',     false, 26214400),
  ('avatars',       'avatars',       true,  2097152)
on conflict (id) do nothing;

-- Objects live under <company_id>/..., so the first path segment is the
-- tenant key. Comparing it to current_company_id() is what stops one
-- company reading another's uploads.
drop policy if exists documents_rw on storage.objects;
create policy documents_rw on storage.objects
  for all to authenticated
  using      (bucket_id = 'documents' and (storage.foldername(name))[1] = public.current_company_id()::text)
  with check (bucket_id = 'documents' and (storage.foldername(name))[1] = public.current_company_id()::text);

drop policy if exists public_read on storage.objects;
create policy public_read on storage.objects
  for select to public
  using (bucket_id in ('company-logos','avatars'));

drop policy if exists public_write on storage.objects;
create policy public_write on storage.objects
  for insert to authenticated
  with check (bucket_id in ('company-logos','avatars')
              and (storage.foldername(name))[1] = public.current_company_id()::text);
