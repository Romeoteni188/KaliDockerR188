# Docker

```bash
docker build -t auditoria:latest .

docker run --rm -it \
  -v $(pwd)/wordlists:/home/pentest/wordlists:ro \
  --cap-add=NET_RAW --cap-add=NET_ADMIN \
  auditoria:latest
```

## Docker compose

```bash
docker compose up --build
docker compose run --rm auditoria
```
