Below is a compilation of subdomain enumeration tools that can be used to discover subdomains associated with a specific domain. The identification of these subdomains can significantly expand the scope of your testing activities and enhance your testing effectiveness.

# Web Link:
https://securitycipher.com/docs/subdomain-enumeration-tools/

|Tools Name	|Description	|URL	|Command|
|:---:|:---:|:---:|:---:|
|subfinder|	Fast passive subdomain enumeration tool.	|https://github.com/projectdiscovery/subfinder	|subfinder -d domain.com -all -silent|
|amass|	In-depth attack surface mapping and asset discovery	|https://github.com/OWASP/Amass	|amass enum -passive -d domain.com|
|Sublist3r|	Fast subdomains enumeration tool for penetration testers	|https://github.com/aboul3la/Sublist3r	|python3 sublist3r.py -d domain.com|
|chaos|	Go client to communicate with Chaos DB API.	|https://github.com/projectdiscovery/chaos-client	|chaos -d domain.com -silent|
|assetfinder|	Find domains and subdomains related to a given domain	|https://github.com/tomnomnom/assetfinder	|assetfinder –subs-only domain.com|
|gau|	Fetch known URLs from AlienVault’s Open Threat Exchange, the Wayback Machine, and Common Crawl.|	https://github.com/lc/gau	gau –subs domain.com | unfurl -u domains|
|github-subdomains|	Find subdomains on GitHub.	|https://github.com/gwen001/github-subdomains	|github-subdomains -d domain.com| 
|findomain|	The fastest and complete solution for domain recognition. Supports screenshoting, port scan, HTTP check, data import from other tools, subdomain monitoring, alerts via Discord, Slack and Telegram, multiple API Keys for sources and much more.	|https://github.com/Findomain/Findomain	|findomain -t domain.com --external-subdomains|
|OneForAll|	OneForAll is a powerful subdomain integration tool	|https://github.com/shmilylty/OneForAll	|python3 oneforall.py --target domain.com run|
|puredns|	Puredns is a fast domain resolver and subdomain bruteforcing tool that can accurately filter out wildcard subdomains and DNS poisoned entries.	|https://github.com/d3mondev/puredns	|puredns bruteforce wordlist.txt domain.com|
|gobuster|	Directory/File, DNS and VHost busting tool written in Go	|https://github.com/OJ/gobuster	|gobuster dns -d domain.com -w wordlist.txt|
|shuffledns|	MassDNS wrapper written in go that allows you to enumerate valid subdomains using active bruteforce as well as resolve subdomains with wildcard handling and easy input-output support.	|https://github.com/projectdiscovery/shuffledns|	shuffledns -d domain.com -w wordlist.txt -r resolvers.txt|
