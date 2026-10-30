#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/resume_paths.sh "${1:-}"
MD="$BASE.md"
DOCX="$BASE.docx"
if [[ ! -f "$MD" ]]; then
  echo "Missing $MD. Run scripts/render.sh first." >&2
  exit 1
fi
if ! command -v pandoc >/dev/null 2>&1; then
  echo "pandoc is required for DOCX export. Install with: brew install pandoc" >&2
  exit 1
fi
pandoc "$MD" -o "$DOCX"
echo "Wrote $DOCX"
