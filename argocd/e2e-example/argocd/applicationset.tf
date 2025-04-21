resource "kubernetes_manifest" "castai_applicationset" {
    manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind" = "ApplicationSet"
    "metadata" = {
      "name" = format("%s-%s",var.aws_cluster_name,"appset")
      "namespace" = "argocd"
    }
    "spec" = {
      "generators" = [
        {
        "git" = {
          "repoURL" = var.gitops_repo_url
          "revision" = "HEAD"
          "directories" = [
            {
              "path" = "argocd/deploy/*"
            }
          ]
          }
        }
        ]
      "template" = {
        "metadata" = {
          "name" = format("%s-%s-{{path.basename}}",var.aws_cluster_name,"castai")
          }
        "spec" = {
          "project" = format("%s-%s",var.aws_cluster_name,"project")
          "source" = {
            "repoURL" = var.gitops_repo_url
            "path" = "{{path}}"
            "targetRevision" = "HEAD"
            }
          "destination" = {
            "server" = "https://kubernetes.default.svc"
            "namespace" = "castai-agent"
            }
          "syncPolicy" = {
            "automated" = {
              "prune" = true
              "selfHeal" = true
            }
          }
          }
        }
      }
    }
    depends_on = [ kubernetes_manifest.castai_app_project ]
}