Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3019C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 16:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2D822067B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 16:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgMmXQrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgFGQbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 12:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbgFGQbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 12:31:07 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D5FC08C5C4
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 09:31:06 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a9so13936233ljn.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 09:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZN8pb1DxbDLuAa3GwJ440N0/6Zk96TU9nPo+rlxSNXs=;
        b=hgMmXQrmQr4gLMphT0IR3nsiRZgO+DUmJ3Jk8kWCmvJJkWdlGe8cAbh9VOYwOIqVjD
         V4oz0SXiDfTtEt7QnN+7tS0C5/r5ys9CSB/0SevtYjrYtp+38gyPGwdqDNJ7ZOeIRtVs
         rXO/zgcXzFu4ryb6uENXqD1Zw5RNVpBLPtqtsQkhq7uApRlntzg+xFh27ORacmkgvkn9
         RD0QTa6dONTYPTxsL/gB44FSKAZ2oGXG+7Hj7o/Bl3/Dx+IWIMZqNbWs4hfnyUDNKXuV
         TFjRWiJfOjfyo0jFcRelceUsoPmgmZrKsuZUzx0znCkiFpDlDW7F+25HnPgiLYjAaRrk
         VQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZN8pb1DxbDLuAa3GwJ440N0/6Zk96TU9nPo+rlxSNXs=;
        b=s9JtGs00yNFXwVLzkP6x5Vv0Us7OCIhYf9+UT2S3VpMflaxq+PWtBJYWRWyV9N4h7d
         NPdtOMON/Gd16pkN+pmeWbqpBYW3edjDpd1D5HnhBdwSOnTHSg7dA+DruCx6qWNjR17P
         UBgQLBL0rT7T2/Hhoy7ex26ZLh1hwxu0DbvLfR7hkd5xoB9qeAF8CRoM3twvUvvc2xKi
         SpSDg1aehA0xp6p2m+VCR3EnpIcHw05XpCpi977+K7RjULd+GuuRorDMIG2cjnRnOARs
         ty1UBRpMg55NEv5NMnjJaeK14iJUQGzc6K9iYDzVZL3BvKyrHuaqk6l+G3QO0NGo8Hng
         jTIQ==
X-Gm-Message-State: AOAM530Sty/7KGZiPmYN4QzI4YBufl+yV085EnFPL5cqCtr2gxum58R+
        sVDQs3iQshogb3NrN3I/02yR/A==
X-Google-Smtp-Source: ABdhPJwKvDoJhrs1A3GxUZPAsk4YJqgk84ISg9RDQ8bOuu1WO9sTe68xjvI+5fEFyJEEzp396jhkgg==
X-Received: by 2002:a2e:87da:: with SMTP id v26mr8806511ljj.14.1591547464950;
        Sun, 07 Jun 2020 09:31:04 -0700 (PDT)
Received: from localhost.localdomain (37-144-159-139.broadband.corbina.ru. [37.144.159.139])
        by smtp.googlemail.com with ESMTPSA id l7sm1726511ljj.55.2020.06.07.09.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 09:31:04 -0700 (PDT)
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@iki.fi,
        manivannan.sadhasivam@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com, peter.griffin@linaro.org,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Subject: [PATCH v4 08/10] media: i2c: imx290: Add support to enumerate all frame sizes
Date:   Sun,  7 Jun 2020 19:30:23 +0300
Message-Id: <20200607163025.8409-9-andrey.konovalov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200607163025.8409-1-andrey.konovalov@linaro.org>
References: <20200607163025.8409-1-andrey.konovalov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Add support to enumerate all frame sizes supported by IMX290. This is
required for using with userspace tools such as libcamera.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
---
 drivers/media/i2c/imx290.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index c654a9a8fb08..fd147fac5ef2 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -528,6 +528,28 @@ static int imx290_enum_mbus_code(struct v4l2_subdev *sd,
 	return 0;
 }
 
+static int imx290_enum_frame_size(struct v4l2_subdev *sd,
+				  struct v4l2_subdev_pad_config *cfg,
+				  struct v4l2_subdev_frame_size_enum *fse)
+{
+	const struct imx290 *imx290 = to_imx290(sd);
+	const struct imx290_mode *imx290_modes = imx290_modes_ptr(imx290);
+
+	if ((fse->code != imx290_formats[0].code) &&
+	    (fse->code != imx290_formats[1].code))
+		return -EINVAL;
+
+	if (fse->index >= imx290_modes_num(imx290))
+		return -EINVAL;
+
+	fse->min_width = imx290_modes[fse->index].width;
+	fse->max_width = imx290_modes[fse->index].width;
+	fse->min_height = imx290_modes[fse->index].height;
+	fse->max_height = imx290_modes[fse->index].height;
+
+	return 0;
+}
+
 static int imx290_get_fmt(struct v4l2_subdev *sd,
 			  struct v4l2_subdev_pad_config *cfg,
 			  struct v4l2_subdev_format *fmt)
@@ -873,6 +895,7 @@ static const struct v4l2_subdev_video_ops imx290_video_ops = {
 static const struct v4l2_subdev_pad_ops imx290_pad_ops = {
 	.init_cfg = imx290_entity_init_cfg,
 	.enum_mbus_code = imx290_enum_mbus_code,
+	.enum_frame_size = imx290_enum_frame_size,
 	.get_fmt = imx290_get_fmt,
 	.set_fmt = imx290_set_fmt,
 };
-- 
2.17.1

