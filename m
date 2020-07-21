Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAED6C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5B6207BB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LcdyzJ1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgGURCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbgGUQxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:53:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B7CC0619DE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:53:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id f139so3564848wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VmuP26pFXhq32+z5mcBmskWxvyaip5dpiXSHlITuiYI=;
        b=LcdyzJ1L9NT7IlmRky2XGOi2dgCFGrHMpH9KW3K0KDnm9PRj9VQy05ZL/O1QsS621d
         qBffdUU1ScWZ4v1PuOw+0KJfXsvDnbuqmzB4ueaSGEEOJQfY7hdgB4eF8/1s7j56IBTZ
         mKUq3unYHA0D4FBQ4B0fp+K8W2rpfcaU6f7Ac3bD3WBW/FuxDaESlvDdZA95MmxQWF0v
         RVKVjvl1EOtfxBBo5fAsnWy8EueV2i+KigQBiuPn4U0qXRHVzbAHDGzIhCOZu2p+OaQl
         RQ7DzP6g7rTmMFGbEg2eRRuYLy2rWXHHoaFS5vyP1RHvY1ZWmpxpqQ9fb2/PM+UpQjs9
         yXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VmuP26pFXhq32+z5mcBmskWxvyaip5dpiXSHlITuiYI=;
        b=e95FkvszOmkTE0TzOJCQjogrKMZEEfpb2i9MZgwh4ihDyzril4Y3rqTMCdF5fEF5Ha
         JYxHI4tSBjxK1EErEA++FEP1l+zbB680ivEKNExFAvMYz1iCOrc4ADwEeRk8OiJVzDE9
         qrWHrX7+JBqoblIJOEb++Up+pwZbm/0nl6GxwEJPBeChTy7CAd7rLeA8duYmD6YrovO0
         Z+In0F2e4T92nsXlsnsPIl3Sy7Ypf4UE6bP1eT0/OFcKM6nAVzct3mhntSFHw9kVLCfI
         5yDTnQCgUdEm+sC7Ju736lQCgKGhJ23XqVE+upulY/2GoOvmrLgB6RDy6kjOz6JXEp8F
         6kXw==
X-Gm-Message-State: AOAM532WqUljrtKapEWgfKM9U+81H7qwpL/sTxR3CM2b1L072pzoMoa+
        JV4pqVhfvJI7JjgGSjMKjBRH1w==
X-Google-Smtp-Source: ABdhPJy1BZSc/XQ0qyoKoKoKDVWcSK8KAWiqlSbx6Vi2eEAQs2S9ZN6lynnWU9MMZ6w8cilLW1ffvQ==
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr5147693wma.66.1595350411794;
        Tue, 21 Jul 2020 09:53:31 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c25sm4058648wml.18.2020.07.21.09.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:53:31 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 7/9] ASoC: q6asm-dai: add next track metadata support
Date:   Tue, 21 Jul 2020 17:53:04 +0100
Message-Id: <20200721165306.29082-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
References: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to metadata required to do a gapless playback.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index a493350c8cc2..c4b4684b7824 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -71,6 +71,8 @@ struct q6asm_dai_rtd {
 	uint32_t stream_id;
 	uint16_t session_id;
 	enum stream_state state;
+	uint32_t initial_samples_drop;
+	uint32_t trailing_samples_drop;
 };
 
 struct q6asm_dai_data {
@@ -869,6 +871,28 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 	return 0;
 }
 
+static int q6asm_dai_compr_set_metadata(struct snd_compr_stream *stream,
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
@@ -985,6 +1009,7 @@ static struct snd_compress_ops q6asm_dai_compress_ops = {
 	.open		= q6asm_dai_compr_open,
 	.free		= q6asm_dai_compr_free,
 	.set_params	= q6asm_dai_compr_set_params,
+	.set_metadata	= q6asm_dai_compr_set_metadata,
 	.pointer	= q6asm_dai_compr_pointer,
 	.trigger	= q6asm_dai_compr_trigger,
 	.get_caps	= q6asm_dai_compr_get_caps,
-- 
2.21.0

