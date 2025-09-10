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
  --set-string controller.admin.username=admin \
  --set-string controller.admin.password=1234

# kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo

sudo cp /etc/rancher/k3s/k3s.yaml /etc/rancher/k3s/k3s-jenkins.yaml
sudo chmod 644 /etc/rancher/k3s/k3s-jenkins.yaml

sudo sed -i 's#server: https://127.0.0.1:6443#server: https://kubernetes.default.svc:443#' /etc/rancher/k3s/k3s-jenkins.yaml

