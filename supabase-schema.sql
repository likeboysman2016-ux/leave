create table if not exists departments (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  color text not null default '#1d6863',
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists employees (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  department_id uuid references departments(id),
  color text not null default '#1d6863',
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists leave_types (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  color text not null default '#1d6863',
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists leave_records (
  id uuid primary key default gen_random_uuid(),
  employee_id uuid not null references employees(id),
  leave_type_id uuid references leave_types(id),
  custom_type text,
  start_date date not null,
  end_date date not null,
  start_time time not null default '08:00',
  end_time time not null default '17:00',
  deleted boolean not null default false,
  deleted_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint leave_date_order check (end_date >= start_date),
  constraint leave_type_present check (leave_type_id is not null or nullif(trim(custom_type), '') is not null)
);

create table if not exists audit_logs (
  id uuid primary key default gen_random_uuid(),
  action text not null,
  detail text not null,
  created_at timestamptz not null default now()
);

alter table departments enable row level security;
alter table employees enable row level security;
alter table leave_types enable row level security;
alter table leave_records enable row level security;
alter table audit_logs enable row level security;

drop policy if exists "public access departments" on departments;
drop policy if exists "public access employees" on employees;
drop policy if exists "public access leave types" on leave_types;
drop policy if exists "public access leave records" on leave_records;
drop policy if exists "public access audit logs" on audit_logs;

create policy "public access departments" on departments for all using (true) with check (true);
create policy "public access employees" on employees for all using (true) with check (true);
create policy "public access leave types" on leave_types for all using (true) with check (true);
create policy "public access leave records" on leave_records for all using (true) with check (true);
create policy "public access audit logs" on audit_logs for all using (true) with check (true);