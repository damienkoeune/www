#!/usr/bin/env bash
#
# Recopie le dossier publiable du vault Obsidian dans content/, puis pousse.
# Le vault (~/Claude) reste la source de vérité privée ; seul ~/Claude/www part en ligne.
#
# Usage : ./sync-from-vault.sh [--no-push]
#   --no-push : recopie seulement, sans commit ni push (utilisé par serve.sh).
#
set -euo pipefail

PUSH=true
if [[ "${1:-}" == "--no-push" ]]; then
  PUSH=false
fi

VAULT_DIR="$HOME/Claude/www"
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ ! -d "$VAULT_DIR" ]]; then
  echo "Dossier source introuvable : $VAULT_DIR" >&2
  exit 1
fi

cd "$PROJECT_DIR"

rsync -a --delete \
  --exclude '.DS_Store' \
  --exclude '.obsidian/' \
  --exclude '.trash/' \
  "$VAULT_DIR/" content/

if [[ "$PUSH" == false ]]; then
  echo "Contenu synchronisé (sans publication)."
  exit 0
fi

git add -A content
if git diff --cached --quiet; then
  echo "Aucune modification à publier."
  exit 0
fi

git status --short content
git commit -q -m "Publication : $(date '+%Y-%m-%d %H:%M')"
git push -q
echo "Publié. Le build GitHub Actions démarre : https://github.com/damienkoeune/www/actions"
