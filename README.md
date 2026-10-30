# Kaloyan's Digital Garden

A personal digital garden built with [Quartz 5](https://quartz.jzhao.xyz/) — Obsidian-compatible Markdown notes published as a free static site.

**Live site (after deploy):** https://YOUR-USERNAME.github.io/digital-garden (or your custom domain)

## What's inside

- `content/` — your notes (Markdown, Obsidian-flavored, with `[[wikilinks]]`)
  - `content/index.md` — homepage
  - `content/maps/` — maps of content (MOCs): topic indexes
  - `content/notes/` — evergreen notes
- `quartz.config.yaml` — site config (title, theme, plugins)
- `.github/workflows/deploy.yml` — auto-deploy to GitHub Pages on push to `main`

## Publishing model

`explicit-publish` is enabled: only notes with `publish: true` in frontmatter go live. Everything else stays private.

```yaml
---
title: My note
publish: true
tags: [topic]
---
```

## Local preview

```bash
npm install
npx quartz build --serve
# open http://localhost:8080
```

## Manual steps to go live (one-time)

### 1. Create a GitHub repo
- Go to github.com → New repository → name it `digital-garden` → Create (empty, no README).
- Copy the repo URL.

### 2. Push this project
```bash
cd ~/projects/digital-garden
git remote add origin https://github.com/YOUR-USERNAME/digital-garden.git
git push -u origin main
```

### 3. Enable GitHub Pages
- Repo → Settings → Pages → Source: **GitHub Actions**.
- The deploy workflow runs automatically on push. First deploy takes ~2 min.
- Site URL: `https://YOUR-USERNAME.github.io/digital-garden`

### 4. Update baseUrl
Edit `quartz.config.yaml` → set `baseUrl` to `YOUR-USERNAME.github.io/digital-garden` (or your custom domain). Commit + push.

### 5. (Optional) Custom domain
- Buy a domain (~$10/yr) → add a `CNAME` file in `content/` with your domain → update `baseUrl` → configure DNS (A records to GitHub Pages IPs). See Quartz hosting docs.

## Using Obsidian (optional, recommended)

This project is Obsidian-compatible. To edit notes in Obsidian:

1. Install Obsidian (free) from obsidian.md.
2. Open `~/projects/digital-garden/content/` as a vault (or symlink your existing vault into `content/`).
3. Write notes with `[[wikilinks]]`. Mark `publish: true` to ship.
4. Run `npx quartz build --serve` to preview, or push to deploy.

**Tip:** keep private notes in a separate vault or a `private/` folder (already in ignorePatterns).

## Adding a note

1. Create `content/notes/my-note.md` with frontmatter (`publish: true`).
2. Link it from a MOC in `content/maps/`.
3. Preview locally, then `git push`.

## Structure

```
content/
├── index.md
├── maps/          # maps of content (topic indexes)
└── notes/         # evergreen notes
```

## Credits

Built on [Quartz 5](https://github.com/jackyzha0/quartz) by Jacky Zhao. Theme, plugins, and hosting are all free/open-source.