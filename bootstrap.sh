#!/bin/sh

echo "Setting up primary server 1"
k3sup install --host 192.168.178.100 \
--user ubuntu \
--cluster \
--ssh-key /Users/ahereza/.ssh/id_ed25519 \
--local-path /Users/ahereza/.kube/config-files/homelab \
--context default \
--k3s-extra-args "--disable traefik"

echo "Fetching the server's node-token into memory"

export NODE_TOKEN=$(k3sup node-token --host 192.168.178.100 --user ubuntu)

echo "Setting up worker: 1"
k3sup join \
--host 192.168.178.101 \
--ssh-key /Users/ahereza/.ssh/id_ed25519 \
--server-host 192.168.178.100 \
--node-token "$NODE_TOKEN" \
--user ubuntu

echo "Setting up worker: 2"
k3sup join \
--host 192.168.178.102 \
--ssh-key /Users/ahereza/.ssh/id_ed25519 \
--server-host 192.168.178.100 \
--node-token "$NODE_TOKEN" \
--user ubuntu

echo "Setting up worker: 3"
k3sup join \
--host 192.168.178.103 \
--ssh-key /Users/ahereza/.ssh/id_ed25519 \
--server-host 192.168.178.100 \
--node-token "$NODE_TOKEN" \
--user ubuntu
