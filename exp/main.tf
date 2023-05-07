locals {
  list = split("/", var.arn)
}

output "oidc_id" {
  value = element(local.list, -1)
}
