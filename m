Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F906C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C99520720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KWAySNzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgGGKQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgGGKQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:16:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1D4C08C5DB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:16:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f18so36484888wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KDb2cHewYsZWIM9X5BweTMn+o+Wme2rV/mNBj7f6Kc0=;
        b=KWAySNzyfzgA6L35OqDEdMfxyRW6P5mNQ/VoKFi3SPOGxlROBgL/6G+0MYrllTvY+U
         CwdWcR0JaSnDwr0jP1J9a/WGbXKdNpkAw4F9cqrIhLwhxLXc/QuvLC/+rCJ95WSCocwi
         5u8Ofosz9530ws8xxT5Le5pgKaBsFBSqXZ4KnG9+ar+gJv8obmLu8DxsTKzFLZhfNu6X
         xSbgp8e/buyq7tf5WVYb6aqlEwHk3L1kA1BS0Ar0tAd3bhnm1DgmIL/fQUYbIL0Kz56v
         HRbSh3uo5DzQiBe0Cs6+GdH1OK9V/sDl1+PEBHLNW8xOmIZjYUq36JRRw1Zo5Z5+Q1ld
         P1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KDb2cHewYsZWIM9X5BweTMn+o+Wme2rV/mNBj7f6Kc0=;
        b=bPaw5gitkPI1bn4SrpnB9Tv6CL+ShoRAf1PZfjqHlqNOMuaZNztH8qpmOSX3gHjgRY
         uYZzBYmeydgwFtvOpc+ECzHBzIGy+ybaVv7nnV/YozYZqy+m4bCWs69L1hBa0cuTLGNj
         SP3FN0mrBUGstHFNMXMD9n5slpsrEA8MsR3jLUFmcaxELRSnCTeiIlAwRfhJWKCGo56X
         Fp3jIQ0LbfrwVJYr3AqvNtVl1Fo+FQYM1isOvyTvb5HzKR59xNHRkakYUaBFDiQiWe2x
         DZ8/F12u0Pn9LscLLGfNEMErYP/i1qxR6kFWOFvSdDYMqwbBFMilPjvzW3flu2nrNGYA
         qxBA==
X-Gm-Message-State: AOAM530QC7zUbPI5dbWwEugVl7+u7dwCNoZPVI5nda5DBMJBb75IxGkf
        XlLqhdO9iddnLE4SPlw40cxZ1Q==
X-Google-Smtp-Source: ABdhPJyuLSFDg+DgyQWYS0Sp/uZ2Uz32rktUaElyVytRNJtrr6b4EIZCqaiZhAvG7a8BZrItq4OaWA==
X-Received: by 2002:a5d:69c5:: with SMTP id s5mr53007426wrw.197.1594117011646;
        Tue, 07 Jul 2020 03:16:51 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:16:51 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/28] ASoC: fsl: fsl-asoc-card: Use correct format when providing struct documentation
Date:   Tue,  7 Jul 2020 11:16:17 +0100
Message-Id: <20200707101642.1747944-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Struct kerneldoc headers need to be prefixed with 'struct $NAME', else
the checker gets confused.

Fixes the following W=1 kernel build warning(s):

 sound/soc/fsl/fsl-asoc-card.c:43: warning: cannot understand function prototype: 'struct codec_priv '
 sound/soc/fsl/fsl-asoc-card.c:60: warning: cannot understand function prototype: 'struct cpu_priv '
 sound/soc/fsl/fsl-asoc-card.c:83: warning: cannot understand function prototype: 'struct fsl_asoc_card_priv '
 sound/soc/fsl/fsl-asoc-card.c:104: warning: cannot understand function prototype: 'const struct snd_soc_dapm_route audio_map[] = '

Also the size of the struct does not belong in the description:

 sound/soc/fsl/fsl-asoc-card.c:65: warning: Function parameter or member 'sysclk_freq' not described in 'cpu_priv'
 sound/soc/fsl/fsl-asoc-card.c:65: warning: Function parameter or member 'sysclk_dir' not described in 'cpu_priv'
 sound/soc/fsl/fsl-asoc-card.c:65: warning: Function parameter or member 'sysclk_id' not described in 'cpu_priv'
 sound/soc/fsl/fsl-asoc-card.c:95: warning: Function parameter or member 'dai_link' not described in 'fsl_asoc_card_priv'

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 57ea1b072326b..3b1fd8c9316d8 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -33,7 +33,7 @@
 #define DAI_FMT_BASE (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF)
 
 /**
- * CODEC private data
+ * struct codec_priv - CODEC private data
  *
  * @mclk_freq: Clock rate of MCLK
  * @mclk_id: MCLK (or main clock) id for set_sysclk()
@@ -48,11 +48,11 @@ struct codec_priv {
 };
 
 /**
- * CPU private data
+ * struct cpu_priv - CPU private data
  *
- * @sysclk_freq[2]: SYSCLK rates for set_sysclk()
- * @sysclk_dir[2]: SYSCLK directions for set_sysclk()
- * @sysclk_id[2]: SYSCLK ids for set_sysclk()
+ * @sysclk_freq: SYSCLK rates for set_sysclk()
+ * @sysclk_dir: SYSCLK directions for set_sysclk()
+ * @sysclk_id: SYSCLK ids for set_sysclk()
  * @slot_width: Slot width of each frame
  *
  * Note: [1] for tx and [0] for rx
@@ -65,9 +65,9 @@ struct cpu_priv {
 };
 
 /**
- * Freescale Generic ASOC card private data
+ * struct fsl_asoc_card_priv - Freescale Generic ASOC card private data
  *
- * @dai_link[3]: DAI link structure including normal one and DPCM link
+ * @dai_link: DAI link structure including normal one and DPCM link
  * @pdev: platform device pointer
  * @codec_priv: CODEC private data
  * @cpu_priv: CPU private data
@@ -94,7 +94,7 @@ struct fsl_asoc_card_priv {
 	char name[32];
 };
 
-/**
+/*
  * This dapm route map exsits for DPCM link only.
  * The other routes shall go through Device Tree.
  *
-- 
2.25.1

