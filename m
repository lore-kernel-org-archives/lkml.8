Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BACFC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0815A207BB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fx7sh8hS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbgGURDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbgGUQxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:53:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B59EC0619E0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:53:35 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so3515704wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=es6+jBGMK8ai7em1T9vvEeryxpgMOX8IQwvAkx9cMQo=;
        b=Fx7sh8hSQNz81hTJDLXs7WqJS1Gaen4E8ekXdPxKWS8mqU2W8JoWCKAyamnXo3V9Qf
         qIyEuZoh6mXqmvD4f55tFRhwwq3SJ5kFtp9cXFBGAsHVLmq1XlZpEI2girohTMYFTQiA
         lpjAfEpeFncJlLSEV/mKg4lngHtGSk3LzD9p533NkJsXsitWsjj8lGfVwLDWuJ2j9E6O
         zdD3DBK+5G3EDn/lYr+2LRWqtIp6Q1ys6YKVPFqUdk3z1yVTV8ob5zsXqdb4YLawxEmo
         ih8V0RXvRPVe1HLdNonD1Kx6c97wH7THpTFzYcdgSZh8ubhcnKNw3z/ieDWY8qPlH8K1
         ux6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=es6+jBGMK8ai7em1T9vvEeryxpgMOX8IQwvAkx9cMQo=;
        b=Avzl3o+DEOtNIKWlOHAeKrWp7mJD3eFYOK93Ke/WNXLcm0emwitZBRTovIAzCVrW6/
         KfJVM90Wi5C0P+Y6A9Q9v9EMjZI8vkQ/MnhhqAogQkSLfoMz0SezSyOfBSSl7H3qDPhM
         Axjtm5GctFCDjYVQKORraB36SeCt6p3BmSam4eyDDEJN4hIg8NBLwbKdMbRN6/ni4IUG
         Dw0Oq+EvM6TRD4fzwW489BqXPy8KhNLWxgPIXuDFUugEVPLOABRgN5GJtsyftjO2GKQt
         jTZiRCHTdGirpXEiEv7aDBxE+9mdmvoLKMTy7ackoauE1HoGBmxPiQAn8r+sCvJFZs+G
         S4FA==
X-Gm-Message-State: AOAM5333d/OctXzI8jwUiigq5V96RmTuyCCXXqDqgK44G2F9HG54TmSt
        cLlYUhT8tzLESvjox7wrNUb5JMYdvoE=
X-Google-Smtp-Source: ABdhPJy8DGVcnB0ReuS3Md3gtsV1gJJfunligUoL/2nZPSFt2oAeeXmUfHU0PZAARbgH4KxT3CVRmg==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr4959466wmk.34.1595350414160;
        Tue, 21 Jul 2020 09:53:34 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c25sm4058648wml.18.2020.07.21.09.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:53:33 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 9/9] ASoC: q6asm-dai: add support to copy callback
Date:   Tue, 21 Jul 2020 17:53:06 +0100
Message-Id: <20200721165306.29082-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
References: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During gapless playback, its possible for previous track to
end at unaligned boundary, starting next track on the same
boundary can lead to unaligned address exception in dsp.

So implement copy callback for finer control on the buffer offsets.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 65 +++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 50055c113f10..b5c719682919 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -1052,16 +1052,71 @@ static int q6asm_dai_compr_pointer(struct snd_soc_component *component,
 	return 0;
 }
 
-static int q6asm_dai_compr_ack(struct snd_soc_component *component,
-			       struct snd_compr_stream *stream,
-			       size_t count)
+static int q6asm_compr_copy(struct snd_soc_component *component,
+			    struct snd_compr_stream *stream, char __user *buf,
+			    size_t count)
 {
 	struct snd_compr_runtime *runtime = stream->runtime;
 	struct q6asm_dai_rtd *prtd = runtime->private_data;
 	unsigned long flags;
+	u32 wflags = 0;
+	int avail, bytes_in_flight = 0;
+	void *dstn;
+	size_t copy;
+	u32 app_pointer;
+	u32 bytes_received;
+
+	bytes_received = prtd->bytes_received;
+
+	/**
+	 * Make sure that next track data pointer is aligned at 32 bit boundary
+	 * This is a Mandatory requirement from DSP data buffers alignment
+	 */
+	if (prtd->next_track)
+		bytes_received = ALIGN(prtd->bytes_received, prtd->pcm_count);
+
+	app_pointer = bytes_received/prtd->pcm_size;
+	app_pointer = bytes_received -  (app_pointer * prtd->pcm_size);
+	dstn = prtd->dma_buffer.area + app_pointer;
+
+	if (count < prtd->pcm_size - app_pointer) {
+		if (copy_from_user(dstn, buf, count))
+			return -EFAULT;
+	} else {
+		copy = prtd->pcm_size - app_pointer;
+		if (copy_from_user(dstn, buf, copy))
+			return -EFAULT;
+		if (copy_from_user(prtd->dma_buffer.area, buf + copy,
+				   count - copy))
+			return -EFAULT;
+	}
 
 	spin_lock_irqsave(&prtd->lock, flags);
-	prtd->bytes_received += count;
+
+	bytes_in_flight = prtd->bytes_received - prtd->copied_total;
+
+	if (prtd->next_track) {
+		prtd->next_track = false;
+		prtd->copied_total = ALIGN(prtd->copied_total, prtd->pcm_count);
+		prtd->bytes_sent = ALIGN(prtd->bytes_sent, prtd->pcm_count);
+	}
+
+	prtd->bytes_received = bytes_received + count;
+
+	/* Kick off the data to dsp if its starving!! */
+	if (prtd->state == Q6ASM_STREAM_RUNNING && (bytes_in_flight == 0)) {
+		uint32_t bytes_to_write = prtd->pcm_count;
+
+		avail = prtd->bytes_received - prtd->bytes_sent;
+
+		if (avail < prtd->pcm_count)
+			bytes_to_write = avail;
+
+		q6asm_write_async(prtd->audio_client, prtd->stream_id,
+				  bytes_to_write, 0, 0, wflags);
+		prtd->bytes_sent += bytes_to_write;
+	}
+
 	spin_unlock_irqrestore(&prtd->lock, flags);
 
 	return count;
@@ -1124,7 +1179,7 @@ static struct snd_compress_ops q6asm_dai_compress_ops = {
 	.get_caps	= q6asm_dai_compr_get_caps,
 	.get_codec_caps	= q6asm_dai_compr_get_codec_caps,
 	.mmap		= q6asm_dai_compr_mmap,
-	.ack		= q6asm_dai_compr_ack,
+	.copy		= q6asm_compr_copy,
 };
 
 static int q6asm_dai_pcm_new(struct snd_soc_component *component,
-- 
2.21.0

