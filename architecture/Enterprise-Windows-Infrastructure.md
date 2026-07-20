# Enterprise Windows Infrastructure Architecture

## Overview

This project simulates an enterprise Windows infrastructure using a World Cup-themed business scenario. The environment demonstrates enterprise identity management, infrastructure automation, centralized administration, and Windows security concepts.

---

## Infrastructure

```
VMware Workstation Pro
│
├── DC01 (Windows Server 2022)
│   ├── Active Directory Domain Services
│   ├── DNS
│   ├── Organizational Units
│   ├── Security Groups (RBAC)
│   ├── SMB File Shares
│   ├── NTFS Permissions
│   └── Group Policy
│
└── Windows 11 Client
    ├── Domain Authentication
    ├── Drive Mapping
    ├── Team Wallpapers
    └── File Share Access
```

---

## Automation

PowerShell scripts automate deployment of:

- Organizational Units
- Users
- Coaches
- Featured Players
- Security Groups
- SMB Shares
- NTFS Permissions

CSV files provide structured input for automated provisioning.

---

## Core Technologies

- Windows Server 2022
- Windows 11
- Active Directory Domain Services
- DNS
- Group Policy
- PowerShell
- SMB
- NTFS
- Role-Based Access Control (RBAC)

---

## Enterprise Concepts Demonstrated

- Identity Management
- Infrastructure Automation
- Centralized Administration
- File Services
- Windows Security
- Least Privilege
- Group Policy Management
- Enterprise Troubleshooting

---

## Future Enhancements

- Microsoft Entra ID
- Azure AD Connect
- Microsoft Intune
- Microsoft Defender
- Microsoft Sentinel
- Hybrid Identity
