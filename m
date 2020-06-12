Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4528C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C52B206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FWhMXcsO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgFLNzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgFLNym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:54:42 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CD3C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:54:41 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 9so11158619ljv.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VUUHzTYdCTkEy8qJLKBgOAUld/T0D8KqCFLo4EbK13A=;
        b=FWhMXcsOEds3+BBPQIYyMZMkkDNYqr8Hvf0Pzpg8tbt+5q0Pae7x3KYplDTTYLnDZf
         QvTkqvmHw6i/6iRnZ6dnkfHHxnwYw+FzQ1XgGJorSL9W5s03JdN63NTaH2Xu715b8AAO
         GBaDMKfA/GrwV0MpFVy36NKbRAccos6wcPg+0znIPFcVs2fOJgfF9X97Uc4UsVMbZAPC
         C0l70vTdL9ANIP0BUF6i6V8lgp4kdQEaigslsXFA2rOwOugGsuVgK8qUVKFO8hawrUWA
         Hk3RGdrY3ILJaiZ8KSi3IYeU7Zz86SNOZcT+Bb0Cx4hswB9ri17H147UnULxxgNo2oPU
         W9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VUUHzTYdCTkEy8qJLKBgOAUld/T0D8KqCFLo4EbK13A=;
        b=JpR8qx6ZelWBeQzP9wGWRTNIg3Qvagfur68oWSixa5aQRPW6M0aermlAFDX6Sumzwg
         30/AOT1SvQ2wcYtMsz5r6dR+AzsoQH9NPXKHmDmpSFdvXOKHPWDDModCXPMsZNMDGVcj
         fFYVJmQKUTYVPb+i2dKmk5+Yd9mCVDtoVps1pFDltMlP+90tWrob0UzlBLJvN6NyE62M
         jTIxzL5u62n5+hDGTEBdO5dgogiVCivnrZIyep16hFM39JH3N9M4yaDhzKcl25lZYOQO
         ISYCQNVBkGayeSgJfyR9sPquC/xR1zCg8dA5+/TkySEnRw3g/vNMNvdq7tAehMmiB0P9
         aUTQ==
X-Gm-Message-State: AOAM532GWZuvdntjmbCdBPP1h2cxzQnEgKJHCA2NqdNOybQSikfIQTnd
        0RganPRWrnEKYoO5mF+sxk2Zrw==
X-Google-Smtp-Source: ABdhPJxk6HkegMMq+UhE9X/AYUPY8zX34/yL/MBNoC6KMOLW3w9i0pDCF9KBxHYexkhZH/3Tt6kGjw==
X-Received: by 2002:a2e:9ac6:: with SMTP id p6mr7249076ljj.417.1591970080042;
        Fri, 12 Jun 2020 06:54:40 -0700 (PDT)
Received: from localhost.localdomain (37-144-159-139.broadband.corbina.ru. [37.144.159.139])
        by smtp.googlemail.com with ESMTPSA id a1sm2414415lfi.36.2020.06.12.06.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 06:54:39 -0700 (PDT)
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@iki.fi,
        manivannan.sadhasivam@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com, peter.griffin@linaro.org,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Subject: [PATCH v5 07/10] media: i2c: imx290: Add RAW12 mode support
Date:   Fri, 12 Jun 2020 16:53:52 +0300
Message-Id: <20200612135355.30286-8-andrey.konovalov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612135355.30286-1-andrey.konovalov@linaro.org>
References: <20200612135355.30286-1-andrey.konovalov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

IMX290 is capable of outputting frames in both Raw Bayer (packed) 10 and
12 bit formats. Since the driver already supports RAW10 mode, let's add
the missing RAW12 mode as well.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
---
 drivers/media/i2c/imx290.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index 67725a5aabd3..c654a9a8fb08 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -67,6 +67,7 @@ struct imx290 {
 	struct clk *xclk;
 	struct regmap *regmap;
 	u8 nlanes;
+	u8 bpp;
 
 	struct v4l2_subdev sd;
 	struct v4l2_fwnode_endpoint ep;
@@ -86,10 +87,12 @@ struct imx290 {
 
 struct imx290_pixfmt {
 	u32 code;
+	u8 bpp;
 };
 
 static const struct imx290_pixfmt imx290_formats[] = {
-	{ MEDIA_BUS_FMT_SRGGB10_1X10 },
+	{ MEDIA_BUS_FMT_SRGGB10_1X10, 10 },
+	{ MEDIA_BUS_FMT_SRGGB12_1X12, 12 },
 };
 
 static const struct regmap_config imx290_regmap_config = {
@@ -257,6 +260,18 @@ static const struct imx290_regval imx290_10bit_settings[] = {
 	{ 0x300b, 0x00},
 };
 
+static const struct imx290_regval imx290_12bit_settings[] = {
+	{ 0x3005, 0x01 },
+	{ 0x3046, 0x01 },
+	{ 0x3129, 0x00 },
+	{ 0x317c, 0x00 },
+	{ 0x31ec, 0x0e },
+	{ 0x3441, 0x0c },
+	{ 0x3442, 0x0c },
+	{ 0x300a, 0xf0 },
+	{ 0x300b, 0x00 },
+};
+
 /* supported link frequencies */
 #define FREQ_INDEX_1080P	0
 #define FREQ_INDEX_720P		1
@@ -478,7 +493,12 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
 		} else {
 			imx290_write_reg(imx290, IMX290_PGCTRL, 0x00);
 			msleep(10);
-			imx290_write_reg(imx290, IMX290_BLKLEVEL_LOW, 0x3c);
+			if (imx290->bpp == 10)
+				imx290_write_reg(imx290, IMX290_BLKLEVEL_LOW,
+						 0x3c);
+			else /* 12 bits per pixel */
+				imx290_write_reg(imx290, IMX290_BLKLEVEL_LOW,
+						 0xf0);
 			imx290_write_reg(imx290, IMX290_BLKLEVEL_HIGH, 0x00);
 		}
 		break;
@@ -550,7 +570,7 @@ static u64 imx290_calc_pixel_rate(struct imx290 *imx290)
 
 	/* pixel rate = link_freq * 2 * nr_of_lanes / bits_per_sample */
 	pixel_rate = link_freq * 2 * nlanes;
-	do_div(pixel_rate, 10);
+	do_div(pixel_rate, imx290->bpp);
 	return pixel_rate;
 }
 
@@ -587,6 +607,7 @@ static int imx290_set_fmt(struct v4l2_subdev *sd,
 	} else {
 		format = &imx290->current_format;
 		imx290->current_mode = mode;
+		imx290->bpp = imx290_formats[i].bpp;
 
 		if (imx290->link_freq)
 			__v4l2_ctrl_s_ctrl(imx290->link_freq,
@@ -631,6 +652,15 @@ static int imx290_write_current_format(struct imx290 *imx290)
 			return ret;
 		}
 		break;
+	case MEDIA_BUS_FMT_SRGGB12_1X12:
+		ret = imx290_set_register_array(imx290, imx290_12bit_settings,
+						ARRAY_SIZE(
+							imx290_12bit_settings));
+		if (ret < 0) {
+			dev_err(imx290->dev, "Could not set format registers\n");
+			return ret;
+		}
+		break;
 	default:
 		dev_err(imx290->dev, "Unknown pixel format\n");
 		return -EINVAL;
-- 
2.17.1

