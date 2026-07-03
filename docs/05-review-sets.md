# Review Sets

## Overview

Review Sets are an eDiscovery Premium feature that provides a curated, static collection of content collected from a search. Unlike direct search results (which are dynamic), Review Sets allow legal teams to apply tags, annotations, and attorney–client privilege markers to content before production.

> **Not validated during this implementation.** This repository documents eDiscovery Standard. Review Sets require eDiscovery Premium (Microsoft 365 E5 or Purview Compliance Add-On).

---

## eDiscovery Premium Review Set Capabilities

The following capabilities are available in eDiscovery Premium and are documented here for reference:

| Feature | Description |
|---|---|
| Add to Review Set | Copy search results into a static, reviewable collection |
| Tag Content | Apply custom tags (Responsive, Privileged, Not Responsive) |
| Attorney-Client Privilege | Mark content for privilege review before production |
| Near-Duplicate Detection | Identify and group near-duplicate documents |
| Email Threading | Group emails into conversation threads for context |
| Advanced Analytics | Themes, relevance scoring, predictive coding |
| Annotation | Apply redactions and highlighting |
| Export from Review Set | Export only tagged, reviewed content |

---

## Upgrade Path

To enable Review Sets in this tenant:

1. Assign Microsoft 365 E5 or the Purview Compliance Add-On to relevant investigator accounts
2. Navigate to compliance.microsoft.com → Settings → eDiscovery Premium
3. Re-open the Finance Investigation case
4. Run the content search and select **Add to Review Set** instead of direct export

---

## Standard vs Premium — Practical Difference

In eDiscovery Standard, after search execution investigators review the estimated results count and export directly. There is no intermediate review layer.

In eDiscovery Premium, investigators add results to a Review Set, perform legal review (privilege, responsiveness), and export only the reviewed and tagged subset — producing a more defensible evidence package.
