# ArgoCD example

This directory shows how CASTAI in-cluster components can be deployed using ArgoCD.

### About the dir

#### deploy
Directory where the examples of Helm Charts or Kustomize configuration files.
This dir is the `path` where ArgoCD Applications will be pointed.

#### e2e-example
Contains an end to end example of 
- onboarding a cluster to CASTAI using terraform
- deployment of ArgoCD in the cluster with terraform helm
- creation of `AppProject` and `ApplicationSet`, which will dynamically generate `Applications` for each subdir in the `deploy` directory. Avoiding clickops.
- argocd will auto sync the configuration from `argocd/deploy`

See README.md of e2e-example for more details.

