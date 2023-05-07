### Install AWS ALB Controller
#### Pre-requisites(https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html)
  - At least two subnets in two AZs
  - Have an existing EKS cluster
  - Tag subnets with 
    - Key: `kubernetes.io/cluster/balman-eks-cluster`, Value: `shared` or `owned`
    - Key: `kubernetes.io/role/elb`, Value: `1` if subnet is public
    - Key: `kubernetes.io/role/internal-elb`, Value: `1` if subnet is private
  - Have an aws alb controller deployed on your cluster.
  - At least two subnets

#### Installing Controller Addons(https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html)
  - Creating OIDC provider(https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html) if not created. By default it is created for EKS.
  - Create Load balancer IAM policy and role for loadbalancer controller

- Create Service Account EKS
```shell
## Update Role ARN in service account file and apply the file
kubectl apply -f service-account.yaml
```
-  (Optional)Configure the AWS Security Token Service endpoint type(https://docs.aws.amazon.com/eks/latest/userguide/configure-sts-endpoint.html)

```shell
kubectl annotate serviceaccount -n kube-system aws-node eks.amazonaws.com/sts-regional-endpoints=true
```

#### Install the AWS Load Balancer Controller using Helm V3
```shell
helm repo add eks https://aws.github.io/eks-charts
helm repo update

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set region=us-east-1 \
  --set vpcId=vpc-06b779eafcad561e4 \
  --set clusterName=balman-eks-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set image.repository=amazon/aws-alb-ingress-controller
```

### Run Sample Application
```shell
kubectl apply -f 2048_full.yaml
```
