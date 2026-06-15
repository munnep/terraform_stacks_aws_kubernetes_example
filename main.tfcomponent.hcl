output "kubernetes_cluster_name" {
  description = "The name of the Kubernetes cluster"
  type        = string
  value       = component.kubernetes.cluster_name
}

output "kubectl_environment" {
  description = "The command to set up kubectl for the cluster"
  type        = string
  value       = component.kubernetes.kubectl_environment
}

component "kubernetes" {
  source = "./kubernetes"
  inputs = {
    k8s_version = var.k8s_version
    tag_prefix = var.tag_prefix
    vpc_cidr = var.vpc_cidr
    region = var.region
  }

  providers = {
      aws = provider.aws.this
      http = provider.http.this
  }

}

component "EDR" {
  source = "./EDR"
  inputs = {
    tag_prefix   = var.tag_prefix
    cluster_name = component.kubernetes.cluster_name
  }

  providers = {
      helm = provider.helm.this
  }
}

component "pods" {
  source = "./pods"
  inputs = {
    tag_prefix   = var.tag_prefix
  }

  providers = {
      kubernetes = provider.kubernetes.this
  }
}

