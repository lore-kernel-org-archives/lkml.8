Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FE1C433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93CD92070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RhOXMgss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgG0JiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgG0JiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:38:19 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C17EC0619D4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:38:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z18so10596946wrm.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NGhSMw5rANk93AxDzrh+wwZG+B5HF8qJTCODBy27FHQ=;
        b=RhOXMgssTx6PPGu1/Vegg97W3OXjoKMeWxLRo2HdsCYofJV7I6CWx3NqsrMfRyin3G
         SN4xkcFD4ZPa3UAetwasbE3Hjm9kLETVc72d/EhjygzCyg9O5Pvdt24lQXrf988dBhCw
         0R3jANKPQFUZaGGFy+FFrfBbySVuV7PxdtTLPLKS56uCUgBx6b3eUBrozqtSdhD9wP8Y
         AUnRULsfwCpQjxr/nnNABoG3reJ+YiARMnmK1DcekF2+ZMGVaeaPbWvlDxyAXGhM/QZS
         kM3TD6v8lG5okWyFgl10QvoWXVU/eMkNVda2aAgy4OMQbRTMAT4CymAAaIdterxvqEI+
         v4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NGhSMw5rANk93AxDzrh+wwZG+B5HF8qJTCODBy27FHQ=;
        b=jzYJdPRAz9QCWZSCvPeikPLwiVAEJxHl1ouzhER+aqaxslJyrXft71RxlwHfdJpZUG
         fr76IpJ4fco3z86AK4lQTWnA5Cacra3WoQk4lhQpAApHdFfVNuwaP72rzXQNC3owPsYD
         AckfcXnoSbyUSCtwmKFKtITi7Ww9wyuYIsIGl1Dcc8r51s87avxHBa8klynvleefX9jV
         Pd+SXHvsZFyqdFNXj7nw4zdxHxiltk93vlcACh3lWR6O04CjC7EXKXFPUJH+7IYQlY2J
         wwQz7WNd33QFOQypQuNiLePV/dmIEnu7kEHssIP12cHUO/4lnlWegeEnF9YaMMqCHMcb
         PSew==
X-Gm-Message-State: AOAM531m0n1tRgEDMzGDgrUjDbZfxF3buPFTOMMFKJoZCshJgSiwx2DF
        LaF8to44M5jAu00lV8rRUvWqpg==
X-Google-Smtp-Source: ABdhPJya93rqdcJwhckPQUaHBuEIu9GMb+saVL1XYg0o4gz1LaDhJSt0Sn/S40itt6TIeef+yn1+Eg==
X-Received: by 2002:a5d:4942:: with SMTP id r2mr15760878wrs.285.1595842697169;
        Mon, 27 Jul 2020 02:38:17 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id y189sm20566099wmd.27.2020.07.27.02.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 02:38:16 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        pierre-louis.bossart@linux.intel.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 03/10] ASoC: q6asm: use flags directly from q6asm-dai
Date:   Mon, 27 Jul 2020 10:37:59 +0100
Message-Id: <20200727093806.17089-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
References: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use flags set by q6asm-dais directly!

This will be useful gapless case where write needs a special flag to indicate
that last buffer.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 8 ++++----
 sound/soc/qcom/qdsp6/q6asm.c     | 5 +----
 sound/soc/qcom/qdsp6/q6asm.h     | 1 -
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index e8c732ec6061..466383b8c20c 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -186,7 +186,7 @@ static void event_handler(uint32_t opcode, uint32_t token,
 	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			q6asm_write_async(prtd->audio_client, prtd->stream_id,
-				   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
+				   prtd->pcm_count, 0, 0, 0);
 		break;
 	case ASM_CLIENT_EVENT_CMD_EOS_DONE:
 		prtd->state = Q6ASM_STREAM_STOPPED;
@@ -196,7 +196,7 @@ static void event_handler(uint32_t opcode, uint32_t token,
 		snd_pcm_period_elapsed(substream);
 		if (prtd->state == Q6ASM_STREAM_RUNNING)
 			q6asm_write_async(prtd->audio_client, prtd->stream_id,
-					   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
+					   prtd->pcm_count, 0, 0, 0);
 
 		break;
 		}
@@ -515,7 +515,7 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
 		spin_lock_irqsave(&prtd->lock, flags);
 		if (!prtd->bytes_sent) {
 			q6asm_write_async(prtd->audio_client, prtd->stream_id,
-					  prtd->pcm_count, 0, 0, NO_TIMESTAMP);
+					  prtd->pcm_count, 0, 0, 0);
 			prtd->bytes_sent += prtd->pcm_count;
 		}
 
@@ -541,7 +541,7 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
 
 		if (avail >= prtd->pcm_count) {
 			q6asm_write_async(prtd->audio_client, prtd->stream_id,
-					   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
+					   prtd->pcm_count, 0, 0, 0);
 			prtd->bytes_sent += prtd->pcm_count;
 		}
 
diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index f5d1f3c2c1ec..d6728304ce6a 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -1546,10 +1546,7 @@ int q6asm_write_async(struct audio_client *ac, uint32_t stream_id, uint32_t len,
 	write->mem_map_handle =
 	    ac->port[SNDRV_PCM_STREAM_PLAYBACK].mem_map_handle;
 
-	if (wflags == NO_TIMESTAMP)
-		write->flags = (wflags & 0x800000FF);
-	else
-		write->flags = (0x80000000 | wflags);
+	write->flags = wflags;
 
 	port->dsp_buf++;
 
diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
index ceece124dd3d..9ac020c609c6 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -29,7 +29,6 @@ enum {
 };
 
 #define MAX_SESSIONS	8
-#define NO_TIMESTAMP    0xFF00
 #define FORMAT_LINEAR_PCM   0x0000
 
 struct q6asm_flac_cfg {
-- 
2.21.0

