Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6CBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DC002083B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgHYOHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:07:08 -0400
Received: from ec2-3-21-30-127.us-east-2.compute.amazonaws.com ([3.21.30.127]:59940
        "EHLO www.teo-en-ming.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHYOHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:07:05 -0400
Received: from localhost (localhost [IPv6:::1])
        by www.teo-en-ming.com (Postfix) with ESMTPA id 00186426B9B;
        Tue, 25 Aug 2020 22:07:03 +0800 (+08)
MIME-Version: 1.0
Date:   Tue, 25 Aug 2020 22:07:03 +0800
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming.com>
To:     linux-kernel@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Subject: Configuring Fortigate 60D Firewall SSL VPN with FortiToken 2FA
 (Advanced Configuration)
Message-ID: <fac273f8cd4cde443b1f9fdd047d208e@teo-en-ming.com>
X-Sender: ceo@teo-en-ming.com
User-Agent: Roundcube Webmail/1.2.3
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Configuring Fortigate 60D Firewall SSL VPN with FortiToken 2FA 
(Advanced Configuration)

Author: Mr. Turritopsis Dohrnii Teo En Ming
Country: Singapore
Date: 25 August 2020 Tuesday Singapore Time
Type of Publication: PDF Manual
Document Version: 20200825.01

INTRODUCTION
============

Fortigate firewall appliances are based on Linux Kernel and open source 
software.

In this PDF manual, I will show you how to:

1.	Install Windows Server 2019 Standard as a virtual machine in Linux 
KVM/QEMU Hypervisor
2.	Install Active Directory Domain Services role/feature
3.	Promote Windows Server 2019 Standard to Domain Controller
4.	Create organizational units in Active Directory Users and Computers
5.	Create Active Directory user
6.	Create security group for SSL VPN users
7.	Assign Active Directory user to the SSL VPN Users security group
8.	Add LDAP server (Microsoft Active Directory/LDAP integration) in 
Fortigate 60D firewall
9.	Add user group from LDAP server in Fortigate 60D firewall (remember 
to add members of the group as well)
10.	Add LDAP user in Fortigate 60D firewall
11.	Configure SSL VPN tunnel in Fortigate 60D firewall
12.	Configure two firewall security policies to allow VPN users to 
access the (a) internal network and the (b) internet
13.	Assign FortiToken to LDAP user in Fortigate 60D firewall and turn on 
2nd Factor Authentication (2FA)
14.	Create VPN tunnel in FortiClient VPN on your Android phone and 
connect to Fortigate 60D SSL VPN tunnel successfully
15.	FortiClient VPN will now ask you for the token code

Redundant Google Drive download links for my PDF manual
=======================================================

[1] 
https://drive.google.com/file/d/1uhRWr8OXerCN30OeWhgFP8rG_4NlkHsa/view?usp=sharing

[2] 
https://drive.google.com/file/d/1mJ5m7zlPFLXuXfKgfLcq_nAGP1jC2QlC/view?usp=sharing

[3] 
https://drive.google.com/file/d/1ZU7aphOXIG3q8-1g6GSRXX2hXgG7AibU/view?usp=sharing

[4] 
https://drive.google.com/file/d/1IKVeGJZ5HPR6hAsRwxTHfABBLjKz9uyl/view?usp=sharing

[5] 
https://drive.google.com/file/d/1nwC7VlA3p0U2apmsOlH6mADrX84wxTNM/view?usp=sharing

[6] 
https://drive.google.com/file/d/1mXT3TdX8dtCDA1YeoX7oRxk3mSgcoN6P/view?usp=sharing








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
