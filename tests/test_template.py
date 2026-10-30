import subprocess
import tempfile
import unittest
from pathlib import Path
import sys
import yaml
from pypdf import PdfWriter

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))
from validate_pdf import validate


class TemplateTests(unittest.TestCase):
    def test_variant_paths_and_traversal(self):
        for variant, ok in (("", True), ("backend", True), ("../resume", False), ("missing", False), ("Backend", False)):
            p = subprocess.run(["bash", "-c", 'source scripts/resume_paths.sh "$1"; echo "$BASE"', "bash", variant], cwd=ROOT, capture_output=True, text=True)
            self.assertEqual(p.returncode == 0, ok)
            if ok:
                self.assertEqual(p.stdout.strip(), "outputs/resume" if not variant else "outputs/backend/resume-backend")

    def test_validation_rejects_missing_text_and_overflow(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "blank.pdf"
            writer = PdfWriter()
            writer.add_blank_page(width=612, height=792)
            writer.write(path)
            with self.assertRaisesRegex(ValueError, "missing source values"):
                validate(ROOT / "resume.yaml", path)
            writer.add_blank_page(width=612, height=792)
            writer.write(path)
            with self.assertRaisesRegex(ValueError, "got 2"):
                validate(ROOT / "resume.yaml", path)

    def test_all_sources_are_safe_local_examples(self):
        sources = [ROOT / "resume.yaml", *sorted((ROOT / "variants").glob("*.yaml"))]
        self.assertGreaterEqual(len(sources), 2)
        for source in sources:
            cv = yaml.safe_load(source.read_text())["cv"]
            self.assertEqual(cv["email"], "morgan@example.com")
            self.assertEqual(cv["website"], "https://example.com")
            self.assertNotIn("photo", cv)


if __name__ == "__main__":
    unittest.main()
