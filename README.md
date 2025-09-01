# FileIntegrity

This project is a File Integrity Monitoring tool built in PowerShell to detect unauthorized changes to files and directories.
It continuously scans and prints real-time updates (every ~3–5 seconds) in the terminal whenever files are modified, deleted, or newly created.
The goal is to simulate enterprise-style security monitoring, giving hands-on experience in cyber defense and SOC operations.

# 🛡️ File Integrity Monitoring System

A powershell based tool that helps detect unauthorized changes to files and directories — a common
requirement in cybersecurity, SOC operations, and compliance frameworks (e.g., PCI-DSS, HIPAA).

---

## 🚀 Features
- ✅ Baseline Hashing: Creates cryptographic hashes (SHA-256) of files to establish a trusted baseline.  
- ✅ Change Detection: Flags modifications, deletions, or newly created files.  
- ✅ Configurable: Monitor specific directories and files of interest.  
- ✅ Lightweight & Extensible: Easy to adapt for integration with SIEM or alerting systems.  

---

##  Why I Built It

As part of my journey into cybersecurity, I wanted to understand how real-world systems detect tampering—compliant
with security best practices like those used in SIEMs and enterprise FIMs :contentReference[oaicite:0]{index=0}. This 
tool helped me get hands-on experience monitoring integrity at the file system level.

##  Technical Highlights

- Language & Stack: PowerShell
- Alerting Mechanism: Reports detected changes via console output; ideal foundation for SIEM or automated response integration.
- Extensible: Can be expanded with logging to files, email notifications, or SIEM integration.  


---

## 📂 Usage
Clone the repo and run the monitor:
```bash
git clone https://github.com/aayushpandey06/FileIntegrity.git
cd FileIntegrity
python integrity_monitor.py
