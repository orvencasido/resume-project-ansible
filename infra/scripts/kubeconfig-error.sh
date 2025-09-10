#!/bin/bash 

set -e 

# server: https://kubernetes.default.svc:443
# sudo cp /etc/rancher/k3s/k3s.yaml /etc/rancher/k3s/k3s-jenkins.yaml
# sudo chmod 644 /etc/rancher/k3s/k3s-jenkins.yaml

sudo cp /etc/rancher/k3s/k3s.yaml /etc/rancher/k3s/k3s-jenkins.yaml
sudo chmod 644 /etc/rancher/k3s/k3s-jenkins.yaml

sudo sed -i 's#server: https://127.0.0.1:6443#server: https://kubernetes.default.svc:443#' /etc/rancher/k3s/k3s.yaml



