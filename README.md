# Kaloyan's Digital Garden

A public digital garden of evergreen notes on service delivery, AI & automation, career, and principles — thinking out loud. Built on [Quartz 5](https://quartz.jzhao.xyz/).

**Live site:** https://hkaloiva.github.io/digital-garden

## Publishing model

`explicit-publish` is on: only notes with `publish: true` in frontmatter go live; everything else stays private.

```yaml
---
title: My note
publish: true
tags: [topic]
---
```

## Features enabled

- Full-text search, graph view, backlinks, recent-notes, tag list
- OG images, RSS feed (`/rss.xml`), sitemap
- Dark mode + custom warm-editorial theme (Fraunces / Source Sans Pro / IBM Plex Mono)
- 404 page, breadcrumbs, table of contents, reader mode
- Explicit publish (drafts stay private), unlisted pages, alias redirects

## Structure

```
content/
├── index.md              # home / entry point
├── 404.md                # not-found page
├── reading-list.md       # books & resources
├── changelog.md          # garden update log
├── maps/                 # maps of content (MOCs)
│   ├── ai.md
│   ├── career.md
│   ├── home-ops.md
│   ├── principles.md
│   └── service-delivery.md
└── notes/                # 30 evergreen notes
```

38 published pages in total: 30 notes, 5 MOCs, plus index, 404, reading list, and changelog.

## Local preview

```bash
npm install
npx quartz build --serve
# open http://localhost:8080
```

## Deploy

Pushes to `main` deploy via GitHub Actions to GitHub Pages (`.github/workflows/deploy.yml`). `baseUrl` is set in `quartz.config.yaml`.

## Using Obsidian (optional)

Open `content/` as an Obsidian vault. Write notes with `[[wikilinks]]`, mark `publish: true` to ship. Private notes live in `private/` or stay unpublishable.

## Adding a note

1. Create `content/notes/my-note.md` with frontmatter (`publish: true`).
2. Link it from a MOC in `content/maps/`.
3. Preview locally, then `git push`.

## Credits

Built on [Quartz 5](https://quartz.jzhao.xyz/) by Jacky Zhao. Theme, plugins, and hosting are free/open-source.