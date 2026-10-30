#!/usr/bin/env bash
# Run AFTER `gh auth login` completes. Creates the repo, pushes, enables Pages.
set -euo pipefail
cd "$(dirname "$0")"

USERNAME=$(gh api user --jq .login)
echo "Authenticated as: $USERNAME"

# Create repo + push
gh repo create "$USERNAME/digital-garden" --public --source=. --remote=origin --push 2>&1 || {
  echo "Repo may already exist; pushing instead..."
  git remote add origin "https://github.com/$USERNAME/digital-garden.git" 2>/dev/null || true
  git push -u origin main
}

# Enable GitHub Pages (workflow-based)
echo "Enabling GitHub Pages..."
gh api -X POST "repos/$USERNAME/digital-garden/pages" -f build_type=workflow 2>&1 || \
  gh api -X PUT "repos/$USERNAME/digital-garden/pages" -f build_type=workflow 2>&1 || true

# Fix baseUrl in config
sed -i.bak "s|baseUrl: example.com|baseUrl: $USERNAME.github.io/digital-garden|" quartz.config.yaml
rm -f quartz.config.yaml.bak
git add quartz.config.yaml
git commit -m "Set baseUrl to $USERNAME.github.io/digital-garden" 2>&1 || true
git push

echo ""
echo "✅ Done! Site will be live at: https://$USERNAME.github.io/digital-garden"
echo "   (First deploy takes ~2 min. Check Actions tab for progress.)"