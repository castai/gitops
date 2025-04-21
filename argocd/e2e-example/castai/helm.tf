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