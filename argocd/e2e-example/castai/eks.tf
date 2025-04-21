data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_eks_cluster" "existing_cluster" {
  name = var.aws_cluster_name
}