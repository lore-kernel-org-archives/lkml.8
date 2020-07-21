Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0570C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4E292073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RndzQRQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgGUQ72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbgGUQx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:53:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCB4C0619DC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:53:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z2so21925844wrp.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D0KBLJSyHUDczll9CUzFZybPDYUhXLgXfcuwU2vCfU0=;
        b=RndzQRQyjYHb4zvkO44hxq5eAO6FQW9kx/uS7ttfQ40NAgTl+MUvGZ3C0jksTKPvuk
         MYs431lGl/W90YWtUVqoOmVnLNM5jjOIIDVLORVFC5T/cFkl7rorNxihKg9CZwMM9ba7
         DuRYunowy3/b9x7a6IYhCywKAX1VJ907bQOi57Z5Nsak0ee2WbFXNTG1NYMGT93mHaoN
         DBplYGdtYCrs0kOzk74PgLbaBdLYiGKHTQuSgFJyJ634pOYcpYL1uIF3BGgU7aoVRHwr
         /0iv1z60Gefi6hNqH7MtB+Cx/kCz8a0X34qf6KyFkH1wDEy7U9UrEP6659GkjC3HrRbR
         ddzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D0KBLJSyHUDczll9CUzFZybPDYUhXLgXfcuwU2vCfU0=;
        b=LQUVkruCxj3MC0obCTdjaGW7j6ZA2fry+ce681v+hnhEI4z44ZGNQeLBCOhTmupB0y
         BdIODND3KHMMaSwJ5L8+Wlzg30spUsoRoiXhUCNjhGElGEFzxjTNVkYcKhusAhURGljS
         B8JivKT7RZGZNszryVeM5OUxFWq0W/GDOwJO1FP230XmWVQk6Ek7EYOxPees69EL4Z+k
         J4DMU5MPH1Tzt9FGYXZEk+ng3r2pLT7xdkQHvWVRNoB9+yV8THYhDDQgN/17Xh/DlM1q
         co8giTME8AG6oQxqpgytgYT0s6RFjFG7f1agsmhZEf+SDkkDfPrQ9KHn5Z62eickx7YF
         mWgQ==
X-Gm-Message-State: AOAM531VtbVzLRTc2jk/K0QBCTu0fCiBTW3M3b1RM1e4RsB1xLzk+NCf
        2uwm/Dz2ZPaM8QGroM6cgiq8og==
X-Google-Smtp-Source: ABdhPJwvV9uzLIZ74GTl/g1snxyu/7bH0n2O3i09nImUvb2cFpUvrRvDqEmgGWGpfCBCPCqMBUT9Rg==
X-Received: by 2002:adf:e4d0:: with SMTP id v16mr27262664wrm.193.1595350406849;
        Tue, 21 Jul 2020 09:53:26 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c25sm4058648wml.18.2020.07.21.09.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:53:25 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 4/9] ASoC: q6asm: add length to write command token
Date:   Tue, 21 Jul 2020 17:53:01 +0100
Message-Id: <20200721165306.29082-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
References: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
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
index fb0488e7beb9..6b9ceac2ceb2 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -510,6 +510,7 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
 	struct snd_compr_stream *substream = prtd->cstream;
 	unsigned long flags;
 	uint64_t avail;
+	uint32_t bytes_written;
 
 	switch (opcode) {
 	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
@@ -530,7 +531,8 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
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
index ceece124dd3d..0379580f0742 100644
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

