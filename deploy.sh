#!/usr/bin/env bash
# One-shot deploy for https://jaeminiman.github.io   (Git Bash / WSL / macOS / Linux)
set -euo pipefail
cd "$(dirname "$0")"

REPO="Jaeminiman.github.io"

for t in git gh; do
  command -v "$t" >/dev/null || { echo "Missing '$t'. Install it and re-run."; exit 1; }
done

gh auth status >/dev/null 2>&1 || gh auth login

[ -d .git ] || git init -q
git add -A
git -c user.name="Jaemin Shin" -c user.email="wpals113@snu.ac.kr" commit -qm "Personal homepage" >/dev/null
git branch -M main

gh repo create "$REPO" --public --source=. --remote=origin --push
gh api -X POST "repos/{owner}/$REPO/pages" -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1 || true

echo
echo "Done. Live at https://jaeminiman.github.io in about a minute."
