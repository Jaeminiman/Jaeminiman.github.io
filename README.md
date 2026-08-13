# jaeminiman.github.io

Personal academic homepage of **Jaemin Shin** (신제민) — Ph.D. student, Construction Innovation
Laboratory, Seoul National University.

Live site: <https://jaeminiman.github.io>

## Contents

| File | Purpose |
|---|---|
| `index.html` | The entire site — HTML, CSS, JS and the profile photo are all inlined. No build step, no dependencies. |
| `.nojekyll` | Tells GitHub Pages to serve the files as-is (skips Jekyll processing). |

## Editing

Open `index.html` in any editor and edit the text directly. Common spots:

- **Publications** — the `<ol class="pubs">` blocks. Copy an existing `<li>`, change the text.
  Wrap your own name in `<span class="me">Shin, J.</span>` so it stays bold.
- **Status badges** — `<span class="tag review">Under Review</span>`. When a paper is accepted,
  swap it for `<span class="tag">Published</span>` and add the year/volume.
- **Photo** — replace the long `data:image/jpeg;base64,...` value in the `.avatar` image.
- **Colours** — the `:root` block at the top of the `<style>` section. `--accent` controls every
  blue element on the page.

Commit and push; GitHub Pages redeploys within about a minute.
