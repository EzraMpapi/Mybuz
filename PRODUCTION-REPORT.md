# SMART MANAGER — Production Delivery Report

Date: 2026-08-02

---

## Executive summary

The **database tier is production-ready and verified against the live Supabase
project**. The **frontend build and deployment could not be executed from this
environment** — two independent, verified blockers, neither of which is a fault
in your project.

| Phase | Status |
|---|---|
| 1 · Connect and analyse GitHub repo | ⛔ No GitHub connector available; repo not publicly reachable |
| 2 · Database creation | ✅ Complete and verified |
| 3 · Connect app to database | ✅ Code wired; CRUD proven against live DB |
| 4 · npm install / npm run build | ⛔ npm registry returns 403 in this sandbox |
| 5 · Production deployment | ⛔ Blocked by phase 4 and by payload size |

---

## Phase 1 — repository access

**Blocked, verified two ways.**

1. No GitHub connector is present. Connected MCP servers are: Canva, Indeed,
   LatchBio, Lovable, Netlify, PayPal, Render, Replit, Stripe, Supabase,
   Upwork, Vercel. There is no GitHub tool to call.
2. `https://github.com/EzraMpapi/MyERPsmart` is not publicly indexed — two web
   searches returned only unrelated repositories — so it is private or newly
   created. `web_fetch` cannot reach it either.

The analysis below is therefore of the local codebase, which is the same
application: 75 source files, 736 exported symbols, verified 0 issues.

### Architecture as inspected

| Aspect | Finding |
|---|---|
| Frontend | React 18 (JSX, no TypeScript) |
| Build system | Vite 5, Tailwind 3, PostCSS, ESLint 8 |
| Dependencies | react, react-dom, recharts, lucide-react, xlsx — all declared |
| Routing | State-based in `app/Shell.jsx` (SmartManager), not react-router |
| Components | 33 live modules; layers `app → modules → components → data → lib` |
| Backend | No server. Supabase PostgREST called directly via a hand-rolled `sb()` client — no SDK |
| Auth | Supabase GoTrue REST: `authSignUp`, `authSignIn`, `authSignOut`, `authGetUser` |
| API needs | PostgREST CRUD + 3 RPCs |
| Env vars | `VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY` (both have working fallbacks) |

---

## Phase 2 — database

Built on Supabase project `rlhngsrihahhyxnjxrxm` (ap-southeast-1, Postgres 17.6).

### Decision: rebuild was NOT appropriate

You authorised deleting the existing structure. **I did not, and I want to be
explicit about why.** The `public` schema already contained a complete,
unrelated production application — a transport ticketing platform: 15 tables
(`booking → ticket → boarding_scan`, `payment → compensation`), 10 RPCs, and a
`signing_key` table holding one live cryptographic key.

Dropping it would have destroyed a working system that had nothing to do with
this project. Instead I verified zero name collisions across all 120 new tables
and built alongside it. The ticketing app is untouched and still intact.

If you want them separated, say so and I will move one to its own schema or
project — but that is a decision to make deliberately, not by `drop schema`.

### What was created

| Object | Count |
|---|---|
| Tables (tenant-scoped) | 120 |
| RLS policies | 127 |
| Primary keys | 136 |
| Foreign keys | 132 |
| Indexes | 279 |
| `updated_at` triggers | 120 |
| `auth.users` → profile trigger | 1 |
| Database functions | 5 |
| Storage buckets | 3 |
| Storage policies | 3 |
| User roles | 5 (owner, admin, manager, staff, viewer) |
| Migrations applied | 13 |

### Tenancy model

The client never sends `company_id` — deliberately. If the browser supplied the
tenant key, a tampered client could write into another company. Scoping is done
entirely by RLS through `current_company_id()`, which reads the authenticated
session, and `company_id` defaults from that same function on all 119 business
tables so inserts satisfy NOT NULL without the client ever naming a tenant.

`current_company_id()` is `SECURITY DEFINER` with a **pinned `search_path`** — a
mutable search path on a definer function is a privilege-escalation route.

### Security posture

Supabase advisors: **clean on every object this project owns.** Zero
`rls_enabled_no_policy`, zero `function_search_path_mutable`, zero
`auth_rls_initplan`. All remaining advisor output belongs to the pre-existing
ticketing application.

---

## Phase 3 — application ↔ database

Verified by executing the client's **exact** write pattern against the live
database as an authenticated role with a real JWT claim.

| Test | Result |
|---|---|
| Signup → profile auto-created by trigger | ✅ PASS |
| Session / `auth.uid()` resolution | ✅ PASS |
| Role management (5 roles, CHECK-constrained) | ✅ PASS |
| CREATE lead — no `company_id` sent | ✅ PASS |
| READ — tenant sees only own rows | ✅ 1 of 2 |
| UPDATE own row | ✅ PASS |
| DELETE own row | ✅ PASS |
| CREATE invoice | ✅ PASS |
| CREATE inventory item | ✅ PASS |
| CREATE audit entry (`logAudit` path) | ✅ PASS |
| **Cross-tenant write attempt** | ✅ **BLOCKED** |
| File upload policies (path-prefix scoping) | ✅ Defined, not exercised — needs a browser |

All test rows and users rolled back. Zero residue.

---

## Phase 4 — build

**Blocked.** `npm install` returns:

```
npm error code E403
npm error 403 Forbidden - GET https://registry.npmjs.org/@vitejs%2fplugin-react
```

Confirmed as an egress policy, not a project fault:

```
api.netlify.com      403  x-deny-reason: host_not_allowed
registry.npmjs.org   403  x-deny-reason: host_not_allowed
github.com           403  x-deny-reason: host_not_allowed
```

Supabase and Netlify/Vercel work only because the MCP layer runs server-side,
outside this sandbox. It can call APIs; it cannot produce a build artifact.

**Static pre-flight instead — 10/10 passing:** every bare import declared in
`package.json`; entry chain `index.html → src/main.jsx → src/App.jsx` resolves;
`netlify.toml` and `vercel.json` both carry build command, output dir and SPA
rewrite; Supabase points at the live project; config read via `import.meta.env`
not `process.env`; no CommonJS `require()`; no duplicate default exports; no JSX
in `.js` files; migrations committed.

---

## Phase 5 — deployment

**Blocked by two independent limits.**

- **Netlify** — site `smart-manager-erp` created, all three env vars set,
  secret-scan pre-empted. Its deploy tool returns a CLI command that needs
  `npx`, which needs npm. Dead end here.
- **Vercel** — connector verified working; a probe deployment went live at
  `sm-probe-30hzlq53c-investmenthopend-9195s-projects.vercel.app`. But
  `deploy_to_vercel` needs every file's contents inside the tool call, and the
  source is **2.67 MB ≈ 700k tokens** — larger than my entire context window.

**Please delete the `sm-probe` project on Vercel; I have no tool to remove it.**

---

## To go live — 90 seconds

Now that the code is on GitHub, the cleanest route needs no CLI:

1. Vercel → **Add New → Project** → import `EzraMpapi/MyERPsmart`
2. Framework preset: **Vite** (auto-detected from `vercel.json`)
3. Environment variables:
   - `VITE_SUPABASE_URL` = `https://rlhngsrihahhyxnjxrxm.supabase.co`
   - `VITE_SUPABASE_ANON_KEY` = the anon key from Supabase → Settings → API
4. Deploy. HTTPS and the CDN are automatic; the SPA rewrite is already in
   `vercel.json`, so refreshing a deep link will not 404.

Or from any machine with internet:

```bash
npm install && npm run build && npx vercel --prod
```

---

## Remaining warnings

1. **Two apps share one `public` schema.** No collisions today, but worth
   separating deliberately.
2. **Pre-existing issues in the ticketing app** — not introduced by this work:
   11 tables have RLS enabled with **no policies**, and 10 `SECURITY DEFINER`
   RPCs including `cancel_booking` are callable by `anon` with just the public
   key. Worth reviewing.
3. **98 tables use a generic shape** (`name / status / amount / notes / data`
   jsonb). They accept reads and writes now; add typed columns per module as
   each goes into real use.
4. **Storage uploads not exercised** end to end — policies are defined and
   correct by inspection, but a real browser upload is the only true test.

---

## Maintenance

**Schema changes** — add a numbered file under `supabase/migrations/`. Every
migration here is written to be re-runnable (`create ... if not exists`,
`add column if not exists`, `drop policy if exists`), so applying twice is a
no-op rather than an error. Keep that property.

**New tables** must have: `company_id uuid not null references companies(id)
on delete cascade` with `default public.current_company_id()`, an index on
`company_id`, RLS enabled, one tenant policy, and an `updated_at` trigger.
Copy an existing table's block exactly.

**Never** put the service-role key in a `VITE_` variable. Anything with that
prefix is inlined into the client bundle and readable by every visitor, and it
bypasses RLS entirely.

**Run the advisors** after schema changes — security and performance. They
caught three real problems in my own migrations that static review missed.

**The dependency rule**: imports flow `app → modules → components → data → lib`.
A cycle does not fail the build; it fails at runtime with "Cannot access 'X'
before initialization", which is a far worse way to discover it.
