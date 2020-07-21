Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA43C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B1AD2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YkPHg0Mx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbgGURDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbgGUQxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:53:37 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4B0C0619DD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:53:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c80so3525720wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NwtppsTcVvcZ5TZNh7CjWprzGgIi6+BwsTgR08pkjwY=;
        b=YkPHg0MxyTyKTlPpIXza+hR1qRXWrYvubKsDsrdNbwnZxNPihEQmkgXkuKD1Cn2PXO
         qDrEcklBJjkleM0dZOqAW1tHoiDjabYteyDFDBJwOxGswvVfvwcgkRjp58XKxawf0EFP
         H018noIhx9M2ntKeM1XWTYeTfb7FIvwbirUuvjpXGOs6h0oTmchpNK9LsP+WvVlN7jkE
         nvPDIflTK70gxnTrKR8U4POBc1mmwVUkkvNVXDCsFvHY3NIjkEiLdM0+0YUKUgp7Ons/
         LiEMiij97V2m5Uu0K6AWuLxBvWud58YHphre0bWgHLqzx6TJlYqffgvHGU1ekQaXWgbo
         4f9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NwtppsTcVvcZ5TZNh7CjWprzGgIi6+BwsTgR08pkjwY=;
        b=mI9l+VM0CQnmHyGOMJYfXEpnza3gCsOomjE7WT3lEhXelVZabSVl7mmdIbeVXg9OSi
         l2JYW+36IlCIqykW/ceJfOIsSD1pgweTgaZUjNTuF1ufeRCB4C/bxrsj8cmAXnkyiU8A
         hyDg6XU4Pev6ggVqq3T55JBr9l7whFjUVJOADYFPyqV4nk81JHZAOu7FTCUb/XtWIjTk
         hft6TL/NEG+uVdga4SnlgqLiibDKC2Bz3yFGrfDIJ6CNnJtDv7awIxO+9/oFjPc0JO3E
         JV5GIl0TUwEPd9QyIPbkk78vG+lcDo56nkr4hr/PMMKoo1itR4rxwMO/zEizM4at+ORH
         Do/A==
X-Gm-Message-State: AOAM5327132LEdD+ns5GjTAeXml/TWRjm3u900+xi0BZ1GUngXAA2rS6
        LOi4CKWYf++dZVo71AMIUm4o0w==
X-Google-Smtp-Source: ABdhPJz06SmuoOdh4tYpRVa5G9rtDS6HPN94BzXs9IQnMA84PpQ2veD0gjkBTx+kuHRfcHY4/U/BhA==
X-Received: by 2002:a1c:19c5:: with SMTP id 188mr4849059wmz.124.1595350410173;
        Tue, 21 Jul 2020 09:53:30 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c25sm4058648wml.18.2020.07.21.09.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:53:29 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 6/9] ASoC: q6asm: add support to gapless flag in q6asm open
Date:   Tue, 21 Jul 2020 17:53:03 +0100
Message-Id: <20200721165306.29082-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
References: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to gapless flag to q6asm_open_write().

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 4 ++--
 sound/soc/qcom/qdsp6/q6asm.c     | 4 +++-
 sound/soc/qcom/qdsp6/q6asm.h     | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 6b9ceac2ceb2..a493350c8cc2 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -259,7 +259,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		ret = q6asm_open_write(prtd->audio_client, prtd->stream_id,
 				       FORMAT_LINEAR_PCM,
-				       0, prtd->bits_per_sample);
+				       0, prtd->bits_per_sample, false);
 	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		ret = q6asm_open_read(prtd->audio_client, prtd->stream_id,
 				      FORMAT_LINEAR_PCM,
@@ -686,7 +686,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 	if (dir == SND_COMPRESS_PLAYBACK) {
 		ret = q6asm_open_write(prtd->audio_client, prtd->stream_id,
 				       params->codec.id, params->codec.profile,
-				       prtd->bits_per_sample);
+				       prtd->bits_per_sample, true);
 
 		if (ret < 0) {
 			dev_err(dev, "q6asm_open_write failed\n");
diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 14ec7dad5b65..22ac99029e56 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -923,7 +923,7 @@ static int q6asm_ac_send_cmd_sync(struct audio_client *ac, struct apr_pkt *pkt)
  */
 int q6asm_open_write(struct audio_client *ac, uint32_t stream_id,
 		     uint32_t format, u32 codec_profile,
-		     uint16_t bits_per_sample)
+		     uint16_t bits_per_sample, bool is_gapless)
 {
 	struct asm_stream_cmd_open_write_v3 *open;
 	struct apr_pkt *pkt;
@@ -943,6 +943,8 @@ int q6asm_open_write(struct audio_client *ac, uint32_t stream_id,
 	pkt->hdr.opcode = ASM_STREAM_CMD_OPEN_WRITE_V3;
 	open->mode_flags = 0x00;
 	open->mode_flags |= ASM_LEGACY_STREAM_SESSION;
+	if (is_gapless)
+		open->mode_flags |= BIT(ASM_SHIFT_GAPLESS_MODE_FLAG);
 
 	/* source endpoint : matrix */
 	open->sink_endpointype = ASM_END_POINT_DEVICE_MATRIX;
diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
index e315f7ff5e54..69513ac1fa55 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -100,7 +100,7 @@ int q6asm_write_async(struct audio_client *ac, uint32_t stream_id, uint32_t len,
 		      uint32_t msw_ts, uint32_t lsw_ts, uint32_t flags);
 int q6asm_open_write(struct audio_client *ac, uint32_t stream_id,
 		     uint32_t format, u32 codec_profile,
-		     uint16_t bits_per_sample);
+		     uint16_t bits_per_sample, bool is_gapless);
 
 int q6asm_open_read(struct audio_client *ac, uint32_t stream_id,
 		    uint32_t format, uint16_t bits_per_sample);
-- 
2.21.0

