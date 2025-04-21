# ArgoCD example

This directory shows how CASTAI in-cluster components can be deployed using ArgoCD.

### About the dir

#### deploy
Directory where the examples of Charts or Kustomize configuration files. This dir is the `path` where ArgoCD Applications will be pointed.

#### e2e-example
Contains an example of onboarding a cluster to CASTAI, deployment of ArgoCD, and creation of `AppProject` and `ApplicationSet`, generating `Applications` for each subdir in the `deploy` directory.

See README.md of e2e-example for more details.

