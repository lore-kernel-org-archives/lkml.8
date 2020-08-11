Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F51C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64484204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgHKOfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:35:11 -0400
Received: from ec2-3-21-30-127.us-east-2.compute.amazonaws.com ([3.21.30.127]:49886
        "EHLO www.teo-en-ming.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbgHKOfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:35:10 -0400
Received: from localhost (localhost [IPv6:::1])
        by www.teo-en-ming.com (Postfix) with ESMTPA id B61C343A8BF;
        Tue, 11 Aug 2020 22:35:08 +0800 (+08)
MIME-Version: 1.0
Date:   Tue, 11 Aug 2020 22:35:08 +0800
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming.com>
To:     linux-kernel@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Subject: How to Setup TWO DMZ Zones (DMZ1 and DMZ2) on the Cisco ASA 5506-X
 Firewall
Message-ID: <5bbe3ed461b0f0da8a39a7eb5416749f@teo-en-ming.com>
X-Sender: ceo@teo-en-ming.com
User-Agent: Roundcube Webmail/1.2.3
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: How to Setup TWO DMZ Zones (DMZ1 and DMZ2) on the Cisco ASA 
5506-X Firewall

Author: Mr. Turritopsis Dohrnii Teo En Ming (Targeted Individual)
Country: Singapore, Singapore, Singapore
Date: 11 August 2020 Tuesday Singapore Time
Type of Publication: Plain Text

Cisco ASA firewall appliances are based on open source software.

Reference Guide: Cisco ASA DMZ Configuration Example
Link: https://www.speaknetworks.com/cisco-asa-dmz-configuration-example/

Cisco ASA CLI commands:

interface GigabitEthernet1/6
description to DMZ1
nameif dmz1
security-level 50
ip address 192.168.1.1 255.255.255.0

interface GigabitEthernet1/7
description to DMZ2
nameif dmz2
security-level 50
ip address 192.168.2.1 255.255.255.0

nat (dmz1,outside) after-auto source dynamic any interface
nat (dmz2,outside) after-auto source dynamic any interface

object network DMZ1SERVER-EXT
host <public WAN IP address #1>

object network DMZ1SERVER-INT
host 192.168.1.10

nat (dmz1,outside) static DMZ1SERVER-EXT service tcp ssh ssh

access-list OUTSIDE extended permit tcp any object DMZ1SERVER-INT eq ssh

access-group OUTSIDE in interface outside

object network DMZ2SERVER-EXT
host <public WAN IP address #2>

object network DMZ2SERVER-INT
host 192.168.2.10

nat (dmz2,outside) static DMZ2SERVER-EXT service tcp ssh ssh

access-list OUTSIDE extended permit tcp any object DMZ2SERVER-INT eq ssh

access-group OUTSIDE in interface outside

copy run start

Additional Learning Material
============================

Reference Guide: Remote Access IPsec VPNs
Link: 
https://www.cisco.com/c/en/us/td/docs/security/asa/asa95/configuration/vpn/asa-95-vpn-config/vpn-remote-access.html






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
