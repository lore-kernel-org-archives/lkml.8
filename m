Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7457C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5B1920899
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rnd7ZVz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgGBOtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbgGBOqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:46:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9C5C08C5E0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:46:43 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l17so27117679wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zCvEYr43bmvAI4c/u02EnPe5wklhcOBr52WpV3Wdhnc=;
        b=rnd7ZVz1ZhbElscG9Bkyx7lA4/DyNELrmIlS9pFIxHeR0jZ64UUgjYI7/xmq7V/nBQ
         ZjeYBcOXpxnMVFhStvkm3qSrrk39Vbmp5EY9GY7i2drA52md+rN3AH5t9d8r0TgeFZNz
         tw/ORXRpXc9E6zjDPBTC35hNIHMr+7X2+Bt/wd9jC/lvPleiDxFGAMeKNMn6tZwOKAMw
         +Fr6OtBOW8Ck2cXOQadIEhvAe9qMjojndUc9IB+nRn8EfKDQNJv3QpZ+jbkkt3DrMn/x
         Qq4i23HE176PnzXDn8TVDQOGIPyiW8rEvw2ymMaPpVPUI/C+iiH4DcU3ekAl1SEKJ2/j
         EL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zCvEYr43bmvAI4c/u02EnPe5wklhcOBr52WpV3Wdhnc=;
        b=Vk6u9LY32KjHPbj5wEHRWRVNw6fhKBiuPswD7QV+uYOlh421xMf+lFGY4vsXsFMYKh
         Gx+Eu7mLaXn4+UhdHkZy54hv+kV0phaC2FaJrV6p2HKQetXSCtcGMq8bX7BhM/6V4ZTr
         F+a0XsV2t4bv3/YyG5DGWJM84lgCCWkq1Lv4LAIwuc/uuhN8xr6/MaeaJCvZJCwEMbMM
         uo6gVPTO9DrkAnOsq4BiBZ/IT7I3m7K5zUTAPrbNCTHo58BsqPVsBUmOsCYqcpQPR1Hh
         VVXuhkycdF2L04FRYG4MObAa5C+M3NRk4KQjFwLGqkzhcRgG6u905nMWDmu7ANollngS
         yuEA==
X-Gm-Message-State: AOAM530NXO2RwudcFv+UYIFTrrsBdWERXFECjG9SGexL/xwiZps9DMkZ
        H56u8bGKaR5Zd4rPZL+6vvvtyg==
X-Google-Smtp-Source: ABdhPJxTZlxUGKYXKggwnjvqFMcBCaf45y5q+liL9GM89JskjMNjlM3bEhXyNhYs3yNR7dMSBMPRZA==
X-Received: by 2002:a1c:cc12:: with SMTP id h18mr30459205wmb.3.1593701202335;
        Thu, 02 Jul 2020 07:46:42 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g14sm7002737wrw.83.2020.07.02.07.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:46:41 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andrzej Siewior <bigeasy@linutronix.de>,
        linux-omap@vger.kernel.org
Subject: [PATCH 08/30] usb: dwc3: dwc3-omap: Do not read DMA status
Date:   Thu,  2 Jul 2020 15:46:03 +0100
Message-Id: <20200702144625.2533530-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit af566a0be6e49 ("usb: dwc3: omap: get rid of dma_status") rendered
reading DMA status from the H/W even more redundant.  The variable hasn't
been read/used since 2016.  Remove the set but unused variable and the call
which populates it.

Fixes the following W=1 warning:

 drivers/usb/dwc3/dwc3-omap.c: In function ‘dwc3_omap_probe’:
 drivers/usb/dwc3/dwc3-omap.c:460:8: warning: variable ‘reg’ set but not used [-Wunused-but-set-variable]
 460 | u32 reg;
 | ^~~

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/dwc3/dwc3-omap.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 8c3de2d258bf7..11288a370828c 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * dwc3-omap.c - OMAP Specific Glue layer
  *
  * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
@@ -457,8 +457,6 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	int			ret;
 	int			irq;
 
-	u32			reg;
-
 	void __iomem		*base;
 
 	if (!node) {
@@ -503,9 +501,6 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	dwc3_omap_map_offset(omap);
 	dwc3_omap_set_utmi_mode(omap);
 
-	/* check the DMA Status */
-	reg = dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
-
 	ret = dwc3_omap_extcon_register(omap);
 	if (ret < 0)
 		goto err1;
-- 
2.25.1

