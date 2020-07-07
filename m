Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB8FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAB8420773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2/7iVEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgGGQhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgGGQhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:37:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2362AC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 09:37:05 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so43978610wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 09:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0LCQd23Yogjcuva7hnoMUmTS7Zo4+fh0cqMsuVwvVHs=;
        b=z2/7iVEPi6c4YzePA7lVJFqlxQru4flzloqCa6AmzydzcLXSHjRmP6u6E97J+Gfaad
         knpysLVgJ5DAsxr30ZgCeAkqV7BiXkx8lS474vk8i2UI407yuTbOCu43WBO+8wG/bzAb
         Hgv4q55N/tU7w2nnr7GmLX6BJcZtuxiCYzaYoCTYDwXXnaXVKGXBdELSlyaX4pVqLFXt
         O3x9g4lt+CO2/KXQorj2EamsHhF96qNWaJJFpX9eR/bDj07WU3EplKQTR6WuhhWLDnuV
         iMm1BT+Z/oZyGE0p08X4oPgJsq5yHeh3ZXmttChWtSBnUpEqTe7UqSClja8841qZ1nqS
         aXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0LCQd23Yogjcuva7hnoMUmTS7Zo4+fh0cqMsuVwvVHs=;
        b=BpYAIqV6RHSovWzsQHGMQKTFvyBHQx3M05U9WYwikOOZgUv0Nwf2iNKMhULp3bdyUn
         6nWOT0d9Mo9/5xjVfVZAG8RmlgGy5mrzQ2yVCaaU48b+gQzge+j+tR0sEPlQ0wt/OXXN
         6RJeSVpDkAa8cd0qd0xouXB8ZaO2sMl7+gLrtJsSENS98CpIhlsBXqnojcZTCl/V7yFC
         /W+pbCMkuj0dC4lRfysyGOeRerG8lYdLTwpAjESShiyD/P8XsbgOiePBOB4FHwFxgwN8
         mXg1fn5WKfO6WhQiP+9frWvQFWtag+EIzt6Z8JdYF81D2RR5Wr46n5QB+8qiUVHMG2ZM
         irdA==
X-Gm-Message-State: AOAM531x5shrQZyMFEfiGI6JmenQpFxFRnzhAO2wlDnXnYpNnIJLhuMW
        caAcqvE8vlrdv03NjLtawhETag==
X-Google-Smtp-Source: ABdhPJxEGLcIU0q2DNdl3HjVtQCCXNoNR/WiMWN+ecXbpoBqpJ0jbw+EHwixtcDEmaz0Y5yoWECKfw==
X-Received: by 2002:a1c:7d85:: with SMTP id y127mr5259971wmc.181.1594139823817;
        Tue, 07 Jul 2020 09:37:03 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p14sm1925874wrj.14.2020.07.07.09.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 09:37:03 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 11/11] ASoC: q6asm-dai: add support to copy callback
Date:   Tue,  7 Jul 2020 17:36:41 +0100
Message-Id: <20200707163641.17113-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
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
index f48eca227fb5..0b285b759409 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -1045,16 +1045,71 @@ static int q6asm_dai_compr_pointer(struct snd_soc_component *component,
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
@@ -1117,7 +1172,7 @@ static struct snd_compress_ops q6asm_dai_compress_ops = {
 	.get_caps	= q6asm_dai_compr_get_caps,
 	.get_codec_caps	= q6asm_dai_compr_get_codec_caps,
 	.mmap		= q6asm_dai_compr_mmap,
-	.ack		= q6asm_dai_compr_ack,
+	.copy		= q6asm_compr_copy,
 };
 
 static int q6asm_dai_pcm_new(struct snd_soc_component *component,
-- 
2.21.0

