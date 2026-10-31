# Contributing

How to suggest edits to this garden — for collaborators and future-you.

## Ways to contribute

1. **Open an issue** — simplest. Describe the problem/suggestion at
   https://github.com/hkaloiva/digital-garden/issues. Good for typos, broken links, ideas.
2. **Fork + Pull Request** — for concrete edits:
   - Fork the repo.
   - Create a branch: `git checkout -b fix/short-description`.
   - Make changes (see style guide below).
   - Preview locally: `npx quartz build --serve`.
   - Open a PR against `main` with a short description of what and why.
3. **Direct push** (owner only) — commit to `main`; GitHub Actions deploys.

## Note style guide

### Frontmatter

Every note starts with YAML frontmatter:

```yaml
---
title: My note title
publish: true
tags:
  - topic
  - subtopic
---
```

- `title` — human-readable; used as the page title and in links.
- `publish` — `true` ships it; `false`/omitted keeps it private. **Only `publish: true` notes go live** (explicit-publish model).
- `tags` — lowercase, kebab-case-friendly; used by tag list and search.
- Optional: `description`, `aliases`, `date` (created/modified).

### Wikilinks

- Use `[[Note Title]]` or `[[note-slug]]` for internal links.
- Prefer linking to MOCs (`content/maps/`) as entry points.
- Aliases: `[[note-slug|display text]]`.

### Publish flag

- Default to **not publishing**. New notes ship only when explicitly marked `publish: true`.
- Drafts can live in `content/private/` (ignored by build) or stay `publish: false`.
- Never put secrets, personal data, or client info in published notes.

### Formatting

- One idea per note; keep it evergreen (update in place rather than date-stamping).
- Use headings (`##`, `###`) for sections; callouts (`> [!note]`) where helpful.
- Code blocks with language tags.
- Images in `content/` or referenced by URL.

## Review checklist (PRs)

- [ ] Frontmatter valid (title + publish).
- [ ] Links resolve (preview locally).
- [ ] No secrets/personal data.
- [ ] `npm run` build succeeds (`npx quartz build`).
- [ ] Commit message is descriptive.

## Code of conduct

See `CODE_OF_CONDUCT.md`.
