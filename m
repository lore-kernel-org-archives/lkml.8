Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F809C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D3424676
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgAVWYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 17:24:40 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47912 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAVWYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 17:24:03 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id DDCB4299C0; Wed, 22 Jan 2020 17:23:59 -0500 (EST)
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Chris Zankel <chris@zankel.net>,
        Laurent Vivier <laurent@vivier.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1b839d1752b28d3ee4089371577562c7211e59d4.1579730846.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1579730846.git.fthain@telegraphics.com.au>
References: <cover.1579730846.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net v3 09/12] net/sonic: Quiesce SONIC before re-initializing
 descriptor memory
Date:   Thu, 23 Jan 2020 09:07:26 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure the SONIC's DMA engine is idle before altering the transmit
and receive descriptors. Add a helper for this as it will be needed
again.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
Changed since v2:
 - Removed blank line.
---
 drivers/net/ethernet/natsemi/sonic.c | 25 +++++++++++++++++++++++++
 drivers/net/ethernet/natsemi/sonic.h |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/natsemi/sonic.c b/drivers/net/ethernet/natsemi/sonic.c
index 26848acec63d..42a6b87d8886 100644
--- a/drivers/net/ethernet/natsemi/sonic.c
+++ b/drivers/net/ethernet/natsemi/sonic.c
@@ -116,6 +116,24 @@ static int sonic_open(struct net_device *dev)
 	return 0;
 }
 
+/* Wait for the SONIC to become idle. */
+static void sonic_quiesce(struct net_device *dev, u16 mask)
+{
+	struct sonic_local * __maybe_unused lp = netdev_priv(dev);
+	int i;
+	u16 bits;
+
+	for (i = 0; i < 1000; ++i) {
+		bits = SONIC_READ(SONIC_CMD) & mask;
+		if (!bits)
+			return;
+		if (irqs_disabled() || in_interrupt())
+			udelay(20);
+		else
+			usleep_range(100, 200);
+	}
+	WARN_ONCE(1, "command deadline expired! 0x%04x\n", bits);
+}
 
 /*
  * Close the SONIC device
@@ -132,6 +150,9 @@ static int sonic_close(struct net_device *dev)
 	/*
 	 * stop the SONIC, disable interrupts
 	 */
+	SONIC_WRITE(SONIC_CMD, SONIC_CR_RXDIS);
+	sonic_quiesce(dev, SONIC_CR_ALL);
+
 	SONIC_WRITE(SONIC_IMR, 0);
 	SONIC_WRITE(SONIC_ISR, 0x7fff);
 	SONIC_WRITE(SONIC_CMD, SONIC_CR_RST);
@@ -171,6 +192,9 @@ static void sonic_tx_timeout(struct net_device *dev)
 	 * put the Sonic into software-reset mode and
 	 * disable all interrupts before releasing DMA buffers
 	 */
+	SONIC_WRITE(SONIC_CMD, SONIC_CR_RXDIS);
+	sonic_quiesce(dev, SONIC_CR_ALL);
+
 	SONIC_WRITE(SONIC_IMR, 0);
 	SONIC_WRITE(SONIC_ISR, 0x7fff);
 	SONIC_WRITE(SONIC_CMD, SONIC_CR_RST);
@@ -658,6 +682,7 @@ static int sonic_init(struct net_device *dev)
 	 */
 	SONIC_WRITE(SONIC_CMD, 0);
 	SONIC_WRITE(SONIC_CMD, SONIC_CR_RXDIS);
+	sonic_quiesce(dev, SONIC_CR_ALL);
 
 	/*
 	 * initialize the receive resource area
diff --git a/drivers/net/ethernet/natsemi/sonic.h b/drivers/net/ethernet/natsemi/sonic.h
index cc2f7b4b77e3..1df6d2f06cc4 100644
--- a/drivers/net/ethernet/natsemi/sonic.h
+++ b/drivers/net/ethernet/natsemi/sonic.h
@@ -110,6 +110,9 @@
 #define SONIC_CR_TXP            0x0002
 #define SONIC_CR_HTX            0x0001
 
+#define SONIC_CR_ALL (SONIC_CR_LCAM | SONIC_CR_RRRA | \
+		      SONIC_CR_RXEN | SONIC_CR_TXP)
+
 /*
  * SONIC data configuration bits
  */
-- 
2.24.1

