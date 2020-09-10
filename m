Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDD6C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 04:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6631F20719
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 04:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dTCggUrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgIJEPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgIJEO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 00:14:56 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB63C061795
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 21:14:27 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m15so273606pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 21:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KWwm8mWE4d4wVcJJo9tytWYejv+Pxcnm9glHhgWnu5Q=;
        b=dTCggUrLZ8gGuJz0l6b75Knxn3+MUxo3lYXr/4UHEEgOKTtC1kTS0ojPh6SX8sQU8p
         BCYj2cqqON+K/W0M5bfhEKpPbtQxeGg35NlNVjC7cyMRlsDjHlao3a0vcIe18yGVY1pc
         4t0mrw36EPOR+39cKMN1JRaE/tiBhcjr6qetI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KWwm8mWE4d4wVcJJo9tytWYejv+Pxcnm9glHhgWnu5Q=;
        b=AUkSVrDVg+7m327NSnNpEExecTsWLOHL8N64ToX+jNJulGeO+B+FMNmd5n7KzpmC5+
         MDI6b/y/Ijo/iUcuhisn8KgKSCaO8SK6emn2gjUsVvHbEDAWu88dPRuvfcmm2hf3ispQ
         Lj3CmmUruYK1o9XKUnULKD7/acHhkxhNphFBLMDF8sqQg1Onvf3jNBojxhnWqI2fUL5P
         9fzL058x0OPzaRURmJcm4seL7XuG9dbeva5yJJkSRYkJMbNksSkhJagSIh75055yvgAB
         Ks/pLlWuwViUIhrTiOEuqoDMGT7/Y01A64Jbtd0RHU7761kxGTnxNtGwDEWXHEzCIgG9
         suGA==
X-Gm-Message-State: AOAM533kOU4y8guYLzJyvSq2g+qhkBb52Qdy3sv1ILbX2ZOJu4pbhld1
        BkgvEZ6b7N0w7amOCQLG85/hcw==
X-Google-Smtp-Source: ABdhPJzYfBcwkmIQmoRUkge3+F2vQd+PMsW9pyK+LSIVKTewrgGDMUCeeNY1yViHgy9zIU7mIyiTog==
X-Received: by 2002:a17:902:b409:b029:d0:cbe1:e741 with SMTP id x9-20020a170902b409b02900d0cbe1e741mr4019631plr.28.1599711267272;
        Wed, 09 Sep 2020 21:14:27 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id z11sm4266169pfc.181.2020.09.09.21.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 21:14:26 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] spi: spi-mtk-nor: support 36bit dma addressing to mediatek spi-nor
Date:   Thu, 10 Sep 2020 12:11:01 +0800
Message-Id: <20200910041101.1695195-3-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200910041101.1695195-1-ikjn@chromium.org>
References: <20200910041101.1695195-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables direct mappings over 32bit range to spi-mtk-nor.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>

---

 drivers/spi/spi-mtk-nor.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 6e6ca2b8e6c8..eb93ae34e670 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -78,6 +78,8 @@
 #define MTK_NOR_REG_DMA_FADR		0x71c
 #define MTK_NOR_REG_DMA_DADR		0x720
 #define MTK_NOR_REG_DMA_END_DADR	0x724
+#define MTK_NOR_REG_DMA_DADR_HB		0x738
+#define MTK_NOR_REG_DMA_END_DADR_HB	0x73c
 
 #define MTK_NOR_PRG_MAX_SIZE		6
 // Reading DMA src/dst addresses have to be 16-byte aligned
@@ -101,6 +103,7 @@ struct mtk_nor {
 	unsigned int spi_freq;
 	bool wbuf_en;
 	bool has_irq;
+	bool high_dma;
 	struct completion op_done;
 };
 
@@ -279,6 +282,11 @@ static int mtk_nor_read_dma(struct mtk_nor *sp, u32 from, unsigned int length,
 	writel(dma_addr, sp->base + MTK_NOR_REG_DMA_DADR);
 	writel(dma_addr + length, sp->base + MTK_NOR_REG_DMA_END_DADR);
 
+	if (sp->high_dma) {
+		writel(dma_addr >> 32, sp->base + MTK_NOR_REG_DMA_DADR_HB);
+		writel((dma_addr + length) >> 32, sp->base + MTK_NOR_REG_DMA_END_DADR_HB);
+	}
+
 	if (sp->has_irq) {
 		reinit_completion(&sp->op_done);
 		mtk_nor_rmw(sp, MTK_NOR_REG_IRQ_EN, MTK_NOR_IRQ_DMA, 0);
@@ -578,7 +586,8 @@ static const struct spi_controller_mem_ops mtk_nor_mem_ops = {
 };
 
 static const struct of_device_id mtk_nor_match[] = {
-	{ .compatible = "mediatek,mt8173-nor" },
+	{ .compatible = "mediatek,mt8192-nor", .data = (void *)36 },
+	{ .compatible = "mediatek,mt8173-nor", .data = (void *)32 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mtk_nor_match);
@@ -591,6 +600,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	u8 *buffer;
 	struct clk *spi_clk, *ctlr_clk;
 	int ret, irq;
+	unsigned long dma_bits;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -614,6 +624,12 @@ static int mtk_nor_probe(struct platform_device *pdev)
 		buffer = (u8 *)(((ulong)buffer + MTK_NOR_DMA_ALIGN) &
 				~MTK_NOR_DMA_ALIGN_MASK);
 
+	dma_bits = (unsigned long)of_device_get_match_data(&pdev->dev);
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(dma_bits))) {
+		dev_err(&pdev->dev, "failed to set dma mask(%lu)\n", dma_bits);
+		return -EINVAL;
+	}
+
 	ctlr = spi_alloc_master(&pdev->dev, sizeof(*sp));
 	if (!ctlr) {
 		dev_err(&pdev->dev, "failed to allocate spi controller\n");
@@ -640,6 +656,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	sp->dev = &pdev->dev;
 	sp->spi_clk = spi_clk;
 	sp->ctlr_clk = ctlr_clk;
+	sp->high_dma = (dma_bits > 32);
 
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq < 0) {
-- 
2.28.0.526.ge36021eeef-goog

