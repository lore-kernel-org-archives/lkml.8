Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339A2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E7C20643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589826280;
	bh=WnNstYCDUFAAXrsF4FoTE8vpCGvT/AX729NNv95uTrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hBldyGKcMB9Q8muzO6ihPac4Tym8tTHBbYHsh4lqbp42CNUoinrBoVnwzzxyVScd2
	 x1hsMrB4ZgHdkzZS7nQQOAS73FybpGWrefX7e0+4Z+KMgnaFcBBT2PL2+GyrG51PlB
	 96RbegOr121/2IeblpAHDeHULijIzwA8b9pARoIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387713AbgERSYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729955AbgERRrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:47:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1682420657;
        Mon, 18 May 2020 17:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824060;
        bh=WnNstYCDUFAAXrsF4FoTE8vpCGvT/AX729NNv95uTrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BwV2maedGC6nz+z76WmBUUmFn7G8ab+trAKh7AhBo/3Apil3JBYD38BSZ7fWgLK4Q
         fjNc/ZmjwqWQ+IFouiOF96A+ZsBQbrIAZpqXwJrjG7DrWiB87X6gjvfzeAtH4kaYnm
         pra2WETZkmQHJW1Qy7RlXmN10UYaERAyz/8V8QyE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 056/114] dmaengine: mmp_tdma: Reset channel error on release
Date:   Mon, 18 May 2020 19:36:28 +0200
Message-Id: <20200518173513.332274606@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173503.033975649@linuxfoundation.org>
References: <20200518173503.033975649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>

[ Upstream commit 0c89446379218698189a47871336cb30286a7197 ]

When a channel configuration fails, the status of the channel is set to
DEV_ERROR so that an attempt to submit it fails. However, this status
sticks until the heat end of the universe, making it impossible to
recover from the error.

Let's reset it when the channel is released so that further use of the
channel with correct configuration is not impacted.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Link: https://lore.kernel.org/r/20200419164912.670973-5-lkundrak@v3.sk
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/mmp_tdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 13c68b6434ce2..15b4a44e60069 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -362,6 +362,8 @@ static void mmp_tdma_free_descriptor(struct mmp_tdma_chan *tdmac)
 		gen_pool_free(gpool, (unsigned long)tdmac->desc_arr,
 				size);
 	tdmac->desc_arr = NULL;
+	if (tdmac->status == DMA_ERROR)
+		tdmac->status = DMA_COMPLETE;
 
 	return;
 }
-- 
2.20.1



