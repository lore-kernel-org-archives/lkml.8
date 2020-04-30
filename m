Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B80EC28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA5162072A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255067;
	bh=6PQThudiOADLiowU8hPRGHfSO63STL1z7Wa+F73g4G0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Spxq/qxHmijd7HGHbsnH40zBSQB0et+9d5td8zkD18uNfUrggVxaKHjqI543K+/da
	 j7rCboiNhLC+ehqZCMGgMm2FLWIGlKo46sOlM8aUC1S0A2Zg2cHl6XkHEbqx/+4hMR
	 i+aDFONWoSgXzPBpkTb0aFHAGA3QokNbKLdBY6zw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgD3N5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbgD3Nyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:54:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E188C20873;
        Thu, 30 Apr 2020 13:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254891;
        bh=6PQThudiOADLiowU8hPRGHfSO63STL1z7Wa+F73g4G0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kXmtWC758Y/Njd9L0GglATGtVS8Yf9ixrbfh+Wp7ynps4tUUPffit4mbFptFyL5/4
         VrbXb8IxtooGaZYtNVxrDN9bLp//seSPj5oXx7Du1hcPV2DPAhVn8S5z978MuizHFU
         zjXIj5ZXr7t4gFLxNIsPIUcJDhDL61FrxOziChRI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 16/17] net: bcmgenet: suppress warnings on failed Rx SKB allocations
Date:   Thu, 30 Apr 2020 09:54:32 -0400
Message-Id: <20200430135433.21204-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135433.21204-1-sashal@kernel.org>
References: <20200430135433.21204-1-sashal@kernel.org>
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
index a234044805977..5d4189c94718c 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1596,7 +1596,8 @@ static struct sk_buff *bcmgenet_rx_refill(struct bcmgenet_priv *priv,
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

