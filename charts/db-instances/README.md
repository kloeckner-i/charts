# db-instances
Create DB Instance resources for is DB Operator

## Configuring helm client
```
$ helm repo add kloeckneri https://kloeckner-i.github.io/charts
```
Test the helm chart repository
```
$ helm search repo kloeckneri/db-instances
```

## Installing Chart
To install the chart with the release name my-release:
```
$ helm install --name my-release kloeckneri/db-instances
```
The command deploys DB Operator on Kubernetes with default configuration.

## Uninstalling Chart
To uninstall the `my-release` deployment:
```
$ helm delete my-release
```