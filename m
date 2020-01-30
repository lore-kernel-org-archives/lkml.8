Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98FDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B75217BA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409874;
	bh=m6bc5YESLPX3tHV+DdMc2TMiL3pkOqdd2l98jsO9fXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UxjY96hziTHz1oO1qaC7mCkQUUyfFo07jw35QtFH3p7AN3ZZofOHYn0yRJ05lem7r
	 /ZAVmoU8vVKeKFPlNZkybQARbXY7rZHSz2AHoj/pl3d2ir3eyLPHnGy8jrq+LXy6H0
	 8GOGk1y8uJhriPB/rErrwUbr/JQfWBHHgq5IxDrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbgA3Soc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:44:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730835AbgA3So3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:44:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A043C2173E;
        Thu, 30 Jan 2020 18:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409869;
        bh=m6bc5YESLPX3tHV+DdMc2TMiL3pkOqdd2l98jsO9fXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JBzlMkxoxBC8pAejmHCjkHUdzR6miySMfAzyiiCO28sKTKrYP0ToxVQek63yc4/d0
         TqAcO0xPtA7UBiCQNtwezVsI7bvjvAqSZg6aEY6Af4jtiaP7Skeq5hgAPF+ALwfVKL
         1fDvOO75sPN/jt4eRHjbVJL3Y6zPcoxhWcdkHUw8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Si-Wei Liu <si-wei.liu@oracle.com>,
        Liran Alon <liran.alon@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 066/110] net: Google gve: Remove dma_wmb() before ringing doorbell
Date:   Thu, 30 Jan 2020 19:38:42 +0100
Message-Id: <20200130183622.527019051@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183613.810054545@linuxfoundation.org>
References: <20200130183613.810054545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liran Alon <liran.alon@oracle.com>

[ Upstream commit b54ef37b1ce892fdf6b632d566246d2f2f539910 ]

Current code use dma_wmb() to ensure Rx/Tx descriptors are visible
to device before writing to doorbell.

However, these dma_wmb() are wrong and unnecessary. Therefore,
they should be removed.

iowrite32be() called from gve_rx_write_doorbell()/gve_tx_put_doorbell()
should guaratee that all previous writes to WB/UC memory is visible to
device before the write done by iowrite32be().

E.g. On ARM64, iowrite32be() calls __iowmb() which expands to dma_wmb()
and only then calls __raw_writel().

Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_rx.c | 2 --
 drivers/net/ethernet/google/gve/gve_tx.c | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index edec61dfc8687..9f52e72ff641d 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -418,8 +418,6 @@ bool gve_clean_rx_done(struct gve_rx_ring *rx, int budget,
 	rx->cnt = cnt;
 	rx->fill_cnt += work_done;
 
-	/* restock desc ring slots */
-	dma_wmb();	/* Ensure descs are visible before ringing doorbell */
 	gve_rx_write_doorbell(priv, rx);
 	return gve_rx_work_pending(rx);
 }
diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index f4889431f9b70..d0244feb03011 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -487,10 +487,6 @@ netdev_tx_t gve_tx(struct sk_buff *skb, struct net_device *dev)
 		 * may have added descriptors without ringing the doorbell.
 		 */
 
-		/* Ensure tx descs from a prior gve_tx are visible before
-		 * ringing doorbell.
-		 */
-		dma_wmb();
 		gve_tx_put_doorbell(priv, tx->q_resources, tx->req);
 		return NETDEV_TX_BUSY;
 	}
@@ -505,8 +501,6 @@ netdev_tx_t gve_tx(struct sk_buff *skb, struct net_device *dev)
 	if (!netif_xmit_stopped(tx->netdev_txq) && netdev_xmit_more())
 		return NETDEV_TX_OK;
 
-	/* Ensure tx descs are visible before ringing doorbell */
-	dma_wmb();
 	gve_tx_put_doorbell(priv, tx->q_resources, tx->req);
 	return NETDEV_TX_OK;
 }
-- 
2.20.1



