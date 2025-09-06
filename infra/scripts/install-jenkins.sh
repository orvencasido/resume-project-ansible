#!/bin/bash 
set -e

until k3s kubectl get nodes &>/dev/null; do
    echo "Kubernetes not ready, sleeping 5s..."
    sleep 5
done

mkdir -p ~/.kube
sudo k3s kubectl config view --raw > ~/.kube/config
chmod 600 ~/.kube/config
export KUBECONFIG=~/.kube/config

kubectl create namespace jenkins --dry-run=client -o yaml | kubectl apply -f -

helm repo add jenkins https://charts.jenkins.io
helm repo update

helm install jenkins jenkins/jenkins -n jenkins \
  --set persistence.enabled=true \
  --set persistence.size=8Gi \
  --set persistence.storageClass=local-path \
  --set controller.serviceType=NodePort \
  --set controller.nodePort=30080 \
  --set controller.adminUser=admin \
  --set controller.adminPassword=1234
