Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F4CC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC56E20705
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="x3vpN2ti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgCFW3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:29:52 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:48178 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgCFW3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1583533779; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yRGg6vO7hMIxilmoFbXVvo35zl/6jF7rGN4qOJe/OOE=;
        b=x3vpN2tin6NERjx2+lVzw/clOc67Dd4y/qx3U8Y7EZUi58iPda05Veka6z9hKrOTBcpKPY
        shrh/XvoIcLb6JYSq/R+tfiXdahqgV1YsYTMQOy0uQch+dha7wjOVBRh3yXeiGCENaGg4t
        ZULk80cHXrjRHNxfx1ZAuy71JT2F+wg=
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
Subject: [PATCH 3/6] ASoC: jz4740-i2s: Add local dev variable in probe function
Date:   Fri,  6 Mar 2020 23:29:28 +0100
Message-Id: <20200306222931.39664-3-paul@crapouillou.net>
In-Reply-To: <20200306222931.39664-1-paul@crapouillou.net>
References: <20200306222931.39664-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the code cleaner by using a "struct device *dev" variable instead
of dereferencing it everytime from within the struct platform_device.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/jz4740/jz4740-i2s.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 434737b2b2b2..b7e5056a8fde 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -492,45 +492,45 @@ MODULE_DEVICE_TABLE(of, jz4740_of_matches);
 
 static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct jz4740_i2s *i2s;
 	struct resource *mem;
 	int ret;
 
-	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
+	i2s = devm_kzalloc(dev, sizeof(*i2s), GFP_KERNEL);
 	if (!i2s)
 		return -ENOMEM;
 
-	i2s->version =
-		(enum jz47xx_i2s_version)of_device_get_match_data(&pdev->dev);
+	i2s->version = (enum jz47xx_i2s_version)of_device_get_match_data(dev);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	i2s->base = devm_ioremap_resource(&pdev->dev, mem);
+	i2s->base = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(i2s->base))
 		return PTR_ERR(i2s->base);
 
 	i2s->phys_base = mem->start;
 
-	i2s->clk_aic = devm_clk_get(&pdev->dev, "aic");
+	i2s->clk_aic = devm_clk_get(dev, "aic");
 	if (IS_ERR(i2s->clk_aic))
 		return PTR_ERR(i2s->clk_aic);
 
-	i2s->clk_i2s = devm_clk_get(&pdev->dev, "i2s");
+	i2s->clk_i2s = devm_clk_get(dev, "i2s");
 	if (IS_ERR(i2s->clk_i2s))
 		return PTR_ERR(i2s->clk_i2s);
 
 	platform_set_drvdata(pdev, i2s);
 
 	if (i2s->version == JZ_I2S_JZ4780)
-		ret = devm_snd_soc_register_component(&pdev->dev,
+		ret = devm_snd_soc_register_component(dev,
 			&jz4740_i2s_component, &jz4780_i2s_dai, 1);
 	else
-		ret = devm_snd_soc_register_component(&pdev->dev,
+		ret = devm_snd_soc_register_component(dev,
 			&jz4740_i2s_component, &jz4740_i2s_dai, 1);
 
 	if (ret)
 		return ret;
 
-	return devm_snd_dmaengine_pcm_register(&pdev->dev, NULL,
+	return devm_snd_dmaengine_pcm_register(dev, NULL,
 		SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
 
-- 
2.25.1

