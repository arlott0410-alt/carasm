# Supabase Setup

## 1) Create project
- Go to [Supabase](https://supabase.com/), create a new project.
- Save your project URL and `anon` key from `Project Settings -> API`.

## 2) Run SQL schema
- Open `SQL Editor`.
- Run all SQL from `supabase/schema.sql`.
- Confirm tables `cars` and `settings` are created.

### Existing database (upgrade)
If your project was created earlier and cars “disappear” after saving, your table may be missing the `currency` column. Run `supabase/migration_add_currency.sql` once in the SQL Editor, then reload the site.

## 3) Configure storage
- In `SQL Editor`, run `supabase/storage-policy.sql`.
- Confirm bucket `car-images` exists and is public.

## 4) Create admin user
- Go to `Authentication -> Users -> Add user`.
- Create one admin email/password for the shop owner.
- This user logs into the in-page Admin Panel.

## 5) Verify RLS quickly
- `cars`: public can `SELECT`, only authenticated can mutate.
- `settings`: public can `SELECT`, only authenticated can mutate.
- `storage.objects` in `car-images`: public read, authenticated write/delete.

## 6) Ready for Cloudflare
- Keep these values ready:
  - `SUPABASE_URL` = your project URL
  - `SUPABASE_KEY` = your anon/public key
