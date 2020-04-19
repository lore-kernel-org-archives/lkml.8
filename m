Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97254C5321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F0F3214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgDSQta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 12:49:30 -0400
Received: from v6.sk ([167.172.42.174]:43706 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgDSQt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 12:49:27 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 7E003610AB;
        Sun, 19 Apr 2020 16:49:26 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 4/7] dmaengine: mmp_tdma: Reset channel error on release
Date:   Sun, 19 Apr 2020 18:49:09 +0200
Message-Id: <20200419164912.670973-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200419164912.670973-1-lkundrak@v3.sk>
References: <20200419164912.670973-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a channel configuration fails, the status of the channel is set to
DEV_ERROR so that an attempt to submit it fails. However, this status
sticks until the heat end of the universe, making it impossible to
recover from the error.

Let's reset it when the channel is released so that further use of the
channel with correct configuration is not impacted.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/dma/mmp_tdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index d574641791598..0b1aa6eab1801 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -370,6 +370,8 @@ static void mmp_tdma_free_descriptor(struct mmp_tdma_chan *tdmac)
 		gen_pool_free(gpool, (unsigned long)tdmac->desc_arr,
 				size);
 	tdmac->desc_arr = NULL;
+	if (tdmac->status == DMA_ERROR)
+		tdmac->status = DMA_COMPLETE;
 
 	return;
 }
-- 
2.26.0

