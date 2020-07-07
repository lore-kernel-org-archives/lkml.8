Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF9EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 771F320773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fOdzTEcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgGGOhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGOhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:37:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD683C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:37:50 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so43521736wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KDb2cHewYsZWIM9X5BweTMn+o+Wme2rV/mNBj7f6Kc0=;
        b=fOdzTEcfqDWXHHGsK3RSk6klgVeOq4kKl1yqa8GPt8rsKxfPxvACiPgftfArSdTfkn
         +bQP4l0HPEwtB2OpMJKUC/eVmcBLrAEqMXMmhXguk81lmiE8Y52qpuOWTZsCHqU7hg7w
         mZFrHdufwhigmefa9nvoXDFxevuX0x3LowKfRY2BwYO3xmos96rbsa3JWfwZj03d9zhO
         3WB9PjUPT/yWwNWC4Tb0zonDWluOEIN5raUub5n3CcGXhPTUBpA1xb8+4p5wOKWpGZBO
         Rh+Arwk0kubZqjIDBZJbBFATGww6GSpX81zAvCfNfFEq2bSBtDks044WHz4zpeln4+mm
         C7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KDb2cHewYsZWIM9X5BweTMn+o+Wme2rV/mNBj7f6Kc0=;
        b=m/Kbmemi86S/Z8gGUt249oQBPASbwiD4zfAmHH2tReAR1yeFZkBZtIJp7KEeJefkvB
         qkB96OuO8bUUVJL+5QhpWZfe3XTlOihXLgrVYQK+JKcBrgJwd1ti/fGF+g5G9lvQTFx0
         +JbNV+h3be6baPNID8cVPT2/Yi02EW3OoTk89O1DRdoFFcQD6feACF4n/+ZLwcL/0E+D
         +G7wCSnE9m72mzR84K1rgKWw5OZtf+9ttFXU95OmiZUB55bKtfFLR9dPPdTsYYMR8CsV
         pHr080C9iCOi+rcrdRDlA2JmDBgo3kJiMI63AYTo8tvagR+t8SL7/Cyyd7REh1zM+dQP
         mvww==
X-Gm-Message-State: AOAM531/c9QiDlePx7PUzCS7OxNIqk+YwW9QW8JMAYB4t61oaFgqm5h9
        Xux5Je+l5jd0cPn4PsLgb5XpBw==
X-Google-Smtp-Source: ABdhPJzv0lUCdAZV7Tzonh9ODAAoKJ3ODB1Ka6SB0h4CZrG5qt7dZrtoXm09LT11yngBdC4AIyvYEw==
X-Received: by 2002:a7b:c394:: with SMTP id s20mr4794988wmj.31.1594132669656;
        Tue, 07 Jul 2020 07:37:49 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:37:49 -0700 (PDT)
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
Subject: [PATCH v2 03/28] ASoC: fsl: fsl-asoc-card: Use correct format when providing struct documentation
Date:   Tue,  7 Jul 2020 15:37:17 +0100
Message-Id: <20200707143742.2959960-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
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

