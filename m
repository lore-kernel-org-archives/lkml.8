Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7A7C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E972063A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255284;
	bh=3zoZdwu3a/4pc6Gr7kyTB8URRIJNRUR7D/4f1hGP0RY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MuuhwXmFrRI6Ep9w6f+ynkgNUUH/UHRUIuduEjCbsJdn8YzNptgFFBUzFqUpgbiNt
	 zArN08ewoQWsJuQR0LgjcdzNhAK2iR+H3UoBKJIxCvV4E2rOlSdgNOG41n9pjwCbbM
	 XjLB4y8hlCldpilAfgztaFbkVt9vzoe64r44E7rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgD3OBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:01:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728857AbgD3Nx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:53:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C97B208D5;
        Thu, 30 Apr 2020 13:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254838;
        bh=3zoZdwu3a/4pc6Gr7kyTB8URRIJNRUR7D/4f1hGP0RY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zW3TFmTXjhe5vLKSZ3j5K9k/gboo9uCld7DzimNw7aIsgX0pHRHEpngsG01RiAdC3
         awKD/G3YnzFkYw8ZZQ9qtR4BUga3NIOf0xbQUbpY/FnA2XBjCsthBwqoRwCenPKsjw
         YhIO3IzbTIUde5e7AxVd4LUAC0UUb4D1GLmrMglk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 29/30] net: systemport: suppress warnings on failed Rx SKB allocations
Date:   Thu, 30 Apr 2020 09:53:24 -0400
Message-Id: <20200430135325.20762-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135325.20762-1-sashal@kernel.org>
References: <20200430135325.20762-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit 3554e54a46125030c534820c297ed7f6c3907e24 ]

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
 drivers/net/ethernet/broadcom/bcmsysport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 3fdf135bad56e..6b761f6b8fd56 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -677,7 +677,8 @@ static struct sk_buff *bcm_sysport_rx_refill(struct bcm_sysport_priv *priv,
 	dma_addr_t mapping;
 
 	/* Allocate a new SKB for a new packet */
-	skb = netdev_alloc_skb(priv->netdev, RX_BUF_LENGTH);
+	skb = __netdev_alloc_skb(priv->netdev, RX_BUF_LENGTH,
+				 GFP_ATOMIC | __GFP_NOWARN);
 	if (!skb) {
 		priv->mib.alloc_rx_buff_failed++;
 		netif_err(priv, rx_err, ndev, "SKB alloc failed\n");
-- 
2.20.1

