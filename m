Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C99C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DEC72072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597921592;
	bh=dU8mWmZj2y/PLg8r9aam5cB2sbSCPZqhnJStU6/e1cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jLIuMgCBZF8ccExgqn4w9lZ2/9VTuZ6ZVod3l06pxgJu6dL0bfuDkUEe3fpxuEyXc
	 Vsu/c9KujS6qvdkopCMXBujyW4w72n3C7ZO0ujUHn894kaLE7k3+3xrnJzjyW6nhTZ
	 806v1+GIVDcTdaLC+n0VXzI1qCD5Ybfz5QjjerKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgHTLGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730223AbgHTKMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:12:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E807F20738;
        Thu, 20 Aug 2020 10:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918321;
        bh=dU8mWmZj2y/PLg8r9aam5cB2sbSCPZqhnJStU6/e1cM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=chxIm6+AgO8AGkp0BNVJLBi0kcRS5orsQhHuxQ0COUgJYzFVvHmUXBDmNfjzHdUEk
         KCboMp9NfYhGNw0GyOcPTyWfDGXaEPFFvPhasQPOW8vbh8E5nqxcPPBnzLLdS7MzVI
         38qSmZdDHUVm5db5/JOGkbGdkukiMuj+eA/6pdT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 129/228] net: spider_net: Fix the size used in a dma_free_coherent() call
Date:   Thu, 20 Aug 2020 11:21:44 +0200
Message-Id: <20200820091614.035744041@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 36f28f7687a9ce665479cce5d64ce7afaa9e77ae ]

Update the size used in 'dma_free_coherent()' in order to match the one
used in the corresponding 'dma_alloc_coherent()', in
'spider_net_init_chain()'.

Fixes: d4ed8f8d1fb7 ("Spidernet DMA coalescing")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/toshiba/spider_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/toshiba/spider_net.c b/drivers/net/ethernet/toshiba/spider_net.c
index da136b8843dd9..a0fed9035f537 100644
--- a/drivers/net/ethernet/toshiba/spider_net.c
+++ b/drivers/net/ethernet/toshiba/spider_net.c
@@ -296,8 +296,8 @@ spider_net_free_chain(struct spider_net_card *card,
 		descr = descr->next;
 	} while (descr != chain->ring);
 
-	dma_free_coherent(&card->pdev->dev, chain->num_desc,
-	    chain->hwring, chain->dma_addr);
+	dma_free_coherent(&card->pdev->dev, chain->num_desc * sizeof(struct spider_net_hw_descr),
+			  chain->hwring, chain->dma_addr);
 }
 
 /**
-- 
2.25.1



