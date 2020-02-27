Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,
	WEIRD_PORT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62E0C52D26
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A216F2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732762AbgB0OA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:00:28 -0500
Received: from ec2-3-21-30-127.us-east-2.compute.amazonaws.com ([3.21.30.127]:37180
        "EHLO www.teo-en-ming.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732702AbgB0OA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:00:26 -0500
Received: from localhost (localhost [IPv6:::1])
        by www.teo-en-ming.com (Postfix) with ESMTPA id A05E64139C5;
        Thu, 27 Feb 2020 14:00:24 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 27 Feb 2020 22:00:24 +0800
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming.com>
To:     linux-kernel@vger.kernel.org
Cc:     ceo@teo-en-ming.com
Subject: Re-configuring BIND DNS Servers for CentOS Web Panel Web Hosting
 Control Panel on Amazon AWS Cloud
Message-ID: <7816f274b3126c82c3639207808e9934@teo-en-ming.com>
X-Sender: ceo@teo-en-ming.com
User-Agent: Roundcube Webmail/1.2.3
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Re-configuring BIND DNS Servers for CentOS Web Panel Web 
Hosting Control Panel on Amazon AWS Cloud

Author: Mr. Turritopsis Dohrnii Teo En Ming, Singapore
Date: 27 Feb 2020 Thursday

Rationale for Re-configuration of BIND DNS Servers for CentOS Web Panel
=======================================================================

I have originally followed the approach for cPanel where there are 2 
DNS-ONLY servers and one or more cPanel webservers. However, CentOS Web 
Panel
implements DNS Clusters differently. Hence I have to re-configure BIND 
DNS Servers for CentOS Web Panel web hosting control panel.

PREREQUISITES
=============

Part 1 of the series: Mr. Teo En Ming's Guide to Deploying CentOS Web 
Panel (CWP) Web Hosting Control Panel on Amazon AWS Cloud

Redundant Blogger and Wordpress blog links:

[1] 
https://tdtemcerts.blogspot.com/2020/02/mr-teo-en-mings-guide-to-deploying.html

[2] 
https://tdtemcerts.wordpress.com/2020/02/23/mr-teo-en-mings-guide-to-deploying-centos-web-panel-cwp-web-hosting-control-panel-on-amazon-aws-cloud/

Part 2 of the series: Setting Up Mail Server Operation for CentOS Web 
Panel Web Hosting Control Panel on Amazon AWS Cloud

Redundant Blogger and Wordpress blog links:

[1] 
https://tdtemcerts.blogspot.com/2020/02/setting-up-mail-server-operation-for.html

[2] 
https://tdtemcerts.wordpress.com/2020/02/25/setting-up-mail-server-operation-for-centos-web-panel-web-hosting-control-panel-on-amazon-aws-cloud/

THIS guide is Part 3 of the series.

EXTREMELY DETAILED INSTRUCTIONS OF TEO EN MING'S GUIDE
======================================================

Login to Amazon AWS Console.

Setting Up Secondary/Slave DNS Server
=====================================

On the EC2 Dashboard, click Instances.

Click Launch Instance.

Search for centos in the AWS Markpetplace.

Select CentOS 7 (x86_64) - with Updates HVM (free tier eligible).

Click Continue.

Select t2.micro (free tier eligible).

Click Next: Configure Instance Details.

Network: Teo En Ming VPC

Subnet: Public subnet | us-east-2a

Click Protect against accidental termination.

Click Next: Add Storage

Size (GiB): 8

Click Next: Add Tags

Key = Name

Value = slave

Click Next: Configure Security Group

Click Select an existing security group

Select NameServers

Click Review and Launch.

Click Launch.

Select Choose an existing key pair.

Key pair name: cwp

Click Launch Instances.

Click Instances.

Select slave, right click and select Networking > Manage IP Addresses.

Click Allocate an elastic IP to this instance.

Click Allocate.

Click Associate this Elastic IP Address.

Instance: slave

Click Associate.

IPv4 address of Secondary/Slave DNS server is 3.12.224.179

$ ssh -i cwp.pem centos@3.12.224.179

$ sudo passwd

$ su -

# yum -y update && yum -y install wget

# hostnamectl set-hostname ns2.teo-en-ming.com

# cd /usr/local/src && wget http://centos-webpanel.com/cwp-el7-latest && 
sh cwp-el7-latest

Started installing CentOS Web Panel at 9:00 PM on 26 Feb 2020 Wed.

Completed installing CentOS Web Panel at 9:05 PM on 26 Feb 2020 Wed.

Total duration: 5 mins.

#############################
#      CWP Installed        #
#############################

Go to CentOS WebPanel Admin GUI at http://SERVER_IP:2030/

http://3.12.224.179:2030
SSL: https://3.12.224.179:2031
---------------------
Username: root
Password: ssh server root password
MySQL root Password:

#########################################################
           CentOS Web Panel MailServer Installer
#########################################################
SSL Cert name (hostname): ns2.teo-en-ming.com
SSL Cert file location /etc/pki/tls/ private|certs
#########################################################

Visit for help: www.centos-webpanel.com
Write down login details and press ENTER for server reboot!
Please reboot the server!
Reboot command: shutdown -r now

# reboot

REFERENCE
=========

Guide: Slave DNS Server & Manager - DNS Cluster

Link: 
https://wiki.centos-webpanel.com/slave-dns-server-manager-dns-cluster

REFERENCE
=========

Guide: Slave DNS Server & Manager download version

Link: 
https://wiki.centos-webpanel.com/slave-dns-server-manager-download-version

Login to the CentOS Web Panel Admin Panel on the Slave.

 From the left menu, click on CWP Settings, then select Edit Settings.

Admin Email: ceo@teo-en-ming-corp.com

Check Activate NAT-ed network configuration.

Click Save Changes.

Create a New Account on the Secondary/Slave DNS Server
======================================================

 From the left menu, click User Accounts, then click New Account.

Domain name: teo-en-ming.com

Username: slave

Package: default

Click Create.

Download Slave DNS Manager and upload it to public_html folder on the 
Secondary/Slave DNS Server
================================================================================================

ssh -i cwp.pem centos@3.12.224.179

su -

cd /home/slave/public_html

wget http://dl1.centos-webpanel.com/files/cwp/addons/cwp-slave_dns.zip

unzip cwp-slave_dns.zip

mv slave_dns/* .

rm -f index.html

Fix file permissions on the Slave DNS Server
============================================

chown -R slave.slave /home/slave/public_html/*

MySQL: Create User and Database on the Slave DNS Server
=======================================================

 From the left menu, click SQL Services, then click MySQL Manager.

Click Create Database and User.

New Database for user: slave

Database Name: slave

Click Create Database.

Edit file /home/slave/public_html/inc/db_conn.php.sample and enter your 
database connection details

# nano /home/slave/public_html/inc/db_conn.php.sample

# mv inc/db_conn.php.sample inc/db_conn.php

# mysql slave_slave < sql/slave_dns.sql

# nano /etc/sudoers.d/slave

slave  ALL= NOPASSWD: /bin/systemctl start named
slave  ALL= NOPASSWD: /bin/systemctl stop named
slave  ALL= NOPASSWD: /bin/systemctl restart named
slave  ALL= NOPASSWD: /bin/systemctl reload named
slave  ALL= NOPASSWD: /bin/systemctl status named
slave  ALL= NOPASSWD: /bin/systemctl is-active named


# touch /etc/named/slave.conf

# chmod 771 /etc/named

# usermod -a -G named slave

# chown slave.named /etc/named/slave.conf

# mkdir /var/named/slave

# chown named.named /var/named/slave

Edit File: /etc/named.conf and add this in options section before 
closing }

masterfile-format text;

Add after options{} where other include lines are specifed

//Slave dns configuration
include "/etc/named/slave.conf";

Now you can login to Slave DNS Manager GUI by using a domain link of the 
account you have created.

Go to http://3.12.224.179/~slave/index.php?login

Default login for Slave DNS Manager GUI admin/root
Username: root
Password: FX8QKxvQ
* Please change the default password after the first login

Adding WebServers to Slave DNS Manager
======================================

- On Slave DNS manager GUI create a new user for each server or use a 
single for all webservers if you plan to transfer accounts from one to 
another webserver.

Click Add New User.

Username:

Password:

Email:

API Key:

API Secret:

Domain Limit: 1000000

Click Save.

- On Master CentOS Web Panel WebServer go to DNS Functions -> Slave DNS 
Manager

Buy CWPPro license first. It is only USD$1.49 compared to USD$20 for the 
license of cPanel. I can't afford to buy the license for cPanel, hence
I have to settle for CentOS Web Panel.

Then ssh into your Master CentOS Web Panel Webserver.

# sh /scripts/update_cwp

You have successfully upgraded to CWPpro.

On the Master CentOS Web Panel, Go to DNS Functions -> Slave DNS Manager

API Key:

Secret Key:

Base URL: http://3.12.224.179/~slave

Master Server IP's: 3.21.30.127

Click Submit.

Master CentOS Web Panel WebServer configuration
===============================================

Edit File: /etc/named.conf and add this in options section before 
closing }

//Slave dns configuration
allow-transfer {3.12.224.179;};
allow-recursion {3.12.224.179;};
also-notify {3.12.224.179;};
masterfile-format text;

# named-checkconf

# systemctl restart named

REFERENCE
=========

Guide: How to setup DNS cluster on CWP 1 – Install DNS Manager

Link: https://opentechy.com/how-to-setup-dns-cluster-on-cwp/

REFERENCE
=========

Guide: How to setup DNS cluster on CWP 2 – Add webservers to DNS cluster

Link: 
https://opentechy.com/how-to-setup-dns-cluster-on-cwp-2-add-webservers-to-dns-cluster/

CONFIGURING CUSTOM NAME SERVERS AT YOUR DOMAIN REGISTRAR
========================================================

Go to Advanced Features > Hostnames

Host: ns1 	IP Addresses: 3.21.30.127
Host: ns2	IP Addresses: 3.12.224.179

Nameservers: Using custom nameservers

ns1.teo-en-ming.com

ns2.teo-en-ming.com

CONFIGURING NAME SERVERS ON THE MASTER CENTOS WEB PANEL WEBSERVER
==================================================================

 From the left menu, click DNS Functions, then click Edit Nameservers 
IPs.

Name Server 1: ns1.teo-en-ming.com	3.21.30.127

Name Server 2: ns2.teo-en-ming.com	3.12.224.179

Click Save changes.

# systemctl restart named

BIND DNS CONFIGURATION ON THE MASTER CENTOS WEB PANEL WEBSERVER
===============================================================

File /etc/named.conf:

//
// named.conf
//
// Provided by Red Hat bind package to configure the ISC BIND named(8) 
DNS
// server as a caching only nameserver (as a any DNS resolver only).
//
// See /usr/share/doc/bind*/sample/ for example named configuration 
files.
//
// See the BIND Administrator's Reference Manual (ARM) for details about 
the
// configuration located in /usr/share/doc/bind-{version}/Bv9ARM.html

options {
	listen-on port 53 { any; };
	listen-on-v6 port 53 { ::1; };
	directory 	"/var/named";
	dump-file 	"/var/named/data/cache_dump.db";
	statistics-file "/var/named/data/named_stats.txt";
	memstatistics-file "/var/named/data/named_mem_stats.txt";
	recursing-file  "/var/named/data/named.recursing";
	secroots-file   "/var/named/data/named.secroots";
	allow-query     { any; };

	/*
	 - If you are building an AUTHORITATIVE DNS server, do NOT enable 
recursion.
	 - If you are building a RECURSIVE (caching) DNS server, you need to 
enable
	   recursion.
	 - If your recursive DNS server has a public IP address, you MUST 
enable access
	   control to limit queries to your legitimate users. Failing to do so 
will
	   cause your server to become part of large scale DNS amplification
	   attacks. Implementing BCP38 within your network would greatly
	   reduce such attack surface
	*/
//	recursion no;

	dnssec-enable yes;
	dnssec-validation yes;

	/* Path to ISC DLV key */
	bindkeys-file "/etc/named.root.key";

	managed-keys-directory "/var/named/dynamic";

	pid-file "/run/named/named.pid";
	session-keyfile "/run/named/session.key";

//Slave dns configuration
allow-transfer {3.12.224.179;};
allow-recursion {3.12.224.179;};
also-notify {3.12.224.179;};
masterfile-format text;
};

logging {
         channel default_debug {
                 file "data/named.run";
                 severity dynamic;
         };
};

zone "." IN {
	type hint;
	file "named.ca";
};

include "/etc/named.rfc1912.zones";
include "/etc/named.root.key";


zone "ns1.teo-en-ming.com" {type master;file 
"/var/named/ns1.teo-en-ming.com.db";};
zone "ns2.teo-en-ming.com" {type master;file 
"/var/named/ns2.teo-en-ming.com.db";};

// zone teo-en-ming.com
zone "teo-en-ming.com" {type master; file 
"/var/named/teo-en-ming.com.db";};
// zone_end teo-en-ming.com

File /var/named/ns1.teo-en-ming.com.db:


; Panel %version%
; Zone file for ns1.teo-en-ming.com
$TTL 14400
ns1.teo-en-ming.com.      86400      IN      SOA      
ns1.teo-en-ming.com.      info.centos-webpanel.com.      (
       				2013071600 ;serial, todays date+todays
       				86400 ;refresh, seconds
       				7200 ;retry, seconds
       				3600000 ;expire, seconds
       				86400 ;minimum, seconds
       )
ns1.teo-en-ming.com. 86400 IN NS ns1.teo-en-ming.com.
ns1.teo-en-ming.com. 86400 IN NS ns2.teo-en-ming.com.
ns1.teo-en-ming.com. 14400 IN A 3.21.30.127

File /var/named/ns2.teo-en-ming.com.db:


; Panel %version%
; Zone file for ns2.teo-en-ming.com
$TTL 14400
ns2.teo-en-ming.com.      86400      IN      SOA      
ns1.teo-en-ming.com.      info.centos-webpanel.com.      (
       				2013071600 ;serial, todays date+todays
       				86400 ;refresh, seconds
       				7200 ;retry, seconds
       				3600000 ;expire, seconds
       				86400 ;minimum, seconds
       )
ns2.teo-en-ming.com. 86400 IN NS ns1.teo-en-ming.com.
ns2.teo-en-ming.com. 86400 IN NS ns2.teo-en-ming.com.
ns2.teo-en-ming.com. 14400 IN A 3.12.224.179

File /var/named/teo-en-ming.com.db:

; Generated by CWP
; Zone file for teo-en-ming.com
$TTL 14400
@    86400        IN      SOA     ns1.teo-en-ming.com. 
ceo.teo-en-ming-corp.com. (
				2020022453      ; serial, todays date+todays
				3600            ; refresh, seconds
				7200            ; retry, seconds
				1209600         ; expire, seconds
				86400 )         ; minimum, seconds
@	86400	IN	NS		ns1.teo-en-ming.com.
@	86400	IN	NS		ns2.teo-en-ming.com.
@ IN A 3.21.30.127
localhost.teo-en-ming.com. IN A 127.0.0.1
@ IN MX 0 teo-en-ming.com.
mail 14400 IN CNAME teo-en-ming.com.
smtp 14400 IN CNAME teo-en-ming.com.
pop  14400 IN CNAME teo-en-ming.com.
pop3 14400 IN CNAME teo-en-ming.com.
imap 14400 IN CNAME teo-en-ming.com.
webmail 14400 IN A 3.21.30.127
cpanel 14400 IN A 3.21.30.127
cwp 14400 IN A 3.21.30.127
www 14400 IN CNAME teo-en-ming.com.
ftp 14400 IN CNAME teo-en-ming.com.
_dmarc	14400	IN	TXT	"v=DMARC1; p=none"
@	14400	IN	TXT	"v=spf1 +a +mx +ip4:3.21.30.127 ~all"
ns1.teo-en-ming.com. 14400 IN A 3.21.30.127
ns2.teo-en-ming.com. 14400 IN A 3.12.224.179
default._domainkey 14400 IN TXT "v=DKIM1; k=rsa; 
p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDEXk5wQIfKJPjTkkj0yHGX8yIJOOrsOsvAqbqVaEBFBWhRlF7YxyGzchaAdWEVQkozcsWPIL5DgJ7vWBoJIGqfNOT7vO/lStqNcXC+2hYVIF7MTB8i6tBW1/UDEuL8oammKWDq8P9Fpduk6JppV7rtKXeFzrYj35ydIhDIKUABcwIDAQAB"

BIND DNS CONFIGURATION ON THE SLAVE DNS MANAGER
===============================================

File /etc/named.conf:

//
// named.conf
//
// Provided by Red Hat bind package to configure the ISC BIND named(8) 
DNS
// server as a caching only nameserver (as a any DNS resolver only).
//
// See /usr/share/doc/bind*/sample/ for example named configuration 
files.
//
// See the BIND Administrator's Reference Manual (ARM) for details about 
the
// configuration located in /usr/share/doc/bind-{version}/Bv9ARM.html

options {
	listen-on port 53 { any; };
	listen-on-v6 port 53 { ::1; };
	directory 	"/var/named";
	dump-file 	"/var/named/data/cache_dump.db";
	statistics-file "/var/named/data/named_stats.txt";
	memstatistics-file "/var/named/data/named_mem_stats.txt";
	recursing-file  "/var/named/data/named.recursing";
	secroots-file   "/var/named/data/named.secroots";
	allow-query     { any; };

	/*
	 - If you are building an AUTHORITATIVE DNS server, do NOT enable 
recursion.
	 - If you are building a RECURSIVE (caching) DNS server, you need to 
enable
	   recursion.
	 - If your recursive DNS server has a public IP address, you MUST 
enable access
	   control to limit queries to your legitimate users. Failing to do so 
will
	   cause your server to become part of large scale DNS amplification
	   attacks. Implementing BCP38 within your network would greatly
	   reduce such attack surface
	*/
	recursion no;

	dnssec-enable yes;
	dnssec-validation yes;

	/* Path to ISC DLV key */
	bindkeys-file "/etc/named.root.key";

	managed-keys-directory "/var/named/dynamic";

	pid-file "/run/named/named.pid";
	session-keyfile "/run/named/session.key";

	masterfile-format text;
};

logging {
         channel default_debug {
                 file "data/named.run";
                 severity dynamic;
         };
};

zone "." IN {
	type hint;
	file "named.ca";
};

include "/etc/named.rfc1912.zones";
include "/etc/named.root.key";


// zone teo-en-ming.com
// zone "teo-en-ming.com" {type master; file 
"/var/named/teo-en-ming.com.db";};
// zone_end teo-en-ming.com

//Slave dns configuration
include "/etc/named/slave.conf";

File /var/named/teo-en-ming.com.db (WRONG, DON'T USE):

; Generated by CWP
; Zone file for teo-en-ming.com
$TTL 14400
@    86400        IN      SOA     ns1.centos-webpanel.com. 
ceo.teo-en-ming-corp.com. (
				2020022660      ; serial, todays date+todays
				3600            ; refresh, seconds
				7200            ; retry, seconds
				1209600         ; expire, seconds
				86400 )         ; minimum, seconds
@	86400	IN	NS		ns1.centos-webpanel.com.
@	86400	IN	NS		ns2.centos-webpanel.com.
@ IN A 3.12.224.179
localhost.teo-en-ming.com. IN A 127.0.0.1
@ IN MX 0 teo-en-ming.com.
mail 14400 IN CNAME teo-en-ming.com.
smtp 14400 IN CNAME teo-en-ming.com.
pop  14400 IN CNAME teo-en-ming.com.
pop3 14400 IN CNAME teo-en-ming.com.
imap 14400 IN CNAME teo-en-ming.com.
webmail 14400 IN A 3.12.224.179
cpanel 14400 IN A 3.12.224.179
cwp 14400 IN A 3.12.224.179
www 14400 IN CNAME teo-en-ming.com.
ftp 14400 IN CNAME teo-en-ming.com.
_dmarc	14400	IN	TXT	"v=DMARC1; p=none"
@	14400	IN	TXT	"v=spf1 +a +mx +ip4:3.12.224.179 ~all"
default._domainkey 14400 IN TXT "v=DKIM1; k=rsa; 
p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCktDYpEtFO7dyJeErMbjHvyfJYU8RqDeS7WVqQnjH4fP42JSqPmxEFX+QytFTlGqd6ndlz9Tjqi1iZsD0ajB/+0Pkwq/KtL6NVo2TIqnXj8VebV9+FEcx+FGvLA/b5zz+Hfn0Bf+w/2T2bSwUm+tJoHilmANCFGlcGmpO9/lXvAwIDAQAB"

File /etc/named/slave.conf:

zone "teo-en-ming.com" { type slave; file "slave/db.teo-en-ming.com"; 
masters { 3.21.30.127; };}; //username:enming

That's all folks!








-- 
-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: 
https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the 
United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan (5 Aug 
2019) and Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
