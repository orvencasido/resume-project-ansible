#!/bin/bash 
set -e

helm repo add jenkins https://charts.jenkins.io
helm repo update

kubectl create namespace jenkins 

helm install jenkins jenkins/jenkins -n jenkins \
--set persistence.enabled=true \
--set persistence.size=8Gi \
--set persistence.storageClass=local-path \
--set service.type=NodePort \
--set service.nodePort=30080