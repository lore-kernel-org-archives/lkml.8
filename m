Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BBBC3B186
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54CD02070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgBJV0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:26:50 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:59716 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgBJV0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 16:26:49 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 1350F29B4E; Mon, 10 Feb 2020 16:26:48 -0500 (EST)
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Chris Zankel <chris@zankel.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <0adf9819ded56830f460cd1643e9ce013ed33f6d.1581369531.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1581369530.git.fthain@telegraphics.com.au>
References: <cover.1581369530.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net-next 3/7] net/sonic: Remove redundant next_tx variable
Date:   Tue, 11 Feb 2020 08:18:50 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eol_tx variable is the one that matters to the tx algorithm because
packets are always placed at the end of the list. The next_tx variable
just confuses things so remove it.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/net/ethernet/natsemi/sonic.c | 8 ++++----
 drivers/net/ethernet/natsemi/sonic.h | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/natsemi/sonic.c b/drivers/net/ethernet/natsemi/sonic.c
index c066510b348e..9ecdd67e1410 100644
--- a/drivers/net/ethernet/natsemi/sonic.c
+++ b/drivers/net/ethernet/natsemi/sonic.c
@@ -300,7 +300,7 @@ static int sonic_send_packet(struct sk_buff *skb, struct net_device *dev)
 
 	spin_lock_irqsave(&lp->lock, flags);
 
-	entry = lp->next_tx;
+	entry = (lp->eol_tx + 1) & SONIC_TDS_MASK;
 
 	sonic_tda_put(dev, entry, SONIC_TD_STATUS, 0);       /* clear status */
 	sonic_tda_put(dev, entry, SONIC_TD_FRAG_COUNT, 1);   /* single fragment */
@@ -321,8 +321,8 @@ static int sonic_send_packet(struct sk_buff *skb, struct net_device *dev)
 				  sonic_tda_get(dev, lp->eol_tx, SONIC_TD_LINK) & ~SONIC_EOL);
 	lp->eol_tx = entry;
 
-	lp->next_tx = (entry + 1) & SONIC_TDS_MASK;
-	if (lp->tx_skb[lp->next_tx] != NULL) {
+	entry = (entry + 1) & SONIC_TDS_MASK;
+	if (lp->tx_skb[entry]) {
 		/* The ring is full, the ISR has yet to process the next TD. */
 		netif_dbg(lp, tx_queued, dev, "%s: stopping queue\n", __func__);
 		netif_stop_queue(dev);
@@ -811,7 +811,7 @@ static int sonic_init(struct net_device *dev)
 
 	SONIC_WRITE(SONIC_UTDA, lp->tda_laddr >> 16);
 	SONIC_WRITE(SONIC_CTDA, lp->tda_laddr & 0xffff);
-	lp->cur_tx = lp->next_tx = 0;
+	lp->cur_tx = 0;
 	lp->eol_tx = SONIC_NUM_TDS - 1;
 
 	/*
diff --git a/drivers/net/ethernet/natsemi/sonic.h b/drivers/net/ethernet/natsemi/sonic.h
index 053f12f5cf4a..3cbb62c860c8 100644
--- a/drivers/net/ethernet/natsemi/sonic.h
+++ b/drivers/net/ethernet/natsemi/sonic.h
@@ -321,7 +321,6 @@ struct sonic_local {
 	unsigned int cur_tx;           /* first unacked transmit packet */
 	unsigned int eol_rx;
 	unsigned int eol_tx;           /* last unacked transmit packet */
-	unsigned int next_tx;          /* next free TD */
 	int msg_enable;
 	struct device *device;         /* generic device */
 	struct net_device_stats stats;
-- 
2.24.1

