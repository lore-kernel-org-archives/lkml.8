Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE13BC433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6D9D2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DNKtH2g1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgG0Jih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgG0JiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:38:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B392C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:38:24 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so14116455wrj.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=meC3a0XMpAMCvTskSaE7QuXxyexgyd30xROgIhSgThI=;
        b=DNKtH2g18mJYE1u0xN+/OtwLdcKmahBm9SuH8kQ8ltOh+kDu/iF/2zyUVtLawUgRLJ
         XIsz1RhiIkcRi6I6M9biuxcsUhDESmb+oA+kmIks6o0yxhYiOSo21NWqa+s2cTmNOZcV
         9BU7Kx0RkS6vnesCtTts2vNVK185edqeJ8dk8T0AAV5H3a0omh8meJF6cyxMA9R9xT0n
         1aSoKFB99ufrnNBnr++A0N5xNspTp3BDEmcJtxeGVZoFsC1L+9JDob5CStsbU31bA0YH
         FSedbIBTZHDu6UTzSFvL4fa//SQu7NdnnrMZzoM/jitPlQkog0w2V4+Z3hBwOOneLPrH
         /idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=meC3a0XMpAMCvTskSaE7QuXxyexgyd30xROgIhSgThI=;
        b=lErmTORlNPdZFpDhoerOgAzAVCD+TaA7a4WqtefL1ja8Dq0WfRl8OLlGPf+pCyajz4
         MSHT+prYsD5Jm9b4LgGCBb84TdNkcPJ8wHiE3rJZumdanhva8ZsO/LSEkdEdlCHgx3cg
         twjJw/TVVU08QUJ52aEAEh9dqcA4blYhe/lDRfoBOMdBSnFAkIT1whFKcwT+5WzWM6P2
         5VJxHo1KDBI3EmhU1he9jl3oo6B3VJ2uPEYQaDB/wxHvpQUf3oSM5Bs9/Pzne7uBHdvK
         xaNY72C5r17QGk0FVNAVOLfbAPAKL3f+oP2Fc/YvnU+MT/2x0cct4ZP3TUR0x3S6KSyu
         qhEw==
X-Gm-Message-State: AOAM531u9ark+FHmWLL7457Jk7u1AVxh8i6AMWXDEqAEnST04shO5OSc
        Z/AWyRWKonDI9ZsRspxkrRHTrA==
X-Google-Smtp-Source: ABdhPJyq0mHzjPsa4xocEL27Qs9vKdQBHRKmGqlsIlTmA8ty/1rjygg6XNsxdiUBeAoaLQ9EYmuklQ==
X-Received: by 2002:adf:fdce:: with SMTP id i14mr14301158wrs.273.1595842702847;
        Mon, 27 Jul 2020 02:38:22 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id y189sm20566099wmd.27.2020.07.27.02.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 02:38:22 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        pierre-louis.bossart@linux.intel.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 07/10] ASoC: q6asm-dai: add next track metadata support
Date:   Mon, 27 Jul 2020 10:38:03 +0100
Message-Id: <20200727093806.17089-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
References: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to metadata required to do a gapless playback.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 4652c78d57c5..a7fe4147c0a2 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -70,6 +70,8 @@ struct q6asm_dai_rtd {
 	uint32_t stream_id;
 	uint16_t session_id;
 	enum stream_state state;
+	uint32_t initial_samples_drop;
+	uint32_t trailing_samples_drop;
 };
 
 struct q6asm_dai_data {
@@ -868,6 +870,29 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 	return 0;
 }
 
+static int q6asm_dai_compr_set_metadata(struct snd_soc_component *component,
+					struct snd_compr_stream *stream,
+					struct snd_compr_metadata *metadata)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	int ret = 0;
+
+	switch (metadata->key) {
+	case SNDRV_COMPRESS_ENCODER_PADDING:
+		prtd->trailing_samples_drop = metadata->value[0];
+		break;
+	case SNDRV_COMPRESS_ENCODER_DELAY:
+		prtd->initial_samples_drop = metadata->value[0];
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
 static int q6asm_dai_compr_trigger(struct snd_soc_component *component,
 				   struct snd_compr_stream *stream, int cmd)
 {
@@ -984,6 +1009,7 @@ static struct snd_compress_ops q6asm_dai_compress_ops = {
 	.open		= q6asm_dai_compr_open,
 	.free		= q6asm_dai_compr_free,
 	.set_params	= q6asm_dai_compr_set_params,
+	.set_metadata	= q6asm_dai_compr_set_metadata,
 	.pointer	= q6asm_dai_compr_pointer,
 	.trigger	= q6asm_dai_compr_trigger,
 	.get_caps	= q6asm_dai_compr_get_caps,
-- 
2.21.0

