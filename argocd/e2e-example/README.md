## e2e-example

#### Pre-requisite
1. terraform cli
2. On correct dir `cd argocd/e2e-example`
3. Pre-populate the `tf.vars.example` with the required information of your cluster.
Then rename it to `tf.vars`.


#### Onboard the cluster to CASTAI:
```
terraform -chdir=castai init --var-file ../tf.vars

terraform -chdir=castai plan --var-file ../tf.vars

terraform -chdir=castai apply --var-file ../tf.vars
```

#### Create AppProject and ApplicationSet:
```
terraform -chdir=argocd init --var-file ../tf.vars

terraform -chdir=argocd plan --var-file ../tf.vars

terraform -chdir=argocd apply --var-file ../tf.vars
```




