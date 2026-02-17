# 🔐 Linux Log Analyzer

A Bash-based security monitoring tool that analyzes SSH authentication logs to detect brute-force attacks and suspicious login activity.

## 🚀 Features

- Detects failed SSH login attempts
- Identifies suspicious IP addresses based on threshold
- Counts successful logins
- Generates automated timestamped security reports
- Supports customizable brute-force threshold
- Colored terminal output

## 🛠 Technologies Used

- Bash Scripting
- journalctl
- grep, awk, sort, uniq
- Linux SSH logging system

## ⚙ Usage

Default threshold (5 attempts):

