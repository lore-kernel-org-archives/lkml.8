Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4F5C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3227520829
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FWqAdG33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgIJKTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgIJKRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:17:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D27C061795
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:17:51 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so6053729wrp.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XiTDwe0DE6I7Qq6iJehCoT2zSGDBsTZiTs0CApOPA1I=;
        b=FWqAdG33IxMr+QgyxdRqUDWiYgJsK8hTsj1WMNseY5YWkHruSHbiEken0vXLzsuv3L
         CWDZaqI+bxxqe24R2Lu++jFMvrDaTD4qiZnN/4Xv1Citx8DDaz8LapDrZIsAgMfq06nP
         KtXqkfwDhaTfoYWS5LNXGWaIVZmyg7lYXYbvzLZU0+0phvgbKG+WVpEhG3YDYrUD4/Pb
         b5IWVUFMHez3kOAmU8bGxtrpgZrPOjQUITEQsJP/5/Ecxx75H5DOSHxqPVHaSPQYz9xa
         8XmL0dfz1BtqFgCUikJAQKHCuI1fhsmjHiI6kBmeZwf1wex3MQpzOLdqpVfEd++3f42Z
         0r4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XiTDwe0DE6I7Qq6iJehCoT2zSGDBsTZiTs0CApOPA1I=;
        b=WJDpptPyweoyscJ+yZr3lLCjP6Vt8qGLPrtlqmRFDwKfQJ0PUpjKjXiqF/NzqILaav
         5yAVb8YuDNeiNq0TOf2shsdHS69Agk8iQPWGgFT4fqVheTaJfbRzMoCH0XATmNq00g6D
         Y9ihLutWFt3cZQyBSXG6Dd8BAZy70EnywZ/jUqRlMufhRoDZAA6vo/bk9TjATZJke64F
         U6XqQqFtYLD04LPMq1LnRyZND/cav1TxMzQN5o42s4R2h1CKyhjCBz/u9rqJAPKZdl2f
         EnxQguvtDeFTKTivdZJtxkGPaqCo784geDn5XlpACmRFFVPLMtNfE8Vek/6xuPPSY/Gv
         fGDA==
X-Gm-Message-State: AOAM533Q+raw+ZyxDfKLQs5om0yXeu/QoNP9ksMwznMXcqHovEuzhfX0
        ASC4Lk8tG4X7sQWF5rQ7yTZ85g==
X-Google-Smtp-Source: ABdhPJz9heXgS8rFxJS0nXHKUiSQmu7ZR9KnDg2SgCKZBNu8QkHR6CIg7pqKUo9m1ZUWj95R+WtbyA==
X-Received: by 2002:a5d:4910:: with SMTP id x16mr9051472wrq.204.1599733069852;
        Thu, 10 Sep 2020 03:17:49 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id m4sm8851731wro.18.2020.09.10.03.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 03:17:49 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/8] ASoC: q6dsp: q6routing: add support to Codec DMA ports
Date:   Thu, 10 Sep 2020 11:17:26 +0100
Message-Id: <20200910101732.23484-3-srinivas.kandagatla@linaro.org>
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
 sound/soc/qcom/qdsp6/q6routing.c | 121 ++++++++++++++++++++++++++++++-
 1 file changed, 120 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 25d23e0266c7..b12539fae6ed 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -113,7 +113,19 @@
 	{ mix_name, "QUIN_TDM_TX_4", "QUIN_TDM_TX_4"},		\
 	{ mix_name, "QUIN_TDM_TX_5", "QUIN_TDM_TX_5"},		\
 	{ mix_name, "QUIN_TDM_TX_6", "QUIN_TDM_TX_6"},		\
-	{ mix_name, "QUIN_TDM_TX_7", "QUIN_TDM_TX_7"}
+	{ mix_name, "QUIN_TDM_TX_7", "QUIN_TDM_TX_7"},		\
+	{ mix_name, "WSA_CODEC_DMA_TX_0", "WSA_CODEC_DMA_TX_0"},	\
+	{ mix_name, "WSA_CODEC_DMA_TX_1", "WSA_CODEC_DMA_TX_1"},	\
+	{ mix_name, "WSA_CODEC_DMA_TX_2", "WSA_CODEC_DMA_TX_2"},	\
+	{ mix_name, "VA_CODEC_DMA_TX_0", "VA_CODEC_DMA_TX_0"},	\
+	{ mix_name, "VA_CODEC_DMA_TX_1", "VA_CODEC_DMA_TX_1"},	\
+	{ mix_name, "VA_CODEC_DMA_TX_2", "VA_CODEC_DMA_TX_2"},	\
+	{ mix_name, "TX_CODEC_DMA_TX_0", "TX_CODEC_DMA_TX_0"},	\
+	{ mix_name, "TX_CODEC_DMA_TX_1", "TX_CODEC_DMA_TX_1"},	\
+	{ mix_name, "TX_CODEC_DMA_TX_2", "TX_CODEC_DMA_TX_2"},	\
+	{ mix_name, "TX_CODEC_DMA_TX_3", "TX_CODEC_DMA_TX_3"},	\
+	{ mix_name, "TX_CODEC_DMA_TX_4", "TX_CODEC_DMA_TX_4"},	\
+	{ mix_name, "TX_CODEC_DMA_TX_5", "TX_CODEC_DMA_TX_5"}
 
 #define Q6ROUTING_TX_MIXERS(id)						\
 	SOC_SINGLE_EXT("PRI_MI2S_TX", PRIMARY_MI2S_TX,			\
@@ -267,6 +279,42 @@
 		id, 1, 0, msm_routing_get_audio_mixer,			\
 		msm_routing_put_audio_mixer),				\
 	SOC_SINGLE_EXT("QUIN_TDM_TX_7", QUINARY_TDM_TX_7,		\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("WSA_CODEC_DMA_TX_0", WSA_CODEC_DMA_TX_0,	\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("WSA_CODEC_DMA_TX_1", WSA_CODEC_DMA_TX_1,	\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("WSA_CODEC_DMA_TX_2", WSA_CODEC_DMA_TX_2,	\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("VA_CODEC_DMA_TX_0", VA_CODEC_DMA_TX_0,		\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("VA_CODEC_DMA_TX_1", VA_CODEC_DMA_TX_1,		\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("VA_CODEC_DMA_TX_2", VA_CODEC_DMA_TX_2,		\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("TX_CODEC_DMA_TX_0", TX_CODEC_DMA_TX_0,		\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("TX_CODEC_DMA_TX_1", TX_CODEC_DMA_TX_1,		\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("TX_CODEC_DMA_TX_2", TX_CODEC_DMA_TX_2,		\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("TX_CODEC_DMA_TX_3", TX_CODEC_DMA_TX_3,		\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("TX_CODEC_DMA_TX_4", TX_CODEC_DMA_TX_4,		\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("TX_CODEC_DMA_TX_5", TX_CODEC_DMA_TX_5,		\
 		id, 1, 0, msm_routing_get_audio_mixer,			\
 		msm_routing_put_audio_mixer),
 
@@ -609,6 +657,36 @@ static const struct snd_kcontrol_new quin_tdm_rx_6_mixer_controls[] = {
 static const struct snd_kcontrol_new quin_tdm_rx_7_mixer_controls[] = {
 	Q6ROUTING_RX_MIXERS(QUINARY_TDM_RX_7) };
 
+static const struct snd_kcontrol_new wsa_codec_dma_rx_0_mixer_controls[] = {
+	Q6ROUTING_RX_MIXERS(WSA_CODEC_DMA_RX_0) };
+
+static const struct snd_kcontrol_new wsa_codec_dma_rx_1_mixer_controls[] = {
+	Q6ROUTING_RX_MIXERS(WSA_CODEC_DMA_RX_1) };
+
+static const struct snd_kcontrol_new rx_codec_dma_rx_0_mixer_controls[] = {
+	Q6ROUTING_RX_MIXERS(RX_CODEC_DMA_RX_0) };
+
+static const struct snd_kcontrol_new rx_codec_dma_rx_1_mixer_controls[] = {
+	Q6ROUTING_RX_MIXERS(RX_CODEC_DMA_RX_1) };
+
+static const struct snd_kcontrol_new rx_codec_dma_rx_2_mixer_controls[] = {
+	Q6ROUTING_RX_MIXERS(RX_CODEC_DMA_RX_2) };
+
+static const struct snd_kcontrol_new rx_codec_dma_rx_3_mixer_controls[] = {
+	Q6ROUTING_RX_MIXERS(RX_CODEC_DMA_RX_3) };
+
+static const struct snd_kcontrol_new rx_codec_dma_rx_4_mixer_controls[] = {
+	Q6ROUTING_RX_MIXERS(RX_CODEC_DMA_RX_4) };
+
+static const struct snd_kcontrol_new rx_codec_dma_rx_5_mixer_controls[] = {
+	Q6ROUTING_RX_MIXERS(RX_CODEC_DMA_RX_5) };
+
+static const struct snd_kcontrol_new rxcodec_dma_rx_6_mixer_controls[] = {
+	Q6ROUTING_RX_MIXERS(RX_CODEC_DMA_RX_6) };
+
+static const struct snd_kcontrol_new rx_codec_dma_rx_7_mixer_controls[] = {
+	Q6ROUTING_RX_MIXERS(RX_CODEC_DMA_RX_7) };
+
 
 static const struct snd_kcontrol_new mmul1_mixer_controls[] = {
 	Q6ROUTING_TX_MIXERS(MSM_FRONTEND_DAI_MULTIMEDIA1) };
@@ -819,6 +897,37 @@ static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
 	SND_SOC_DAPM_MIXER("QUIN_TDM_RX_7 Audio Mixer", SND_SOC_NOPM, 0, 0,
 				quin_tdm_rx_7_mixer_controls,
 				ARRAY_SIZE(quin_tdm_rx_7_mixer_controls)),
+
+	SND_SOC_DAPM_MIXER("WSA_CODEC_DMA_RX_0 Audio Mixer", SND_SOC_NOPM, 0, 0,
+		wsa_codec_dma_rx_0_mixer_controls,
+		ARRAY_SIZE(wsa_codec_dma_rx_0_mixer_controls)),
+	SND_SOC_DAPM_MIXER("WSA_CODEC_DMA_RX_1 Audio Mixer", SND_SOC_NOPM, 0, 0,
+		wsa_codec_dma_rx_1_mixer_controls,
+		ARRAY_SIZE(wsa_codec_dma_rx_1_mixer_controls)),
+	SND_SOC_DAPM_MIXER("RX_CODEC_DMA_RX_0 Audio Mixer", SND_SOC_NOPM, 0, 0,
+		rx_codec_dma_rx_0_mixer_controls,
+		ARRAY_SIZE(rx_codec_dma_rx_0_mixer_controls)),
+	SND_SOC_DAPM_MIXER("RX_CODEC_DMA_RX_1 Audio Mixer", SND_SOC_NOPM, 0, 0,
+		rx_codec_dma_rx_1_mixer_controls,
+		ARRAY_SIZE(rx_codec_dma_rx_1_mixer_controls)),
+	SND_SOC_DAPM_MIXER("RX_CODEC_DMA_RX_2 Audio Mixer", SND_SOC_NOPM, 0, 0,
+		rx_codec_dma_rx_2_mixer_controls,
+		ARRAY_SIZE(rx_codec_dma_rx_2_mixer_controls)),
+	SND_SOC_DAPM_MIXER("RX_CODEC_DMA_RX_3 Audio Mixer", SND_SOC_NOPM, 0, 0,
+		rx_codec_dma_rx_3_mixer_controls,
+		ARRAY_SIZE(rx_codec_dma_rx_3_mixer_controls)),
+	SND_SOC_DAPM_MIXER("RX_CODEC_DMA_RX_4 Audio Mixer", SND_SOC_NOPM, 0, 0,
+		rx_codec_dma_rx_4_mixer_controls,
+		ARRAY_SIZE(rx_codec_dma_rx_4_mixer_controls)),
+	SND_SOC_DAPM_MIXER("RX_CODEC_DMA_RX_5 Audio Mixer", SND_SOC_NOPM, 0, 0,
+		rx_codec_dma_rx_5_mixer_controls,
+		ARRAY_SIZE(rx_codec_dma_rx_5_mixer_controls)),
+	SND_SOC_DAPM_MIXER("RX_CODEC_DMA_RX_6 Audio Mixer", SND_SOC_NOPM, 0, 0,
+		rxcodec_dma_rx_6_mixer_controls,
+		ARRAY_SIZE(rxcodec_dma_rx_6_mixer_controls)),
+	SND_SOC_DAPM_MIXER("RX_CODEC_DMA_RX_7 Audio Mixer", SND_SOC_NOPM, 0, 0,
+		rx_codec_dma_rx_7_mixer_controls,
+		ARRAY_SIZE(rx_codec_dma_rx_7_mixer_controls)),
 	SND_SOC_DAPM_MIXER("MultiMedia1 Mixer", SND_SOC_NOPM, 0, 0,
 		mmul1_mixer_controls, ARRAY_SIZE(mmul1_mixer_controls)),
 	SND_SOC_DAPM_MIXER("MultiMedia2 Mixer", SND_SOC_NOPM, 0, 0,
@@ -901,6 +1010,16 @@ static const struct snd_soc_dapm_route intercon[] = {
 	Q6ROUTING_RX_DAPM_ROUTE("QUIN_TDM_RX_5 Audio Mixer", "QUIN_TDM_RX_5"),
 	Q6ROUTING_RX_DAPM_ROUTE("QUIN_TDM_RX_6 Audio Mixer", "QUIN_TDM_RX_6"),
 	Q6ROUTING_RX_DAPM_ROUTE("QUIN_TDM_RX_7 Audio Mixer", "QUIN_TDM_RX_7"),
+	Q6ROUTING_RX_DAPM_ROUTE("WSA_CODEC_DMA_RX_0 Audio Mixer", "WSA_CODEC_DMA_RX_0"),
+	Q6ROUTING_RX_DAPM_ROUTE("WSA_CODEC_DMA_RX_1 Audio Mixer", "WSA_CODEC_DMA_RX_1"),
+	Q6ROUTING_RX_DAPM_ROUTE("RX_CODEC_DMA_RX_0 Audio Mixer", "RX_CODEC_DMA_RX_0"),
+	Q6ROUTING_RX_DAPM_ROUTE("RX_CODEC_DMA_RX_1 Audio Mixer", "RX_CODEC_DMA_RX_1"),
+	Q6ROUTING_RX_DAPM_ROUTE("RX_CODEC_DMA_RX_2 Audio Mixer", "RX_CODEC_DMA_RX_2"),
+	Q6ROUTING_RX_DAPM_ROUTE("RX_CODEC_DMA_RX_3 Audio Mixer", "RX_CODEC_DMA_RX_3"),
+	Q6ROUTING_RX_DAPM_ROUTE("RX_CODEC_DMA_RX_4 Audio Mixer", "RX_CODEC_DMA_RX_4"),
+	Q6ROUTING_RX_DAPM_ROUTE("RX_CODEC_DMA_RX_5 Audio Mixer", "RX_CODEC_DMA_RX_5"),
+	Q6ROUTING_RX_DAPM_ROUTE("RX_CODEC_DMA_RX_6 Audio Mixer", "RX_CODEC_DMA_RX_6"),
+	Q6ROUTING_RX_DAPM_ROUTE("RX_CODEC_DMA_RX_7 Audio Mixer", "RX_CODEC_DMA_RX_7"),
 	Q6ROUTING_TX_DAPM_ROUTE("MultiMedia1 Mixer"),
 	Q6ROUTING_TX_DAPM_ROUTE("MultiMedia2 Mixer"),
 	Q6ROUTING_TX_DAPM_ROUTE("MultiMedia3 Mixer"),
-- 
2.21.0

