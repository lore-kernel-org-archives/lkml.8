Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB35C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9046C20873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583763918;
	bh=WKog/Z3eWreiPgowZwnHuYIiKaqytEO7j/CjS0mGOGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=0Xqcd6TIkUrIHaoim+kUwp6aXaWBew7AjYm9pIc25RtrRJRjJWJv0/0pQw34r/Uwp
	 W6fSVOTIapbSGAJmiRukrr/ScYQKn+69+UO0EDXkDYYVEzS0I3ZOKDgU1hq+lECMkW
	 8GdysO7PvMGa1Dz1TMMQ+DttcTEEVhJUo2uXIRj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCIOZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 10:25:17 -0400
Received: from foss.arm.com ([217.140.110.172]:53128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgCIOZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:25:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84B2F30E;
        Mon,  9 Mar 2020 07:25:16 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 079343F67D;
        Mon,  9 Mar 2020 07:25:15 -0700 (PDT)
Date:   Mon, 09 Mar 2020 14:25:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>
Subject: Applied "ASoC: jz4740-i2s: Avoid passing enum as match data" to the asoc tree
In-Reply-To:  <20200306222931.39664-4-paul@crapouillou.net>
Message-Id:  <applied-20200306222931.39664-4-paul@crapouillou.net>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: jz4740-i2s: Avoid passing enum as match data

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 62f9ed5f8768d2425461737d77b83f888b525c06 Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Fri, 6 Mar 2020 23:29:29 +0100
Subject: [PATCH] ASoC: jz4740-i2s: Avoid passing enum as match data

Instead of passing an enum as match data, and checking its value in the
probe to register one or the other dai, pass a pointer to a struct
i2s_soc_info, which contains all the information relative to one SoC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Link: https://lore.kernel.org/r/20200306222931.39664-4-paul@crapouillou.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/jz4740/jz4740-i2s.c | 36 ++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 2572aba843e3..d1512d483cda 100644
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
2.20.1

