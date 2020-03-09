Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7889C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7489520873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583763923;
	bh=CUvHsyb4NnoMIXB/Ro0tmAGHeTgxzBj9AjeT9wTt46g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=H3JM9LYWdXEbOZGBbandy2QKeY9h+XsBzHcOlVllZqBarlpC+GTyV1NCEdnwJ94Ic
	 vBE9eQQQHx7zyptbp39yyZ99VM7dXlzdtP/RdRTuPR82GBdGra6mMdr4bUr6hE69+A
	 l45xciaK2HkUf9xxfB5YonzF/EgAcqBzInFuPL+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgCIOZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 10:25:22 -0400
Received: from foss.arm.com ([217.140.110.172]:53154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgCIOZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:25:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F16707FA;
        Mon,  9 Mar 2020 07:25:20 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 750B93F67D;
        Mon,  9 Mar 2020 07:25:20 -0700 (PDT)
Date:   Mon, 09 Mar 2020 14:25:19 +0000
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
Subject: Applied "ASoC: jz4740-i2s: Add local dev variable in probe function" to the asoc tree
In-Reply-To:  <20200306222931.39664-3-paul@crapouillou.net>
Message-Id:  <applied-20200306222931.39664-3-paul@crapouillou.net>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: jz4740-i2s: Add local dev variable in probe function

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

From a42d9ba15cbf3e84307906db65fc598a8b73e2f1 Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Fri, 6 Mar 2020 23:29:28 +0100
Subject: [PATCH] ASoC: jz4740-i2s: Add local dev variable in probe function

Make the code cleaner by using a "struct device *dev" variable instead
of dereferencing it everytime from within the struct platform_device.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Link: https://lore.kernel.org/r/20200306222931.39664-3-paul@crapouillou.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/jz4740/jz4740-i2s.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 9d5405881209..2572aba843e3 100644
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
2.20.1

