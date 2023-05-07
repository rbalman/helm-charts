variable "oidc_arn" {
  description = "ARN of the OIDC"
  type        = string
  default     = "arn:aws:iam::263423382682:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/543C31A0609D1BBEE07308719B2BCC22"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-w00w3l0p"
}
