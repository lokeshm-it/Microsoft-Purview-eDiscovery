<#
.SYNOPSIS
    Creates a new Microsoft Purview eDiscovery (Standard) case.

.DESCRIPTION
    Creates an eDiscovery case with the specified name and description,
    then optionally adds case members. Connects to the Security and
    Compliance PowerShell endpoint using Connect-IPPSSession.

.PARAMETER CaseName
    Name for the new eDiscovery case. Must be unique within the tenant.

.PARAMETER Description
    Description of the investigation purpose. Used for audit and documentation.

.PARAMETER Members
    Array of UPNs to add as case members (eDiscovery Manager role required).

.PARAMETER HoldName
    If specified, creates an initial preservation hold within the case.

.EXAMPLE
    .\New-eDiscoveryCase.ps1 `
        -CaseName "Finance Investigation" `
        -Description "Investigation of finance-related emails and documents" `
        -Members "investigator@yourtenant.onmicrosoft.com"

.EXAMPLE
    .\New-eDiscoveryCase.ps1 `
        -CaseName "HR-Matter-2026-07" `
        -Description "HR investigation - employee communications review"

.NOTES
    Author:     Lokesh M
    Version:    1.0
    Date:       2026-07-03
    Requires:   ExchangeOnlineManagement v3.x+
    Role:       eDiscovery Manager or eDiscovery Administrator
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$CaseName,

    [Parameter(Mandatory = $false)]
    [string]$Description = "",

    [Parameter(Mandatory = $false)]
    [string[]]$Members,

    [Parameter(Mandatory = $false)]
    [string]$HoldName
)

#region Helpers
function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $ts = Get-Date -Format "HH:mm:ss"
    $col = switch ($Level) { "SUCCESS" { "Green" } "WARNING" { "Yellow" } "ERROR" { "Red" } default { "Cyan" } }
    Write-Host "[$ts] [$Level] $Message" -ForegroundColor $col
}
#endregion

#region Connect
Write-Log "Connecting to Security and Compliance PowerShell..."
try {
    $conn = Get-ConnectionInformation -ErrorAction SilentlyContinue
    if (-not $conn) { Connect-IPPSSession }
    Write-Log "Connected successfully" "SUCCESS"
} catch {
    Write-Log "Connection failed: $_" "ERROR"; exit 1
}
#endregion

#region Check for Existing Case
Write-Log "Checking if case '$CaseName' already exists..."
$existingCase = Get-ComplianceCase -Identity $CaseName -ErrorAction SilentlyContinue

if ($existingCase) {
    Write-Log "Case '$CaseName' already exists (Status: $($existingCase.Status))" "WARNING"
    Write-Log "Skipping creation. Use existing case or choose a different name."
    exit 0
}
#endregion

#region Create Case
Write-Log "Creating eDiscovery case: '$CaseName'..."
try {
    $newCase = New-ComplianceCase -Name $CaseName -Description $Description -CaseType eDiscovery
    Write-Log "Case created successfully — ID: $($newCase.Identity)" "SUCCESS"
    Write-Log "  Name       : $($newCase.Name)"
    Write-Log "  Status     : $($newCase.Status)"
    Write-Log "  Created    : $($newCase.CreatedDateTime)"
} catch {
    Write-Log "Case creation failed: $_" "ERROR"; exit 1
}
#endregion

#region Add Members
if ($Members) {
    Write-Log "Adding case members..."
    foreach ($member in $Members) {
        try {
            Add-ComplianceCaseMember -Case $CaseName -Member $member
            Write-Log "Added member: $member" "SUCCESS"
        } catch {
            Write-Log "Failed to add member $member : $_" "WARNING"
        }
    }
}
#endregion

#region Create Initial Hold (Optional)
if ($HoldName) {
    Write-Log "Creating initial hold: '$HoldName'..."
    try {
        # Note: Holds require specifying content locations (ExchangeLocation, SharePointLocation)
        # This creates a placeholder hold — add locations after case content sources are identified
        New-CaseHoldPolicy -Name $HoldName -Case $CaseName -Enabled $true
        Write-Log "Hold created: $HoldName" "SUCCESS"
        Write-Log "Note: Add content locations to the hold policy via the compliance portal or Set-CaseHoldPolicy" "WARNING"
    } catch {
        Write-Log "Hold creation failed: $_" "WARNING"
    }
}
#endregion

Write-Log "eDiscovery case setup complete."
Write-Log "Access the case at: https://compliance.microsoft.com/ediscovery/cases"
#endregion
