
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
	@helm lint -f charts/db-operator/values.yaml -f charts/db-operator/ci/ci-1-values.yaml --strict ./charts/db-operator
	@helm lint -f charts/db-instances/values.yaml --strict ./charts/db-instances

db-operator: ## install db-operator chart if not exist and install local chart using helm upgrade --install command
	@helm upgrade --install --create-namespace --namespace operator my-dboperator charts/db-operator -f charts/db-operator/values.yaml -f charts/db-operator/values-local.yaml