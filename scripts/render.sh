#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/resume_paths.sh "${1:-}"
# RenderCV resolves output paths relative to the input YAML directory.
OUT="$PWD/$OUT"
BASE="$PWD/$BASE"
mkdir -p "$OUT"
UV_PROJECT_ENVIRONMENT=.venv \
  uv run --python 3.14 \
    --with 'rendercv[full]==2.8' \
    rendercv render "$SOURCE" \
      --output-folder "$OUT" \
      --pdf-path "$BASE.pdf" \
      --png-path "$BASE.png" \
      --markdown-path "$BASE.md" \
      --html-path "$BASE.html" \
      --typst-path "$BASE.typ"
