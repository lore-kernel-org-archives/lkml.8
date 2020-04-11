Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5125BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FDD20692
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="QUWnkVIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgDKIEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 04:04:34 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:32636 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726697AbgDKIEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 04:04:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586592271; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Bnz6MJ/qFfPiLKy+tJVoenTR3jVnJA77P0RTyIyn02s=; b=QUWnkVIEdgQeUXtS4j8MVgbLlEVF6ASWF9lhEOE5xUAJfLBXP8cQqL+EmFlWVcRwnWfQ/4wp
 F8MPciKE6o4O0pStFOfWyAl5tWL7pJLzFbwqhfnSN5lO4nycA1G2QeWEtCq/wCWrJWKy33OS
 LfLDH4GvztgIC2R++nDHGhxN3nA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e917a0f.7f0d06be3768-smtp-out-n04;
 Sat, 11 Apr 2020 08:04:31 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BE094C433F2; Sat, 11 Apr 2020 08:04:30 +0000 (UTC)
Received: from c-ajitp-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ajitp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B1E94C433CB;
        Sat, 11 Apr 2020 08:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B1E94C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ajitp@codeaurora.org
From:   Ajit Pandey <ajitp@codeaurora.org>
To:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.com,
        Ajit Pandey <ajitp@codeaurora.org>
Subject: [PATCH 08/11] ASoC: qcom : lpass: Add support to configure dai's connection mode
Date:   Sat, 11 Apr 2020 13:32:48 +0530
Message-Id: <1586592171-31644-9-git-send-email-ajitp@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
References: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few dai configuration depends on board layout and use cases. Add new
variables in dai_data to configure dai modes based on values defined
in device tree configuration of board.

Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
---
 sound/soc/qcom/lpass-cpu.c | 70 ++++++++++++++++++++++++++++++++++++++++++++--
 sound/soc/qcom/lpass.h     |  6 ++++
 2 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 006ba5a..f96338f 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -90,8 +90,9 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 		return bitwidth;
 	}
 
-	regval = LPAIF_I2SCTL(v, LOOPBACK_DISABLE);
-	regval |= LPAIF_I2SCTL(v, WSSRC_INTERNAL);
+	/* default to Loopback disable & wssrc internal */
+	regval = dai_data->loopback << (LPAIF_I2SCTL(v, LOOPBACK_SHIFT));
+	regval |= dai_data->wssrc << (LPAIF_I2SCTL(v, WSSRC_SHIFT));
 
 	switch (bitwidth) {
 	case 16:
@@ -172,6 +173,28 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	/* Overwrite spk & mic mode bits with device tree value if specified */
+	if (dai_data->spkmode != 0) {
+		regval = dai_data->spkmode << (LPAIF_I2SCTL(v, SPKMODE_SHIFT));
+		ret = regmap_update_bits(drvdata->lpaif_map,
+			LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
+			LPAIF_I2SCTL(v, SPKMODE_MASK), regval);
+		if (ret)
+			dev_err(dai->dev, "error writing to i2sctl reg: %d\n",
+				ret);
+	}
+
+
+	if (dai_data->micmode != 0) {
+		regval = dai_data->micmode << (LPAIF_I2SCTL(v, MICMODE_SHIFT));
+		ret = regmap_update_bits(drvdata->lpaif_map,
+			LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
+			LPAIF_I2SCTL(v, MICMODE_MASK), regval);
+		if (ret)
+			dev_err(dai->dev, "error writing to i2sctl reg: %d\n",
+				ret);
+	}
+
 	ret = clk_set_rate(dai_data->bit_clk, rate * bitwidth * 2);
 	if (ret) {
 		dev_err(dai->dev, "error setting mi2s bitclk to %u: %d\n",
@@ -423,6 +446,46 @@ static bool lpass_cpu_regmap_volatile(struct device *dev, unsigned int reg)
 	.cache_type = REGCACHE_FLAT,
 };
 
+static void of_qcom_parse_dai_data(struct device *dev,
+				    struct lpass_data *drvdata)
+{
+	struct device_node *node;
+	struct lpass_dai *dai;
+	int ret;
+
+	for_each_child_of_node(dev->of_node, node) {
+		int id;
+
+		ret = of_property_read_u32(node, "id", &id);
+		if (ret || id < 0 || id >= LPASS_MAX_MI2S_PORTS) {
+			dev_err(dev, "valid dai id not found:%d\n", ret);
+			continue;
+		}
+
+		dai = drvdata->dai_priv[id];
+		switch (id) {
+		case MI2S_PRIMARY... MI2S_QUATERNARY:
+			 /* MI2S specific properties */
+			ret = of_property_read_u32(node, "qcom,spkmode-mask",
+						   &dai->spkmode);
+
+			ret = of_property_read_u32(node, "qcom,micmode-mask",
+						   &dai->micmode);
+
+			ret = of_property_read_u32(node, "qcom,wssrc-mask",
+						   &dai->wssrc);
+
+			ret = of_property_read_u32(node, "qcom,loopback-mask",
+						   &dai->loopback);
+
+			break;
+		default:
+			dev_err(dev, "valid dai not found:%d\n", id);
+			break;
+		}
+	}
+}
+
 static int lpass_init_dai_clocks(struct device *dev,
 			   struct lpass_data *drvdata)
 {
@@ -501,6 +564,9 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 						GFP_KERNEL);
 	}
 
+	/* parse dai data from dts */
+	of_qcom_parse_dai_data(dev, drvdata);
+
 	ret = lpass_init_dai_clocks(dev, drvdata);
 	if (ret) {
 		dev_err(&pdev->dev, "error intializing dai clock: %d\n", ret);
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 384f4b8..960ee97 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -12,6 +12,7 @@
 #include <linux/compiler.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <dt-bindings/sound/qcom,lpass.h>
 
 #define LPASS_AHBIX_CLOCK_FREQUENCY            131072000
 #define LPASS_MAX_MI2S_PORTS                   (8)
@@ -23,6 +24,11 @@
 struct lpass_dai {
 	struct clk *osr_clk;
 	struct clk *bit_clk;
+
+	uint32_t spkmode;
+	uint32_t micmode;
+	uint32_t wssrc;
+	uint32_t loopback;
 };
 
 /* Both the CPU DAI and platform drivers will access this data */
-- 
1.9.1
