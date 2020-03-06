Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39373C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF82206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="AUaxDo09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCFWaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:30:13 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:48654 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgCFWaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1583533784; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=et3xssf9jXYhr8qjPkYvKPU7a6v5Pi9/fuLNjUQEHE4=;
        b=AUaxDo09VnVLjRyEvyn8VAx0fMz/9s7OWG93J1ekiE0IQXLcuv0BGM8uz1ahdwMzNmQiYH
        fM/TUjOzy7nVUN+d3tgzIPyh9JqCqTL2aga0izptLIAbrdRjzd71FLVfeBVPGADf4aZIIC
        E68LLyNQhCQJIk+niG25Yp8csQAPZCY=
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
Subject: [PATCH 6/6] ASoC: jz4740-i2s: Add support for the JZ4770
Date:   Fri,  6 Mar 2020 23:29:31 +0100
Message-Id: <20200306222931.39664-6-paul@crapouillou.net>
In-Reply-To: <20200306222931.39664-1-paul@crapouillou.net>
References: <20200306222931.39664-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before the JZ4770, the playback and capture sampling rates had to match.
The JZ4770 supports independent sampling rates for both.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/jz4740/jz4740-i2s.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 253f8d8ba273..6f6f8dad0356 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -87,6 +87,7 @@
 enum jz47xx_i2s_version {
 	JZ_I2S_JZ4740,
 	JZ_I2S_JZ4760,
+	JZ_I2S_JZ4770,
 	JZ_I2S_JZ4780,
 };
 
@@ -286,7 +287,7 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 		ctrl &= ~JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK;
 		ctrl |= sample_size << JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET;
 
-		if (i2s->soc_info->version >= JZ_I2S_JZ4780) {
+		if (i2s->soc_info->version >= JZ_I2S_JZ4770) {
 			div_reg &= ~I2SDIV_IDV_MASK;
 			div_reg |= (div - 1) << I2SDIV_IDV_SHIFT;
 		} else {
@@ -469,7 +470,7 @@ static const struct i2s_soc_info jz4760_i2s_soc_info = {
 	.dai = &jz4740_i2s_dai,
 };
 
-static struct snd_soc_dai_driver jz4780_i2s_dai = {
+static struct snd_soc_dai_driver jz4770_i2s_dai = {
 	.probe = jz4740_i2s_dai_probe,
 	.remove = jz4740_i2s_dai_remove,
 	.playback = {
@@ -487,9 +488,14 @@ static struct snd_soc_dai_driver jz4780_i2s_dai = {
 	.ops = &jz4740_i2s_dai_ops,
 };
 
+static const struct i2s_soc_info jz4770_i2s_soc_info = {
+	.version = JZ_I2S_JZ4770,
+	.dai = &jz4770_i2s_dai,
+};
+
 static const struct i2s_soc_info jz4780_i2s_soc_info = {
 	.version = JZ_I2S_JZ4780,
-	.dai = &jz4780_i2s_dai,
+	.dai = &jz4770_i2s_dai,
 };
 
 static const struct snd_soc_component_driver jz4740_i2s_component = {
@@ -502,6 +508,7 @@ static const struct snd_soc_component_driver jz4740_i2s_component = {
 static const struct of_device_id jz4740_of_matches[] = {
 	{ .compatible = "ingenic,jz4740-i2s", .data = &jz4740_i2s_soc_info },
 	{ .compatible = "ingenic,jz4760-i2s", .data = &jz4760_i2s_soc_info },
+	{ .compatible = "ingenic,jz4770-i2s", .data = &jz4770_i2s_soc_info },
 	{ .compatible = "ingenic,jz4780-i2s", .data = &jz4780_i2s_soc_info },
 	{ /* sentinel */ }
 };
-- 
2.25.1

