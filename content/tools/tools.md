# Security Tools
Presenting an exhaustive compilation of security tools designed for Bug Bounty hunters and Penetration testers to streamline their day-to-day tasks.

## Tools Category
-  Reconnaissance
-  Web Application Security
-  Mobile Application Security
-  Network Security
-  SAST
-  SCA
-  Cloud Security

# Recon
| Name 	| Description 	    | URL   |
|------	|-------------    	| ------------  |
| rengine | reNgine is a web application reconnaissance suite with focus on a highly configurable streamlined recon process via Engines, recon data correlation, continuous monitoring, recon data backed by a database, and a simple yet intuitive User Interface | https://github.com/yogeshojha/rengine |  


# Proxy Tools
| Name 	| Description 	    | URL   |
|------	|-------------    	| ------------  |
| Burp Suite | Burp Proxy operates as a web proxy server between the browser and target applications. It enables you to intercept, inspect, and modify traffic that passes in both directions. | https://portswigger.net/burp/communitydownload |
| ZAP Proxy | The Zed Attack Proxy (ZAP) is an easy-to-use proxy tool which helps in finding vulnerabilities in web applications. | https://www.zaproxy.org/download/ |
| Caido | A lightweight web security auditing toolkit. | https://caido.io/download |
| Charles Proxy | It enables the user to view HTTP, HTTPS, HTTP/2 and enabled TCP port traffic accessed from, to, or via the local computer. | https://www.charlesproxy.com/download/latest-release/ |

# DAST
| Name 	| Description 	    | URL   |
|------	|-------------    	| ------------  |
| zap-cli | A commandline tool that wraps the OWASP ZAP API for controlling ZAP and executing quick, targeted attacks. | https://github.com/Grunny/zap-cli | 
| Wapti | Wapiti is a web vulnerability scanner written in Python. | https://github.com/wapiti-scanner/wapiti |
| Nuclei | Nuclei is used to send requests across targets based on a template, leading to zero false positives and providing fast scanning on a large number of hosts. | https://github.com/projectdiscovery/nuclei |
| Nikto | web server scanner | https://github.com/sullo/nikto |
| Burp Suite Professional | Burp Suite Professional is the world's most popular tool for web security testing. | https://portswigger.net/burp/pro |
| Arachni | Web Application Security Scanner Framework | https://github.com/Arachni/arachni |
| Dastardly | A free DAST web application scanner for your CI/CD pipeline | https://portswigger.net/burp/dastardly | 

# Mobile Application Security
| Name 	| Description 	    | URL   |
|------	|-------------    	| ------------  |
| Mobile Security Framework (MobSF) | Mobile Security Framework (MobSF) is an automated, all-in-one mobile application (Android/iOS/Windows) pen-testing, malware analysis and security assessment framework capable of performing static and dynamic analysis. MobSF supports mobile app binaries (APK, XAPK, IPA & APPX) along with zipped source code and provides REST APIs for seamless integration with your CI/CD or DevSecOps pipeline.The Dynamic Analyzer helps you to perform runtime security assessment and interactive instrumented testing. | https://github.com/MobSF/Mobile-Security-Framework-MobSF |
| RMS - Runtime Mobile Security | Runtime Mobile Security (RMS), powered by FRIDA, is a powerful web interface that helps you to manipulate Android and iOS Apps at Runtime. With RMS you can easily dump all loaded classes and relative methods, hook everything on the fly, trace methods args and return value, load custom scripts and many other useful stuff. | https://github.com/m0bilesecurity/RMS-Runtime-Mobile-Security |
| Frida | Inject your own scripts into black box processes. Hook any function, spy on crypto APIs or trace private application code, no source code needed. Edit, hit save, and instantly see the results. All without compilation steps or program restarts. | https://github.com/frida/frida |
| Objection | Objection is a runtime mobile exploration toolkit, powered by Frida, built to help you assess the security posture of your mobile applications, without needing a jailbreak. | https://github.com/sensepost/objection |
| jadx | The main features of jadx-gui encompass decompiling Dalvik bytecode into Java classes from various file formats like APK, dex, aar, aab, and zip files, along with decoding AndroidManifest.xml and other resources from resources.arsc. The tool also includes a deobfuscator. The jadx-gui interface offers capabilities such as viewing decompiled code with syntax highlighting, navigating to declarations, finding usages, conducting full-text searches, and even incorporating a smali debugger. | https://github.com/skylot/jadx |
| drozer | drozer allows you to search for security vulnerabilities in apps and devices by assuming the role of an app and interacting with the Dalvik VM, other apps' IPC endpoints and the underlying OS. | https://github.com/WithSecureLabs/drozer |
| apktool | It is a tool for reverse engineering 3rd party, closed, binary Android apps. It can decode resources to nearly original form and rebuild them after making some modifications; it makes possible to debug smali code step by step. Also it makes working with app easier because of project-like files structure and automation of some repetitive tasks like building apk, etc. | https://github.com/iBotPeaches/Apktool |
| apkleaks | Scanning APK file for URIs, endpoints & secrets. | https://github.com/dwisiswant0/apkleaks |

# Cloud Security 
| Name 	| Description 	    |  Supported   |URL   |
|------	|-------------    	| ------------  | ------------  |
| ScoutSuite | Scout Suite is an open source multi-cloud security-auditing tool, which enables security posture assessment of cloud environments. | Amazon Web Services(AWS), Microsoft Azure, Google Cloud Platform (GCP), Alibaba Cloud (alpha), Oracle Cloud Infrastructure (alpha), Kubernetes clusters on a cloud provider (alpha) | https://github.com/nccgroup/ScoutSuite | 
| cloudsploit| CloudSploit by Aqua is an open-source project designed to allow detection of security risks in cloud infrastructure accounts. | Amazon Web Services (AWS), Microsoft Azure, Google Cloud Platform (GCP), Oracle Cloud Infrastructure (OCI), and GitHub. | https://github.com/aquasecurity/cloudsploit |
| Prowler | Prowler is an Open Source security tool to perform AWS, GCP and Azure security best practices assessments, audits, incident response, continuous monitoring, hardening and forensics readiness. |Amazon Web Services(AWS), Microsoft Azure, and Google Cloud Platform (GCP)  | https://github.com/prowler-cloud/prowler |
| ZeusCloud| Effortlessly manage your cloud security with our comprehensive solution. Create a detailed asset inventory across your AWS accounts, uncover potential attack routes using public exposure, IAM, and vulnerabilities, all while effectively prioritizing and tackling issues through visual insights. With clear step-by-step instructions, you can swiftly address findings, and tailor security controls to align with your requirements. Achieve compliance benchmarks such as PCI DSS, CIS, SOC 2, and more seamlessly. | Amazon Sweb Services (AWS)|https://github.com/Zeus-Labs/ZeusCloud |

# SAST
| Name 	| Description 	    | Language Supported   | URL   |
|------	|-------------    	| ------------  | ------------  |
| SpotBugs | SpotBugs is a program which uses static analysis to look for bugs in Java code.  | Java | https://github.com/spotbugs/spotbugs | 
| SonarQube Community Edition| Designed to detect and fix a wide range of code issues that can lead to bugs and security vulnerabilities, Sonar supports over 30 programming languages and frameworks. | 30+ languages | https://github.com/SonarSource/sonarqube | 
| Semgrep | Semgrep is a fast, open source static analysis tool for finding bugs, detecting vulnerabilities in third-party dependencies, and enforcing code standards. | 30+ Languages | https://github.com/returntocorp/semgrep |
| nodejsscan | Static security code scanner (SAST) for Node.js applications | Node.js | https://github.com/ajinabraham/nodejsscan |
| Bandit | Bandit is a tool designed to find common security issues in Python code.  | Python | https://github.com/PyCQA/bandit| 
| gosec|  Golang security checker  | Golang | https://github.com/securego/gosec |
| flawfinder | a static analysis tool for finding vulnerabilities in C/C++ source code | C/C++ | https://github.com/david-a-wheeler/flawfinder | 
| security-code-scan | Static code analyzer for .NET | .NET |  https://github.com/security-code-scan/security-code-scan | 
| phpcs-security-audit | phpcs-security-audit is a set of PHP_CodeSniffer rules that finds vulnerabilities and weaknesses related to security in PHP code | PHP | https://github.com/FloeDesignTechnologies/phpcs-security-audit |
| Brakeman | Brakeman is a static analysis tool which checks Ruby on Rails applications for security vulnerabilities. | Ruby | https://github.com/presidentbeef/brakeman | 

# SCA
| Name 	| Description 	    | URL   |
|------	|-------------    	| ------------  |
| Dependency-Check | OWASP dependency-check is a software composition analysis utility that detects publicly disclosed vulnerabilities in application dependencies. | https://github.com/jeremylong/DependencyCheck |
| osv-scanner | Use OSV-Scanner to find existing vulnerabilities affecting your project's dependencies. | https://github.com/google/osv-scanner |
| Syny | Find and automatically fix vulnerabilities in your code, open source dependencies, containers, and IaC | https://github.com/snyk/cli |

# Other
| Name 	| Description 	    | URL   |
|------	|-------------    	| ------------  |
| requestcatcher | equest Catcher will create a subdomain on which you can test an application. All requests sent to any path on the subdomain are forwarded to your browser in real time. | https://requestcatcher.com/ | 
| SecLists | It's a collection of multiple types of lists used during security assessments, collected in one place | https://github.com/danielmiessler/SecLists |
| AssetNote Wordlist| Collection of Wordlist  | https://wordlists.assetnote.io/ | 
| faraday | Open Source Vulnerability Management Platform | https://github.com/infobyte/faraday |
