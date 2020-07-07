Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A48AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D9F2064C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKVb4Y4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgGGQhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbgGGQhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:37:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF63C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 09:37:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f18so47244841wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 09:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iRN6o+p1itojHcaFRxgrGSWCOSGdr0VVMo4vP6TgjyY=;
        b=SKVb4Y4zeIMHe89fvsXsPpFJsJcmEzKqZ1ZHx33ll+/weS64aNM9lL4Wqc8GBgqZxu
         f2cP2S8NBDtvjsl3mV0NDVQAn/Oefjui/Zgzbufq07Gtg3ry02CXMZh8VKDzFuEBl2vP
         omGCEX9CRpP6WjmfIBiGCGZ5VwpmGC9bLJpf9ALpf2OLPuo5RvK32oy51UWwUtwB3V/A
         v4uAMWZJ+yg9cHGagNW7Qe89fDqM3CmMi9yhRlEMmA6+yIF0xR2DRe1RjB4eDfPRdPXG
         kGUiyUDbOApN6JAlzR6d5qKfO7t4z/2Ewb/JFLXc7UrE42X+XajwaqrMg+5LpOyWpTMQ
         VY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iRN6o+p1itojHcaFRxgrGSWCOSGdr0VVMo4vP6TgjyY=;
        b=mm2zOOEaVT1wdncItg1XAUrr+btmZpp/swwd94rxxt7W9Zmheqm/w7sJrQUjFS1DRR
         QA8jJHiwW5XzLaa10+HVpKMc5S0nCD91t017Yg2x4+sc+i0NUosyksIzBkm6++FxCjny
         OKgXrYHwRTFHDtU8Yt8rj4EkxhDghu/+ZTSRmuqKnZCYDQuDnxJaRBbPaBFklRFfia9c
         HP4AD5N6NN9i0jilpwYKTU6INry7zfEjJocbdEFlFnCKtmQ16+xpFh6YQFYov2Vd7Bf7
         efQR+hHjKu+OuV5WeawtTrWhz3J/127nxy4B3xJnkgM6P7c/E5v0LgK+tO6kUuPpx+T6
         Q3lw==
X-Gm-Message-State: AOAM531otQhSxh7AHSIme9+Pj7HK49p7KyHksNUtSqqk3GRE7wvahNm9
        nKk5JihHxLlrsJLC2e5WMUXcwQ==
X-Google-Smtp-Source: ABdhPJy4mbomuMOkS1d2J9pyuA5Z5IB6RG1GuMns4Yyo/F1FjtOkvcfPRFh7nkmb4NTOriF0JVuiJw==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr4883519wmc.72.1594139818805;
        Tue, 07 Jul 2020 09:36:58 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p14sm1925874wrj.14.2020.07.07.09.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 09:36:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 07/11] ASoC: q6asm: add support to gapless flag in asm open
Date:   Tue,  7 Jul 2020 17:36:37 +0100
Message-Id: <20200707163641.17113-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
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
index c3558288242a..8c214436a2c2 100644
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

