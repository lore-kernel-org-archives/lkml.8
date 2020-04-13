Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64775C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39BE6206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="kg6ykZxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgDMJZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 05:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728233AbgDMJYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 05:24:43 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F635C00860C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:18:26 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m2so6033642lfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=g64ft+x3hBUoNKaOlNsqOIBji2tCG8A8Sg8KRFe28Yc=;
        b=kg6ykZxF9Sg3DIKw4sLTc7wrIYsnOS1F0G3B6b4/E+yNNiTq6/CUotfvSeyDIOHR/r
         ZrqNeqfJCLBa5UDqK/KZ/paCvMlYMjG5l3Ol+rNJCXYNmbekl6Srhf9uct55aVBtcIa6
         fvfATh+tuQNfDPPfLbCF/0GFaYwvDxefnNZXI5H+bASe3vkZJT906W1tQ5K0CNmVfCgK
         +otgCvqFVk+vo/OLeUyQQbig/uffIqcMqN/K3C+tL0AS4APDyvw7uXpvA0PFgnmp1zMC
         pzQd0M4fDUvFrYYRoWlVOQa5BX7/JIDLHSRdp+lXPr0Huj5jxzzbhovTAnF3EYVxV2/h
         9J7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=g64ft+x3hBUoNKaOlNsqOIBji2tCG8A8Sg8KRFe28Yc=;
        b=T2pr56gkGV0TGD6k4E6BXkIfZ18cFDhuEHmawmkSyTU495QEncmhbYY7w479yVeuMW
         YYNZFClI+LdLn7tIeTgRmAgCAv1yP51xRuEQGkJXcsa+XpRxYIxGYdvs9wmsF48jsyIQ
         l63Ks0zWy4La3yd28zhq/sdu8ggAoz2pMcX/4G/zMm9cMyV4na+3TIdwQcXrh+oQ52gM
         l8vJJ6xs6FcpFORbaVAqsEPReLOVGgQSyMclqtWQxrIuTT87if/3YuAN23EUKholT/fS
         3c+1lh1Wn3imQNuXhCWGRMiT+EGudzpWSYoJEy8/vJA7H7HZjZEOy2nK5oymNNLqt7vy
         HZuw==
X-Gm-Message-State: AGi0PuZ4XbtTqcQpYWuK5yc13+UmPyq5aIT6RV730Q44F0cdF/83TKGu
        KM2dYWkOd7jpoAXmh7tVm9EX/iAtBpf0YA==
X-Google-Smtp-Source: APiQypKsD9OoGak6fki/X4BhtvzdRdt8QcUcFqDWZ/kirBl+F7dY0/BGOtgEXs30BbUHtznkTZvNTQ==
X-Received: by 2002:a05:6512:1095:: with SMTP id j21mr10024855lfg.118.1586769504807;
        Mon, 13 Apr 2020 02:18:24 -0700 (PDT)
Received: from localhost.localdomain ([159.224.5.60])
        by smtp.googlemail.com with ESMTPSA id e16sm8339049ljh.18.2020.04.13.02.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 02:18:24 -0700 (PDT)
From:   Roman Kovalivskyi <roman.kovalivskyi@globallogic.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc:     Luis Oliveira <lolivei@synopsys.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Michael Rodin <mrodin@de.adit-jv.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Maxime Ripard <mripard@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Roman Kovalivskyi <roman.kovalivskyi@globallogic.com>
Subject: [PATCH 1/4] media: ov5647: Add set_fmt and get_fmt calls.
Date:   Mon, 13 Apr 2020 12:17:44 +0300
Message-Id: <8a4c0d157d26251c9916b32866e6a4a91c023ef9.1586759968.git.roman.kovalivskyi@globallogic.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1586758372.git.roman.kovalivskyi@globallogic.com>
References: <cover.1586758372.git.roman.kovalivskyi@globallogic.com>
In-Reply-To: <cover.1586759968.git.roman.kovalivskyi@globallogic.com>
References: <cover.1586759968.git.roman.kovalivskyi@globallogic.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

There's no way to query the subdevice for the supported
resolutions. Add set_fmt and get_fmt implementations. Since there's
only one format supported set_fmt does nothing and get returns single
format.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Roman Kovalivskyi <roman.kovalivskyi@globallogic.com>
---
 drivers/media/i2c/ov5647.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index e7d2e5b4ad4b..3e587eb0a30e 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -463,8 +463,30 @@ static int ov5647_enum_mbus_code(struct v4l2_subdev *sd,
 	return 0;
 }
 
+static int ov5647_set_get_fmt(struct v4l2_subdev *sd,
+			      struct v4l2_subdev_pad_config *cfg,
+			      struct v4l2_subdev_format *format)
+{
+	struct v4l2_mbus_framefmt *fmt = &format->format;
+
+	if (format->pad != 0)
+		return -EINVAL;
+
+	/* Only one format is supported, so return that */
+	memset(fmt, 0, sizeof(*fmt));
+	fmt->code = MEDIA_BUS_FMT_SBGGR8_1X8;
+	fmt->colorspace = V4L2_COLORSPACE_SRGB;
+	fmt->field = V4L2_FIELD_NONE;
+	fmt->width = 640;
+	fmt->height = 480;
+
+	return 0;
+}
+
 static const struct v4l2_subdev_pad_ops ov5647_subdev_pad_ops = {
 	.enum_mbus_code = ov5647_enum_mbus_code,
+	.set_fmt =	  ov5647_set_get_fmt,
+	.get_fmt =	  ov5647_set_get_fmt,
 };
 
 static const struct v4l2_subdev_ops ov5647_subdev_ops = {
-- 
2.17.1

