Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A43C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9D12465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgAVWZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 17:25:00 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47776 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgAVWYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 17:24:02 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 4DA5B299A6; Wed, 22 Jan 2020 17:23:59 -0500 (EST)
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Chris Zankel <chris@zankel.net>,
        Laurent Vivier <laurent@vivier.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <7927d3de3f46e660c0112aefb1a63bf1584c187d.1579730846.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1579730846.git.fthain@telegraphics.com.au>
References: <cover.1579730846.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net v3 02/12] net/sonic: Clear interrupt flags immediately
Date:   Thu, 23 Jan 2020 09:07:26 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The chip can change a packet's descriptor status flags at any time.
However, an active interrupt flag gets cleared rather late. This
allows a race condition that could theoretically lose an interrupt.
Fix this by clearing asserted interrupt flags immediately.

Fixes: efcce839360f ("[PATCH] macsonic/jazzsonic network drivers update")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/net/ethernet/natsemi/sonic.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/natsemi/sonic.c b/drivers/net/ethernet/natsemi/sonic.c
index 8a7cff516281..1109070a5154 100644
--- a/drivers/net/ethernet/natsemi/sonic.c
+++ b/drivers/net/ethernet/natsemi/sonic.c
@@ -304,10 +304,11 @@ static irqreturn_t sonic_interrupt(int irq, void *dev_id)
 	}
 
 	do {
+		SONIC_WRITE(SONIC_ISR, status); /* clear the interrupt(s) */
+
 		if (status & SONIC_INT_PKTRX) {
 			netif_dbg(lp, intr, dev, "%s: packet rx\n", __func__);
 			sonic_rx(dev);	/* got packet(s) */
-			SONIC_WRITE(SONIC_ISR, SONIC_INT_PKTRX); /* clear the interrupt */
 		}
 
 		if (status & SONIC_INT_TXDN) {
@@ -362,7 +363,6 @@ static irqreturn_t sonic_interrupt(int irq, void *dev_id)
 			if (freed_some || lp->tx_skb[entry] == NULL)
 				netif_wake_queue(dev);  /* The ring is no longer full */
 			lp->cur_tx = entry;
-			SONIC_WRITE(SONIC_ISR, SONIC_INT_TXDN); /* clear the interrupt */
 		}
 
 		/*
@@ -372,42 +372,31 @@ static irqreturn_t sonic_interrupt(int irq, void *dev_id)
 			netif_dbg(lp, rx_err, dev, "%s: rx fifo overrun\n",
 				  __func__);
 			lp->stats.rx_fifo_errors++;
-			SONIC_WRITE(SONIC_ISR, SONIC_INT_RFO); /* clear the interrupt */
 		}
 		if (status & SONIC_INT_RDE) {
 			netif_dbg(lp, rx_err, dev, "%s: rx descriptors exhausted\n",
 				  __func__);
 			lp->stats.rx_dropped++;
-			SONIC_WRITE(SONIC_ISR, SONIC_INT_RDE); /* clear the interrupt */
 		}
 		if (status & SONIC_INT_RBAE) {
 			netif_dbg(lp, rx_err, dev, "%s: rx buffer area exceeded\n",
 				  __func__);
 			lp->stats.rx_dropped++;
-			SONIC_WRITE(SONIC_ISR, SONIC_INT_RBAE); /* clear the interrupt */
 		}
 
 		/* counter overruns; all counters are 16bit wide */
-		if (status & SONIC_INT_FAE) {
+		if (status & SONIC_INT_FAE)
 			lp->stats.rx_frame_errors += 65536;
-			SONIC_WRITE(SONIC_ISR, SONIC_INT_FAE); /* clear the interrupt */
-		}
-		if (status & SONIC_INT_CRC) {
+		if (status & SONIC_INT_CRC)
 			lp->stats.rx_crc_errors += 65536;
-			SONIC_WRITE(SONIC_ISR, SONIC_INT_CRC); /* clear the interrupt */
-		}
-		if (status & SONIC_INT_MP) {
+		if (status & SONIC_INT_MP)
 			lp->stats.rx_missed_errors += 65536;
-			SONIC_WRITE(SONIC_ISR, SONIC_INT_MP); /* clear the interrupt */
-		}
 
 		/* transmit error */
-		if (status & SONIC_INT_TXER) {
+		if (status & SONIC_INT_TXER)
 			if (SONIC_READ(SONIC_TCR) & SONIC_TCR_FU)
 				netif_dbg(lp, tx_err, dev, "%s: tx fifo underrun\n",
 					  __func__);
-			SONIC_WRITE(SONIC_ISR, SONIC_INT_TXER); /* clear the interrupt */
-		}
 
 		/* bus retry */
 		if (status & SONIC_INT_BR) {
@@ -416,13 +405,8 @@ static irqreturn_t sonic_interrupt(int irq, void *dev_id)
 			/* ... to help debug DMA problems causing endless interrupts. */
 			/* Bounce the eth interface to turn on the interrupt again. */
 			SONIC_WRITE(SONIC_IMR, 0);
-			SONIC_WRITE(SONIC_ISR, SONIC_INT_BR); /* clear the interrupt */
 		}
 
-		/* load CAM done */
-		if (status & SONIC_INT_LCD)
-			SONIC_WRITE(SONIC_ISR, SONIC_INT_LCD); /* clear the interrupt */
-
 		status = SONIC_READ(SONIC_ISR) & SONIC_IMR_DEFAULT;
 	} while (status);
 
-- 
2.24.1

