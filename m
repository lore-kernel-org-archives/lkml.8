Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CA1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C2720786
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8UZedaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgGGOhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgGGOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:37:52 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AA9C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:37:52 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l17so43539442wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WA9dG36UknQVCp/Rfsks+W3xsfkt4WlYU9zyAfbsCgQ=;
        b=e8UZedaLC/b7LICkDSQc2DDmIu2zA5B7w9bun1l9DVnAJtIVMl/823pw/IseRZm8Lf
         9d4IjtTJfah6OY8MykIHz2YrsaRApIraOX7TdG2d8hbZhJ+PZnADf45ZU7yBS5dwNOmH
         TuITPaHJpZuLam+omGcBbi7cG6g37+9aI9i3HNWXlYIgEmdzX3wPYI8yFS6XPAngLrwy
         CVO5ycmhUfRUnC8i0StYi7v6fuPuqMU7CtD1W8IYk6Pn2UoAFNAphetI9euRPJdy3D0M
         cDJTbtWEPbg+E65BTnqBfEY3kYYDECSWO8pCXjmJzhYt1ZNKTJ9prlXAjN9wFHrLhkQ+
         EUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WA9dG36UknQVCp/Rfsks+W3xsfkt4WlYU9zyAfbsCgQ=;
        b=ulMK43JGREuZLqc4AZ1IxpypMV32XlxqAW8QyOd3oH+vJ4rS1x2zUs0h9q+MFVWbOF
         9a7zTjojRTaF0RqK9a1xmR9Ni0apen5LpOsGQZD0q9gESvgKr9VpbxAU+3PTwv253Xv5
         b3nCJgFOlrtSDXsDKo7W1BEY+uEYKaQmUxFS6agUT+/6VAuaVnzURtjj+TaVLXIwH22o
         wzNSqcS3JjC5VnfsMw8oOFPlhGbOpOwxbRNrfbJGyiFNBOdYgK8yIkL9LXrhTx5t7vvu
         oJPoUYXtSW58dHuF/H26BY8Rf5QCw/gVOBa6RQ058xXNl/tczKZJcZP+nS0nGn94OakB
         jdGw==
X-Gm-Message-State: AOAM531yGqIFqmMNIJyJlKF9rCs326f1VNtUJR6x1NeCMWLqBfhU2P6T
        maysVUBW9WcCvUE+r/YVh7Rmtg==
X-Google-Smtp-Source: ABdhPJz0hM/mZ52e8GW2OdluzvMHfohOQqKcuaIX2M8lgi/HJbk9NYK0v9wDJlnCtP947+e55/mAHQ==
X-Received: by 2002:a1c:2503:: with SMTP id l3mr4470950wml.188.1594132670740;
        Tue, 07 Jul 2020 07:37:50 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:37:50 -0700 (PDT)
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
Subject: [PATCH v2 04/28] ASoC: fsl: fsl_asrc: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Tue,  7 Jul 2020 15:37:18 +0100
Message-Id: <20200707143742.2959960-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document any of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 sound/soc/fsl/fsl_asrc.c:44: warning: cannot understand function prototype: 'unsigned char input_clk_map_imx35[ASRC_CLK_MAP_LEN] = '
 sound/soc/fsl/fsl_asrc.c:78: warning: cannot understand function prototype: 'unsigned char clk_map_imx8qm[2][ASRC_CLK_MAP_LEN] = '
 sound/soc/fsl/fsl_asrc.c:118: warning: Function parameter or member 'inrate' not described in 'fsl_asrc_sel_proc'
 sound/soc/fsl/fsl_asrc.c:118: warning: Function parameter or member 'outrate' not described in 'fsl_asrc_sel_proc'
 sound/soc/fsl/fsl_asrc.c:118: warning: Function parameter or member 'pre_proc' not described in 'fsl_asrc_sel_proc'
 sound/soc/fsl/fsl_asrc.c:118: warning: Function parameter or member 'post_proc' not described in 'fsl_asrc_sel_proc'
 sound/soc/fsl/fsl_asrc.c:158: warning: Function parameter or member 'channels' not described in 'fsl_asrc_request_pair'
 sound/soc/fsl/fsl_asrc.c:158: warning: Function parameter or member 'pair' not described in 'fsl_asrc_request_pair'
 sound/soc/fsl/fsl_asrc.c:201: warning: Function parameter or member 'pair' not described in 'fsl_asrc_release_pair'
 sound/soc/fsl/fsl_asrc.c:223: warning: Function parameter or member 'pair' not described in 'fsl_asrc_set_watermarks'
 sound/soc/fsl/fsl_asrc.c:223: warning: Function parameter or member 'in' not described in 'fsl_asrc_set_watermarks'
 sound/soc/fsl/fsl_asrc.c:223: warning: Function parameter or member 'out' not described in 'fsl_asrc_set_watermarks'
 sound/soc/fsl/fsl_asrc.c:242: warning: Function parameter or member 'pair' not described in 'fsl_asrc_cal_asrck_divisor'
 sound/soc/fsl/fsl_asrc.c:242: warning: Function parameter or member 'div' not described in 'fsl_asrc_cal_asrck_divisor'
 sound/soc/fsl/fsl_asrc.c:259: warning: Function parameter or member 'pair' not described in 'fsl_asrc_set_ideal_ratio'
 sound/soc/fsl/fsl_asrc.c:259: warning: Function parameter or member 'inrate' not described in 'fsl_asrc_set_ideal_ratio'
 sound/soc/fsl/fsl_asrc.c:259: warning: Function parameter or member 'outrate' not described in 'fsl_asrc_set_ideal_ratio'
 sound/soc/fsl/fsl_asrc.c:310: warning: Function parameter or member 'pair' not described in 'fsl_asrc_config_pair'
 sound/soc/fsl/fsl_asrc.c:310: warning: Function parameter or member 'use_ideal_rate' not described in 'fsl_asrc_config_pair'
 sound/soc/fsl/fsl_asrc.c:516: warning: Function parameter or member 'pair' not described in 'fsl_asrc_start_pair'
 sound/soc/fsl/fsl_asrc.c:545: warning: Function parameter or member 'pair' not described in 'fsl_asrc_stop_pair'
 sound/soc/fsl/fsl_asrc.c:559: warning: Function parameter or member 'pair' not described in 'fsl_asrc_get_dma_channel'
 sound/soc/fsl/fsl_asrc.c:559: warning: Function parameter or member 'dir' not described in 'fsl_asrc_get_dma_channel'
 sound/soc/fsl/fsl_asrc.c:902: warning: Function parameter or member 'asrc' not described in 'fsl_asrc_init'
 sound/soc/fsl/fsl_asrc.c:936: warning: Function parameter or member 'irq' not described in 'fsl_asrc_isr'
 sound/soc/fsl/fsl_asrc.c:936: warning: Function parameter or member 'dev_id' not described in 'fsl_asrc_isr'

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/fsl/fsl_asrc.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 462ce9f9ab488..209bf80dc3670 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -37,7 +37,7 @@ static struct snd_pcm_hw_constraint_list fsl_asrc_rate_constraints = {
 	.list = supported_asrc_rate,
 };
 
-/**
+/*
  * The following tables map the relationship between asrc_inclk/asrc_outclk in
  * fsl_asrc.h and the registers of ASRCSR
  */
@@ -68,7 +68,7 @@ static unsigned char output_clk_map_imx53[ASRC_CLK_MAP_LEN] = {
 	0x7, 0x7, 0x7, 0x7, 0x7, 0x7, 0x7, 0x7, 0x7, 0x7, 0x7, 0x7, 0x7, 0x7, 0x7, 0x7,
 };
 
-/**
+/*
  * i.MX8QM/i.MX8QXP uses the same map for input and output.
  * clk_map_imx8qm[0] is for i.MX8QM asrc0
  * clk_map_imx8qm[1] is for i.MX8QM asrc1
@@ -101,7 +101,7 @@ static unsigned char clk_map_imx8qxp[2][ASRC_CLK_MAP_LEN] = {
 	},
 };
 
-/**
+/*
  * Select the pre-processing and post-processing options
  * Make sure to exclude following unsupported cases before
  * calling this function:
@@ -147,7 +147,7 @@ static void fsl_asrc_sel_proc(int inrate, int outrate,
 		*post_proc = 1;
 }
 
-/**
+/*
  * Request ASRC pair
  *
  * It assigns pair by the order of A->C->B because allocation of pair B,
@@ -192,7 +192,7 @@ static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
 	return ret;
 }
 
-/**
+/*
  * Release ASRC pair
  *
  * It clears the resource from asrc and releases the occupied channels.
@@ -216,7 +216,7 @@ static void fsl_asrc_release_pair(struct fsl_asrc_pair *pair)
 	spin_unlock_irqrestore(&asrc->lock, lock_flags);
 }
 
-/**
+/*
  * Configure input and output thresholds
  */
 static void fsl_asrc_set_watermarks(struct fsl_asrc_pair *pair, u32 in, u32 out)
@@ -233,7 +233,7 @@ static void fsl_asrc_set_watermarks(struct fsl_asrc_pair *pair, u32 in, u32 out)
 			   ASRMCRi_OUTFIFO_THRESHOLD(out));
 }
 
-/**
+/*
  * Calculate the total divisor between asrck clock rate and sample rate
  *
  * It follows the formula clk_rate = samplerate * (2 ^ prescaler) * divider
@@ -249,7 +249,7 @@ static u32 fsl_asrc_cal_asrck_divisor(struct fsl_asrc_pair *pair, u32 div)
 	return ((div - 1) << ASRCDRi_AxCPi_WIDTH) | ps;
 }
 
-/**
+/*
  * Calculate and set the ratio for Ideal Ratio mode only
  *
  * The ratio is a 32-bit fixed point value with 26 fractional bits.
@@ -292,7 +292,7 @@ static int fsl_asrc_set_ideal_ratio(struct fsl_asrc_pair *pair,
 	return 0;
 }
 
-/**
+/*
  * Configure the assigned ASRC pair
  *
  * It configures those ASRC registers according to a configuration instance
@@ -507,7 +507,7 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair, bool use_ideal_rate)
 	return fsl_asrc_set_ideal_ratio(pair, inrate, outrate);
 }
 
-/**
+/*
  * Start the assigned ASRC pair
  *
  * It enables the assigned pair and makes it stopped at the stall level.
@@ -538,7 +538,7 @@ static void fsl_asrc_start_pair(struct fsl_asrc_pair *pair)
 	regmap_write(asrc->regmap, REG_ASRIER, ASRIER_AOLIE);
 }
 
-/**
+/*
  * Stop the assigned ASRC pair
  */
 static void fsl_asrc_stop_pair(struct fsl_asrc_pair *pair)
@@ -551,7 +551,7 @@ static void fsl_asrc_stop_pair(struct fsl_asrc_pair *pair)
 			   ASRCTR_ASRCEi_MASK(index), 0);
 }
 
-/**
+/*
  * Get DMA channel according to the pair and direction.
  */
 static struct dma_chan *fsl_asrc_get_dma_channel(struct fsl_asrc_pair *pair,
@@ -895,7 +895,7 @@ static const struct regmap_config fsl_asrc_regmap_config = {
 	.cache_type = REGCACHE_FLAT,
 };
 
-/**
+/*
  * Initialize ASRC registers with a default configurations
  */
 static int fsl_asrc_init(struct fsl_asrc *asrc)
@@ -929,7 +929,7 @@ static int fsl_asrc_init(struct fsl_asrc *asrc)
 	return regmap_write(asrc->regmap, REG_ASR56K, ipg_rate / 56000);
 }
 
-/**
+/*
  * Interrupt handler for ASRC
  */
 static irqreturn_t fsl_asrc_isr(int irq, void *dev_id)
-- 
2.25.1

