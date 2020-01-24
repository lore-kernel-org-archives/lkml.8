Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA83C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384AE20709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860254;
	bh=bE8o3OQvcMXCoNjxx7+jugWh8bZK+iZueB5gdaJ+QW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iDoqw2m8DyGvJ4cEPYRB1DWFZnr3xkxwvO/fu+nNrkTKgMEM4gygPX9pBahlAquVX
	 +WyQ2I4RhhW1TNWTU2viX8RHzqEX6n/tkwAZFURua1eFVlS4fDdHTXThkBpDgsCLII
	 OJilOORKfoQ3DrtQGxz8m5neCd5nT+PCQG5sRQsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbgAXKEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:04:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbgAXKEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:04:09 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 384FD208C4;
        Fri, 24 Jan 2020 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860248;
        bh=bE8o3OQvcMXCoNjxx7+jugWh8bZK+iZueB5gdaJ+QW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uXMWcXmq0QAycgUxAJcmHmXpSBsf96isGgjq5Ed0dYrUr6yC/CZO6fG1xdunIQYxP
         +CsnguPb2xKmo02cxrC13BF96yWqWIyOP73+J4oc3BL/Bzm8fhQM4GCsvR9DtrPqp8
         vlzF9rsbjfAc3S/dcukIVr1NePmvPAw/oWkJrdCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mao Wenan <maowenan@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 294/343] net: sonic: return NETDEV_TX_OK if failed to map buffer
Date:   Fri, 24 Jan 2020 10:31:52 +0100
Message-Id: <20200124092958.639653868@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 23821540ab078..11f472fd5d477 100644
--- a/drivers/net/ethernet/natsemi/sonic.c
+++ b/drivers/net/ethernet/natsemi/sonic.c
@@ -221,9 +221,9 @@ static int sonic_send_packet(struct sk_buff *skb, struct net_device *dev)
 
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



