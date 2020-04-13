Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD8FC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C48D20678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="Mihc4o/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgDMJYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 05:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728225AbgDMJYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 05:24:42 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E5CC008612
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:18:31 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m8so8068037lji.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xNnpgHBnAt93LCIPafN5Q7raYCjrxR7PxR0eKNYX2Gg=;
        b=Mihc4o/u2GESh9QtZTLS9bDa+fIpzDDIm2QbW1xflipN04q6us+ZS1uuRCXW42gyxp
         ow7SBl/uxT9YusmKcBLDSyPz4BYek5tLeXf2G7KWa6MhhNMYNp5TYWANvY7lnExEPunn
         pKyTXFOcFlCR2BbHRRphxmDybSCmGDn6qeE333lKjs0UK+VUjASrhHDjWY9zpGB8ubEN
         Mm3Witfs/SG0Q3+H781+h4IBoBvwJetZXuiqZiUhjU1BUkm4bdpafTHYbueQx6dAHBxs
         3mI0gF2Y9e04sr9hEsN9/NFaui/nlLu45u4lCAfiSF4u3g9t1qEFNaUpgHg/v1MBbDBQ
         sjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xNnpgHBnAt93LCIPafN5Q7raYCjrxR7PxR0eKNYX2Gg=;
        b=tJ7CmgVCbCY54OPYza1EOlsv/dJ/u0yieWuZAIJMusSH88bMgOH5pvboRzNLdmdlwq
         JNeumrRyQvq7r2Xv7zYJAeKL8OC+3hhRhSFBPo15T+MU2PGRRZw5d3dLDMVgZML1bFKu
         3KEnHBTE6AXhbPcdkQvd+OxN+/XQM95CA9BLIfNU6rfHkO2fmRRjec1YATYPPzEsmb/Z
         oXeNNDfQyGoLtV69aZRr8cv7FaYaLLZ487BxPP0HkpFKWqm1pUuCKcK9Zu7s9b428XDs
         CBhab3/VLdrV0dLd4sSJZ/qeHcNZrJAdA+rvIkDBhrxsWnRGwQxx+lneiuq5WURAtowR
         6o4A==
X-Gm-Message-State: AGi0PuZJ4N2hQBRvkeU3OlPz+Thk19Mds2VPLq89ump685Lwt2lDZSZz
        hHrQVAA88HE2BS3fVoydrhKKCeutbs8b8w==
X-Google-Smtp-Source: APiQypJkQICP4Ap1mDBsse87b5AUPBn0Cjrn55lJDgqRygunQAPYwy5UN/m68rQqdBdC4VSjmv0Gjw==
X-Received: by 2002:a05:651c:1064:: with SMTP id y4mr6248ljm.49.1586769509596;
        Mon, 13 Apr 2020 02:18:29 -0700 (PDT)
Received: from localhost.localdomain ([159.224.5.60])
        by smtp.googlemail.com with ESMTPSA id e16sm8339049ljh.18.2020.04.13.02.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 02:18:29 -0700 (PDT)
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
Subject: [PATCH 3/4] media: ov5647: Add support for non-continuous clock mode
Date:   Mon, 13 Apr 2020 12:17:46 +0300
Message-Id: <c3189c80ac27d67e814509d44a864f8164971efb.1586759968.git.roman.kovalivskyi@globallogic.com>
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

The driver was only supporting continuous clock mode
although this was not stated anywhere.
Non-continuous clock saves a small amount of power and
on some SoCs is easier to interface with.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Roman Kovalivskyi <roman.kovalivskyi@globallogic.com>
---
 drivers/media/i2c/ov5647.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index c39e3d20e3ef..8a1a515388e0 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -44,6 +44,7 @@
 #define PWDN_ACTIVE_DELAY_MS	20
 
 #define MIPI_CTRL00_CLOCK_LANE_GATE		BIT(5)
+#define MIPI_CTRL00_LINE_SYNC_ENABLE		BIT(4)
 #define MIPI_CTRL00_BUS_IDLE			BIT(2)
 #define MIPI_CTRL00_CLOCK_LANE_DISABLE		BIT(0)
 
@@ -95,6 +96,7 @@ struct ov5647 {
 	int				power_count;
 	struct clk			*xclk;
 	struct gpio_desc		*pwdn;
+	unsigned int			flags;
 };
 
 static inline struct ov5647 *to_state(struct v4l2_subdev *sd)
@@ -269,9 +271,15 @@ static int ov5647_set_virtual_channel(struct v4l2_subdev *sd, int channel)
 
 static int ov5647_stream_on(struct v4l2_subdev *sd)
 {
+	struct ov5647 *ov5647 = to_state(sd);
+	u8 val = MIPI_CTRL00_BUS_IDLE;
 	int ret;
 
-	ret = ov5647_write(sd, OV5647_REG_MIPI_CTRL00, MIPI_CTRL00_BUS_IDLE);
+	if (ov5647->flags & V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK)
+		val |= MIPI_CTRL00_CLOCK_LANE_GATE |
+		       MIPI_CTRL00_LINE_SYNC_ENABLE;
+
+	ret = ov5647_write(sd, OV5647_REG_MIPI_CTRL00, val);
 	if (ret < 0)
 		return ret;
 
@@ -568,7 +576,7 @@ static const struct v4l2_subdev_internal_ops ov5647_subdev_internal_ops = {
 	.open = ov5647_open,
 };
 
-static int ov5647_parse_dt(struct device_node *np)
+static int ov5647_parse_dt(struct device_node *np, struct ov5647 *sensor)
 {
 	struct v4l2_fwnode_endpoint bus_cfg = { .bus_type = 0 };
 	struct device_node *ep;
@@ -581,6 +589,9 @@ static int ov5647_parse_dt(struct device_node *np)
 
 	ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep), &bus_cfg);
 
+	if (!ret)
+		sensor->flags = bus_cfg.bus.mipi_csi2.flags;
+
 	of_node_put(ep);
 	return ret;
 }
@@ -599,7 +610,7 @@ static int ov5647_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	if (IS_ENABLED(CONFIG_OF) && np) {
-		ret = ov5647_parse_dt(np);
+		ret = ov5647_parse_dt(np, sensor);
 		if (ret) {
 			dev_err(dev, "DT parsing error: %d\n", ret);
 			return ret;
-- 
2.17.1

