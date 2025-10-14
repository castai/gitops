# Deploy argocd helm chart
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = "argocd"
  version    = "7.8.14"
  atomic     = true
  create_namespace = true
  # values = [
  #   file("argocd-values.yaml"),
  # ]
}

resource "helm_release" "argocd-customization" {
  name       = "argocd-customization"
  chart      = "./argocd-customization/"
  namespace  = "argocd"
  version    = "0.0.1"
  atomic     = true
  set = [ {
    name = "clusterName"
    value = var.aws_cluster_name
  },
  {
    name = "gitops_url"
    value = var.gitops_repo_url
  }
  ]
  depends_on = [ helm_release.argocd ]
}