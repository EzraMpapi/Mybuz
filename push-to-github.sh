#!/usr/bin/env bash
# Push SMART MANAGER to GitHub, verifying src/ is included before committing.
# The previous push landed only 3 root files — src/ was missing, so the Vercel
# build failed on: Rollup failed to resolve import "/src/main.jsx"
set -euo pipefail

REPO="https://github.com/EzraMpapi/MyERPsmart.git"

[ -d src ] || { echo "ERROR: run this from the smart-manager/ folder (no src/ here)."; exit 1; }

git init -q 2>/dev/null || true
git remote remove origin 2>/dev/null || true
git remote add origin "$REPO"

git add -A

# Refuse to push a commit that would repeat the previous failure.
STAGED_SRC=$(git diff --cached --name-only | grep -c '^src/' || true)
echo "Files staged under src/: $STAGED_SRC"
if [ "$STAGED_SRC" -lt 70 ]; then
  echo
  echo "ABORTING — expected ~76 files under src/, found $STAGED_SRC."
  echo "Something is excluding them. Find out what with:"
  echo "    git check-ignore -v src/main.jsx"
  exit 1
fi

echo "Total staged: $(git diff --cached --name-only | wc -l) files"
git commit -q -m "SMART MANAGER v2.1 — full source, migrations and deploy config"
git branch -M main
git push -u origin main --force

echo
echo "Pushed. Verify at https://github.com/EzraMpapi/MyERPsmart"
echo "You should see: src/  supabase/  index.html  package.json  vite.config.js"
