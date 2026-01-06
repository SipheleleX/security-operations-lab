# Security Operations Lab - Wazuh XDR & Nessus

> A comprehensive security operations center (SOC) lab demonstrating vulnerability assessment, threat detection, and incident response using Wazuh XDR, Nessus, and MITRE ATT&CK framework.

[![Video Demo](https://img.shields.io/badge/Video-Demo-red?style=for-the-badge&logo=youtube)](https://youtu.be/uBauC0E4XIk)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=for-the-badge&logo=linkedin)](https://www.linkedin.com/in/siphelele-x-929a45267/)

##  Project Overview

This project simulates a real-world security operations environment where vulnerabilities are discovered, exploited in a controlled manner, and detected in real-time using enterprise security tools.

**Key Achievements:**
-  Discovered 50+ vulnerabilities using Nessus Essentials
-  100% attack detection rate across 10+ MITRE ATT&CK techniques
-  Real-time alerting with <10 second detection time
-  Complete MITRE ATT&CK framework mapping
-  Professional incident documentation and remediation guidance

##  Architecture
```
┌─────────────────────────────────────────┐
│         Linux VM (Ubuntu 24.04)         │
│  ┌────────────┐      ┌──────────────┐  │
│  │   Wazuh    │      │    Nessus    │  │
│  │    XDR     │      │  Essentials  │  │
│  │  (Docker)  │      │   (Native)   │  │
│  │            │      │              │  │
│  │ • Manager  │      │ • Scanner    │  │
│  │ • Indexer  │      │ • Reporting  │  │
│  │ • Dashboard│      │              │  │
│  └────────────┘      └──────────────┘  │
└─────────────────┬───────────────────────┘
                  │
                  │ Monitors & Attacks
                  ↓
      ┌───────────────────────────┐
      │  Windows Server 2022      │
      │  (10GB RAM)               │
      │                           │
      │  • Wazuh Agent            │
      │  • Sysmon v15             │
      │  • Intentionally Vuln.    │
      │  • Attack Target          │
      └───────────────────────────┘
```

##  Technology Stack

| Component | Technology | Version | Purpose |
|-----------|-----------|---------|---------|
| **SIEM/XDR** | Wazuh | 4.7.0 | Threat detection & response |
| **Vulnerability Scanner** | Nessus Essentials | 10.7.0 | Vulnerability assessment |
| **Endpoint Monitoring** | Sysmon | 15.0 | Deep Windows telemetry |
| **Attack Tools** | Hydra, PowerShell | Latest | Attack simulation |
| **Container Platform** | Docker | 24.x | Service orchestration |
| **Operating Systems** | Ubuntu 24.04, Windows Server 2022 | Latest | Lab environment |

##  Video Demonstration

[**Watch the Full Demo →**](https://youtu.be/uBauC0E4XIk)

**Video Highlights:**
- Live attack execution and detection
- Real-time Wazuh alert correlation
- MITRE ATT&CK technique mapping
- Professional incident analysis

##  Attack Scenarios Tested

### 1. RDP Brute Force Attack
- **MITRE ATT&CK**: T1110.001 (Brute Force: Password Guessing)
- **Tool**: Hydra
- **Detection**: ✅ Detected in <15 seconds
- **Severity**: HIGH
- **[Full Report →](reports/attack-demo-brute-force.md)**

### 2. Lateral Movement via WMI
- **MITRE ATT&CK**: T1047 (Windows Management Instrumentation), T1021 (Remote Services)
- **Techniques**: WMI queries, share enumeration, remote execution testing
- **Detection**: ✅ Detected in <10 seconds
- **Severity**: HIGH
- **[Full Report →](reports/attack-demo-lateral-movement.md)**

### Additional Scenarios Available:
- Credential Access (Mimikatz simulation)
- Persistence (Registry Run Keys, Scheduled Tasks)
- Defense Evasion (Log clearing, security disabling)
- Discovery (Network reconnaissance)
- Data Staging (Exfiltration preparation)

##  Vulnerability Assessment

**Nessus Scan Results:**
- **Critical**: 5-10 vulnerabilities
- **High**: 10-20 vulnerabilities
- **Medium**: 20-30 vulnerabilities
- **Total**: 50-100+ findings

**Key Vulnerabilities:**
- SMBv1 enabled (EternalBlue - CVE-2017-0144)
- Weak credential policy
- Missing security patches
- Disabled security features
- Unnecessary services enabled

**[Full Nessus Report →](reports/nessus/)**

##  Detection Statistics

| Metric | Result |
|--------|--------|
| Total Attacks Simulated | 10+ |
| Attacks Detected | 10 (100%) |
| Average Detection Time | <10 seconds |
| False Positives | 0 |
| MITRE ATT&CK Coverage | 12 techniques across 6 tactics |

##  Quick Start

### Prerequisites
- Ubuntu 24.04 or similar Linux distribution
- Docker and Docker Compose installed
- 8GB RAM minimum (16GB recommended)
- Windows Server 2022 (for agent monitoring)

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/SipheleleX/security-operations-lab.git
cd security-operations-lab
```

2. **Deploy Wazuh (Docker)**
```bash
cd wazuh
docker-compose up -d
```

3. **Install Nessus**
```bash
cd ../nessus
sudo dpkg -i Nessus-*.deb
sudo systemctl start nessusd
```

4. **Access Services**
- Wazuh Dashboard: `https://localhost:443` (admin/admin)
- Nessus: `https://localhost:8834`

### Running Attack Simulations

**Linux (Brute Force):**
```bash
cd attack-scripts
./rdp-brute-force-demo.sh
```

**Windows (Lateral Movement):**
```powershell
Set-ExecutionPolicy Bypass -Scope Process
C:\SecurityLab\Demo\lateral-movement-demo.ps1
```

##  Project Structure
```
security-operations-lab/
├── README.md
├── wazuh/
│   └── docker-compose.yml
├── nessus/
│   └── installation files
├── attack-scripts/
│   ├── rdp-brute-force-demo.sh
│   └── comprehensive-attacks.ps1
├── reports/
│   ├── attack-demo-brute-force.md
│   ├── attack-demo-lateral-movement.md
│   └── nessus/
│       └── vulnerability-report.pdf
├── screenshots/
│   ├── wazuh-dashboard.png
│   ├── nessus-results.png
│   └── mitre-attack-mapping.png
└── documentation/
    └── setup-guide.md
```

##  Skills Demonstrated

### Technical Skills
- ✅ SIEM/XDR administration (Wazuh)
- ✅ Vulnerability assessment (Nessus)
- ✅ Penetration testing basics
- ✅ Windows security monitoring
- ✅ Docker containerization
- ✅ Linux system administration
- ✅ PowerShell scripting
- ✅ Bash scripting
- ✅ Network security
- ✅ Incident response

### Security Frameworks
- ✅ MITRE ATT&CK framework
- ✅ Cyber Kill Chain
- ✅ NIST Cybersecurity Framework
- ✅ CIS Controls

### Soft Skills
- ✅ Technical documentation
- ✅ Incident analysis
- ✅ Risk assessment
- ✅ Report writing
- ✅ Problem-solving

##  Documentation

- **[Brute Force Attack Report](reports/attack-demo-brute-force.md)** - Detailed analysis of RDP brute force attack
- **[Lateral Movement Report](reports/attack-demo-lateral-movement.md)** - WMI-based lateral movement analysis
- **[Nessus Vulnerability Report](reports/nessus/)** - Complete vulnerability assessment
- **[Setup Guide](documentation/setup-guide.md)** - Detailed installation instructions

##  MITRE ATT&CK Coverage

**Tactics Covered:**
- Initial Access (T1110)
- Execution (T1059, T1047)
- Persistence (T1547, T1053)
- Privilege Escalation
- Defense Evasion (T1070, T1562)
- Credential Access (T1003)
- Discovery (T1018, T1082, T1033, T1135)
- Lateral Movement (T1021)
- Collection
- Exfiltration

##  Remediation Implemented

**Hardening Applied:**
- Account lockout policy configured
- MFA recommendations documented
- Firewall rules implemented
- Security monitoring enhanced
- Incident response playbooks created

##  Future Enhancements

- [ ] Integrate TheHive for case management
- [ ] Add SOAR capabilities with Shuffle
- [ ] Implement automated response rules
- [ ] Add threat intelligence feeds (MISP)
- [ ] Expand to cloud security monitoring (AWS/Azure)
- [ ] Add malware analysis sandbox
- [ ] Implement EDR solution (Velociraptor)

##  Contact

**Siphelele Xaba**
- LinkedIn: [Your LinkedIn Profile]([YOUR_LINKEDIN](https://www.linkedin.com/in/siphelele-x-929a45267/))
- Email: siphelelexaba71@icloud.com
- GitHub: [@SipheleleX](https://github.com/SipheleleX)

##  License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

##  Acknowledgments

- Wazuh team for excellent open-source XDR platform
- Tenable for Nessus Essentials
- SwiftOnSecurity for Sysmon configuration
- MITRE for ATT&CK framework
- Cybersecurity community for guidance and resources

---
