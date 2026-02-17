#!/bin/bash

# ==============================
#   Linux Log Analyzer Tool
# ==============================

# ---------- CONFIG ----------
THRESHOLD=${1:-5}   # Default threshold = 5
REPORT_DIR="reports"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
REPORT_FILE="$REPORT_DIR/log_report_$TIMESTAMP.txt"

# ---------- COLORS ----------
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

echo -e "${GREEN}==============================${RESET}"
echo -e "${GREEN}   Linux Log Analysis Tool${RESET}"
echo -e "${GREEN}==============================${RESET}"
echo ""

echo -e "${YELLOW}Brute-force threshold set to: $THRESHOLD${RESET}"
echo ""

# Create report directory if not exists
mkdir -p "$REPORT_DIR"

# Collect SSH logs
LOG_DATA=$(sudo journalctl -u ssh --no-pager)

if [ -z "$LOG_DATA" ]; then
    echo -e "${RED}No SSH logs found.${RESET}"
    exit 1
fi

# ---------- FAILED LOGIN COUNT ----------
FAILED_COUNT=$(echo "$LOG_DATA" | grep "Failed password" | wc -l)
echo -e "${YELLOW}Total Failed Login Attempts: $FAILED_COUNT${RESET}"
echo ""

# ---------- SUCCESSFUL LOGIN COUNT ----------
SUCCESS_COUNT=$(echo "$LOG_DATA" | grep "Accepted password" | wc -l)
echo -e "${GREEN}Total Successful Logins: $SUCCESS_COUNT${RESET}"
echo ""

# ---------- TOP ATTACKING IPs ----------
echo -e "${YELLOW}Top Attacking IPs:${RESET}"

TOP_IPS=$(echo "$LOG_DATA" | grep "Failed password" | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr)

if [ -z "$TOP_IPS" ]; then
    echo "No attacking IPs detected."
else
    echo "$TOP_IPS" | head -5
fi

echo ""

# ---------- SUSPICIOUS IP DETECTION ----------
echo -e "${RED}Suspicious IPs (Attempts > $THRESHOLD):${RESET}"

SUSPICIOUS_FOUND=false

if [ -n "$TOP_IPS" ]; then
    while read count ip; do
        if [[ "$count" =~ ^[0-9]+$ ]] && [ "$count" -gt "$THRESHOLD" ]; then
            echo -e "${RED}$ip - $count attempts${RESET}"
            SUSPICIOUS_FOUND=true
        fi
    done <<< "$TOP_IPS"
fi

if [ "$SUSPICIOUS_FOUND" = false ]; then
    echo -e "${GREEN}No suspicious IPs detected.${RESET}"
fi

# ---------- REPORT GENERATION ----------
{
echo "=============================="
echo " Linux Log Analysis Report"
echo "=============================="
echo "Timestamp: $(date)"
echo ""
echo "Brute-force Threshold: $THRESHOLD"
echo ""
echo "Total Failed Login Attempts: $FAILED_COUNT"
echo "Total Successful Logins: $SUCCESS_COUNT"
echo ""
echo "Top Attacking IPs:"
if [ -n "$TOP_IPS" ]; then
    echo "$TOP_IPS"
else
    echo "No attacking IPs detected."
fi
echo ""
echo "Suspicious IPs (Attempts > $THRESHOLD):"
if [ -n "$TOP_IPS" ]; then
    while read count ip; do
        if [[ "$count" =~ ^[0-9]+$ ]] && [ "$count" -gt "$THRESHOLD" ]; then
            echo "$ip - $count attempts"
        fi
    done <<< "$TOP_IPS"
else
    echo "None"
fi
} > "$REPORT_FILE"

echo ""
echo -e "${GREEN}Report saved to: $REPORT_FILE${RESET}"



