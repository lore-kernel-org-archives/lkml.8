Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBB1C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0247A2075F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kcK3yrH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388221AbgEXTZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 15:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387807AbgEXTZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 15:25:38 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D138AC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 12:25:36 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id l15so18194832lje.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 12:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xeJmQRJvkh8fRKHXAH/W536lRiSffIGCx+R099ed5PQ=;
        b=kcK3yrH4g4ts5H42rI7JP7vzXPX5ac10GjBC78+fEwYXQ3xZZpe9hpb7780Aet7sPu
         xaOopB6kTv3WLbIteq/l/ZlkTGa0IIAljayEsDG5Xhf/lutDdWeg6GFCGpjOr2Vvo2B3
         qPhOFBVuH/CquAHzfHkFJFtlHJ9ice2Wgsbb5A6DxzbPeQmJQ4INkwahmq/0YipuFFT0
         GeSvG0rKpIesgav6Oft8aO4BWDVkaW9fvA+h+VgH3GXCnJjN8Q3BpRjj703BjzvdbX9K
         2A5OKmiM6aZ2Y9bR9xuRVHh3eeBWjw5O3qbZhtwhlJwCQk4aJxXA0M75OZYXxJni35qu
         tyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xeJmQRJvkh8fRKHXAH/W536lRiSffIGCx+R099ed5PQ=;
        b=DtGOIm6X0SuFArAVbDeBvWIk9+To/KrSiZ+M8gSLrlM7AAB7YY5GxPouIsrzuclCBf
         4ssN1YaPegXmqdawzRCr/KwSH9C0MFWdoxYO11mhR39nHGE3b2rC97VM/yJ6mRcobpQL
         H1NVcSwfeYEdgNWh33U+jMeYWJ8tt0Ljp6+c8V+QlrLFjpleFGrZXebtuElLxFreKw3A
         g1AkyfuvuXzhEGAvRHIEmuyOqofcBCd/1+DFL+fc+QgF8mxYFRt/vMU6B8hxWxs1BDJJ
         BkyMatqfXvUSUep1AKe4IVlY/DpkpQpDsrD1ZCyI72/3+C0BmSpeQo5e0TjgFUTqM2E6
         habg==
X-Gm-Message-State: AOAM5338l+RvSQtqzIw9Lw+xbsez1NES09eGBG3uTIceJ46z4QxcT92o
        /bBd3C7yyCAK+HwugzoY3pD5Ug==
X-Google-Smtp-Source: ABdhPJyZWmTTulqXDsNX7SFmBuKS+wkGmszWbb8/SsBCZAbUcqm2vhW7VXLbW742ya3E0gZXk1U0Lg==
X-Received: by 2002:a2e:b6cd:: with SMTP id m13mr12974189ljo.242.1590348335341;
        Sun, 24 May 2020 12:25:35 -0700 (PDT)
Received: from localhost.localdomain (37-144-159-139.broadband.corbina.ru. [37.144.159.139])
        by smtp.googlemail.com with ESMTPSA id v10sm3878137lja.23.2020.05.24.12.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 12:25:34 -0700 (PDT)
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@iki.fi,
        manivannan.sadhasivam@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com, peter.griffin@linaro.org,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Subject: [PATCH v3 01/10] media: i2c: imx290: set the format before VIDIOC_SUBDEV_G_FMT is called
Date:   Sun, 24 May 2020 22:24:56 +0300
Message-Id: <20200524192505.20682-2-andrey.konovalov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200524192505.20682-1-andrey.konovalov@linaro.org>
References: <20200524192505.20682-1-andrey.konovalov@linaro.org>
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

