<#
.SYNOPSIS
    Retrieves all Microsoft Purview eDiscovery cases and their configuration.

.DESCRIPTION
    Lists all eDiscovery cases in the tenant with status, creation date,
    case members, associated searches, and hold counts. Useful for periodic
    case inventory, compliance audits, and investigation tracking.
    Exports results to CSV and JSON.

.PARAMETER OutputPath
    Directory for exported reports. Default: C:\eDiscoveryReports

.PARAMETER IncludeSearches
    If specified, retrieves all content searches within each case.

.PARAMETER IncludeHolds
    If specified, retrieves hold policies associated with each case.

.PARAMETER GenerateHtmlReport
    If specified, generates an HTML summary report.

.EXAMPLE
    .\Get-eDiscoveryCases.ps1 -OutputPath "C:\eDiscoveryReports" -IncludeSearches

.EXAMPLE
    .\Get-eDiscoveryCases.ps1 -GenerateHtmlReport -OutputPath "C:\Reports"

.NOTES
    Author:     Lokesh M
    Version:    1.0
    Date:       2026-07-03
    Requires:   ExchangeOnlineManagement v3.x+
    Role:       eDiscovery Manager or eDiscovery Administrator
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$OutputPath = "C:\eDiscoveryReports",

    [Parameter(Mandatory = $false)]
    [switch]$IncludeSearches,

    [Parameter(Mandatory = $false)]
    [switch]$IncludeHolds,

    [Parameter(Mandatory = $false)]
    [switch]$GenerateHtmlReport
)

#region Helpers
function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $ts = Get-Date -Format "HH:mm:ss"
    $col = switch ($Level) { "SUCCESS" { "Green" } "WARNING" { "Yellow" } "ERROR" { "Red" } default { "Cyan" } }
    Write-Host "[$ts] [$Level] $Message" -ForegroundColor $col
}
#endregion

#region Setup
if (-not (Test-Path $OutputPath)) { New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null }
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"

try {
    $conn = Get-ConnectionInformation -ErrorAction SilentlyContinue
    if (-not $conn) { Connect-IPPSSession }
} catch { Write-Log "Connection failed: $_" "ERROR"; exit 1 }
#endregion

#region Retrieve Cases
Write-Log "Retrieving eDiscovery cases..."
$cases = Get-ComplianceCase -CaseType eDiscovery -ErrorAction Stop
Write-Log "Found $($cases.Count) case(s)" "SUCCESS"

$caseReport = foreach ($case in $cases) {
    $members = try { (Get-ComplianceCaseMember -Case $case.Name).Name -join ', ' } catch { "N/A" }
    $searches = 0
    $holds    = 0

    if ($IncludeSearches) {
        $searches = try { (Get-ComplianceSearch -Case $case.Name -ErrorAction SilentlyContinue).Count } catch { 0 }
    }
    if ($IncludeHolds) {
        $holds = try { (Get-CaseHoldPolicy -Case $case.Name -ErrorAction SilentlyContinue).Count } catch { 0 }
    }

    [PSCustomObject]@{
        CaseName    = $case.Name
        Status      = $case.Status
        CreatedBy   = $case.CreatedBy
        CreatedDate = $case.CreatedDateTime
        Members     = $members
        Searches    = $searches
        Holds       = $holds
        Description = $case.Description
    }
}
#endregion

#region Export CSV
$csvPath = Join-Path $OutputPath "ediscovery-cases-${timestamp}.csv"
$caseReport | Export-Csv $csvPath -NoTypeInformation -Encoding UTF8
Write-Log "Cases exported: $csvPath" "SUCCESS"

$jsonPath = Join-Path $OutputPath "ediscovery-cases-${timestamp}.json"
$caseReport | ConvertTo-Json -Depth 5 | Out-File $jsonPath -Encoding UTF8
Write-Log "JSON exported: $jsonPath" "SUCCESS"
#endregion

#region HTML Report
if ($GenerateHtmlReport) {
    $htmlPath = Join-Path $OutputPath "ediscovery-cases-report-${timestamp}.html"
    $rows = ($caseReport | ForEach-Object {
        $statusColor = if ($_.Status -eq "Active") { "#22c55e" } else { "#fbbf24" }
        "<tr><td>$($_.CaseName)</td><td style='color:$statusColor'>$($_.Status)</td><td>$($_.CreatedDate.ToString('yyyy-MM-dd'))</td><td>$($_.Members)</td><td>$($_.Searches)</td><td>$($_.Holds)</td></tr>"
    }) -join "`n"

    @"
<!DOCTYPE html><html><head><meta charset='UTF-8'>
<title>eDiscovery Cases Report</title>
<style>
  body{font-family:Segoe UI,sans-serif;background:#0d1b2a;color:#c8dff0;padding:32px}
  h1{color:#f0f6ff}
  .meta{color:#7fa8d0;font-size:12px;margin-bottom:20px}
  table{width:100%;border-collapse:collapse}
  th{background:#0078D4;color:#fff;padding:10px 14px;text-align:left}
  td{padding:9px 14px;border-bottom:1px solid #1e3a5f;font-size:13px}
  tr:hover td{background:rgba(0,120,212,.08)}
</style></head><body>
<h1>Microsoft Purview eDiscovery — Cases Report</h1>
<p class='meta'>Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') | Total Cases: $($cases.Count)</p>
<table><thead><tr><th>Case Name</th><th>Status</th><th>Created</th><th>Members</th><th>Searches</th><th>Holds</th></tr></thead>
<tbody>$rows</tbody></table>
</body></html>
"@ | Out-File $htmlPath -Encoding UTF8
    Write-Log "HTML report: $htmlPath" "SUCCESS"
}
#endregion

Write-Log "Case inventory complete. $($cases.Count) case(s) exported to $OutputPath"
