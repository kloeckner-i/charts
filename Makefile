
.PHONY: all deploy build helm
.ONESHELL: test

ifeq ($(K8S_VERSION),)
K8S_VERSION := v1.22.13
endif

k3d:
	@curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
	@k3d cluster create myk3s -i rancher/k3s:$(K8S_VERSION)-k3s1
	@kubectl get pod

lint: ## lint helm manifests
	@helm lint -f db-operator/values.yaml -f db-operator/ci/ci-1-values.yaml --strict ./db-operator
	@helm lint -f db-instances/values.yaml --strict ./db-instances

helm: ## install helm if not exist and install local chart using helm upgrade --install command
	@helm upgrade --install --create-namespace --namespace operator my-dboperator db-operator -f db-operator/values.yaml -f db-operator/values-local.yaml