-- ═══════════════════════════════════════════════════════════════════════════
-- SMART MANAGER — insert path + audit trail
--
-- Two fixes found by testing the client's real write path against the schema.
-- ═══════════════════════════════════════════════════════════════════════════

-- ── 1. the ERP audit trail ─────────────────────────────────────────────────
-- Named sm_audit_log, not audit_log: that name is taken in this database by
-- an unrelated ticketing application whose shape has no company_id and so
-- cannot carry tenant RLS.
create table if not exists public.sm_audit_log (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  action      text not null,
  module      text,
  actor       text not null default 'Unattributed',
  details     text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists sm_audit_log_company_idx on public.sm_audit_log(company_id);
create index if not exists sm_audit_log_recent_idx  on public.sm_audit_log(company_id, created_at desc);
alter table public.sm_audit_log enable row level security;
drop policy if exists sm_audit_log_tenant on public.sm_audit_log;
create policy sm_audit_log_tenant on public.sm_audit_log
  for all to authenticated
  using      (company_id = (select public.current_company_id()))
  with check (company_id = (select public.current_company_id()));

-- ── 2. company_id default on every tenant table ────────────────────────────
-- The client never sends company_id. That is deliberate and correct: if the
-- browser supplied the tenant key, a tampered client could write into another
-- company. But it left every INSERT failing the NOT NULL constraint.
--
-- Defaulting from current_company_id() resolves it without weakening anything.
-- The value is derived from the session on the server, never from the request
-- body, so it still cannot be forged — and the RLS WITH CHECK verifies it
-- independently on the way in.
do $mig$
declare t text;
begin
  for t in
    select c.relname from pg_class c
    join pg_namespace n on n.oid = c.relnamespace
    where n.nspname = 'public' and c.relkind = 'r'
      and exists (select 1 from pg_attribute a
                  where a.attrelid = c.oid and a.attname = 'company_id' and not a.attisdropped)
  loop
    execute format(
      'alter table public.%I alter column company_id set default public.current_company_id()', t);
  end loop;
end $mig$;

-- profiles is the exception: company_id is assigned by the join/create RPCs
-- and must stay null until the user actually belongs somewhere.
alter table public.profiles alter column company_id drop default;

-- ── 3. RLS initplan ────────────────────────────────────────────────────────
-- auth.uid() written bare is re-evaluated once per row. A scalar subquery
-- lets the planner hoist it to an InitPlan and evaluate it once per statement.
drop policy if exists profiles_self on public.profiles;
create policy profiles_self on public.profiles
  for select to authenticated
  using (id = (select auth.uid()) or company_id = (select public.current_company_id()));

drop policy if exists profiles_update_self on public.profiles;
create policy profiles_update_self on public.profiles
  for update to authenticated
  using      (id = (select auth.uid()))
  with check (id = (select auth.uid()));

do $mig$
declare t text;
begin
  for t in
    select c.relname from pg_class c
    join pg_namespace n on n.oid=c.relnamespace
    where n.nspname='public' and c.relkind='r'
      and exists (select 1 from pg_attribute a
                  where a.attrelid=c.oid and a.attname='company_id' and not a.attisdropped)
      and c.relname <> 'profiles'
  loop
    execute format('drop policy if exists %I on public.%I', t||'_tenant', t);
    execute format($f$create policy %I on public.%I for all to authenticated
      using      (company_id = (select public.current_company_id()))
      with check (company_id = (select public.current_company_id()))$f$, t||'_tenant', t);
  end loop;
end $mig$;
