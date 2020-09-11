Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF8AC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 13:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0249222224
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 13:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599829219;
	bh=751jnFFiPM7Rz+YvYy29f9LhzmeeTfNIcCziFRBD/40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rPDXbDB6JTvltmuPlpg7jMlSJXKKf9pQxqzR1oT1daHFhhLg8pHW2r42XC3uuOiEq
	 0DF14PhPNQYWgKzAPFpYh4I3aGtxT4tuOwne29nZK/hN7XWZYsKGGlO66J08LmeBxZ
	 7JrEI8HUbDWsECKEw9+i+0HjocdiJMtfX2JiOzzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgIKNAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 09:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgIKMyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:54:55 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58B9D2222B;
        Fri, 11 Sep 2020 12:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599828844;
        bh=751jnFFiPM7Rz+YvYy29f9LhzmeeTfNIcCziFRBD/40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a8S4YYZwBmoM16gSK3nqYYpW00eNrTiAMU7kNMNaphllIDgfu4m7Gn4zIoZc6XuLs
         pJOMrb2nOvIRZBMLIK5cApDWWFEuDBqnNRgJ0CLcGZ1Chy7WY0OoGld2nu/mhUE9rg
         ADr4MXntVtkKJEY1BxzPZinfeyI5n+b0jFIiivvc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 09/62] dmaengine: of-dma: Fix of_dma_router_xlates of_dma_xlate handling
Date:   Fri, 11 Sep 2020 14:45:52 +0200
Message-Id: <20200911122502.855779713@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911122502.395450276@linuxfoundation.org>
References: <20200911122502.395450276@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit 5b2aa9f918f6837ae943557f8cec02c34fcf80e7 ]

of_dma_xlate callback can return ERR_PTR as well NULL in case of failure.

If error code is returned (not NULL) then the route should be released and
the router should not be registered for the channel.

Fixes: 56f13c0d9524c ("dmaengine: of_dma: Support for DMA routers")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20200806104928.25975-1-peter.ujfalusi@ti.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/of-dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index 1e1f2986eba8f..86c591481dfe9 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -72,12 +72,12 @@ static struct dma_chan *of_dma_router_xlate(struct of_phandle_args *dma_spec,
 		return NULL;
 
 	chan = ofdma_target->of_dma_xlate(&dma_spec_target, ofdma_target);
-	if (chan) {
-		chan->router = ofdma->dma_router;
-		chan->route_data = route_data;
-	} else {
+	if (IS_ERR_OR_NULL(chan)) {
 		ofdma->dma_router->route_free(ofdma->dma_router->dev,
 					      route_data);
+	} else {
+		chan->router = ofdma->dma_router;
+		chan->route_data = route_data;
 	}
 
 	/*
-- 
2.25.1



