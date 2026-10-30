# RenderCV resume template

Edit your resume in YAML and build a PDF. This template includes Word export and a second example for a backend role. All names, schools, jobs, projects, and results are fictional. Contact links use example.com.

## Quickstart

Install [uv](https://docs.astral.sh/uv/getting-started/installation/) and Bash. uv downloads Python if necessary. Run from the project root:

```bash
./scripts/render.sh
./scripts/validate.sh
```

The check prints `PDF validation passed: 1 page(s), source-derived text present` for the bundled example. Open `outputs/resume.pdf` and `outputs/resume_1.png` in your preferred viewer. The build also creates Markdown, HTML, and Typst files. The scripts use RenderCV 2.8 and Python 3.14. uv resolves the versions of the packages RenderCV depends on. The first run needs internet access. uv stores Python and packages in the folders and cache it manages. Generated documents stay in `outputs/`. Later runs use cached dependencies where available.

On macOS or Linux with Make, the equivalent is `make render validate`. On Windows, use Windows Subsystem for Linux (WSL). You need no account, API key, or global Python packages.

## Customize

1. Edit `resume.yaml`: name, contact details, summary, work, projects, skills, and education. Delete sections you don't need. Use only results and numbers you can support.
2. Change `design` for fonts, margins, page size, and theme. The example uses the built-in `engineeringclassic` theme with no custom templates.
3. Build the PDF and check each page for clipped text, line breaks, and clear headings. The check enforces a page limit and looks for names, employers, and schools from the YAML. It doesn't check every bullet or prove that the layout is correct.
4. If you want two pages, run `MAX_PAGES=2 ./scripts/validate.sh`. Check both pages visually.

The example sets `settings.current_date` to a fixed date. Update it if you use time spans or last-updated notes. Use [RenderCV's documentation](https://docs.rendercv.com/) for its YAML schema and theme options. Remove the editor schema comment if you prefer to avoid schema downloads.

## Variants

`variants/backend.yaml` shows a different headline and summary for the same fictional candidate. Each variant is a full source file. Keep shared facts in sync by hand.

```bash
./scripts/all_variants.sh  # Requires pandoc; builds every example
./scripts/render.sh backend
./scripts/validate.sh backend
# With Make:
make all VARIANT=backend
```

Use only lowercase letters, digits, and hyphens in variant names. Copy an example to `variants/<name>.yaml`. Outputs go to `outputs/<name>/resume-<name>.*`.

## Word export

Install [Pandoc](https://pandoc.org/installing.html), then:

```bash
./scripts/export_docx.sh
# Or render, validate and export together:
./scripts/all.sh
```

Word export converts the Markdown to a Word file (.docx). It doesn't preserve the PDF layout and may use more pages. Check the Word file in your target editor before you submit it. Use the PDF for the typeset layout. Test exports with your application portal: this template makes no promise about applicant tracking system (ATS) support.

## Checks and files

```bash
make test          # Unit tests; first run may fetch Python dependencies
make all-variants  # Integration build, page/text checks and Word export
make clean         # Deletes generated outputs only
```

- `resume.yaml`: fictional default resume and design settings.
- `variants/`: complete alternative sources.
- `scripts/`: rendering, source-derived PDF checks and Word export.
- `tests/`: path traversal rejection and PDF validation regression cases.
- `outputs/`: generated files. Git ignores this folder.

The scripts don't publish files. Keep your working resume private if it contains facts you don't want in Git history. Review exported files before you share them.

## Start your own repository

To start with a new history, download the source ZIP from GitHub. Extract it into a new folder and edit it. The ZIP has no Git directory or remotes. Review your files, then set up Git:

```bash
git init
# Review the files before your first commit.
git add .
git commit -m "Start resume project"
```

## Licensing

The source project had no LICENSE file. This template has no project license yet. Choose a license before you share the source publicly. RenderCV and Pandoc have their own licenses in their upstream packages. This template includes no third-party theme source or fonts. See `NOTICE.md`.
