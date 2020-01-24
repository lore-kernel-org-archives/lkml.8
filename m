Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB5BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49942075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865731;
	bh=8c+2tFdN24FrAVsa6vdFiza2LyH0hnYaDNcV2+0fWmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kuNItxd5iuWAj3jfxRcdVWG45nXYYiNm+XdxX0Et9E4RmgTtLRGb9o9b8awEeho4o
	 vfq5khMmXPiKA2myB5ZRDB+grjKtbT4RYO7F54SLgPtkjliIoo3exU8yiQrGZ+LxOb
	 aSkiRLo269nBj9L8MINlBFbku6jgIMIPbM+64wkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391921AbgAXLfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:35:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388424AbgAXLf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:35:27 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7782324125;
        Fri, 24 Jan 2020 11:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865726;
        bh=8c+2tFdN24FrAVsa6vdFiza2LyH0hnYaDNcV2+0fWmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFKKOEoU9paxW78iI2mo8peFWXxnTMEffM/g3UnBolUJbcIK/UayUG0FdJbuf4auh
         ryj8y7aJvyWOdyxshvw2WJ4CZnB4ZHkuTxjNFP0ltjirde+EQ0/neLHffsNrtceTLN
         EnvJuDCn2rF06+rhUL9rln1F0huOS06c8zoyZV3k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 621/639] dpaa_eth: avoid timestamp read on error paths
Date:   Fri, 24 Jan 2020 10:33:11 +0100
Message-Id: <20200124093207.423730378@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madalin Bucur <madalin.bucur@nxp.com>

[ Upstream commit 9a4f4f3a894ff4487f5597b7aabba9432b238292 ]

The dpaa_cleanup_tx_fd() function is called by the frame transmit
confirmation callback but also on several error paths. This function
is reading the transmit timestamp value. Avoid reading an invalid
timestamp value on the error paths.

Fixes: 4664856e9ca2 ("dpaa_eth: add support for hardware timestamping")
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 3cd62a71ddea8..d7736c9c6339a 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -1600,13 +1600,15 @@ static int dpaa_eth_refill_bpools(struct dpaa_priv *priv)
  * Skb freeing is not handled here.
  *
  * This function may be called on error paths in the Tx function, so guard
- * against cases when not all fd relevant fields were filled in.
+ * against cases when not all fd relevant fields were filled in. To avoid
+ * reading the invalid transmission timestamp for the error paths set ts to
+ * false.
  *
  * Return the skb backpointer, since for S/G frames the buffer containing it
  * gets freed here.
  */
 static struct sk_buff *dpaa_cleanup_tx_fd(const struct dpaa_priv *priv,
-					  const struct qm_fd *fd)
+					  const struct qm_fd *fd, bool ts)
 {
 	const enum dma_data_direction dma_dir = DMA_TO_DEVICE;
 	struct device *dev = priv->net_dev->dev.parent;
@@ -1648,7 +1650,8 @@ static struct sk_buff *dpaa_cleanup_tx_fd(const struct dpaa_priv *priv,
 	}
 
 	/* DMA unmapping is required before accessing the HW provided info */
-	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {
+	if (ts && priv->tx_tstamp &&
+	    skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {
 		memset(&shhwtstamps, 0, sizeof(shhwtstamps));
 
 		if (!fman_port_get_tstamp(priv->mac_dev->port[TX], (void *)skbh,
@@ -2118,7 +2121,7 @@ dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 	if (likely(dpaa_xmit(priv, percpu_stats, queue_mapping, &fd) == 0))
 		return NETDEV_TX_OK;
 
-	dpaa_cleanup_tx_fd(priv, &fd);
+	dpaa_cleanup_tx_fd(priv, &fd, false);
 skb_to_fd_failed:
 enomem:
 	percpu_stats->tx_errors++;
@@ -2164,7 +2167,7 @@ static void dpaa_tx_error(struct net_device *net_dev,
 
 	percpu_priv->stats.tx_errors++;
 
-	skb = dpaa_cleanup_tx_fd(priv, fd);
+	skb = dpaa_cleanup_tx_fd(priv, fd, false);
 	dev_kfree_skb(skb);
 }
 
@@ -2205,7 +2208,7 @@ static void dpaa_tx_conf(struct net_device *net_dev,
 
 	percpu_priv->tx_confirm++;
 
-	skb = dpaa_cleanup_tx_fd(priv, fd);
+	skb = dpaa_cleanup_tx_fd(priv, fd, true);
 
 	consume_skb(skb);
 }
@@ -2435,7 +2438,7 @@ static void egress_ern(struct qman_portal *portal,
 	percpu_priv->stats.tx_fifo_errors++;
 	count_ern(percpu_priv, msg);
 
-	skb = dpaa_cleanup_tx_fd(priv, fd);
+	skb = dpaa_cleanup_tx_fd(priv, fd, false);
 	dev_kfree_skb_any(skb);
 }
 
-- 
2.20.1



