Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C7FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4982B20702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yhs6mPQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgGGKSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgGGKRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:17:07 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83F8C08C5DB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:17:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so44517923wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=joYuVrqjbvze3xQNhXb1qygj1A0MIp/q6w6MCrvUZ8U=;
        b=yhs6mPQq4PZeAt1M2EZMuLygavzZyEDV/c7Afv2xVs9/TugaazgwktDEldd7ZHl6jo
         5TSLozA1cPtC0mMfjSR+eEDDFqNoqdaIRYlcRwQyis654xVVugVaJ5/09fjtvF53qr3G
         AM71mfQpQPhABe8ZE/CSuJ/7yjxUd4EfLvizTrmuoLtXflMfxnEsww5Abej9dATeKPzk
         DCcxKFJ2krNUxMnnknHCRIUQMbynguHM9yiVaGT4YbXmFZxoaTGinJsTS2pn6w9dxE35
         wWajVTMatx/MEmzV/VNOHjxcWEmbTRuoAH82DfsBaLUVz/gI1cNQy4aav0LgjVDi2bPO
         +umA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=joYuVrqjbvze3xQNhXb1qygj1A0MIp/q6w6MCrvUZ8U=;
        b=FL+x14esxzQSRHe5NPHOC6PXKQIf5ix+qF24WuGW7Qu9pk4yyW/CCHlOPC7sMJtzi1
         x8jR5GsOqZQo+jfC9Z4VoMADAI2rtaRbGtQZB9g4XJhD12wpezjokLL8B2VsDoK4+fUl
         uw6qTDMCX8i9jj5/RoT0vEPkUGBM9uVMkbNDSMb5BZZ7MHBm9P8pqH7czLoSyiHWEIPZ
         ZOdagxyDURtGiXacId89T+9yhZnagwHP49Ou7KQ1gHh4o7Awir9DKJ2HMLa3mgqy81pW
         Nu+TsGH+5zQLMBu4Wd1/OBwvjvAbrQWgr/CymI5kiGgepwQwg72uLzoNff5iHmOW+U76
         FR/Q==
X-Gm-Message-State: AOAM531frEumjEm0YflhH0/Wt8BFqAIgV4ofz8d8FUD6nJdoM0Oz33Rs
        Y1QFfKI6KbCHsK4ivIiLWwii1w==
X-Google-Smtp-Source: ABdhPJxG99p5QaqaNYLPvj7Abir3MWTHXEmvxOPLyB5aXcDmjbSSvCDpahka5msO5NNg5NwWh6HBEg==
X-Received: by 2002:a5d:484b:: with SMTP id n11mr50993892wrs.320.1594117025590;
        Tue, 07 Jul 2020 03:17:05 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:17:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jaswinder Singh <jassisinghbrar@gmail.com>
Subject: [PATCH 14/28] ASoC: samsung: pcm: Demote half-documented kerneldoc header
Date:   Tue,  7 Jul 2020 11:16:28 +0100
Message-Id: <20200707101642.1747944-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
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

