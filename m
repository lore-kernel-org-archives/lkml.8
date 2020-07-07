Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F14C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB36206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LCQfc/e5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgGGKSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgGGKRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:17:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BA9C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:17:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q15so42683408wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GMUYidfrIwBoQwr04cGElMGH9ZhgIrwlDOw4is85pEg=;
        b=LCQfc/e5ty78KnRBAWkN5lY+b68RFMYCz8nZm/KdhRS9l+QtjMn+DGKkzXQpAfRwuD
         n8dndQB0ha994npwPP+9EdI4y10eYHeLl7rqUAivaYJyPvaYJ5ovzn9eJrfwLoqCqK4D
         X1AiU35rKsZhW8y7U7JVvYJ3Hdc6bOWnrjH3pdc0D7QzdCRmlTGMuowrhG6zEB0mjcko
         uRbhznr83cxoJYNTTqCOsMg7hp/Eqo6YLYBOePqhVcVBAlo/BOJld4J9auQWVMDG2fff
         aH0a3GrNPvm2pIMPUemmoUKXAZVmeTlnqbZWMT93sJR7zuapWpadYGEV9ssJwOGmt31Q
         jRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GMUYidfrIwBoQwr04cGElMGH9ZhgIrwlDOw4is85pEg=;
        b=SdAGncx9mgJqOAIa3bnr1vLfbdSTZ+o4ohYyFNSqHjiX0mHW+Z+7Nh4HTHGbnNn7k+
         yPaJ4nTksDefNUG/PiPUexN7g9PXd4/RT+OPSX01kFOE9PbObJtBEkYRyDOlSqwTpTzB
         zDwgZ5AcmmxNjXLs+OxkCBiu9CBgEqIb5sdGE/DPCfYr7kC9yQioWaUPyJm3FfJKuBoX
         4MFqXOLZ0w2Jia9lQn9Kd3GcA6mRQ8HvXgEC8WRNbnahH+iScnBw4Tdt0bm/PY19ixys
         oNVM5WHsMfibwGiEaTaU+v3phUUrNfDvLKI00clxnhMEmBcCOWShW0K9FaR/AyzHdUdg
         T8Wg==
X-Gm-Message-State: AOAM532gbvOn8mXiG07lPN0DPzLCOQwmNXLXLDG6we4qGPmmbCMCrIOc
        9HwwQTX4PUBb4dJpdxmmeDe0uA==
X-Google-Smtp-Source: ABdhPJy3UpRnh1pbIW5TM69XcTo8ALmp1/bv7rxoyf8ZQ1E28518TJ8Xw2HwfBX5mnOEi/HYkpRqNA==
X-Received: by 2002:a7b:cbcb:: with SMTP id n11mr3217967wmi.99.1594117032905;
        Tue, 07 Jul 2020 03:17:12 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:17:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 20/28] ASoC: sti: uniperif: Mark 'uni_tdm_hw' as __maybe_unused
Date:   Tue,  7 Jul 2020 11:16:34 +0100
Message-Id: <20200707101642.1747944-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
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

