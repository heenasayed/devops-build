#!/bin/bash
set -euo pipefail

IMAGE_NAME="${IMAGE_NAME:-devops-build}"
IMAGE_TAG="${IMAGE_TAG:-latest}"

docker rm -f react-app 2>/dev/null || true

docker run -d \
  --name react-app \
  --restart unless-stopped \
  -p 80:80 \
  "${IMAGE_NAME}:${IMAGE_TAG}"

for i in {1..15}; do
  if curl -fsS http://localhost/ >/dev/null; then
    echo "Application is responding on port 80."
    exit 0
  fi
  sleep 2
done

echo "Application health check failed."
docker logs react-app
exit 1

