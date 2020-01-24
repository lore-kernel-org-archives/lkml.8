Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B8DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353EB22464
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579875706;
	bh=k5OAPK/Q9V2qMlz9alH4BM1w8L1wut7OFR8509l6y2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OsxeAnpRj8ICbCFddj6/V100byp58EZI8pzqUZXm0/C/G5E8ZahrAYOXgKXwXfZDl
	 UGpWTaF/b5cWY2Iq/FAhBvOmzEcJaBGXSQ8p+vBHUaK7fguqPqN8hjpTFhY8eJ4MFZ
	 MIe4EOOOLE7rIFPy2v/D9Vh0aLX41QCShWfoE41s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392212AbgAXOVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:21:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387774AbgAXOVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:21:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFC83222C2;
        Fri, 24 Jan 2020 14:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875702;
        bh=k5OAPK/Q9V2qMlz9alH4BM1w8L1wut7OFR8509l6y2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0FsK2cSg/VpT4w+0k2Bmd4W3iLOpTmigx+S5Un1QOsI5echHDveMPcXQbTO2mYnqK
         dilYAxhr1ormm9Qx88v/KnGGj6HflRgdoVp+gMWGBkdSA4dA2g94LtJu8HSu/1egEm
         pSdZ+G7YZwxlJrVFQd0WCTEFOiI9I8sBUm+u00m4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        RENARD Pierre-Francois <pfrenard@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 19/32] net: usb: lan78xx: limit size of local TSO packets
Date:   Fri, 24 Jan 2020 09:21:06 -0500
Message-Id: <20200124142119.30484-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124142119.30484-1-sashal@kernel.org>
References: <20200124142119.30484-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit f8d7408a4d7f60f8b2df0f81decdc882dd9c20dc ]

lan78xx_tx_bh() makes sure to not exceed MAX_SINGLE_PACKET_SIZE
bytes in the aggregated packets it builds, but does
nothing to prevent large GSO packets being submitted.

Pierre-Francois reported various hangs when/if TSO is enabled.

For localy generated packets, we can use netif_set_gso_max_size()
to limit the size of TSO packets.

Note that forwarded packets could still hit the issue,
so a complete fix might require implementing .ndo_features_check
for this driver, forcing a software segmentation if the size
of the TSO packet exceeds MAX_SINGLE_PACKET_SIZE.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: RENARD Pierre-Francois <pfrenard@gmail.com>
Tested-by: RENARD Pierre-Francois <pfrenard@gmail.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Woojung Huh <woojung.huh@microchip.com>
Cc: Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index c23f35dba7188..ee7194a9e2315 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3612,6 +3612,7 @@ static int lan78xx_probe(struct usb_interface *intf,
 
 	/* MTU range: 68 - 9000 */
 	netdev->max_mtu = MAX_SINGLE_PACKET_SIZE;
+	netif_set_gso_max_size(netdev, MAX_SINGLE_PACKET_SIZE - MAX_HEADER);
 
 	dev->ep_blkin = (intf->cur_altsetting)->endpoint + 0;
 	dev->ep_blkout = (intf->cur_altsetting)->endpoint + 1;
-- 
2.20.1

