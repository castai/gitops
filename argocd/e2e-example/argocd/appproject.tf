
# Create ArgoCD AppProject
resource "kubernetes_manifest" "castai_app_project" {
    manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind" = "AppProject"
    "metadata" = {
      "name" = format("%s-%s",var.aws_cluster_name,"project")
      "namespace" = "argocd"
    }
    "spec" = {
      "description" = "CASTAI components"
      "sourceRepos" = ["*"]
      "destinations" = [
        {
        "server" = "*"
        "namespace" = "*"
        }
        ]
      "clusterResourceWhitelist" = [
        {
        "group" = "*"
        "kind" = "*"
        }
        ]
      }
    }
}