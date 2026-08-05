# Enterprise Windows Infrastructure Project

> End-to-end Windows Server infrastructure deployment featuring Active Directory, PowerShell automation, Group Policy, enterprise file services, and infrastructure validation.

![Enterprise Architecture](architecture/AD%20Diagram.png)

---

# Project Overview

This project demonstrates the design, deployment, automation, validation, and troubleshooting of a Windows enterprise infrastructure using **Windows Server 2022**, **Active Directory Domain Services (AD DS)**, **PowerShell**, **Group Policy**, and **VMware Workstation Pro**.

Rather than building isolated lab exercises, this environment was developed as a complete enterprise deployment that mirrors real-world systems administration workflows. The project emphasizes infrastructure design, identity management, automation, security, centralized administration, validation, and troubleshooting through a World Cup 2026–themed organizational scenario.

---

# Lab Environment

| Component | Technology |
|-----------|------------|
| Hypervisor | VMware Workstation Pro |
| Server | Windows Server 2022 |
| Client | Windows 11 Pro |
| Domain | `jblab.local` |
| Directory Services | Active Directory Domain Services |
| Automation | PowerShell |
| Identity | Active Directory |
| File Services | SMB |
| Security | NTFS + RBAC |
| Policy | Group Policy |

---

# Enterprise Architecture

The enterprise architecture was designed before implementation to establish the relationship between the Windows Server, Active Directory, PowerShell automation, Group Policy, file services, and Windows client.

![Enterprise Architecture](architecture/AD%20Diagram.png)

---

# Project Chapters

This repository documents the project in the same order the infrastructure was implemented.

## 1. Active Directory

Enterprise Organizational Unit (OU) design, domain structure, security groups, and identity organization.

📁 `images/active-directory`

---

## 2. PowerShell Automation

PowerShell scripts used to automate:

- Organizational Unit creation
- User provisioning
- Coach provisioning
- Security Group creation
- SMB share creation
- Permission assignment

📁 `images/powershell`

---

## 3. Enterprise File Services

Implementation of SMB file shares including:

- Folder hierarchy
- Share creation
- Share validation
- Client accessibility

📁 `images/file-services`

---

## 4. NTFS Permissions

Role-Based Access Control using NTFS permissions and Active Directory Security Groups.

📁 `images/NTFS`

---

## 5. Coach Administration

Automated provisioning of coach accounts demonstrating delegated administration and role-based identity management.

📁 `images/coach-administration`

---

## 6. Group Policy

Enterprise policy deployment including:

- Desktop wallpaper deployment
- Drive Mapping
- Item-Level Targeting
- Group Policy Preferences

📁 `images/Group-Policy`

---

## 7. Enterprise Validation

Validation from the Windows client perspective confirming:

- Domain authentication
- Group Policy processing
- Drive mapping
- SMB access
- User-targeted configuration

📁 `images/enterprise-validation`

---

## 8. Enterprise Troubleshooting

Documentation of real implementation issues encountered throughout the project, including root-cause analysis, remediation, and validation.

Topics include:

- Storage path issues
- SMB share troubleshooting
- Permission troubleshooting
- PowerShell error analysis

📁 `images/enterprise-troubleshooting`

---

# Technologies Used

- Windows Server 2022
- Windows 11 Pro
- Active Directory Domain Services
- DNS
- PowerShell
- VMware Workstation Pro
- SMB File Services
- NTFS Permissions
- Group Policy
- CSV Automation

---

# Skills Demonstrated

- Enterprise Windows Administration
- Active Directory Administration
- Windows Server Administration
- Infrastructure Automation
- PowerShell Scripting
- Identity & Access Management
- Role-Based Access Control (RBAC)
- Group Policy Management
- SMB File Services
- NTFS Permissions
- Enterprise Troubleshooting
- Technical Documentation

---

# Repository Structure

```text
enterprise-windows-infrastructure-project
│
├── architecture/
├── csv/
├── docs/
├── images/
│   ├── active-directory/
│   ├── coach-administration/
│   ├── enterprise-troubleshooting/
│   ├── enterprise-validation/
│   ├── file-services/
│   ├── group-policy/
│   ├── ntfs/
│   └── powershell/
└── scripts/
```

---

# Future Enhancements

Planned future expansions include:

- Microsoft Entra ID Hybrid Identity
- Azure AD Connect
- Microsoft Intune
- Microsoft Defender for Endpoint
- Windows Server Certificate Services
- Microsoft Sentinel
- DFS Namespace & Replication

---

# Author

**Jameel B**

Systems Administrator focused on enterprise Windows infrastructure, identity management, automation, and modern endpoint administration.

This repository represents a hands-on enterprise infrastructure project built to strengthen practical systems engineering skills through design, implementation, automation, validation, and troubleshooting.
