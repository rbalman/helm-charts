resource "kubernetes_manifest" "loadbalancer-controller-sa" {
  manifest = {
    apiVersion = "v1"
    kind = "ServiceAccount"
    metadata = {
      name = "aws-load-balancer-controller"
      namespace = "kube-system"
      labels = {
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/name" = "aws-load-balancer-controller"
      }
      annotations = {
        "eks.amazonaws.com/role-arn" = "${ aws_iam_role.loadbalancer_controller_role.arn }"
        "eks.amazonaws.com/sts-regional-endpoints" =  "true"
      }
    }
  }
  # manifest = yamldecode(<<YAML
  #   apiVersion: v1
  #   kind: ServiceAccount
  #   metadata:
  #     name: aws-load-balancer-controller
  #     namespace: kube-system
  #     labels:
  #       app.kubernetes.io/component: controller
  #       app.kubernetes.io/name: aws-load-balancer-controller
  #     annotations:
  #       eks.amazonaws.com/role-arn: "${ aws_iam_role.loadbalancer_controller_role.arn }"
  #       eks.amazonaws.com/sts-regional-endpoints: "true"
  #   YAML
  # )
}

resource "helm_release" "loadbalancer_ingress" {
  depends_on = [
    kubernetes_manifest.loadbalancer-controller-sa
  ]
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace = "kube-system"

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "serviceAccount.create"
    value = false
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }
}

