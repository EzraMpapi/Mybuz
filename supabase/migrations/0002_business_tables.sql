-- ═══════════════════════════════════════════════════════════════════════════
-- SMART MANAGER — business tables
--
-- Every table carries company_id and is scoped by one RLS policy comparing
-- it to current_company_id(). Written to be re-runnable: create-if-not-exists
-- throughout, so applying it twice is a no-op rather than an error.
--
-- NOTE: public.audit_log is deliberately NOT created here. That name is
-- already taken in this database by an unrelated application and the two
-- column shapes are incompatible. Resolve the target database first.
-- ═══════════════════════════════════════════════════════════════════════════

create table if not exists public.bank_accounts (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists bank_accounts_company_idx on public.bank_accounts(company_id);
alter table public.bank_accounts enable row level security;
drop policy if exists bank_accounts_tenant on public.bank_accounts;
create policy bank_accounts_tenant on public.bank_accounts
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.bank_fixed_deposits (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists bank_fixed_deposits_company_idx on public.bank_fixed_deposits(company_id);
alter table public.bank_fixed_deposits enable row level security;
drop policy if exists bank_fixed_deposits_tenant on public.bank_fixed_deposits;
create policy bank_fixed_deposits_tenant on public.bank_fixed_deposits
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.bank_loans (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists bank_loans_company_idx on public.bank_loans(company_id);
alter table public.bank_loans enable row level security;
drop policy if exists bank_loans_tenant on public.bank_loans;
create policy bank_loans_tenant on public.bank_loans
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.bank_standing_orders (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists bank_standing_orders_company_idx on public.bank_standing_orders(company_id);
alter table public.bank_standing_orders enable row level security;
drop policy if exists bank_standing_orders_tenant on public.bank_standing_orders;
create policy bank_standing_orders_tenant on public.bank_standing_orders
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.bank_transactions (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists bank_transactions_company_idx on public.bank_transactions(company_id);
alter table public.bank_transactions enable row level security;
drop policy if exists bank_transactions_tenant on public.bank_transactions;
create policy bank_transactions_tenant on public.bank_transactions
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.branches (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists branches_company_idx on public.branches(company_id);
alter table public.branches enable row level security;
drop policy if exists branches_tenant on public.branches;
create policy branches_tenant on public.branches
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.business_loans (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists business_loans_company_idx on public.business_loans(company_id);
alter table public.business_loans enable row level security;
drop policy if exists business_loans_tenant on public.business_loans;
create policy business_loans_tenant on public.business_loans
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.calendar_events (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  attendees                  text,
  description                text,
  end_time                   text,
  event_date                 timestamptz,
  event_type                 text,
  meeting_link               text,
  start_time                 text,
  title                      text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists calendar_events_company_idx on public.calendar_events(company_id);
alter table public.calendar_events enable row level security;
drop policy if exists calendar_events_tenant on public.calendar_events;
create policy calendar_events_tenant on public.calendar_events
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.collab_channels (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  description                text,
  name                       text,
  scope                      text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists collab_channels_company_idx on public.collab_channels(company_id);
alter table public.collab_channels enable row level security;
drop policy if exists collab_channels_tenant on public.collab_channels;
create policy collab_channels_tenant on public.collab_channels
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.community_contributions (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists community_contributions_company_idx on public.community_contributions(company_id);
alter table public.community_contributions enable row level security;
drop policy if exists community_contributions_tenant on public.community_contributions;
create policy community_contributions_tenant on public.community_contributions
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.community_groups (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists community_groups_company_idx on public.community_groups(company_id);
alter table public.community_groups enable row level security;
drop policy if exists community_groups_tenant on public.community_groups;
create policy community_groups_tenant on public.community_groups
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.competitors (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  category                   text,
  name                       text,
  notes                      text,
  threat_level               integer,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists competitors_company_idx on public.competitors(company_id);
alter table public.competitors enable row level security;
drop policy if exists competitors_tenant on public.competitors;
create policy competitors_tenant on public.competitors
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.crm_contacts (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists crm_contacts_company_idx on public.crm_contacts(company_id);
alter table public.crm_contacts enable row level security;
drop policy if exists crm_contacts_tenant on public.crm_contacts;
create policy crm_contacts_tenant on public.crm_contacts
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.crm_interactions (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists crm_interactions_company_idx on public.crm_interactions(company_id);
alter table public.crm_interactions enable row level security;
drop policy if exists crm_interactions_tenant on public.crm_interactions;
create policy crm_interactions_tenant on public.crm_interactions
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.crm_leads (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists crm_leads_company_idx on public.crm_leads(company_id);
alter table public.crm_leads enable row level security;
drop policy if exists crm_leads_tenant on public.crm_leads;
create policy crm_leads_tenant on public.crm_leads
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.custom_kpis (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  label                      text,
  metric_id                  uuid,
  target_value               numeric(18,2),
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists custom_kpis_company_idx on public.custom_kpis(company_id);
alter table public.custom_kpis enable row level security;
drop policy if exists custom_kpis_tenant on public.custom_kpis;
create policy custom_kpis_tenant on public.custom_kpis
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.customer_feedback (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists customer_feedback_company_idx on public.customer_feedback(company_id);
alter table public.customer_feedback enable row level security;
drop policy if exists customer_feedback_tenant on public.customer_feedback;
create policy customer_feedback_tenant on public.customer_feedback
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.departments (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists departments_company_idx on public.departments(company_id);
alter table public.departments enable row level security;
drop policy if exists departments_tenant on public.departments;
create policy departments_tenant on public.departments
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.documents (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists documents_company_idx on public.documents(company_id);
alter table public.documents enable row level security;
drop policy if exists documents_tenant on public.documents;
create policy documents_tenant on public.documents
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.ecommerce_orders (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists ecommerce_orders_company_idx on public.ecommerce_orders(company_id);
alter table public.ecommerce_orders enable row level security;
drop policy if exists ecommerce_orders_tenant on public.ecommerce_orders;
create policy ecommerce_orders_tenant on public.ecommerce_orders
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.ecommerce_products (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists ecommerce_products_company_idx on public.ecommerce_products(company_id);
alter table public.ecommerce_products enable row level security;
drop policy if exists ecommerce_products_tenant on public.ecommerce_products;
create policy ecommerce_products_tenant on public.ecommerce_products
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.expense_budgets (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists expense_budgets_company_idx on public.expense_budgets(company_id);
alter table public.expense_budgets enable row level security;
drop policy if exists expense_budgets_tenant on public.expense_budgets;
create policy expense_budgets_tenant on public.expense_budgets
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.finance_assets (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  acquisition_date           timestamptz,
  category                   text,
  cost                       text,
  name                       text,
  useful_life_years          text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists finance_assets_company_idx on public.finance_assets(company_id);
alter table public.finance_assets enable row level security;
drop policy if exists finance_assets_tenant on public.finance_assets;
create policy finance_assets_tenant on public.finance_assets
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.finance_expenses (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  amount                     text,
  category                   text,
  due_date                   timestamptz,
  expense_date               timestamptz,
  method                     text,
  status                     text,
  vendor                     text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists finance_expenses_company_idx on public.finance_expenses(company_id);
alter table public.finance_expenses enable row level security;
drop policy if exists finance_expenses_tenant on public.finance_expenses;
create policy finance_expenses_tenant on public.finance_expenses
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.financial_benchmarks (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  benchmark_value            numeric(18,2),
  label                      text,
  metric_id                  uuid,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists financial_benchmarks_company_idx on public.financial_benchmarks(company_id);
alter table public.financial_benchmarks enable row level security;
drop policy if exists financial_benchmarks_tenant on public.financial_benchmarks;
create policy financial_benchmarks_tenant on public.financial_benchmarks
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.flt_maintenance (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists flt_maintenance_company_idx on public.flt_maintenance(company_id);
alter table public.flt_maintenance enable row level security;
drop policy if exists flt_maintenance_tenant on public.flt_maintenance;
create policy flt_maintenance_tenant on public.flt_maintenance
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.flt_trips (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists flt_trips_company_idx on public.flt_trips(company_id);
alter table public.flt_trips enable row level security;
drop policy if exists flt_trips_tenant on public.flt_trips;
create policy flt_trips_tenant on public.flt_trips
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.flt_vehicles (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists flt_vehicles_company_idx on public.flt_vehicles(company_id);
alter table public.flt_vehicles enable row level security;
drop policy if exists flt_vehicles_tenant on public.flt_vehicles;
create policy flt_vehicles_tenant on public.flt_vehicles
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.hc_appointments (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists hc_appointments_company_idx on public.hc_appointments(company_id);
alter table public.hc_appointments enable row level security;
drop policy if exists hc_appointments_tenant on public.hc_appointments;
create policy hc_appointments_tenant on public.hc_appointments
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.hc_doctors (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists hc_doctors_company_idx on public.hc_doctors(company_id);
alter table public.hc_doctors enable row level security;
drop policy if exists hc_doctors_tenant on public.hc_doctors;
create policy hc_doctors_tenant on public.hc_doctors
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.hc_invoices (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists hc_invoices_company_idx on public.hc_invoices(company_id);
alter table public.hc_invoices enable row level security;
drop policy if exists hc_invoices_tenant on public.hc_invoices;
create policy hc_invoices_tenant on public.hc_invoices
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.hc_lab_orders (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists hc_lab_orders_company_idx on public.hc_lab_orders(company_id);
alter table public.hc_lab_orders enable row level security;
drop policy if exists hc_lab_orders_tenant on public.hc_lab_orders;
create policy hc_lab_orders_tenant on public.hc_lab_orders
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.hc_patients (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists hc_patients_company_idx on public.hc_patients(company_id);
alter table public.hc_patients enable row level security;
drop policy if exists hc_patients_tenant on public.hc_patients;
create policy hc_patients_tenant on public.hc_patients
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.hc_prescriptions (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists hc_prescriptions_company_idx on public.hc_prescriptions(company_id);
alter table public.hc_prescriptions enable row level security;
drop policy if exists hc_prescriptions_tenant on public.hc_prescriptions;
create policy hc_prescriptions_tenant on public.hc_prescriptions
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.hc_radiology (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists hc_radiology_company_idx on public.hc_radiology(company_id);
alter table public.hc_radiology enable row level security;
drop policy if exists hc_radiology_tenant on public.hc_radiology;
create policy hc_radiology_tenant on public.hc_radiology
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.hc_reports (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists hc_reports_company_idx on public.hc_reports(company_id);
alter table public.hc_reports enable row level security;
drop policy if exists hc_reports_tenant on public.hc_reports;
create policy hc_reports_tenant on public.hc_reports
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.hc_visits (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists hc_visits_company_idx on public.hc_visits(company_id);
alter table public.hc_visits enable row level security;
drop policy if exists hc_visits_tenant on public.hc_visits;
create policy hc_visits_tenant on public.hc_visits
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.hc_vitals (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists hc_vitals_company_idx on public.hc_vitals(company_id);
alter table public.hc_vitals enable row level security;
drop policy if exists hc_vitals_tenant on public.hc_vitals;
create policy hc_vitals_tenant on public.hc_vitals
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.hr_attendance (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists hr_attendance_company_idx on public.hr_attendance(company_id);
alter table public.hr_attendance enable row level security;
drop policy if exists hr_attendance_tenant on public.hr_attendance;
create policy hr_attendance_tenant on public.hr_attendance
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.hr_benefits (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists hr_benefits_company_idx on public.hr_benefits(company_id);
alter table public.hr_benefits enable row level security;
drop policy if exists hr_benefits_tenant on public.hr_benefits;
create policy hr_benefits_tenant on public.hr_benefits
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.hr_candidates (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists hr_candidates_company_idx on public.hr_candidates(company_id);
alter table public.hr_candidates enable row level security;
drop policy if exists hr_candidates_tenant on public.hr_candidates;
create policy hr_candidates_tenant on public.hr_candidates
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.hr_duties (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists hr_duties_company_idx on public.hr_duties(company_id);
alter table public.hr_duties enable row level security;
drop policy if exists hr_duties_tenant on public.hr_duties;
create policy hr_duties_tenant on public.hr_duties
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.hr_employees (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists hr_employees_company_idx on public.hr_employees(company_id);
alter table public.hr_employees enable row level security;
drop policy if exists hr_employees_tenant on public.hr_employees;
create policy hr_employees_tenant on public.hr_employees
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.hr_leave_requests (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists hr_leave_requests_company_idx on public.hr_leave_requests(company_id);
alter table public.hr_leave_requests enable row level security;
drop policy if exists hr_leave_requests_tenant on public.hr_leave_requests;
create policy hr_leave_requests_tenant on public.hr_leave_requests
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.hr_payroll_runs (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists hr_payroll_runs_company_idx on public.hr_payroll_runs(company_id);
alter table public.hr_payroll_runs enable row level security;
drop policy if exists hr_payroll_runs_tenant on public.hr_payroll_runs;
create policy hr_payroll_runs_tenant on public.hr_payroll_runs
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.hr_performance_reviews (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists hr_performance_reviews_company_idx on public.hr_performance_reviews(company_id);
alter table public.hr_performance_reviews enable row level security;
drop policy if exists hr_performance_reviews_tenant on public.hr_performance_reviews;
create policy hr_performance_reviews_tenant on public.hr_performance_reviews
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.hr_training (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  completion_date            timestamptz,
  course                     text,
  due_date                   timestamptz,
  employee_name              text,
  hr_employees               text,
  is_compliance              boolean,
  is_mandatory               boolean,
  status                     text,
  video_url                  text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists hr_training_company_idx on public.hr_training(company_id);
alter table public.hr_training enable row level security;
drop policy if exists hr_training_tenant on public.hr_training;
create policy hr_training_tenant on public.hr_training
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.htl_bookings (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists htl_bookings_company_idx on public.htl_bookings(company_id);
alter table public.htl_bookings enable row level security;
drop policy if exists htl_bookings_tenant on public.htl_bookings;
create policy htl_bookings_tenant on public.htl_bookings
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.htl_rooms (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists htl_rooms_company_idx on public.htl_rooms(company_id);
alter table public.htl_rooms enable row level security;
drop policy if exists htl_rooms_tenant on public.htl_rooms;
create policy htl_rooms_tenant on public.htl_rooms
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.integration_connections (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists integration_connections_company_idx on public.integration_connections(company_id);
alter table public.integration_connections enable row level security;
drop policy if exists integration_connections_tenant on public.integration_connections;
create policy integration_connections_tenant on public.integration_connections
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.inventory_batches (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists inventory_batches_company_idx on public.inventory_batches(company_id);
alter table public.inventory_batches enable row level security;
drop policy if exists inventory_batches_tenant on public.inventory_batches;
create policy inventory_batches_tenant on public.inventory_batches
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.inventory_items (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists inventory_items_company_idx on public.inventory_items(company_id);
alter table public.inventory_items enable row level security;
drop policy if exists inventory_items_tenant on public.inventory_items;
create policy inventory_items_tenant on public.inventory_items
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.inventory_suppliers (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists inventory_suppliers_company_idx on public.inventory_suppliers(company_id);
alter table public.inventory_suppliers enable row level security;
drop policy if exists inventory_suppliers_tenant on public.inventory_suppliers;
create policy inventory_suppliers_tenant on public.inventory_suppliers
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.inventory_transfers (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists inventory_transfers_company_idx on public.inventory_transfers(company_id);
alter table public.inventory_transfers enable row level security;
drop policy if exists inventory_transfers_tenant on public.inventory_transfers;
create policy inventory_transfers_tenant on public.inventory_transfers
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.inventory_warehouses (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists inventory_warehouses_company_idx on public.inventory_warehouses(company_id);
alter table public.inventory_warehouses enable row level security;
drop policy if exists inventory_warehouses_tenant on public.inventory_warehouses;
create policy inventory_warehouses_tenant on public.inventory_warehouses
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.kb_articles (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists kb_articles_company_idx on public.kb_articles(company_id);
alter table public.kb_articles enable row level security;
drop policy if exists kb_articles_tenant on public.kb_articles;
create policy kb_articles_tenant on public.kb_articles
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.manufacturing_boms (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists manufacturing_boms_company_idx on public.manufacturing_boms(company_id);
alter table public.manufacturing_boms enable row level security;
drop policy if exists manufacturing_boms_tenant on public.manufacturing_boms;
create policy manufacturing_boms_tenant on public.manufacturing_boms
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.manufacturing_machines (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  machine_type               text,
  name                       text,
  purchase_date              timestamptz,
  status                     text,
  warehouse_id               uuid,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists manufacturing_machines_company_idx on public.manufacturing_machines(company_id);
alter table public.manufacturing_machines enable row level security;
drop policy if exists manufacturing_machines_tenant on public.manufacturing_machines;
create policy manufacturing_machines_tenant on public.manufacturing_machines
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.manufacturing_maintenance (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  cost                       text,
  machine_name               text,
  maintenance_date           timestamptz,
  maintenance_type           text,
  next_due_date              timestamptz,
  notes                      text,
  technician                 text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists manufacturing_maintenance_company_idx on public.manufacturing_maintenance(company_id);
alter table public.manufacturing_maintenance enable row level security;
drop policy if exists manufacturing_maintenance_tenant on public.manufacturing_maintenance;
create policy manufacturing_maintenance_tenant on public.manufacturing_maintenance
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.manufacturing_qc_inspections (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists manufacturing_qc_inspections_company_idx on public.manufacturing_qc_inspections(company_id);
alter table public.manufacturing_qc_inspections enable row level security;
drop policy if exists manufacturing_qc_inspections_tenant on public.manufacturing_qc_inspections;
create policy manufacturing_qc_inspections_tenant on public.manufacturing_qc_inspections
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.manufacturing_work_orders (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists manufacturing_work_orders_company_idx on public.manufacturing_work_orders(company_id);
alter table public.manufacturing_work_orders enable row level security;
drop policy if exists manufacturing_work_orders_tenant on public.manufacturing_work_orders;
create policy manufacturing_work_orders_tenant on public.manufacturing_work_orders
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.marketing_campaigns (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists marketing_campaigns_company_idx on public.marketing_campaigns(company_id);
alter table public.marketing_campaigns enable row level security;
drop policy if exists marketing_campaigns_tenant on public.marketing_campaigns;
create policy marketing_campaigns_tenant on public.marketing_campaigns
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.mfi_clients (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists mfi_clients_company_idx on public.mfi_clients(company_id);
alter table public.mfi_clients enable row level security;
drop policy if exists mfi_clients_tenant on public.mfi_clients;
create policy mfi_clients_tenant on public.mfi_clients
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.mfi_loans (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists mfi_loans_company_idx on public.mfi_loans(company_id);
alter table public.mfi_loans enable row level security;
drop policy if exists mfi_loans_tenant on public.mfi_loans;
create policy mfi_loans_tenant on public.mfi_loans
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.mfi_savings (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists mfi_savings_company_idx on public.mfi_savings(company_id);
alter table public.mfi_savings enable row level security;
drop policy if exists mfi_savings_tenant on public.mfi_savings;
create policy mfi_savings_tenant on public.mfi_savings
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.network_profiles (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists network_profiles_company_idx on public.network_profiles(company_id);
alter table public.network_profiles enable row level security;
drop policy if exists network_profiles_tenant on public.network_profiles;
create policy network_profiles_tenant on public.network_profiles
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.network_rfqs (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists network_rfqs_company_idx on public.network_rfqs(company_id);
alter table public.network_rfqs enable row level security;
drop policy if exists network_rfqs_tenant on public.network_rfqs;
create policy network_rfqs_tenant on public.network_rfqs
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.notebook_notes (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists notebook_notes_company_idx on public.notebook_notes(company_id);
alter table public.notebook_notes enable row level security;
drop policy if exists notebook_notes_tenant on public.notebook_notes;
create policy notebook_notes_tenant on public.notebook_notes
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.notification_channels (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  business_number            text,
  channel_id                 uuid,
  enabled                    text,
  from_address               text,
  from_number                text,
  server_key                 text,
  webhook_url                text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists notification_channels_company_idx on public.notification_channels(company_id);
alter table public.notification_channels enable row level security;
drop policy if exists notification_channels_tenant on public.notification_channels;
create policy notification_channels_tenant on public.notification_channels
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.notification_log (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists notification_log_company_idx on public.notification_log(company_id);
alter table public.notification_log enable row level security;
drop policy if exists notification_log_tenant on public.notification_log;
create policy notification_log_tenant on public.notification_log
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.notification_rules (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  alert_type                 text,
  channels                   text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists notification_rules_company_idx on public.notification_rules(company_id);
alter table public.notification_rules enable row level security;
drop policy if exists notification_rules_tenant on public.notification_rules;
create policy notification_rules_tenant on public.notification_rules
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.other_debtors (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists other_debtors_company_idx on public.other_debtors(company_id);
alter table public.other_debtors enable row level security;
drop policy if exists other_debtors_tenant on public.other_debtors;
create policy other_debtors_tenant on public.other_debtors
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.other_income (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists other_income_company_idx on public.other_income(company_id);
alter table public.other_income enable row level security;
drop policy if exists other_income_tenant on public.other_income;
create policy other_income_tenant on public.other_income
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.phm_dispense (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists phm_dispense_company_idx on public.phm_dispense(company_id);
alter table public.phm_dispense enable row level security;
drop policy if exists phm_dispense_tenant on public.phm_dispense;
create policy phm_dispense_tenant on public.phm_dispense
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.phm_drugs (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists phm_drugs_company_idx on public.phm_drugs(company_id);
alter table public.phm_drugs enable row level security;
drop policy if exists phm_drugs_tenant on public.phm_drugs;
create policy phm_drugs_tenant on public.phm_drugs
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.phm_stock (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists phm_stock_company_idx on public.phm_stock(company_id);
alter table public.phm_stock enable row level security;
drop policy if exists phm_stock_tenant on public.phm_stock;
create policy phm_stock_tenant on public.phm_stock
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.phm_suppliers (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists phm_suppliers_company_idx on public.phm_suppliers(company_id);
alter table public.phm_suppliers enable row level security;
drop policy if exists phm_suppliers_tenant on public.phm_suppliers;
create policy phm_suppliers_tenant on public.phm_suppliers
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.pos_cash_movements (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists pos_cash_movements_company_idx on public.pos_cash_movements(company_id);
alter table public.pos_cash_movements enable row level security;
drop policy if exists pos_cash_movements_tenant on public.pos_cash_movements;
create policy pos_cash_movements_tenant on public.pos_cash_movements
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.pos_shifts (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists pos_shifts_company_idx on public.pos_shifts(company_id);
alter table public.pos_shifts enable row level security;
drop policy if exists pos_shifts_tenant on public.pos_shifts;
create policy pos_shifts_tenant on public.pos_shifts
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.pos_transactions (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists pos_transactions_company_idx on public.pos_transactions(company_id);
alter table public.pos_transactions enable row level security;
drop policy if exists pos_transactions_tenant on public.pos_transactions;
create policy pos_transactions_tenant on public.pos_transactions
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.procurement_contracts (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  contract_type              text,
  doc_number                 text,
  end_date                   timestamptz,
  notes                      text,
  start_date                 timestamptz,
  supplier                   text,
  value                      text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists procurement_contracts_company_idx on public.procurement_contracts(company_id);
alter table public.procurement_contracts enable row level security;
drop policy if exists procurement_contracts_tenant on public.procurement_contracts;
create policy procurement_contracts_tenant on public.procurement_contracts
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.procurement_purchase_orders (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists procurement_purchase_orders_company_idx on public.procurement_purchase_orders(company_id);
alter table public.procurement_purchase_orders enable row level security;
drop policy if exists procurement_purchase_orders_tenant on public.procurement_purchase_orders;
create policy procurement_purchase_orders_tenant on public.procurement_purchase_orders
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.project_expenses (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  amount                     text,
  description                text,
  expense_date               timestamptz,
  project_ref                text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists project_expenses_company_idx on public.project_expenses(company_id);
alter table public.project_expenses enable row level security;
drop policy if exists project_expenses_tenant on public.project_expenses;
create policy project_expenses_tenant on public.project_expenses
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.project_milestones (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists project_milestones_company_idx on public.project_milestones(company_id);
alter table public.project_milestones enable row level security;
drop policy if exists project_milestones_tenant on public.project_milestones;
create policy project_milestones_tenant on public.project_milestones
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.project_tasks (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists project_tasks_company_idx on public.project_tasks(company_id);
alter table public.project_tasks enable row level security;
drop policy if exists project_tasks_tenant on public.project_tasks;
create policy project_tasks_tenant on public.project_tasks
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.projects (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  budget                     text,
  client                     text,
  end_date                   timestamptz,
  manager                    text,
  name                       text,
  start_date                 timestamptz,
  status                     text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists projects_company_idx on public.projects(company_id);
alter table public.projects enable row level security;
drop policy if exists projects_tenant on public.projects;
create policy projects_tenant on public.projects
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.resource_bookings (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists resource_bookings_company_idx on public.resource_bookings(company_id);
alter table public.resource_bookings enable row level security;
drop policy if exists resource_bookings_tenant on public.resource_bookings;
create policy resource_bookings_tenant on public.resource_bookings
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.rst_menu (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists rst_menu_company_idx on public.rst_menu(company_id);
alter table public.rst_menu enable row level security;
drop policy if exists rst_menu_tenant on public.rst_menu;
create policy rst_menu_tenant on public.rst_menu
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.rst_orders (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists rst_orders_company_idx on public.rst_orders(company_id);
alter table public.rst_orders enable row level security;
drop policy if exists rst_orders_tenant on public.rst_orders;
create policy rst_orders_tenant on public.rst_orders
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.rst_reservations (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists rst_reservations_company_idx on public.rst_reservations(company_id);
alter table public.rst_reservations enable row level security;
drop policy if exists rst_reservations_tenant on public.rst_reservations;
create policy rst_reservations_tenant on public.rst_reservations
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.rst_tables (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists rst_tables_company_idx on public.rst_tables(company_id);
alter table public.rst_tables enable row level security;
drop policy if exists rst_tables_tenant on public.rst_tables;
create policy rst_tables_tenant on public.rst_tables
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.sales_invoices (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists sales_invoices_company_idx on public.sales_invoices(company_id);
alter table public.sales_invoices enable row level security;
drop policy if exists sales_invoices_tenant on public.sales_invoices;
create policy sales_invoices_tenant on public.sales_invoices
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.sales_orders (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  customer                   text,
  doc_number                 text,
  order_date                 timestamptz,
  owner_id                   uuid,
  quotation_id               uuid,
  sales_order_items          text,
  sales_order_returns        text,
  status                     text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists sales_orders_company_idx on public.sales_orders(company_id);
alter table public.sales_orders enable row level security;
drop policy if exists sales_orders_tenant on public.sales_orders;
create policy sales_orders_tenant on public.sales_orders
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.sales_quotations (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists sales_quotations_company_idx on public.sales_quotations(company_id);
alter table public.sales_quotations enable row level security;
drop policy if exists sales_quotations_tenant on public.sales_quotations;
create policy sales_quotations_tenant on public.sales_quotations
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.sales_subscriptions (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists sales_subscriptions_company_idx on public.sales_subscriptions(company_id);
alter table public.sales_subscriptions enable row level security;
drop policy if exists sales_subscriptions_tenant on public.sales_subscriptions;
create policy sales_subscriptions_tenant on public.sales_subscriptions
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.sch_books (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists sch_books_company_idx on public.sch_books(company_id);
alter table public.sch_books enable row level security;
drop policy if exists sch_books_tenant on public.sch_books;
create policy sch_books_tenant on public.sch_books
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.sch_classes (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists sch_classes_company_idx on public.sch_classes(company_id);
alter table public.sch_classes enable row level security;
drop policy if exists sch_classes_tenant on public.sch_classes;
create policy sch_classes_tenant on public.sch_classes
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.sch_exams (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists sch_exams_company_idx on public.sch_exams(company_id);
alter table public.sch_exams enable row level security;
drop policy if exists sch_exams_tenant on public.sch_exams;
create policy sch_exams_tenant on public.sch_exams
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.sch_fees (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists sch_fees_company_idx on public.sch_fees(company_id);
alter table public.sch_fees enable row level security;
drop policy if exists sch_fees_tenant on public.sch_fees;
create policy sch_fees_tenant on public.sch_fees
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.sch_students (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists sch_students_company_idx on public.sch_students(company_id);
alter table public.sch_students enable row level security;
drop policy if exists sch_students_tenant on public.sch_students;
create policy sch_students_tenant on public.sch_students
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.sch_teachers (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists sch_teachers_company_idx on public.sch_teachers(company_id);
alter table public.sch_teachers enable row level security;
drop policy if exists sch_teachers_tenant on public.sch_teachers;
create policy sch_teachers_tenant on public.sch_teachers
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.sch_transport (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists sch_transport_company_idx on public.sch_transport(company_id);
alter table public.sch_transport enable row level security;
drop policy if exists sch_transport_tenant on public.sch_transport;
create policy sch_transport_tenant on public.sch_transport
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.scheduled_reports (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  format                     text,
  frequency                  text,
  last_run                   text,
  recipient_email            text,
  report_type                text,
  status                     text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists scheduled_reports_company_idx on public.scheduled_reports(company_id);
alter table public.scheduled_reports enable row level security;
drop policy if exists scheduled_reports_tenant on public.scheduled_reports;
create policy scheduled_reports_tenant on public.scheduled_reports
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.scm_shipments (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists scm_shipments_company_idx on public.scm_shipments(company_id);
alter table public.scm_shipments enable row level security;
drop policy if exists scm_shipments_tenant on public.scm_shipments;
create policy scm_shipments_tenant on public.scm_shipments
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.scm_vehicles (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists scm_vehicles_company_idx on public.scm_vehicles(company_id);
alter table public.scm_vehicles enable row level security;
drop policy if exists scm_vehicles_tenant on public.scm_vehicles;
create policy scm_vehicles_tenant on public.scm_vehicles
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.signatures (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists signatures_company_idx on public.signatures(company_id);
alter table public.signatures enable row level security;
drop policy if exists signatures_tenant on public.signatures;
create policy signatures_tenant on public.signatures
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.sms_groups (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists sms_groups_company_idx on public.sms_groups(company_id);
alter table public.sms_groups enable row level security;
drop policy if exists sms_groups_tenant on public.sms_groups;
create policy sms_groups_tenant on public.sms_groups
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.sms_templates (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists sms_templates_company_idx on public.sms_templates(company_id);
alter table public.sms_templates enable row level security;
drop policy if exists sms_templates_tenant on public.sms_templates;
create policy sms_templates_tenant on public.sms_templates
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.stock_audits (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists stock_audits_company_idx on public.stock_audits(company_id);
alter table public.stock_audits enable row level security;
drop policy if exists stock_audits_tenant on public.stock_audits;
create policy stock_audits_tenant on public.stock_audits
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.support_call_log (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists support_call_log_company_idx on public.support_call_log(company_id);
alter table public.support_call_log enable row level security;
drop policy if exists support_call_log_tenant on public.support_call_log;
create policy support_call_log_tenant on public.support_call_log
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.support_chat_conversations (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists support_chat_conversations_company_idx on public.support_chat_conversations(company_id);
alter table public.support_chat_conversations enable row level security;
drop policy if exists support_chat_conversations_tenant on public.support_chat_conversations;
create policy support_chat_conversations_tenant on public.support_chat_conversations
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.support_tickets (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  assignee                   text,
  category                   text,
  created_date               timestamptz,
  customer                   text,
  doc_number                 text,
  priority                   text,
  status                     text,
  subject                    text,
  support_ticket_messages    text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists support_tickets_company_idx on public.support_tickets(company_id);
alter table public.support_tickets enable row level security;
drop policy if exists support_tickets_tenant on public.support_tickets;
create policy support_tickets_tenant on public.support_tickets
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.vicoba_loans (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists vicoba_loans_company_idx on public.vicoba_loans(company_id);
alter table public.vicoba_loans enable row level security;
drop policy if exists vicoba_loans_tenant on public.vicoba_loans;
create policy vicoba_loans_tenant on public.vicoba_loans
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.vicoba_meetings (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists vicoba_meetings_company_idx on public.vicoba_meetings(company_id);
alter table public.vicoba_meetings enable row level security;
drop policy if exists vicoba_meetings_tenant on public.vicoba_meetings;
create policy vicoba_meetings_tenant on public.vicoba_meetings
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.vicoba_members (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists vicoba_members_company_idx on public.vicoba_members(company_id);
alter table public.vicoba_members enable row level security;
drop policy if exists vicoba_members_tenant on public.vicoba_members;
create policy vicoba_members_tenant on public.vicoba_members
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.workflow_marketplace_templates (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  category                   text,
  description                text,
  install_count              integer,
  is_official                boolean,
  name                       text,
  published_by_company_name  text,
  steps                      text,
  trigger_type               text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists workflow_marketplace_templates_company_idx on public.workflow_marketplace_templates(company_id);
alter table public.workflow_marketplace_templates enable row level security;
drop policy if exists workflow_marketplace_templates_tenant on public.workflow_marketplace_templates;
create policy workflow_marketplace_templates_tenant on public.workflow_marketplace_templates
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.workflows (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  condition                  text,
  enabled                    text,
  last_run                   text,
  name                       text,
  steps                      text,
  trigger_type               text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists workflows_company_idx on public.workflows(company_id);
alter table public.workflows enable row level security;
drop policy if exists workflows_tenant on public.workflows;
create policy workflows_tenant on public.workflows
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.workspaces (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade,
  channel_ref                text,
  department                 text,
  description                text,
  members                    text,
  name                       text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists workspaces_company_idx on public.workspaces(company_id);
alter table public.workspaces enable row level security;
drop policy if exists workspaces_tenant on public.workspaces;
create policy workspaces_tenant on public.workspaces
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());
