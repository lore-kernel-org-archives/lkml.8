Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD64C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A61D20809
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZE1QZI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgG0JiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgG0JiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:38:21 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A9FC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:38:21 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r2so9071781wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZFlP2hftW/OVEfLVzTfnKdTkSZtyEnkGEH1R6ufs8I=;
        b=ZZE1QZI99xBLfbuCo9jH5jJHtr6OG63gQKMJQyq//NnYbb1/3yPOseqwhr9mQxPm5U
         ue2F04iceQpIHIWfBuy3Rh3+onBqRbDhO6ViFq8wxn2fLTvP8KX/bdbiH57DG58JZwbP
         llutMB5lv0mc02o5j8YqiwFerDMJpDn457gecbXgk9MtjSUO/HiwspVzfW3fvTJyiVzL
         eADN0rGUHys0/hJhqjSWyxsB4sXAZ6X4RQM2AcxcWY2GEv/fI/9KrXwnPFeD6l0AeSiU
         sVWWZu7vAEo6jqtSWKE2fL4KAVw3Du+2HwTbZm+klSEMPvXKTtz3TDnleEgAJcyvlksn
         CaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZFlP2hftW/OVEfLVzTfnKdTkSZtyEnkGEH1R6ufs8I=;
        b=bjS88LkPHhxSd9ixMGq8v9FnPK+rYV0N6Wy0m3RBgoBuGqVXLOpU2f1jxMcXZd1jB5
         hdohqyq2BRd3g7gkxrs1ezQ5h1nrm4pvYtKWzCeBSJwQlTgJEQFCbw4U74rjlNTguBT4
         Epqf7+U6mA4iPX6byj9MOTtglkLKgxANb0tqD2BARk0jCABoHeBjYJ+z9aX0BN3/c7Ni
         G5jSZIUB+83QvXbT8z9mSUiO/+DLnoAZ47GrI5BCIdWxwX4h4xAdPEjYVKw3DyixJw+A
         hN1MacRbICTfngeBxaINTYinv6736hH2aX7WvMMcxKihm5AHPQNU3N3ph5P+hOEw76j6
         E9cw==
X-Gm-Message-State: AOAM533k0XEm/o2/U4ou2lkfNqmCT6/ho4+VqxaYxMg5OLM7E1m9HgLK
        ofpgEYkISEGLTuE7TKBpvxOKHQ==
X-Google-Smtp-Source: ABdhPJwdYJ0QYsLGadsdE2PzGJ+Pm2WGAupMBwzneDIJXFuCcXa1HslNogSVyOAUXTLBa35lLm1gvA==
X-Received: by 2002:adf:ab05:: with SMTP id q5mr461098wrc.46.1595842699989;
        Mon, 27 Jul 2020 02:38:19 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id y189sm20566099wmd.27.2020.07.27.02.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 02:38:19 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        pierre-louis.bossart@linux.intel.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 05/10] ASoC: q6asm: add support to remove intial and trailing silence
Date:   Mon, 27 Jul 2020 10:38:01 +0100
Message-Id: <20200727093806.17089-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
References: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
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
index 312a0452dcdf..2acfc2274069 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -134,6 +134,12 @@ int q6asm_run(struct audio_client *ac, uint32_t stream_id, uint32_t flags,
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

