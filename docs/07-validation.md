# Validation — eDiscovery Implementation Test Cases

## Test Case Results

### TC-ED-01 — eDiscovery Portal Access

| Field | Value |
|---|---|
| Test Case ID | TC-ED-01 |
| Description | eDiscovery solution accessible at compliance.microsoft.com |
| Steps | Navigate to Solutions → eDiscovery → Standard |
| Expected Result | eDiscovery solutions menu and cases list visible |
| Actual Result | eDiscovery (Standard) accessible; cases list loads successfully |
| Screenshot | `images/01-overview/01-ediscovery-solutions-menu.png` |
| Result | ✅ Pass |

---

### TC-ED-02 — Case Creation

| Field | Value |
|---|---|
| Test Case ID | TC-ED-02 |
| Description | Finance Investigation case created with name and description |
| Steps | Create a case → Enter Case Name and Description → Create |
| Expected Result | Case creation form accepts input and submits |
| Actual Result | Case form accepted "Finance Investigation" + description; submitted successfully |
| Screenshots | `images/02-create-case/01-ediscovery-cases-page.png`, `images/02-create-case/02-create-case-form.png` |
| Result | ✅ Pass |

---

### TC-ED-03 — Case Visible in Cases List

| Field | Value |
|---|---|
| Test Case ID | TC-ED-03 |
| Description | Finance Investigation case appears in eDiscovery cases list |
| Steps | After creation, verify case appears in the cases list with Active status |
| Expected Result | Case visible with correct name and status |
| Actual Result | Finance Investigation case visible in cases list with Active status |
| Screenshot | `images/02-create-case/03-case-created-list.png` |
| Result | ✅ Pass |

---

### TC-ED-04 — Data Sources Configured

| Field | Value |
|---|---|
| Test Case ID | TC-ED-04 |
| Description | Exchange Online, SharePoint Online, OneDrive, and Teams added as search data sources |
| Steps | Open case → New search → Add sources → Select all four workloads |
| Expected Result | All four M365 data sources available and selectable |
| Actual Result | Exchange Online, SharePoint Online, OneDrive, Teams all selectable in the data source panel |
| Screenshots | `images/04-content-search/01-add-sources-button.png`, `images/04-content-search/02-data-source-selection.png` |
| Result | ✅ Pass |

---

### TC-ED-05 — KQL Search Query Executed

| Field | Value |
|---|---|
| Test Case ID | TC-ED-05 |
| Description | KQL search query configured using Condition Builder and executed |
| Steps | Configure keyword and condition filters → Run query |
| Expected Result | Search executes against configured data sources |
| Actual Result | Search query accepted with conditions (keyword, sender, date, file type); query executed successfully |
| Screenshot | `images/04-content-search/03-search-condition-builder.png` |
| Result | ✅ Pass |

---

### TC-ED-06 — Search Results Reviewed

| Field | Value |
|---|---|
| Test Case ID | TC-ED-06 |
| Description | Search results page displays estimated item count and data size |
| Steps | After search execution, review results summary |
| Expected Result | Results page shows item count, data size, and per-source breakdown |
| Actual Result | Search completed; 0 matching items returned (expected in test tenant with limited sample data). Results page confirmed accessible. |
| Screenshot | `images/04-content-search/04-search-results.png` |
| Result | ✅ Pass |

---

### TC-ED-07 — Export Screen Accessible

| Field | Value |
|---|---|
| Test Case ID | TC-ED-07 |
| Description | Export screen accessible from search results |
| Steps | From search results → Select Export Results |
| Expected Result | Export configuration screen loads with export options |
| Actual Result | Export screen accessible with output options (All items / Exclude unindexed / Unindexed only) |
| Screenshot | `images/06-export-results/01-export-screen.png` |
| Result | ✅ Pass |

---

## Validation Summary

| Test Case | Description | Result |
|---|---|---|
| TC-ED-01 | eDiscovery portal accessible | ✅ Pass |
| TC-ED-02 | Finance Investigation case created | ✅ Pass |
| TC-ED-03 | Case visible in cases list | ✅ Pass |
| TC-ED-04 | Four data sources configured | ✅ Pass |
| TC-ED-05 | KQL search query executed | ✅ Pass |
| TC-ED-06 | Search results reviewed (0 items — test tenant) | ✅ Pass |
| TC-ED-07 | Export screen accessed | ✅ Pass |

**Total: 7/7 Pass ✅**
