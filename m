Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74972C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4979D2078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbgDAIx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:53:28 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55482 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732107AbgDAIxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:53:25 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C3791200CD8;
        Wed,  1 Apr 2020 10:53:22 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6DACC200CD7;
        Wed,  1 Apr 2020 10:53:15 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9FEDC402DF;
        Wed,  1 Apr 2020 16:53:06 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/7] ASoC: fsl_asrc: Support new property fsl,asrc-format
Date:   Wed,  1 Apr 2020 16:45:37 +0800
Message-Id: <496f49f1fe20b969f4456b591f62223d430c6d74.1585726761.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1585726761.git.shengjiu.wang@nxp.com>
References: <cover.1585726761.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1585726761.git.shengjiu.wang@nxp.com>
References: <cover.1585726761.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to align with new ESARC, we add new property fsl,asrc-format.
The fsl,asrc-format can replace the fsl,asrc-width, driver
can accept format from devicetree, don't need to convert it to
format through width.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c     | 40 ++++++++++++++++++++++--------------
 sound/soc/fsl/fsl_asrc.h     |  4 ++--
 sound/soc/fsl/fsl_asrc_dma.c | 15 +++++++++++---
 3 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 4d3e51bfa949..eea19e2b723b 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -589,7 +589,6 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
 	unsigned int channels = params_channels(params);
 	unsigned int rate = params_rate(params);
 	struct asrc_config config;
-	snd_pcm_format_t format;
 	int ret;
 
 	ret = fsl_asrc_request_pair(channels, pair);
@@ -600,11 +599,6 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
 
 	pair->config = &config;
 
-	if (asrc->asrc_width == 16)
-		format = SNDRV_PCM_FORMAT_S16_LE;
-	else
-		format = SNDRV_PCM_FORMAT_S24_LE;
-
 	config.pair = pair->index;
 	config.channel_num = channels;
 	config.inclk = INCLK_NONE;
@@ -612,11 +606,11 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		config.input_format   = params_format(params);
-		config.output_format  = format;
+		config.output_format  = asrc->asrc_format;
 		config.input_sample_rate  = rate;
 		config.output_sample_rate = asrc->asrc_rate;
 	} else {
-		config.input_format   = format;
+		config.input_format   = asrc->asrc_format;
 		config.output_format  = params_format(params);
 		config.input_sample_rate  = asrc->asrc_rate;
 		config.output_sample_rate = rate;
@@ -946,6 +940,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 	int irq, ret, i;
 	u32 map_idx;
 	char tmp[16];
+	u32 width;
 
 	asrc = devm_kzalloc(&pdev->dev, sizeof(*asrc), GFP_KERNEL);
 	if (!asrc)
@@ -1052,16 +1047,31 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = of_property_read_u32(np, "fsl,asrc-width",
-				   &asrc->asrc_width);
+	ret = of_property_read_u32(np, "fsl,asrc-format", &asrc->asrc_format);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to get output width\n");
-		return ret;
+		ret = of_property_read_u32(np, "fsl,asrc-width", &width);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to get output width\n");
+			return ret;
+		}
+
+		switch (width) {
+		case 16:
+			asrc->asrc_format = SNDRV_PCM_FORMAT_S16_LE;
+			break;
+		case 24:
+			asrc->asrc_format = SNDRV_PCM_FORMAT_S24_LE;
+			break;
+		default:
+			dev_warn(&pdev->dev, "unsupported width, switching to 24bit\n");
+			asrc->asrc_format = SNDRV_PCM_FORMAT_S24_LE;
+			break;
+		}
 	}
 
-	if (asrc->asrc_width != 16 && asrc->asrc_width != 24) {
-		dev_warn(&pdev->dev, "unsupported width, switching to 24bit\n");
-		asrc->asrc_width = 24;
+	if (!(FSL_ASRC_FORMATS & (1ULL << asrc->asrc_format))) {
+		dev_warn(&pdev->dev, "unsupported format, switching to S24_LE\n");
+		asrc->asrc_format = SNDRV_PCM_FORMAT_S24_LE;
 	}
 
 	platform_set_drvdata(pdev, asrc);
diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
index 95d62c45afde..3b0f156af2c3 100644
--- a/sound/soc/fsl/fsl_asrc.h
+++ b/sound/soc/fsl/fsl_asrc.h
@@ -493,7 +493,7 @@ struct fsl_asrc_pair {
  * @channel_avail: non-occupied channel numbers
  * @clk_map: clock map for input/output clock
  * @asrc_rate: default sample rate for ASoC Back-Ends
- * @asrc_width: default sample width for ASoC Back-Ends
+ * @asrc_format: default sample format for ASoC Back-Ends
  * @regcache_cfg: store register value of REG_ASRCFG
  */
 struct fsl_asrc {
@@ -514,7 +514,7 @@ struct fsl_asrc {
 	unsigned char *clk_map[2];
 
 	int asrc_rate;
-	int asrc_width;
+	snd_pcm_format_t asrc_format;
 
 	u32 regcache_cfg;
 };
diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index 5fe83aece25b..b15946e03380 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -146,7 +146,7 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 	struct device *dev_be;
 	u8 dir = tx ? OUT : IN;
 	dma_cap_mask_t mask;
-	int ret;
+	int ret, bits;
 
 	/* Fetch the Back-End dma_data from DPCM */
 	for_each_dpcm_be(rtd, stream, dpcm) {
@@ -230,10 +230,19 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 		return -EINVAL;
 	}
 
-	if (asrc->asrc_width == 16)
+	bits = snd_pcm_format_physical_width(asrc->asrc_format);
+	if (bits < 8 || bits > 64)
+		return -EINVAL;
+	else if (bits == 8)
+		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	else if (bits == 16)
 		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
-	else
+	else if (bits == 24)
+		buswidth = DMA_SLAVE_BUSWIDTH_3_BYTES;
+	else if (bits <= 32)
 		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	else
+		buswidth = DMA_SLAVE_BUSWIDTH_8_BYTES;
 
 	config_be.direction = DMA_DEV_TO_DEV;
 	config_be.src_addr_width = buswidth;
-- 
2.21.0

