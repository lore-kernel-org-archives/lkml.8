Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E22C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C44B204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597692068;
	bh=qwmtcEJWzec+yfxtt+Irjpf9GYAZv4tTy6m8cR9ZZtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GKavcbDtAGNF8MKSZKGh5bzM3uKOMN1VAkOqmG4TmNmPnBDML0Hg49K2fhuX6FrHq
	 5PEHLtiBPeoF+reXf47Gxzq7Qv7uvlrmL9jrX4X5+qZ2ekCC3vuqQk1DUrsP6e3Z5o
	 jevzint5FGsAe8UphQCgiVzwhvCI1mMuRx391YTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392347AbgHQTUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730479AbgHQPgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:36:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8045722EBF;
        Mon, 17 Aug 2020 15:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678595;
        bh=qwmtcEJWzec+yfxtt+Irjpf9GYAZv4tTy6m8cR9ZZtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mvXoL68hehA6y391YWcuMJ6p8MFh6wks6N1YHMbmE+ZCfotCpLWoaP3oClSJ/KpUD
         c5WN2SXV5qNw1W4LlWPgBsQZxnHlScI+sDl0EA6+NQIG3G40kykUPOMTxNb/RP86QD
         Lyg/2ckem71fAGqPzBmiRAmO/OF9sPhMBZEL61z4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 358/464] net: sgi: ioc3-eth: Fix the size used in some dma_free_coherent() calls
Date:   Mon, 17 Aug 2020 17:15:11 +0200
Message-Id: <20200817143850.915899553@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit edab74e9cb1d073c70add0f9b75e17aebf0598ff ]

Update the size used in 'dma_free_coherent()' in order to match the one
used in the corresponding 'dma_alloc_coherent()'.

Fixes: 369a782af0f1 ("net: sgi: ioc3-eth: ensure tx ring is 16k aligned.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 6646eba9f57fe..6eef0f45b133b 100644
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



