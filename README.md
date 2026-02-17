# 🔐 Linux SSH Log Analyzer

A Bash-based defensive security tool that analyzes SSH authentication logs to detect brute-force attacks and suspicious login activity on Linux systems.

---

## 📌 Project Overview

This tool simulates a basic Security Operations Center (SOC) monitoring workflow by parsing SSH logs and identifying potentially malicious behavior using configurable thresholds.

It automates detection of:

- Failed SSH login attempts
- Suspicious IP addresses
- Brute-force attack patterns
- Successful authentication events
- Security report generation

---

## 🚀 Features

- 🔍 Counts failed SSH login attempts
- 🛡 Detects suspicious IPs exceeding threshold
- ✅ Counts successful logins
- 📊 Displays top attacking IP addresses
- 📝 Generates timestamped security reports
- 🎨 Colored terminal output
- ⚙ Custom brute-force threshold support

---

## 🛠 Technologies Used

- Bash Scripting
- journalctl
- grep
- awk
- sort / uniq
- Linux SSH logging system

---

## ⚙ Installation

Clone the repository:

```bash
git clone https://github.com/angel71004/Linux-SSH-Log-Analyzer.git
cd Linux-SSH-Log-Analyzer
chmod +x log_analyzer.sh
