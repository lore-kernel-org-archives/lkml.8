Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5F4C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36FE421702
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fIFUagIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbgGURC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729706AbgGUQxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:53:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B02C0619DF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:53:34 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 9so110575wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o5QASc0ZtBRqm3j+AnuPnR8xk5O5k6BwP49LHKnzt08=;
        b=fIFUagIuibKbaW9rMFfbuKX5qZaOc865HrRcvvZYjBGFKo0vr8+fIOo+ZRH/hBpQpb
         /KeKX9zA15jzMLY1MRp/Altc7foBBtQtlyJnzCPEGIcK3LK6ycP3xWQ3eL3Msu9SgdXp
         twqw3JI3PKwTgrSSRE2468DbDTOFnpX5Zzu2o2Tvokyx90C+t2cEDuIB0DSFHdHGzsPK
         Kf8SMTAL1/Z/v+xjGyl4PwjDHxXqnQBlHIDp4xw7r4C2Nm0FYFtcIKMxQ1T46V3ss+dZ
         ZmZPuRo6eyfODMqPGaPJnbT+L/mUab2gRB58fUskNi22dA9kuvSN1zqD0OGlQRfRu5CM
         PL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o5QASc0ZtBRqm3j+AnuPnR8xk5O5k6BwP49LHKnzt08=;
        b=SMyynalt5RKmzj5PC0uaAohHJeWGAf3xWcajMfSWNVRMc5yKXxopSmO4pvecb5AUGQ
         QxtcKElSaiWcF/JRfNr6FriW8hLps7HUHQUWy10R221j+UeeM5hC8zzv30tVvY2+mYQj
         N43IiTQLnZb2v7SvXxegjJ/SNgUkc4txt+2EnSEWzsGnd/aScxjdduDDipC1XgrssTTt
         Ij1rPdkFV09OHG6Ht8qn4acNDNhhN/brQVsezCI8vTlac2e6wWq2i1K6QFXpFSCnMIzG
         68ZINYzv9XEVx761qzUOoq7/hWEWQgsg4DXRmhqDqwo7kntMcS4rqkW+2BmLj+wN7FLX
         uLFw==
X-Gm-Message-State: AOAM533O4PZTfdt2vRI4swiXrOjeST+KuSi6nzZYni0yqODnKHGeN3Tx
        0YWfDP/mSTGGm+zvsnRfh7yeUQ==
X-Google-Smtp-Source: ABdhPJzAp1R7Y0HYndC/p76wBrMlHzHRnYNsT58qXnbMmSwr2sdx+DkYBmczR0c8WQzGG0V4GFZSkA==
X-Received: by 2002:a1c:b6c3:: with SMTP id g186mr5077837wmf.135.1595350412946;
        Tue, 21 Jul 2020 09:53:32 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c25sm4058648wml.18.2020.07.21.09.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:53:32 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 8/9] ASoC: qdsp6-dai: add gapless support
Date:   Tue, 21 Jul 2020 17:53:05 +0100
Message-Id: <20200721165306.29082-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
References: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to gapless playback by implementing metadata,
next_track, drain and partial drain support.

Gapless on Q6ASM is implemented by opening 2 streams in a single
q6asm stream and toggling them on next track.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 253 ++++++++++++++++++++++---------
 sound/soc/qcom/qdsp6/q6asm.h     |   1 +
 2 files changed, 182 insertions(+), 72 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index c4b4684b7824..50055c113f10 100644
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
@@ -67,12 +67,15 @@ struct q6asm_dai_rtd {
 	uint16_t bits_per_sample;
 	uint16_t source; /* Encoding source bit mask */
 	struct audio_client *audio_client;
+	uint32_t next_track_stream_id;
+	bool next_track;
 	/* Active */
 	uint32_t stream_id;
 	uint16_t session_id;
 	enum stream_state state;
 	uint32_t initial_samples_drop;
 	uint32_t trailing_samples_drop;
+	bool notify_on_drain;
 };
 
 struct q6asm_dai_data {
@@ -510,14 +513,20 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
 {
 	struct q6asm_dai_rtd *prtd = priv;
 	struct snd_compr_stream *substream = prtd->cstream;
-	unsigned long flags;
+	unsigned long flags = 0;
+	u32 wflags = 0;
 	uint64_t avail;
-	uint32_t bytes_written;
+	uint32_t bytes_written, bytes_to_write;
+	bool is_last_buffer = false;
 
 	switch (opcode) {
 	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
 		spin_lock_irqsave(&prtd->lock, flags);
 		if (!prtd->bytes_sent) {
+			q6asm_stream_remove_initial_silence(prtd->audio_client,
+						    prtd->stream_id,
+						    prtd->initial_samples_drop);
+
 			q6asm_write_async(prtd->audio_client, prtd->stream_id,
 					  prtd->pcm_count, 0, 0, 0);
 			prtd->bytes_sent += prtd->pcm_count;
@@ -527,7 +536,26 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
 		break;
 
 	case ASM_CLIENT_EVENT_CMD_EOS_DONE:
-		prtd->state = Q6ASM_STREAM_STOPPED;
+		spin_lock_irqsave(&prtd->lock, flags);
+		if (prtd->notify_on_drain) {
+			if (substream->partial_drain) {
+				/**
+				 * Close old stream and make it stale, switch
+				 * the active stream now!
+				 */
+				q6asm_cmd_nowait(prtd->audio_client,
+						 prtd->stream_id,
+						 CMD_CLOSE);
+				prtd->stream_id = (prtd->stream_id == 1 ? 2 : 1);
+			}
+
+			snd_compr_drain_notify(prtd->cstream);
+			prtd->notify_on_drain = false;
+
+		} else {
+			prtd->state = Q6ASM_STREAM_STOPPED;
+		}
+		spin_unlock_irqrestore(&prtd->lock, flags);
 		break;
 
 	case ASM_CLIENT_EVENT_DATA_WRITE_DONE:
@@ -543,13 +571,32 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
 		}
 
 		avail = prtd->bytes_received - prtd->bytes_sent;
+		if (avail > prtd->pcm_count) {
+			bytes_to_write = prtd->pcm_count;
+		} else {
+			if (substream->partial_drain || prtd->notify_on_drain)
+				is_last_buffer = true;
+			bytes_to_write = avail;
+		}
+
+		if (bytes_to_write) {
+			if (substream->partial_drain && is_last_buffer) {
+				wflags |= ASM_LAST_BUFFER_FLAG;
+				q6asm_stream_remove_trailing_silence(prtd->audio_client,
+						     prtd->stream_id,
+						     prtd->trailing_samples_drop);
+			}
 
-		if (avail >= prtd->pcm_count) {
 			q6asm_write_async(prtd->audio_client, prtd->stream_id,
-					   prtd->pcm_count, 0, 0, 0);
-			prtd->bytes_sent += prtd->pcm_count;
+					  bytes_to_write, 0, 0, wflags);
+
+			prtd->bytes_sent += bytes_to_write;
 		}
 
+		if (prtd->notify_on_drain && is_last_buffer)
+			q6asm_cmd_nowait(prtd->audio_client,
+					 prtd->stream_id, CMD_EOS);
+
 		spin_unlock_irqrestore(&prtd->lock, flags);
 		break;
 
@@ -629,9 +676,15 @@ static int q6asm_dai_compr_free(struct snd_soc_component *component,
 	struct snd_soc_pcm_runtime *rtd = stream->private_data;
 
 	if (prtd->audio_client) {
-		if (prtd->state)
+		if (prtd->state) {
 			q6asm_cmd(prtd->audio_client, prtd->stream_id,
 				  CMD_CLOSE);
+			if (prtd->next_track_stream_id) {
+				q6asm_cmd(prtd->audio_client,
+					  prtd->next_track_stream_id,
+					  CMD_CLOSE);
+			}
+		}
 
 		snd_dma_free_pages(&prtd->dma_buffer);
 		q6asm_unmap_memory_regions(stream->direction,
@@ -645,15 +698,13 @@ static int q6asm_dai_compr_free(struct snd_soc_component *component,
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
@@ -667,53 +718,18 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
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
@@ -722,7 +738,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 		flac_cfg.min_frame_size = flac->min_frame_size;
 
 		ret = q6asm_stream_media_format_block_flac(prtd->audio_client,
-							   prtd->stream_id,
+							   stream_id,
 							   &flac_cfg);
 		if (ret < 0) {
 			dev_err(dev, "FLAC CMD Format block failed:%d\n", ret);
@@ -735,10 +751,10 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 
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
@@ -752,7 +768,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 			return -EINVAL;
 
 		/* check the codec profile */
-		switch (params->codec.profile) {
+		switch (codec->profile) {
 		case SND_AUDIOPROFILE_WMA9:
 			wma_cfg.fmtag = 0x161;
 			wma_v9 = 1;
@@ -776,17 +792,17 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 
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
@@ -798,10 +814,10 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
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
@@ -811,7 +827,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 		alac_cfg.compatible_version = alac->compatible_version;
 		alac_cfg.max_frame_bytes = alac->max_frame_bytes;
 
-		switch (params->codec.ch_in) {
+		switch (codec->ch_in) {
 		case 1:
 			alac_cfg.channel_layout_tag = ALAC_CH_LAYOUT_MONO;
 			break;
@@ -820,7 +836,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 			break;
 		}
 		ret = q6asm_stream_media_format_block_alac(prtd->audio_client,
-							   prtd->stream_id,
+							   stream_id,
 							   &alac_cfg);
 		if (ret < 0) {
 			dev_err(dev, "ALAC CMD Format block failed:%d\n", ret);
@@ -832,8 +848,8 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 		memset(&ape_cfg, 0x0, sizeof(ape_cfg));
 		ape = &codec_options->ape_d;
 
-		ape_cfg.sample_rate = params->codec.sample_rate;
-		ape_cfg.num_channels = params->codec.ch_in;
+		ape_cfg.sample_rate = codec->sample_rate;
+		ape_cfg.num_channels = codec->ch_in;
 		ape_cfg.bits_per_sample = prtd->bits_per_sample;
 
 		ape_cfg.compatible_version = ape->compatible_version;
@@ -845,7 +861,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 		ape_cfg.seek_table_present = ape->seek_table_present;
 
 		ret = q6asm_stream_media_format_block_ape(prtd->audio_client,
-							  prtd->stream_id,
+							  stream_id,
 							  &ape_cfg);
 		if (ret < 0) {
 			dev_err(dev, "APE CMD Format block failed:%d\n", ret);
@@ -857,6 +873,64 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
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
@@ -871,7 +945,8 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 	return 0;
 }
 
-static int q6asm_dai_compr_set_metadata(struct snd_compr_stream *stream,
+static int q6asm_dai_compr_set_metadata(struct snd_soc_component *component,
+					struct snd_compr_stream *stream,
 					struct snd_compr_metadata *metadata)
 {
 	struct snd_compr_runtime *runtime = stream->runtime;
@@ -884,6 +959,32 @@ static int q6asm_dai_compr_set_metadata(struct snd_compr_stream *stream,
 		break;
 	case SNDRV_COMPRESS_ENCODER_DELAY:
 		prtd->initial_samples_drop = metadata->value[0];
+		if (prtd->next_track_stream_id) {
+			ret = q6asm_open_write(prtd->audio_client,
+					       prtd->next_track_stream_id,
+					       prtd->codec.id,
+					       prtd->codec.profile,
+					       prtd->bits_per_sample,
+				       true);
+			if (ret < 0) {
+				dev_err(component->dev, "q6asm_open_write failed\n");
+				return ret;
+			}
+			ret = __q6asm_dai_compr_set_codec_params(component, stream,
+								 &prtd->codec,
+								 prtd->next_track_stream_id);
+			if (ret < 0) {
+				dev_err(component->dev, "q6asm_open_write failed\n");
+				return ret;
+			}
+
+			ret = q6asm_stream_remove_initial_silence(prtd->audio_client,
+						    prtd->next_track_stream_id,
+						    prtd->initial_samples_drop);
+			prtd->next_track_stream_id = 0;
+
+		}
+
 		break;
 	default:
 		ret = -EINVAL;
@@ -917,6 +1018,14 @@ static int q6asm_dai_compr_trigger(struct snd_soc_component *component,
 		ret = q6asm_cmd_nowait(prtd->audio_client, prtd->stream_id,
 				       CMD_PAUSE);
 		break;
+	case SND_COMPR_TRIGGER_NEXT_TRACK:
+		prtd->next_track = true;
+		prtd->next_track_stream_id = (prtd->stream_id == 1 ? 2 : 1);
+		break;
+	case SND_COMPR_TRIGGER_DRAIN:
+	case SND_COMPR_TRIGGER_PARTIAL_DRAIN:
+		prtd->notify_on_drain = true;
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
index 69513ac1fa55..a8dddfeb28da 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -34,6 +34,7 @@ enum {
 #define MAX_SESSIONS	8
 #define NO_TIMESTAMP    0xFF00
 #define FORMAT_LINEAR_PCM   0x0000
+#define ASM_LAST_BUFFER_FLAG           BIT(30)
 
 struct q6asm_flac_cfg {
         u32 sample_rate;
-- 
2.21.0

