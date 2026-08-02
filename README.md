# SMART MANAGER

Thirty-three modules for Tanzanian businesses — sales, stock, cash, staff and tax,
plus industry packs for pharmacies, clinics, schools, hotels, restaurants, fleets,
VICOBA groups and microfinance.

TZS throughout, VAT at 18%, M-Pesa and Airtel references on payments, TRA-ready
returns. Kiswahili and English side by side.

**Stack:** React 18 · Vite 5 · Tailwind CSS 3 · Recharts · Supabase (REST) · SheetJS

---

## Quick start

```bash
npm install
cp .env.example .env      # optional — falls back to the demo project
npm run dev               # http://localhost:5173
npm run build             # → dist/
```

---

## Deploying

**Netlify** — push to GitHub, then *Add new site → Import an existing project*.
`netlify.toml` supplies the build command, publish directory, Node version and
the SPA redirect. Add `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY` under
*Site settings → Environment variables*.

**Vercel** — the same flow; `vercel.json` carries the equivalent config.

The SPA rewrite matters. Without it every route except `/` returns 404 on
refresh. Both config files already include it.

---

## Environment variables

| Variable | Required | Notes |
|---|---|---|
| `VITE_SUPABASE_URL` | No | Falls back to the bundled demo project |
| `VITE_SUPABASE_ANON_KEY` | No | Same |

The anon key is safe to expose — row-level security is what protects the data.
Never put the **service role** key in a `VITE_` variable; anything with that
prefix is bundled into the client and visible to every visitor.

With neither variable set the app runs on local seed data, which is also what
the *Preview demo* button on the sign-in screen forces.

---

## Structure

```
src/
├── main.jsx        entry
├── App.jsx         GlobalStyles → ErrorBoundary → AppLock → Shell
├── index.css       Tailwind + base styles
│
├── lib/            layer 0 — no internal dependencies
│   ├── supabase.jsx        config, GoTrue auth, sb() query builder
│   ├── useCompanyTable.jsx the hook every module loads rows through
│   ├── mappers.jsx         snake_case DB rows → camelCase UI rows
│   ├── format.jsx          money, TODAY, docId, TAX_RATE, lineTotal
│   ├── buses.jsx           toast / confirm / receipt / audit / whatsapp buses
│   ├── notify.jsx          notify() and toast styling
│   ├── crypto.jsx          WebAuthn base64 helpers, PIN hashing
│   ├── export.jsx          CSV / Excel / Word / PDF export and print
│   └── alerts.jsx          shared business-alert engine
│
├── data/           layer 1 — seed data and domain constants (20 files)
├── components/     layer 2 — shared UI (ui, feedback, ActivityStream,
│                            SendReceiptPanel, BrandMark, tools)
├── modules/        layer 3 — one file per business area (33 modules)
└── app/            layer 4 — Shell (SmartManager) and ErrorBoundary
```

### The dependency rule

Imports flow strictly downward: `app → modules → components → data → lib`.

The graph is verified acyclic with zero back-edges. Keep it that way. If a file
in `lib/` or `data/` needs something from a module, the thing it needs belongs
in a lower layer — move it down rather than importing upward. A cycle here does
not fail the build; it fails at runtime with *"Cannot access 'X' before
initialization"*, which is a far worse way to find out.

### Mutable module state

`TAX_RATE` and `DEMO_OVERRIDE` are the only mutable exports, and both ship with
setters. Use `setActiveTaxRate()` and `setDemoOverride()` — assigning to an
imported binding is an ES-module error, not a lint warning.

---

## Database

The client talks to Supabase over plain PostgREST — no SDK. Company scoping is
enforced entirely by RLS via `current_company_id()`, which reads the
authenticated session. The client never sends its own `company_id` filter, so
the database stays the single authority on which rows a session can see.

Run the schema against your project before pointing the app at it; the anon key
gets you a connection, not tables.

---

© Kilimanjaro Trading Co. · Dar es Salaam
