#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/resume_paths.sh "${1:-}"
[[ -f "$BASE.pdf" ]] || { echo "Missing PDF. Run scripts/render.sh first." >&2; exit 1; }
uv run --python 3.14 --with 'pypdf==6.1.1' --with 'PyYAML==6.0.3' \
  python scripts/validate_pdf.py "$SOURCE" "$BASE.pdf" "${MAX_PAGES:-1}"
