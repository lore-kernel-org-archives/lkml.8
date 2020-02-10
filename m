Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD893C3B187
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892422070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgBJV1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:27:01 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:59758 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgBJV0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 16:26:50 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 30EE529B51; Mon, 10 Feb 2020 16:26:48 -0500 (EST)
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Chris Zankel <chris@zankel.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <0124da144de7ddce8d1fe6d4fd72a17c343a5f04.1581369531.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1581369530.git.fthain@telegraphics.com.au>
References: <cover.1581369530.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net-next 5/7] net/sonic: Remove explicit memory barriers
Date:   Tue, 11 Feb 2020 08:18:50 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The explicit memory barriers are redundant now that proper locking and
MMIO accessors have been employed.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/net/ethernet/natsemi/sonic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/natsemi/sonic.c b/drivers/net/ethernet/natsemi/sonic.c
index 1d6de6706875..508c6a80fc6e 100644
--- a/drivers/net/ethernet/natsemi/sonic.c
+++ b/drivers/net/ethernet/natsemi/sonic.c
@@ -311,12 +311,10 @@ static int sonic_send_packet(struct sk_buff *skb, struct net_device *dev)
 	sonic_tda_put(dev, entry, SONIC_TD_LINK,
 		sonic_tda_get(dev, entry, SONIC_TD_LINK) | SONIC_EOL);
 
-	wmb();
 	lp->tx_len[entry] = length;
 	lp->tx_laddr[entry] = laddr;
 	lp->tx_skb[entry] = skb;
 
-	wmb();
 	sonic_tda_put(dev, lp->eol_tx, SONIC_TD_LINK,
 				  sonic_tda_get(dev, lp->eol_tx, SONIC_TD_LINK) & ~SONIC_EOL);
 	lp->eol_tx = entry;
-- 
2.24.1

