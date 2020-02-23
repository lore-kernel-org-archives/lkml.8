Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,
	NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_CSS,URIBL_CSS_A,
	URIBL_RHS_DOB,WEIRD_PORT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18B8C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 13:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FFE206ED
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 13:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjdkfmQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgBWNWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 08:22:18 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35650 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgBWNWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 08:22:17 -0500
Received: by mail-qt1-f194.google.com with SMTP id n17so4814031qtv.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 05:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=g5huPZ0y91QAf0h5wnE6GL4PNcNK0bE/CAb7b5RJKuE=;
        b=bjdkfmQYabw1EwUNGdXMgsLTJ33W/QrGpHxMOg5iaiibegNEB/3/yBJnyRBU6MEzoM
         FW3ErJyk6vOsy2/nNIUiNa9L1cb9s91JnhTd386mAYb241sH1YmsoJBJqoPFk0ESB7q/
         292vDw8ZRD40H1tCjJKcPVacbpZb/gI2BKWSZ4BiAEjtW965m1dAO78CxL/2K8fnzG3D
         yrdYtPpXBhrSfF6uVtnOwR3hXqBJe8rrTsjeZE97TBothlDoBlKdNhKD7lw47avnF5Y5
         IruzhXcNMe55mfUM0t+1RpAheb+gchhbcxND1hTJP5XbFE8fDikJ0g9VHebkEilCLqLl
         UqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=g5huPZ0y91QAf0h5wnE6GL4PNcNK0bE/CAb7b5RJKuE=;
        b=lnIXmc0NtuZPODwV4sA8ydYUAIxfB+yjT94ZcT+D7kQ1hcVAauzs9VJVqL8p9Lki6T
         t1OH4DqGsxuh5TWHy6AhUnUxs1tE3Tu6+A8Ud/11SQwqXARE1ZXkbFGs9HaS+lGiYH/f
         2UoRlw8cWbp0HBcPscUQHIHVaNzXK21iGmjqxd/rwdCWtawCN7jjtLjYJtigjidXQwA6
         23iWJaCH0uUmuQQ++6jSMNpYeyIwHIy1i87nUoZd0rcJDNeT7PsuePEvslF1n6c2Ko6s
         8wLkqQHSKzoYEuMCKPA/Pc55Ex2y5Q0kOkA59tRIOnZoKjOWSbNAlQ9z/lYzKnSV1NVm
         VCMw==
X-Gm-Message-State: APjAAAVwPjnQbQAI++eL37qGK68CS1d/46w0KOcv5DBSZnd0Dv/MHwMX
        eMd1XOS0BYG54yQJSxND+So/a/H4EQ2fqvUaQGYbUGV0iZ/lTw==
X-Google-Smtp-Source: APXvYqyrKy4OnlyR6OZRqWHYtR9EC5I4HiNeFWiqlmTQCqmuqTMAm+nlAg0X1j1BaTELcQq6MEWFvU0HL8UUx1RLSEs=
X-Received: by 2002:ac8:592:: with SMTP id a18mr42706438qth.107.1582464134294;
 Sun, 23 Feb 2020 05:22:14 -0800 (PST)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <teo.en.ming.feb9020@gmail.com>
Date:   Sun, 23 Feb 2020 21:22:03 +0800
Message-ID: <CAH-aG90Jq=jmqRF6MLMN6xW9voAPYwsKebV6+SKiYjAYcR0iTA@mail.gmail.com>
Subject: Teo En Ming's Guide to Deploying CentOS Web Panel (CWP) Web Hosting
 Control Panel on Amazon AWS Cloud
To:     linux-kernel@vger.kernel.org
Cc:     teo.en.ming.feb9020@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Teo En Ming's Guide to Deploying CentOS Web Panel (CWP) Web
Hosting Control Panel on Amazon AWS Cloud

===FIRST DRAFT===

PUBLISHED 23 FEB 2020 SUNDAY, SINGAPORE, SINGAPORE

I chose CentOS Web Panel because the graphical user interface is a bit
like cPanel and it is free/open source.

EXTREMELY DETAILED INSTRUCTIONS OF TEO EN MING'S GUIDE
======================================================

REFERENCE
=========

Guide: Part 1: How I Built a cPanel Hosting Environment on Amazon AWS

Link: https://wiredgorilla.com/part-1-built-cpanel-hosting-environment-amazon-aws/

Setup the Amazon AWS VPC (Virtual Private Cloud)
================================================

Go to https://us-east-2.console.aws.amazon.com/vpc/home?region=us-east-2#dashboard:

Click Launch VPC Wizard.

Select VPC with a Single Public Subnet.

IPv4 CIDR block: 10.0.0.0/16

VPC Name: Teo En Ming VPC

Public subnet's IPv4 CIDR: 10.0.0.0/24

Availability Zone: No Preference

Subnet name: Public subnet

Click Create VPC.

Create Security Groups in Amazon AWS Cloud
==========================================

Click Security Groups in the VPC Dashboard.

Sub-Part 1
==========

Click Create Security Group.

Security Group Name: NameServers

Description: Allows access to DNS servers

VPC: Teo En Ming VPC

Click Create.

Sub-Part 2
==========

Click Create Security Group.

Security Group Name: CentOSWebPanel

Description: Allows access to CentOS Web Panel

VPC: Teo En Ming VPC

Click Create.

Sub-Part 3
==========

Select the NameServers Security Group.

On the Inbound tab, click Edit.

Under Type, select All Traffic.

Protocol: All

Port Range: 0 - 65535

Source: Anywhere

Click Save.

Sub-Part 4
==========

Select the CentOSWebPanel Security Group.

On the Inbound tab, click Edit.

Under Type, select All Traffic.

Protocol: All

Port Range: 0 - 65535

Source: Anywhere

Click Save.

Provisioning the Primary DNS Server
===================================

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

Value = ns1

Click Next: Configure Security Group

Click Select an existing security group

Select NameServers

Click Review and Launch.

Click Launch.

Select Create a new key pair.

Key pair name: cwp

Click Download key pair.

Click Launch Instances.

Click Instances.

Select ns1, right click and select Networking > Manage IP Addresses.

Click Allocate an elastic IP to this instance.

Click Allocate.

Click Associate this Elastic IP Address.

Instance: ns1

Click Associate.

IPv4 address of Primary DNS server is 13.58.253.162


Provisioning the Secondary DNS Server
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

Value = ns2

Click Next: Configure Security Group

Click Select an existing security group

Select NameServers

Click Review and Launch.

Click Launch.

Select Choose an existing key pair.

Key pair name: cwp

Click Launch Instances.

Click Instances.

Select ns2, right click and select Networking > Manage IP Addresses.

Click Allocate an elastic IP to this instance.

Click Allocate.

Click Associate this Elastic IP Address.

Instance: ns2

Click Associate.

IPv4 address of Secondary DNS server is 3.20.186.205

Provisioning CentOS 7 to Install CentOS Web Panel Later
=======================================================

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

Size (GiB): 30

Click Next: Add Tags

Key = Name

Value = CentOSWebPanel

Click Next: Configure Security Group

Click Select an existing security group

Select CentOSWebPanel

Click Review and Launch.

Click Launch.

Select Choose an existing key pair.

Key pair name: cwp

Click Launch Instances.

Click Instances.

Select CentOSWebPanel, right click and select Networking > Manage IP Addresses.

Click Allocate an elastic IP to this instance.

Click Allocate.

Click Associate this Elastic IP Address.

Instance: CentOSWebPanel

Click Associate.

IPv4 address of CentOS Web Panel is 3.21.30.127

RFERENCE
========

Guide: Connecting to Your Linux Instance Using SSH

Link: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html

How to SSH into Linux Instances in Amazon AWS Cloud
===================================================

$ chmod 600 cwp.pem

For Primary DNS Server:

$ ssh -i cwp.pem centos@13.58.253.162

For Secondary DNS Server:

$ ssh -i cwp.pem centos@3.20.186.205

For CentOS Web Panel:

$ ssh -i cwp.pem centos@3.21.30.127

REFERENCE
=========

Guide: How To Configure BIND as a Private Network DNS Server on CentOS 7

Link: https://www.digitalocean.com/community/tutorials/how-to-configure-bind-as-a-private-network-dns-server-on-centos-7

Configuring the Primary DNS Server
==================================

$ sudo passwd

$ su -

# yum install bind bind-utils

# yum install nano

# nano /etc/named.conf

//
// named.conf
//
// Provided by Red Hat bind package to configure the ISC BIND named(8) DNS
// server as a caching only nameserver (as a localhost DNS resolver only).
//
// See /usr/share/doc/bind*/sample/ for example named configuration files.
//
// See the BIND Administrator's Reference Manual (ARM) for details about the
// configuration located in /usr/share/doc/bind-{version}/Bv9ARM.html

options {
listen-on port 53 { 127.0.0.1; 10.0.0.99; };
// listen-on-v6 port 53 { ::1; };
directory "/var/named";
dump-file "/var/named/data/cache_dump.db";
statistics-file "/var/named/data/named_stats.txt";
memstatistics-file "/var/named/data/named_mem_stats.txt";
recursing-file  "/var/named/data/named.recursing";
secroots-file   "/var/named/data/named.secroots";
allow-transfer { 3.20.186.205; };
allow-query     { any; };

/*
- If you are building an AUTHORITATIVE DNS server, do NOT enable recursion.
- If you are building a RECURSIVE (caching) DNS server, you need to enable
   recursion.
- If your recursive DNS server has a public IP address, you MUST enable access
   control to limit queries to your legitimate users. Failing to do so will
   cause your server to become part of large scale DNS amplification
   attacks. Implementing BCP38 within your network would greatly
   reduce such attack surface
*/
recursion yes;

dnssec-enable yes;
dnssec-validation yes;

/* Path to ISC DLV key */
bindkeys-file "/etc/named.root.key";

managed-keys-directory "/var/named/dynamic";

pid-file "/run/named/named.pid";
session-keyfile "/run/named/session.key";
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

include "/etc/named/named.conf.local";

# nano /etc/named/named.conf.local

zone "teo-en-ming.com" {
    type master;
    file "/etc/named/zones/db.teo-en-ming.com"; # zone file path
};

# chmod 755 /etc/named

# mkdir /etc/named/zones

# nano /etc/named/zones/db.teo-en-ming.com

$TTL    604800
@ IN      SOA     ns1.teo-en-ming.com. ceo.teo-en-ming.com. (
         2020022301     ; Serial
             604800     ; Refresh
              86400     ; Retry
            2419200     ; Expire
             604800 )   ; Negative Cache TTL
;
; name servers - NS records
     IN      NS      ns1.teo-en-ming.com.
     IN      NS      ns2.teo-en-ming.com.

; name servers - A records
ns1.teo-en-ming.com.          IN      A       13.58.253.162
ns2.teo-en-ming.com.          IN      A       3.20.186.205

; Additional A records
www.teo-en-ming.com.          IN      A       3.21.30.127

# named-checkconf

# systemctl start named

# systemctl enable named

Testing the Primary DNS Server
==============================

$ dig @13.58.253.162 teo-en-ming.com

Configuring the Secondary DNS Server
====================================

$ sudo passwd

$ su -

# yum install nano

# yum install bind bind-utils

# nano /etc/named.conf

//
// named.conf
//
// Provided by Red Hat bind package to configure the ISC BIND named(8) DNS
// server as a caching only nameserver (as a localhost DNS resolver only).
//
// See /usr/share/doc/bind*/sample/ for example named configuration files.
//
// See the BIND Administrator's Reference Manual (ARM) for details about the
// configuration located in /usr/share/doc/bind-{version}/Bv9ARM.html

options {
listen-on port 53 { 127.0.0.1; 10.0.0.76; };
// listen-on-v6 port 53 { ::1; };
directory "/var/named";
dump-file "/var/named/data/cache_dump.db";
statistics-file "/var/named/data/named_stats.txt";
memstatistics-file "/var/named/data/named_mem_stats.txt";
recursing-file  "/var/named/data/named.recursing";
secroots-file   "/var/named/data/named.secroots";
allow-query     { any; };

/*
- If you are building an AUTHORITATIVE DNS server, do NOT enable recursion.
- If you are building a RECURSIVE (caching) DNS server, you need to enable
   recursion.
- If your recursive DNS server has a public IP address, you MUST enable access
   control to limit queries to your legitimate users. Failing to do so will
   cause your server to become part of large scale DNS amplification
   attacks. Implementing BCP38 within your network would greatly
   reduce such attack surface
*/
recursion yes;

dnssec-enable yes;
dnssec-validation yes;

/* Path to ISC DLV key */
bindkeys-file "/etc/named.root.key";

managed-keys-directory "/var/named/dynamic";

pid-file "/run/named/named.pid";
session-keyfile "/run/named/session.key";
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

include "/etc/named/named.conf.local";

# chmod 755 /etc/named

# nano /etc/named/named.conf.local

zone "teo-en-ming.com" {
    type slave;
    file "slaves/db.teo-en-ming.com";
    masters { 13.58.253.162; };  # ns1 private IP
};


# named-checkconf

# systemctl start named

# systemctl enable named

Testing the Secondary DNS Server
================================

$ dig @3.20.186.205 teo-en-ming.com

Configuring Custom Name Servers At Your Domain Registrar
========================================================

Go to DNS management.

Under host names,

Set ns1 to 13.58.253.162

Set ns2 to 3.20.186.205

Set custom name servers to:

ns1.teo-en-ming.com

ns2.teo-en-ming.com

REFERENCE
=========

Guide: How to Set up a CentOS Web Panel

Link: https://www.alibabacloud.com/blog/how-to-set-up-a-centos-web-panel_595183

Setting Up CentOS Web Panel
===========================

$ sudo passwd

$ su -

# yum -y update && yum -y install wget

# hostnamectl set-hostname www.teo-en-ming.com

# cd /usr/local/src && wget http://centos-webpanel.com/cwp-el7-latest
&& sh cwp-el7-latest

Started installing CentOS Web Panel at 6.24 PM on 23 Feb 2020 Sunday.

Completed installing CentOS Web Panel at 6.30 PM on 23 Feb 2020 Sunday.

Total duration: 6 mins

#############################
#      CWP Installed        #
#############################

Go to CentOS WebPanel Admin GUI at http://SERVER_IP:2030/

http://3.21.30.127:2030
SSL: https://3.21.30.127:2031
---------------------
Username: root
Password: ssh server root password
MySQL root Password:

#########################################################
          CentOS Web Panel MailServer Installer
#########################################################
SSL Cert name (hostname): www.teo-en-ming.com
SSL Cert file location /etc/pki/tls/ private|certs
#########################################################

Visit for help: www.centos-webpanel.com
Write down login details and press ENTER for server reboot!
Please reboot the server!
Reboot command: shutdown -r now

# shutdown -r now

Configuring CentOS Web Panel Web Hosting Control Panel
======================================================

Go to https://3.21.30.127:2031

From the left menu, click on CWP Settings, then select Edit Settings.

Admin Email: ceo@teo-en-ming-corp.com

Check Activate NAT-ed network configuration.

Click Save Changes.

From the left menu, click DNS Functions, then select Edit Nameservers IPs.

Name Server 1: ns1.teo-en-ming.com            13.58.253.162

Name Server 2: ns2.teo-en-ming.com            3.20.186.205

Click Save Changes.

That's all.

In future, go to https://www.teo-en-ming.com:2031

It works!

AUTHOR: MR. TURRITOPSIS DOHRNII TEO EN MING, SINGAPORE






-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the
United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan (5 Aug
2019) and Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
