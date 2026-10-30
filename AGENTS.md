# Resume template

RenderCV 2.8 reads `resume.yaml`; `variants/*.yaml` are independent examples.

- Edit YAML sources and run `make all-variants` after content or design changes.
- Inspect every generated PDF page. Page count and extracted text cannot establish visual quality.
- Replace fictional examples with user-confirmed facts; never invent metrics or ownership.
- Treat DOCX as a separate compatibility export. Inspect it in the target editor before submitting.
- Keep outputs, credentials and personal evidence out of version control. Publication requires user authorization.

Run `make test` for offline validation and path-handling regression tests after dependencies are available.
