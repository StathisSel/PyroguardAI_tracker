-- PyroGuard AI Tracker — Supabase schema
-- Τρέξε ολόκληρο αυτό το αρχείο μέσα στο: Supabase Dashboard → SQL Editor → New query → Run

create table if not exists stations (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);

-- Ενεργοποίηση Row Level Security
alter table stations enable row level security;

-- Πρόσβαση χωρίς login (κοινό link, 1-3 συνεργάτες, χωρίς ξεχωριστά λογαριασμό ο καθένας).
-- Σημείωση: αυτό σημαίνει ότι ΟΠΟΙΟΣ έχει το link / το anon key μπορεί να διαβάσει ή να
-- αλλάξει τα δεδομένα. Αν στο μέλλον θέλεις περιορισμό ανά χρήστη, αντικατέστησε αυτές τις
-- πολιτικές με Supabase Auth (email/password) + πολιτικές βάσει auth.uid().
create policy "public read" on stations
  for select using (true);

create policy "public insert" on stations
  for insert with check (true);

create policy "public update" on stations
  for update using (true);

create policy "public delete" on stations
  for delete using (true);

-- Ρητή παραχώρηση δικαιωμάτων στον ρόλο anon (απαραίτητο για το anon public key)
grant usage on schema public to anon;
grant select, insert, update, delete on table stations to anon;
