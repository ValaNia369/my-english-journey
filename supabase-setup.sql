-- Run in Supabase SQL Editor. Sign-up requires email confirmation unless disabled.
create table if not exists public.learning_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  updated_at timestamptz not null,
  payload jsonb not null
);
alter table public.learning_state enable row level security;
create policy "read own learning state" on public.learning_state for select to authenticated using (auth.uid() = user_id);
create policy "insert own learning state" on public.learning_state for insert to authenticated with check (auth.uid() = user_id);
create policy "update own learning state" on public.learning_state for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
