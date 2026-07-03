# Microsoft Purview eDiscovery — Overview

## What Is Microsoft Purview eDiscovery?

Microsoft Purview eDiscovery enables organizations to search, collect, review, and export Microsoft 365 content in response to legal requests, HR investigations, security incidents, and regulatory audits. All investigation activities are organized within named cases, providing a structured, auditable workflow.

eDiscovery searches across:

| Workload | Content Types Searched |
|---|---|
| Exchange Online | Emails, attachments, calendar items, contacts |
| SharePoint Online | Documents, lists, site pages |
| OneDrive for Business | Files, folders, shared content |
| Microsoft Teams | Channel messages, chats, meeting recordings, shared files |
| Microsoft 365 Groups | Group mailboxes, SharePoint sites |

---

## Why eDiscovery Matters

Without a centralized investigation tool, administrators must log into Exchange, SharePoint, OneDrive, and Teams separately — a process that takes days, produces inconsistent results, and risks missing evidence stored in a secondary workload. eDiscovery eliminates this gap by providing a unified search interface, structured case management, and exportable evidence packages.

Common investigation scenarios:

- **Legal Investigations** — Legal team requests all documents related to a contract dispute
- **HR Investigations** — HR requires all communications between two employees over a 6-month period
- **Security Incidents** — Security team needs all emails containing a specific attachment or link
- **Regulatory Audits** — Regulator requests evidence that specific data governance controls are operating
- **Data Breach Response** — Identify what data was accessed by a potentially compromised account

---

## eDiscovery Standard vs eDiscovery Premium

| Feature | eDiscovery Standard | eDiscovery Premium |
|---|---|---|
| Cases | ✅ | ✅ |
| Content Search | ✅ | ✅ |
| KQL Query Language | ✅ | ✅ |
| Export Results | ✅ | ✅ |
| Custodian Management | ❌ | ✅ |
| Review Sets | ❌ | ✅ |
| Advanced Analytics | ❌ | ✅ |
| Legal Hold (advanced) | Limited | ✅ |
| Intelligent Tagging | ❌ | ✅ |
| Licensing | E3, E5, Business Premium | E5 / Purview Compliance Add-On |

> **This implementation uses eDiscovery Standard.** Custodian Management, Review Sets, and Advanced Analytics (eDiscovery Premium features) were not validated during this lab.

---

## Licensing Requirements

| License | eDiscovery Capability |
|---|---|
| Microsoft 365 Business Basic | Content Search only |
| Microsoft 365 E3 | eDiscovery Standard |
| Microsoft 365 E5 | eDiscovery Standard + Premium |
| Microsoft Purview Compliance Add-On | eDiscovery Premium |

---

## Required Roles

| Role | Permission |
|---|---|
| eDiscovery Manager | Create and manage cases, run searches, export |
| eDiscovery Administrator | Full eDiscovery administration across all cases |
| Compliance Administrator | Broad compliance portal access |

> **Important:** Global Administrators are **not** automatically granted the eDiscovery Manager role. This must be explicitly assigned via compliance.microsoft.com → Permissions → Roles.

---

## Navigation

Access Microsoft Purview eDiscovery at:

```
https://compliance.microsoft.com
→ Solutions → eDiscovery → Standard
```
