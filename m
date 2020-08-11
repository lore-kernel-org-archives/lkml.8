Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64355C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DFEA20782
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sfr0g5fJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgHKMCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 08:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgHKMCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 08:02:16 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3026C061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 05:02:15 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id kq25so12798716ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 05:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UtO337UuhwrHztkf/uXMNcdRJRUGGo/p2OPF/qdxl2E=;
        b=Sfr0g5fJMimBf15dE6fMhdMgI0QznVXtfJt+gZEla2kYWaDQAf8FGWzxAx7q0DtYhS
         HL3QWZD2Bf7+3J0wt9peBnWV1Fs+iPXsIXyeD1TEiYDTb5Lc//Qn2YiFpq3nFIXcHqIG
         QbLFTYed/Aeo4gfv+UwO+PJRuYcGlbAaLUyelMi2EMPUwwQnvt4wQw9deYkSZZ8QjPJu
         6FTQ1jPuLy6D9z2Vs+MjwVbvaNbbOMxNl/agMbyuGOCNZq47gQS0laVH5PoCqlQ+M7YO
         foepncG0wwI0G0EyUbJDVVKmrk3Dm8iy/ikAs2ZGyBacodY7D2F+hz4jrsoK3uyMBNMd
         N91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UtO337UuhwrHztkf/uXMNcdRJRUGGo/p2OPF/qdxl2E=;
        b=E80KI72CVDBZ0e04/Xrb6XZQcmCHaRb+At6f4dwr/q8Chn0Iw/cINFaSxkVUHCKw3M
         G2hypkek72jKy7eTKnpD48jXul4SAJN1120Q3yQ7ohqg+PN8sDcb5LD3LsoFWW/QF/Tw
         AP9eoujIa36kUdsxeSnA0u2UslakaPXPltn4E5UhBk5njSxHHAXA0xqOcWbGYfMgpmuB
         kNNQeKA5TAXbsUGGpWZ+1Hb9wYu8bTKJQCDKYNKndKDDXGeqXtsYyy/+Rgjz8zgyCTm6
         TDZw/jctsPSkxhmt4hEn5anFW3rvJafBO7LbQeGoqnTgw5eTMJ2MdrKjnPA89jpTReRu
         l1EA==
X-Gm-Message-State: AOAM533ZbMedGYGNPMCVZZlpLlmoBEFFj92NwZKV0qBkJAHWqpv/P2I2
        3H+mByxcKXic5D8FvZn/V5J5mg==
X-Google-Smtp-Source: ABdhPJynE3JraElTEyvaK4HUeYOem+y7v5bgGfQh1UqOS+jNIUVSQ8t3NnSIo9Bn040DIQpQ6LntPg==
X-Received: by 2002:a17:906:403:: with SMTP id d3mr25577883eja.522.1597147334476;
        Tue, 11 Aug 2020 05:02:14 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id f21sm14238363edv.66.2020.08.11.05.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 05:02:13 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        john.stultz@linaro.org, stephan@gerhold.net,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/2] ASoC: q6routing: add dummy register read/write function
Date:   Tue, 11 Aug 2020 13:02:05 +0100
Message-Id: <20200811120205.21805-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200811120205.21805-1-srinivas.kandagatla@linaro.org>
References: <20200811120205.21805-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the DAPM widgets for DSP ASoC components reuse reg field
of the widgets for its internal calculations, however these are not
real registers. So read/writes to these numbers are not really
valid. However ASoC core will read these registers to get default
state during startup.

With recent changes to ASoC core, every register read/write
failures are reported very verbosely. Prior to this fails to reads
are totally ignored, so we never saw any error messages.

To fix this add dummy read/write function to return default value.

Reported-by: John Stultz <john.stultz@linaro.org>
Fixes: e3a33673e845 ("ASoC: qdsp6: q6routing: Add q6routing driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes since v1:
	- added reg write callback

 sound/soc/qcom/qdsp6/q6routing.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index eaa95b5a7b66..25d23e0266c7 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -973,6 +973,20 @@ static int msm_routing_probe(struct snd_soc_component *c)
 	return 0;
 }
 
+static unsigned int q6routing_reg_read(struct snd_soc_component *component,
+				       unsigned int reg)
+{
+	/* default value */
+	return 0;
+}
+
+static int q6routing_reg_write(struct snd_soc_component *component,
+			       unsigned int reg, unsigned int val)
+{
+	/* dummy */
+	return 0;
+}
+
 static const struct snd_soc_component_driver msm_soc_routing_component = {
 	.probe = msm_routing_probe,
 	.name = DRV_NAME,
@@ -981,6 +995,8 @@ static const struct snd_soc_component_driver msm_soc_routing_component = {
 	.num_dapm_widgets = ARRAY_SIZE(msm_qdsp6_widgets),
 	.dapm_routes = intercon,
 	.num_dapm_routes = ARRAY_SIZE(intercon),
+	.read = q6routing_reg_read,
+	.write = q6routing_reg_write,
 };
 
 static int q6pcm_routing_probe(struct platform_device *pdev)
-- 
2.21.0

