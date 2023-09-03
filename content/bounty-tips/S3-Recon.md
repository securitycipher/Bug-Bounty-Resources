# S3 Recon

Here's a list of common tools and methods you can use to perform S3 bucket Recon. 👇

Medium Document: https://securitycipher.medium.com/s3-bucket-recon-2d7c2bbf41ef

### Method 1:
Google Dork to find S3 Buckets  <br>
site: s3.amazonaws.com site.com  <br>
site:amazonaws.com inurl:.s3.amazonaws.com  <br>
site:s3.amazonaws.com intitle:index.of.bucket  <br>

### Method 2:
Using Burp Suite  <br>
Crawl the whole application through the browser proxy and then discover the S3 buckets from the sitemap feature of the Burp suite. Look for web addresses or special headers that mention S3 buckets, like "s3.amazonaws.com" or "x-am-bucket".

### Method 3:
From Application  <br>
To find the target application's S3 bucket, right-click on any image available on the application, open it in a new tab, and check if the image URL format is something like this: "https://name.s3.amazonaws.com" In this case, "name" before ".s3" is the bucket name where the images or data is stored.

### Method 4:
There are many online tools available on GitHub for discovering the S3 bucket associated with a website  <br>
S3Scanner: https://github.com/sa7mon/S3Scanner  <br>
Mass3: https://github.com/smiegles/mass3  <br>
slurp: https://github.com/0xbharath/slurp  <br>
Lazy S3: https://github.com/nahamsec/lazys3  <br>
bucket_finder: https://github.com/mattweidner/bucket_finder  <br>
AWSBucketDump : https://github.com/netgusto/awsbucketdump  <br>
sandcastle: https://github.com/0xSearches/sandcastle  <br>
Dumpster Diver: https://github.com/securing/DumpsterDiver  <br>
S3 Bucket Finder: https://github.com/gwen001/s3-buckets-finder  <br>

### Method 5:
Online Websites  <br>
grayhatwarfare: https://buckets.grayhatwarfare.com  <br>
osint.[sh]: https://osint.sh/buckets  <br>

### Method 6:
Nuclei Template to find S3 Bucket  <br>
Template: https://github.com/projectdiscovery/nuclei-templates/blob/master/technologies/s3-detect.yaml

### Method 7:
A simple command to extract S3 buckets from a list of js URLs from a file. You can modify the regex based on your requirements. <br>
cat js_url.txt | xargs -I {} curl -s {} | grep -oE 'http[s]?://[^"]*.s3.amazonaws.com' <br>
cat js_url.txt | xargs -I {} curl -s {} | grep -oE 'http[s]?://[^"]*.s3.amazonaws.com/*'

### Method 8:
Extract using #subfinder and #httpx <br>
subfinder -d domain.com -all -silent | httpx -status-code -title -tech-detect | grep "Amazon S3"
