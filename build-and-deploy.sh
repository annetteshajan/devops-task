#!/bin/bash

set -e

IMAGE_NAME=hello-python-server
IMAGE_TAG=latest

echo "Building Docker image..."
docker build -t $IMAGE_NAME:$IMAGE_TAG .

echo "Running tests..."
docker run --rm $IMAGE_NAME:$IMAGE_TAG python -m unittest discover -s helloapp

echo "Loading image into Minikube..."
minikube image load $IMAGE_NAME:$IMAGE_TAG

echo "Deploying to Kubernetes..."
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

echo "Deployment complete."
