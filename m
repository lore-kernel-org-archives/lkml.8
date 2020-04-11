Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24191C2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84DD2078E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="S5blbag5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgDKIED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 04:04:03 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:31820 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726037AbgDKIED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 04:04:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586592242; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=KXy1loHb2FhxhHhKQrd5okL0GUCoCdYflO1LTaz/12I=; b=S5blbag5tpnd0vEndOqBuSgNzD5QTI63+pp18sL5epso4N5F6kMKXetRqwgwHULdNR06r/ta
 UArH/bGe3oY828Ap2pSR3UgBEq9UCEfhHr4EaJ+9gyalRSL5KX9Tp4sdP/T+YKDdQgzoUn+D
 rDtq8+E+5odRGFae3Ms0RxXRbVM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9179e9.7f727dc2f0a0-smtp-out-n03;
 Sat, 11 Apr 2020 08:03:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0DCADC433F2; Sat, 11 Apr 2020 08:03:53 +0000 (UTC)
Received: from c-ajitp-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ajitp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 857D6C433CB;
        Sat, 11 Apr 2020 08:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 857D6C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ajitp@codeaurora.org
From:   Ajit Pandey <ajitp@codeaurora.org>
To:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.com,
        Ajit Pandey <ajitp@codeaurora.org>
Subject: [PATCH 02/11] ASoC: qcom: lpass: Add struct lpass_dai to store dai clocks pointer
Date:   Sat, 11 Apr 2020 13:32:42 +0530
Message-Id: <1586592171-31644-3-git-send-email-ajitp@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
References: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lpass_dai will store clocks related to respective dai's and it will
be initialized during probe based on variant clock names.

Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
---
 sound/soc/qcom/lpass-cpu.c | 89 ++++++++++++++++++++++++++--------------------
 sound/soc/qcom/lpass.h     | 18 +++++-----
 2 files changed, 61 insertions(+), 46 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index dbce7e9..492f27b 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -23,13 +23,15 @@ static int lpass_cpu_daiops_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 		unsigned int freq, int dir)
 {
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
-	int ret;
-
-	ret = clk_set_rate(drvdata->mi2s_osr_clk[dai->driver->id], freq);
-	if (ret)
-		dev_err(dai->dev, "error setting mi2s osrclk to %u: %d\n",
-			freq, ret);
+	struct lpass_dai *dai_data = drvdata->dai_priv[dai->driver->id];
+	int ret = 0;
 
+	if (dai_data->osr_clk != NULL) {
+		ret = clk_set_rate(dai_data->osr_clk, freq);
+		if (ret)
+			dev_err(dai->dev, "error setting mi2s osrclk to %u:%d\n",
+				freq, ret);
+	}
 	return ret;
 }
 
@@ -37,18 +39,22 @@ static int lpass_cpu_daiops_startup(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
+	struct lpass_dai *dai_data = drvdata->dai_priv[dai->driver->id];
 	int ret;
 
-	ret = clk_prepare_enable(drvdata->mi2s_osr_clk[dai->driver->id]);
-	if (ret) {
-		dev_err(dai->dev, "error in enabling mi2s osr clk: %d\n", ret);
-		return ret;
+	if (dai_data->osr_clk != NULL) {
+		ret = clk_prepare_enable(dai_data->osr_clk);
+		if (ret) {
+			dev_err(dai->dev,
+				"error in enabling mi2s osr clk: %d\n", ret);
+			return ret;
+		}
 	}
 
-	ret = clk_prepare_enable(drvdata->mi2s_bit_clk[dai->driver->id]);
+	ret = clk_prepare_enable(dai_data->bit_clk);
 	if (ret) {
 		dev_err(dai->dev, "error in enabling mi2s bit clk: %d\n", ret);
-		clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->driver->id]);
+		clk_disable_unprepare(dai_data->osr_clk);
 		return ret;
 	}
 
@@ -59,16 +65,18 @@ static void lpass_cpu_daiops_shutdown(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
+	struct lpass_dai *dai_data = drvdata->dai_priv[dai->driver->id];
 
-	clk_disable_unprepare(drvdata->mi2s_bit_clk[dai->driver->id]);
+	clk_disable_unprepare(dai_data->bit_clk);
 
-	clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->driver->id]);
+	clk_disable_unprepare(dai_data->osr_clk);
 }
 
 static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
+	struct lpass_dai *dai_data = drvdata->dai_priv[dai->driver->id];
 	snd_pcm_format_t format = params_format(params);
 	unsigned int channels = params_channels(params);
 	unsigned int rate = params_rate(params);
@@ -163,8 +171,7 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	ret = clk_set_rate(drvdata->mi2s_bit_clk[dai->driver->id],
-			   rate * bitwidth * 2);
+	ret = clk_set_rate(dai_data->bit_clk, rate * bitwidth * 2);
 	if (ret) {
 		dev_err(dai->dev, "error setting mi2s bitclk to %u: %d\n",
 			rate * bitwidth * 2, ret);
@@ -413,6 +420,25 @@ static bool lpass_cpu_regmap_volatile(struct device *dev, unsigned int reg)
 	.cache_type = REGCACHE_FLAT,
 };
 
+static int lpass_init_dai_clocks(struct device *dev,
+			   struct lpass_data *drvdata)
+{
+	struct lpass_dai *dai;
+	struct lpass_variant *v = drvdata->variant;
+	int i;
+
+	for (i = 0; i < v->num_dai; i++) {
+
+		dai = drvdata->dai_priv[i];
+
+		dai->osr_clk = devm_clk_get_optional(dev,
+						     v->dai_osr_clk_names[i]);
+		dai->bit_clk = devm_clk_get(dev, v->dai_bit_clk_names[i]);
+	}
+
+	return 0;
+}
+
 int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 {
 	struct lpass_data *drvdata;
@@ -421,7 +447,7 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 	struct lpass_variant *variant;
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *match;
-	int ret, i, dai_id;
+	int ret, i;
 
 	dsp_of_node = of_parse_phandle(pdev->dev.of_node, "qcom,adsp", 0);
 	if (dsp_of_node) {
@@ -467,28 +493,15 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 		variant->init(pdev);
 
 	for (i = 0; i < variant->num_dai; i++) {
-		dai_id = variant->dai_driver[i].id;
-		drvdata->mi2s_osr_clk[dai_id] = devm_clk_get(&pdev->dev,
-					     variant->dai_osr_clk_names[i]);
-		if (IS_ERR(drvdata->mi2s_osr_clk[dai_id])) {
-			dev_warn(&pdev->dev,
-				"%s() error getting optional %s: %ld\n",
-				__func__,
-				variant->dai_osr_clk_names[i],
-				PTR_ERR(drvdata->mi2s_osr_clk[dai_id]));
-
-			drvdata->mi2s_osr_clk[dai_id] = NULL;
-		}
+		drvdata->dai_priv[i] = devm_kzalloc(dev,
+						sizeof(struct lpass_dai),
+						GFP_KERNEL);
+	}
 
-		drvdata->mi2s_bit_clk[dai_id] = devm_clk_get(&pdev->dev,
-						variant->dai_bit_clk_names[i]);
-		if (IS_ERR(drvdata->mi2s_bit_clk[dai_id])) {
-			dev_err(&pdev->dev,
-				"error getting %s: %ld\n",
-				variant->dai_bit_clk_names[i],
-				PTR_ERR(drvdata->mi2s_bit_clk[dai_id]));
-			return PTR_ERR(drvdata->mi2s_bit_clk[dai_id]);
-		}
+	ret = lpass_init_dai_clocks(dev, drvdata);
+	if (ret) {
+		dev_err(&pdev->dev, "error intializing dai clock: %d\n", ret);
+		return ret;
 	}
 
 	drvdata->ahbix_clk = devm_clk_get(&pdev->dev, "ahbix-clk");
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 17113d3..b729686 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -13,9 +13,14 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
-#define LPASS_AHBIX_CLOCK_FREQUENCY		131072000
-#define LPASS_MAX_MI2S_PORTS			(8)
-#define LPASS_MAX_DMA_CHANNELS			(8)
+#define LPASS_AHBIX_CLOCK_FREQUENCY            131072000
+#define LPASS_MAX_MI2S_PORTS                   (8)
+#define LPASS_MAX_DMA_CHANNELS                 (8)
+
+struct lpass_dai {
+	struct clk *osr_clk;
+	struct clk *bit_clk;
+};
 
 /* Both the CPU DAI and platform drivers will access this data */
 struct lpass_data {
@@ -23,11 +28,8 @@ struct lpass_data {
 	/* AHB-I/X bus clocks inside the low-power audio subsystem (LPASS) */
 	struct clk *ahbix_clk;
 
-	/* MI2S system clock */
-	struct clk *mi2s_osr_clk[LPASS_MAX_MI2S_PORTS];
-
-	/* MI2S bit clock (derived from system clock by a divider */
-	struct clk *mi2s_bit_clk[LPASS_MAX_MI2S_PORTS];
+	/* MI2S dai specific configuration */
+	struct lpass_dai *dai_priv[LPASS_MAX_MI2S_PORTS];
 
 	/* low-power audio interface (LPAIF) registers */
 	void __iomem *lpaif;
-- 
1.9.1
