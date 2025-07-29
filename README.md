# balance-fit-prd Namespace Backup

This repository contains automated backup of the `balance-fit-prd` namespace using GitOps methodology with ArgoCD.

## Overview

This backup system provides:
- **Automated daily backups** of all namespace resources
- **GitOps deployment** using ArgoCD for infrastructure as code
- **Version control** of all configuration changes
- **Disaster recovery** capabilities

## Repository Structure

```
├── backup/                    # Backup artifacts
│   ├── raw/                   # Raw exported resources
│   ├── cleaned/               # Cleaned resources
│   └── daily/                 # Daily backup snapshots
├── gitops/                    # GitOps manifests
│   ├── base/                  # Base Kustomize resources
│   │   ├── namespace.yaml
│   │   ├── serviceaccount.yaml
│   │   ├── scc-binding.yaml
│   │   └── kustomization.yaml
│   ├── overlays/              # Environment overlays
│   │   └── prd/               # Production overlay
│   │       ├── kustomization.yaml
│   │       └── [resource files]
│   └── argocd-application.yaml
├── scripts/                   # Automation scripts
│   ├── daily-backup.sh        # Daily backup script
│   └── setup-cron.sh          # Cron job setup
└── README.md
```

## Setup

### Initial Setup
The initial setup was completed on Tue, Jul 29, 2025  3:19:00 PM using:
```bash
./backup-namespace-setup.sh
```

**Note**: The setup script creates a local project directory based on the repository name (e.g., `balance-fit`) to organize all backup files. This allows multiple namespace backups to coexist without conflicts.

### Daily Backups
Daily backups are automated using:
```bash
# Navigate to the project directory
cd balance-fit  # (or your repository name)

# Manual run
./scripts/daily-backup.sh

# Setup cron job (runs daily at 2 AM)
./scripts/setup-cron.sh
```

## ArgoCD Deployment

### Deploy the ArgoCD Application
```bash
# Navigate to the project directory
cd balance-fit  # (or your repository name)

# Login to target cluster (if not already logged in)
oc login <your-cluster-url> --token=<your-token>

# Deploy ArgoCD application
oc apply -f gitops/argocd-application.yaml

# Monitor deployment
oc get application balance-fit-prd-backup -n openshift-gitops -w
```

### Verify Deployment
```bash
# Navigate to the project directory (if not already there)
cd balance-fit  # (or your repository name)

# Check application status
oc get application balance-fit-prd-backup -n openshift-gitops

# Check target namespace
oc get all -n balance-fit-prd

# Check ArgoCD logs
oc logs -n openshift-gitops deployment/argocd-application-controller
```

## Monitoring

### ArgoCD UI
Access the ArgoCD UI to monitor sync status:
- Application: `balance-fit-prd-backup`
- Namespace: `openshift-gitops`

### Backup Logs
Daily backup logs are available at:
```bash
# View latest backup log
tail -f /var/log/balance-fit-prd-backup.log

# View backup summaries (from project directory)
cd balance-fit  # (or your repository name)
ls -la backup/daily/
```

## Disaster Recovery

### Restore from Backup
1. Ensure target cluster is accessible
2. Navigate to the project directory: `cd balance-fit` (or your repository name)
3. Deploy ArgoCD application:
   ```bash
   oc apply -f gitops/argocd-application.yaml
   ```
4. ArgoCD will automatically sync and restore all resources

### Manual Restore
If ArgoCD is not available:
```bash
# Navigate to the project directory
cd balance-fit  # (or your repository name)

# Deploy using Kustomize
kubectl apply -k gitops/overlays/prd
```

## Configuration

- **Source Cluster**: Dynamic (detected from current context)
- **Source Namespace**: balance-fit-prd
- **GitHub Repository**: https://github.com/rich-p-ai/kohler-apps.git
- **ArgoCD Namespace**: openshift-gitops

### Authentication Requirements

Before using the backup scripts, ensure you are authenticated to the OpenShift cluster:

```bash
# Login to your OpenShift cluster
oc login <your-cluster-url> --token=<your-token>

# Verify access to the namespace
oc get namespace balance-fit-prd
```

The backup scripts will automatically detect your current cluster context and verify access.

## Support

For issues or questions:
1. Check ArgoCD application status and logs
2. Review daily backup logs
3. Verify cluster connectivity and permissions
4. Check GitHub repository for recent changes

---

**Created**: Tue, Jul 29, 2025  3:19:00 PM  
**Backup System**: Automated GitOps with ArgoCD  
**Update Frequency**: Daily at 2:00 AM
