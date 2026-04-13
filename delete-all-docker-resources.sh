#!/usr/bin/env bash
set -euo pipefail

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker is not installed or not in PATH."
  exit 1
fi

if [[ "${1:-}" != "--yes" ]]; then
  cat <<'MSG'
WARNING: This will delete ALL Docker containers, images, and volumes on this host.
This is global and not limited to this project.
MSG
  read -r -p "Type DELETE to continue: " confirm
  if [[ "$confirm" != "DELETE" ]]; then
    echo "Aborted."
    exit 0
  fi
fi

echo "Removing all containers..."
containers="$(docker ps -aq)"
if [[ -n "$containers" ]]; then
  docker rm -f $containers
else
  echo "No containers found."
fi

echo "Removing all images..."
images="$(docker images -aq)"
if [[ -n "$images" ]]; then
  docker rmi -f $images
else
  echo "No images found."
fi

echo "Removing all volumes..."
volumes="$(docker volume ls -q)"
if [[ -n "$volumes" ]]; then
  docker volume rm $volumes
else
  echo "No volumes found."
fi

echo "Done. All containers, images, and volumes have been removed."
