#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
scripts/render.sh "${1:-}"
scripts/validate.sh "${1:-}"
scripts/export_docx.sh "${1:-}"
