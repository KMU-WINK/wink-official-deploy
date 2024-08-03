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

if [ ! -d "wink-official-deploy" ]; then
  git clone git@github.com:kmu-wink/wink-official-deploy.git
fi

cd wink-official-deploy

if [ ! -d "$HOME/wink-official-deploy/deploy" ]; then
  echo "Error: deploy directory does not exist." >&2
  exit 1
fi

git checkout master
git pull origin master

docker compose pull
docker compose down
docker compose up -d
