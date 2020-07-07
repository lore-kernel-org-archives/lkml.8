Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE09C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F7C2064C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xjrxz6Uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgGGQhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbgGGQhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:37:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C708C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 09:37:02 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o8so43978469wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 09:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mXSLR7iMnpm45taqbFAGKqh/zslkXOWYUH4mPXBbrmE=;
        b=xjrxz6Uk2oTPsp6LJHb0UktwlKqpwA6oFl732jwtKfnQe7iRFeOtBlMeMQnisK6dzj
         NAMySLMsz5bWIw+adQAUosrYGdtjHw0g2H9RcboNEe0cNP/265BIw72THqoQEInuD4lH
         G0SBrwZpXNANRIZkz6peQo4gwEFi/ecCeDIPuqfjlxu5pQ8f6ZMzovuGPeuuUVsl9eWA
         RWiFTXiAAtFvJQJ679aqIw6jdvkftUljGXraEqfO3PuCUtsOdw/G8ol+XWmT285GXt/N
         p/ugv17CeLSOqHMVP1Vbbph2p6C7RzZ23GPBpGnf/+gUWjaxy23DFLJ4EdnnfTb7ncQz
         dkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mXSLR7iMnpm45taqbFAGKqh/zslkXOWYUH4mPXBbrmE=;
        b=orTNrnVPupQ/x86Bmb4U5crOtDxL49sEkUdGOuehjokUcSv+fDUP4gEsrU8M3nFipP
         L6rafS8PYeFMX2MA7xUAajoFgpAtXdqo5nNTW5Hi34yrBPWrObOWcVrEzVEDwKG9cEeE
         sZQxKs3x/T2R8/WriS/QD5VHDIqUcrd18Ubp4bsU185fjs55Tfol1CZKmdni0TkqsB9V
         LHTbRwuh2ZruefWezD0khsJivzge+eX3cg7IqEhbZ4psyFqEgYOFeO5VE8V4lZVwh4Qu
         UPHk2ShWKJwSAMykI4l8/+lBI3ppXsQzVSHhRxLx8Re2g27l5aN7eXlA4AHREkVSY2Wu
         FxOA==
X-Gm-Message-State: AOAM53185SeJpbB3UddKMHWXkqObZkmsmuwwTUMC6JLMded+76fD9Mk4
        CKGd8P/kYWE1Ai/PO0SXtg7rPw==
X-Google-Smtp-Source: ABdhPJzbGGjMFukQ72dWUXtYlcMgBGenzO2ViNFSXsTUM2cUiDwQIOAtRPmdkAA17cOf/qT9z7OZeQ==
X-Received: by 2002:a05:600c:414f:: with SMTP id h15mr5429140wmm.82.1594139821236;
        Tue, 07 Jul 2020 09:37:01 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p14sm1925874wrj.14.2020.07.07.09.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 09:37:00 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/11] ASoC: qdsp6: use dev_err instead of pr_err
Date:   Tue,  7 Jul 2020 17:36:39 +0100
Message-Id: <20200707163641.17113-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index c0e1e84267bf..c4b4684b7824 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -222,6 +222,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	struct snd_soc_pcm_runtime *soc_prtd = substream->private_data;
 	struct q6asm_dai_rtd *prtd = runtime->private_data;
 	struct q6asm_dai_data *pdata;
+	struct device *dev = component->dev;
 	int ret, i;
 
 	pdata = snd_soc_component_get_drvdata(component);
@@ -229,7 +230,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 		return -EINVAL;
 
 	if (!prtd || !prtd->audio_client) {
-		pr_err("%s: private data null or audio client freed\n",
+		dev_err(dev, "%s: private data null or audio client freed\n",
 			__func__);
 		return -EINVAL;
 	}
@@ -252,7 +253,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 				       prtd->periods);
 
 	if (ret < 0) {
-		pr_err("Audio Start: Buffer Allocation failed rc = %d\n",
+		dev_err(dev, "Audio Start: Buffer Allocation failed rc = %d\n",
 							ret);
 		return -ENOMEM;
 	}
@@ -268,7 +269,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	}
 
 	if (ret < 0) {
-		pr_err("%s: q6asm_open_write failed\n", __func__);
+		dev_err(dev, "%s: q6asm_open_write failed\n", __func__);
 		q6asm_audio_client_free(prtd->audio_client);
 		prtd->audio_client = NULL;
 		return -ENOMEM;
@@ -278,7 +279,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	ret = q6routing_stream_open(soc_prtd->dai_link->id, LEGACY_PCM_MODE,
 			      prtd->session_id, substream->stream);
 	if (ret) {
-		pr_err("%s: stream reg failed ret:%d\n", __func__, ret);
+		dev_err(dev, "%s: stream reg failed ret:%d\n", __func__, ret);
 		return ret;
 	}
 
@@ -300,7 +301,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 
 	}
 	if (ret < 0)
-		pr_info("%s: CMD Format block failed\n", __func__);
+		dev_info(dev, "%s: CMD Format block failed\n", __func__);
 
 	prtd->state = Q6ASM_STREAM_RUNNING;
 
@@ -355,7 +356,7 @@ static int q6asm_dai_open(struct snd_soc_component *component,
 
 	pdata = snd_soc_component_get_drvdata(component);
 	if (!pdata) {
-		pr_err("Drv data not found ..\n");
+		dev_err(dev, "Drv data not found ..\n");
 		return -EINVAL;
 	}
 
@@ -368,7 +369,7 @@ static int q6asm_dai_open(struct snd_soc_component *component,
 				(q6asm_cb)event_handler, prtd, stream_id,
 				LEGACY_PCM_MODE);
 	if (IS_ERR(prtd->audio_client)) {
-		pr_info("%s: Could not allocate memory\n", __func__);
+		dev_info(dev, "%s: Could not allocate memory\n", __func__);
 		ret = PTR_ERR(prtd->audio_client);
 		kfree(prtd);
 		return ret;
@@ -386,12 +387,12 @@ static int q6asm_dai_open(struct snd_soc_component *component,
 				SNDRV_PCM_HW_PARAM_RATE,
 				&constraints_sample_rates);
 	if (ret < 0)
-		pr_info("snd_pcm_hw_constraint_list failed\n");
+		dev_info(dev, "snd_pcm_hw_constraint_list failed\n");
 	/* Ensure that buffer size is a multiple of period size */
 	ret = snd_pcm_hw_constraint_integer(runtime,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
 	if (ret < 0)
-		pr_info("snd_pcm_hw_constraint_integer failed\n");
+		dev_info(dev, "snd_pcm_hw_constraint_integer failed\n");
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		ret = snd_pcm_hw_constraint_minmax(runtime,
@@ -399,21 +400,21 @@ static int q6asm_dai_open(struct snd_soc_component *component,
 			PLAYBACK_MIN_NUM_PERIODS * PLAYBACK_MIN_PERIOD_SIZE,
 			PLAYBACK_MAX_NUM_PERIODS * PLAYBACK_MAX_PERIOD_SIZE);
 		if (ret < 0) {
-			pr_err("constraint for buffer bytes min max ret = %d\n",
-									ret);
+			dev_err(dev, "constraint for buffer bytes min max ret = %d\n",
+				ret);
 		}
 	}
 
 	ret = snd_pcm_hw_constraint_step(runtime, 0,
 		SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
 	if (ret < 0) {
-		pr_err("constraint for period bytes step ret = %d\n",
+		dev_err(dev, "constraint for period bytes step ret = %d\n",
 								ret);
 	}
 	ret = snd_pcm_hw_constraint_step(runtime, 0,
 		SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
 	if (ret < 0) {
-		pr_err("constraint for buffer bytes step ret = %d\n",
+		dev_err(dev, "constraint for buffer bytes step ret = %d\n",
 								ret);
 	}
 
-- 
2.21.0

