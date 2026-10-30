.PHONY: render validate docx all all-variants test clean
# Example: make all VARIANT=backend
render:
	./scripts/render.sh "$(VARIANT)"
validate:
	./scripts/validate.sh "$(VARIANT)"
docx:
	./scripts/export_docx.sh "$(VARIANT)"
all:
	./scripts/all.sh "$(VARIANT)"
all-variants:
	./scripts/all_variants.sh
test:
	uv run --python 3.14 --with 'pypdf==6.1.1' --with 'PyYAML==6.0.3' python -m unittest discover -s tests -v
clean:
	python3 -c 'import shutil; shutil.rmtree("outputs", ignore_errors=True)'
