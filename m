Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AC9C2BB86
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E02E20737
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="IGBO35OF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgDMJYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 05:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728226AbgDMJYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 05:24:42 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335B3C00860F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:18:29 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id k28so6022615lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Dazg0uCSqaIHQUhsMcqRqSvCcoSDDbmA2fiSqaBN9MM=;
        b=IGBO35OFdsIktkEWxvs2u4uJJPxlcgyZgAtOmQLDnMg9+1yf2x6K4oow82u3Vlikj4
         qyRasUsMsWEzeVunT6ep688hAfUTx3p1Ce7s93jQ+yNgHVwkPBClqTLofhCwfPw6Hc0C
         L3tXbx24BUqaoG3IrXoDbIGfTt746UnzFEMJNf5RGfElay0pVSBBwKn5eWVnq3tPAj5+
         2Y0yWyJpilbcfw6QMj5hxIP7rJcXmxpzi6TJDXMQ8ml0lpav44aUEbOtUYD2KK/U6e2p
         BDP0Bk+FEb8MMXT3lYkvqBclo/Ov6Ki7F6DEXnOINF4F6fscfQdZZ1PJ8IiOAvGDp3JH
         K0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Dazg0uCSqaIHQUhsMcqRqSvCcoSDDbmA2fiSqaBN9MM=;
        b=WTytEnAFvxwSd+rQIa/VHSBc5AVQk6CWISHbIpoLTOt5u9i/tBlKudOK7u1XxR1zKE
         uGGOjyyxq5vXB3w79s6R3J45dg9IQWOe9Bm99/oV4oJmVl29hyAO9NAMMQz+4jvRS+K0
         GetkIBph5Ti9U6IRJw2VO/sK9S9doZh/63MWRWhIc9bsQ7l5GiMfzpOFJu0RK86uAan6
         eDRdMRfodzV4eU8ljiggNub2g++/otQWFxL6RUFKApe5c2GicgT97ZSBxnYKLS6H/D50
         qdW4UUtJzp+KaJBH843mQxrsJkuNqEbe7dNQwXCpZLj1ZUb8A6bzEvsOKGoDnKEakeZ/
         ie4g==
X-Gm-Message-State: AGi0Pua+0f6MaL/HYFbQuYT104meDSFJD3sQ0DfsxjOwiLASpLowvaZQ
        mkuRv5dR87fhrAQiB6scpiFq/0BR4WpLag==
X-Google-Smtp-Source: APiQypJtWZRgeuhBdwNVv/BYkC/v97z1lki6YGoNZ8np1IQMVGV5tfmu6geF0iOgUiJOhok3iuHfpQ==
X-Received: by 2002:a19:114:: with SMTP id 20mr9943824lfb.169.1586769507484;
        Mon, 13 Apr 2020 02:18:27 -0700 (PDT)
Received: from localhost.localdomain ([159.224.5.60])
        by smtp.googlemail.com with ESMTPSA id e16sm8339049ljh.18.2020.04.13.02.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 02:18:27 -0700 (PDT)
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
Subject: [PATCH 2/4] media: ov5647: Add support for PWDN GPIO.
Date:   Mon, 13 Apr 2020 12:17:45 +0300
Message-Id: <f88b99899eb5e680607349b37eb3679dbd12433e.1586759968.git.roman.kovalivskyi@globallogic.com>
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

Add support for an optional GPIO connected to PWDN on the sensor. This
allows the use of hardware standby mode where internal device clock
and circuit activities are halted.

Please nothe that power is off when PWDN is high.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Roman Kovalivskyi <roman.kovalivskyi@globallogic.com>
---
 drivers/media/i2c/ov5647.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index 3e587eb0a30e..c39e3d20e3ef 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -21,6 +21,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -35,6 +36,13 @@
 
 #define SENSOR_NAME "ov5647"
 
+/*
+ * From the datasheet, "20ms after PWDN goes low or 20ms after RESETB goes
+ * high if reset is inserted after PWDN goes high, host can access sensor's
+ * SCCB to initialize sensor."
+ */
+#define PWDN_ACTIVE_DELAY_MS	20
+
 #define MIPI_CTRL00_CLOCK_LANE_GATE		BIT(5)
 #define MIPI_CTRL00_BUS_IDLE			BIT(2)
 #define MIPI_CTRL00_CLOCK_LANE_DISABLE		BIT(0)
@@ -86,6 +94,7 @@ struct ov5647 {
 	unsigned int			height;
 	int				power_count;
 	struct clk			*xclk;
+	struct gpio_desc		*pwdn;
 };
 
 static inline struct ov5647 *to_state(struct v4l2_subdev *sd)
@@ -355,6 +364,11 @@ static int ov5647_sensor_power(struct v4l2_subdev *sd, int on)
 	if (on && !ov5647->power_count)	{
 		dev_dbg(&client->dev, "OV5647 power on\n");
 
+		if (ov5647->pwdn) {
+			gpiod_set_value(ov5647->pwdn, 0);
+			msleep(PWDN_ACTIVE_DELAY_MS);
+		}
+
 		ret = clk_prepare_enable(ov5647->xclk);
 		if (ret < 0) {
 			dev_err(&client->dev, "clk prepare enable failed\n");
@@ -392,6 +406,8 @@ static int ov5647_sensor_power(struct v4l2_subdev *sd, int on)
 			dev_dbg(&client->dev, "soft stby failed\n");
 
 		clk_disable_unprepare(ov5647->xclk);
+
+		gpiod_set_value(ov5647->pwdn, 1);
 	}
 
 	/* Update the power count. */
@@ -603,6 +619,10 @@ static int ov5647_probe(struct i2c_client *client)
 		return -EINVAL;
 	}
 
+	/* Request the power down GPIO asserted */
+	sensor->pwdn = devm_gpiod_get_optional(&client->dev, "pwdn",
+					       GPIOD_OUT_HIGH);
+
 	mutex_init(&sensor->lock);
 
 	sd = &sensor->sd;
@@ -616,7 +636,15 @@ static int ov5647_probe(struct i2c_client *client)
 	if (ret < 0)
 		goto mutex_remove;
 
+	if (sensor->pwdn) {
+		gpiod_set_value(sensor->pwdn, 0);
+		msleep(PWDN_ACTIVE_DELAY_MS);
+	}
+
 	ret = ov5647_detect(sd);
+
+	gpiod_set_value(sensor->pwdn, 1);
+
 	if (ret < 0)
 		goto error;
 
-- 
2.17.1

