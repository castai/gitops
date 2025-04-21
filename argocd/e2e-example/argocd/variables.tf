## Required variables.

variable "aws_cluster_name" {
  type        = string
  description = "Name of the cluster to be connected to CAST AI."
}

variable "gitops_repo_url" {
  type        = string
  description = "URL of the gitops repository"
}

variable "aws_cluster_region" {
  type        = string
  description = "Region of the cluster to be connected to CAST AI."
}

variable "profile" {
  type        = string
  description = "Profile used with AWS CLI"
  default     = "default"
}