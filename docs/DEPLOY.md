# Deploy Guide (Cloudflare Pages)

## 1) Prepare files
This repo should contain:
- `index.html`
- `_worker.js`
- `supabase/schema.sql`
- `supabase/storage-policy.sql`

## 2) Set up Supabase first
- Follow `docs/SUPABASE_SETUP.md`.
- Ensure admin user exists in Supabase Auth.

## 3) Create Cloudflare Pages project
- Go to Cloudflare Dashboard -> `Pages` -> `Create project`.
- Connect your Git repository (recommended), or upload manually.
- Build command: none
- Output directory: `/` (root with static files)

## 4) Enable Pages Functions worker
- Keep `_worker.js` at repository root.
- Cloudflare Pages will execute it for requests.

## 5) Add environment variables
In `Pages -> Settings -> Environment variables`, add:
- `SUPABASE_URL` = `https://<project>.supabase.co`
- `SUPABASE_KEY` = your Supabase anon/public key

Do not use service role key on frontend.

## 6) Deploy
- Trigger deployment from Cloudflare UI (or push to main branch).
- Open site URL and verify:
  - public inventory loads
  - no keys are hardcoded in HTML
  - worker injects `window.__ENV`

## 7) First-time admin setup
- Open site -> click `⚙` bottom-right.
- Login with Supabase admin user.
- Open settings tab, set shop values.
- Add first car with images.

## 8) Optional custom domain
- Add your domain in `Pages -> Custom domains`.
- Update canonical URL/meta if domain differs from `asmcars.la`.
