#!/usr/bin/env bash
# Shared source/output naming for the default and every variant.
VARIANT="${1:-}"
if [[ -n "$VARIANT" ]]; then
  [[ "$VARIANT" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]] || { echo "Invalid variant: $VARIANT" >&2; exit 1; }
  SOURCE="variants/$VARIANT.yaml"
  [[ -f "$SOURCE" ]] || { echo "Missing variant: $SOURCE" >&2; exit 1; }
  OUT="outputs/$VARIANT"
  BASE="$OUT/resume-$VARIANT"
else
  SOURCE="resume.yaml"
  OUT="outputs"
  BASE="$OUT/resume"
fi
