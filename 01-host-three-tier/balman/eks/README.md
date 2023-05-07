# Learn Terraform - Provision an EKS Cluster

This repo is a companion repo to the [Provision an EKS Cluster tutorial](https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks), containing
Terraform configuration files to provision an EKS cluster on AWS.


### Create EKS Cluster
terraform init
export ENV_LABEL=k8s ENV_TYPE=nonproduction AWS_PROFILE=guru
## Export envs
terraform apply -var="EnvironmentName=${ENV_LABEL}"

## Create kubeconfig
aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)  --alias $(terraform output -raw environment_name)-eks-test

## Check cluster-info
kubectl cluster-info # dump for more details
kubectl get nodes
kubectl get pods -A
```
