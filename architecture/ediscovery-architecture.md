# Microsoft Purview eDiscovery — Architecture Diagrams

## Diagram 1 — Enterprise eDiscovery Architecture

```mermaid
flowchart TB
    subgraph Sources["📡 Microsoft 365 Data Sources"]
        EXO["📧 Exchange Online\nMailboxes · Calendar · Contacts\nDeleted Items · Recoverable Items"]
        SPO["📁 SharePoint Online\nDocument Libraries · Lists\nSite Pages · Version History"]
        ODB["☁️ OneDrive for Business\nUser Files · Shared Folders\nRecycle Bin Items"]
        TMS["💬 Microsoft Teams\nChannel Messages · Private Chats\nMeeting Recordings · Shared Files"]
    end

    subgraph Case["📋 eDiscovery Case Container"]
        direction TB
        CASE["Case: Finance Investigation\nCreated: 2026-07-03\nStatus: Active\nRole: eDiscovery Manager"]
        SEARCH["Content Searches\nKQL Queries\nData Source Scope"]
        HOLD["Case Holds\nPreservation Policies\n(Standard: limited)"]
        EXPORT["Export Jobs\nEvidence Packages\nChain-of-Custody"]
    end

    subgraph Delivery["📦 Evidence Delivery"]
        PST["PST Files\nExchange Email"]
        LOOSE["Loose Files\nSharePoint · OneDrive\nTeams Content"]
        MANIFEST["Manifest + Results.csv\nChain-of-Custody\nExport Summary"]
    end

    EXO --> SEARCH
    SPO --> SEARCH
    ODB --> SEARCH
    TMS --> SEARCH
    CASE --> SEARCH
    CASE --> HOLD
    SEARCH --> EXPORT
    EXPORT --> PST
    EXPORT --> LOOSE
    EXPORT --> MANIFEST

    style Sources fill:#0d1b2a,stroke:#1e3a5f,color:#c8dff0
    style Case fill:#112240,stroke:#0078D4,color:#f0f6ff
    style Delivery fill:#0d2a1a,stroke:#22c55e,color:#c8dff0
```

---

## Diagram 2 — Investigation Workflow

```mermaid
flowchart TD
    A["🚨 Legal / Compliance Request\nAll finance emails and documents\nRequired within 48 hours"] --> B["Navigate to\ncompliance.microsoft.com\n→ Solutions → eDiscovery"]
    B --> C["Assign eDiscovery Manager Role\nto investigator account"]
    C --> D["Create Case\nFinance Investigation\n+ description"]
    D --> E["Add Data Sources\nExchange · SharePoint\nOneDrive · Teams"]
    E --> F["Build KQL Search Query\nKeywords · Sender · Date · FileType"]
    F --> G["Execute Search\nRun query across all sources"]
    G --> H{"Results\nSatisfactory?"}
    H -->|Refine needed| F
    H -->|Sufficient| I["Review Results\nItem count · Data size\nBreakdown by source"]
    I --> J["Export Results\nUsing Microsoft Edge"]
    J --> K["Deliver Evidence Package\nto Legal / Compliance Team"]
    K --> L["Document Investigation\nAudit log + export summary\nChain-of-custody hash"]

    style A fill:#1e0d0d,stroke:#ef4444,color:#f0f6ff
    style L fill:#0d2a1a,stroke:#22c55e,color:#4ade80
```

---

## Diagram 3 — Content Search Flow

```mermaid
flowchart LR
    A["👤 Investigator\nConfigures search\nin eDiscovery case"] --> B["KQL Query Engine\nParsed query:\nfrom: · subject: · received: · filetype:"]
    B --> C{"Scope\nSelection"}
    C -->|Mailboxes| D["📧 Exchange\nAudit + Active Mailbox\nRecoverable Items"]
    C -->|Sites| E["📁 SharePoint\nDocument Libraries\nSite Collections"]
    C -->|OneDrive| F["☁️ OneDrive\nPersonal Files\nShared Items"]
    C -->|Teams| G["💬 Teams\nChannel + Chat\nShared Files"]
    D --> H["📊 Search Results\nEstimated Items\nEstimated Size\nPer-Source Breakdown"]
    E --> H
    F --> H
    G --> H
    H --> I{"Action"}
    I -->|Export| J["📦 Export Package\nPST + Loose Files\n+ Manifest"]
    I -->|Refine| B

    style A fill:#0d1b2a,stroke:#1e3a5f,color:#c8dff0
    style H fill:#112240,stroke:#0078D4,color:#f0f6ff
    style J fill:#0d2a1a,stroke:#22c55e,color:#4ade80
```

---

## Diagram 4 — Evidence Export Process

```mermaid
flowchart TB
    subgraph Trigger["⚖️ Export Trigger"]
        T1["Legal team requests evidence package"]
        T2["Regulatory audit response required"]
        T3["HR investigation — export for legal review"]
    end

    subgraph Config["⚙️ Export Configuration"]
        E1["Select export scope\n• All items (BestAvailable)\n• Exclude unindexed\n• Unindexed only"]
        E2["Enable deduplication\n(avoids duplicate emails)"]
        E3["Include SharePoint versions\n(optional)"]
    end

    subgraph Package["📦 Export Package Contents"]
        P1["PST Files\nExchange email content"]
        P2["Loose Files\nSharePoint · OneDrive · Teams"]
        P3["Export Summary.txt\nItem counts + sizes"]
        P4["Results.csv\nPer-item metadata"]
        P5["Manifest.xml\nPackage structure"]
        P6["Error.csv\nFailed/unindexed items"]
    end

    subgraph Custody["🔐 Chain of Custody"]
        C1["Hash export package\nSHA-256"]
        C2["Store in access-controlled\nevidence location"]
        C3["Document: search name,\ndate, item count, export ID"]
    end

    Trigger --> Config --> Package --> Custody

    style Trigger fill:#1e1e0d,stroke:#f59e0b,color:#f0f6ff
    style Config fill:#0d1b2a,stroke:#0078D4,color:#f0f6ff
    style Package fill:#112240,stroke:#a78bfa,color:#f0f6ff
    style Custody fill:#0d2a1a,stroke:#22c55e,color:#f0f6ff
```
