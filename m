Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C982FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5C02468A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699442;
	bh=0QjlQtTTabmc9LN4ALwyRXkbHB9NqZWvRyzB4ypdrNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2dC4idK8qVj37qRc5jPuvQtfZjXrG9KDkf4/0AtXQ6dNAyGwNKPsNc2Rp0EfdGBxK
	 FIWPm7vgEnsqAs++N1pd8U0cyWXR2cibXrXessieijoXNnIHF+/m53DmxAL75pXGJB
	 BhIRO5oSTsg4GjjOUnMfnmvpQxN0A3WLXLlIWwL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbgAVNYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:24:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730155AbgAVNYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:24:00 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 625DA2467B;
        Wed, 22 Jan 2020 13:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699440;
        bh=0QjlQtTTabmc9LN4ALwyRXkbHB9NqZWvRyzB4ypdrNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWeJYeO/IOqPGKY6K6ZJR+2k2pGHBXopcjMbGQqeQjscwavr2+Nq8CqXF3VSnaFYw
         BxaJEk+nDmitdDXFo3s97/8aMWQG2Vn5+aJxH9IGMkwFfoLI/8bUDl9bFnQCmsa/Ry
         K5rkABRubipKunmlkCBuQ7DBQtFzQWQVoCOkZCzU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        RENARD Pierre-Francois <pfrenard@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 144/222] net: usb: lan78xx: limit size of local TSO packets
Date:   Wed, 22 Jan 2020 10:28:50 +0100
Message-Id: <20200122092844.041982912@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/lan78xx.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3750,6 +3750,7 @@ static int lan78xx_probe(struct usb_inte
 
 	/* MTU range: 68 - 9000 */
 	netdev->max_mtu = MAX_SINGLE_PACKET_SIZE;
+	netif_set_gso_max_size(netdev, MAX_SINGLE_PACKET_SIZE - MAX_HEADER);
 
 	dev->ep_blkin = (intf->cur_altsetting)->endpoint + 0;
 	dev->ep_blkout = (intf->cur_altsetting)->endpoint + 1;


