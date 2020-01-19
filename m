Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02002C33CAF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 23:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68EC20714
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 23:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgASXRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 18:17:37 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:49810 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbgASXQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 18:16:33 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 9AEFE29989; Sun, 19 Jan 2020 18:16:31 -0500 (EST)
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Chris Zankel <chris@zankel.net>,
        Laurent Vivier <laurent@vivier.eu>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <ef679c41a39f64a495cc7d7953e5e995825ab034.1579474569.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1579474569.git.fthain@telegraphics.com.au>
References: <cover.1579474569.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net 18/19] net/sonic: Fix CAM initialization
Date:   Mon, 20 Jan 2020 09:56:09 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Section 4.3.1 of the datasheet says,

    This bit [TXP] must not be set if a Load CAM operation is in
    progress (LCAM is set). The SONIC will lock up if both bits are
    set simultaneously.

Testing has shown that the driver sometimes attempts to set LCAM
while TXP is set. Avoid this by waiting for command completion
before and after giving the LCAM command.

After issuing the Load CAM command, poll for !SONIC_CR_LCAM rather than
SONIC_INT_LCD, because the SONIC_CR_TXP bit can't be used until
!SONIC_CR_LCAM.

When in reset mode, take the opportunity to reset the CAM Enable
register.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/net/ethernet/natsemi/sonic.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/natsemi/sonic.c b/drivers/net/ethernet/natsemi/sonic.c
index 01055a53517d..1a569df63fde 100644
--- a/drivers/net/ethernet/natsemi/sonic.c
+++ b/drivers/net/ethernet/natsemi/sonic.c
@@ -661,6 +661,8 @@ static void sonic_multicast_list(struct net_device *dev)
 		    (netdev_mc_count(dev) > 15)) {
 			rcr |= SONIC_RCR_AMC;
 		} else {
+			unsigned long flags;
+
 			netif_dbg(lp, ifup, dev, "%s: mc_count %d\n", __func__,
 				  netdev_mc_count(dev));
 			sonic_set_cam_enable(dev, 1);  /* always enable our own address */
@@ -674,9 +676,14 @@ static void sonic_multicast_list(struct net_device *dev)
 				i++;
 			}
 			SONIC_WRITE(SONIC_CDC, 16);
-			/* issue Load CAM command */
 			SONIC_WRITE(SONIC_CDP, lp->cda_laddr & 0xffff);
+
+			/* LCAM and TXP commands can't be used simultaneously */
+			local_irq_save(flags);
+			sonic_quiesce(dev, SONIC_CR_TXP);
 			SONIC_WRITE(SONIC_CMD, SONIC_CR_LCAM);
+			sonic_quiesce(dev, SONIC_CR_LCAM);
+			local_irq_restore(flags);
 		}
 	}
 
@@ -702,6 +709,9 @@ static int sonic_init(struct net_device *dev)
 	SONIC_WRITE(SONIC_ISR, 0x7fff);
 	SONIC_WRITE(SONIC_CMD, SONIC_CR_RST);
 
+	/* While in reset mode, clear CAM Enable register */
+	SONIC_WRITE(SONIC_CE, 0);
+
 	/*
 	 * clear software reset flag, disable receiver, clear and
 	 * enable interrupts, then completely initialize the SONIC
@@ -812,14 +822,7 @@ static int sonic_init(struct net_device *dev)
 	 * load the CAM
 	 */
 	SONIC_WRITE(SONIC_CMD, SONIC_CR_LCAM);
-
-	i = 0;
-	while (i++ < 100) {
-		if (SONIC_READ(SONIC_ISR) & SONIC_INT_LCD)
-			break;
-	}
-	netif_dbg(lp, ifup, dev, "%s: CMD=%x, ISR=%x, i=%d\n", __func__,
-		  SONIC_READ(SONIC_CMD), SONIC_READ(SONIC_ISR), i);
+	sonic_quiesce(dev, SONIC_CR_LCAM);
 
 	/*
 	 * enable receiver, disable loopback
-- 
2.24.1

