Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EF7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD51A2065D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="upiA6fr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbgGURAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbgGUQxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:53:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED18C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:53:29 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so21785470wrj.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fdPCJ0r4pAFvhKy/aJH+HSqNEzc4ORQDPhTx4mOph9I=;
        b=upiA6fr7fWef4eXwE0+hK7HGl2gIyiAo2pzkBvVMmS3W+Vh0yJOrvKJdPgo/CAPQVh
         QRYYdyXrB6w9XSMCkMkD93XcqWGYrUo0YWrETPuCibOge0b9sLFCh1MLXBYWTlAltCEr
         W4xW6522EOvZ0ibsQXbR5rCqxNRWIvfX/d26kBZslpOZeJOpBfxv4Z0bQDdKHKOvsccj
         haJ/CMHj0h7cUbQNTxJA2C8BlUjM3Huk/4+PWNy7vmkbnxEklYhjnJH1lXI+z93c6cna
         /FtW3yvq5njXyJ6SMl+BKzAuYDo2MnOYxL59ObNTUJJOrHiDircHJY2G9y/6n2Nz6YuJ
         sFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fdPCJ0r4pAFvhKy/aJH+HSqNEzc4ORQDPhTx4mOph9I=;
        b=kSqP12PuBRdK4mDSZIRvLiIiG6xkfpOK3ywXNVjewhxzd3MyJ+TFMTGgRcboTwlMLm
         4BzNlXT6cAOmQTqLT24sdc0QtbNVfEDDwW9OQMgBWbfr4NAIj3GFdPI9tgMq1ZYqCTOo
         xZWFIQK1E4ABzrlQ8VaWix0L8cVpn19GDILoVTqEJ8oYDZU4cbvp7hkOA7nXFBOK5NcK
         XH8Zb11PsaLgcBejB3yjRwUQRtV0n7ORfFAgoWd6Ts0voAGFwojKxqbqkxdfxLWfMgue
         HMVH3AloU/VjnjxwKXrXU/ij/yDURN3vLWdV61ThsfngWxcR2awr55TeO2FPMyjWUfzG
         1JcA==
X-Gm-Message-State: AOAM533K4E5TmBPffetpQ6zWOG64lfVgkBhxrnqFERnR50r8HwLdT19Z
        0xoPbD4tZysd3md4TKcKCN4NnzdA1AY=
X-Google-Smtp-Source: ABdhPJyJvLH6PEqLYBgiHJM7NLc5orRiT+DOc60Cybemhzgdpex54JO59l//QKyViOBHoN3EJql2jA==
X-Received: by 2002:adf:f784:: with SMTP id q4mr27300836wrp.397.1595350408516;
        Tue, 21 Jul 2020 09:53:28 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c25sm4058648wml.18.2020.07.21.09.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:53:27 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 5/9] ASoC: q6asm: add support to remove intial and trailing silence
Date:   Tue, 21 Jul 2020 17:53:02 +0100
Message-Id: <20200721165306.29082-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
References: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to ASM_DATA_CMD_REMOVE_INITIAL_SILENCE
and ASM_DATA_CMD_REMOVE_TRAILING_SILENCE q6asm command to support
compressed metadata for gapless playback.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 53 ++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6asm.h |  6 ++++
 2 files changed, 59 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 205453d1c1fc..14ec7dad5b65 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -51,6 +51,8 @@
 #define ASM_STREAM_CMD_OPEN_READWRITE_V2        0x00010D8D
 #define ASM_MEDIA_FMT_ALAC			0x00012f31
 #define ASM_MEDIA_FMT_APE			0x00012f32
+#define ASM_DATA_CMD_REMOVE_INITIAL_SILENCE	0x00010D67
+#define ASM_DATA_CMD_REMOVE_TRAILING_SILENCE	0x00010D68
 
 
 #define ASM_LEGACY_STREAM_SESSION	0
@@ -639,6 +641,8 @@ static int32_t q6asm_stream_callback(struct apr_device *adev,
 		case ASM_STREAM_CMD_OPEN_READWRITE_V2:
 		case ASM_STREAM_CMD_SET_ENCDEC_PARAM:
 		case ASM_DATA_CMD_MEDIA_FMT_UPDATE_V2:
+		case ASM_DATA_CMD_REMOVE_INITIAL_SILENCE:
+		case ASM_DATA_CMD_REMOVE_TRAILING_SILENCE:
 			if (result->status != 0) {
 				dev_err(ac->dev,
 					"cmd = 0x%x returned error = 0x%x\n",
@@ -1324,6 +1328,55 @@ int q6asm_stream_media_format_block_ape(struct audio_client *ac,
 }
 EXPORT_SYMBOL_GPL(q6asm_stream_media_format_block_ape);
 
+static int q6asm_stream_remove_silence(struct audio_client *ac, uint32_t stream_id,
+				       uint32_t cmd,
+				       uint32_t num_samples)
+{
+	uint32_t *samples;
+	struct apr_pkt *pkt;
+	void *p;
+	int rc, pkt_size;
+
+	pkt_size = APR_HDR_SIZE + sizeof(uint32_t);
+	p = kzalloc(pkt_size, GFP_ATOMIC);
+	if (!p)
+		return -ENOMEM;
+
+	pkt = p;
+	samples = p + APR_HDR_SIZE;
+
+	q6asm_add_hdr(ac, &pkt->hdr, pkt_size, true, stream_id);
+
+	pkt->hdr.opcode = cmd;
+	*samples = num_samples;
+	rc = apr_send_pkt(ac->adev, pkt);
+	if (rc == pkt_size)
+		rc = 0;
+
+	kfree(pkt);
+
+	return rc;
+}
+
+int q6asm_stream_remove_initial_silence(struct audio_client *ac,
+					uint32_t stream_id,
+					uint32_t initial_samples)
+{
+	return q6asm_stream_remove_silence(ac, stream_id,
+					   ASM_DATA_CMD_REMOVE_INITIAL_SILENCE,
+					   initial_samples);
+}
+EXPORT_SYMBOL_GPL(q6asm_stream_remove_initial_silence);
+
+int q6asm_stream_remove_trailing_silence(struct audio_client *ac, uint32_t stream_id,
+					 uint32_t trailing_samples)
+{
+	return q6asm_stream_remove_silence(ac, stream_id,
+				   ASM_DATA_CMD_REMOVE_TRAILING_SILENCE,
+				   trailing_samples);
+}
+EXPORT_SYMBOL_GPL(q6asm_stream_remove_trailing_silence);
+
 /**
  * q6asm_enc_cfg_blk_pcm_format_support() - setup pcm configuration for capture
  *
diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
index 0379580f0742..e315f7ff5e54 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -135,6 +135,12 @@ int q6asm_run(struct audio_client *ac, uint32_t stream_id, uint32_t flags,
 	      uint32_t msw_ts, uint32_t lsw_ts);
 int q6asm_run_nowait(struct audio_client *ac, uint32_t stream_id,
 		     uint32_t flags, uint32_t msw_ts, uint32_t lsw_ts);
+int q6asm_stream_remove_initial_silence(struct audio_client *ac,
+					uint32_t stream_id,
+					uint32_t initial_samples);
+int q6asm_stream_remove_trailing_silence(struct audio_client *ac,
+					 uint32_t stream_id,
+					 uint32_t trailing_samples);
 int q6asm_cmd(struct audio_client *ac, uint32_t stream_id,  int cmd);
 int q6asm_cmd_nowait(struct audio_client *ac, uint32_t stream_id,  int cmd);
 int q6asm_get_session_id(struct audio_client *ac);
-- 
2.21.0

