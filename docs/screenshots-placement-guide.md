# Screenshots Placement Guide

## Confirmed Screenshots (9 PNG files)

All screenshots were extracted from the source blog as real Microsoft Purview eDiscovery portal screenshots and converted from AVIF to PNG.

---

### A.1 — eDiscovery Solutions Menu

| Field | Value |
|---|---|
| Filename | `01-overview/01-ediscovery-solutions-menu.png` |
| Source | compliance.microsoft.com → Solutions menu with eDiscovery visible |
| Content | Solutions menu showing eDiscovery option |
| Used In | README Phase 1, docs/01-overview.md |
| HTML Section | Implementation Timeline |
| Phase | Phase 1 |

### A.2 — eDiscovery Cases Page

| Field | Value |
|---|---|
| Filename | `02-create-case/01-ediscovery-cases-page.png` |
| Source | eDiscovery (Standard) cases list with Create a Case button |
| Content | Cases list page with Create a case button visible |
| Used In | README Phase 2, docs/02-create-case.md |
| HTML Section | Implementation Screenshots |
| Phase | Phase 2 |

### A.3 — Create Case Form

| Field | Value |
|---|---|
| Filename | `02-create-case/02-create-case-form.png` |
| Source | Create case form with "Finance Investigation" entered |
| Content | Case name = Finance Investigation, description entered |
| Used In | README Phase 2, docs/02-create-case.md |
| HTML Section | Implementation Screenshots |
| Phase | Phase 2 |

### A.4 — Case Created — Cases List

| Field | Value |
|---|---|
| Filename | `02-create-case/03-case-created-list.png` |
| Source | eDiscovery cases list with Finance Investigation visible |
| Content | Finance Investigation case in Active status |
| Used In | README Phase 2, docs/02-create-case.md |
| HTML Section | Implementation Screenshots |
| Phase | Phase 2 |

### A.5 — Add Sources Button

| Field | Value |
|---|---|
| Filename | `04-content-search/01-add-sources-button.png` |
| Source | Case content with Add sources button visible |
| Content | Search creation with Add sources button |
| Used In | README Phase 3, docs/03-add-custodians.md |
| HTML Section | Implementation Screenshots |
| Phase | Phase 3 |

### A.6 — Data Source Selection Panel

| Field | Value |
|---|---|
| Filename | `04-content-search/02-data-source-selection.png` |
| Source | Data source selection panel showing Exchange, SharePoint, OneDrive, Teams |
| Content | Four M365 workloads available for selection |
| Used In | README Phase 3, docs/03-add-custodians.md |
| HTML Section | Implementation Screenshots |
| Phase | Phase 3 |

### A.7 — Search Condition Builder

| Field | Value |
|---|---|
| Filename | `04-content-search/03-search-condition-builder.png` |
| Source | KQL search condition builder with conditions configured |
| Content | Keyword search + condition filters configured |
| Used In | README Phase 4, docs/04-content-search.md |
| HTML Section | Implementation Screenshots |
| Phase | Phase 4 |

### A.8 — Search Results

| Field | Value |
|---|---|
| Filename | `04-content-search/04-search-results.png` |
| Source | Search results page after query execution |
| Content | Search results (0 items — test tenant); export button visible |
| Used In | README Phase 5, docs/04-content-search.md |
| HTML Section | Implementation Screenshots |
| Phase | Phase 5 |

### A.9 — Export Screen

| Field | Value |
|---|---|
| Filename | `06-export-results/01-export-screen.png` |
| Source | Export results configuration screen |
| Content | Export options: all items, excluding unindexed, unindexed only |
| Used In | README Phase 6, docs/06-export-results.md |
| HTML Section | Implementation Screenshots |
| Phase | Phase 6 |

---

## Screenshot Summary

| Ref | Filename | Folder | Status |
|---|---|---|---|
| A.1 | 01-ediscovery-solutions-menu.png | 01-overview/ | ✅ Extracted |
| A.2 | 01-ediscovery-cases-page.png | 02-create-case/ | ✅ Extracted |
| A.3 | 02-create-case-form.png | 02-create-case/ | ✅ Extracted |
| A.4 | 03-case-created-list.png | 02-create-case/ | ✅ Extracted |
| A.5 | 01-add-sources-button.png | 04-content-search/ | ✅ Extracted |
| A.6 | 02-data-source-selection.png | 04-content-search/ | ✅ Extracted |
| A.7 | 03-search-condition-builder.png | 04-content-search/ | ✅ Extracted |
| A.8 | 04-search-results.png | 04-content-search/ | ✅ Extracted |
| A.9 | 01-export-screen.png | 06-export-results/ | ✅ Extracted |

**Total: 9 screenshots extracted | 9 PNG files | 0 missing**

---

## Move Instructions

Downloaded files have `__` subfolder encoding. Move each to the correct location:

| Downloaded Filename | Destination |
|---|---|
| `01-overview__01-ediscovery-solutions-menu.png` | `images/01-overview/01-ediscovery-solutions-menu.png` |
| `02-create-case__01-ediscovery-cases-page.png` | `images/02-create-case/01-ediscovery-cases-page.png` |
| `02-create-case__02-create-case-form.png` | `images/02-create-case/02-create-case-form.png` |
| `02-create-case__03-case-created-list.png` | `images/02-create-case/03-case-created-list.png` |
| `04-content-search__01-add-sources-button.png` | `images/04-content-search/01-add-sources-button.png` |
| `04-content-search__02-data-source-selection.png` | `images/04-content-search/02-data-source-selection.png` |
| `04-content-search__03-search-condition-builder.png` | `images/04-content-search/03-search-condition-builder.png` |
| `04-content-search__04-search-results.png` | `images/04-content-search/04-search-results.png` |
| `06-export-results__01-export-screen.png` | `images/06-export-results/01-export-screen.png` |

### PowerShell Move Script

```powershell
$downloads = "$env:USERPROFILE\Downloads"
$repo = "C:\Back\SOP-ZTs\Microsoft 365 Infrastructure Portfolio\Microsoft-Purview-eDiscovery\images"

$map = @{
    "01-overview__01-ediscovery-solutions-menu.png"              = "01-overview\01-ediscovery-solutions-menu.png"
    "02-create-case__01-ediscovery-cases-page.png"               = "02-create-case\01-ediscovery-cases-page.png"
    "02-create-case__02-create-case-form.png"                    = "02-create-case\02-create-case-form.png"
    "02-create-case__03-case-created-list.png"                   = "02-create-case\03-case-created-list.png"
    "04-content-search__01-add-sources-button.png"               = "04-content-search\01-add-sources-button.png"
    "04-content-search__02-data-source-selection.png"            = "04-content-search\02-data-source-selection.png"
    "04-content-search__03-search-condition-builder.png"         = "04-content-search\03-search-condition-builder.png"
    "04-content-search__04-search-results.png"                   = "04-content-search\04-search-results.png"
    "06-export-results__01-export-screen.png"                    = "06-export-results\01-export-screen.png"
}

foreach ($file in $map.Keys) {
    $src = Join-Path $downloads $file
    $dst = Join-Path $repo $map[$file]
    if (Test-Path $src) {
        Move-Item $src $dst -Force
        Write-Host "Moved: $file" -ForegroundColor Green
    } else {
        Write-Warning "Not found: $file"
    }
}
```
