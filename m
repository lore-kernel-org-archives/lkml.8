Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35C8C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB90220684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436664AbgAPSZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:25:45 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:51371 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395500AbgAPSZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:25:41 -0500
X-Originating-IP: 109.204.130.2
Received: from kurenai.i.gensoukyou.net (unknown [109.204.130.2])
        (Authenticated sender: oranenj@gensoukyou.net)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id C8D311C0012
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 18:25:38 +0000 (UTC)
To:     linux-kernel@vger.kernel.org
From:   Jarkko Oranen <oranenj@iki.fi>
Subject: Linux router responds to any ARP query when iproute2 xfrm policies
 are configured for an IPSec tunnel. What's going on?
Message-ID: <4efb35fb-d2ee-49e7-8c7d-e8bab315ca60@iki.fi>
Date:   Thu, 16 Jan 2020 20:25:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First of all, I'm not currently subscribed to LKML, so please CC any 
replies.

I recently debugged a DHCP client which refused to accept a lease, and 
noticed that my router seems to reply to ARP requests for any IP 
address, apparently causing the client to think it was receiving a 
duplicate IP.

After some debugging, I learned that my router will respond to any ARP 
query if the IP falls within the traffic selector I'm using for my xfrm 
interface-based IPSec VPN. For example:

$ arping 1.1.1.1

ARPING 1.1.1.1 from 10.21.1.10 enp7s0

Unicast reply from 1.1.1.1 [00:0D:B9:4B:07:C1]  1.449ms


I tried changing the various ARP-related sysctls, but they had no effect 
on this behaviour. It stops immediately if I kill the IPSec tunnel and 
the xfrm policies are removed.

The xfrm interface is created simply with
   ip link add st0 type xfrm dev eth0 if_id 1
and 10/8 is routed to it, though this doesn't seem to matter.

When the IPSec tunnel is up and running, it configures xfrm policies 
like so:

src 0.0.0.0/0 dst 0.0.0.0/0

	dir out priority 399999 ptype main

	tmpl src <my-ip> dst <remote-ip>

		proto esp spi 0xc5a3f611 reqid 1 mode tunnel

	if_id 0x1

src 0.0.0.0/0 dst 0.0.0.0/0

	dir fwd priority 399999 ptype main

	tmpl src <remote-ip> dst <my-ip>

		proto esp reqid 1 mode tunnel

	if_id 0x1

src 0.0.0.0/0 dst 0.0.0.0/0

	dir in priority 399999 ptype main

	tmpl src <remote-ip> dst <my-ip>

		proto esp reqid 1 mode tunnel

	if_id 0x1

src 0.0.0.0/0 dst 0.0.0.0/0

	socket in priority 0 ptype main

src 0.0.0.0/0 dst 0.0.0.0/0

	socket out priority 0 ptype main

src 0.0.0.0/0 dst 0.0.0.0/0

	socket in priority 0 ptype main

src 0.0.0.0/0 dst 0.0.0.0/0

	socket out priority 0 ptype main

src ::/0 dst ::/0

	socket in priority 0 ptype main

src ::/0 dst ::/0

	socket out priority 0 ptype main

src ::/0 dst ::/0

	socket in priority 0 ptype main

src ::/0 dst ::/0

	socket out priority 0 ptype main


The traffic selector affects what ARP requests the router responds to, 
so if I change it to 10.0.0.0/8, it will respond to any ARP request for 
IPs in that range.

This is happening on Alpine Linux running kernel version 5.4.12-1-lts.

Is this expected behaviour? I would appreciate some pointers.

--
Jarkko Oranen
