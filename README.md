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

### Daily Backups
Daily backups are automated using:
```bash
# Manual run
./scripts/daily-backup.sh

# Setup cron job (runs daily at 2 AM)
./scripts/setup-cron.sh
```

## ArgoCD Deployment

### Deploy the ArgoCD Application
```bash
# Login to target cluster (if not already logged in)
oc login <your-cluster-url> --token=<your-token>

# Deploy ArgoCD application
oc apply -f gitops/argocd-application.yaml

# Monitor deployment
oc get application balance-fit-prd-backup -n openshift-gitops -w
```

### Verify Deployment
```bash
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

# View backup summaries
ls -la backup/daily/
```

## Disaster Recovery

### Restore from Backup
1. Ensure target cluster is accessible
2. Deploy ArgoCD application:
   ```bash
   oc apply -f gitops/argocd-application.yaml
   ```
3. ArgoCD will automatically sync and restore all resources

### Manual Restore
If ArgoCD is not available:
```bash
# Deploy using Kustomize
kubectl apply -k gitops/overlays/prd
```

## Configuration

- **Source Cluster**: https://api.ocp-prd.kohlerco.com:6443
- **Source Namespace**: balance-fit-prd
- **GitHub Repository**: https://github.com/rich-p-ai/kohler-apps.git
- **ArgoCD Namespace**: openshift-gitops

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
