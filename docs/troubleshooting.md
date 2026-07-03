# Troubleshooting — Microsoft Purview eDiscovery

## Common Issues and Resolutions

### Issue 1: eDiscovery Not Visible in Compliance Portal

**Symptom:** The eDiscovery option is missing from the Solutions menu.

**Cause:** User does not have the eDiscovery Manager or eDiscovery Administrator role.

**Resolution:**
1. Navigate to `compliance.microsoft.com → Permissions → Roles`
2. Select **eDiscovery Manager**
3. Add the investigator account as a member
4. Wait up to 60 minutes for propagation
5. Sign out and sign back in

> Global Administrator does not grant eDiscovery access automatically.

---

### Issue 2: Cannot Create a Case

**Symptom:** The **Create a case** button is greyed out or returns a permissions error.

**Cause:** Account lacks eDiscovery Manager role or Compliance Administrator role.

**Resolution:**
```powershell
# Add user to eDiscovery Manager role group
Add-RoleGroupMember -Identity "eDiscovery Manager" -Member "investigator@yourtenant.onmicrosoft.com"
```

---

### Issue 3: Search Returns 0 Results (Expected in Test Environments)

**Symptom:** Content search executes successfully but returns 0 matching items.

**Cause A:** Newly provisioned test tenant with no user activity — no emails, documents, or Teams messages exist to match.

**Resolution:** This is expected. The search configuration is correct. In production environments with real user data, results will populate based on search criteria.

**Cause B:** Search conditions are too restrictive.

**Resolution:** Broaden the search by removing sender and file type conditions. Search using keyword only first, then narrow iteratively.

---

### Issue 4: Export Button Does Not Respond / Export Fails

**Symptom:** Clicking Export Results produces no response or the download never starts.

**Cause:** Browser incompatibility — eDiscovery export uses browser integration that does not reliably work in Google Chrome.

**Resolution:** Switch to Microsoft Edge. The eDiscovery export function is designed for and tested with Microsoft Edge.

---

### Issue 5: Cannot Access Another Investigator's Case

**Symptom:** Case exists but a second investigator cannot open it.

**Cause:** The second investigator is not a case member and is not an eDiscovery Administrator.

**Resolution:**
1. Open the case as the case creator (or eDiscovery Administrator)
2. Select **Settings → Access & permissions**
3. Add the second investigator's account as a case member
