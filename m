Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FF0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C52F3207D0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JPaF/Cic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgGGKQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGKQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:16:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27EEC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:16:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so16561466wrp.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X8lNwwZEdxo/c3swk/aA3YOExp2MKHA0sqq87q0a3wI=;
        b=JPaF/CicEUbbEvjATlnxD7O2L+C/bGJ44q6+XFBdFLiooQUTKPkM6b0DF3WaHnu4JS
         ljQ5WTYJ0xaTu2U4mv3oOx94WuvUQoFuRkIBSLp8S2hyPW4ZQLvUaGeRMmQZt7cpJj4x
         m01vqsFt+pXzQBT5G2aTJ3/BjNOhPTnV8UlrL+8wty5YciPoKJ4ARWpjMjBBFNiU1Uhx
         9RLT5cN5m8UAT70LX2t+cMicwmn7u5LoXarjAg0/SCZWkFYApjO4j0N51QUXv+ZkdZxI
         q7sxYY1T4eOP1cuu4pEh2T0MQzepg3MsQdNjmC/63Xv8pzwyBzI699063chxHcX2/rES
         m0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X8lNwwZEdxo/c3swk/aA3YOExp2MKHA0sqq87q0a3wI=;
        b=bSfl86HwCqDAS2gyDBBHssby2L0qe0iVbnJvXeUrkeggJmhA+CYecR1oUk1E+DlkJG
         NPMzIekSn/0OhGI9X7CJalqmzKRj/TFEN31mAKumBjJQr+PKD2NS3o/Pn1R5UDWUvGoQ
         rl4v/L66AYhpXX1QEykLzZasvy5nAt3QXpySZW0XZ8Wl6spkkXUUubItuTRADtlTXGU5
         w0+Z+rKex0xqYgNRgLyIvPU+isSG3V/JWnLwMVBOYu8p2aETN9921cMROz4yvdSTp+y8
         6RpSh/nNuCbHmQ2GHbyWvLzv/gLZ3vXQKvXFWeFe/UGdJd0d5fEVlbH5RkKhGmnsoF5Y
         OoDw==
X-Gm-Message-State: AOAM53174hDoUcselfTyVTYZxv5nEdlefdsKO5OAwMA2t5JaYF+qT552
        9IE3H1LTqUO9QYBeG0JjXe0JRA==
X-Google-Smtp-Source: ABdhPJzoaszx/FMxs1EP+dndZHd/3eQX6gVh8XKr9z6/arTSDiQU05AAnvgjIGjxpvs4zR3pPcZ5+Q==
X-Received: by 2002:adf:f888:: with SMTP id u8mr11364000wrp.18.1594117008361;
        Tue, 07 Jul 2020 03:16:48 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:16:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Bo Shen <voice.shen@atmel.com>,
        Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: [PATCH 01/28] ASoC: atmel: atmel-pcm-dma: Demote function header which is clearly not kerneldoc
Date:   Tue,  7 Jul 2020 11:16:15 +0100
Message-Id: <20200707101642.1747944-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document the demoted function here.

Fixes the following W=1 kernel build warning(s):

 sound/soc/atmel/atmel-pcm-dma.c:55: warning: Function parameter or member 'ssc_sr' not described in 'atmel_pcm_dma_irq'
 sound/soc/atmel/atmel-pcm-dma.c:55: warning: Function parameter or member 'substream' not described in 'atmel_pcm_dma_irq'

Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Bo Shen <voice.shen@atmel.com>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/atmel/atmel-pcm-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
index cb03c4f7324c9..0a2e956232afe 100644
--- a/sound/soc/atmel/atmel-pcm-dma.c
+++ b/sound/soc/atmel/atmel-pcm-dma.c
@@ -44,7 +44,7 @@ static const struct snd_pcm_hardware atmel_pcm_dma_hardware = {
 	.buffer_bytes_max	= 512 * 1024,
 };
 
-/**
+/*
  * atmel_pcm_dma_irq: SSC interrupt handler for DMAENGINE enabled SSC
  *
  * We use DMAENGINE to send/receive data to/from SSC so this ISR is only to
-- 
2.25.1

