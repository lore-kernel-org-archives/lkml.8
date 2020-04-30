Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034FFC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8D602076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255727;
	bh=xxlon5SXE49wUSaaUMDJaJatz3yptoEVissdAYJWjpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e+Sd8EqP2wG2l7JUP401muQsMEj5aMbwLzhxlqmroarG/kr2aqeSgiXB/+V3a5LdI
	 S6diS95e6cYGqBT8V29vF8d5eYuWPcDO6A5z6MlvhPt0CdO+khavshZwSAGfiYaOG6
	 TLHv4eNwCWKvCDhXhYXUedujZu+vzsG1s8tCW9D8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgD3OIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:32796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbgD3NwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:52:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FC7024958;
        Thu, 30 Apr 2020 13:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254724;
        bh=xxlon5SXE49wUSaaUMDJaJatz3yptoEVissdAYJWjpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B0UlNJA+TLji+bdKSy9YJZuCIa0pmQPoHKnXghQvYIbYLHG44P1JTYjKHmrEt8BrJ
         5M/b0Zzxx+PyPctYAPqjkMx+9sAq9t2iyT48fR4R33F3q6iRJzhnhXQHDmklV0slo4
         VXCaKJSXr71d4b5hs7IejtzvbKj8f/4Q5S+nGWxk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 72/79] net: bcmgenet: suppress warnings on failed Rx SKB allocations
Date:   Thu, 30 Apr 2020 09:50:36 -0400
Message-Id: <20200430135043.19851-72-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135043.19851-1-sashal@kernel.org>
References: <20200430135043.19851-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit ecaeceb8a8a145d93c7e136f170238229165348f ]

The driver is designed to drop Rx packets and reclaim the buffers
when an allocation fails, and the network interface needs to safely
handle this packet loss. Therefore, an allocation failure of Rx
SKBs is relatively benign.

However, the output of the warning message occurs with a high
scheduling priority that can cause excessive jitter/latency for
other high priority processing.

This commit suppresses the warning messages to prevent scheduling
problems while retaining the failure count in the statistics of
the network interface.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index b7c0c20e13258..5fd1a9dfcfff3 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1625,7 +1625,8 @@ static struct sk_buff *bcmgenet_rx_refill(struct bcmgenet_priv *priv,
 	dma_addr_t mapping;
 
 	/* Allocate a new Rx skb */
-	skb = netdev_alloc_skb(priv->dev, priv->rx_buf_len + SKB_ALIGNMENT);
+	skb = __netdev_alloc_skb(priv->dev, priv->rx_buf_len + SKB_ALIGNMENT,
+				 GFP_ATOMIC | __GFP_NOWARN);
 	if (!skb) {
 		priv->mib.alloc_rx_buff_failed++;
 		netif_err(priv, rx_err, priv->dev,
-- 
2.20.1

