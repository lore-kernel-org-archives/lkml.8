Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEA0C433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE0A2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UPva6lbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgG0Ji2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbgG0JiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:38:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8671C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:38:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a15so14150337wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oaaxr1XrWDeHaCTc5ZRFtudk1Q+YHJL7mwPY5QYLst4=;
        b=UPva6lbHnT6aJkApbjzdPclDHZuqy7Fdq/YKotY/LvbsW8sTVfwaiVi0Cly0mwUbvV
         hda1HFrFJQIZxeo6gR+A/JbyE5jTxkMQBt5M+RSl7XQ5qgTGjTuARTV47LarnuuF9z0i
         meKGo7QHKoIs9YT1CAQuL1fak1xUY5XbDpspq9OJwOOoYXGDmT0OYc3SYsqxBMio/mVQ
         w7u36cc0Wp01tHAWOGOL+WORHfcQmr2o1E3YAPPHFirKgd9qErfUmlaN7Ui5kMEiuIs3
         QGk3fhi8BTquSsy2xjuU8pCRjE4FPm/NZiSPWOxC80vD0EFfUCWjoUoY/2qsE27XjkfZ
         aFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oaaxr1XrWDeHaCTc5ZRFtudk1Q+YHJL7mwPY5QYLst4=;
        b=aZkzplyojcIbZdY3R8+jpubqbiE6pcJLNb0o1rh0NIxe/vmp6plcCZvAlAbYKLp1OH
         H/OUp+6aN8OvRkQI1+def71h0q7n/Bes1aNgCFJKMZ5y9jUhQT3aGxVdyS14LOla71Gd
         ZXYFIHS4kLQrbvfY3n9CBLIYHWiFO6O9nLvL5HWdihl8NADuBrnox97ooKItT5DpYX1h
         B0M89+hXz53hwWeeoW0jmt32GtZcl2SAFqEsKnK3XCC2UK5wWyWkY3ZLAYteNfCH3zGf
         R7CmYsRT+m0YYnOpNbdL3YGjlWZ2p5qwbVIP4PJAnds8FekD8FtJ0t/sKMe50jyfArRF
         Q1Hw==
X-Gm-Message-State: AOAM532WitdqxbvfAP2Q1DurmTOCWEjUajATtXyeBuNC1ee5utNHYxXp
        EnbCC/TQbQZssRu51sV/Im2wsg==
X-Google-Smtp-Source: ABdhPJwYDrPNX+3ZAENAGl9buZdCJ8GBfodGVnw8Ziwk0v7h4XS004nimyMPlTK611g7EmJW5ZpZnw==
X-Received: by 2002:a5d:43c4:: with SMTP id v4mr18194825wrr.426.1595842701525;
        Mon, 27 Jul 2020 02:38:21 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id y189sm20566099wmd.27.2020.07.27.02.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 02:38:20 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        pierre-louis.bossart@linux.intel.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 06/10] ASoC: q6asm: add support to gapless flag in q6asm open
Date:   Mon, 27 Jul 2020 10:38:02 +0100
Message-Id: <20200727093806.17089-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
References: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
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
index 5f0e36e23ef3..4652c78d57c5 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -258,7 +258,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		ret = q6asm_open_write(prtd->audio_client, prtd->stream_id,
 				       FORMAT_LINEAR_PCM,
-				       0, prtd->bits_per_sample);
+				       0, prtd->bits_per_sample, false);
 	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		ret = q6asm_open_read(prtd->audio_client, prtd->stream_id,
 				      FORMAT_LINEAR_PCM,
@@ -685,7 +685,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
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
index 2acfc2274069..f20e1441988f 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -99,7 +99,7 @@ int q6asm_write_async(struct audio_client *ac, uint32_t stream_id, uint32_t len,
 		      uint32_t msw_ts, uint32_t lsw_ts, uint32_t flags);
 int q6asm_open_write(struct audio_client *ac, uint32_t stream_id,
 		     uint32_t format, u32 codec_profile,
-		     uint16_t bits_per_sample);
+		     uint16_t bits_per_sample, bool is_gapless);
 
 int q6asm_open_read(struct audio_client *ac, uint32_t stream_id,
 		    uint32_t format, uint16_t bits_per_sample);
-- 
2.21.0

