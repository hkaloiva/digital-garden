# Custom Domain

Step-by-step guide to pointing a custom domain at this GitHub Pages site.

> This garden deploys to GitHub Pages via `.github/workflows/deploy.yml` (push to `main`). The site's `baseUrl` is set in `quartz.config.yaml`.

## Prerequisites

- A domain you own (apex, e.g. `example.com`, or a subdomain, e.g. `garden.example.com`).
- Access to your DNS provider's record editor.
- Admin access to the GitHub repo (`hkaloiva/digital-garden`).

## Step 1 — Set `baseUrl` in Quartz

Edit `quartz.config.yaml`:

```yaml
configuration:
  baseUrl: example.com   # or garden.example.com (no protocol, no trailing slash)
```

Commit and push so the build uses the new base URL.

## Step 2 — Create the `CNAME` file

GitHub Pages reads a `CNAME` file at the site root. Quartz copies files in `content/`? No — Quartz emits to `public/`. The cleanest approach for Quartz is to put a `CNAME` file in the `static/` directory (Quartz copies `static/` verbatim into `public/`).

Create `static/CNAME` (repo root) containing a single line — your domain:

```
example.com
```

(If `static/` doesn't exist, create it.) Alternatively, you can add the file via the GitHub Pages UI (Step 4), which auto-commits a `CNAME` to the deployment branch — but that gets overwritten on next deploy, so the `static/CNAME` method is durable.

## Step 3 — DNS records

### Apex domain (`example.com`)

At your DNS provider, create **A records** for the apex (`@`) pointing to GitHub Pages' IPs:

| Type | Name | Value |
|------|------|-------|
| A | @ | 185.199.108.153 |
| A | @ | 185.199.109.153 |
| A | @ | 185.199.110.153 |
| A | @ | 185.199.111.153 |

Optionally add **AAAA records** for IPv6 (GitHub's): `2606:50c0:8000::153`, `2606:50c0:8001::153`, `2606:50c0:8002::153`, `2606:50c0:8003::153`.

### Subdomain (`garden.example.com`)

Create a **CNAME record**:

| Type | Name | Value |
|------|------|-------|
| CNAME | garden | hkaloiva.github.io |

(Use your actual `<username>.github.io`.) Do **not** include a path.

### `www` redirect (optional)

If you want `www.example.com` to redirect to the apex, add a CNAME for `www` → `example.com` (or your Pages domain) and enable "Enforce HTTPS".

## Step 4 — GitHub Pages settings

1. Repo → **Settings → Pages**.
2. Under **Source**, select **GitHub Actions** (already set by the workflow).
3. Under **Custom domain**, enter your domain (e.g. `example.com`) and click **Save**.
   - GitHub creates/updates the `CNAME` file in the deployed artifact and verifies DNS.
4. Wait for the **DNS check** to pass (green tick). This can take minutes to hours depending on TTL.

## Step 5 — HTTPS

1. Once DNS verifies, tick **Enforce HTTPS** in Settings → Pages.
2. GitHub provisions a Let's Encrypt certificate automatically (may take up to an hour after DNS verification).
3. Test: `https://example.com` should load with a valid cert.

## Verify

```bash
# DNS resolution
dig example.com +short
# Expect the four GitHub IPs

# HTTPS
curl -I https://example.com
# Expect 200
```

## Troubleshooting

- **"Domain does not resolve"** — DNS TTL not expired yet; wait, then re-check. Confirm A records are on the apex, not a subdomain.
- **Certificate pending** — Enforce HTTPS stays disabled until DNS verification succeeds; re-save the custom domain after DNS propagates.
- **404 on custom domain** — `baseUrl` mismatch or missing `CNAME` in `public/`; check the deployed artifact.
- **Mixed content** — update any hardcoded `http://` links to `https://`.

## References

- GitHub Docs: "Managing a custom domain for your GitHub Pages site"
- Quartz hosting docs: `docs/hosting.md`
