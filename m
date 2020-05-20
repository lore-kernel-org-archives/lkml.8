Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C1EC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE992070A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgETG4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 02:56:33 -0400
Received: from v6.sk ([167.172.42.174]:59870 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgETG4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 02:56:32 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id F17D161300;
        Wed, 20 May 2020 06:56:29 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] dmaengine: mmp_pdma: Do not warn when IRQ is shared by all chans
Date:   Wed, 20 May 2020 08:56:26 +0200
Message-Id: <20200520065626.2119120-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there's a single interrupt for all the DMA channels, the
unsuccessful attempt to request separate IRQs emits useless warnings:

  [    1.370381] mmp-pdma d4000000.dma: IRQ index 1 not found
  ...
  [    1.412398] mmp-pdma d4000000.dma: IRQ index 15 not found
  [    1.418308] mmp-pdma d4000000.dma: initialized 16 channels

Avoid that, treating the IRQs as optional.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/dma/mmp_pdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index ad06f260e907..41c542eaa23a 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -1060,7 +1060,7 @@ static int mmp_pdma_probe(struct platform_device *op)
 	pdev->dma_channels = dma_channels;
 
 	for (i = 0; i < dma_channels; i++) {
-		if (platform_get_irq(op, i) > 0)
+		if (platform_get_irq_optional(op, i) > 0)
 			irq_num++;
 	}
 
-- 
2.26.2

