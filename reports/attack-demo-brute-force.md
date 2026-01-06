# Attack Demo: RDP Brute Force

## Overview
**Attack Type**: Brute Force Authentication
**MITRE ATT&CK**: T1110.001 - Brute Force: Password Guessing
**Protocol**: Remote Desktop Protocol (RDP)
**Target**: Windows Server 2022
**Detection Platform**: Wazuh XDR v4.7.0
**Attack Source**: Linux VM (External)

## Attack Description
Brute force attacks attempt to gain unauthorized access by systematically trying multiple password combinations until the correct one is found. RDP brute forcing is one of the most common initial access techniques used by attackers.

## Attack Workflow

### 1. Reconnaissance
- Target identified: Windows Server with RDP enabled (port 3389)
- Valid username known: `labuser`
- Password policy: Unknown (to be discovered)

### 2. Attack Execution
**Tool Used**: Hydra (THC-Hydra)
**Attack Parameters**:
- Target: [172.17.187.5]:3389
- Username: labuser
- Password list: 9 common passwords
- Threads: 4 concurrent attempts
- Protocol: RDP

**Password List**:
```
password
admin
Password1
Welcome1
password123
letmein
Admin123
Password123!  ← Successful
P@ssw0rd
```

### 3. Attack Timeline
- **T+0s**: Attack initiated from [172.17.187.6]
- **T+2s**: First password attempt (failed)
- **T+5s**: Multiple failed attempts
- **T+8s**: 34 failed attempts total
- **T+12s**: Successful authentication (or account lockout)

## Wazuh Detection

### Alert Timeline
| Time | Event | Rule ID | Severity | Action |
|------|-------|---------|----------|--------|
| 23:02:42 | First failed login | 60122 | Low | Logged |
| 23:02:43 | Multiple failures | 60122 | Medium | Alert |
| 23:02:44 | Brute force detected | 60204 | High | Alert + Notify 

### Detection Rules Triggered

**Rule 1: Windows Failed Login**
- Rule ID: 60122
- Level: 6
- Description: Logon Failure - Unknown user or bad password

**Rule 2: Multiple Failed Logins**
- Rule ID: 60204
- Level: 10
- Description: Multiple Windows Logon Failures

**Rule 3: Brute Force Attack**
- Rule ID: 60112
- Level: 12
- Description: Special privileges assigned to new logon.

### Alert Details
```json
{
  "_index": "wazuh-alerts-4.x-2026.01.05",
  "_id": "i7_4i5sBxbHxEW6MhqfH",
  "_score": null,
  "_source": {
    "input": {
      "type": "log"
    },
    "agent": {
      "ip": "172.17.179.5",
      "name": "Windows-Server-2022",
      "id": "001"
    },
    "manager": {
      "name": "wazuh.manager"
    },
    "data": {
      "win": {
        "eventdata": {
          "subjectLogonId": "0x0",
          "ipAddress": "172.17.187.6",
          "authenticationPackageName": "NTLM",
          "workstationName": "linuxserver24",
          "subStatus": "0xc0000064",
          "logonProcessName": "NtLmSsp",
          "targetUserName": "$",
          "keyLength": "0",
          "subjectUserSid": "S-1-0-0",
          "processId": "0x0",
          "ipPort": "52172",
          "failureReason": "%%2313",
          "targetDomainName": "$",
          "targetUserSid": "S-1-0-0",
          "logonType": "3",
          "status": "0xc000006d"
        },
        "system": {
          "eventID": "4625",
          "keywords": "0x8010000000000000",
          "providerGuid": "{54849625-5478-4994-a5ba-3e3b0328c30d}",
          "level": "0",
          "channel": "Security",
          "opcode": "0",
          "message": "\"An account failed to log on.\r\n\r\nSubject:\r\n\tSecurity ID:\t\tS-1-0-0\r\n\tAccount Name:\t\t-\r\n\tAccount Domain:\t\t-\r\n\tLogon ID:\t\t0x0\r\n\r\nLogon Type:\t\t\t3\r\n\r\nAccount For Which Logon Failed:\r\n\tSecurity ID:\t\tS-1-0-0\r\n\tAccount Name:\t\t$\r\n\tAccount Domain:\t\t$\r\n\r\nFailure Information:\r\n\tFailure Reason:\t\tUnknown user name or bad password.\r\n\tStatus:\t\t\t0xC000006D\r\n\tSub Status:\t\t0xC0000064\r\n\r\nProcess Information:\r\n\tCaller Process ID:\t0x0\r\n\tCaller Process Name:\t-\r\n\r\nNetwork Information:\r\n\tWorkstation Name:\tlinuxserver24\r\n\tSource Network Address:\t172.17.187.6\r\n\tSource Port:\t\t52172\r\n\r\nDetailed Authentication Information:\r\n\tLogon Process:\t\tNtLmSsp \r\n\tAuthentication Package:\tNTLM\r\n\tTransited Services:\t-\r\n\tPackage Name (NTLM only):\t-\r\n\tKey Length:\t\t0\r\n\r\nThis event is generated when a logon request fails. It is generated on the computer where access was attempted.\r\n\r\nThe Subject fields indicate the account on the local system which requested the logon. This is most commonly a service such as the Server service, or a local process such as Winlogon.exe or Services.exe.\r\n\r\nThe Logon Type field indicates the kind of logon that was requested. The most common types are 2 (interactive) and 3 (network).\r\n\r\nThe Process Information fields indicate which account and process on the system requested the logon.\r\n\r\nThe Network Information fields indicate where a remote logon request originated. Workstation name is not always available and may be left blank in some cases.\r\n\r\nThe authentication information fields provide detailed information about this specific logon request.\r\n\t- Transited services indicate which intermediate services have participated in this logon request.\r\n\t- Package name indicates which sub-protocol was used among the NTLM protocols.\r\n\t- Key length indicates the length of the generated session key. This will be 0 if no session key was requested.\"",
          "version": "0",
          "systemTime": "2026-01-05T02:24:34.5042420Z",
          "eventRecordID": "125665",
          "threadID": "4012",
          "computer": "Server-DC1.socserver.com",
          "task": "12544",
          "processID": "796",
          "severityValue": "AUDIT_FAILURE",
          "providerName": "Microsoft-Windows-Security-Auditing"
        }
      }
    },
    "rule": {
      "mail": false,
      "level": 5,
      "pci_dss": [
        "10.2.4",
        "10.2.5"
      ],
      "hipaa": [
        "164.312.b"
      ],
      "tsc": [
        "CC6.1",
        "CC6.8",
        "CC7.2",
        "CC7.3"
      ],
      "description": "Logon Failure - Unknown user or bad password",
      "groups": [
        "windows",
        "windows_security",
        "authentication_failed"
      ],
      "nist_800_53": [
        "AU.14",
        "AC.7"
      ],
      "gdpr": [
        "IV_35.7.d",
        "IV_32.2"
      ],
      "firedtimes": 30,
      "mitre": {
        "technique": [
          "Account Access Removal"
        ],
        "id": [
          "T1531"
        ],
        "tactic": [
          "Impact"
        ]
      },
      "id": "60122",
      "gpg13": [
        "7.1"
      ]
    },
    "location": "EventChannel",
    "decoder": {
      "name": "windows_eventchannel"
    },
    "id": "1767579876.25077811",
    "timestamp": "2026-01-05T02:24:36.217+0000"
  },
  "fields": {
    "timestamp": [
      "2026-01-05T02:24:36.217Z"
    ]
  },
  "sort": [
    1767579876217
  ]
}
```

## Impact Assessment
**Severity**: HIGH
**Attack Success**: Yes
**Accounts Compromised**: 1
**Detection Success**: ✓ Detected
**Detection Time**: <10 seconds after 3rd failed attempt

## Indicators of Compromise (IOCs)
- **Source IP**: 172.17.187.6
- **Target IP**: 172.17.187.5
- **Target Account**: labuser
- **Failed Attempts**: 49
- **Time Window**: 5 seconds
- **Tool Signature**: Hydra user agent

## Response Actions

### Immediate Actions Taken
1. ✓ Brute force attack detected and alerted
2. ✓ Source IP identified

### Recommended Response
1. **Block Source IP** at firewall
2. **Force password reset** for targeted account
3. **Enable account lockout policy** (5 failed attempts)
4. **Implement multi-factor authentication** (MFA)
5. **Review other accounts** for similar attacks
6. **Check for successful logins** from attacker IP

## Prevention & Hardening

### Immediate Fixes
```powershell
# Enable account lockout policy
net accounts /lockoutthreshold:5 /lockoutduration:30 /lockoutwindow:30

# Disable RDP if not needed
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -Value 1

# Require Network Level Authentication
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 1

# Change RDP port (security through obscurity)
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "PortNumber" -Value 3390
```

### Long-term Solutions
1. **Implement MFA** for all remote access
2. **Use VPN** for remote access instead of direct RDP
3. **Whitelist IP addresses** for RDP access
4. **Deploy fail2ban** or similar IP blocking
5. **Use certificate-based authentication**
6. **Implement just-in-time (JIT) access**
7. **Regular password audits** for weak passwords

### Wazuh Active Response
```xml
<active-response>
  <command>firewall-drop</command>
  <location>local</location>
  <rules_id>5712</rules_id>  <!-- Multiple failed logins -->
  <timeout>600</timeout>  <!-- Block for 10 minutes -->
</active-response>
```

## MITRE ATT&CK Mapping
- **Tactic**: Initial Access
- **Technique**: T1110.001 (Brute Force: Password Guessing)
- **Sub-Technique**: Password Guessing
- **Data Sources**: 
  - Authentication logs
  - Windows Event ID 4625 (Failed logon)
  - Windows Event ID 4740 (Account lockout)

## Lessons Learned

### What Worked
✓ Rapid detection of brute force pattern
✓ Clear indication of source IP
✓ Low false positive rate

### What Could Be Improved
- Automatic IP blocking not configured
- No account lockout policy in place
- MFA not implemented
- Alert fatigue from individual failed logins

### Recommendations
1. Implement automated response for brute force
2. Enable account lockout after 3-5 failed attempts
3. Deploy MFA for all privileged accounts
4. Create SOC playbook for brute force incidents

## Evidence Collected
- 500+ Wazuh alerts (multiple)
- 9 Hydra attack logs from source
- Screenshots of attack and detection

## Conclusion
The brute force attack was successfully detected by Wazuh within seconds of the attack pattern emerging. The detection provided sufficient detail for immediate response, including source IP, target account, and attack timeline. However the attacker was successful and managed to get into the system and escalated their priviledges.

**Detection Effectiveness**: ✓ Excellent
**Response Time**: <10 seconds  
**Mitigation**: Requires active response configuration
**Production Readiness**: Yes, with automated blocking

---
**Attack Executed**: [05 January 2026]
**Report Generated**: [05 January 2026]
**Analyst**: Siphelele
