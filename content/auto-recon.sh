#!/bin/bash


if [ $# -eq 0 ]; then
echo "Usage: $0 <domain>"
exit 1
fi


domain=$1
output_dir="recon_$domain"
mkdir -p $output_dir/{subdomains,ip_addresses,ports,screenshots,content,vulnerabilities,emails,technologies,dns,certificates,scans}


echo "[+] Starting comprehensive reconnaissance and vulnerability scanning for $domain"


# Subdomain enumeration
echo "[+] Enumerating subdomains..."
subfinder -d $domain -o $output_dir/subdomains/subfinder.txt
assetfinder --subs-only $domain > $output_dir/subdomains/assetfinder.txt
amass enum -d $domain -o $output_dir/subdomains/amass.txt
github-subdomains -d $domain -t /path/to/github_token -o $output_dir/subdomains/github_subdomains.txt
chaos -d $domain -o $output_dir/subdomains/chaos.txt
sort -u $output_dir/subdomains/*.txt > $output_dir/subdomains/all_subdomains.txt


# DNS enumeration
echo "[+] Performing DNS enumeration..."
dnsenum $domain --noreverse -o $output_dir/dns/dns_enum.txt
dnsrecon -d $domain -t std,brt -c $output_dir/dns/dnsrecon.csv


# Resolve IP addresses
echo "[+] Resolving IP addresses..."
cat $output_dir/subdomains/all_subdomains.txt | dnsx -a -resp-only -o $output_dir/ip_addresses/resolved_ips.txt


# Reverse DNS lookup
echo "[+] Performing reverse DNS lookup..."
for ip in $(cat $output_dir/ip_addresses/resolved_ips.txt); do
host $ip | awk '{print $5}' >> $output_dir/ip_addresses/reverse_dns.txt
done


# Port scanning
echo "[+] Scanning ports..."
nmap -iL $output_dir/ip_addresses/resolved_ips.txt -p- -sV -sC -oN $output_dir/ports/nmap_full_scan.txt
masscan -iL $output_dir/ip_addresses/resolved_ips.txt -p1-65535 --rate=1000 -oG $output_dir/ports/masscan_results.txt
rustscan -a $output_dir/ip_addresses/resolved_ips.txt --ulimit 5000 -- -sV -sC -oN $output_dir/ports/rustscan_results.txt


# Web probing
echo "[+] Probing for web servers..."
cat $output_dir/subdomains/all_subdomains.txt | httpx -o $output_dir/content/live_subdomains.txt


# WAF detection
echo "[+] Detecting WAF..."
wafw00f -i $output_dir/content/live_subdomains.txt -o $output_dir/content/waf_detection.txt


# Screenshots
echo "[+] Taking screenshots..."
gowitness file -f $output_dir/content/live_subdomains.txt -P $output_dir/screenshots/


# Content discovery
echo "[+] Discovering content..."
for subdomain in $(cat $output_dir/content/live_subdomains.txt); do
ffuf -w /path/to/wordlist.txt -u "https://$subdomain/FUZZ" -mc 200,204,301,302,307,401,403 -o $output_dir/content/ffuf_${subdomain}.json
dirsearch -u "https://$subdomain" -o $output_dir/content/dirsearch_${subdomain}.txt
done


# Vulnerability scanning
echo "[+] Scanning for vulnerabilities..."
nuclei -l $output_dir/content/live_subdomains.txt -o $output_dir/vulnerabilities/nuclei_results.txt
nikto -h $output_dir/content/live_subdomains.txt -output $output_dir/vulnerabilities/nikto_results.txt


# Git exposure check
echo "[+] Checking for exposed .git directories..."
for subdomain in $(cat $output_dir/content/live_subdomains.txt); do
curl -s "https://$subdomain/.git/HEAD" | grep "ref:" && echo "https://$subdomain/.git" >> $output_dir/vulnerabilities/exposed_git.txt
done


# S3 bucket enumeration
echo "[+] Enumerating S3 buckets..."
for subdomain in $(cat $output_dir/subdomains/all_subdomains.txt); do
s3scanner -bucket "$subdomain" >> $output_dir/vulnerabilities/s3_buckets.txt
done


# JavaScript analysis
echo "[+] Analyzing JavaScript files..."
for subdomain in $(cat $output_dir/content/live_subdomains.txt); do
getJS -url "https://$subdomain" --output $output_dir/content/js_files_${subdomain}.txt
cat $output_dir/content/js_files_${subdomain}.txt | grep -Ei "api\.|token|key|secret|password|aws|azure|gcp" >> $output_dir/vulnerabilities/js_secrets_${subdomain}.txt
linkfinder -i "https://$subdomain" -o $output_dir/content/linkfinder_${subdomain}.txt
done


# SSL/TLS analysis
echo "[+] Analyzing SSL/TLS..."
for subdomain in $(cat $output_dir/content/live_subdomains.txt); do
sslyze --regular "$subdomain" >> $output_dir/vulnerabilities/sslyze_results.txt
testssl.sh "$subdomain" >> $output_dir/vulnerabilities/testssl_results.txt
done


# CORS misconfiguration check
echo "[+] Checking for CORS misconfigurations..."
for subdomain in $(cat $output_dir/content/live_subdomains.txt); do
curl -s -I -H "Origin: https://evil.com" "https://$subdomain" | grep -i "Access-Control-Allow-Origin: https://evil.com" && echo "CORS misconfiguration found at https://$subdomain" >> $output_dir/vulnerabilities/cors_misconfig.txt
done


# Technology stack identification
echo "[+] Identifying technology stack..."
for subdomain in $(cat $output_dir/content/live_subdomains.txt); do
whatweb "https://$subdomain" >> $output_dir/technologies/whatweb_results.txt
wappalyzer "https://$subdomain" --pretty >> $output_dir/technologies/wappalyzer_results.json
done


# Email harvesting
echo "[+] Harvesting email addresses..."
theHarvester -d $domain -b all -f $output_dir/emails/theharvester_results.txt


# Subdomain takeover check
echo "[+] Checking for subdomain takeover..."
subjack -w $output_dir/subdomains/all_subdomains.txt -t 100 -timeout 30 -o $output_dir/vulnerabilities/subjack_results.txt -ssl


# DNS zone transfer attempt
echo "[+] Attempting DNS zone transfer..."
for ns in $(dig +short NS $domain); do
dig @$ns $domain AXFR > $output_dir/dns/zone_transfer_${ns}.txt
done


# Certificate transparency logs
echo "[+] Checking certificate transparency logs..."
ct_logs=$(curl -s "https://crt.sh/?q=%.$domain&output=json" | jq -r '.[].name_value' | sort -u)
echo "$ct_logs" > $output_dir/certificates/ct_logs.txt


# Fuzzing for virtual hosts
echo "[+] Fuzzing for virtual hosts..."
for ip in $(cat $output_dir/ip_addresses/resolved_ips.txt); do
ffuf -w $output_dir/subdomains/all_subdomains.txt -u "http://$ip" -H "Host: FUZZ" -fc 404 -o $output_dir/content/vhost_fuzzing_${ip}.json
done


# API endpoint discovery
echo "[+] Discovering API endpoints..."
for subdomain in $(cat $output_dir/content/live_subdomains.txt); do
ffuf -w /path/to/api_wordlist.txt -u "https://$subdomain/FUZZ" -mc 200,201,204,301,302,307,401,403 -o $output_dir/content/api_discovery_${subdomain}.json
done


# Wayback machine crawling
echo "[+] Crawling Wayback Machine..."
waybackurls $domain | sort -u > $output_dir/content/wayback_urls.txt


# SQLi Scanning
echo "[+] Scanning for SQL injection vulnerabilities..."
sqlmap -m $output_dir/content/wayback_urls.txt --batch --random-agent --level 1 --risk 1 -o -report-file $output_dir/vulnerabilities/sqlmap_results.txt


# XSS Scanning
echo "[+] Scanning for XSS vulnerabilities..."
xsser --url "https://$domain" --auto --Cw 3 --Cl 5 --Cs 5 --Cp 5 --CT 5 --threads 10 --output $output_dir/vulnerabilities/xsser_results.xml


# Open redirect scanning
echo "[+] Checking for open redirects..."
cat $output_dir/content/wayback_urls.txt | grep -E '(=|%3D)https?%3A%2F%2F' | qsreplace 'https://evil.com' | httpx -silent -status-code -location -json -o $output_dir/vulnerabilities/open_redirects.json


# SSRF scanning
echo "[+] Scanning for SSRF vulnerabilities..."
cat $output_dir/content/wayback_urls.txt | grep "=" | qsreplace "http://169.254.169.254/latest/meta-data/" | httpx -silent -status-code -json -o $output_dir/vulnerabilities/potential_ssrf.json


# GraphQL introspection
echo "[+] Checking for GraphQL endpoints and introspection..."
for subdomain in $(cat $output_dir/content/live_subdomains.txt); do
graphql-cop -t "https://$subdomain/graphql" -o $output_dir/vulnerabilities/graphql_${subdomain}.json
done


# CRLF injection
echo "[+] Checking for CRLF injection..."
crlfuzz -l $output_dir/content/live_subdomains.txt -o $output_dir/vulnerabilities/crlf_results.txt


# XML external entity (XXE) injection
echo "[+] Scanning for XXE vulnerabilities..."
cat $output_dir/content/live_subdomains.txt | xmlrpcscan -server "collaborator_url.net" > $output_dir/vulnerabilities/xxe_results.txt


# Server-side template injection (SSTI)
echo "[+] Checking for SSTI vulnerabilities..."
cat $output_dir/content/wayback_urls.txt | grep "=" | qsreplace "{{7*7}}" | httpx -silent -status-code -content-length -json -o $output_dir/vulnerabilities/potential_ssti.json


# WebSocket security
echo "[+] Analyzing WebSocket security..."
for subdomain in $(cat $output_dir/content/live_subdomains.txt); do
wscat -c "wss://$subdomain" --execute 'ping' | tee $output_dir/vulnerabilities/websocket_${subdomain}.txt
done


# CORS misconfiguration (extended)
echo "[+] Extended CORS misconfiguration check..."
corscanner -i $output_dir/content/live_subdomains.txt -o $output_dir/vulnerabilities/cors_extended.txt


# HTTP request smuggling
echo "[+] Checking for HTTP request smuggling..."
smuggler -u "https://$domain" -t 20 -o $output_dir/vulnerabilities/http_smuggling.txt


# Web cache poisoning
echo "[+] Scanning for web cache poisoning vulnerabilities..."
cacheblaster -u "https://$domain" -o $output_dir/vulnerabilities/cache_poisoning.txt


# CSTI (Client-Side Template Injection)
echo "[+] Checking for CSTI vulnerabilities..."
csti-scanner -D "https://$domain" -o $output_dir/vulnerabilities/csti_results.txt


echo "[+] Comprehensive reconnaissance and vulnerability scanning completed. Results saved in $output_dir"
