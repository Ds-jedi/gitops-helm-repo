# helm dependency update
# helm template . -f values.yaml
# kubectl create ns external-secrets
# helm upgrade -install external-secrets . -f values.yaml -n external-secrets














# External Secrets Operator Helm Installtion

**External Secrets Operator** is a Kubernetes operator that integrates external secret management systems like [AWS Secrets Manager](https://aws.amazon.com/secrets-manager/), [HashiCorp Vault](https://www.vaultproject.io/), [Google Secrets Manager](https://cloud.google.com/secret-manager), [Azure Key Vault](https://azure.microsoft.com/en-us/services/key-vault/) and many more. The operator reads information from external APIs and automatically injects the values into a [Kubernetes Secret](https://kubernetes.io/docs/concepts/configuration/secret/).

### What is the goal of External Secrets Operator?

The goal of External Secrets Operator is to synchronize secrets from external APIs into Kubernetes. ESO is a collection of custom API resources - `ExternalSecret`, `SecretStore` and `ClusterSecretStore` that provide a user-friendly abstraction for the external API that stores and manages the lifecycle of the secrets for you.

Step 1: Create Namespace:

```
kubectl create ns external-secrets
```

Step 2: Create custom helm charts using below command:

```
$ helm create external-secrets
Creating external-secrets
$ ls external-secrets/
Chart.yaml   charts/      templates/   values.yaml
```

Step 3: Add dependencies in Chart.yaml:

```
apiVersion: v2
name: external-secrets
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "1.16.0"
dependencies:
- name: external-secrets
  version: "0.5.8"
  repository: https://charts.external-secrets.io
```

Step 4: Install crds for external-secrets:

- Create folder **crds** and add all the external secretes crds in that folder

- We are going to install crds manually.

- Pull external secrets version, copy this tar to charts folder and extract tar file. You will get crds in template folder.

- Edit those crds and remove all helm {{ }} template syntax.

- Once done copy all the crds to crds folder. So folder structure will looks like.

  ```
  $ ls
  Chart.yaml  charts  crds  templates  values.yaml  yamls
  $ tree
  .
  |-- charts
  |   `-- external-secrets-0.5.8.tgz
  |-- Chart.yaml
  |-- crds
  |   `-- bases
  |       |-- clusterexternalsecret.yaml
  |       |-- clustersecretstore.yaml
  |       |-- externalsecret.yaml
  |       `-- secretstore.yaml
  |-- templates
  |   |-- sa.yaml
  |   `-- secretstore-by-role.yaml
  |-- values.yaml
  `-- yamls
      |-- clusterwise
      |   |-- app-1.yaml
      |   |-- external-secretes-by-role.yaml
      |   `-- sa.yaml
      `-- namespaced
          |-- app-1.yaml
          |-- external-secretes-by-role.yaml
          |-- sa.yaml
          `-- secretstore-by-role.yaml

  7 directories, 16 files
  ```

  Once done apply those crds yamls.

Step 4: Add ClusterSecretStore and service account yaml to create at installtion time.

Step 5: Edit/add required values in values.yaml and install external secrets helm operator using below command.

So values.yaml looks like

```

"external-secrets":
  installCRDs: false
  crds:
    # -- If true, create CRDs for Cluster External Secret.
    createClusterExternalSecret: false
    # -- If true, create CRDs for Cluster Secret Store.
    createClusterSecretStore: false
  leaderElect: false


  replicaCount: 1

  podAnnotations:
   consul.hashicorp.com/connect-inject: 'false'

  serviceAccount:
    create: true

  webhook:
    replicaCount: 1
    certCheckInterval: "5m"

    podAnnotations:
      consul.hashicorp.com/connect-inject: 'false'

    serviceAccount:
      create: true

  certController:
    requeueInterval: "5m"
    replicaCount: 1

    podAnnotations:
      consul.hashicorp.com/connect-inject: 'false'

    serviceAccount:
      create: true
```

Install helm operator :

```
helm upgrade --install external-secrets . -f values.yaml -n external-secrets
```

Once done check the operator pods:

```
$ kubectl get pod -n external-secrets
NAME                                               READY   STATUS    RESTARTS   AGE
external-secrets-54dd8d574b-w6b2n                  1/1     Running   0          21m
external-secrets-cert-controller-8b76bd699-dhj58   1/1     Running   0          21m
external-secrets-webhook-6c464cfb74-lsqpw          1/1     Running   0          21m
```

For remove this operator use below command.

```
helm uninstall external-secrets -n external-secrets
```

