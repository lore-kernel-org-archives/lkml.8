Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB258C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F27206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="aofibF9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgCFW37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:29:59 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:48288 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgCFW36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1583533781; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KYpwDP7uSX0WQKMOu9T+wZZUfdnqJXfPhxn6hjS/0i4=;
        b=aofibF9TJUEn7bffsrQZNJVBY2PplI8NSpd5EiO3tJ0QhnBr1WeOotOJkChPg81j7jnLjG
        aKmK+rtTgEzBqRwRqd58dtGwfxKLM49y8Z/MWrEhEHwHQs4pyP3Z2e/wc3qiXh6OI1xly+
        02PaCSvEp1QW4VBIOYg4YNgN88MbLdY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/6] ASoC: jz4740-i2s: Avoid passing enum as match data
Date:   Fri,  6 Mar 2020 23:29:29 +0100
Message-Id: <20200306222931.39664-4-paul@crapouillou.net>
In-Reply-To: <20200306222931.39664-1-paul@crapouillou.net>
References: <20200306222931.39664-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of passing an enum as match data, and checking its value in the
probe to register one or the other dai, pass a pointer to a struct
i2s_soc_info, which contains all the information relative to one SoC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/jz4740/jz4740-i2s.c | 36 ++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index b7e5056a8fde..3f9b2e1b4747 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -93,6 +93,11 @@ enum jz47xx_i2s_version {
 	JZ_I2S_JZ4780,
 };
 
+struct i2s_soc_info {
+	enum jz47xx_i2s_version version;
+	struct snd_soc_dai_driver *dai;
+};
+
 struct jz4740_i2s {
 	struct resource *mem;
 	void __iomem *base;
@@ -104,7 +109,7 @@ struct jz4740_i2s {
 	struct snd_dmaengine_dai_dma_data playback_dma_data;
 	struct snd_dmaengine_dai_dma_data capture_dma_data;
 
-	enum jz47xx_i2s_version version;
+	const struct i2s_soc_info *soc_info;
 };
 
 static inline uint32_t jz4740_i2s_read(const struct jz4740_i2s *i2s,
@@ -284,7 +289,7 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 		ctrl &= ~JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK;
 		ctrl |= sample_size << JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET;
 
-		if (i2s->version >= JZ_I2S_JZ4780) {
+		if (i2s->soc_info->version >= JZ_I2S_JZ4780) {
 			div_reg &= ~I2SDIV_IDV_MASK;
 			div_reg |= (div - 1) << I2SDIV_IDV_SHIFT;
 		} else {
@@ -398,7 +403,7 @@ static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 	snd_soc_dai_init_dma_data(dai, &i2s->playback_dma_data,
 		&i2s->capture_dma_data);
 
-	if (i2s->version >= JZ_I2S_JZ4780) {
+	if (i2s->soc_info->version >= JZ_I2S_JZ4780) {
 		conf = (7 << JZ4780_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET) |
 			(8 << JZ4780_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET) |
 			JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
@@ -457,6 +462,11 @@ static struct snd_soc_dai_driver jz4740_i2s_dai = {
 	.ops = &jz4740_i2s_dai_ops,
 };
 
+static const struct i2s_soc_info jz4740_i2s_soc_info = {
+	.version = JZ_I2S_JZ4740,
+	.dai = &jz4740_i2s_dai,
+};
+
 static struct snd_soc_dai_driver jz4780_i2s_dai = {
 	.probe = jz4740_i2s_dai_probe,
 	.remove = jz4740_i2s_dai_remove,
@@ -475,6 +485,11 @@ static struct snd_soc_dai_driver jz4780_i2s_dai = {
 	.ops = &jz4740_i2s_dai_ops,
 };
 
+static const struct i2s_soc_info jz4780_i2s_soc_info = {
+	.version = JZ_I2S_JZ4780,
+	.dai = &jz4780_i2s_dai,
+};
+
 static const struct snd_soc_component_driver jz4740_i2s_component = {
 	.name		= "jz4740-i2s",
 	.suspend	= jz4740_i2s_suspend,
@@ -483,8 +498,8 @@ static const struct snd_soc_component_driver jz4740_i2s_component = {
 
 #ifdef CONFIG_OF
 static const struct of_device_id jz4740_of_matches[] = {
-	{ .compatible = "ingenic,jz4740-i2s", .data = (void *)JZ_I2S_JZ4740 },
-	{ .compatible = "ingenic,jz4780-i2s", .data = (void *)JZ_I2S_JZ4780 },
+	{ .compatible = "ingenic,jz4740-i2s", .data = &jz4740_i2s_soc_info },
+	{ .compatible = "ingenic,jz4780-i2s", .data = &jz4780_i2s_soc_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, jz4740_of_matches);
@@ -501,7 +516,7 @@ static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 	if (!i2s)
 		return -ENOMEM;
 
-	i2s->version = (enum jz47xx_i2s_version)of_device_get_match_data(dev);
+	i2s->soc_info = device_get_match_data(dev);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	i2s->base = devm_ioremap_resource(dev, mem);
@@ -520,13 +535,8 @@ static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, i2s);
 
-	if (i2s->version == JZ_I2S_JZ4780)
-		ret = devm_snd_soc_register_component(dev,
-			&jz4740_i2s_component, &jz4780_i2s_dai, 1);
-	else
-		ret = devm_snd_soc_register_component(dev,
-			&jz4740_i2s_component, &jz4740_i2s_dai, 1);
-
+	ret = devm_snd_soc_register_component(dev, &jz4740_i2s_component,
+					      i2s->soc_info->dai, 1);
 	if (ret)
 		return ret;
 
-- 
2.25.1

