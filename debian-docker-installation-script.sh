#!/usr/bin/env bash
set -e

# ------------------------------------------------------------
# Docker installation script for Debian
# ------------------------------------------------------------

echo "==> Updating system"
apt update && apt upgrade -y

echo "==> Installing required packages"
apt install -y ca-certificates curl

echo "==> Creating APT keyring directory"
install -m 0755 -d /etc/apt/keyrings

echo "==> Downloading Docker GPG key"
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo "==> Adding Docker repository"
tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

echo "==> Updating package sources"
apt update

echo "==> Installing Docker & Docker Compose"
apt install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

echo "==> Docker installation completed"
docker --version
docker compose version

echo "==> Done ✔"
