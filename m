Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DAEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A897D204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgF2S7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:59:52 -0400
Received: from inva021.nxp.com ([92.121.34.21]:35520 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728088AbgF2S7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:59:44 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 70AA02010B8;
        Mon, 29 Jun 2020 16:10:31 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AF2862010AB;
        Mon, 29 Jun 2020 16:10:26 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D0415402E7;
        Mon, 29 Jun 2020 22:10:20 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_asrc: Add an option to select internal ratio mode
Date:   Mon, 29 Jun 2020 21:58:35 +0800
Message-Id: <1593439115-19282-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASRC not only supports ideal ratio mode, but also supports
internal ratio mode.

For internal rato mode, the rate of clock source should be divided
with no remainder by sample rate, otherwise there is sound
distortion.

Add function fsl_asrc_select_clk() to find proper clock source for
internal ratio mode, if the clock source is available then internal
ratio mode will be selected.

With change, the ideal ratio mode is not the only option for user.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c | 58 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 95f6a9617b0b..fcafc8ecb131 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -582,11 +582,59 @@ static int fsl_asrc_dai_startup(struct snd_pcm_substream *substream,
 			SNDRV_PCM_HW_PARAM_RATE, &fsl_asrc_rate_constraints);
 }
 
+/**
+ * Select proper clock source for internal ratio mode
+ */
+static int fsl_asrc_select_clk(struct fsl_asrc_priv *asrc_priv,
+			       struct fsl_asrc_pair *pair,
+			       int in_rate,
+			       int out_rate)
+{
+	struct fsl_asrc_pair_priv *pair_priv = pair->private;
+	struct asrc_config *config = pair_priv->config;
+	int rate[2], select_clk[2]; /* Array size 2 means IN and OUT */
+	int clk_rate, clk_index;
+	int i = 0, j = 0;
+	bool clk_sel[2];
+
+	rate[0] = in_rate;
+	rate[1] = out_rate;
+
+	/* Select proper clock source for internal ratio mode */
+	for (j = 0; j < 2; j++) {
+		for (i = 0; i < ASRC_CLK_MAP_LEN; i++) {
+			clk_index = asrc_priv->clk_map[j][i];
+			clk_rate = clk_get_rate(asrc_priv->asrck_clk[clk_index]);
+			if (clk_rate != 0 && (clk_rate / rate[j]) <= 1024 &&
+			    (clk_rate % rate[j]) == 0)
+				break;
+		}
+
+		if (i == ASRC_CLK_MAP_LEN) {
+			select_clk[j] = OUTCLK_ASRCK1_CLK;
+			clk_sel[j] = false;
+		} else {
+			select_clk[j] = i;
+			clk_sel[j] = true;
+		}
+	}
+
+	/* Switch to ideal ratio mode if there is no proper clock source */
+	if (!clk_sel[IN] || !clk_sel[OUT])
+		select_clk[IN] = INCLK_NONE;
+
+	config->inclk = select_clk[IN];
+	config->outclk = select_clk[OUT];
+
+	return 0;
+}
+
 static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *params,
 				  struct snd_soc_dai *dai)
 {
 	struct fsl_asrc *asrc = snd_soc_dai_get_drvdata(dai);
+	struct fsl_asrc_priv *asrc_priv = asrc->private;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_asrc_pair *pair = runtime->private_data;
 	struct fsl_asrc_pair_priv *pair_priv = pair->private;
@@ -605,8 +653,6 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
 
 	config.pair = pair->index;
 	config.channel_num = channels;
-	config.inclk = INCLK_NONE;
-	config.outclk = OUTCLK_ASRCK1_CLK;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		config.input_format   = params_format(params);
@@ -620,6 +666,14 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
 		config.output_sample_rate = rate;
 	}
 
+	ret = fsl_asrc_select_clk(asrc_priv, pair,
+				  config.input_sample_rate,
+				  config.output_sample_rate);
+	if (ret) {
+		dev_err(dai->dev, "fail to select clock\n");
+		return ret;
+	}
+
 	ret = fsl_asrc_config_pair(pair, false);
 	if (ret) {
 		dev_err(dai->dev, "fail to config asrc pair\n");
-- 
2.21.0

