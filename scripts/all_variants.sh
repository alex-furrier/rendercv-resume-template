#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
scripts/all.sh
shopt -s nullglob
for source in variants/*.yaml; do
  variant="${source##*/}"
  scripts/all.sh "${variant%.yaml}"
done
