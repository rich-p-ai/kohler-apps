# Kubernetes Namespace Backup Setup Tools

This repository contains the setup tools and scripts for creating automated backups of Kubernetes namespaces using GitOps methodology with ArgoCD.

## ⚠️ Important Note

This repository contains the **setup tools**, not the actual backup data. When you run the setup script, it creates a separate project directory with its own git repository for the specific namespace backup.

## What's Included

- **`backup-namespace-setup.sh`** - Main setup script that creates backup infrastructure
- **`daily-namespace-backup.sh`** - Standalone daily backup script  
- **`NAMESPACE-BACKUP-README.md`** - Comprehensive documentation
- **Setup tools and templates** for GitOps backup automation

## Quick Start

1. **Run the setup script:**
   ```bash
   ./backup-namespace-setup.sh
   ```

2. **Follow the prompts to configure:**
   - Source namespace to backup
   - GitHub repository URL for the backup
   - Repository name (creates local project directory)

3. **The script will create:**
   - A local project directory named after your repository
   - Complete GitOps structure with ArgoCD configuration
   - Automated backup scripts and cron jobs
   - Separate git repository for the backup project

## Example: balance-fit-prd Namespace

This repository was used to create the `balance-fit-prd` namespace backup:

## Example: balance-fit-prd Namespace

This repository was used to create the `balance-fit-prd` namespace backup:

- **Source Namespace**: balance-fit-prd
- **Backup Repository**: https://github.com/rich-p-ai/kohler-apps.git
- **Project Directory**: `balance-fit-prd/` (excluded from this repo)
- **Setup Date**: Tue, Jul 29, 2025  3:19:00 PM

## Features

This backup system provides:
- **Automated daily backups** of all namespace resources
- **GitOps deployment** using ArgoCD for infrastructure as code
- **Version control** of all configuration changes
- **Disaster recovery** capabilities
- **Multi-namespace support** with organized project directories

## Project Structure Created by Setup

When you run the setup script, it creates this structure:

```
./[repository-name]/           # Project directory (separate git repo)
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
├── .gitignore
└── README.md
```

## Documentation

For detailed setup and usage instructions, see:
- **[NAMESPACE-BACKUP-README.md](NAMESPACE-BACKUP-README.md)** - Complete documentation
- **Project README** - Generated in each backup project directory

## Prerequisites

- OpenShift CLI (`oc`) installed and configured
- `kubectl` installed
- `git` installed and configured
- Access to source OpenShift cluster
- ArgoCD installed in target cluster
- GitHub repository with write access

## Authentication

Before running the setup, authenticate to your OpenShift cluster:

```bash
# Login to your OpenShift cluster
oc login <your-cluster-url> --token=<your-token>

# Verify access to the namespace
oc get namespace <your-namespace>
```

## Support

For setup issues or questions:
1. Review the [NAMESPACE-BACKUP-README.md](NAMESPACE-BACKUP-README.md) documentation
2. Check script permissions and prerequisites
3. Verify OpenShift cluster connectivity and authentication
4. Check this repository for updates and issues

For backup operation issues:
1. Check the individual project directory documentation
2. Review ArgoCD application status and logs
3. Verify cluster connectivity and permissions
4. Check the backup project's GitHub repository

## Contributing

To improve these setup tools:
1. Test changes in a development environment
2. Update documentation for any new features
3. Ensure backward compatibility
4. Add appropriate error handling
5. Update this README and documentation

---

**Repository**: Kubernetes Namespace Backup Setup Tools  
**Purpose**: Automated GitOps backup infrastructure creation  
**Version**: 2.0 (with project directory support)  
**Last Updated**: July 29, 2025
