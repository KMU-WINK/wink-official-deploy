#!/bin/bash

if ! command -v docker &> /dev/null; then
  echo "Error: Docker is not installed." >&2
  exit 1
fi

if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  echo "A" > "$HOME/.ssh/id_ed25519"
  chmod 600 "$HOME/.ssh/id_ed25519"
  ssh-keyscan github.com >> "$HOME/.ssh/known_hosts"
fi

if [ ! -d "deploy" ]; then
  echo "Error: deploy directory does not exist." >&2
  exit 1
fi

git checkout develop
git pull origin develop

docker compose pull
docker compose down
docker compose up -d
