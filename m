Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEB4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 01:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF0B20715
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 01:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="W8CqP3lM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgESBQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 21:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgESBQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 21:16:51 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678CBC05BD0A
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 18:16:51 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id a4so9743672lfh.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 18:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=iNtkjLBofdH+4f64nkDpx4VziClnAaPL36XhTHv5QzU=;
        b=W8CqP3lMPScdIK6wIrmeT3P/nb87MaSjC2kmNctZJ5viIvGgB48mlnUCoGMa+JFxgw
         cFJE8Ime/RLaYAU+N+vk5UGBE44yFuZK7NQn/afZArp+f4a2nPYxZDRRKTe0yW2MBN5x
         5Z80Ftp/ZYoMOA58mSpEmDUkUu8sTz5kgZj/GQKFjV/wmFIsK7EBAfQo/t0wAXEtx2EN
         NosGoAbeXUKde2bZu2eeZY3Ok75YdM/LptpD+HC1lZx3V/bJ0G05LDU1Gxv3Q+10Raq+
         fzJmQc8cVouEOgW6GqbMjFg6jpKT8OMwNhQD6T+lbhlhSLhkxNYt6Yl0JTyKcSrWhhCu
         w+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=iNtkjLBofdH+4f64nkDpx4VziClnAaPL36XhTHv5QzU=;
        b=mN08gtKhmnMZmpz+DgXER4NzjaDfRjX6iMw9mjkJUZHenbfIy8b/pMrl6VxapVMcn3
         y/qowofiWYceNaXClefC6q221k13z/WEfFUrmOL0X80tB4j84lqtmIId5b9rCy+YGEoE
         o4SQCfevLp7terAb7UfAth9Duh/Rg9JN2Vud/3vkf02gz4bUmwM6fydCDCF6vI/giLTU
         pz7i6O2EKlQPxzrnx5nYFRoMn86GW7ZAK7UqTLe5u/lBRAd8RXJK9PN4t2VWRyK30fdf
         Q+oMffWc76toVcE34yfKWyAC3aVw2k2z72EVy1KWzmNqqXC7PmdAMxwOtEk2Yw0bze/x
         DkXw==
X-Gm-Message-State: AOAM532UcW/vT+zzpIy2zEmOksbJhXKo/fUsCRT4ai5KlddT7BP9TAxC
        xZizv07E49I/eCQPGIInPlhfSViNv7CnWg==
X-Google-Smtp-Source: ABdhPJzTVQ7s6a5XPWnmoKQsqku0bOnsdidXGcDFI4Nrwm6hwoCvxf6HZrbBO61ZjPhhtmUNk/oxYw==
X-Received: by 2002:a19:c016:: with SMTP id q22mr5245316lff.191.1589851009299;
        Mon, 18 May 2020 18:16:49 -0700 (PDT)
Received: from localhost.localdomain ([159.224.5.60])
        by smtp.googlemail.com with ESMTPSA id i8sm4764244lfl.72.2020.05.18.18.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 18:16:48 -0700 (PDT)
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
Subject: [PATCH v2 1/6] media: ov5647: Add set_fmt and get_fmt calls.
Date:   Tue, 19 May 2020 04:16:16 +0300
Message-Id: <8a4c0d157d26251c9916b32866e6a4a91c023ef9.1589850165.git.roman.kovalivskyi@globallogic.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1589847910.git.roman.kovalivskyi@globallogic.com>
References: <cover.1589847910.git.roman.kovalivskyi@globallogic.com>
In-Reply-To: <cover.1589850165.git.roman.kovalivskyi@globallogic.com>
References: <cover.1589850165.git.roman.kovalivskyi@globallogic.com>
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
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
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

