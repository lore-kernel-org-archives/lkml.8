Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92802C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 775DE20857
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgGMK0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:26:17 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:53630 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729390AbgGMK0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:26:16 -0400
Received: from localhost (unknown [192.168.167.69])
        by lucky1.263xmail.com (Postfix) with ESMTP id BCE20CA52C;
        Mon, 13 Jul 2020 18:26:09 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P8591T140098829747968S1594635967092824_;
        Mon, 13 Jul 2020 18:26:08 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <dfe795403dc7e7e9647a2a61f1a0f504>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: broonie@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Sugar Zhang <sugar.zhang@rock-chips.com>
To:     broonie@kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rockchip: spdif: Handle clk by pm runtime
Date:   Mon, 13 Jul 2020 18:26:00 +0800
Message-Id: <1594635960-67855-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch handle the clk by pm runtime mechanism to simplify
the clk management.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_spdif.c | 59 +++++++++++--------------------------
 1 file changed, 17 insertions(+), 42 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 6635145..6748108 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -306,44 +306,22 @@ static int rk_spdif_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	spdif->hclk = devm_clk_get(&pdev->dev, "hclk");
-	if (IS_ERR(spdif->hclk)) {
-		dev_err(&pdev->dev, "Can't retrieve rk_spdif bus clock\n");
+	if (IS_ERR(spdif->hclk))
 		return PTR_ERR(spdif->hclk);
-	}
-	ret = clk_prepare_enable(spdif->hclk);
-	if (ret) {
-		dev_err(spdif->dev, "hclock enable failed %d\n", ret);
-		return ret;
-	}
 
 	spdif->mclk = devm_clk_get(&pdev->dev, "mclk");
-	if (IS_ERR(spdif->mclk)) {
-		dev_err(&pdev->dev, "Can't retrieve rk_spdif master clock\n");
-		ret = PTR_ERR(spdif->mclk);
-		goto err_disable_hclk;
-	}
-
-	ret = clk_prepare_enable(spdif->mclk);
-	if (ret) {
-		dev_err(spdif->dev, "clock enable failed %d\n", ret);
-		goto err_disable_clocks;
-	}
+	if (IS_ERR(spdif->mclk))
+		return PTR_ERR(spdif->mclk);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(regs)) {
-		ret = PTR_ERR(regs);
-		goto err_disable_clocks;
-	}
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
 	spdif->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "hclk", regs,
 						  &rk_spdif_regmap_config);
-	if (IS_ERR(spdif->regmap)) {
-		dev_err(&pdev->dev,
-			"Failed to initialise managed register map\n");
-		ret = PTR_ERR(spdif->regmap);
-		goto err_disable_clocks;
-	}
+	if (IS_ERR(spdif->regmap))
+		return PTR_ERR(spdif->regmap);
 
 	spdif->playback_dma_data.addr = res->start + SPDIF_SMPDR;
 	spdif->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
@@ -352,47 +330,44 @@ static int rk_spdif_probe(struct platform_device *pdev)
 	spdif->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, spdif);
 
-	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-	pm_request_idle(&pdev->dev);
+	if (!pm_runtime_enabled(&pdev->dev)) {
+		ret = rk_spdif_runtime_resume(&pdev->dev);
+		if (ret)
+			goto err_pm_runtime;
+	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &rk_spdif_component,
 					      &rk_spdif_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register DAI\n");
-		goto err_pm_runtime;
+		goto err_pm_suspend;
 	}
 
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register PCM\n");
-		goto err_pm_runtime;
+		goto err_pm_suspend;
 	}
 
 	return 0;
 
+err_pm_suspend:
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		rk_spdif_runtime_suspend(&pdev->dev);
 err_pm_runtime:
 	pm_runtime_disable(&pdev->dev);
-err_disable_clocks:
-	clk_disable_unprepare(spdif->mclk);
-err_disable_hclk:
-	clk_disable_unprepare(spdif->hclk);
 
 	return ret;
 }
 
 static int rk_spdif_remove(struct platform_device *pdev)
 {
-	struct rk_spdif_dev *spdif = dev_get_drvdata(&pdev->dev);
-
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		rk_spdif_runtime_suspend(&pdev->dev);
 
-	clk_disable_unprepare(spdif->mclk);
-	clk_disable_unprepare(spdif->hclk);
-
 	return 0;
 }
 
-- 
2.7.4



