# dockerVolumeDocApp

A lightweight **Nginx-based frontend** application containerized with Docker and deployable to Kubernetes via raw manifests or a Helm chart.

---

## 📁 Project Structure

```
.
├── dockerVolumeDocApp/
│   ├── Dockerfile          # Single-stage Nginx Docker image
│   ├── index.html          # Frontend HTML application
│   └── README.md           # This file
└── helm-chart/
    ├── Chart.yaml          # Helm chart metadata (v0.1.1)
    ├── values.yaml         # Default configuration values
    └── templates/
        ├── deployment.yaml # Kubernetes Deployment template
        └── service.yaml    # Kubernetes Service template
```

---

## 🐳 Docker

### Build & Run Locally

```bash
# Build the image
docker build -t docapp .

# Run the container
docker run -it -d -p 8080:80 docapp

# Visit in browser
http://localhost:8080
```

### Docker Hub Image

```
ashishkashyap92/frontend23:latest
```

---

## ☸️ Kubernetes — Deploy with Helm

### Prerequisites
- Kubernetes cluster (e.g. Minikube, AKS)
- Helm v3 installed

### Install

```bash
# From the repo root (parent of helm-chart/)
helm install blobmountguide ./helm-chart
```

### Upgrade

```bash
helm upgrade blobmountguide ./helm-chart
```

### Uninstall

```bash
helm uninstall blobmountguide
```

### Verify Deployment

```bash
kubectl get pods
kubectl get svc
```

---

## ⚙️ Helm Chart Configuration

Helm chart version: `0.1.1` | App version: `1.0.1`

| Parameter | Description | Default |
|---|---|---|
| `replicaCount` | Number of pod replicas | `2` |
| `image.repository` | Container image | `ashishkashyap92/frontend23` |
| `image.tag` | Image tag | `latest` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `containerPort` | Port exposed by container | `80` |
| `service.type` | Kubernetes service type | `ClusterIP` |
| `service.port` | Service port | `80` |
| `resources.requests.cpu` | CPU request | `100m` |
| `resources.requests.memory` | Memory request | `128Mi` |
| `resources.limits.cpu` | CPU limit | `250m` |
| `resources.limits.memory` | Memory limit | `256Mi` |
| `livenessProbe.enabled` | Enable liveness probe | `false` |
| `readinessProbe.enabled` | Enable readiness probe | `false` |
| `env` | Environment variables | `[]` |
| `nodeSelector` | Node selector labels | `{}` |
| `tolerations` | Pod tolerations | `[]` |
| `affinity` | Pod affinity rules | `{}` |

### Override values on install

```bash
helm install blobmountguide ./helm-chart \
  --set replicaCount=3 \
  --set image.tag=v2.0 \
  --set service.type=NodePort
```

---

## 📊 Monitoring (Prometheus)

Prometheus is deployed alongside the app using the community Helm chart:

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install my-prometheus prometheus-community/prometheus --version 29.17.0
```

Access Prometheus:
```bash
export POD_NAME=$(kubectl get pods -l "app.kubernetes.io/name=prometheus,app.kubernetes.io/instance=my-prometheus" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward $POD_NAME 9090
# Visit http://localhost:9090
```
