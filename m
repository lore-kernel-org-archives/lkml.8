Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2852CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00AA02065D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xUCw3RVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbgGURDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730375AbgGURAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:00:40 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E20C0619DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:00:16 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 184so3620876wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=29yfJ1iVy+Hi6g3ZFLKBYwMLLHqUdPID3gr+X5nhlQE=;
        b=xUCw3RVo9rgBVXxyK05KyzX+F+UEoCmKIdZ/zHQJDYM2hP4Z+669hm5koy0s34lI2B
         IV9kS+QFWRnLLNHlCEmI6QiCgV0euvZmz6ldotibeSGKE/ScbaHBTGNckYjtF9vKq0Wv
         8njmiz3BcPLCGI/e3NZ4Zi7TuzbsFwqOky/dKWuXgZVtHsIagRXvYQl/bXzhlYP991a0
         yOdi5hpvIoZJDqDCEDX+C0Aue50qp1MaeYxGtQP0dMZItXbB2/2ev5CUcEEyShXOry6L
         hsdOdLFc5HArkLtNWcd8JrPQ2cKrzrWNZesGbEqLp2wsu6IaIH95o4JJUDfsNnXjzFjy
         EoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=29yfJ1iVy+Hi6g3ZFLKBYwMLLHqUdPID3gr+X5nhlQE=;
        b=HphzTVxx6FirN/AGs1iuotT4oFV4dl7g5vWfIglreUIlSMkhhVi1VkfEJlHM46+Uo9
         2DqRBRP2uGq/ni+Uyyo8RVUmOmWAz0C9zMYb+92+YupdZZE52gwe8B9XJO4j6n7AuqUo
         6I8B06X27CXYEeViOtgeSQJqvezxMHKtiboxVSexn3f+qL4FwNZBSiydWnnrQalX6Iz0
         G/hOYe88DCuTdUfy0wPSgbD7NfdQmmuffSpUAzucCwcRuK1+LJiMywVvAPjY55fB8kFm
         IQKliUIwy1hF+jTbQ0dhVVYvv0dCO5wGNAPqN0AWrBZ6J57ZT2pPydK/aWtcfAM9NXfN
         etcQ==
X-Gm-Message-State: AOAM531ztymfq8/Y+bwEvMs+uO/on4X3L0gQDXpRuHuRfJZHAztJQj1g
        D/PZ7aEXHGpBVxrFqhSG2KyZhQ==
X-Google-Smtp-Source: ABdhPJxd9qOgR1HG0URRCj3/zigqsoR04LiAQhM1WvcGVT/Zw5yPyzOn4ePe9YMuRmMcbgOc/oKw+w==
X-Received: by 2002:a05:600c:414f:: with SMTP id h15mr5200889wmm.82.1595350813907;
        Tue, 21 Jul 2020 10:00:13 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id h11sm15526327wrb.68.2020.07.21.10.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 10:00:13 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH v2 1/6] ALSA: compress: move codec parameter check to a function
Date:   Tue, 21 Jul 2020 18:00:02 +0100
Message-Id: <20200721170007.4554-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move codec parameter checking to dedicated function so that other
callers do not duplicate it. This is in preparedness for adding
snd_compr_set_codec_params() support.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/core/compress_offload.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 0e53f6f31916..af5824113246 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -566,6 +566,18 @@ static int snd_compr_allocate_buffer(struct snd_compr_stream *stream,
 	return 0;
 }
 
+static int snd_compress_check_codec_params(struct snd_codec *codec)
+{
+	/* now codec parameters */
+	if (codec->id == 0 || codec->id > SND_AUDIOCODEC_MAX)
+		return -EINVAL;
+
+	if (codec->ch_in == 0 || codec->ch_out == 0)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int snd_compress_check_input(struct snd_compr_params *params)
 {
 	/* first let's check the buffer parameter's */
@@ -574,14 +586,8 @@ static int snd_compress_check_input(struct snd_compr_params *params)
 	    params->buffer.fragments == 0)
 		return -EINVAL;
 
-	/* now codec parameters */
-	if (params->codec.id == 0 || params->codec.id > SND_AUDIOCODEC_MAX)
-		return -EINVAL;
+	return snd_compress_check_codec_params(&params->codec);
 
-	if (params->codec.ch_in == 0 || params->codec.ch_out == 0)
-		return -EINVAL;
-
-	return 0;
 }
 
 static int
-- 
2.21.0

