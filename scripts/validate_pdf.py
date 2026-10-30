"""Validate page budget and source-derived identity/section content in a PDF."""
import sys
from pathlib import Path
import yaml
from pypdf import PdfReader


def validate(source, pdf, max_pages=1):
    cv = yaml.safe_load(Path(source).read_text(encoding="utf-8"))["cv"]
    reader = PdfReader(pdf)
    if not 1 <= len(reader.pages) <= max_pages:
        raise ValueError(f"Expected 1 to {max_pages} pages; got {len(reader.pages)}")
    text = " ".join(" ".join(p.extract_text() or "" for p in reader.pages).split())
    expected = [cv["name"]]
    for entries in cv.get("sections", {}).values():
        for entry in entries:
            if isinstance(entry, dict):
                expected.extend(str(entry[k]) for k in ("company", "institution") if entry.get(k))
    missing = [x for x in expected if " ".join(x.split()) not in text]
    if missing:
        raise ValueError(f"PDF text is missing source values: {missing}")
    print(f"PDF validation passed: {len(reader.pages)} page(s), source-derived text present")


if __name__ == "__main__":
    validate(sys.argv[1], sys.argv[2], int(sys.argv[3]))
