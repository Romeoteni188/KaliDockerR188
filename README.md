# Docker

```bash
docker build -t auditoria:latest .

docker run --rm -it \
  -v "$(pwd)/wordlists":/root/wordlists:ro \
  --cap-add=NET_RAW --cap-add=NET_ADMIN \
  auditoria:latest

```

```bash
 apt-get update
```

## Docker compose

```bash
docker compose up --build
docker compose run --rm auditoria
```
