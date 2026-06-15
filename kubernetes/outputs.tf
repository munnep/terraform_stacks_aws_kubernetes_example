output "kubectl_environment" {
   value = "aws eks update-kubeconfig --region ${var.region} --name ${aws_eks_cluster.k8s.name}"  
}

output "cluster_name" {
  value = aws_eks_cluster.k8s.name
}

output "cluster-name" {
   value = aws_eks_cluster.k8s.name 
}

output "prefix" {
  value = var.tag_prefix
}

output "region" {
  value = var.region
}




output "cluster_url" {
  value = aws_eks_cluster.k8s.endpoint
}

output "cluster_ca" {
  value = base64decode(aws_eks_cluster.k8s.certificate_authority[0].data)
}

data "aws_eks_cluster_auth" "k8s" {
  name = aws_eks_cluster.k8s.name
}

output "cluster_token" {
  sensitive = true
  value = data.aws_eks_cluster_auth.k8s.token
}
