Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87984C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 661882071C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgEAKIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 06:08:34 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:42530 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgEAKIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 06:08:34 -0400
Received: from localhost.localdomain ([93.22.39.103])
        by mwinf5d48 with ME
        id ZN8S2200X2DY6MH03N8Ti7; Fri, 01 May 2020 12:08:30 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 01 May 2020 12:08:30 +0200
X-ME-IP: 93.22.39.103
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     green.wan@sifive.com, dan.j.williams@intel.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] dmaengine: sf-pdma: Simplify the error handling path in 'sf_pdma_probe()'
Date:   Fri,  1 May 2020 12:08:24 +0200
Message-Id: <20200501100824.126534-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to explicitly free memory that have been 'devm_kzalloc'ed.
Simplify the probe function accordingly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma/sf-pdma/sf-pdma.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 6d0bec947636..5c118c7e02bd 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -506,11 +506,11 @@ static int sf_pdma_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pdma->membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(pdma->membase))
-		goto ERR_MEMBASE;
+		return PTR_ERR(pdma->membase);
 
 	ret = sf_pdma_irq_init(pdev, pdma);
 	if (ret)
-		goto ERR_INITIRQ;
+		return ret;
 
 	sf_pdma_setup_chans(pdma);
 
@@ -544,24 +544,13 @@ static int sf_pdma_probe(struct platform_device *pdev)
 			 "Failed to set DMA mask. Fall back to default.\n");
 
 	ret = dma_async_device_register(&pdma->dma_dev);
-	if (ret)
-		goto ERR_REG_DMADEVICE;
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Can't register SiFive Platform DMA. (%d)\n", ret);
+		return ret;
+	}
 
 	return 0;
-
-ERR_MEMBASE:
-	devm_kfree(&pdev->dev, pdma);
-	return PTR_ERR(pdma->membase);
-
-ERR_INITIRQ:
-	devm_kfree(&pdev->dev, pdma);
-	return ret;
-
-ERR_REG_DMADEVICE:
-	devm_kfree(&pdev->dev, pdma);
-	dev_err(&pdev->dev,
-		"Can't register SiFive Platform DMA. (%d)\n", ret);
-	return ret;
 }
 
 static int sf_pdma_remove(struct platform_device *pdev)
-- 
2.25.1

