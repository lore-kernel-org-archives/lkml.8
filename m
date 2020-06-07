Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31F7C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 16:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC662067B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 16:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cWHbKehK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgFGQaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 12:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgFGQat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 12:30:49 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910ADC08C5C4
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 09:30:47 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h188so8722510lfd.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 09:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xeJmQRJvkh8fRKHXAH/W536lRiSffIGCx+R099ed5PQ=;
        b=cWHbKehKHIDF062O/92MuKOTWDReA/eMg+2MWo7iENt0FzGGlbcQHmhxWZorGSbmAM
         uc7zGnxHEe1MUmNlY+bGjoJMYJ6MtMyIKDi42imxeId/vOh3PE1qgbEJVCUdbk/ZQlTq
         BPB2NjB2AWvTlQ0eFu9CzcpTKCowVtbXC/UNqY8R/PzETERaT9zsc+VUAXXaF6zoHUqB
         G21musHG+MCTXQW9HLMc5rOj4gujqvo0V1Xnga40s8Rjx/sLUD8Jf0a+9VblX/NHDMbP
         +CfTEdGPe0aKpfM3Zbl3qOk3Tk5BdJLCEW8d4W5NdkVAN/hkC2MLSstUvfCCMFBYtKs9
         ehMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xeJmQRJvkh8fRKHXAH/W536lRiSffIGCx+R099ed5PQ=;
        b=um0UsFtIV1k4yVpzlI63Xm1dumafQ0na4DxDeLSiFhrbKYOvM6Qhs2UjZrvlT/bC+h
         qjMNgY5iwIP8BUtWHMEhdSLPCJKRwEdSVpMOo03X7mLVJk5XNaaUiuy5VlyWChoBSmfa
         ERaOvWvPCdesRbP9QzVxHz6BZ5wS5zGRUaQGgC+J/WMplW2Ddlea5zLRBSue/WdQzi8r
         f2Af8iRy5zuOfppOWCXv9WY92nG3ulMmYtyKah4Oll1aNZ2W1aY0SxLWGerJIM1NYrDp
         9tJAnH/4cg/n8Nbb//lTRY0E3D/5Wr1/khg2K+ZvFwe+lwVTTDGxxDrSGFWgQdbRQssO
         2dig==
X-Gm-Message-State: AOAM5334/3/SXQ07ELLovKhodPFIgnoHuFxTL30xOjqMA0UjD4ztnmJe
        qguHkmRuZ7gyQb+wBZdW6fLgjQ==
X-Google-Smtp-Source: ABdhPJxth+i63WhQaXwjfVhDSLOI1ZX4ELYq67YtASPe86NC6Fn9Cnu2AFDuq7cDjzyYCb5ga9xmZw==
X-Received: by 2002:ac2:4d25:: with SMTP id h5mr10414421lfk.87.1591547446112;
        Sun, 07 Jun 2020 09:30:46 -0700 (PDT)
Received: from localhost.localdomain (37-144-159-139.broadband.corbina.ru. [37.144.159.139])
        by smtp.googlemail.com with ESMTPSA id l7sm1726511ljj.55.2020.06.07.09.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 09:30:45 -0700 (PDT)
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@iki.fi,
        manivannan.sadhasivam@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com, peter.griffin@linaro.org,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Subject: [PATCH v4 01/10] media: i2c: imx290: set the format before VIDIOC_SUBDEV_G_FMT is called
Date:   Sun,  7 Jun 2020 19:30:16 +0300
Message-Id: <20200607163025.8409-2-andrey.konovalov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200607163025.8409-1-andrey.konovalov@linaro.org>
References: <20200607163025.8409-1-andrey.konovalov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the current driver 'media-ctl -p' issued right after the imx290 driver
is loaded prints:
pad0: Source
             [fmt:unknown/0x0]

The format value of zero is due to the current_format field of the imx290
struct not being initialized yet.

As imx290_entity_init_cfg() calls imx290_set_fmt(), the current_mode field
is also initialized, so the line which set current_mode to a default value
in driver's probe() function is no longer needed.

Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/media/i2c/imx290.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index f7678e5a5d87..2d8c38ffe2f0 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -722,9 +722,6 @@ static int imx290_probe(struct i2c_client *client)
 		goto free_err;
 	}
 
-	/* Set default mode to max resolution */
-	imx290->current_mode = &imx290_modes[0];
-
 	/* get system clock (xclk) */
 	imx290->xclk = devm_clk_get(dev, "xclk");
 	if (IS_ERR(imx290->xclk)) {
@@ -809,6 +806,9 @@ static int imx290_probe(struct i2c_client *client)
 		goto free_ctrl;
 	}
 
+	/* Initialize the frame format (this also sets imx290->current_mode) */
+	imx290_entity_init_cfg(&imx290->sd, NULL);
+
 	ret = v4l2_async_register_subdev(&imx290->sd);
 	if (ret < 0) {
 		dev_err(dev, "Could not register v4l2 device\n");
-- 
2.17.1

