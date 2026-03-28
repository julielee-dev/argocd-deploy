## Set up working Environment Basics
To set up your working environment you'll need to set up these tooling.

I use homebrew to set up this environment. This is also under the assumption you are working on a Mac with xcode installed and Docker Desktop installed and running.

### Note 
It is important to note for Macbook users to turn off Airplay Reciever as it runs on port 5000 and will interfere with the set up of ArgoCD.

System Settings -> General -> AirDrop & Handoff -> Toggle off AirPlay Reciever


Install Docker Desktop
https://www.docker.com/products/docker-desktop/

Set up K8s environment and CLI

`brew install kubectl helm kustomize minikube docker argocd`

Make sure to verify tools are installed with `brew list`

Spin up Minikube
`minikube start --driver=docker`

Spin up ArgoCD locally

```kubectl create namespace argocd
kubectl apply -n argocd --server-side --force-conflicts -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Check to verify if ArgoCD has stood up in your cluster and set your kube config to namespace argocd

``` kubectl config set-context --current --namespace=argocd
    kubectl get pods
    ```

You should see at least 7 pods stood up:
    ```
    argocd-application-controller
    argocd-applicationset-controller
    argocd-dex-server
    argocd-notifications-controller
    argocd-redis
    argocd-repo-server
    argocd-server
    ```
For ease, we will expose the service of argocd-server to port 8080

`kubectl port-forward svc/argocd-server -n argocd 8080:443`

Verify on your browser if this is port is exposed here:

`https://localhost:8080/`

In a new CLI, because the current one you're probably using is port-forwarding ArgoCD UI, grab the auto-generated password to log into argocd UI

`argocd admin initial-password -n argocd`

Grab the output of the password and login with the user admin and paste the password into the UI.

Download my hello-world app.

`git clone https://github.com/julielee-dev/hello-world.git`

 