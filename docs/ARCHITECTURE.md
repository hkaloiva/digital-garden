# Architecture

Brief overview of how this garden is built and deployed.

## Pipeline

```
content/  --(Quartz build)-->  public/  --(GitHub Actions)-->  GitHub Pages
   .md notes                    static HTML/CSS/JS               live site
```

1. **Source**: Markdown notes in `content/` (with frontmatter).
2. **Build**: `npx quartz build` runs the plugin pipeline, emitting a static site into `public/`.
3. **Deploy**: `.github/workflows/deploy.yml` builds on push to `main` and publishes `public/` to GitHub Pages via `actions/deploy-pages`.
4. **Serve**: GitHub Pages serves the static files at `https://hkaloiva.github.io/digital-garden` (or your custom domain).

## Plugin pipeline

Configured in `quartz.config.yaml` (plugins list with `order`). Stages include:

- **Transformers**: parse Markdown/Obsidian-flavored syntax (wikilinks, callouts, tags, frontmatter), GFM, syntax highlighting, created/modified dates.
- **Filters**: `explicit-publish` filter drops notes without `publish: true`; ignore patterns (`private`, `templates`, `.obsidian`).
- **Emitters**: generate HTML pages, RSS (`/rss.xml`), sitemap, OG images, 404.
- **Components**: layout (header, footer, sidebar, graph, backlinks, search, TOC, breadcrumbs, recent-notes, tag list).

Plugin order matters; lower `order` runs first.

## Explicit-publish model

`explicit-publish` is on: a note is published **only** if `publish: true` is in its frontmatter. Everything else stays out of `public/`. This keeps drafts and private notes out of the deployed site even if committed.

## Theme system

- Theme defined in `quartz.config.yaml` → `theme`: typography (Fraunces / Source Sans Pro / IBM Plex Mono via Google Fonts) and color palettes for light/dark modes.
- Custom CSS in `quartz/styles/` (warm-editorial theme overrides).
- Dark mode toggled client-side; colors are CSS variables.

## Key files

| File | Role |
|------|------|
| `quartz.config.yaml` | Site config, plugins, theme, baseUrl |
| `quartz.layout.ts` | Page layout composition |
| `content/` | Source notes |
| `public/` | Build output (gitignored) |
| `.github/workflows/deploy.yml` | CI/CD to GitHub Pages |
| `static/` | Files copied verbatim into `public/` (e.g. `CNAME`) |

## Local development

```bash
npm install
npx quartz plugin install
npx quartz build --serve   # http://localhost:8080, hot reload
```
