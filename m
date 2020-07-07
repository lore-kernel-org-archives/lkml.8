Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96E1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 887D820738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QsQNaqhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgGGKSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbgGGKRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:17:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0D1C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:17:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so45914982wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+qKCC8gwbOOqZ6yEPkGSkmGeka7mYOZ7iXEWMftP650=;
        b=QsQNaqhxkVtL41tk1/qoGhyCm7rVJ4vpnlgVliFcwROlzr/daTSEoku3cq8UN82fQX
         IFbaFWVeeLZZcbS0019ujgPja2Nu5gkt/1krAFAUnVatnIx3B91JzL5kGlJDfics0Pav
         uL9Yr8HgEPEpP24WORMxYPT+RLeq0riRndWjJeO/uU4y0oO+r4jt9Ig0R0Pk8DMQcv7z
         rp4u8MT93nqSXy9KYnhrdA+GBJiH2sAaOi/Dy/QKPlv0PunseCYqkvxjRt83mLjFcW6Z
         alULEaJtZv8pRcmMemxrm7hMHD0NKnLzelBD/xb4HTuKiZ/wncZ/jnlVrwAmV3VlLCjX
         FiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+qKCC8gwbOOqZ6yEPkGSkmGeka7mYOZ7iXEWMftP650=;
        b=Y0iJxSCXL0M2hr9HBfFr8OQeC8fbGnPvkxZFlEOcem+C6NVbRwpf2b4F54lsHpVMaI
         a0/dUerJSmhSO4lC/JKUXqqWVlDZx1lQDtgCYmwaa/WkAPTalDtvTvxs/POtqZVawArB
         taBF2LJ/Ge6deCXWmwjTM62SxMOZn/nv+zORdC37dRUI+aa49DiH0WosXsNA5Abra9+n
         5GDCmUbOsxWCfARTS+tPU20FfOdaQY/6c4wg4yC27ZRGinh/agAP6tn3I7CSLZxDr6vP
         oLNF6Yn55vgSHfn42LECtoWtdw3et7rSqfbovXujb4ZDn3tH8rdzjM/aplOe5OnqF1zo
         1cmw==
X-Gm-Message-State: AOAM531aUZps31P+G+zp9wOwZ431ZBcv+oN/Xxewtm5xuzkzLQiPrHth
        HEbf1leJ4E+tGiW+pTsj1VR7GQ==
X-Google-Smtp-Source: ABdhPJx1ZbuUA9wWKqxxF1IHrewdkfGEfSuRE8l+gQGgDf17uueoN0ReeFhO3RmeiPsig4/tbI5/XQ==
X-Received: by 2002:a1c:e143:: with SMTP id y64mr3375157wmg.90.1594117023297;
        Tue, 07 Jul 2020 03:17:03 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:17:02 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>,
        Mihai Serban <mihai.serban@nxp.com>
Subject: [PATCH 12/28] ASoC: codecs: ak4458: Remove set but never checked variable 'ret'
Date:   Tue,  7 Jul 2020 11:16:26 +0100
Message-Id: <20200707101642.1747944-13-lee.jones@linaro.org>
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

Looks as though the result of snd_soc_update_bits() has never been checked.

Fixes the following W=1 kernel build warning(s):

 sound/soc/codecs/ak4458.c: In function ‘ak4458_set_dai_mute’:
 sound/soc/codecs/ak4458.c:408:16: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
Cc: Mihai Serban <mihai.serban@nxp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/codecs/ak4458.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index f180cb5dfe4f1..39ae089dcd1d8 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -405,7 +405,7 @@ static int ak4458_set_dai_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_component *component = dai->component;
 	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
-	int nfs, ndt, ret, reg;
+	int nfs, ndt, reg;
 	int ats;
 
 	nfs = ak4458->fs;
@@ -416,14 +416,14 @@ static int ak4458_set_dai_mute(struct snd_soc_dai *dai, int mute)
 	ndt = att_speed[ats] / (nfs / 1000);
 
 	if (mute) {
-		ret = snd_soc_component_update_bits(component, AK4458_01_CONTROL2,  0x01, 1);
+		snd_soc_component_update_bits(component, AK4458_01_CONTROL2,  0x01, 1);
 		mdelay(ndt);
 		if (ak4458->mute_gpiod)
 			gpiod_set_value_cansleep(ak4458->mute_gpiod, 1);
 	} else {
 		if (ak4458->mute_gpiod)
 			gpiod_set_value_cansleep(ak4458->mute_gpiod, 0);
-		ret = snd_soc_component_update_bits(component, AK4458_01_CONTROL2, 0x01, 0);
+		snd_soc_component_update_bits(component, AK4458_01_CONTROL2, 0x01, 0);
 		mdelay(ndt);
 	}
 
-- 
2.25.1

