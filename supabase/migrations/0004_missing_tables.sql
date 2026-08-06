-- Missing tables migration


create table if not exists public.approval_signatures (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists approval_signatures_company_idx on public.approval_signatures(company_id);
alter table public.approval_signatures enable row level security;
drop policy if exists approval_signatures_tenant on public.approval_signatures;
create policy approval_signatures_tenant on public.approval_signatures
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.collab_messages (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists collab_messages_company_idx on public.collab_messages(company_id);
alter table public.collab_messages enable row level security;
drop policy if exists collab_messages_tenant on public.collab_messages;
create policy collab_messages_tenant on public.collab_messages
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.company_modules (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists company_modules_company_idx on public.company_modules(company_id);
alter table public.company_modules enable row level security;
drop policy if exists company_modules_tenant on public.company_modules;
create policy company_modules_tenant on public.company_modules
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.digital_signatures (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists digital_signatures_company_idx on public.digital_signatures(company_id);
alter table public.digital_signatures enable row level security;
drop policy if exists digital_signatures_tenant on public.digital_signatures;
create policy digital_signatures_tenant on public.digital_signatures
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.emails (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists emails_company_idx on public.emails(company_id);
alter table public.emails enable row level security;
drop policy if exists emails_tenant on public.emails;
create policy emails_tenant on public.emails
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.hr_invite_codes (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists hr_invite_codes_company_idx on public.hr_invite_codes(company_id);
alter table public.hr_invite_codes enable row level security;
drop policy if exists hr_invite_codes_tenant on public.hr_invite_codes;
create policy hr_invite_codes_tenant on public.hr_invite_codes
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.inventory_stock_movements (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists inventory_stock_movements_company_idx on public.inventory_stock_movements(company_id);
alter table public.inventory_stock_movements enable row level security;
drop policy if exists inventory_stock_movements_tenant on public.inventory_stock_movements;
create policy inventory_stock_movements_tenant on public.inventory_stock_movements
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.journal_entries (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists journal_entries_company_idx on public.journal_entries(company_id);
alter table public.journal_entries enable row level security;
drop policy if exists journal_entries_tenant on public.journal_entries;
create policy journal_entries_tenant on public.journal_entries
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.loan_repayments (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists loan_repayments_company_idx on public.loan_repayments(company_id);
alter table public.loan_repayments enable row level security;
drop policy if exists loan_repayments_tenant on public.loan_repayments;
create policy loan_repayments_tenant on public.loan_repayments
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.manufacturing_bom_components (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists manufacturing_bom_components_company_idx on public.manufacturing_bom_components(company_id);
alter table public.manufacturing_bom_components enable row level security;
drop policy if exists manufacturing_bom_components_tenant on public.manufacturing_bom_components;
create policy manufacturing_bom_components_tenant on public.manufacturing_bom_components
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.period_closes (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists period_closes_company_idx on public.period_closes(company_id);
alter table public.period_closes enable row level security;
drop policy if exists period_closes_tenant on public.period_closes;
create policy period_closes_tenant on public.period_closes
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.pos_return_items (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists pos_return_items_company_idx on public.pos_return_items(company_id);
alter table public.pos_return_items enable row level security;
drop policy if exists pos_return_items_tenant on public.pos_return_items;
create policy pos_return_items_tenant on public.pos_return_items
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.pos_returns (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists pos_returns_company_idx on public.pos_returns(company_id);
alter table public.pos_returns enable row level security;
drop policy if exists pos_returns_tenant on public.pos_returns;
create policy pos_returns_tenant on public.pos_returns
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.pos_transaction_items (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists pos_transaction_items_company_idx on public.pos_transaction_items(company_id);
alter table public.pos_transaction_items enable row level security;
drop policy if exists pos_transaction_items_tenant on public.pos_transaction_items;
create policy pos_transaction_items_tenant on public.pos_transaction_items
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.purchase_order_items (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists purchase_order_items_company_idx on public.purchase_order_items(company_id);
alter table public.purchase_order_items enable row level security;
drop policy if exists purchase_order_items_tenant on public.purchase_order_items;
create policy purchase_order_items_tenant on public.purchase_order_items
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.sales_invoice_items (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists sales_invoice_items_company_idx on public.sales_invoice_items(company_id);
alter table public.sales_invoice_items enable row level security;
drop policy if exists sales_invoice_items_tenant on public.sales_invoice_items;
create policy sales_invoice_items_tenant on public.sales_invoice_items
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.sales_order_items (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists sales_order_items_company_idx on public.sales_order_items(company_id);
alter table public.sales_order_items enable row level security;
drop policy if exists sales_order_items_tenant on public.sales_order_items;
create policy sales_order_items_tenant on public.sales_order_items
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.sales_quotation_items (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists sales_quotation_items_company_idx on public.sales_quotation_items(company_id);
alter table public.sales_quotation_items enable row level security;
drop policy if exists sales_quotation_items_tenant on public.sales_quotation_items;
create policy sales_quotation_items_tenant on public.sales_quotation_items
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.sales_order_return_items (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists sales_order_return_items_company_idx on public.sales_order_return_items(company_id);
alter table public.sales_order_return_items enable row level security;
drop policy if exists sales_order_return_items_tenant on public.sales_order_return_items;
create policy sales_order_return_items_tenant on public.sales_order_return_items
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.sales_order_returns (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists sales_order_returns_company_idx on public.sales_order_returns(company_id);
alter table public.sales_order_returns enable row level security;
drop policy if exists sales_order_returns_tenant on public.sales_order_returns;
create policy sales_order_returns_tenant on public.sales_order_returns
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.sales_payments (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists sales_payments_company_idx on public.sales_payments(company_id);
alter table public.sales_payments enable row level security;
drop policy if exists sales_payments_tenant on public.sales_payments;
create policy sales_payments_tenant on public.sales_payments
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.sms_group_members (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists sms_group_members_company_idx on public.sms_group_members(company_id);
alter table public.sms_group_members enable row level security;
drop policy if exists sms_group_members_tenant on public.sms_group_members;
create policy sms_group_members_tenant on public.sms_group_members
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.stock_audit_items (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists stock_audit_items_company_idx on public.stock_audit_items(company_id);
alter table public.stock_audit_items enable row level security;
drop policy if exists stock_audit_items_tenant on public.stock_audit_items;
create policy stock_audit_items_tenant on public.stock_audit_items
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.support_chat_messages (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists support_chat_messages_company_idx on public.support_chat_messages(company_id);
alter table public.support_chat_messages enable row level security;
drop policy if exists support_chat_messages_tenant on public.support_chat_messages;
create policy support_chat_messages_tenant on public.support_chat_messages
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.support_ticket_messages (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists support_ticket_messages_company_idx on public.support_ticket_messages(company_id);
alter table public.support_ticket_messages enable row level security;
drop policy if exists support_ticket_messages_tenant on public.support_ticket_messages;
create policy support_ticket_messages_tenant on public.support_ticket_messages
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());

create table if not exists public.whatsapp_messages (
  id          uuid primary key default gen_random_uuid(),
  company_id  uuid not null references public.companies(id) on delete cascade default public.current_company_id(),
  name        text,
  status      text,
  amount      numeric(18,2),
  notes       text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists whatsapp_messages_company_idx on public.whatsapp_messages(company_id);
alter table public.whatsapp_messages enable row level security;
drop policy if exists whatsapp_messages_tenant on public.whatsapp_messages;
create policy whatsapp_messages_tenant on public.whatsapp_messages
  for all to authenticated
  using      (company_id = public.current_company_id())
  with check (company_id = public.current_company_id());
