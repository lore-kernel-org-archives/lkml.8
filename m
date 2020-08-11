Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE04C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C774420656
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BucFTP/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgHKK0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 06:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgHKK0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 06:26:00 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F06FC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 03:26:00 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id m20so8660237eds.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 03:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PaWjjpu7k8J9RHaNkW//mkekRofZuSKHvdYD85FjRL0=;
        b=BucFTP/U0ooSwDRC3ml0RS3YG5nZYJfI2RHb6DVQUW7bjkswI+6cSdb9nLwTSRU95W
         LFYeyr7pH6ftcNWyO+90HHFn0/cmOpmU5WX3p4joKIHk4vwDBlxo9dm311EPTfK8tDDx
         irLzHLg26oLDsUNhsjtj/wwPlQkvpkj7EhaLmL5hzKx8yz/bAXVP7Viy480MmNAmu8nY
         RDX4z3uyWN46vkhj0oSt6kXEuUcBnZ24fS26JKj2rep0kHMTViTtIgl2kI9VRQDmaKzJ
         xxPaVVKDGo0Ql8AYnjrmY+AG0OeVjhP7OMxIk8A3BNzbwDauKBzKh3HsCvYqNWZc73JB
         l7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PaWjjpu7k8J9RHaNkW//mkekRofZuSKHvdYD85FjRL0=;
        b=hwH/CbGKQFzK4H560AUhiyoxfhoMz901vMTiInjR58KuNwUkmAHz0tElCOdlJBtHc7
         ZpDbvaU1lMBVCz0QS1Sfbaa2fszP6FH8kNmbaHT6ms+sNs8Gut1ueo6bIYq0DyXgvSEs
         NJGk52Rld5T3jJbgVmWb+ZQDM4/Rm/Xsab3/jn102L/BQWOW1JCXt0rDDmKChme2x2mt
         guus7HzS1JFQNPB0LwjPPwyCthJCDzZY7rNxfmY07zglI8nOx0IsIafRBeR5qFDHFPG9
         HXmYJrDfgxUR1uiEtmBXII2vzVQg+Ntw44eAyG++eWdklZ6mMmJKE1/Bj+kjclu2dZ4z
         JDnw==
X-Gm-Message-State: AOAM531FGLJjyblxdpulhebUHnQ8WqHJQ3w2+1klDRpdMSBYdRWVKOZq
        5zJ3yRUPheY8jphONHb7ANJUJg==
X-Google-Smtp-Source: ABdhPJw7lgKWYL2W+g2daDCtxbUyMIzYG9IWIZ1uZANjQlfF+D0YKGkMjX9+XiPw5+vJHZ8Idi9Y3g==
X-Received: by 2002:aa7:d516:: with SMTP id y22mr25187240edq.221.1597141558972;
        Tue, 11 Aug 2020 03:25:58 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id v14sm14864196ejb.63.2020.08.11.03.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 03:25:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        john.stultz@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] ASoC: q6routing: add dummy register read function
Date:   Tue, 11 Aug 2020 11:25:52 +0100
Message-Id: <20200811102552.26975-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200811102552.26975-1-srinivas.kandagatla@linaro.org>
References: <20200811102552.26975-1-srinivas.kandagatla@linaro.org>
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

To fix this add dummy read function to return default value.

Reported-by: John Stultz <john.stultz@linaro.org>
Fixes: e3a33673e845 ("ASoC: qdsp6: q6routing: Add q6routing driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index eaa95b5a7b66..fb7c4b266d19 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -973,6 +973,13 @@ static int msm_routing_probe(struct snd_soc_component *c)
 	return 0;
 }
 
+static unsigned int q6routing_reg_read(struct snd_soc_component *component,
+				       unsigned int reg)
+{
+	/* default value */
+	return 0;
+}
+
 static const struct snd_soc_component_driver msm_soc_routing_component = {
 	.probe = msm_routing_probe,
 	.name = DRV_NAME,
@@ -981,6 +988,7 @@ static const struct snd_soc_component_driver msm_soc_routing_component = {
 	.num_dapm_widgets = ARRAY_SIZE(msm_qdsp6_widgets),
 	.dapm_routes = intercon,
 	.num_dapm_routes = ARRAY_SIZE(intercon),
+	.read = q6routing_reg_read,
 };
 
 static int q6pcm_routing_probe(struct platform_device *pdev)
-- 
2.21.0

