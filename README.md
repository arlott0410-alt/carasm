# ASM Cars - Used Car Web System

Single-file website for **ASM ອາມສັ່ງມາ** (Vientiane, Laos), built for zero monthly cost using:
- Static `index.html`
- Cloudflare Pages + `_worker.js` env injection
- Supabase (Postgres + Storage + Auth)

## Project Structure

```text
/
├── index.html
├── _worker.js
├── supabase/
│   ├── schema.sql
│   └── storage-policy.sql
├── docs/
│   ├── DEPLOY.md
│   └── SUPABASE_SETUP.md
└── README.md
```

## Features
- Dark luxury bilingual UI (Lao/English)
- SEO complete head (meta, OG, JSON-LD AutoDealer)
- Public car inventory with filters and responsive cards
- WhatsApp lead flow
- Admin login (Supabase Auth email/password)
- Admin panel with 3 tabs:
  - Add/Edit cars + upload up to 10 photos
  - Manage list (edit/sold/restore/delete)
  - Shop settings key-value update (applies instantly)
- Demo mode when Supabase env is missing

## Quick Start
1. Set up Supabase using `docs/SUPABASE_SETUP.md`.
2. Deploy to Cloudflare Pages using `docs/DEPLOY.md`.
3. Add environment variables:
   - `SUPABASE_URL`
   - `SUPABASE_KEY` (anon key only)
4. Open site, login from `⚙` button, configure settings, add cars.

## Security Notes
- Frontend keys are injected at request-time by worker, not hardcoded in HTML.
- Data mutation requires authenticated user via Supabase RLS.
- Storage write/delete requires authenticated user.
- Worker sends response security headers:
  - `X-Content-Type-Options: nosniff`
  - `X-Frame-Options: DENY`
  - `Referrer-Policy: strict-origin-when-cross-origin`
