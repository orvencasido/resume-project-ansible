#!/bin/bash
set -e

curl -sfL https://get.k3s.io | sh -

export KUBECONFIG=~/.kube/config && \
mkdir ~/.kube 2> /dev/null && \
k3s kubectl config view --raw > "$KUBECONFIG" && \
chmod 600 "$KUBECONFIG" 