Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2F4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFBD20738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="feeerbFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgGGOiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbgGGOiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:16 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A278CC08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:38:16 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so45372121wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GMUYidfrIwBoQwr04cGElMGH9ZhgIrwlDOw4is85pEg=;
        b=feeerbFqAir1V0Q6gG7sN9/sctNzOhjRzVnjuEbvAbmdsIlIDD56silJ+KDXeR/Jq9
         8jR1hCIT+WFN9UFvLDuUyUJVDogu1pHStNdyZIOThNEwp5zhx10W+YtTfYWblWhPARnL
         vxcY8UD8Q+wOuvAsctslvZW2g4yufz+FsjXe5lz5AoHEfe0v6Vl31z17ULBKIdl5VnHf
         NFgf6ZG9C6kQHLGTFIYhptX5/o/IQS3yshXcvSC0a+FjA1CKqyVJw4TBbqHn6BKNK8mC
         Nc9Jyj9vUMD7j4Z7Ve633OrgtQAlOJsmxJywmtvnOXIOpMCZR77AZYcVWKaZHTlUOxm+
         Iqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GMUYidfrIwBoQwr04cGElMGH9ZhgIrwlDOw4is85pEg=;
        b=W6CxDEDY9K9xG/2luPCSDajEzhwk5jQenP2eMHMUQkSDmCloltV5DZKkgm0Q/6pZZH
         wEM6gBVviJp5xmwaUWOIjCUv0ZRbWP9mgKKaRdoqXUE0MalviJNUYP2+r5ElZdslTZeC
         +F4DzGIFKhcchzQDpzGXDdqIlwKLiGk8FDsgyx50pcVstTe7W1b4xtIHVI2lc1FzCIxU
         Pr8+biGz2PO0XrNSrXih0CGUphpXiiavxoZH0uwcq0goqIh1Z/L1BVwGgx28yBoMF81C
         +U7D62F756LchD3/fiNwmSuLDZ8CrWo7NVR8SOML7BTNhQM9Hfu9nrh9vvNTEJophqVv
         iz0A==
X-Gm-Message-State: AOAM532+csaAURxWDGI1Ea/pbDytzpU4xoV2eOMKfiq9MDDDqIg54t1I
        sytIEy+SBcU8Ij9j5bpsvJ6U/Q==
X-Google-Smtp-Source: ABdhPJwecod/4foCMnzh1J6sMuZQ6V/g4S44h0ZZWS70jZc4P0QOoxlkw+3CGKD1KX4PYHqecVMChg==
X-Received: by 2002:adf:8444:: with SMTP id 62mr51773190wrf.278.1594132695426;
        Tue, 07 Jul 2020 07:38:15 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:38:14 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v2 20/28] ASoC: sti: uniperif: Mark 'uni_tdm_hw' as __maybe_unused
Date:   Tue,  7 Jul 2020 15:37:34 +0100
Message-Id: <20200707143742.2959960-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only 2 of the 3 source files which include this headerfile actually
reference 'uni_tdm_hw'.  The other source file 'sti_uniperif.c' sees
as it as being unused.  Mark it as __maybe_unused to show that this
behaviour is not only known, it's intentional.

Fixes the following W=1 kernel build warning(s):

 sound/soc/sti/uniperif.h:1351:38: warning: ‘uni_tdm_hw’ defined but not used [-Wunused-const-variable=]
 1351 | static const struct snd_pcm_hardware uni_tdm_hw = {
 | ^~~~~~~~~~

Cc: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/sti/uniperif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index 2dc2da5d458bd..e22d045d5cd99 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1348,7 +1348,7 @@ struct sti_uniperiph_data {
 	struct sti_uniperiph_dai dai_data;
 };
 
-static const struct snd_pcm_hardware uni_tdm_hw = {
+static const struct snd_pcm_hardware __maybe_unused uni_tdm_hw = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_MMAP |
 		SNDRV_PCM_INFO_MMAP_VALID,
-- 
2.25.1

