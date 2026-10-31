# Obsidian Setup

How to use [Obsidian](https://obsidian.md/) as the authoring environment for this garden.

## Open `content/` as a vault

1. Install Obsidian (desktop recommended).
2. **Open folder as vault** → select the `content/` directory inside this repo.
   - Do **not** open the repo root as the vault — Quartz expects notes under `content/`, and the build ignores `.obsidian/`.
3. Obsidian will create `.obsidian/` inside `content/` (gitignored by Quartz's `ignorePatterns`? Check `.gitignore` — `.obsidian` is ignored at repo root; add `content/.obsidian/` to `.gitignore` if you want it untracked).

> The repo already ships a root `.obsidian/` config for convenience. You can copy its `app.json`/`appearance.json` into `content/.obsidian/` to match.

## Recommended plugins

Install via **Settings → Community plugins → Browse** (enable community plugins first).

| Plugin | Purpose | Required? |
|--------|---------|-----------|
| **Templater** | Note templates with frontmatter (`publish`, `tags`) | Recommended |
| **Dataview** | Query notes by frontmatter/tags for MOCs and dashboards | Recommended |
| **Digital Garden** (oleeskild) | Optional push-to-publish helper; this garden publishes via git instead | Optional |

Also useful: **Linter** (frontmatter formatting), **Tag Wrangler** (rename tags), **Graph Analysis**.

## Hotkeys (suggested)

| Action | Suggested hotkey |
|--------|------------------|
| New note | `Ctrl/Cmd + N` |
| Quick switcher | `Ctrl/Cmd + O` |
| Command palette | `Ctrl/Cmd + P` |
| Insert wikilink | `[[` (auto) |
| Toggle preview/source | `Ctrl/Cmd + E` |
| Templater: insert template | `Alt + T` |

Set in **Settings → Hotkeys**.

## Workflow

1. **Create a note** in `content/notes/my-note.md` (or via Templater template).
2. **Frontmatter** — minimum:
   ```yaml
   ---
   title: My note
   publish: true
   tags: [topic]
   ---
   ```
   Set `publish: false` (or omit) to keep it private.
3. **Link** with `[[wikilinks]]` to other notes; add to a MOC in `content/maps/`.
4. **Preview** locally: `npx quartz build --serve` from repo root → `http://localhost:8080`.
5. **Ship**: `git add content/... && git commit && git push` (or `npx quartz sync`).

## Conventions

- Private notes live in `content/private/` (ignored by build) or stay `publish: false`.
- Filenames: kebab-case, descriptive (`a-kept-promise-is-success.md`).
- One idea per note; link generously; prefer MOCs over folders for navigation.
- Don't store secrets or personal data in published notes.

## Troubleshooting

- **Wikilinks not resolving in Quartz** — ensure the target note exists and is published (or use an alias). Quartz's OFM plugin handles `[[...]]`.
- **Frontmatter not parsed** — must be the very first thing in the file, delimited by `---`.
- **Build ignores a note** — check `ignorePatterns` in `quartz.config.yaml` (`private`, `templates`, `.obsidian`).
