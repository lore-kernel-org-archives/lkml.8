Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926C2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67E99206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QoVnhhkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgGGKSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgGGKRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:17:19 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA26BC08C5DB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:17:18 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k6so44564617wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c4/atXJGhj1n0uTQI5cYV/gQNs+sjaOZMgJsAAMgfWA=;
        b=QoVnhhknZYVxWfl9mcL1Hgta3/3Af8FucpK51zcYOzuI1LPngqjVM8rBVmQqjLgh7E
         1Uw5NQ/B6U3SUgvxl1hiVmj1hwCKO9EaY5U/DRBIuNUsVN/pN8KwuthGGhnUKBnKlSQB
         a4d7SMY6AFyJbq8ZR4ADQrnNHzUMD5ziAGLPIcECCntkWmbzjXnZofBCZFbWuKIPcqcC
         wAZxm9Rtksb3/dunSciAduuH/UVb0HHOL8I3Rsr26SmQn3plTAqH/gh7J1xC4qLizdp6
         nnU60q8xCFLFZxL4M3qkB9cNqUBR/rnNppyXEvYp/IwKxkobwyQx6HJWu9+ptWGyT82Y
         JKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c4/atXJGhj1n0uTQI5cYV/gQNs+sjaOZMgJsAAMgfWA=;
        b=NllQTsJFU3aOpNpa0WsPgm4V7kwXlsWLApNpLo2S9R0w0+fNgCUU+o8lYVohjilNHW
         Y4afYS6rh6w3IFyZ0AQ5wxYtif/uIzFD5cHOCWZ1JUozxovIKeN1UXeOBZbnKamjc9Kb
         hRXbffOdokFHLJWnQehCG/AIwh6VYgfyUnWZLaFkvqCRTjtmfcBYjscbgZrq1AX1aFoO
         DAyj9Qht6rX43YoF6pwBpYpIKcGIKzODN7j3RUyXrrFoGddIzBxCx6fc5Ua/a42ndR5v
         L8dqn6Gx0oceHIGUavK5INY1btjaOMJ2WylXgudfHUM9LNb5ah8TrjsABF10aGESRJjQ
         bRfw==
X-Gm-Message-State: AOAM533VepPvbttDtj3w4QVBxMpHgZChyH6dpPtYIgsm8hfdYjXwFn7h
        woxjVObtA0m+0iJ1axI5BJPJBQ==
X-Google-Smtp-Source: ABdhPJw9oo8pfsuehCGY22+GnK13HnMCljfQRckQGf4lIiSb36XKwJQOyruMnCDQuGqbsropcrAgFw==
X-Received: by 2002:adf:e60e:: with SMTP id p14mr51698572wrm.31.1594117037406;
        Tue, 07 Jul 2020 03:17:17 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:17:16 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        ter Huurne <maarten@treewalker.org>
Subject: [PATCH 24/28] ASoC: codecs: jz4770: Remove defined but never used variable 'mic_boost_tlv'
Date:   Tue,  7 Jul 2020 11:16:38 +0100
Message-Id: <20200707101642.1747944-25-lee.jones@linaro.org>
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

Fixes the following W=1 kernel build warning(s):

 In file included from include/sound/tlv.h:10,
 from sound/soc/codecs/jz4770.c:19:
 sound/soc/codecs/jz4770.c:306:35: warning: ‘mic_boost_tlv’ defined but not used [-Wunused-const-variable=]
 306 | static const DECLARE_TLV_DB_SCALE(mic_boost_tlv, 0, 400, 0);
 | ^~~~~~~~~~~~~
 include/uapi/sound/tlv.h:64:15: note: in definition of macro ‘SNDRV_CTL_TLVD_DECLARE_DB_SCALE’
 64 | unsigned int name[] = { | ^~~~
 sound/soc/codecs/jz4770.c:306:14: note: in expansion of macro ‘DECLARE_TLV_DB_SCALE’
 306 | static const DECLARE_TLV_DB_SCALE(mic_boost_tlv, 0, 400, 0);
 | ^~~~~~~~~~~~~~~~~~~~

Cc: Paul Cercueil <paul@crapouillou.net>
Cc: ter Huurne <maarten@treewalker.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/codecs/jz4770.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/jz4770.c b/sound/soc/codecs/jz4770.c
index 34775aa624024..4dee585761c24 100644
--- a/sound/soc/codecs/jz4770.c
+++ b/sound/soc/codecs/jz4770.c
@@ -303,7 +303,6 @@ static int jz4770_codec_digital_mute(struct snd_soc_dai *dai, int mute)
 static const DECLARE_TLV_DB_MINMAX_MUTE(dac_tlv, -3100, 0);
 static const DECLARE_TLV_DB_SCALE(adc_tlv, 0, 100, 0);
 static const DECLARE_TLV_DB_MINMAX(out_tlv, -2500, 600);
-static const DECLARE_TLV_DB_SCALE(mic_boost_tlv, 0, 400, 0);
 static const DECLARE_TLV_DB_SCALE(linein_tlv, -2500, 100, 0);
 
 /* Unconditional controls. */
-- 
2.25.1

