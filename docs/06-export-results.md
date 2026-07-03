# Export eDiscovery Search Results

## Overview

After reviewing search results, investigators initiate an export to package the content for legal team delivery. The export produces a structured evidence package containing the matched content, a manifest file, and export statistics.

---

## Export Process

### Step 1: Initiate Export

From the search results view, select **Export Results** (or **Export** button).

![Export Screen](../images/06-export-results/01-export-screen.png)

### Step 2: Configure Export Options

| Option | Description |
|---|---|
| All items including those with unrecognized format, encrypted, or unindexed | Maximum coverage — includes all items regardless of indexing status |
| Items excluding unrecognized format / encrypted / unindexed | Standard export — well-indexed, readable content only |
| Only items with unrecognized format, encrypted, or unindexed | Supplemental export for items excluded from main export |

### Step 3: Download Export Package

> **Browser Requirement:** Use **Microsoft Edge** for export download. The eDiscovery export function uses browser integration that may not function correctly in Google Chrome depending on tenant configuration.

The export package is downloaded to the investigator's local machine and contains:
- **PST files** — Email content (Exchange Online)
- **Loose files** — Documents, Teams exports, OneDrive content
- **Export summary** — Statistics file with item counts and sizes
- **Results log** — CSV file with per-item details
- **Manifest** — XML describing the package contents

---

## Export Package Contents

| File | Description |
|---|---|
| `*.pst` | Exchange Online emails in Outlook PST format |
| `Non-PST files/` | SharePoint, OneDrive, and Teams content |
| `Export Summary.txt` | High-level export statistics |
| `Results.csv` | Row per item with metadata (subject, sender, date, path) |
| `Manifest.xml` | Full package manifest for legal chain-of-custody |
| `Error.csv` | Items that could not be exported (if any) |

---

## Evidence Handling Best Practices

| Practice | Rationale |
|---|---|
| Hash the export package (SHA-256) | Establishes integrity baseline for chain-of-custody |
| Store in access-controlled location | Restrict access to named investigators and legal counsel |
| Document export parameters | Record search name, date, item count, and export ID |
| Do not modify export contents | Any modification breaks chain-of-custody |
| Retain until case is closed | Do not delete export packages while matter is active |

---

## Deleted Content — What eDiscovery Can Recover

eDiscovery searches the Recoverable Items folder in Exchange Online:

| Content State | eDiscovery Access |
|---|---|
| Active mailbox items | ✅ Always searchable |
| Soft-deleted emails (Deleted Items) | ✅ Searchable within retention window |
| Hard-deleted emails (Recoverable Items) | ✅ Searchable within retention window |
| Permanently purged items | ❌ Not recoverable |
| SharePoint version history | ✅ Searchable |
| OneDrive deleted files (Recycle Bin) | ✅ Searchable within retention window |

> This is a common MS-102 exam scenario: eDiscovery can surface soft-deleted emails that users have moved to Deleted Items or permanently deleted, provided they are still within the mailbox retention window.
