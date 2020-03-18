Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDF2C43332
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40EA20777
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584567719;
	bh=q1ZRi7IHIhtCRPdsKT19s0Mf+yBaQVRxm/aCkk3HWko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=pDJUcz0mI1qWL99qha08AClBTxFdYwMzKSua5H04tTymO4NbxCD1IV/90zsT0pnU5
	 ykmzB6ZYDfM33xW7khji++PROzRCwvVtgR7rAVWD5YJvIEABXusK6sCDrrDqfv/bYL
	 /qnRc8Wf3OVaxQ5YOxJgHskk+62sRMFhgUfFHweQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgCRVl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:41:58 -0400
Received: from foss.arm.com ([217.140.110.172]:55322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgCRVl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 17:41:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E5AFFEC;
        Wed, 18 Mar 2020 14:41:57 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 965A73F67D;
        Wed, 18 Mar 2020 14:41:56 -0700 (PDT)
Date:   Wed, 18 Mar 2020 21:41:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     alexandre.torgue@st.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, olivier.moysan@st.com,
        perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: stm32: spdifrx: manage rebind issue" to the asoc tree
In-Reply-To:  <20200318144125.9163-3-olivier.moysan@st.com>
Message-Id:  <applied-20200318144125.9163-3-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: spdifrx: manage rebind issue

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

From 794df9448edb55978e50372f083aeedade1b2844 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Wed, 18 Mar 2020 15:41:24 +0100
Subject: [PATCH] ASoC: stm32: spdifrx: manage rebind issue

The commit e894efef9ac7 ("ASoC: core: add support to card rebind")
allows to rebind the sound card after a rebind of one of its component.
With this commit, the sound card is actually rebound,
but may be no more functional.

Corrections:
- Call snd_dmaengine_pcm_register() before snd_soc_register_component().
- Call snd_dmaengine_pcm_unregister() and snd_soc_unregister_component()
explicitly from SPDFIRX driver.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Link: https://lore.kernel.org/r/20200318144125.9163-3-olivier.moysan@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_spdifrx.c | 62 ++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 49766afdae61..ae7a0f46a6fb 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -944,6 +944,22 @@ static int stm32_spdifrx_parse_of(struct platform_device *pdev,
 	return 0;
 }
 
+static int stm32_spdifrx_remove(struct platform_device *pdev)
+{
+	struct stm32_spdifrx_data *spdifrx = platform_get_drvdata(pdev);
+
+	if (spdifrx->ctrl_chan)
+		dma_release_channel(spdifrx->ctrl_chan);
+
+	if (spdifrx->dmab)
+		snd_dma_free_pages(spdifrx->dmab);
+
+	snd_dmaengine_pcm_unregister(&pdev->dev);
+	snd_soc_unregister_component(&pdev->dev);
+
+	return 0;
+}
+
 static int stm32_spdifrx_probe(struct platform_device *pdev)
 {
 	struct stm32_spdifrx_data *spdifrx;
@@ -995,25 +1011,27 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 	udelay(2);
 	reset_control_deassert(rst);
 
-	ret = devm_snd_soc_register_component(&pdev->dev,
-					      &stm32_spdifrx_component,
-					      stm32_spdifrx_dai,
-					      ARRAY_SIZE(stm32_spdifrx_dai));
-	if (ret)
-		return ret;
-
-	ret = stm32_spdifrx_dma_ctrl_register(&pdev->dev, spdifrx);
-	if (ret)
-		goto error;
-
 	pcm_config = &stm32_spdifrx_pcm_config;
-	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, pcm_config, 0);
+	ret = snd_dmaengine_pcm_register(&pdev->dev, pcm_config, 0);
 	if (ret) {
 		if (ret != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "PCM DMA register error %d\n", ret);
-		goto error;
+		return ret;
 	}
 
+	ret = snd_soc_register_component(&pdev->dev,
+					 &stm32_spdifrx_component,
+					 stm32_spdifrx_dai,
+					 ARRAY_SIZE(stm32_spdifrx_dai));
+	if (ret) {
+		snd_dmaengine_pcm_unregister(&pdev->dev);
+		return ret;
+	}
+
+	ret = stm32_spdifrx_dma_ctrl_register(&pdev->dev, spdifrx);
+	if (ret)
+		goto error;
+
 	ret = regmap_read(spdifrx->regmap, STM32_SPDIFRX_IDR, &idr);
 	if (ret)
 		goto error;
@@ -1029,27 +1047,11 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 	return ret;
 
 error:
-	if (!IS_ERR(spdifrx->ctrl_chan))
-		dma_release_channel(spdifrx->ctrl_chan);
-	if (spdifrx->dmab)
-		snd_dma_free_pages(spdifrx->dmab);
+	stm32_spdifrx_remove(pdev);
 
 	return ret;
 }
 
-static int stm32_spdifrx_remove(struct platform_device *pdev)
-{
-	struct stm32_spdifrx_data *spdifrx = platform_get_drvdata(pdev);
-
-	if (spdifrx->ctrl_chan)
-		dma_release_channel(spdifrx->ctrl_chan);
-
-	if (spdifrx->dmab)
-		snd_dma_free_pages(spdifrx->dmab);
-
-	return 0;
-}
-
 MODULE_DEVICE_TABLE(of, stm32_spdifrx_ids);
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.20.1

