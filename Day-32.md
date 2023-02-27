# Vulnerability and patch management

Vulnerability and patch management is a crucial process for ensuring the security of computer systems and networks. In simple terms, it involves identifying, prioritizing, and addressing weaknesses or flaws in software and hardware systems that can be exploited by attackers to gain unauthorized access or perform other malicious activities.

Vulnerabilities can arise due to various reasons, such as coding errors, configuration mistakes, or design flaws. Once a vulnerability is known, attackers may use it to gain access or steal data. This is why it is essential to identify and prioritize vulnerabilities and take necessary steps to mitigate them by applying patches or updates released by vendors.

To effectively manage vulnerabilities and patches, DevOps teams need to have a system in place for identifying and prioritizing vulnerabilities. This can be achieved through the use of vulnerability scanners or manual assessments. After prioritizing vulnerabilities, teams need to assess their level of risk and plan for their remediation.

Applying patches or updates to address vulnerabilities is a critical step, and it is important to test patches in a staging environment before deploying them in production. This helps ensure that patches do not introduce new problems or conflicts with other software components.

To maintain the security of systems over time, ongoing monitoring and review are crucial. This helps identify new vulnerabilities promptly and ensures that systems remain secure. In summary, effective vulnerability and patch management is a key component of a robust cybersecurity strategy for DevOps engineers to help ensure the security and integrity of computer systems and networks.


# Monitoring vulnerabilities and misconfigurations

The first step in vulnerability management is to monitor the current posture in runtime.

Let's assume the technology stack we have been using:
* Linux/Mac hosts
* Kubernetes (Minikube)
* Containerized applications

Given this stack, we need to monitor vulnerabilities at the host level, Kubernetes component and configuration and container level.

## Host-level vulnerability scanning

There are multiple solutions and projects that can help you find out host vulnerabilities. To decide which one to choose you need to know your constraints and needs.

A few examples include:
* [AWS Inspector](https://aws.amazon.com/inspector/) which is good if you are running your hosts in AWS EC2. You can turn this on in AWS console or API and get results
* [OpenVAS](https://www.openvas.org/) is an open-source vulnerability scanner, a fork of the "since become closed-source" project Nessus. It container 
* [Vuls](https://vuls.io/) another open-source vulnerability scanner and management system. You can install it in a centralized component and let it connect all your host via SSH and scan them.
* [lynis](https://cisofy.com/lynis/) is a simple but powerful scanner for single hosts

Here is an example, how to scan your machine with `lynis`. We will install it with our package manager:

Ubuntu/Debian:
```bash
sudo apt install lynis
```

RHEL/CentOs:
```bash
sudo yum install lynis
```

Now run the host audit:
```bash
sudo lynis audit system

On MacOs 

`lynis audit system`

```
 Lynis 3.0.8 ]

################################################################################
  Lynis comes with ABSOLUTELY NO WARRANTY. This is free software, and you are
  welcome to redistribute it under the terms of the GNU General Public License.
  See the LICENSE file for details about using this software.

  2007-2021, CISOfy - https://cisofy.com/lynis/
  Enterprise support available (compliance, plugins, interface and tools)
################################################################################


[+] Initializing program
------------------------------------

  ###################################################################
  #                                                                 #
  #   NON-PRIVILEGED SCAN MODE                                      #
  #                                                                 #
  ###################################################################

  NOTES:
  --------------
  * Some tests will be skipped (as they require root permissions)
  * Some tests might fail silently or give different results

Unknown macOS version. Do you know what version it is? Create an issue at https://github.com/CISOfy/lynis
  - Detecting OS...                                           [ DONE ]
  - Checking profiles...                                      [ DONE ]

  ---------------------------------------------------
  Program version:           3.0.8
  Operating system:          macOS
  Operating system name:     macOS
  Operating system version:  13.1
  Kernel version:            22.2.0
  Hardware platform:         arm64
  Hostname:                  Obasoros-MacBook-Pro
  ---------------------------------------------------
  Profiles:                  /opt/homebrew/Cellar/lynis/3.0.8/default.prf
  Log file:                  /Users/kunleobasoro/lynis.log
  Report file:               /Users/kunleobasoro/lynis-report.dat
  Report version:            1.0
  Plugin directory:          /opt/homebrew/Cellar/lynis/3.0.8/plugins
  ---------------------------------------------------
  Auditor:                   [Not Specified]
  Language:                  en
  Test category:             all
  Test group:                all
  ---------------------------------------------------
  - Program update status...                                  [ NO UPDATE ]

[+] System tools
------------------------------------
  - Scanning available tools...
  - Checking system binaries...

[+] Plugins (phase 1)
------------------------------------
 Note: plugins have more extensive tests and may take several minutes to complete
  
  - Plugin: pam
    [..]
  - Plugin: systemd
    [................]

[+] Boot and services
------------------------------------
  - Service Manager                                           [ launchd ]
    - Boot loader                                             [ NONE FOUND ]

[+] Kernel
------------------------------------

[+] Memory and Processes
------------------------------------
  - Searching for dead/zombie processes                       [ FOUND ]
  - Searching for IO waiting processes                        [ NOT FOUND ]

[+] Users, Groups and Authentication
------------------------------------
  - Administrator accounts                                    [ OK ]
  - Unique UIDs                                               [ OK ]
  - Unique group IDs                                          [ OK ]
  - Unique group names                                        [ OK ]
  - Query system users (non daemons)                          [ DONE ]
  - Sudoers file(s)                                           [ FOUND ]
  - PAM password strength tools                               [ SUGGESTION ]
  - PAM configuration file (pam.conf)                         [ NOT FOUND ]
  - PAM configuration files (pam.d)                           [ FOUND ]
  - LDAP module in PAM                                        [ NOT FOUND ]
  - Determining default umask
    - umask (/etc/profile and /etc/profile.d)                 [ OK ]

[+] Shells
------------------------------------
  - Checking shells from /etc/shells
    Result: found 7 shells (valid shells: 7).
    - Session timeout settings/tools                          [ NONE ]
  - Checking default umask values
    - Checking default umask in /etc/bashrc                   [ NONE ]
    - Checking default umask in /etc/csh.cshrc                [ NONE ]
    - Checking default umask in /etc/profile                  [ NONE ]

[+] File systems
------------------------------------
  - Checking mount points
    - Checking /home mount point                              [ SYMLINK ]
    - Checking /tmp mount point                               [ SYMLINK ]
    - Checking /var mount point                               [ SYMLINK ]
  - Checking for old files in /tmp                            [ OK ]
  - Checking /var/tmp sticky bit                              [ OK ]

[+] USB Devices
------------------------------------

[+] Storage
------------------------------------

[+] NFS
------------------------------------
  - Query rpc registered programs                             [ DONE ]
  - Query NFS versions                                        [ DONE ]
  - Query NFS protocols                                       [ DONE ]
  - Check running NFS daemon                                  [ NOT FOUND ]

[+] Name services
------------------------------------
  - Searching DNS domain name                                 [ FOUND ]
      Domain name: local
  - Checking /etc/hosts
    - Duplicate entries in hosts file                         [ NONE ]
    - Presence of configured hostname in /etc/hosts           [ NOT FOUND ]
    - Hostname mapped to localhost                            [ NOT FOUND ]

[+] Ports and packages
------------------------------------
  - Searching package managers
    - Searching brew                                          [ FOUND ]
    - Querying brew for installed packages
  - Checking package audit tool                               [ NONE ]

[+] Networking
------------------------------------
  - Checking configured nameservers
    - Testing nameservers
        Nameserver: 4.2.2.2                                   [ OK ]
        Nameserver: 172.27.247.103                            [ NO RESPONSE ]
        Nameserver: 8.8.8.8                                   [ OK ]
    - Minimal of 2 responsive nameservers                     [ OK ]
  - Checking default gateway                                  [ DONE ]

  - Getting listening ports (TCP/UDP)                         [ DONE ]

  [WARNING]: Test NETW-3012 had a long execution: 38 seconds

  - Checking waiting connections                              [ OK ]
  - Checking status DHCP client

[+] Printers and Spools
------------------------------------
  - Checking cups daemon                                      [ RUNNING ]
  - Checking CUPS configuration file                          [ OK ]
    - File permissions                                        [ WARNING ]
  - Checking CUPS addresses/sockets                           [ FOUND ]
  - Checking lp daemon                                        [ NOT RUNNING ]

[+] Software: e-mail and messaging
------------------------------------

[+] Software: firewalls
------------------------------------
  - Checking host based firewall

[+] Software: webserver
------------------------------------
  - Checking Apache (binary /usr/sbin/httpd)                  [ FOUND ]
      Info: Configuration file found (/private/etc/apache2/httpd.conf)
      Info: Found 8 virtual hosts
    * Loadable modules                                        [ FOUND (114) ]
        - Found 114 loadable modules
          mod_evasive: anti-DoS/brute force                   [ NOT FOUND ]
          mod_reqtimeout/mod_qos                              [ FOUND ]
          ModSecurity: web application firewall               [ NOT FOUND ]
  - Checking nginx                                            [ NOT FOUND ]

[+] SSH Support
------------------------------------
  - Checking running SSH daemon                               [ NOT FOUND ]

[+] SNMP Support
------------------------------------
  - Checking running SNMP daemon                              [ NOT FOUND ]

[+] Databases
------------------------------------
    No database engines found

[+] LDAP Services
------------------------------------
  - Checking OpenLDAP instance                                [ NOT FOUND ]

[+] PHP
------------------------------------
  - Checking PHP                                              [ NOT FOUND ]

[+] Squid Support
------------------------------------
  - Checking running Squid daemon                             [ NOT FOUND ]

[+] Logging and files
------------------------------------
  - Checking for a running log daemon                         [ OK ]
    - Checking Syslog-NG status                               [ NOT FOUND ]
    - Checking systemd journal status                         [ NOT FOUND ]
    - Checking Metalog status                                 [ NOT FOUND ]
    - Checking RSyslog status                                 [ NOT FOUND ]
    - Checking RFC 3195 daemon status                         [ NOT FOUND ]
  - Checking remote logging                                   [ ENABLED ]
  - Checking /etc/newsyslog.conf                              [ FOUND ]
    - Checking log directories (newsyslog.conf)               [ DONE ]
    - Checking log files (newsyslog.conf)                     [ DONE ]
  - Checking log directories (static list)                    [ DONE ]
  - Checking open log files                                   [ DONE ]
  - Checking deleted files in use                             [ FILES FOUND ]

[+] Insecure services
------------------------------------
    - xinetd status
  - com.apple.fingerd                                         [ OK ]
  - com.apple.ftp-proxy                                       [ OK ]

[+] Banners and identification
------------------------------------
  - /etc/issue                                                [ NOT FOUND ]
  - /etc/issue.net                                            [ NOT FOUND ]

[+] Scheduled tasks
------------------------------------
  - Checking crontab and cronjob files                        [ DONE ]

[+] Accounting
------------------------------------

[+] Time and Synchronization
------------------------------------
  - NTP daemon found: timed                                   [ FOUND ]
  - Checking for a running NTP daemon or client               [ OK ]

[+] Cryptography
------------------------------------
  - Checking for expired SSL certificates [0/1]               [ NONE ]

[+] Virtualization
------------------------------------

[+] Containers
------------------------------------
        - Docker info output (warnings)                       [ NONE ]

[+] Security frameworks
------------------------------------
  - Checking presence AppArmor                                [ NOT FOUND ]
  - Checking presence SELinux                                 [ NOT FOUND ]
  - Checking presence TOMOYO Linux                            [ NOT FOUND ]
  - Checking presence grsecurity                              [ NOT FOUND ]
  - Checking for implemented MAC framework                    [ NONE ]

[+] Software: file integrity
------------------------------------
  - Checking file integrity tools
    - mtree                                                   [ FOUND ]
  - Checking presence integrity tool                          [ FOUND ]

[+] Software: System tooling
------------------------------------
  - Checking automation tooling
    - Ansible artifact                                        [ FOUND ]
  - Automation tooling                                        [ FOUND ]
  - Checking for IDS/IPS tooling                              [ NONE ]

[+] Software: Malware
------------------------------------
  - Malware software components                               [ NOT FOUND ]

[+] File Permissions
------------------------------------
  - Starting file permissions check
    File: /etc/group                                          [ OK ]
    File: /etc/passwd                                         [ OK ]
    File: /etc/ssh/sshd_config                                [ SUGGESTION ]
    File: /etc/hosts.equiv                                    [ OK ]

[+] Home directories
------------------------------------
  - Permissions of home directories                           [ WARNING ]
  - Ownership of home directories                             [ OK ]
  - Checking shell history files                              [ OK ]

[+] Kernel Hardening
------------------------------------

[+] Hardening
------------------------------------
    - Installed compiler(s)                                   [ FOUND ]
    - Installed malware scanner                               [ NOT FOUND ]

[+] Custom tests
------------------------------------
  - Running custom tests...                                   [ NONE ]

[+] Plugins (phase 2)
------------------------------------
  - Plugins (phase 2)                                         [ DONE ]

================================================================================

  -[ Lynis 3.0.8 Results ]-

  Warnings (1):
  ----------------------------
  ! Nameserver 172.27.247.103 does not respond [NETW-2704] 
      https://cisofy.com/lynis/controls/NETW-2704/

  Suggestions (18):
  ----------------------------
  * This release is more than 4 months old. Check the website or GitHub to see if there is an update available. [LYNIS] 
      https://cisofy.com/lynis/controls/LYNIS/

  * Check the output of ps for dead or zombie processes [PROC-3612] 
      https://cisofy.com/lynis/controls/PROC-3612/

  * Install a PAM module for password strength testing like pam_cracklib or pam_passwdqc [AUTH-9262] 
      https://cisofy.com/lynis/controls/AUTH-9262/

  * Symlinked mount point needs to be checked manually [FILE-6310] 
    - Details  : /home
    - Solution : 
      https://cisofy.com/lynis/controls/FILE-6310/

  * Symlinked mount point needs to be checked manually [FILE-6310] 
    - Details  : /tmp
    - Solution : 
      https://cisofy.com/lynis/controls/FILE-6310/

  * Symlinked mount point needs to be checked manually [FILE-6310] 
    - Details  : /var
    - Solution : 
      https://cisofy.com/lynis/controls/FILE-6310/

  * Add the IP name and FQDN to /etc/hosts for proper name resolving [NAME-4404] 
      https://cisofy.com/lynis/controls/NAME-4404/

  * Install a package audit tool to determine vulnerable packages [PKGS-7398] 
      https://cisofy.com/lynis/controls/PKGS-7398/

  * Check connection to this nameserver and make sure no outbound DNS queries are blocked (port 53 UDP and TCP). [NETW-2704] 
      https://cisofy.com/lynis/controls/NETW-2704/

  * Access to CUPS configuration could be more strict. [PRNT-2307] 
      https://cisofy.com/lynis/controls/PRNT-2307/

  * Configure a firewall/packet filter to filter incoming and outgoing traffic [FIRE-4590] 
      https://cisofy.com/lynis/controls/FIRE-4590/

  * Install Apache mod_evasive to guard webserver against DoS/brute force attempts [HTTP-6640] 
      https://cisofy.com/lynis/controls/HTTP-6640/

  * Install Apache modsecurity to guard webserver against web application attacks [HTTP-6643] 
      https://cisofy.com/lynis/controls/HTTP-6643/

  * Check what deleted files are still in use and why. [LOGG-2190] 
      https://cisofy.com/lynis/controls/LOGG-2190/

  * Consider restricting file permissions [FILE-7524] 
    - Details  : See screen output or log file
    - Solution : Use chmod to change file permissions
      https://cisofy.com/lynis/controls/FILE-7524/

  * Double check the permissions of home directories as some might be not strict enough. [HOME-9304] 
      https://cisofy.com/lynis/controls/HOME-9304/

  * Harden compilers like restricting access to root user only [HRDN-7222] 
      https://cisofy.com/lynis/controls/HRDN-7222/

  * Harden the system by installing at least one malware scanner, to perform periodic file system scans [HRDN-7230] 
    - Solution : Install a tool like rkhunter, chkrootkit, OSSEC
      https://cisofy.com/lynis/controls/HRDN-7230/

  Follow-up:
  ----------------------------
  - Show details of a test (lynis show details TEST-ID)
  - Check the logfile for all details (less /Users/kunleobasoro/lynis.log)
  - Read security controls texts (https://cisofy.com)
  - Use --upload to upload data to central system (Lynis Enterprise users)

================================================================================

  Lynis security scan details:

  Hardening index : 63 [############        ]
  Tests performed : 163
  Plugins enabled : 2

  Components:
  - Firewall               [X]
  - Malware scanner        [X]

  Scan mode:
  Normal [ ]  Forensics [ ]  Integration [ ]  Pentest [V] (running non-privileged)

  Lynis modules:
  - Compliance status      [?]
  - Security audit         [V]
  - Vulnerability scan     [V]

  Files:
  - Test and debug information      : /Users/kunleobasoro/lynis.log
  - Report data                     : /Users/kunleobasoro/lynis-report.dat

================================================================================

  Skipped tests due to non-privileged mode
    BOOT-5106 - Check EFI boot file on Mac OS X/macOS
    BOOT-5116 - Check if system is booted in UEFI mode
    AUTH-9229 - Check password hashing methods
    AUTH-9252 - Check ownership and permissions for sudo configuration files
    FIRE-4518 - Check pf firewall components

================================================================================

  Lynis 3.0.8

  Auditing, system hardening, and compliance for UNIX-based systems
  (Linux, macOS, BSD, and others)

  2007-2021, CISOfy - https://cisofy.com/lynis/
  Enterprise support available (compliance, plugins, interface and tools)

================================================================================

  [TIP]: Enhance Lynis audits by adding your settings to custom.prf (see /opt/homebrew/Cellar/lynis/3.0.8/default.prf for all settings)

```
```

It will return you a report of your host system with potential security issues:

![](images/day32-1.png)

This is great to see to get a first impression of what such a tool can give you, but I encourage you to think about a more complex system where you need to manage multiple hosts and it is preferable to use a centralized solution to overview the whole system (like mentioned in the above examples).


## Kubernetes vulnerabilities and misconfigurations

Managing vulnerabilities in a Kubernetes cluster requires a multi-faceted approach.

It is important to Kubernetes and its components up-to-date: Make sure that the Kubernetes version and its components (such as etcd, kube-apiserver, kubelet, and others) are up-to-date with the latest patches and security fixes. This can be achieved by following the Kubernetes release notes and upgrading the cluster to the latest version as soon as possible.

In general, these components are tracked in vulnerability databases like any other project and the host scanner will most likely find related vulnerabilities, so you should able to track them with a good host scanner.

Auditing Kubernetes configuration is simple and there are multiple tools you can use here:
* Kubescape - CNCF Project for Kubernetes security, its CLI can give you instant feedback about potential security and compliance issues
* Trivy - Aqua Security's open-source scanner used for both image, cloud and Kubernetes scanning
* Checkov - Bridgecrew's open-source tool scanning cloud infrastructure and Kubernetes 


We will see the simple way to scan our cluster with Kubescape:
```bash
curl -s https://raw.githubusercontent.com/kubescape/kubescape/master/install.sh | /bin/bash
kubescape scan --enable-host-scan --verbose
```

![](https://raw.githubusercontent.com/kubescape/kubescape/master/docs/img/summary.png)

## Application vulnerabilities

Scanning application images is an important aspect of ensuring the security of the entire application stack. Application images are a fundamental part of container-based deployment systems, and they are used to package applications and all their dependencies into a single, deployable artifact. These images are often pulled from public or private repositories and can contain vulnerabilities, misconfigurations, or other security issues that could be exploited by attackers.

Image scanning tools can analyze images for known vulnerabilities and misconfigurations, as well as other issues such as insecure software libraries, outdated packages, or default passwords. These tools compare the contents of an image with a database of known vulnerabilities and can provide information on the severity of the issue.

Trivy project has an operator which monitors application vulnerabilities in containers in the Kubernetes cluster.

It is very easy to install it:
```bash
helm repo add aqua https://aquasecurity.github.io/helm-charts/
helm repo update
helm install trivy-operator aqua/trivy-operator \
  --namespace trivy-system \
  --create-namespace \
  --set="trivy.ignoreUnfixed=true" \
  --version 0.11.1
```

After the installation you can access the vulnerabilities via CRD with kubectl:
```bash
kubectl get vulnerabilityreports --all-namespaces -o wide
```
![](images/day32-2.png)
