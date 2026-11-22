# Daily Automation & Reconnaissance Scripts

A collection of lightweight shell workflows, one-liners, and automated tools commonly used in daily penetration testing and bug bounty reconnaissance.

---

## 1. Included Helper: `auto-recon.sh`

This repository includes [`content/auto-recon.sh`](auto-recon.sh), an automated reconnaissance script designed to kickstart subdomain and DNS mapping for a target domain.

### Usage
```bash
chmod +x content/auto-recon.sh
./content/auto-recon.sh example.com
```

### What it does
- Creates an organized project directory structure (`recon_example.com/`).
- Runs passive subdomain enumeration using `subfinder`, `assetfinder`, `amass`, and `chaos`.
- Deduplicates and sorts all discovered subdomains.
- Performs DNS resolution and zone transfers check using `dnsenum`.

---

## 2. Essential Bug Bounty CLI One-Liners

### Subdomain Enumeration & Live HTTP Probing
```bash
# Find subdomains and filter immediately for live HTTP/HTTPS services
subfinder -d target.com -silent | httpx -silent -status-code -title -tech-detect -o live_targets.txt
```

### Fast Parameter Discovery & URL Gathering
```bash
# Gather historic URLs from AlienVault, Wayback Machine, and CommonCrawl
echo target.com | gau --threads 5 | uro | grep "=" | sort -u > parameters.txt
```

### Secret & API Key Hunting in Discovered JavaScript Files
```bash
# Extract all JavaScript files and search for sensitive tokens
cat live_targets.txt | katana -d 3 -em js -silent | while read url; do
    echo "Scanning: $url"
    curl -s -L "$url" | grep -E -i "(api_key|apikey|secret|token|aws_secret|bearer|password)"
done
```

### Rapid Directory & Endpoint Fuzzing
```bash
# High-speed recursive fuzzing with ffuf
ffuf -u https://target.com/FUZZ -w /path/to/raft-medium-directories.txt -mc 200,301,302,403 -c -v
```

### Quick CORS Misconfiguration Check
```bash
# Check if target reflects arbitrary Origin headers
curl -s -I -H "Origin: https://evil.com" https://target.com/api/user | grep -i "Access-Control-Allow-Origin: https://evil.com"
```

---
*For a complete curriculum and tooling guide, see the [Penetration Testing Roadmap](https://securitycipher.com/penetration-testing-roadmap).*
