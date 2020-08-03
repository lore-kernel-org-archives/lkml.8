Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0711C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA9FA20719
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgHCKe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:34:59 -0400
Received: from ec2-3-21-30-127.us-east-2.compute.amazonaws.com ([3.21.30.127]:47552
        "EHLO www.teo-en-ming.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgHCKe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:34:59 -0400
Received: from localhost (localhost [IPv6:::1])
        by www.teo-en-ming.com (Postfix) with ESMTPA id CD1214049CA;
        Mon,  3 Aug 2020 18:34:57 +0800 (+08)
MIME-Version: 1.0
Date:   Mon, 03 Aug 2020 18:34:57 +0800
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming.com>
To:     linux-kernel@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Subject: =?UTF-8?Q?Teo_En_Ming=27s_Guide_to_Configuring_SSL_VPN_for_Cisco?=
 =?UTF-8?Q?_ASA_5506-X_Firepower_Firewall_with_Let=E2=80=99s_Encrypt_SSL_C?=
 =?UTF-8?Q?ertificates=2C_LDAP/Active_Directory_Primary_Authentication_and?=
 =?UTF-8?Q?_Duo_2FA_Secondary_Authentication?=
Message-ID: <151ee41881749de4afc3e67a967e6156@teo-en-ming.com>
X-Sender: ceo@teo-en-ming.com
User-Agent: Roundcube Webmail/1.2.3
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Teo En Ming's Guide to Configuring SSL VPN for Cisco ASA 5506-X 
Firepower Firewall with Let’s Encrypt SSL Certificates, LDAP/Active 
Directory Primary Authentication and Duo 2FA Secondary Authentication

Author: Mr. Turritopsis Dohrnii Teo En Ming (Targeted Individual)
Country: Singapore
Date Published: 3rd August 2020 Monday Singapore Time
Type of Publication: Plain Text

INTRODUCTION
============

Cisco ASA firewall appliances use open source software.

Cisco Adaptive Security Appliance Software, version 9.8
Copyright (c) 1996-2019 by Cisco Systems, Inc.
For licenses and notices for open source software used in this product, 
please visit
http://www.cisco.com/go/asa-opensource

The basic configuration of the Cisco ASA 5506-X Firepower firewall was 
completed by a previous IT consultant previously (date unknown), so I 
shall not cover it here. I will cover configuration of the Cisco ASA 
5506-X Firepower firewall from Phase 1 onwards, as described below.

The Cisco ASA 5506-X Firepower firewall costs about SGD$1000 in 
Singapore, with refurbished units costing around SGD$500.

PHASE 1: Basic Configuration of SSL VPN on Cisco ASA 5506-X Firepower 
Firewall
==============================================================================

Reference Guide: Cisco ASA Anyconnect Remote Access VPN
Link: 
https://networklessons.com/cisco/asa-firewall/cisco-asa-anyconnect-remote-access-vpn

Cisco ASA firewall CLI commands:

enable

config t

You can download Cisco AnyConnect Secure Mobility Client version 
3.1.03103 at the following link.

http://www.firewall.cx/downloads/doc_details/98-anyconnect-secure-mobility-client-win-mac-linux.html?tmpl=component

Install Filezilla FTP server on the Active Directory Domain Controller.

Create ftp username “anonymous” with empty password.

copy ftp://anonymous@<IP address of FTP server>/ 
anyconnect-win-3.1.03103-k9.pkg

delete flash:filename.pkg

config t

webvpn

anyconnect image flash:/anyconnect-win-3.1.03103-k9.pkg

enable outside

anyconnect enable

sysopt connection permit-vpn

http redirect OUTSIDE 80

ip local pool VPN_POOL 192.168.168.100-192.168.168.200 mask 
255.255.255.0

192.168.168.0 is the VPN Pool.

access-list SPLIT_TUNNEL standard permit 192.168.1.0 255.255.255.0

192.168.1.0 is the inside network behind the Cisco ASA firewall.

group-policy ANYCONNECT_POLICY internal

group-policy ANYCONNECT_POLICY attributes

vpn-tunnel-protocol ssl-client ssl-clientless

split-tunnel-policy tunnelspecified

split-tunnel-network-list value SPLIT_TUNNEL

dns-server value 8.8.8.8

webvpn

anyconnect keep-installer installed

anyconnect ask none default anyconnect

anyconnect dpd-interval client 30

exit

tunnel-group MY_TUNNEL type remote-access

tunnel-group MY_TUNNEL general-attributes

default-group-policy ANYCONNECT_POLICY

address-pool VPN_POOL

exit

tunnel-group MY_TUNNEL webvpn-attributes

group-alias TEO_EN_MING_CORPORATION_SSL_VPN_USERS enable

username teo-en-ming password password

username teo-en-ming attributes

service-type remote-access

copy run start

PHASE 2: Installing 90-day Free Let's Encrypt SSL Certificate on Cisco 
ASA 5506-X Firepower Firewall SSL VPN
============================================================================================================

show flash

Check for asdm-xxx.bin

Go to https://<IP address of Cisco ASA 5506-X firewall>

Install Java Web Start

Install ASDM Launcher

On the Cisco ASDM:

Device IP address / Name: <private IP address of Cisco ASA 5506-X 
firewall>
Username: <empty>
Password: cisco <default password>

Follow the rest of the instructions at the following link.

Reference Guide: INSTALLING A FREE CERTIFICATE ON A CISCO ASA FIREWALL 
FOR ANYCONNECT
Link: 
https://www.ipconfigz.com/installing-a-free-certificate-on-a-cisco-asa-firewall-for-anyconnect/

copy run start

config t

pager 0

show run

PHASE 3: Configure LDAP/Active Directory Primary Authentication for 
Cisco ASA 5506-X SSL VPN
============================================================================================

Reference Guide: Configure LDAP Authentication for WebVPN Users
Link: 
https://www.cisco.com/c/en/us/support/docs/security/asa-5500-x-series-next-generation-firewalls/98625-asa-ldap-authentication.html

dsquery user -samid administrator
"CN=Administrator,CN=Users,DC=teo-en-ming-corp,DC=com"

enable

configure terminal

aaa-server LDAP_SRV_GRP protocol ldap

aaa-server LDAP_SRV_GRP (inside_1) host <private IP address of AD DC 
server>

ldap-base-dn dc=teo-en-ming-corp,dc=com

ldap-login-dn cn=ldapadmin,cn=users,dc=teo-en-ming-corp,dc=com

ldap-login-password password

ldap-naming-attribute sAMAccountName

ldap-scope subtree

server-type microsoft

exit

tunnel-group MY_TUNNEL general-att

authentication-server-group LDAP_SRV_GRP

Testing LDAP Authentication in Phase 3
======================================

debug ldap 255

test aaa-server authentication LDAP_SRV_GRP host <IP address of AD DC 
server> username administrator password password

Troubleshooting for Phase 3
============================

[1] Troubleshooting LDAP Connections to Active Directory Using Apache 
Directory Studio
Link: 
https://www.jamf.com/jamf-nation/articles/224/troubleshooting-ldap-connections-to-active-directory-using-apache-directory-studio

[2] Cisco – LDAP AAA Error ‘AAA Server has been removed”
Link: https://www.petenetlive.com/KB/Article/0001271

[3] ASA 9.8, Bridge groups, and LDAP authentication
Link: 
https://www.reddit.com/r/Cisco/comments/80qezi/asa_98_bridge_groups_and_ldap_authentication/

In this discussion, a Cisco ASA software bug has been found which 
prevents the Cisco ASA firewall from communicating with the LDAP 
server/Active Directory Domain Controller. To resolve this issue, a 
firmware upgrade is required.


PHASE 4: How to Install Duo 2FA Secondary Authentication for Cisco ASA 
5506-X SSL VPN
=====================================================================================

Follow the Duo Authentication setup instructions at the following link.

Reference Guide: Cisco ASA SSL VPN for Browser and AnyConnect
Link: https://duo.com/docs/ciscoasa-ldap

Then follow the guide below.

Reference Guide: CISCO ASA Enable DNS Lookup Problem
Link: 
https://community.cisco.com/t5/network-security/cisco-asa-enable-dns-lookup-problem/td-p/1764736

conf t

dns domain-lookup Outside

dns server-group DefaultDNS

name-server 8.8.8.8

name-server 8.8.4.4

exit

Phase 5: Upgrade Firmware and ASDM of Cisco ASA 5506-X Firepower 
Firewall
=========================================================================

copy run start

Follow the rest of the instructions at the following link.

Reference Guide: ASA 9.x : Upgrade a Software Image using ASDM or CLI 
Configuration Example
Link: 
https://www.cisco.com/c/en/us/support/docs/security/asa-5500-x-series-next-generation-firewalls/200142-ASA-9-x-Upgrade-a-Software-Image-using.html

Phase 6: Configure NAT Exemption on the Cisco ASA 5506-X Firewall
=================================================================

Why do we need to configure NAT exemption on the Cisco ASA 5506-X 
Firepower firewall? Because otherwise, the Cisco AnyConnect Secure 
Mobility Client cannot access the remote LAN
behind the Cisco ASA firewall.

access-list NAT-EXEMPT extended permit ip 192.168.1.0 255.255.255.0 
192.168.168.0 255.255.255.0

object network obj-vpn_ip_address_pool

subnet 192.168.168.0 255.255.255.0

nat (inside_1,outside) source static any any destination static 
obj-vpn_ip_address_pool obj-vpn_ip_address_pool

no access-list SPLIT_TUNNEL standard permit 192.168.1.0 255.255.255.0

MUST READ ARTICLES FOR PHASE 6
==============================

[1] Quick guide: AnyConnect Client VPN on Cisco ASA 5505
Link: 
https://www.techrepublic.com/blog/smb-technologist/quick-guide-anyconnect-client-vpn-on-cisco-asa-5505/

QUOTE:

"Do not use the same subnet as your inside network. So, if you're using 
192.168.100.0/24 for the inside, use 192.168.104.0/24 for your VPN 
pool."

[2] How to configure NAT Exemption in version 8.3 for VPN in Cisco ASA?
Link: 
http://networkqna.com/how-to-configure-nat-exemption-in-version-8-3-for-vpn-in-cisco-asa/

Phase 7: Configuring Dynamic DNS (DDNS)
=======================================

The Cisco ASA 5506-X Firepower Firewall does not support Dynamic DNS 
update using the HTTP POST method. The Cisco ASA only supports DDNS 
update using the Internet Engineering Task Force (IETF) method.

Since the Cisco ASA does not support the HTTP Post method, it CANNOT 
work with NO-IP and DynDNS DDNS service providers.

The following are the results of my research on the Internet:

[01] With its sole reliance on the IETF method, websites such as 
DynDns.org cannot be updated using the ASA, however support has been 
added for HTTPS using port 443.

Link: 
https://www.globalknowledge.com/ca-en/resources/resource-library/articles/implementing-dynamic-dns-on-cisco-ios-router-and-asa/

[02] If you're asking if you can get the ASA5505 to "register" with 
dyndns, the answer is no. Howeve, it appears that someone got a feature 
request added, though, under Cisco BugID CSCsl46782 . (If you don't have 
a Cisco service contract, you can't view the details). However, it looks 
like it has an extremely low priority and I wouldn't expect it to be 
added anytime soon.

Link: 
https://serverfault.com/questions/272825/dyndns-updating-ip-address-via-cisco-asa-5505

PROPOSED WORKAROUND SOLUTION FOR PHASE 7
========================================

I would propose installing Dynamic DNS updater client software on AD DC 
server or any of your office computers which are permanently powered on.

ACTUAL SOLUTION FOR PHASE 7
===========================

Sign up for free No-IP account.

Create hostname teo-en-ming-corp.ddns.net, and point it to public IP 
address of the Cisco ASA firewall.

Install no-ip dynamic update client (duc) in any 24x7 computer behind 
the Cisco ASA firewall.

Create DNS CNAME record sslvpn.teo-en-ming-corp.com and point it to 
teo-en-ming-corp.ddns.net

Phase 8: Synchronizing Users from Active Directory to Duo
=========================================================

Follow the setup instructions at the following link.

Reference Guide: Synchronizing Users from Active Directory
Link: https://duo.com/docs/adsync

dsquery user -samid teoenming
"CN=Turritopsis Dohrnii Teo En 
Ming,OU=Users,OU=Singapore,DC=teo-en-ming-corp,DC=com"

Phase 9: Enrolling Users at Duo
===============================

Reference Guide: Enrolling Users at Duo
Link: https://duo.com/docs/enrolling-users

Duo Admin Panel Login
Link: https://admin.duosecurity.com/

Phase 9 is the final phase.

===EOF===







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
