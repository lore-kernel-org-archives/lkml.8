Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495BAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F61420772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgGBOM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbgGBOMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:12:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0ACC08C5C1;
        Thu,  2 Jul 2020 07:12:21 -0700 (PDT)
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:315a:ecf0:6250:a3ed])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 35F8E2A5EC4;
        Thu,  2 Jul 2020 15:12:19 +0100 (BST)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     kernel@collabora.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] ASoC: fsl-asoc-card: add support for generic I2S slave use-case
Date:   Thu,  2 Jul 2020 16:11:15 +0200
Message-Id: <20200702141114.232688-3-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702141114.232688-1-arnaud.ferraris@collabora.com>
References: <20200702141114.232688-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements support for generic codecs with the SoC acting as
I2S slave, by implementing the new `fsl,imx-audio-i2s-slave` compatible
and related properties.

This is particularly useful when using a Bluetooth controller acting as
I2S master, but other simple or dummy codecs might benefit from it too.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 46 ++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 57ea1b072326..6076b963c873 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -166,12 +166,15 @@ static int fsl_asoc_card_hw_params(struct snd_pcm_substream *substream,
 		return 0;
 
 	/* Specific configurations of DAIs starts from here */
-	ret = snd_soc_dai_set_sysclk(asoc_rtd_to_cpu(rtd, 0), cpu_priv->sysclk_id[tx],
-				     cpu_priv->sysclk_freq[tx],
-				     cpu_priv->sysclk_dir[tx]);
-	if (ret && ret != -ENOTSUPP) {
-		dev_err(dev, "failed to set sysclk for cpu dai\n");
-		return ret;
+	if (cpu_priv->sysclk_freq[tx] > 0) {
+		ret = snd_soc_dai_set_sysclk(asoc_rtd_to_cpu(rtd, 0),
+					     cpu_priv->sysclk_id[tx],
+					     cpu_priv->sysclk_freq[tx],
+					     cpu_priv->sysclk_dir[tx]);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(dev, "failed to set sysclk for cpu dai\n");
+			return ret;
+		}
 	}
 
 	if (cpu_priv->slot_width) {
@@ -475,11 +478,14 @@ static int fsl_asoc_card_late_probe(struct snd_soc_card *card)
 		return 0;
 	}
 
-	ret = snd_soc_dai_set_sysclk(codec_dai, codec_priv->mclk_id,
-				     codec_priv->mclk_freq, SND_SOC_CLOCK_IN);
-	if (ret && ret != -ENOTSUPP) {
-		dev_err(dev, "failed to set sysclk in %s\n", __func__);
-		return ret;
+	if (codec_priv->mclk_freq > 0) {
+		ret = snd_soc_dai_set_sysclk(codec_dai, codec_priv->mclk_id,
+					     codec_priv->mclk_freq,
+					     SND_SOC_CLOCK_IN);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(dev, "failed to set sysclk in %s\n", __func__);
+			return ret;
+		}
 	}
 
 	return 0;
@@ -620,6 +626,23 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->cpu_priv.slot_width = 32;
 		priv->card.dapm_routes = audio_map_tx;
 		priv->card.num_dapm_routes = ARRAY_SIZE(audio_map_tx);
+	} else if (of_device_is_compatible(np, "fsl,imx-audio-i2s-slave")) {
+		ret = of_property_read_string(np, "audio-codec-dai-name",
+					      &codec_dai_name);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to get codec DAI name\n");
+			ret = -EINVAL;
+			goto asrc_fail;
+		}
+		ret = of_property_read_u32(np, "audio-slot-width",
+					   &priv->cpu_priv.slot_width);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to get slot width\n");
+			ret = -EINVAL;
+			goto asrc_fail;
+		}
+		priv->card.set_bias_level = NULL;
+		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
 	} else {
 		dev_err(&pdev->dev, "unknown Device Tree compatible\n");
 		ret = -EINVAL;
@@ -763,6 +786,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 
 static const struct of_device_id fsl_asoc_card_dt_ids[] = {
 	{ .compatible = "fsl,imx-audio-ac97", },
+	{ .compatible = "fsl,imx-audio-i2s-slave", },
 	{ .compatible = "fsl,imx-audio-cs42888", },
 	{ .compatible = "fsl,imx-audio-cs427x", },
 	{ .compatible = "fsl,imx-audio-sgtl5000", },
-- 
2.27.0

