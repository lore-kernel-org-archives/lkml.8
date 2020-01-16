Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED844C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9B124687
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194697;
	bh=no52/3ZbBlS+WUGpTZ80/4fIwoJ8eEU+z3lXxNEXLtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tnXtcl5mVNNf8KZlDCfU0NE4DZjlYG8AkdTzADpBgBSnbLxHyylVhC9pUvXNr4cG1
	 vgJMok5HCo4844V5o2+iV2sesA1HlEAiHvkEpUM9I3I/qTqYdTEg3U9+yxCXwktetk
	 /jMrIjDlzWTrnypdlBombaHVU6rrsQHQG7PHpa8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390295AbgAPRLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:11:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:52234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390245AbgAPRLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:11:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C134E24687;
        Thu, 16 Jan 2020 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194689;
        bh=no52/3ZbBlS+WUGpTZ80/4fIwoJ8eEU+z3lXxNEXLtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a47zNemmlwHGEzKqUQwFaYNaFMQA9RcmLQonYmnhCk4glPtuHjSHSbXiIWzLvTKZ/
         Xy5JiF6+WZTk2mXoxMNlYO5FnL/EF8C5TmR23F9ZpZCTkjDKFtbDZmpEzZJ1KPRkCo
         sQv1KgzQIw7XKvPTxpXj5K2tHBTpuX/ortUZPzi0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mao Wenan <maowenan@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 532/671] net: sonic: return NETDEV_TX_OK if failed to map buffer
Date:   Thu, 16 Jan 2020 12:02:50 -0500
Message-Id: <20200116170509.12787-269-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Wenan <maowenan@huawei.com>

[ Upstream commit 6e1cdedcf0362fed3aedfe051d46bd7ee2a85fe1 ]

NETDEV_TX_BUSY really should only be used by drivers that call
netif_tx_stop_queue() at the wrong moment. If dma_map_single() is
failed to map tx DMA buffer, it might trigger an infinite loop.
This patch use NETDEV_TX_OK instead of NETDEV_TX_BUSY, and change
printk to pr_err_ratelimited.

Fixes: d9fb9f384292 ("*sonic/natsemi/ns83829: Move the National Semi-conductor drivers")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/natsemi/sonic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/natsemi/sonic.c b/drivers/net/ethernet/natsemi/sonic.c
index c805dcbebd02..be36f7117d48 100644
--- a/drivers/net/ethernet/natsemi/sonic.c
+++ b/drivers/net/ethernet/natsemi/sonic.c
@@ -231,9 +231,9 @@ static int sonic_send_packet(struct sk_buff *skb, struct net_device *dev)
 
 	laddr = dma_map_single(lp->device, skb->data, length, DMA_TO_DEVICE);
 	if (!laddr) {
-		printk(KERN_ERR "%s: failed to map tx DMA buffer.\n", dev->name);
+		pr_err_ratelimited("%s: failed to map tx DMA buffer.\n", dev->name);
 		dev_kfree_skb(skb);
-		return NETDEV_TX_BUSY;
+		return NETDEV_TX_OK;
 	}
 
 	sonic_tda_put(dev, entry, SONIC_TD_STATUS, 0);       /* clear status */
-- 
2.20.1

