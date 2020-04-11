Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9ADC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3400212CC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="SCWbhwtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgDKIEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 04:04:16 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:25069 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726204AbgDKIEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 04:04:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586592255; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Y8q86WTB5/2WAKeKfT6xOfI6cCwvGx47c3+wU560RYE=; b=SCWbhwtE6mhO4/51E51gX6YzltLsLWZB/qzRBaWSYpjnvzWbHzgxd0FmFZHpKoeTrGEWbaFI
 LKyNnShBYDhnrkfyt0Ug6lVDqpNW+71T2hauwRkiasS5SJmiTQhckfDJEYuZwaSk9hgRzNjX
 O/aPVRXan/THSn00ixwzGL5N/YM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9179f3.7f47895a1688-smtp-out-n01;
 Sat, 11 Apr 2020 08:04:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4ABB8C44788; Sat, 11 Apr 2020 08:04:02 +0000 (UTC)
Received: from c-ajitp-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ajitp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8C4B2C433F2;
        Sat, 11 Apr 2020 08:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C4B2C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ajitp@codeaurora.org
From:   Ajit Pandey <ajitp@codeaurora.org>
To:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.com,
        Ajit Pandey <ajitp@codeaurora.org>
Subject: [PATCH 03/11] ASoC: qcom: Add common array to initialize soc based core clocks
Date:   Sat, 11 Apr 2020 13:32:43 +0530
Message-Id: <1586592171-31644-4-git-send-email-ajitp@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
References: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lpass variants have their own soc specific clocks that needs to be
enable for MI2S audio support. Added a common variable in drvdata to
initialize such clocks using bulk clk api. Such clock names is still
defined in variants specific data and needs to fetched during init.

Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
---
 sound/soc/qcom/lpass-apq8016.c | 39 ++++++++++++++++++---------------------
 sound/soc/qcom/lpass.h         | 10 +++++++---
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
index 6575da5..cef4661 100644
--- a/sound/soc/qcom/lpass-apq8016.c
+++ b/sound/soc/qcom/lpass-apq8016.c
@@ -161,33 +161,26 @@ static int apq8016_lpass_free_dma_channel(struct lpass_data *drvdata, int chan)
 static int apq8016_lpass_init(struct platform_device *pdev)
 {
 	struct lpass_data *drvdata = platform_get_drvdata(pdev);
+	struct lpass_variant *variant = drvdata->variant;
 	struct device *dev = &pdev->dev;
-	int ret;
+	int ret, i;
 
-	drvdata->pcnoc_mport_clk = devm_clk_get(dev, "pcnoc-mport-clk");
-	if (IS_ERR(drvdata->pcnoc_mport_clk)) {
-		dev_err(&pdev->dev, "error getting pcnoc-mport-clk: %ld\n",
-			PTR_ERR(drvdata->pcnoc_mport_clk));
-		return PTR_ERR(drvdata->pcnoc_mport_clk);
-	}
+	drvdata->clks = devm_kcalloc(dev, variant->num_clks,
+				     sizeof(*drvdata->clks), GFP_KERNEL);
+	drvdata->num_clks = variant->num_clks;
+
+	for (i = 0; i < drvdata->num_clks; i++)
+		drvdata->clks[i].id = variant->clk_name[i];
 
-	ret = clk_prepare_enable(drvdata->pcnoc_mport_clk);
+	ret = devm_clk_bulk_get(dev, drvdata->num_clks, drvdata->clks);
 	if (ret) {
-		dev_err(&pdev->dev, "Error enabling pcnoc-mport-clk: %d\n",
-			ret);
+		dev_err(dev, "Failed to get clocks %d\n", ret);
 		return ret;
 	}
 
-	drvdata->pcnoc_sway_clk = devm_clk_get(dev, "pcnoc-sway-clk");
-	if (IS_ERR(drvdata->pcnoc_sway_clk)) {
-		dev_err(&pdev->dev, "error getting pcnoc-sway-clk: %ld\n",
-			PTR_ERR(drvdata->pcnoc_sway_clk));
-		return PTR_ERR(drvdata->pcnoc_sway_clk);
-	}
-
-	ret = clk_prepare_enable(drvdata->pcnoc_sway_clk);
+	ret = clk_bulk_prepare_enable(drvdata->num_clks, drvdata->clks);
 	if (ret) {
-		dev_err(&pdev->dev, "Error enabling pcnoc_sway_clk: %d\n", ret);
+		dev_err(dev, "ao8016 clk_enable failed\n");
 		return ret;
 	}
 
@@ -198,8 +191,7 @@ static int apq8016_lpass_exit(struct platform_device *pdev)
 {
 	struct lpass_data *drvdata = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(drvdata->pcnoc_mport_clk);
-	clk_disable_unprepare(drvdata->pcnoc_sway_clk);
+	clk_bulk_disable_unprepare(drvdata->num_clks, drvdata->clks);
 
 	return 0;
 }
@@ -220,6 +212,11 @@ static int apq8016_lpass_exit(struct platform_device *pdev)
 	.wrdma_reg_stride	= 0x1000,
 	.wrdma_channel_start	= 5,
 	.wrdma_channels		= 2,
+	.clk_name		= (const char*[]) {
+				   "pcnoc-mport-clk",
+				   "pcnoc-sway-clk",
+				  },
+	.num_clks		= 2,
 	.dai_driver		= apq8016_lpass_cpu_dai_driver,
 	.num_dai		= ARRAY_SIZE(apq8016_lpass_cpu_dai_driver),
 	.dai_osr_clk_names	= (const char *[]) {
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index b729686..279cd02 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -49,9 +49,9 @@ struct lpass_data {
 	/* used it for handling interrupt per dma channel */
 	struct snd_pcm_substream *substream[LPASS_MAX_DMA_CHANNELS];
 
-	/* 8016 specific */
-	struct clk *pcnoc_mport_clk;
-	struct clk *pcnoc_sway_clk;
+	/* SOC specific clock list */
+	struct clk_bulk_data *clks;
+	int num_clks;
 
 };
 
@@ -87,6 +87,10 @@ struct lpass_variant {
 	int num_dai;
 	const char * const *dai_osr_clk_names;
 	const char * const *dai_bit_clk_names;
+
+	/* SOC specific clocks configuration */
+	const char **clk_name;
+	int num_clks;
 };
 
 /* register the platform driver from the CPU DAI driver */
-- 
1.9.1
