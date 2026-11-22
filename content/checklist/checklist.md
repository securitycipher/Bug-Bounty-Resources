# Bug Bounty & Web Security Testing Checklist

A practical, phase-by-phase security testing checklist designed for reconnaissance, attack surface mapping, vulnerability hunting, and report validation.

For deep enterprise checklists covering 17 categories (Kubernetes, AWS, Azure, GCP, Active Directory, LLMs, CI/CD, and APIs), visit the **[Security Checklists Hub](https://github.com/securitycipher/security-checklists)**.

---

## Phase 1: Reconnaissance & Asset Discovery

- [ ] **Root Domain & ASN Enumeration**: Identify all registered ASNs, CIDR prefixes, and organizational acquisitions.
- [ ] **Subdomain Enumeration**:
  - Passive discovery: `subfinder -d target.com`, `amass enum -passive -d target.com`, crt.sh certificate transparency logs.
  - Active brute-forcing: `puredns bruteforce wordlist.txt target.com -r resolvers.txt`.
  - Permutations & Alterations: `altdns`, `dnsgen`.
- [ ] **Port Scanning & Service Probing**:
  - Fast port detection: `naabu -host subdomains.txt -top-ports 1000`.
  - HTTP probing & title discovery: `httpx -l live_hosts.txt -title -tech-detect -status-code`.
- [ ] **Visual Reconnaissance**: Capture screenshots with `gowitness` or `eyewitness` to spot unauthenticated dashboards, admin portals, and login panels.
- [ ] **JavaScript & Endpoint Discovery**:
  - Extract endpoints from JS files using `katana`, `gau`, `waybackurls`.
  - Scan JS bundles for hardcoded API keys, tokens, internal URLs, and secrets (`trufflehog`, `secretfinder`).

---

## Phase 2: Authentication & Session Management

- [ ] **Brute Force & Rate Limiting**: Check if password spraying, credential stuffing, or OTP verification endpoints lack rate limiting.
- [ ] **Password Reset Flows**:
  - Test for token exposure in HTTP response bodies or headers.
  - Test for host header injection altering password reset email links.
  - Test for weak token entropy, timestamp-based generation, or lack of expiration.
- [ ] **OAuth 2.0 & OIDC**:
  - Test redirect URI validation (`redirect_uri` path traversal, open redirect bypasses).
  - Verify whether `state` parameter is strictly validated to prevent OAuth Account Takeover (CSRF).
  - Check for token leakage in URL referer headers.
- [ ] **JWT (JSON Web Tokens)**:
  - Check for `alg: none` algorithm acceptance.
  - Test HMAC-SHA256 signature verification using public RSA key (Algorithm Confusion).
  - Test for sensitive PII or unencrypted claims in JWT payloads.
- [ ] **Session Handling**:
  - Verify cookie security flags: `HttpOnly`, `Secure`, `SameSite=Lax/Strict`.
  - Test session invalidation on logout and password reset.

---

## Phase 3: Access Control & Authorization (IDOR/BOLA)

- [ ] **Insecure Direct Object References (IDOR)**:
  - Test numerical, UUID, and string IDs across user accounts: `GET /api/v1/users/{id}/profile`.
  - Test HTTP verb tampering (e.g. replacing `GET` with `PUT`, `DELETE`, or `PATCH`).
  - Test parameter pollution: `/api/orders?user_id=attacker&user_id=victim`.
- [ ] **Broken Object Property Level Authorization (BOPLA / Mass Assignment)**:
  - Send unexpected parameters in registration or update requests (e.g. `"is_admin": true`, `"role": "superuser"`).
- [ ] **Vertical Privilege Escalation**:
  - Access administrative functions using a standard user session: `GET /admin/users`, `POST /api/v1/system/settings`.

---

## Phase 4: Server-Side Vulnerabilities

- [ ] **Server-Side Request Forgery (SSRF)**:
  - Test webhook URLs, document import, avatar from URL, and PDF generators.
  - Attempt internal metadata service access:
    - AWS: `http://169.254.169.254/latest/meta-data/`
    - GCP: `http://metadata.google.internal/computeMetadata/v1/` (with `Metadata-Flavor: Google` header)
    - Azure: `http://169.254.169.254/metadata/instance?api-version=2021-02-01`
  - Test DNS rebinding and loopback alternatives (`127.0.0.1`, `0.0.0.0`, `[::]`, decimal IP `2130706433`).
- [ ] **SQL Injection (SQLi)**:
  - Test classic error-based, union-based, time-based, and boolean blind payloads across parameters and HTTP headers.
- [ ] **Server-Side Template Injection (SSTI)**:
  - Inject test expressions: `${7*7}`, `{{7*7}}`, `<%= 7*7 %>`, `#{7*7}`.
- [ ] **Command Injection**:
  - Test command separators: `;`, `|`, `&&`, `||`, subshells.
- [ ] **File Upload Vulnerabilities**:
  - Test extension bypasses (`.php5`, `.phtml`, `.phar`, `.jspx`, `.aspx`).
  - Test MIME type tampering, null-byte injection, and path traversal in filename (`../../shell.php`).
  - Upload SVG files with embedded XSS payloads or XML external entities (XXE).

---

## Phase 5: Client-Side Vulnerabilities

- [ ] **Cross-Site Scripting (XSS)**:
  - Test Reflected XSS across all query parameters and input fields.
  - Test Stored XSS in profiles, comments, tickets, and rich text editors.
  - Test DOM-based XSS via sinks (`innerHTML`, `document.write`, `eval`, `location.href`).
- [ ] **Cross-Origin Resource Sharing (CORS)**:
  - Test arbitrary origin reflection: `Origin: https://attacker.com`.
  - Test null origin trust: `Origin: null`.
  - Test wildcard with credentials (`Access-Control-Allow-Origin: *` with `Access-Control-Allow-Credentials: true`).
- [ ] **Clickjacking**:
  - Verify missing `X-Frame-Options` or `Content-Security-Policy: frame-ancestors`.

---
*Explore more at [securitycipher.com](https://securitycipher.com) and the [Security Checklists](https://github.com/securitycipher/security-checklists) project.*
