Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90FEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAC0218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860288;
	bh=QewKoEJlIRAHjoP4tt654qmdwr7ZKQY39OMFwub97Ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=auPwpjENGcbJiGtpNRLptyB3xCmhUixnAPl2ytdPM8JCl5C7hAf+8rkO43j83EK+C
	 Z8cy6ZTrnGjOw2Ox+zigY9SgzruH11kk54VXOMc73ywU2MuaNsI/Wdxby1d+9KLkx+
	 NdikUILQ17RzojmMKXbboZQpzjhrbzqaLZ+gLl6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389158AbgAXKEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:04:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388948AbgAXKEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:04:44 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D394218AC;
        Fri, 24 Jan 2020 10:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860284;
        bh=QewKoEJlIRAHjoP4tt654qmdwr7ZKQY39OMFwub97Ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KOv8Mrj4jrj9LUTL9Tq9YJ8akZbYiCY1tg+SeCL6RkZoLrNaC7wqBshUaLrQSqfbi
         F38xdf5sT0e5bbrw/FKypKa15OYW5vglHSS0iND1ayaMSXa3RjpCuReO8uS0Hdcgrb
         WyCdlVSS5nuwQFUmSBdnQefuIt4DKfdUXyZjBWX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mao Wenan <maowenan@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 302/343] net: sonic: replace dev_kfree_skb in sonic_send_packet
Date:   Fri, 24 Jan 2020 10:32:00 +0100
Message-Id: <20200124092959.624669148@linuxfoundation.org>
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

[ Upstream commit 49f6c90bf6805948b597eabb499e500a47cf24be ]

sonic_send_packet will be processed in irq or non-irq
context, so it would better use dev_kfree_skb_any
instead of dev_kfree_skb.

Fixes: d9fb9f384292 ("*sonic/natsemi/ns83829: Move the National Semi-conductor drivers")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/natsemi/sonic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/natsemi/sonic.c b/drivers/net/ethernet/natsemi/sonic.c
index 11f472fd5d477..a051dddcbd768 100644
--- a/drivers/net/ethernet/natsemi/sonic.c
+++ b/drivers/net/ethernet/natsemi/sonic.c
@@ -222,7 +222,7 @@ static int sonic_send_packet(struct sk_buff *skb, struct net_device *dev)
 	laddr = dma_map_single(lp->device, skb->data, length, DMA_TO_DEVICE);
 	if (!laddr) {
 		pr_err_ratelimited("%s: failed to map tx DMA buffer.\n", dev->name);
-		dev_kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return NETDEV_TX_OK;
 	}
 
-- 
2.20.1



