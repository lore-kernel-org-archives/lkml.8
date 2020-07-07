Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4DCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6DCD2073E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gOyURcK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgGGOhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGOhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:37:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7FCC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:37:48 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f18so37338438wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X8lNwwZEdxo/c3swk/aA3YOExp2MKHA0sqq87q0a3wI=;
        b=gOyURcK3r2DwvFpoXBFwf+VxrVGMJBFa5tiVKiVlD1Sv9lgSJWBeMg+Yax8Pr+ammt
         CbKHd9ahg6vBz7VNf2xbE9ZssjsBljDR3DjEbulgbGUDZrFoHU9h4D9wbsTb4jBnfoNR
         BTPi5POXO3enLgGBzWsE3oHOowzkBN9RZtp+Bbt+eKAwJq02R36MsWF0EP+2c1AaczEv
         bE2WQFjK+3Znea5sLS/gQOIFmLDDGJ8AQQvQk3IBTU2FB6NmZuPTDyO4CDvlS2YFnvQl
         P7R0E5P4x/uOsmhlSg0iofJtsjdLb+XJrIiMBSKnhqm17vb9OXyIP+HyGFWYJmTcejJF
         ecog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X8lNwwZEdxo/c3swk/aA3YOExp2MKHA0sqq87q0a3wI=;
        b=ReK1UxMrnLBnoAKv0ZKXXbdmFOnu2IpwMQpoVb6eahGbWjokY4quztjjDMTuRxiUN9
         GZpxmCYjy1jXYEncFGfzNxdtqmh2eRGKnQZyifJ9XsDHzGOLI1Vd2VlIFGVGfyN1iLQh
         Yf8HDZ7f5T4yhvJQl3rrZdlXuMzd4gk5nS4ud3dNwT4B4JOoYYjSinXNeq5S1gvtz/vr
         vRVOi59okrgiQEB5+qamWihUn2IBvPxCpX9r1a2fqU9UBxur7LuyOdCz+8WgkCikV5/j
         iMXNSlEBmZ8k2as5T77YX2EKZYz7L2ZQRz5gWjX1zlaIUJaqCQB9xXg0veCb09WceZPY
         1l6Q==
X-Gm-Message-State: AOAM5301FXMl2d70LgASu/CE+rWhBd/HYQJeamr+f5yOFSKngN23wEy+
        ZD22kNwWmQKQ8HdhsGeljDYoqg==
X-Google-Smtp-Source: ABdhPJw5AegAISkmzpd19TGSo7pM2dobgJDA/WJik6mZA0LLKNll4VvB7zgDEdydTeGdMWD3L+9EsQ==
X-Received: by 2002:a5d:40c9:: with SMTP id b9mr52265378wrq.425.1594132667350;
        Tue, 07 Jul 2020 07:37:47 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:37:46 -0700 (PDT)
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
Subject: [PATCH v2 01/28] ASoC: atmel: atmel-pcm-dma: Demote function header which is clearly not kerneldoc
Date:   Tue,  7 Jul 2020 15:37:15 +0100
Message-Id: <20200707143742.2959960-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
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

