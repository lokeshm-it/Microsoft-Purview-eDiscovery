<#
.SYNOPSIS
    Initiates and monitors a Microsoft Purview eDiscovery search export job.

.DESCRIPTION
    Starts an export of an existing eDiscovery content search result,
    monitors export progress, and retrieves the download URI for the
    export package. Produces an export summary CSV for chain-of-custody
    documentation.

.PARAMETER CaseName
    Name of the eDiscovery case containing the search.

.PARAMETER SearchName
    Name of the content search to export.

.PARAMETER OutputPath
    Directory to save export summary and log files.

.PARAMETER ExportScope
    Scope of items to export:
    BestAvailable - All items (default)
    WithErrors    - Only items with errors
    NotIndexed    - Only unindexed items

.EXAMPLE
    .\Export-eDiscoverySearch.ps1 `
        -CaseName "Finance Investigation" `
        -SearchName "Finance-Emails-June2026" `
        -OutputPath "C:\eDiscoveryExports"

.NOTES
    Author:     Lokesh M
    Version:    1.0
    Date:       2026-07-03
    Requires:   ExchangeOnlineManagement v3.x+
    Role:       eDiscovery Manager or eDiscovery Administrator
    Note:       Download the export package via the compliance portal
                using Microsoft Edge after the export job completes.
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$CaseName,

    [Parameter(Mandatory = $true)]
    [string]$SearchName,

    [Parameter(Mandatory = $false)]
    [string]$OutputPath = "C:\eDiscoveryExports",

    [Parameter(Mandatory = $false)]
    [ValidateSet("BestAvailable", "WithErrors", "NotIndexed")]
    [string]$ExportScope = "BestAvailable"
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

#region Validate Search
Write-Log "Validating search '$SearchName' in case '$CaseName'..."
$search = Get-ComplianceSearch -Case $CaseName -Identity $SearchName -ErrorAction SilentlyContinue

if (-not $search) {
    Write-Log "Search '$SearchName' not found in case '$CaseName'" "ERROR"
    exit 1
}

Write-Log "Search found: $($search.Name)"
Write-Log "  Status        : $($search.Status)"
Write-Log "  Items matched : $($search.Items)"
Write-Log "  Size          : $($search.Size) bytes"

if ($search.Status -ne "Completed") {
    Write-Log "Search is not in Completed status (current: $($search.Status)). Run the search first." "WARNING"
    exit 1
}
#endregion

#region Start Export
$exportName = "${SearchName}-Export-${timestamp}"
Write-Log "Starting export job: '$exportName'..."

try {
    New-ComplianceSearchAction `
        -SearchName $SearchName `
        -Export `
        -ExportType $ExportScope `
        -EnableDedupe $true `
        -IncludeSharePointDocumentVersions $false `
        -NotifyEmail ""
    Write-Log "Export job submitted: $exportName" "SUCCESS"
} catch {
    Write-Log "Export initiation failed: $_" "ERROR"; exit 1
}
#endregion

#region Monitor Export Progress
Write-Log "Monitoring export progress..."
$maxWait   = 60   # Maximum wait in minutes
$waited    = 0
$interval  = 30   # Seconds between status checks

do {
    Start-Sleep -Seconds $interval
    $waited += $interval / 60

    $exportJob = Get-ComplianceSearchAction -Case $CaseName |
        Where-Object { $_.Name -like "*$SearchName*Export*" } |
        Sort-Object CreatedTime -Descending |
        Select-Object -First 1

    if (-not $exportJob) {
        Write-Log "Export job not yet visible — waiting..." "WARNING"
        continue
    }

    Write-Log "Export status: $($exportJob.Status) ($([math]::Round($waited,1)) min elapsed)"

} while ($exportJob.Status -ne "Completed" -and $waited -lt $maxWait)

if ($exportJob.Status -ne "Completed") {
    Write-Log "Export did not complete within $maxWait minutes. Check compliance portal manually." "WARNING"
} else {
    Write-Log "Export completed successfully" "SUCCESS"
}
#endregion

#region Export Summary
$summaryPath = Join-Path $OutputPath "export-summary-${timestamp}.csv"
[PSCustomObject]@{
    ExportDate    = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
    CaseName      = $CaseName
    SearchName    = $SearchName
    ExportName    = $exportName
    ExportScope   = $ExportScope
    SearchItems   = $search.Items
    SearchSizeGB  = [math]::Round($search.Size / 1GB, 2)
    ExportStatus  = $exportJob.Status
    Note          = "Download package from compliance portal using Microsoft Edge"
} | Export-Csv $summaryPath -NoTypeInformation -Encoding UTF8

Write-Log "Export summary saved: $summaryPath" "SUCCESS"
Write-Log ""
Write-Log "Next step: Download the export package from the compliance portal"
Write-Log "  URL: https://compliance.microsoft.com/ediscovery/cases"
Write-Log "  Browser: USE MICROSOFT EDGE (not Chrome)"
Write-Log "  Navigate to: Case → Searches → $SearchName → Actions → Download export"
