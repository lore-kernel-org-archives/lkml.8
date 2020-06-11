Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1E9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D584D207C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L4Yx9htZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgFKMm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgFKMmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:42:11 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347E9C08C5C4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 05:42:10 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t18so6003854wru.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 05:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=89ssfiDaoOJSnjV248d4sDefUT+7TO0HxUeigRg/Xi8=;
        b=L4Yx9htZSgsTyGH9/nBWmXvvG7pSc20Jy88SyQfOe1gfupZBVpYa1iRsAhT6DE1x+T
         iJL4j5tDVV53t5lrkAGU4pxi+6l1wyC1l7yW+Y+MmVNKPBTG36Cv9DoBeJEAYSfNu+ym
         LsWcOh66+ThBt872nbMRSHlCwUp4XrIfrcpHrlMAdihSQ8xesNaGtk74fjiFDlCku8Sr
         zraTcuSRY4BWGd8bf2kBpWhkExwzfHAcfkMT7k5YgPHZfNw/I0Y7r3ZneZ+haejBSWXH
         AvCUzgQmW9hdccTSc1vrbfrdxOfruBq/CwZSIHBH8dMsbHJczW7ouqt2sWba7k/h64Mm
         UPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=89ssfiDaoOJSnjV248d4sDefUT+7TO0HxUeigRg/Xi8=;
        b=VmgbZdWKg9VWJmtFFL0EfYoR8OryDOe1nTsSWHtw5wkabAnoKo+CzGaOYupWNeCEkn
         m4C+E/epDisfNYXsJLsmLj4AsCgJ+3BBYD5GZOwfLsbe2IR3n8nL1DwfJECXypuM6DrD
         C5G0RCGn3TbmnifqXsrqD27qepayEaqxlB4jJpqchA1PzIPS4oJ0ec9CdHExs+WJGXAP
         qCiiPj5VnqyFw9zO50O7URL4jVBPiAjLh6KGLPqHr6vzfY5DkbZLMq5kFQ0gncM31UoQ
         lm9PiQM89nAi6qCbFqgN8GFBveooLgv8Qbos1CRyx9QpbooXt55eB7ClOJCmGhN5S/l/
         zKKA==
X-Gm-Message-State: AOAM5308ljdB3YLlHNV8Hd2IyOvJwkJJ0KWJBAhzd1a3WE+wrXxe4y66
        9RL+RRdKbGnxxHzZ6XBk5wNmKg==
X-Google-Smtp-Source: ABdhPJyErYeOzDKPbvAE9DmcVdq0rdmLobsuWCwfpgj8VuPZq7x6FcvEpRgs8yytZ/OEKGkn1EpUzg==
X-Received: by 2002:a05:6000:1289:: with SMTP id f9mr9541801wrx.5.1591879328901;
        Thu, 11 Jun 2020 05:42:08 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q13sm4810355wrn.84.2020.06.11.05.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:42:08 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/8] ASoC: q6asm: use flags directly from asm-dai
Date:   Thu, 11 Jun 2020 13:41:56 +0100
Message-Id: <20200611124159.20742-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200611124159.20742-1-srinivas.kandagatla@linaro.org>
References: <20200611124159.20742-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use flags set by asm-dais directly!

This will be useful gapless case where write needs a special flag to indicate
that last buffer.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

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
 
-- 
2.21.0

