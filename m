Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993F3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D4962073E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XXmCFCqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgGGOhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgGGOhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:37:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA57AC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:37:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z15so34118929wrl.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Ojcexqfn/ZS3noXIMdqlD9+JbA+cGF+iBmDVVcfGM0=;
        b=XXmCFCqQ7/7qI24vHpYIeRwak6no+ngDN4qxhtx2B+ciF+xekdDDosz8fuWrt1r7Hu
         SGxtSTZbjq7aFHyn1q3uOMUtuTvj5pzK+miMZjM6zYEALDDu+EV/+0HVBzbAsGhcej/8
         GhiBeAzCFt848KYViMxL9IaPiARSHzpUEmYwvKvqRDlHvNuYou9kQvS7JUTFrpeylQdn
         ovTftEAwgfH2tXOQOYkfUfLQOYu4j/oCtF8h1KTHKgCr+aybzMwet4dozFF+jypqljGP
         86/kp70dU8LvS5YTSIJ3e6T6VbpWEvZPkEhUGDabaYF1sELRkcxNFdq8rBl6tJ1AKOqS
         /NEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Ojcexqfn/ZS3noXIMdqlD9+JbA+cGF+iBmDVVcfGM0=;
        b=qz9Xaxgu1yoWR/1I+9R7cpdSTy1MXpIEwYwSuMdIpUwHw5KzrfRQzwq3TiCo7zHK/4
         B07Z0aHLy+JXKJjYYqOqYXIeJI/KvnraP14ttjzU0P3241wqYjq61Ft41Dgkw2ZkjMNs
         Z1XZhJ6Ry6f1PUe6VQhzLzudBPxR+3Y3kFG0p7UBNgNlPJdotDBjuXDtRwZq9HoZdNLk
         m1MVI1ACDjitO1tQZ3bXeSAt6psNBk66h+iERnON8mdaf9uE4aji1+YuYb11MFTrnNlZ
         C/rKAKeq5+nOEEweCUg2xSPmvJpqpUYzjh2kuJNje/zQL2vItrdriJtNyT7lwksN5I9w
         OlbA==
X-Gm-Message-State: AOAM533xdkuq+2y9P+O2WtzSDoRbZ5IHSiSiQZI/HNGa08ZjQGsLrebJ
        kCzsT9U5y6fonkCyDo44KaTTyQ==
X-Google-Smtp-Source: ABdhPJx0KvnunMH4xk0hxU1AAKtAAjTTj1cxtsLaXSEvWPc8oupZRfIVKuJnEp7OVTzb9qi611+2bg==
X-Received: by 2002:a5d:6990:: with SMTP id g16mr45393223wru.131.1594132668511;
        Tue, 07 Jul 2020 07:37:48 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:37:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Sedji Gaouaou <sedji.gaouaou@atmel.com>,
        Frank Mandarino <fmandarino@endrelia.com>
Subject: [PATCH v2 02/28] ASoC: atmel: atmel_ssc_dai: Demote function header which is clearly not kerneldoc
Date:   Tue,  7 Jul 2020 15:37:16 +0100
Message-Id: <20200707143742.2959960-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document the demoted function here.

Fixes the following W=1 kernel build warning(s):

 sound/soc/atmel/atmel_ssc_dai.c:892: warning: Function parameter or member 'ssc_id' not described in 'atmel_ssc_set_audio'

Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: Frank Mandarino <fmandarino@endrelia.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/atmel/atmel_ssc_dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 0f18dfb85bfed..3a0335864034a 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -885,7 +885,7 @@ static int asoc_ssc_init(struct device *dev)
 	return 0;
 }
 
-/**
+/*
  * atmel_ssc_set_audio - Allocate the specified SSC for audio use.
  */
 int atmel_ssc_set_audio(int ssc_id)
-- 
2.25.1

