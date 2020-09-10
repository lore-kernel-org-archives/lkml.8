Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27E1C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E3A620BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WYVUOP78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbgIJKT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730676AbgIJKSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:18:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5856C0617A3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:17:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so6103641wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fI1uS4bVeiqLJzCVRZUdfDt50/7TaI5DFX9s+uR8bi0=;
        b=WYVUOP78Ceudw8wHTgtD4OL6yrcyMzVLx+5nuP/mHNT7rUuEGgFqmySkdD0ytYlUIT
         8IgjAcg417KQYMvJIDwSxzKsz7FqCuvmkUrFNz51IQwXhGY+FNbNKw5WnIhfY91rHSyS
         YSVvD99v221/B9M+Qv1lOioQPPdkYuDzg2bium2d9z7uIBEBkXxiNe0clrX3eJhD0A+2
         cnaLBhbvyAnSiove7mSyx+rpAr3Pl3YvdQKSrmh3U7gz2oCM4PwecYyjoZxII4dHWiQf
         qtj/FZe/TBe6Z6q0Q6dNxfYnf8P4TNytw4F5+jUs6gDc3DV1wqKChJYyJ3M+A8b36pkL
         NA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fI1uS4bVeiqLJzCVRZUdfDt50/7TaI5DFX9s+uR8bi0=;
        b=N9R0n57hjLytreMPEB1IsRuZwF4XLrqAKdC5qZ6AHjNjMZSEnfWwD0P8tfBZ9TnruF
         iCRnXxnMfunMFn4XovkL8JJd2sJoEZQEvgGHSxOvLWAlKpKU3Uv74JJn2h4AL5ARqfeU
         F9G3J8miL5p2QrBkLZZifzCOSNo6UOaTmgXRPsIk+gLFy/Se+Q6KtBz+jqVEpCLfYg7m
         0vqnL0DG1ft+Ow+FABKXgYaWKNB0gG3mTQaYVtGVTG+gCpavlHpf1SE9T4oZMEhjOub9
         PMVcNt8WlkNPr0tpvyAHDk6E07BssV+Jcs3DSZtMXyv/SpAUjqy0dWvfBrl+ntWzRX9K
         /8QQ==
X-Gm-Message-State: AOAM531EIEXHooWUYtxWweX4FIxjBfGx2A0q6ln9on5nP5QKUUrTBFCh
        e90Li1XphfpCJOQ5xkTLDfuNaejyInaH9Q==
X-Google-Smtp-Source: ABdhPJyDqSI3QwjTu46eo8utnMHXlAibRnHzADDlFuXxPCwSOFwTJn3ww+z5s6A933WGx+awyhPUFw==
X-Received: by 2002:a5d:4591:: with SMTP id p17mr8084131wrq.408.1599733077453;
        Thu, 10 Sep 2020 03:17:57 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id m4sm8851731wro.18.2020.09.10.03.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 03:17:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 8/8] ASoC: q6dsp: q6afe-dai: add support to Codec DMA ports
Date:   Thu, 10 Sep 2020 11:17:32 +0100
Message-Id: <20200910101732.23484-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200910101732.23484-1-srinivas.kandagatla@linaro.org>
References: <20200910101732.23484-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 229 +++++++++++++++++++++++++++++++
 1 file changed, 229 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 0168af849272..d58b86a98114 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -55,6 +55,48 @@
 		.remove = msm_dai_q6_dai_remove,			\
 	}
 
+#define Q6AFE_CDC_DMA_RX_DAI(did) {				\
+		.playback = {						\
+			.stream_name = #did" Playback",	\
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
+				SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000 |\
+				SNDRV_PCM_RATE_176400,			\
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |		\
+				   SNDRV_PCM_FMTBIT_S24_LE |		\
+				   SNDRV_PCM_FMTBIT_S32_LE,		\
+			.channels_min = 1,				\
+			.channels_max = 8,				\
+			.rate_min = 8000,				\
+			.rate_max = 176400,				\
+		},							\
+		.name = #did,						\
+		.ops = &q6dma_ops,					\
+		.id = did,						\
+		.probe = msm_dai_q6_dai_probe,				\
+		.remove = msm_dai_q6_dai_remove,			\
+	}
+
+#define Q6AFE_CDC_DMA_TX_DAI(did) {				\
+		.capture = {						\
+			.stream_name = #did" Capture",		\
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
+				SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000 |\
+				SNDRV_PCM_RATE_176400,			\
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |		\
+				   SNDRV_PCM_FMTBIT_S24_LE |		\
+				   SNDRV_PCM_FMTBIT_S32_LE,		\
+			.channels_min = 1,				\
+			.channels_max = 8,				\
+			.rate_min = 8000,				\
+			.rate_max = 176400,				\
+		},							\
+		.name = #did,						\
+		.ops = &q6dma_ops,					\
+		.id = did,						\
+		.probe = msm_dai_q6_dai_probe,				\
+		.remove = msm_dai_q6_dai_remove,			\
+	}
+
 struct q6afe_dai_priv_data {
 	uint32_t sd_line_mask;
 	uint32_t sync_mode;
@@ -307,6 +349,90 @@ static int q6tdm_hw_params(struct snd_pcm_substream *substream,
 
 	return 0;
 }
+
+static int q6dma_set_channel_map(struct snd_soc_dai *dai,
+				 unsigned int tx_num, unsigned int *tx_ch_mask,
+				 unsigned int rx_num, unsigned int *rx_ch_mask)
+{
+
+	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
+	struct q6afe_cdc_dma_cfg *cfg = &dai_data->port_config[dai->id].dma_cfg;
+	int ch_mask;
+	int rc = 0;
+
+	switch (dai->id) {
+	case WSA_CODEC_DMA_TX_0:
+	case WSA_CODEC_DMA_TX_1:
+	case WSA_CODEC_DMA_TX_2:
+	case VA_CODEC_DMA_TX_0:
+	case VA_CODEC_DMA_TX_1:
+	case VA_CODEC_DMA_TX_2:
+	case TX_CODEC_DMA_TX_0:
+	case TX_CODEC_DMA_TX_1:
+	case TX_CODEC_DMA_TX_2:
+	case TX_CODEC_DMA_TX_3:
+	case TX_CODEC_DMA_TX_4:
+	case TX_CODEC_DMA_TX_5:
+		if (!tx_ch_mask) {
+			dev_err(dai->dev, "tx slot not found\n");
+			return -EINVAL;
+		}
+
+		if (tx_num > AFE_PORT_MAX_AUDIO_CHAN_CNT) {
+			dev_err(dai->dev, "invalid tx num %d\n",
+				tx_num);
+			return -EINVAL;
+		}
+		ch_mask = *tx_ch_mask;
+
+		break;
+	case WSA_CODEC_DMA_RX_0:
+	case WSA_CODEC_DMA_RX_1:
+	case RX_CODEC_DMA_RX_0:
+	case RX_CODEC_DMA_RX_1:
+	case RX_CODEC_DMA_RX_2:
+	case RX_CODEC_DMA_RX_3:
+	case RX_CODEC_DMA_RX_4:
+	case RX_CODEC_DMA_RX_5:
+	case RX_CODEC_DMA_RX_6:
+	case RX_CODEC_DMA_RX_7:
+		/* rx */
+		if (!rx_ch_mask) {
+			dev_err(dai->dev, "rx slot not found\n");
+			return -EINVAL;
+		}
+		if (rx_num > AFE_PORT_MAX_AUDIO_CHAN_CNT) {
+			dev_err(dai->dev, "invalid rx num %d\n",
+				rx_num);
+			return -EINVAL;
+		}
+		ch_mask = *rx_ch_mask;
+
+		break;
+	default:
+		dev_err(dai->dev, "%s: invalid dai id 0x%x\n",
+			__func__, dai->id);
+		return -EINVAL;
+	}
+
+	cfg->active_channels_mask = ch_mask;
+
+	return rc;
+}
+
+static int q6dma_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai)
+{
+	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
+	struct q6afe_cdc_dma_cfg *cfg = &dai_data->port_config[dai->id].dma_cfg;
+
+	cfg->bit_width = params_width(params);
+	cfg->sample_rate = params_rate(params);
+	cfg->num_channels = params_channels(params);
+
+	return 0;
+}
 static void q6afe_dai_shutdown(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
@@ -362,6 +488,10 @@ static int q6afe_dai_prepare(struct snd_pcm_substream *substream,
 		q6afe_tdm_port_prepare(dai_data->port[dai->id],
 					&dai_data->port_config[dai->id].tdm);
 		break;
+	case WSA_CODEC_DMA_RX_0 ... RX_CODEC_DMA_RX_7:
+		q6afe_cdc_dma_port_prepare(dai_data->port[dai->id],
+					   &dai_data->port_config[dai->id].dma_cfg);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -430,6 +560,7 @@ static int q6afe_mi2s_set_sysclk(struct snd_soc_dai *dai,
 					     freq, dir);
 	case Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT ... Q6AFE_LPASS_CLK_ID_QUI_MI2S_OSR:
 	case Q6AFE_LPASS_CLK_ID_MCLK_1 ... Q6AFE_LPASS_CLK_ID_INT_MCLK_1:
+	case Q6AFE_LPASS_CLK_ID_WSA_CORE_MCLK ... Q6AFE_LPASS_CLK_ID_VA_CORE_2X_MCLK:
 		return q6afe_port_set_sysclk(port, clk_id,
 					     Q6AFE_LPASS_CLK_ATTRIBUTE_COUPLE_NO,
 					     Q6AFE_LPASS_CLK_ROOT_DEFAULT,
@@ -562,6 +693,29 @@ static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
 	{"PRI_MI2S_TX", NULL, "Primary MI2S Capture"},
 	{"SEC_MI2S_TX", NULL, "Secondary MI2S Capture"},
 	{"QUAT_MI2S_TX", NULL, "Quaternary MI2S Capture"},
+
+	{"WSA_CODEC_DMA_RX_0 Playback", NULL, "WSA_CODEC_DMA_RX_0"},
+	{"WSA_CODEC_DMA_TX_0", NULL, "WSA_CODEC_DMA_TX_0 Capture"},
+	{"WSA_CODEC_DMA_RX_1 Playback", NULL, "WSA_CODEC_DMA_RX_1"},
+	{"WSA_CODEC_DMA_TX_1", NULL, "WSA_CODEC_DMA_TX_1 Capture"},
+	{"WSA_CODEC_DMA_TX_2", NULL, "WSA_CODEC_DMA_TX_2 Capture"},
+	{"VA_CODEC_DMA_TX_0", NULL, "VA_CODEC_DMA_TX_0 Capture"},
+	{"VA_CODEC_DMA_TX_1", NULL, "VA_CODEC_DMA_TX_1 Capture"},
+	{"VA_CODEC_DMA_TX_2", NULL, "VA_CODEC_DMA_TX_2 Capture"},
+	{"RX_CODEC_DMA_RX_0 Playback", NULL, "RX_CODEC_DMA_RX_0"},
+	{"TX_CODEC_DMA_TX_0", NULL, "TX_CODEC_DMA_TX_0 Capture"},
+	{"RX_CODEC_DMA_RX_1 Playback", NULL, "RX_CODEC_DMA_RX_1"},
+	{"TX_CODEC_DMA_TX_1", NULL, "TX_CODEC_DMA_TX_1 Capture"},
+	{"RX_CODEC_DMA_RX_2 Playback", NULL, "RX_CODEC_DMA_RX_2"},
+	{"TX_CODEC_DMA_TX_2", NULL, "TX_CODEC_DMA_TX_2 Capture"},
+	{"RX_CODEC_DMA_RX_3 Playback", NULL, "RX_CODEC_DMA_RX_3"},
+	{"TX_CODEC_DMA_TX_3", NULL, "TX_CODEC_DMA_TX_3 Capture"},
+	{"RX_CODEC_DMA_RX_4 Playback", NULL, "RX_CODEC_DMA_RX_4"},
+	{"TX_CODEC_DMA_TX_4", NULL, "TX_CODEC_DMA_TX_4 Capture"},
+	{"RX_CODEC_DMA_RX_5 Playback", NULL, "RX_CODEC_DMA_RX_5"},
+	{"TX_CODEC_DMA_TX_5", NULL, "TX_CODEC_DMA_TX_5 Capture"},
+	{"RX_CODEC_DMA_RX_6 Playback", NULL, "RX_CODEC_DMA_RX_6"},
+	{"RX_CODEC_DMA_RX_7 Playback", NULL, "RX_CODEC_DMA_RX_7"},
 };
 
 static const struct snd_soc_dai_ops q6hdmi_ops = {
@@ -594,6 +748,14 @@ static const struct snd_soc_dai_ops q6tdm_ops = {
 	.hw_params        = q6tdm_hw_params,
 };
 
+static const struct snd_soc_dai_ops q6dma_ops = {
+	.prepare	= q6afe_dai_prepare,
+	.shutdown	= q6afe_dai_shutdown,
+	.set_sysclk	= q6afe_mi2s_set_sysclk,
+	.set_channel_map  = q6dma_set_channel_map,
+	.hw_params        = q6dma_hw_params,
+};
+
 static int msm_dai_q6_dai_probe(struct snd_soc_dai *dai)
 {
 	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
@@ -1128,6 +1290,28 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.probe = msm_dai_q6_dai_probe,
 		.remove = msm_dai_q6_dai_remove,
 	},
+	Q6AFE_CDC_DMA_RX_DAI(WSA_CODEC_DMA_RX_0),
+	Q6AFE_CDC_DMA_TX_DAI(WSA_CODEC_DMA_TX_0),
+	Q6AFE_CDC_DMA_RX_DAI(WSA_CODEC_DMA_RX_1),
+	Q6AFE_CDC_DMA_TX_DAI(WSA_CODEC_DMA_TX_1),
+	Q6AFE_CDC_DMA_TX_DAI(WSA_CODEC_DMA_TX_2),
+	Q6AFE_CDC_DMA_TX_DAI(VA_CODEC_DMA_TX_0),
+	Q6AFE_CDC_DMA_TX_DAI(VA_CODEC_DMA_TX_1),
+	Q6AFE_CDC_DMA_TX_DAI(VA_CODEC_DMA_TX_2),
+	Q6AFE_CDC_DMA_RX_DAI(RX_CODEC_DMA_RX_0),
+	Q6AFE_CDC_DMA_TX_DAI(TX_CODEC_DMA_TX_0),
+	Q6AFE_CDC_DMA_RX_DAI(RX_CODEC_DMA_RX_1),
+	Q6AFE_CDC_DMA_TX_DAI(TX_CODEC_DMA_TX_1),
+	Q6AFE_CDC_DMA_RX_DAI(RX_CODEC_DMA_RX_2),
+	Q6AFE_CDC_DMA_TX_DAI(TX_CODEC_DMA_TX_2),
+	Q6AFE_CDC_DMA_RX_DAI(RX_CODEC_DMA_RX_3),
+	Q6AFE_CDC_DMA_TX_DAI(TX_CODEC_DMA_TX_3),
+	Q6AFE_CDC_DMA_RX_DAI(RX_CODEC_DMA_RX_4),
+	Q6AFE_CDC_DMA_TX_DAI(TX_CODEC_DMA_TX_4),
+	Q6AFE_CDC_DMA_RX_DAI(RX_CODEC_DMA_RX_5),
+	Q6AFE_CDC_DMA_TX_DAI(TX_CODEC_DMA_TX_5),
+	Q6AFE_CDC_DMA_RX_DAI(RX_CODEC_DMA_RX_6),
+	Q6AFE_CDC_DMA_RX_DAI(RX_CODEC_DMA_RX_7),
 };
 
 static int q6afe_of_xlate_dai_name(struct snd_soc_component *component,
@@ -1350,6 +1534,51 @@ static const struct snd_soc_dapm_widget q6afe_dai_widgets[] = {
 	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_7", NULL,
 						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("DISPLAY_PORT_RX", "NULL", 0, SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_AIF_IN("WSA_CODEC_DMA_RX_0", "NULL",
+		0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("WSA_CODEC_DMA_TX_0", "NULL",
+		 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("WSA_CODEC_DMA_RX_1", "NULL",
+		0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("WSA_CODEC_DMA_TX_1", "NULL",
+		 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("WSA_CODEC_DMA_TX_2", "NULL",
+		 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("VA_CODEC_DMA_TX_0", "NULL",
+		 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("VA_CODEC_DMA_TX_1", "NULL",
+		 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("VA_CODEC_DMA_TX_2", "NULL",
+		 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX_CODEC_DMA_RX_0", "NULL",
+		0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("TX_CODEC_DMA_TX_0", "NULL",
+		 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX_CODEC_DMA_RX_1", "NULL",
+		0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("TX_CODEC_DMA_TX_1", "NULL",
+		 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX_CODEC_DMA_RX_2", "NULL",
+		0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("TX_CODEC_DMA_TX_2", "NULL",
+		 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX_CODEC_DMA_RX_3", "NULL",
+		0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("TX_CODEC_DMA_TX_3", "NULL",
+		 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX_CODEC_DMA_RX_4", "NULL",
+		0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("TX_CODEC_DMA_TX_4", "NULL",
+		 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX_CODEC_DMA_RX_5", "NULL",
+		0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("TX_CODEC_DMA_TX_5", "NULL",
+		 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX_CODEC_DMA_RX_6", "NULL",
+		0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX_CODEC_DMA_RX_7", "NULL",
+		0, SND_SOC_NOPM, 0, 0),
 };
 
 static const struct snd_soc_component_driver q6afe_dai_component = {
-- 
2.21.0

