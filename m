Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C57C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6836C20771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IhOXTjVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgGGOiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbgGGOiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B6BC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:38:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so46802320wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=joYuVrqjbvze3xQNhXb1qygj1A0MIp/q6w6MCrvUZ8U=;
        b=IhOXTjVMYFUujmZaEgHv/pfMwLaNnDUdlNNgKSMoflKYkAmtWB/h0Diq5Zqy29FQBQ
         F3vXbY5HCuGwkbT/EYmHPySO7bxH35ASeHizHBLQH1nh8gflpFpOx1g8eOLQjM0P2c63
         HKWW8jBApZKsX8R+p811F2DJSoQCoLxnt5EVBODnXS10b/HK6sqDvByi72gsifAqvQmM
         1lqFcvELQOIU/9ba1F5yBI8x1CQkcuoD5wDVDCq54bRRMWhm8ua0sDhhIcwQ1/kMPwY+
         ylGno9KJF/Uh2qp9/gCgKcIiMpheTfbCQ8x8GKQ4dBfFGnRL4n/N0y0Blxr2OymdB37K
         ahUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=joYuVrqjbvze3xQNhXb1qygj1A0MIp/q6w6MCrvUZ8U=;
        b=FF70qFZq+1q8wrCvpSjQ/9K0TeGU89v4OBJ3kw+wUVN09y0CTGRJk7lH/FDWh1RhHr
         hp+CVJXF8xgNiafDYJ1qWl6nOp8YhKDZHzJIspxTMrWs2H7ZvFRfDdbAPq7LqK1Aau31
         wzEUC5DoMDqFzXXm5IlC5i6E1rBIFoISpp1SepeYZVyC0AuymJUudZap0i33huC7kv8W
         OtzQ1KljDp8+pqrKPsUA9yXMbSE53/UoeuhjqgCQH4g8mKs+WIhCO7pnFdy4qJgpLzr3
         PdFNr4iCraQizSH4LRQ97yOBQoZywrPkqoAACsVQUenfJHExittqE9sMh1p2CgN+Y+er
         mFlA==
X-Gm-Message-State: AOAM533U9U/l+vN4SMmWa3V8kUxELQmGWI2ASYqpt2t7Y/ViaMPSFbvn
        v4jVoc2WKLd/u2iR+Ksq/9Xgdw==
X-Google-Smtp-Source: ABdhPJxASJgMCHSlaAT+jnWR7OEUQ6kVVPxeeJQfiNe4Wt79qgXR6a0wnra5Mhr9+Tx8zJpe57W47g==
X-Received: by 2002:a1c:2503:: with SMTP id l3mr4472344wml.188.1594132687466;
        Tue, 07 Jul 2020 07:38:07 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:38:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jaswinder Singh <jassisinghbrar@gmail.com>
Subject: [PATCH v2 14/28] ASoC: samsung: pcm: Demote half-documented kerneldoc header
Date:   Tue,  7 Jul 2020 15:37:28 +0100
Message-Id: <20200707143742.2959960-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ideally the author or someone 'in the know' should come back and
provide the remainder of the documentation.  Until the kerneldoc
checkers have been satisfied, let's just demote the header to a
standard comment block.

Fixes the following W=1 kernel build warning(s):

 sound/soc/samsung/pcm.c:127: warning: Function parameter or member 'lock' not described in 's3c_pcm_info'
 sound/soc/samsung/pcm.c:127: warning: Function parameter or member 'sclk_per_fs' not described in 's3c_pcm_info'
 sound/soc/samsung/pcm.c:127: warning: Function parameter or member 'idleclk' not described in 's3c_pcm_info'
 sound/soc/samsung/pcm.c:127: warning: Function parameter or member 'pclk' not described in 's3c_pcm_info'
 sound/soc/samsung/pcm.c:127: warning: Function parameter or member 'cclk' not described in 's3c_pcm_info'

Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Jaswinder Singh <jassisinghbrar@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/samsung/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index a5b1a12b34966..3116be4239f59 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -102,7 +102,7 @@
 #define S3C_PCM_FIFOSTAT_RXFIFOFULL		(0x1 << 1)
 #define S3C_PCM_FIFOSTAT_RXFIFOALMSTFULL	(0x1 << 0)
 
-/**
+/*
  * struct s3c_pcm_info - S3C PCM Controller information
  * @dev: The parent device passed to use from the probe.
  * @regs: The pointer to the device register block.
-- 
2.25.1

