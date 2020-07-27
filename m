Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFF3C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F326E2250E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltxkpA9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgG0JiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgG0JiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:38:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBA1C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:38:19 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so14116221wrj.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BGEGYiZyCfPzP/WgV+vYnmOQ/dOVXNWBzQ8hq5Z41ko=;
        b=ltxkpA9ir5ZOEwoGWUBGf8shaPDTwgYkI7Suv2aMjHin7DHFcAByud8XWneDNcjuOS
         H9OVjgbnUP4LV1sLt4AP9WtGTukJ9/sQtMM4DaHjzJTD6xd7UTyc4nyaQbj5ZcBQPNIg
         Tnd9vXt3eBY/K41w3R3KIUmUQvOtbZxqbAkDRQpx5W4aonKTp9FFsTGHDaF2DLTn1yAK
         Ez4dhdKa5ihdkku7MbNWBv57Wvcqov/t+Fmrs7t5/bjjHmfY+VS/LASxSxHWfE5Yh5yY
         ORwwrUtm3crGbH5INu4krR+09BUnLziT2/I7c2bosdomjhoVVJQdjwMcWGOH9qrbIUC7
         9NmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BGEGYiZyCfPzP/WgV+vYnmOQ/dOVXNWBzQ8hq5Z41ko=;
        b=BCR+YcmyKrWG5uh4SzvRv1P7CE8iRTeD21AjjxJtDP7SSHYQplmx0e2gnajMXoUlnt
         Eff7iiE+OGYJ6b9dAWJpUh5LNcWozHt8z82ylq0qIMzmUPhqcVN8I6hxrDKCa71yLnT8
         8/+hQw0uTHHq5WCM8NFM0D7HlSmU5xcaibRgo6CEI+Qg9lSWrOcH3+Uy7GPKP8za1dcW
         RAMqOF+CzUI3hTBz63jicuvg+WAC+MWWGTds/bvEIv3XxgEAEOTKkjQxxg0gJLxTxBDO
         nGYzw2iJhpv+yNKZ/Se8uVPqCCHBkVKFRHUQXNMVPeI87Y2sCPwnLbBPi3hFVucG820/
         b+5g==
X-Gm-Message-State: AOAM53217sR8M8npcLiLYBUs3rlkgjEug6MxeeK03Pmg4XfN+yCHY6M+
        3TUaz2+976USjJYnAWDpqAkXbQ==
X-Google-Smtp-Source: ABdhPJyRhmnUtPua5J4n3aoS3uN4PK6KuvPMmIUlBFDqDftLzkly2DB7Wb/ZyqoEISkgcAEl97RUag==
X-Received: by 2002:a5d:55c9:: with SMTP id i9mr18964490wrw.31.1595842698519;
        Mon, 27 Jul 2020 02:38:18 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id y189sm20566099wmd.27.2020.07.27.02.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 02:38:17 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        pierre-louis.bossart@linux.intel.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 04/10] ASoC: q6asm: add length to write command token
Date:   Mon, 27 Jul 2020 10:38:00 +0100
Message-Id: <20200727093806.17089-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
References: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add length to write command packet token so that we can track exactly
how many bytes are consumed by DSP in the command reply.

This is useful in some use-cases where the end of the file/stream
is not aligned with period size.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 4 +++-
 sound/soc/qcom/qdsp6/q6asm.c     | 7 ++++---
 sound/soc/qcom/qdsp6/q6asm.h     | 3 +++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 466383b8c20c..5f0e36e23ef3 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -509,6 +509,7 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
 	struct snd_compr_stream *substream = prtd->cstream;
 	unsigned long flags;
 	uint64_t avail;
+	uint32_t bytes_written;
 
 	switch (opcode) {
 	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
@@ -529,7 +530,8 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
 	case ASM_CLIENT_EVENT_DATA_WRITE_DONE:
 		spin_lock_irqsave(&prtd->lock, flags);
 
-		prtd->copied_total += prtd->pcm_count;
+		bytes_written = token >> ASM_WRITE_TOKEN_LEN_SHIFT;
+		prtd->copied_total += bytes_written;
 		snd_compr_fragment_elapsed(substream);
 
 		if (prtd->state != Q6ASM_STREAM_RUNNING) {
diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index d6728304ce6a..205453d1c1fc 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -670,6 +670,7 @@ static int32_t q6asm_stream_callback(struct apr_device *adev,
 		if (ac->io_mode & ASM_SYNC_IO_MODE) {
 			phys_addr_t phys;
 			unsigned long flags;
+			int token = hdr->token & ASM_WRITE_TOKEN_MASK;
 
 			spin_lock_irqsave(&ac->lock, flags);
 
@@ -681,12 +682,12 @@ static int32_t q6asm_stream_callback(struct apr_device *adev,
 				goto done;
 			}
 
-			phys = port->buf[hdr->token].phys;
+			phys = port->buf[token].phys;
 
 			if (lower_32_bits(phys) != result->opcode ||
 			    upper_32_bits(phys) != result->status) {
 				dev_err(ac->dev, "Expected addr %pa\n",
-					&port->buf[hdr->token].phys);
+					&port->buf[token].phys);
 				spin_unlock_irqrestore(&ac->lock, flags);
 				ret = -EINVAL;
 				goto done;
@@ -1535,7 +1536,7 @@ int q6asm_write_async(struct audio_client *ac, uint32_t stream_id, uint32_t len,
 	q6asm_add_hdr(ac, &pkt->hdr, pkt_size, false, stream_id);
 
 	ab = &port->buf[port->dsp_buf];
-	pkt->hdr.token = port->dsp_buf;
+	pkt->hdr.token = port->dsp_buf | (len << ASM_WRITE_TOKEN_LEN_SHIFT);
 	pkt->hdr.opcode = ASM_DATA_CMD_WRITE_V2;
 	write->buf_addr_lsw = lower_32_bits(ab->phys);
 	write->buf_addr_msw = upper_32_bits(ab->phys);
diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
index 9ac020c609c6..312a0452dcdf 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -20,6 +20,9 @@
 #define ASM_CLIENT_EVENT_CMD_RUN_DONE		0x1008
 #define ASM_CLIENT_EVENT_DATA_WRITE_DONE	0x1009
 #define ASM_CLIENT_EVENT_DATA_READ_DONE		0x100a
+#define ASM_WRITE_TOKEN_MASK			GENMASK(15, 0)
+#define ASM_WRITE_TOKEN_LEN_MASK		GENMASK(31, 16)
+#define ASM_WRITE_TOKEN_LEN_SHIFT		16
 
 enum {
 	LEGACY_PCM_MODE = 0,
-- 
2.21.0

