Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F412DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBEEA20738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y0gY2Sy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgGGKQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGKQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:16:56 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF983C08C5DF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:16:55 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so33266683wrl.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ZEmbLq4aOW35ukJy4E78RGy/Qq2YYTCi7Pk4jUv8mI=;
        b=Y0gY2Sy9AnIXxGPBMPafdM/OU+9ALGKd8+XAf10BdrSVdmVXMQ3Drjdux2AMMLpIff
         I9bHd7e1F6GPWDyeNwpRf5NJl51RBzzacMIqXloYMMCBSl8luOL9X9Vlh2wVEddLyVzH
         X/EglPfk6GL5tncqxuYjwHRyb9k89v9BbmrAsS/STklgO/FkJI/85N9CuLpAYoYifrY8
         m9rysfNJHAiL9ccDW9o8UiDwstNbizR9NdPn2J2Sl1EeTmUz+hEEOxWPUxRA1Ze5DYoF
         uvYdXCkL+aLfmYJDTbvIyEzfu1DeN08knBxZdKrkCHIPtTnNlqsFQH5mepXeDajhBjxs
         UYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ZEmbLq4aOW35ukJy4E78RGy/Qq2YYTCi7Pk4jUv8mI=;
        b=l2vXF90kVaUI7LZkUQY7rvhjVL3x/nZ5nJupuTEylTmF/Va0PIrNQQ/2G6FBBVA402
         UidTdi3pps0GGJ587zo/yLY2oy/IvtEMeSaeYda286U3kd2tgQxmTxWNzc28RTBP0ux9
         nu4ML3hsNEyPBtV++1Y1BeGTQiLwekb+2V4iSGc6/0OF1Bv/1hkRzAMONGYH7R/K6lIg
         bc5kK30+H4acjrzrYhydooGM87iw4ffaDxmqtRUC7xKWvI2Ojkg1vrIXOOhDr3MH7Htt
         laEWiF1jHaQywyKc8ZNnL3pF8izx9PdXsAu8v4SNioHH0495yN149Dj6laFDnd2OMUIs
         CZQA==
X-Gm-Message-State: AOAM531dyJLY9KtnDmPentQCgyuSsj0g1IQ/UZlp9gsoidt8n4wtoW9g
        vrK0yiH+RQrORGC232AJYe3mXA==
X-Google-Smtp-Source: ABdhPJxbWYN/EZ506zCfhQGem0UtKR9JftLPkvuSL9odppwn/+9aRct/FXJzmr1kyNsbYQyI9tSEhw==
X-Received: by 2002:adf:edc8:: with SMTP id v8mr52127368wro.125.1594117014212;
        Tue, 07 Jul 2020 03:16:54 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:16:53 -0700 (PDT)
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
Subject: [PATCH 05/28] ASoC: fsl: fsl_ssi: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Tue,  7 Jul 2020 11:16:19 +0100
Message-Id: <20200707101642.1747944-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document any of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 sound/soc/fsl/fsl_ssi.c:380: warning: Function parameter or member 'irq' not described in 'fsl_ssi_isr'
 sound/soc/fsl/fsl_ssi.c:380: warning: Function parameter or member 'dev_id' not described in 'fsl_ssi_isr'
 sound/soc/fsl/fsl_ssi.c:406: warning: Function parameter or member 'ssi' not described in 'fsl_ssi_config_enable'
 sound/soc/fsl/fsl_ssi.c:406: warning: Function parameter or member 'tx' not described in 'fsl_ssi_config_enable'
 sound/soc/fsl/fsl_ssi.c:506: warning: Function parameter or member 'ssi' not described in 'fsl_ssi_config_disable'
 sound/soc/fsl/fsl_ssi.c:506: warning: Function parameter or member 'tx' not described in 'fsl_ssi_config_disable'
 sound/soc/fsl/fsl_ssi.c:583: warning: Function parameter or member 'ssi' not described in 'fsl_ssi_setup_regvals'
 sound/soc/fsl/fsl_ssi.c:675: warning: Function parameter or member 'substream' not described in 'fsl_ssi_set_bclk'
 sound/soc/fsl/fsl_ssi.c:675: warning: Function parameter or member 'dai' not described in 'fsl_ssi_set_bclk'
 sound/soc/fsl/fsl_ssi.c:675: warning: Function parameter or member 'hw_params' not described in 'fsl_ssi_set_bclk'
 sound/soc/fsl/fsl_ssi.c:798: warning: Function parameter or member 'substream' not described in 'fsl_ssi_hw_params'
 sound/soc/fsl/fsl_ssi.c:798: warning: Function parameter or member 'hw_params' not described in 'fsl_ssi_hw_params'
 sound/soc/fsl/fsl_ssi.c:798: warning: Function parameter or member 'dai' not described in 'fsl_ssi_hw_params'
 sound/soc/fsl/fsl_ssi.c:1003: warning: Function parameter or member 'dai' not described in 'fsl_ssi_set_dai_fmt'
 sound/soc/fsl/fsl_ssi.c:1003: warning: Function parameter or member 'fmt' not described in 'fsl_ssi_set_dai_fmt'
 sound/soc/fsl/fsl_ssi.c:1018: warning: Function parameter or member 'dai' not described in 'fsl_ssi_set_dai_tdm_slot'
 sound/soc/fsl/fsl_ssi.c:1018: warning: Function parameter or member 'tx_mask' not described in 'fsl_ssi_set_dai_tdm_slot'
 sound/soc/fsl/fsl_ssi.c:1018: warning: Function parameter or member 'rx_mask' not described in 'fsl_ssi_set_dai_tdm_slot'
 sound/soc/fsl/fsl_ssi.c:1018: warning: Function parameter or member 'slots' not described in 'fsl_ssi_set_dai_tdm_slot'
 sound/soc/fsl/fsl_ssi.c:1018: warning: Function parameter or member 'slot_width' not described in 'fsl_ssi_set_dai_tdm_slot'
 sound/soc/fsl/fsl_ssi.c:1065: warning: Function parameter or member 'substream' not described in 'fsl_ssi_trigger'
 sound/soc/fsl/fsl_ssi.c:1065: warning: Function parameter or member 'cmd' not described in 'fsl_ssi_trigger'
 sound/soc/fsl/fsl_ssi.c:1065: warning: Function parameter or member 'dai' not described in 'fsl_ssi_trigger'
 sound/soc/fsl/fsl_ssi.c:1245: warning: Function parameter or member 'ssi' not described in 'fsl_ssi_hw_init'
 sound/soc/fsl/fsl_ssi.c:1274: warning: Function parameter or member 'ssi' not described in 'fsl_ssi_hw_clean'
 sound/soc/fsl/fsl_ssi.c:1292: warning: Function parameter or member 's' not described in 'make_lowercase'

Also use correct formatting when documenting structs:

 sound/soc/fsl/fsl_ssi.c:258: warning: cannot understand function prototype: 'struct fsl_ssi '

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/fsl/fsl_ssi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 1a2fa7f181423..5717d664cde1e 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -203,7 +203,7 @@ struct fsl_ssi_soc_data {
 };
 
 /**
- * fsl_ssi: per-SSI private data
+ * struct fsl_ssi - per-SSI private data
  *
  * @regs: Pointer to the regmap registers
  * @irq: IRQ of this SSI
@@ -373,7 +373,7 @@ static bool fsl_ssi_is_i2s_cbm_cfs(struct fsl_ssi *ssi)
 		SND_SOC_DAIFMT_CBM_CFS;
 }
 
-/**
+/*
  * Interrupt handler to gather states
  */
 static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
@@ -394,7 +394,7 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/**
+/*
  * Set SCR, SIER, STCR and SRCR registers with cached values in regvals
  *
  * Notes:
@@ -474,7 +474,7 @@ static void fsl_ssi_config_enable(struct fsl_ssi *ssi, bool tx)
 	ssi->streams |= BIT(dir);
 }
 
-/**
+/*
  * Exclude bits that are used by the opposite stream
  *
  * When both streams are active, disabling some bits for the current stream
@@ -494,7 +494,7 @@ static void fsl_ssi_config_enable(struct fsl_ssi *ssi, bool tx)
 #define ssi_excl_shared_bits(vals, avals, aactive) \
 	((vals) & _ssi_xor_shared_bits(vals, avals, aactive))
 
-/**
+/*
  * Unset SCR, SIER, STCR and SRCR registers with cached values in regvals
  *
  * Notes:
@@ -576,7 +576,7 @@ static void fsl_ssi_tx_ac97_saccst_setup(struct fsl_ssi *ssi)
 	}
 }
 
-/**
+/*
  * Cache critical bits of SIER, SRCR, STCR and SCR to later set them safely
  */
 static void fsl_ssi_setup_regvals(struct fsl_ssi *ssi)
@@ -660,7 +660,7 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 	clk_disable_unprepare(ssi->clk);
 }
 
-/**
+/*
  * Configure Digital Audio Interface bit clock
  *
  * Note: This function can be only called when using SSI as DAI master
@@ -781,7 +781,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-/**
+/*
  * Configure SSI based on PCM hardware parameters
  *
  * Notes:
@@ -996,7 +996,7 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi *ssi, unsigned int fmt)
 	return 0;
 }
 
-/**
+/*
  * Configure Digital Audio Interface (DAI) Format
  */
 static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
@@ -1010,7 +1010,7 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return _fsl_ssi_set_dai_fmt(ssi, fmt);
 }
 
-/**
+/*
  * Set TDM slot number and slot width
  */
 static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask,
@@ -1054,7 +1054,7 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask,
 	return 0;
 }
 
-/**
+/*
  * Start or stop SSI and corresponding DMA transaction.
  *
  * The DMA channel is in external master start and pause mode, which
@@ -1238,7 +1238,7 @@ static struct snd_ac97_bus_ops fsl_ssi_ac97_ops = {
 	.write = fsl_ssi_ac97_write,
 };
 
-/**
+/*
  * Initialize SSI registers
  */
 static int fsl_ssi_hw_init(struct fsl_ssi *ssi)
@@ -1267,7 +1267,7 @@ static int fsl_ssi_hw_init(struct fsl_ssi *ssi)
 	return 0;
 }
 
-/**
+/*
  * Clear SSI registers
  */
 static void fsl_ssi_hw_clean(struct fsl_ssi *ssi)
@@ -1285,7 +1285,7 @@ static void fsl_ssi_hw_clean(struct fsl_ssi *ssi)
 		regmap_update_bits(ssi->regs, REG_SSI_SCR, SSI_SCR_SSIEN, 0);
 	}
 }
-/**
+/*
  * Make every character in a string lower-case
  */
 static void make_lowercase(char *s)
-- 
2.25.1

