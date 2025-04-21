
# # Create a secret in the castai-agent namespace
resource "kubernetes_namespace" "castai-agent" {
  metadata {
    name = "castai-agent"
  }
  depends_on = [ castai_eks_cluster.my_castai_cluster ]
}

resource "kubernetes_secret" "castai-cluster-secret" {
  metadata {
    name      = "castai-cluster-secret"
    namespace = "castai-agent"
  }

  data = {
    "CLUSTER_ID" = castai_eks_clusterid.cluster_id.id
    "API_KEY"    = castai_eks_cluster.my_castai_cluster.cluster_token
  }
  depends_on = [ kubernetes_namespace.castai-agent ]
}