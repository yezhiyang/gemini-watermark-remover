# Docker Deployment

This guide deploys the public `gemini-watermark-remover` repository as a static site served by Nginx.

## Requirements

- Docker Engine 20.10 or newer
- Docker Compose v2 (the `docker compose` command)

No server-side API key is required: image processing runs in the browser.

## Deploy with Docker Compose

```bash
git clone https://github.com/yezhiyang/gemini-watermark-remover.git
cd gemini-watermark-remover
docker compose up -d --build
```

Open `http://YOUR_SERVER_IP:2234`.

## Verify the deployment

```bash
docker compose ps
curl http://localhost:2234/health
docker compose logs -f
```

The health endpoint should return `OK`.

## Deploy with Docker directly

```bash
docker build -t gemini-watermark-remover .
docker run -d \
  --name gemini-watermark-remover \
  -p 2234:2234 \
  --restart unless-stopped \
  gemini-watermark-remover
```

## Update

```bash
git pull --ff-only
docker compose up -d --build
```

## Stop

```bash
docker compose down
```

## Change the port

The default host and container port is `2234`. To change it, update both the Nginx `listen` directives in `nginx.conf` and the host-side port in `docker-compose.yml`, then rebuild:

```bash
docker compose up -d --build
```

If the server uses a firewall, allow the selected TCP port.
