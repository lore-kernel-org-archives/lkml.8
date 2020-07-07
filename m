Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607E6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B26F207BB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tihaag9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgGGOiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgGGOiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:01 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E990C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:38:01 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o2so46778461wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HXwAK5e9O3NfsiXPR7kk8AeqU5Nw2ls4PmOWf/vu7lg=;
        b=Tihaag9jMZwV29UerK76hQHb+DRXAFh+EUs1V7aQVmLUfa12c5Fgqr88tInVnn3Uc1
         LOGKlmUmb+W/soV/36Apjvy+WJPjIp43OaM8ccv/ZI9kSNdijHkDH6/Gl3UPf7G6HBdf
         xiaH7jdxISmGJOyBG2mT24keyFUnXZ4oMlos6cNb89np7R9u13rqCCPwN0VKr6W4bKj+
         V3acj0cuYTx9DTeA41/QMR0Gn4mK+hnG7Aaa7kxv48yTjcNutHvDXt1ekAr2SXoIQr8n
         6YJeRmk++sSjJasxlfqA1DPJNpHwqCymdkR6TM+tEFI+jO78WkaMABQw3YGw7/etEaqx
         208A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HXwAK5e9O3NfsiXPR7kk8AeqU5Nw2ls4PmOWf/vu7lg=;
        b=k8TPW5lRGyzpDY24f7LJZrN2v78W/reiPW2fCC9T0dwsEjIxf2zOxm/d0zhqioUSJi
         ke/xK8rxpIMVWPDaq5TZ170o9KcjtRc3I1izq3pkon+eBtORf0HgnZeM1aJHU1s+tMX9
         Y+xD1qt5Y3AY1WMomE97FJD07jK4+bfrhtwiBw4V1fH/6T1r9KI6AS1pnX8o0bvEQp33
         2oZoqT0B1TKwMcOaZ+V6Bx5tW8Fl2TPhpV6jXhtUJyncisRQleKYc8Z2Gvh/cOSzAZm4
         +eXe9Wsabw4ikDhQt54qJonqSOi16LshPk9t7LTPpvPjEODcH9dWu2ifDP/7ILTLQDZc
         ul0g==
X-Gm-Message-State: AOAM532nCPHH85IOsrJ856hWkRInUhQFmCU55Br9PTGg6f+XjUdDTVl+
        0OihlEzL0PvUJJ0ju1RyuU//Dg==
X-Google-Smtp-Source: ABdhPJxKl25fOx72TKj8zseBRL2O39bOx4sTMEBHeAZ/aj9XhWqZW3rmDeB2Wlp30lHgwCTBjVA4cg==
X-Received: by 2002:a1c:7f82:: with SMTP id a124mr4232616wmd.132.1594132680416;
        Tue, 07 Jul 2020 07:38:00 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:37:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Vladimir Barinov <vbarinov@embeddedalley.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 08/28] ASoC: fsl: fsl_spdif: Update 'struct fsl_spdif_priv's descriptions
Date:   Tue,  7 Jul 2020 15:37:22 +0100
Message-Id: <20200707143742.2959960-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two descriptions for 'soc' and 'regcache_srpc' were missing.  Add them.

Fixes the following W=1 kernel build warning(s):

 sound/soc/fsl/fsl_spdif.c:125: warning: Function parameter or member 'soc' not described in 'fsl_spdif_priv'
 sound/soc/fsl/fsl_spdif.c:125: warning: Function parameter or member 'regcache_srpc' not described in 'fsl_spdif_priv'

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Vladimir Barinov <vbarinov@embeddedalley.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/fsl/fsl_spdif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 7aa3bdec5b6b5..f0b2375a9246f 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -83,6 +83,7 @@ struct spdif_mixer_control {
 /**
  * struct fsl_spdif_priv - Freescale SPDIF private data
  *
+ * @soc: SoC specific data
  * @fsl_spdif_control: SPDIF control data
  * @cpu_dai_drv: cpu dai driver
  * @pdev: platform device pointer
@@ -100,6 +101,7 @@ struct spdif_mixer_control {
  * @spbaclk: SPBA clock (optional, depending on SoC design)
  * @dma_params_tx: DMA parameters for transmit channel
  * @dma_params_rx: DMA parameters for receive channel
+ * @regcache_srpc: regcache for SRPC
  */
 struct fsl_spdif_priv {
 	const struct fsl_spdif_soc_data *soc;
@@ -120,7 +122,6 @@ struct fsl_spdif_priv {
 	struct clk *spbaclk;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
-	/* regcache for SRPC */
 	u32 regcache_srpc;
 };
 
-- 
2.25.1

