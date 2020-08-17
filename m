Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4380C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4DF2204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690154;
	bh=sC52q1jskN1a4GCM1vdNvSZEDdBVrHK3PIW89cOAIoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XM/aR20QRVSdRlnzNqUfFJI090gmz6b4QE7CqUhKGbEel07MkLo5SXotJwl/0d2qV
	 EvetukfzmhTUsgWI4N8H7XZXo5H1R/6CwuSaVZ5Qa7itLiBkUg6zqW9FUYpzFbT75R
	 wSNrMghrUrWsIdgne/5lypGUbCE/TyzPWUHo4Z7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403792AbgHQStN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388003AbgHQPyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:54:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BC3820888;
        Mon, 17 Aug 2020 15:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679683;
        bh=sC52q1jskN1a4GCM1vdNvSZEDdBVrHK3PIW89cOAIoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TOYZOOt1i/msLn3u1PKw4Pl4B9AQD0lyvRh4qK6EJSHeAoadFnJOw5efDp923DEdS
         zQjE+nLUGv4ln1DrxaWpu9PZiSjuKfg/cUhg0L8+xPbpjoj1H+zD/23i5djiasSaNv
         9FP3KN/O9mmEGvREP7ehrbjcIvqSP1Dt4Y1FJDp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 299/393] net: spider_net: Fix the size used in a dma_free_coherent() call
Date:   Mon, 17 Aug 2020 17:15:49 +0200
Message-Id: <20200817143834.120303583@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
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
index 6576271642c14..ce8b123cdbcc1 100644
--- a/drivers/net/ethernet/toshiba/spider_net.c
+++ b/drivers/net/ethernet/toshiba/spider_net.c
@@ -283,8 +283,8 @@ spider_net_free_chain(struct spider_net_card *card,
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



