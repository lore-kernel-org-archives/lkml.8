Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8554AC38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6204B214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgDSQt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 12:49:26 -0400
Received: from v6.sk ([167.172.42.174]:43694 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgDSQtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 12:49:25 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 03EE0610AA;
        Sun, 19 Apr 2020 16:49:24 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 3/7] dmaengine: mmp_tdma: Validate the transfer direction
Date:   Sun, 19 Apr 2020 18:49:08 +0200
Message-Id: <20200419164912.670973-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200419164912.670973-1-lkundrak@v3.sk>
References: <20200419164912.670973-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only support DMA_DEV_TO_MEM and DMA_MEM_TO_DEV. Let's not do
undefined things with other values and reject them.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/dma/mmp_tdma.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index d559bb4d6a31d..d574641791598 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -207,10 +207,17 @@ static int mmp_tdma_config_chan(struct dma_chan *chan)
 
 	mmp_tdma_disable_chan(chan);
 
-	if (tdmac->dir == DMA_MEM_TO_DEV)
-		tdcr = TDCR_DSTDIR_ADDR_HOLD | TDCR_SRCDIR_ADDR_INC;
-	else if (tdmac->dir == DMA_DEV_TO_MEM)
+	switch (tdmac->dir) {
+	case DMA_DEV_TO_MEM:
 		tdcr = TDCR_SRCDIR_ADDR_HOLD | TDCR_DSTDIR_ADDR_INC;
+		break;
+	case DMA_MEM_TO_DEV:
+		tdcr = TDCR_DSTDIR_ADDR_HOLD | TDCR_SRCDIR_ADDR_INC;
+		break;
+	default:
+		dev_err(tdmac->dev, "invalid transfer direction\n");
+		return -EINVAL;
+	}
 
 	if (tdmac->type == MMP_AUD_TDMA) {
 		tdcr |= TDCR_PACKMOD;
@@ -455,12 +462,18 @@ static struct dma_async_tx_descriptor *mmp_tdma_prep_dma_cyclic(
 			desc->nxt_desc = tdmac->desc_arr_phys +
 				sizeof(*desc) * (i + 1);
 
-		if (direction == DMA_MEM_TO_DEV) {
-			desc->src_addr = dma_addr;
-			desc->dst_addr = tdmac->dev_addr;
-		} else {
+		switch (direction) {
+		case DMA_DEV_TO_MEM:
 			desc->src_addr = tdmac->dev_addr;
 			desc->dst_addr = dma_addr;
+			break;
+		case DMA_MEM_TO_DEV:
+			desc->src_addr = dma_addr;
+			desc->dst_addr = tdmac->dev_addr;
+			break;
+		default:
+			dev_err(tdmac->dev, "invalid transfer direction\n");
+			goto err_out;
 		}
 		desc->byte_cnt = period_len;
 		dma_addr += period_len;
@@ -510,14 +523,20 @@ static int mmp_tdma_config_write(struct dma_chan *chan,
 {
 	struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
 
-	if (dir == DMA_DEV_TO_MEM) {
+	switch (dir) {
+	case DMA_DEV_TO_MEM:
 		tdmac->dev_addr = dmaengine_cfg->src_addr;
 		tdmac->burst_sz = dmaengine_cfg->src_maxburst;
 		tdmac->buswidth = dmaengine_cfg->src_addr_width;
-	} else {
+		break;
+	case DMA_MEM_TO_DEV:
 		tdmac->dev_addr = dmaengine_cfg->dst_addr;
 		tdmac->burst_sz = dmaengine_cfg->dst_maxburst;
 		tdmac->buswidth = dmaengine_cfg->dst_addr_width;
+		break;
+	default:
+		dev_err(tdmac->dev, "invalid transfer direction\n");
+		return -EINVAL;
 	}
 	tdmac->dir = dir;
 
-- 
2.26.0

