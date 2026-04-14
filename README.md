# NPM Proxy + 5 Websites (Custom Cert Aware)

This stack creates:

- 1 custom **Nginx Proxy Manager** container (`npm`)
- 5 custom website containers (`shopping`, `social-media`, `news`, `email`, `forum`)
- Certificate trust installation from local `certs/` during image build

## Structure

- `docker-compose.yml`
- `docker/npm/Dockerfile`
- `docker/website/Dockerfile`
- `setup-hosts.sh` (script to configure `/etc/hosts`)
- `certs/` (put your `.crt` CA cert files here)

## Add certificates

1. Place your custom CA certificates into `certs/`.
2. Use `.crt` extensions for compatibility with `update-ca-certificates`.

Example:

```bash
cp my-company-root-ca.crt certs/
```

## Configure hosts file

To access the websites via custom domain names (`*.testlaboratory.cc`), run the provided script:

```bash
sudo ./setup-hosts.sh
```

This will add the following entries to `/etc/hosts`:

- `shopping.testlaboratory.cc`
- `social-media.testlaboratory.cc`
- `news.testlaboratory.cc`
- `email.testlaboratory.cc`
- `forum.testlaboratory.cc`

A backup of your hosts file will be created automatically.

## Build and run

```bash
docker compose up -d --build
```

## Access

- Nginx Proxy Manager UI: `http://localhost:81`
- Shopping: `http://localhost:8081` or `http://shopping.testlaboratory.cc` (after configuring hosts)
- Social Media: `http://localhost:8082` or `http://social-media.testlaboratory.cc` (after configuring hosts)
- News: `http://localhost:8083` or `http://news.testlaboratory.cc` (after configuring hosts)
- Email: `http://localhost:8084` or `http://email.testlaboratory.cc` (after configuring hosts)
- Forum: `http://localhost:8085` or `http://forum.testlaboratory.cc` (after configuring hosts)

## NPM upstream targets

Recommended (container-to-container on Docker network):

- `shopping:80`
- `social-media:80`
- `news:80`
- `email:80`
- `forum:80`

Alternative (via host ports from inside NPM):

- `host.docker.internal:8081`
- `host.docker.internal:8082`
- `host.docker.internal:8083`
- `host.docker.internal:8084`
- `host.docker.internal:8085`

The `npm` service includes `extra_hosts: host.docker.internal:host-gateway` so this works on Linux.

## Default Nginx Proxy Manager login

- Email: `admin@example.com`
- Password: `changeme`

You will be prompted to change these on first login.
