#!/bin/bash

# This script will install Minikube and kubectl, and then start a Minikube cluster using the none driver, 
# which means that it will use the host system as the Kubernetes node. 

# Install Minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube \
  && sudo mv minikube /usr/local/bin/

# Install Kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
  && chmod +x kubectl \
  && sudo mv kubectl /usr/local/bin/

# Start Minikube cluster
sudo minikube start --vm-driver=none
    
