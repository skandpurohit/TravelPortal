# vks-github-cicd
Repo containing code of Github Action CICD pipeline
# Testing feature branch PR
# Testing updated clusterrolebinding
# Github workflow demo

## Build & Run (local)

Build the Docker image locally:

```bash
make docker-build REGISTRY=localhost IMAGE=todo TAG=local
docker run -p 7540:7540 localhost/todo:local
```

Open http://localhost:7540 in your browser.

## Deploy to Kubernetes (local or cluster)

Set `REGISTRY`, `IMAGE`, and `TAG` env vars then run:

```bash
make docker-push REGISTRY=<your-registry> IMAGE=todo TAG=latest
make helm-deploy REGISTRY=<your-registry> IMAGE=todo TAG=latest
```

The chart is in the `helm-charts` directory; it creates a secret for `TODO_PASSWORD` from `env.todoPassword`.

## CI/CD

A GitHub Actions workflow is provided at `.github/workflows/ci-cd.yml` to build and push the image and optionally deploy using a `KUBE_CONFIG` secret.
