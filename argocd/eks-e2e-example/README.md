## e2e-example

#### Pre-requisite
1. terraform cli
2. On correct dir `cd argocd/e2e-example`
3. Pre-populate the `tf.vars.example` with the required information of your cluster.
Then rename it to `tf.vars`.


#### Onboard the cluster to CASTAI:
```
terraform init

terraform plan --var-file tf.vars

terraform apply --var-file tf.vars
```


#### Login to ArgoCD:

- Get the initial password of argocd UI
```
kubectl get secret -n argocd argocd-initial-admin-secret -oyaml | yq '.data.password' | base64 -d
```

- Port-forward to ArgoCD UI
```
kubectl port-forward svc/argocd-server -n argocd 8080:80 
```

- Login and explore the ArgoCD UI
Username: admin
Password: <password_from_secret>


#### Cleaning up

```
terraform destroy --var-file tf.vars
```

```
terraform destroy --var-file tf.vars
```

## What does it do

Based on the [terraform-provider-castai](https://github.com/castai/terraform-provider-castai/tree/master/examples/eks/eks_cluster_gitops) example for GitOps.
With an addition of:
`helm.tf` - deploys argocd via helm.
`kubernetes.tf` - creates castai-agent namespace, and secret containing the clusterid and api key.
`argocd-customization` - is a simple helm chart that will create an `AppProject` and `ApplicationSet` resource on the argocd namespace.
Instead if creating the `AppProject` and `Applications` for each component in the argocd UI or command line. The `ApplicationSet` will generate the `Applications` per component found in the subdirectory of deploy.
[Generating Applications with ApplicationSet](https://argo-cd.readthedocs.io/en/stable/user-guide/application-set/)


Inspecting the generated appproject has the following output yaml
```
kubectl get appproject -n argocd <cluster_name>-project -oyaml
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: <cluster_name>-project
  namespace: argocd
spec:
  clusterResourceWhitelist:
  - group: '*'
    kind: '*'
  description: CASTAI components
  destinations:
  - namespace: '*'
    server: '*'
  sourceRepos:
  - '*'
```

And the generated ApplicationSet
```
apiVersion: v1
items:
- apiVersion: argoproj.io/v1alpha1
  kind: ApplicationSet
  metadata:
    annotations:
      meta.helm.sh/release-name: argocd-customization
      meta.helm.sh/release-namespace: argocd
    creationTimestamp: "2025-10-14T04:20:08Z"
    generation: 1
    labels:
      app.kubernetes.io/managed-by: Helm
    name: in-cluster-applicationset
    namespace: argocd
    resourceVersion: "35189"
    uid: 45e3bfe9-8db3-4e59-b71c-5da10cd8dd97
  spec:
    generators:
    - git:
        directories:
        - path: argocd/deploy/*
        repoURL: https://github.com/castai/gitops
        revision: HEAD
    goTemplate: true
    template:
      metadata:
        name: '{{ .path.basename }}'
      spec:
        destination:
          namespace: '{{ .path.basename }}'
          server: https://kubernetes.default.svc
        project: in-cluster-project
        source:
          path: '{{ .path.path }}'
          repoURL: https://github.com/castai/gitops
          targetRevision: HEAD
        syncPolicy:
          automated:
            prune: true
            selfHeal: true
```