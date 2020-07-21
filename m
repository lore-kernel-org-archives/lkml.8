Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AF8C433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADD5520792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nmH+p02U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbgGURDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgGURBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:01:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1AFC0619E0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:00:21 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z2so21945641wrp.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zAD/7xPPoJF64yaCntuggxRA+ZJ8WHNmGopHS69UMKw=;
        b=nmH+p02UiIUVCenN/Sk7WaDAvRMuPBMbiWgg0viEISI8LAsuH4XSELcKuXFlo4E1jG
         3Ba38x4iQ1l2M+mHUXYoEFuvl6hUqCKceiKb6umj+bXwai6455HJcrCifX4F4L5xSvla
         hOQNlYvdTlE2zqU9p/kqPaBWD1XdHWZ5ivnmwrtNADm45lM4oGP0a95FGH4F/jJ3/dkx
         Znz1H27E1mv6SMM699FO6lQE7Syy2Gm+8DY5uhpQMZgHO8JPx1PX2jVOXnezZWbnolce
         sLsgyiEM6QNFvsMv3D+wimiCt+M4b2lpsMeGNaErObzykdrflmIRoYl21sKkKvpvDAVW
         M8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zAD/7xPPoJF64yaCntuggxRA+ZJ8WHNmGopHS69UMKw=;
        b=jUh9pkfehLfMJlk6hnkCFB2b5zER1uGtViaGJt9TEkc/q2p525L7wWJUEc8WW5KhRy
         XGBOOdyJc16ciI4zvXWuvpxrgOKGfsqKWvMrCPYd0me/JWGnjftyOehTrkJioOsGkqaa
         4Jtz7WdRaVGHzXr8N6qmyAO4rKdFY84vHvui9Ogo2BN9XwdqfNk/aWZhTCD4QnqkNRIY
         rYfrUUX6lOWfH0tzbpDKRXPGF50m+nBxi/RRLYDnPNKLxbcTrPa057+ib5BlUAU5vJ6l
         OeOGH0WaxQPO/DDGODObN00zo4Jkg5svUpUelhgLic9gTKx5EqZr0tidVzVyin9B/uc8
         2OrA==
X-Gm-Message-State: AOAM530KlqL4EnA4w3+QhXrokpnGVCpfwkaiSuNU232duHtX4NYYZByJ
        FFDP84UATfzfRxeTJFvFy5keRjqAai0=
X-Google-Smtp-Source: ABdhPJycW1Xaq3CU8qG7QJBKBhsJckOLmd/4VRs8/GBxAiRAaiByjeY3LRfYRQRK2YrDLo6uukpb1Q==
X-Received: by 2002:adf:ec90:: with SMTP id z16mr27509083wrn.52.1595350820384;
        Tue, 21 Jul 2020 10:00:20 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id h11sm15526327wrb.68.2020.07.21.10.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 10:00:19 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH v2 6/6] ASoC: q6asm-dai: add support to set_codec_params
Date:   Tue, 21 Jul 2020 18:00:07 +0100
Message-Id: <20200721170007.4554-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of new set_codec_params callback to allow decoder switching
during gapless playback.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index b5c719682919..a8cfb1996614 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -876,6 +876,37 @@ static int __q6asm_dai_compr_set_codec_params(struct snd_soc_component *componen
 	return 0;
 }
 
+static int q6asm_dai_compr_set_codec_params(struct snd_soc_component *component,
+					    struct snd_compr_stream *stream,
+					    struct snd_codec *codec)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	int ret;
+
+	ret = q6asm_open_write(prtd->audio_client, prtd->next_track_stream_id,
+			       codec->id, codec->profile, prtd->bits_per_sample,
+			       true);
+	if (ret < 0) {
+		pr_err("q6asm_open_write failed\n");
+		return ret;
+	}
+
+	ret = __q6asm_dai_compr_set_codec_params(component, stream, codec,
+						 prtd->next_track_stream_id);
+	if (ret < 0) {
+		pr_err("q6asm_open_write failed\n");
+		return ret;
+	}
+
+	ret = q6asm_stream_remove_initial_silence(prtd->audio_client,
+						   prtd->next_track_stream_id,
+						   prtd->initial_samples_drop);
+	prtd->next_track_stream_id = 0;
+
+	return ret;
+}
+
 static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 				      struct snd_compr_stream *stream,
 				      struct snd_compr_params *params)
@@ -1144,6 +1175,7 @@ static int q6asm_dai_compr_get_caps(struct snd_soc_component *component,
 	caps->max_fragment_size = COMPR_PLAYBACK_MAX_FRAGMENT_SIZE;
 	caps->min_fragments = COMPR_PLAYBACK_MIN_NUM_FRAGMENTS;
 	caps->max_fragments = COMPR_PLAYBACK_MAX_NUM_FRAGMENTS;
+	caps->flags = SND_COMPR_CAP_FLAGS_DSP_CAN_SWITCH_DECODER;
 	caps->num_codecs = 5;
 	caps->codecs[0] = SND_AUDIOCODEC_MP3;
 	caps->codecs[1] = SND_AUDIOCODEC_FLAC;
@@ -1173,6 +1205,7 @@ static struct snd_compress_ops q6asm_dai_compress_ops = {
 	.open		= q6asm_dai_compr_open,
 	.free		= q6asm_dai_compr_free,
 	.set_params	= q6asm_dai_compr_set_params,
+	.set_codec_params = q6asm_dai_compr_set_codec_params,
 	.set_metadata	= q6asm_dai_compr_set_metadata,
 	.pointer	= q6asm_dai_compr_pointer,
 	.trigger	= q6asm_dai_compr_trigger,
-- 
2.21.0

