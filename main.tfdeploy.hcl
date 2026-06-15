store "varset" "aws-credentials" {
  name     = "aws-credentials"
  category = "env"
}

deployment "test" {

  inputs = {
    tag_prefix    = "test"
    vpc_cidr      = "10.72.0.0/16"
    access_key    = store.varset.aws-credentials.AWS_ACCESS_KEY_ID
    secret_key    = store.varset.aws-credentials.AWS_SECRET_ACCESS_KEY
    session_token = store.varset.aws-credentials.AWS_SESSION_TOKEN
    region        = "eu-north-1"
    k8s_version   = "1.31"
  }

  destroy = false # alter to true to destroy the deployment after creation


}

publish_output "test_cluster_name" {
  description = "Test_Kubernetes cluster name"
  value       = deployment.test.kubernetes_cluster_name
}

publish_output "test_kubectl_environment" {
  description = "Test_Kubernetes kubectl environment"
  value       = deployment.test.kubectl_environment
}
