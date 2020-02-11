Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73733C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4785520656
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581436178;
	bh=41oiSAWX6KA46FTRlILkFTScXlGnOuWdqosQRRAAIgw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=ZI1HTkAsV80Pz7JWDyBPN1jePF2QxTntKM5qzq1qhIuKeSrdfXykhhPBSytuT4Zw5
	 3ltWtIloe6EaoOFRfFmnzIGn/t2lKiufrUipdkF84V7rxELrOesxDF3SuDZ8eJyp3p
	 1D4tgj6huDZPKDfenjNLZDEdr/Ic97h/l3hA11is=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbgBKPth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:49:37 -0500
Received: from foss.arm.com ([217.140.110.172]:48568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730482AbgBKPte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:49:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14B86139F;
        Tue, 11 Feb 2020 07:49:34 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F4663F68E;
        Tue, 11 Feb 2020 07:49:33 -0800 (PST)
Date:   Tue, 11 Feb 2020 15:49:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     alexandre.torgue@st.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, Etienne Carriere <etienne.carriere@st.com>,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com,
        olivier.moysan@st.com, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: stm32: spdifrx: improve error management on probe deferral" to the asoc tree
In-Reply-To: <20200203100814.22944-6-olivier.moysan@st.com>
Message-Id: <applied-20200203100814.22944-6-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: spdifrx: improve error management on probe deferral

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

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

From d49bd5ed24163a1a1c81d40e84295731ddd17b1c Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 3 Feb 2020 11:08:13 +0100
Subject: [PATCH] ASoC: stm32: spdifrx: improve error management on probe
 deferral

Do not print an error trace when deferring probe for SPDIFRX driver.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Link: https://lore.kernel.org/r/20200203100814.22944-6-olivier.moysan@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_spdifrx.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 9f80ddf34443..49766afdae61 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -406,7 +406,9 @@ static int stm32_spdifrx_dma_ctrl_register(struct device *dev,
 
 	spdifrx->ctrl_chan = dma_request_chan(dev, "rx-ctrl");
 	if (IS_ERR(spdifrx->ctrl_chan)) {
-		dev_err(dev, "dma_request_slave_channel failed\n");
+		if (PTR_ERR(spdifrx->ctrl_chan) != -EPROBE_DEFER)
+			dev_err(dev, "dma_request_slave_channel error %ld\n",
+				PTR_ERR(spdifrx->ctrl_chan));
 		return PTR_ERR(spdifrx->ctrl_chan);
 	}
 
@@ -929,7 +931,9 @@ static int stm32_spdifrx_parse_of(struct platform_device *pdev,
 
 	spdifrx->kclk = devm_clk_get(&pdev->dev, "kclk");
 	if (IS_ERR(spdifrx->kclk)) {
-		dev_err(&pdev->dev, "Could not get kclk\n");
+		if (PTR_ERR(spdifrx->kclk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Could not get kclk: %ld\n",
+				PTR_ERR(spdifrx->kclk));
 		return PTR_ERR(spdifrx->kclk);
 	}
 
@@ -967,7 +971,9 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 						    spdifrx->base,
 						    spdifrx->regmap_conf);
 	if (IS_ERR(spdifrx->regmap)) {
-		dev_err(&pdev->dev, "Regmap init failed\n");
+		if (PTR_ERR(spdifrx->regmap) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Regmap init error %ld\n",
+				PTR_ERR(spdifrx->regmap));
 		return PTR_ERR(spdifrx->regmap);
 	}
 
@@ -1003,7 +1009,8 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 	pcm_config = &stm32_spdifrx_pcm_config;
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, pcm_config, 0);
 	if (ret) {
-		dev_err(&pdev->dev, "PCM DMA register returned %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "PCM DMA register error %d\n", ret);
 		goto error;
 	}
 
-- 
2.20.1

