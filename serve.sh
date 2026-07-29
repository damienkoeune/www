#!/usr/bin/env bash
#
# Prévisualisation locale sur http://localhost:8080 (sert aussi d'intranet :
# accessible depuis le réseau local via l'IP du Mac).
#
# Quartz 5 ne fonctionne pas avec Node 26 (deadlock d'esbuild) : on force Node 22,
# la même version que celle utilisée par GitHub Actions.
#
set -euo pipefail

export PATH="/opt/homebrew/opt/node@22/bin:$PATH"
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

./sync-from-vault.sh --no-push || true
exec npx quartz build --serve
