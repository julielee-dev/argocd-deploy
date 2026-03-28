ArgoCD deploy repo
------------------

This folder contains a single ArgoCD Application which watches the repository:

- https://github.com/julielee-dev/hello-world

Files:

- apps/hello-world/application.yaml — ArgoCD `Application` manifest. It points the `source.repoURL` to the repo above and uses `path: ''` (repository root).

Usage:

1. Install ArgoCD in your cluster and ensure the `argocd` namespace exists.
2. Apply the Application manifest:

```bash
kubectl apply -f apps/hello-world/application.yaml
```

3. ArgoCD will create an Application named `hello-world` in the `argocd` namespace and start syncing the target repo into the `default` namespace in the cluster.

Adjust `destination.namespace` or `path` in `apps/hello-world/application.yaml` as needed.

Helm chart and environment apps
-------------------------------

This repo now contains a Helm chart and ArgoCD Application manifests for dev/staging/production:

- `charts/hello-world` — Helm chart for the app.
- `apps/hello-world/dev/application.yaml` — ArgoCD Application targeting the chart with dev-specific Helm values.
- `apps/hello-world/staging/application.yaml` — staging Application.
- `apps/hello-world/production/application.yaml` — production Application.

Important: replace `repoURL: 'https://github.com/your-org/argocd-deploy'` in the Application manifests with the actual git URL for this repo (e.g. your GitHub or Git remote URL) so ArgoCD can access the repository.

To create the environments in ArgoCD (example):

```bash
# Apply the ArgoCD Application manifests
kubectl apply -f apps/hello-world/dev/application.yaml
kubectl apply -f apps/hello-world/staging/application.yaml
kubectl apply -f apps/hello-world/production/application.yaml
```

To install the Helm chart directly (for testing):

```bash
helm install hello-world charts/hello-world --namespace dev --create-namespace
```

