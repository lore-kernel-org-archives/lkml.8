Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B6AC433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381DF2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IgYqDGNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgG0Jih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgG0JiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:38:25 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76465C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:38:25 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so14153960wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PaYEBHP1hA6Z0ty3CQH+DbAz1Fhh0daXJSUmhh2mbvQ=;
        b=IgYqDGNlWZlVtL4DvjwvDyWn3GBJBeuwqEmt703cfv1shUXl27ma+zt571HhruqxUj
         BxZdyUWY/ANHk5RxffcRH8EQjXdy8QOevLkHZuncm5kB5hYQVE/OHiY69HmQizzQop3m
         POsj+Gd5NMmebPTAIb+HwrYKkvnfkam/g6IJcYE/LAcV3GvPeZAJiLONqaE37ALKGTsD
         mh8epq7GDMJhg2wVhDdWku/UYFz3Id5onxSWBWFdj10qlglQmxj/vExBMxbeTu0L0Nbx
         TtVtgYlv6xluYSXLqqUpI6ivOPanW/iCO8d4YoPgJndgHsLzlYOYce+vpKCG19k89Qc6
         wTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PaYEBHP1hA6Z0ty3CQH+DbAz1Fhh0daXJSUmhh2mbvQ=;
        b=fcUaU+EycBm86DvPNOxFAu/n6mlsokCozH42wsR4qw7NZiyP/pReM9KmClpBFZmSiK
         PBFNRzQ8e9DZR8iRmbE2oVxF96d3n1Nhj2Kd0UrWsorTtBkt56FZRv7XYjEUIkxewYDr
         ceh64QPO9wLRFx8cUh67Z8JgMEkol/RxgnbZWyqfVk4m71kXeKbi+Z18ySKdL555RIbE
         CWIPScIwktjIOGZcnFGBBtd1fTv+mD0CSVV5u+h2xO3695PtK9lHaT24NO3sgK9+Ow+C
         hszfCjBEH4iDbuQ4dS1tATs/pKmnsBEiFZyzRPcnZS2ihvnpQM5NhQ5NBVcvYjm6801c
         p17w==
X-Gm-Message-State: AOAM5316fPgOSDGzddVZibTCDSou++g3B4UynDFbvwCgCi48FYtdMDc5
        7IZWTYZOw4zcxmxbKyEg3bBgMQ==
X-Google-Smtp-Source: ABdhPJxzomdcvXn6uVYVrGr10wI1q2tY6BaUV5/UymLlF1nGwt7zdE0RZvHcbMt5a3lSdkbPn5kXEQ==
X-Received: by 2002:a5d:4a90:: with SMTP id o16mr18732461wrq.87.1595842704041;
        Mon, 27 Jul 2020 02:38:24 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id y189sm20566099wmd.27.2020.07.27.02.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 02:38:23 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        pierre-louis.bossart@linux.intel.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 08/10] ASoC: q6asm-dai: prepare set params to accept profile change
Date:   Mon, 27 Jul 2020 10:38:04 +0100
Message-Id: <20200727093806.17089-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
References: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rearrange code so that it will be easy to change the codec
profile at runtime. This means moving exiting set_params
to an internal wrapper which can be called when codec
profile changes.

This is also preparing the code for easy to use in gapless cases.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 149 ++++++++++++++++++-------------
 1 file changed, 85 insertions(+), 64 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index a7fe4147c0a2..420aaaa67788 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -53,7 +53,7 @@ enum stream_state {
 struct q6asm_dai_rtd {
 	struct snd_pcm_substream *substream;
 	struct snd_compr_stream *cstream;
-	struct snd_compr_params codec_param;
+	struct snd_codec codec;
 	struct snd_dma_buffer dma_buffer;
 	spinlock_t lock;
 	phys_addr_t phys;
@@ -644,15 +644,13 @@ static int q6asm_dai_compr_free(struct snd_soc_component *component,
 	return 0;
 }
 
-static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
-				      struct snd_compr_stream *stream,
-				      struct snd_compr_params *params)
+static int __q6asm_dai_compr_set_codec_params(struct snd_soc_component *component,
+					      struct snd_compr_stream *stream,
+					      struct snd_codec *codec,
+					      int stream_id)
 {
 	struct snd_compr_runtime *runtime = stream->runtime;
 	struct q6asm_dai_rtd *prtd = runtime->private_data;
-	struct snd_soc_pcm_runtime *rtd = stream->private_data;
-	int dir = stream->direction;
-	struct q6asm_dai_data *pdata;
 	struct q6asm_flac_cfg flac_cfg;
 	struct q6asm_wma_cfg wma_cfg;
 	struct q6asm_alac_cfg alac_cfg;
@@ -666,53 +664,18 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 	struct snd_dec_alac *alac;
 	struct snd_dec_ape *ape;
 
-	codec_options = &(prtd->codec_param.codec.options);
-
-
-	memcpy(&prtd->codec_param, params, sizeof(*params));
-
-	pdata = snd_soc_component_get_drvdata(component);
-	if (!pdata)
-		return -EINVAL;
-
-	if (!prtd || !prtd->audio_client) {
-		dev_err(dev, "private data null or audio client freed\n");
-		return -EINVAL;
-	}
-
-	prtd->periods = runtime->fragments;
-	prtd->pcm_count = runtime->fragment_size;
-	prtd->pcm_size = runtime->fragments * runtime->fragment_size;
-	prtd->bits_per_sample = 16;
-	if (dir == SND_COMPRESS_PLAYBACK) {
-		ret = q6asm_open_write(prtd->audio_client, prtd->stream_id,
-				       params->codec.id, params->codec.profile,
-				       prtd->bits_per_sample, true);
-
-		if (ret < 0) {
-			dev_err(dev, "q6asm_open_write failed\n");
-			q6asm_audio_client_free(prtd->audio_client);
-			prtd->audio_client = NULL;
-			return ret;
-		}
-	}
+	codec_options = &(prtd->codec.options);
 
-	prtd->session_id = q6asm_get_session_id(prtd->audio_client);
-	ret = q6routing_stream_open(rtd->dai_link->id, LEGACY_PCM_MODE,
-			      prtd->session_id, dir);
-	if (ret) {
-		dev_err(dev, "Stream reg failed ret:%d\n", ret);
-		return ret;
-	}
+	memcpy(&prtd->codec, codec, sizeof(*codec));
 
-	switch (params->codec.id) {
+	switch (codec->id) {
 	case SND_AUDIOCODEC_FLAC:
 
 		memset(&flac_cfg, 0x0, sizeof(struct q6asm_flac_cfg));
 		flac = &codec_options->flac_d;
 
-		flac_cfg.ch_cfg = params->codec.ch_in;
-		flac_cfg.sample_rate =  params->codec.sample_rate;
+		flac_cfg.ch_cfg = codec->ch_in;
+		flac_cfg.sample_rate = codec->sample_rate;
 		flac_cfg.stream_info_present = 1;
 		flac_cfg.sample_size = flac->sample_size;
 		flac_cfg.min_blk_size = flac->min_blk_size;
@@ -721,7 +684,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 		flac_cfg.min_frame_size = flac->min_frame_size;
 
 		ret = q6asm_stream_media_format_block_flac(prtd->audio_client,
-							   prtd->stream_id,
+							   stream_id,
 							   &flac_cfg);
 		if (ret < 0) {
 			dev_err(dev, "FLAC CMD Format block failed:%d\n", ret);
@@ -734,10 +697,10 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 
 		memset(&wma_cfg, 0x0, sizeof(struct q6asm_wma_cfg));
 
-		wma_cfg.sample_rate =  params->codec.sample_rate;
-		wma_cfg.num_channels = params->codec.ch_in;
-		wma_cfg.bytes_per_sec = params->codec.bit_rate / 8;
-		wma_cfg.block_align = params->codec.align;
+		wma_cfg.sample_rate =  codec->sample_rate;
+		wma_cfg.num_channels = codec->ch_in;
+		wma_cfg.bytes_per_sec = codec->bit_rate / 8;
+		wma_cfg.block_align = codec->align;
 		wma_cfg.bits_per_sample = prtd->bits_per_sample;
 		wma_cfg.enc_options = wma->encoder_option;
 		wma_cfg.adv_enc_options = wma->adv_encoder_option;
@@ -751,7 +714,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 			return -EINVAL;
 
 		/* check the codec profile */
-		switch (params->codec.profile) {
+		switch (codec->profile) {
 		case SND_AUDIOPROFILE_WMA9:
 			wma_cfg.fmtag = 0x161;
 			wma_v9 = 1;
@@ -775,17 +738,17 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 
 		default:
 			dev_err(dev, "Unknown WMA profile:%x\n",
-				params->codec.profile);
+				codec->profile);
 			return -EIO;
 		}
 
 		if (wma_v9)
 			ret = q6asm_stream_media_format_block_wma_v9(
-					prtd->audio_client, prtd->stream_id,
+					prtd->audio_client, stream_id,
 					&wma_cfg);
 		else
 			ret = q6asm_stream_media_format_block_wma_v10(
-					prtd->audio_client, prtd->stream_id,
+					prtd->audio_client, stream_id,
 					&wma_cfg);
 		if (ret < 0) {
 			dev_err(dev, "WMA9 CMD failed:%d\n", ret);
@@ -797,10 +760,10 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 		memset(&alac_cfg, 0x0, sizeof(alac_cfg));
 		alac = &codec_options->alac_d;
 
-		alac_cfg.sample_rate = params->codec.sample_rate;
-		alac_cfg.avg_bit_rate = params->codec.bit_rate;
+		alac_cfg.sample_rate = codec->sample_rate;
+		alac_cfg.avg_bit_rate = codec->bit_rate;
 		alac_cfg.bit_depth = prtd->bits_per_sample;
-		alac_cfg.num_channels = params->codec.ch_in;
+		alac_cfg.num_channels = codec->ch_in;
 
 		alac_cfg.frame_length = alac->frame_length;
 		alac_cfg.pb = alac->pb;
@@ -810,7 +773,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 		alac_cfg.compatible_version = alac->compatible_version;
 		alac_cfg.max_frame_bytes = alac->max_frame_bytes;
 
-		switch (params->codec.ch_in) {
+		switch (codec->ch_in) {
 		case 1:
 			alac_cfg.channel_layout_tag = ALAC_CH_LAYOUT_MONO;
 			break;
@@ -819,7 +782,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 			break;
 		}
 		ret = q6asm_stream_media_format_block_alac(prtd->audio_client,
-							   prtd->stream_id,
+							   stream_id,
 							   &alac_cfg);
 		if (ret < 0) {
 			dev_err(dev, "ALAC CMD Format block failed:%d\n", ret);
@@ -831,8 +794,8 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 		memset(&ape_cfg, 0x0, sizeof(ape_cfg));
 		ape = &codec_options->ape_d;
 
-		ape_cfg.sample_rate = params->codec.sample_rate;
-		ape_cfg.num_channels = params->codec.ch_in;
+		ape_cfg.sample_rate = codec->sample_rate;
+		ape_cfg.num_channels = codec->ch_in;
 		ape_cfg.bits_per_sample = prtd->bits_per_sample;
 
 		ape_cfg.compatible_version = ape->compatible_version;
@@ -844,7 +807,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 		ape_cfg.seek_table_present = ape->seek_table_present;
 
 		ret = q6asm_stream_media_format_block_ape(prtd->audio_client,
-							  prtd->stream_id,
+							  stream_id,
 							  &ape_cfg);
 		if (ret < 0) {
 			dev_err(dev, "APE CMD Format block failed:%d\n", ret);
@@ -856,6 +819,64 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 		break;
 	}
 
+	return 0;
+}
+
+static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
+				      struct snd_compr_stream *stream,
+				      struct snd_compr_params *params)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = stream->private_data;
+	int dir = stream->direction;
+	struct q6asm_dai_data *pdata;
+	struct device *dev = component->dev;
+	int ret;
+
+	pdata = snd_soc_component_get_drvdata(component);
+	if (!pdata)
+		return -EINVAL;
+
+	if (!prtd || !prtd->audio_client) {
+		dev_err(dev, "private data null or audio client freed\n");
+		return -EINVAL;
+	}
+
+	prtd->periods = runtime->fragments;
+	prtd->pcm_count = runtime->fragment_size;
+	prtd->pcm_size = runtime->fragments * runtime->fragment_size;
+	prtd->bits_per_sample = 16;
+
+	if (dir == SND_COMPRESS_PLAYBACK) {
+		ret = q6asm_open_write(prtd->audio_client, prtd->stream_id, params->codec.id,
+				params->codec.profile, prtd->bits_per_sample,
+				true);
+
+		if (ret < 0) {
+			dev_err(dev, "q6asm_open_write failed\n");
+			q6asm_audio_client_free(prtd->audio_client);
+			prtd->audio_client = NULL;
+			return ret;
+		}
+	}
+
+	prtd->session_id = q6asm_get_session_id(prtd->audio_client);
+	ret = q6routing_stream_open(rtd->dai_link->id, LEGACY_PCM_MODE,
+			      prtd->session_id, dir);
+	if (ret) {
+		dev_err(dev, "Stream reg failed ret:%d\n", ret);
+		return ret;
+	}
+
+	ret = __q6asm_dai_compr_set_codec_params(component, stream,
+						 &params->codec,
+						 prtd->stream_id);
+	if (ret) {
+		dev_err(dev, "codec param setup failed ret:%d\n", ret);
+		return ret;
+	}
+
 	ret = q6asm_map_memory_regions(dir, prtd->audio_client, prtd->phys,
 				       (prtd->pcm_size / prtd->periods),
 				       prtd->periods);
-- 
2.21.0

