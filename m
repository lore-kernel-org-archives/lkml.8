Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DBEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EE092082F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4icUTAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgGGOiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbgGGOiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17A0C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:38:02 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z15so34119870wrl.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YsokizqvcQrYmRK4XFUw9AfpZPmtx9CnTkzjsD5Kh2w=;
        b=U4icUTAip9+fVemfIStmlUm+NwJ6HLWkl2RVpVYHUx/CKlpWCnzwXVC3CzO6ZJxzhS
         2A1u3oeiQiRbLQzl0ReMEMvLcVbjfBld3DOsbinq/HDwtkUHvTpoWwmwIW3JsgEKydrN
         sT3Mcd7tmzyJB7ZIkVdXvVfah2S5RNbEIcqZBCMnb6IrgPpJML1ZcTZMJjZpFjGT9bwX
         KFw/rVo796NGAFlBcF22gotYI6DwHJNR9jKSzyYFD5cOe2ZDQ9Y6jIASEoBUkL5rLH3v
         YxlY2MQtb7I3y0oBmo4AzeIL57N0+DjNcvsd9DRoEZo+/djPEr+HoSNOmqkrC0YQRMhu
         DvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YsokizqvcQrYmRK4XFUw9AfpZPmtx9CnTkzjsD5Kh2w=;
        b=PQe5Y/UEy8oEdsMwHjhz+FIzaelaXmGv5YsuSUkzAyWrdmSfskURQNqAPaTOTzbCEf
         FVzhzBBL62EzU1TbzfavpynASOROFU45k2IGhWx4Xtr7DsQ+kyReiHEE54HzVPbD1Lot
         mdtO6Rts+W4mC5Nank9+CT3ONsO+UPeX6lYXfxufFIIB6t6L/0kAAsS/awnC/S/s4PmP
         c00zKOypRRaoG4fFbrtUvOhUlW4vh2VwzFIyCRJ/V7zkEhtjZ96Rsms4JMj0hzYT/opF
         uXOM+UR4Znl/i8lSscn4zoIYirWBsGrmjaue1XzA8JmErPVmYyE4HfVkmq0QfM1BZ9xv
         kcLA==
X-Gm-Message-State: AOAM531T0zpPkcyG0yRRnhjWXrC9JVyhXY+LrWt0GtLw24PnERTYPlVx
        6RlpyRV9csssDANc3tN2G243GQ==
X-Google-Smtp-Source: ABdhPJyQQtUDPp475nOrZE1vXhOfcyykGtayzQzLC4nanwruesoW0y74DEzt0XwmDnl//B05KWRVDw==
X-Received: by 2002:a5d:6990:: with SMTP id g16mr45394243wru.131.1594132681537;
        Tue, 07 Jul 2020 07:38:01 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:38:01 -0700 (PDT)
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
Subject: [PATCH v2 09/28] ASoC: fsl: fsl_esai: Fix a bunch of kerneldoc issues
Date:   Tue,  7 Jul 2020 15:37:23 +0100
Message-Id: <20200707143742.2959960-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Struct headers require a 'struct $NAME' title, all function parameters
require a description and need to be in the format '@.*:', else the
checker gets confused.  Also demote one kerneldoc header where no effort
was made to document any of the function's params.

Fixes the following W=1 kernel build warning(s):

 sound/soc/fsl/fsl_esai.c:30: warning: cannot understand function prototype: 'struct fsl_esai_soc_data '
 sound/soc/fsl/fsl_esai.c:61: warning: cannot understand function prototype: 'struct fsl_esai '
 sound/soc/fsl/fsl_esai.c:170: warning: Function parameter or member 'dai' not described in 'fsl_esai_divisor_cal'
 sound/soc/fsl/fsl_esai.c:265: warning: Function parameter or member 'dai' not described in 'fsl_esai_set_dai_sysclk'
 sound/soc/fsl/fsl_esai.c:265: warning: Function parameter or member 'clk_id' not described in 'fsl_esai_set_dai_sysclk'
 sound/soc/fsl/fsl_esai.c:265: warning: Function parameter or member 'freq' not described in 'fsl_esai_set_dai_sysclk'
 sound/soc/fsl/fsl_esai.c:265: warning: Function parameter or member 'dir' not described in 'fsl_esai_set_dai_sysclk'
 sound/soc/fsl/fsl_esai.c:265: warning: Excess function parameter 'Parameters' description in 'fsl_esai_set_dai_sysclk'
 sound/soc/fsl/fsl_esai.c:364: warning: Function parameter or member 'dai' not described in 'fsl_esai_set_bclk'
 sound/soc/fsl/fsl_esai.c:364: warning: Function parameter or member 'tx' not described in 'fsl_esai_set_bclk'
 sound/soc/fsl/fsl_esai.c:364: warning: Function parameter or member 'freq' not described in 'fsl_esai_set_bclk'

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/fsl/fsl_esai.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index cbcb70d6f8c83..bb3c405df623c 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -22,7 +22,7 @@
 				SNDRV_PCM_FMTBIT_S24_LE)
 
 /**
- * fsl_esai_soc_data: soc specific data
+ * struct fsl_esai_soc_data - soc specific data
  *
  * @imx: for imx platform
  * @reset_at_xrun: flags for enable reset operaton
@@ -33,7 +33,7 @@ struct fsl_esai_soc_data {
 };
 
 /**
- * fsl_esai: ESAI private data
+ * struct fsl_esai - ESAI private data
  *
  * @dma_params_rx: DMA parameters for receive channel
  * @dma_params_tx: DMA parameters for transmit channel
@@ -160,10 +160,11 @@ static irqreturn_t esai_isr(int irq, void *devid)
  * This function is used to calculate the divisors of psr, pm, fp and it is
  * supposed to be called in set_dai_sysclk() and set_bclk().
  *
+ * @dai: SoC DAI
+ * @tx: current setting is for playback or capture
  * @ratio: desired overall ratio for the paticipating dividers
  * @usefp: for HCK setting, there is no need to set fp divider
  * @fp: bypass other dividers by setting fp directly if fp != 0
- * @tx: current setting is for playback or capture
  */
 static int fsl_esai_divisor_cal(struct snd_soc_dai *dai, bool tx, u32 ratio,
 				bool usefp, u32 fp)
@@ -252,11 +253,11 @@ static int fsl_esai_divisor_cal(struct snd_soc_dai *dai, bool tx, u32 ratio,
 /**
  * This function mainly configures the clock frequency of MCLK (HCKT/HCKR)
  *
- * @Parameters:
- * clk_id: The clock source of HCKT/HCKR
+ * @dai: SoC DAI
+ * @clk_id: The clock source of HCKT/HCKR
  *	  (Input from outside; output from inside, FSYS or EXTAL)
- * freq: The required clock rate of HCKT/HCKR
- * dir: The clock direction of HCKT/HCKR
+ * @freq: The required clock rate of HCKT/HCKR
+ * @dir: The clock direction of HCKT/HCKR
  *
  * Note: If the direction is input, we do not care about clk_id.
  */
@@ -357,7 +358,7 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 	return 0;
 }
 
-/**
+/*
  * This function configures the related dividers according to the bclk rate
  */
 static int fsl_esai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
-- 
2.25.1

