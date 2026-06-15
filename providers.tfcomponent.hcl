required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 6.50.0"
  }
  http = {
    source  = "hashicorp/http"
    version = "~> 3.2.0"
  }
  kubernetes = {
    source  = "hashicorp/kubernetes"
    version = "~> 3.2.0"
  }
  helm = {
    source  = "hashicorp/helm"
    version = "~> 3.2.0"
  }
}

provider "aws" "this" {
  config {
    access_key = var.access_key
    secret_key = var.secret_key
    token      = var.session_token
    region     = var.region
  }
}

provider "http" "this" {
}

provider "kubernetes" "this" {
  config {
    host                   = component.kubernetes.cluster_url
    cluster_ca_certificate = component.kubernetes.cluster_ca
    token                  = component.kubernetes.cluster_token
  }
}

provider "helm" "this" {
  config {
    kubernetes = {
      host                   = component.kubernetes.cluster_url
      cluster_ca_certificate = component.kubernetes.cluster_ca
      token                  = component.kubernetes.cluster_token
    }
  }
}
