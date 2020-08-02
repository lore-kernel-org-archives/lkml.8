Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4E7C433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 13:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E4120738
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 13:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgHBNwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 09:52:09 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:56851 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHBNwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 09:52:08 -0400
Received: from localhost.localdomain ([93.22.148.198])
        by mwinf5d42 with ME
        id Ads5230064H42jh03ds5fw; Sun, 02 Aug 2020 15:52:06 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Aug 2020 15:52:06 +0200
X-ME-IP: 93.22.148.198
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     ralf@linux-mips.org, davem@davemloft.net, kuba@kernel.org,
        tbogendoerfer@suse.de
Cc:     linux-mips@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] net: sgi: ioc3-eth: Fix the size used in some 'dma_free_coherent()' calls
Date:   Sun,  2 Aug 2020 15:52:04 +0200
Message-Id: <20200802135204.690832-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the size used in 'dma_free_coherent()' in order to match the one
used in the corresponding 'dma_alloc_coherent()'.

Fixes: 369a782af0f1 ("net: sgi: ioc3-eth: ensure tx ring is 16k aligned.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 6646eba9f57f..6eef0f45b133 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -951,7 +951,7 @@ static int ioc3eth_probe(struct platform_device *pdev)
 		dma_free_coherent(ip->dma_dev, RX_RING_SIZE, ip->rxr,
 				  ip->rxr_dma);
 	if (ip->tx_ring)
-		dma_free_coherent(ip->dma_dev, TX_RING_SIZE, ip->tx_ring,
+		dma_free_coherent(ip->dma_dev, TX_RING_SIZE + SZ_16K - 1, ip->tx_ring,
 				  ip->txr_dma);
 out_free:
 	free_netdev(dev);
@@ -964,7 +964,7 @@ static int ioc3eth_remove(struct platform_device *pdev)
 	struct ioc3_private *ip = netdev_priv(dev);
 
 	dma_free_coherent(ip->dma_dev, RX_RING_SIZE, ip->rxr, ip->rxr_dma);
-	dma_free_coherent(ip->dma_dev, TX_RING_SIZE, ip->tx_ring, ip->txr_dma);
+	dma_free_coherent(ip->dma_dev, TX_RING_SIZE + SZ_16K - 1, ip->tx_ring, ip->txr_dma);
 
 	unregister_netdev(dev);
 	del_timer_sync(&ip->ioc3_timer);
-- 
2.25.1

