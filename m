Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4958C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81409206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="LVIXHdas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgDMJY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 05:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728236AbgDMJYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 05:24:43 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DCBC008615
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:18:33 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u10so4882458lfo.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=nJ3wGvHG21kZCcWWUmMVuJpwrK3OAJC5/GGoLYqeeoY=;
        b=LVIXHdasyTi15SI/wHfDn37mthCzFrgVVRH/hbaQzT7jVVePmdSUjWrJrz9DPvXa7d
         g9+e2hGItpjldKG7vYxDZ2sErky+gVlMsJI3J5QwnB6Gsfwsib3ztXf5eT2qR5kk43XX
         ScNvUlyVAuPQVZRWAxYSqXEKMz/4yxObbULY8vXeIpAk53I64Q0Qrx279X+OQV4QhJSY
         RqPRIi4rl2PttqZUPb8yn0zeQVm0G0h1vsNNnCKL5nqDocE9abkznTlwLIETmEVfUsgQ
         6Eb7cC30/iGkuvrUyiWx/U31G4HL9HWP00rQzGFuRNE6aa/6v42UB7U7Tti6Q86//tfY
         ysrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=nJ3wGvHG21kZCcWWUmMVuJpwrK3OAJC5/GGoLYqeeoY=;
        b=olWnsykRy/ZEzRavwGYMDy1TR/ESwGsk/XOVk/NWpXmYQnJvmrlJmf6n0OAaruXJg2
         VBAXxb1aRqDkgoSc9uOWuSYk8pJhFc195FepDf+C3MwbJDQ7DcW5kjG1TRvridZolZLH
         /D4kGVIqX8Fk7tVBMBF/+M5J9q8hXKv73SbcaajeyDI5j+x/aM01wmCPUmWUrW06ZX4x
         lCVqWtsnUpnAHBimotLvMbmfMLlxW9q6NOambGERnYl8iBBDmPIkcaB1Uz7O2NYAk1VZ
         LvhBGTpgAdMVLn+tXYnLadZWzjeQJJDurGHI398cK0QGW2cdoC2utc5hdx54ai5XWbVS
         4vKQ==
X-Gm-Message-State: AGi0PuZMZtS1ncGUkvGzsnN8s0JpDOGHTsdnwbu/xdwZtVgtvOqvPsL3
        2RxQhW/T2k0JlRJlKRBJQ/eZjGHs137Ciw==
X-Google-Smtp-Source: APiQypKiy2ApL12LsEoupN/PJRDWla5hKyE1JxNkCto7raGjWSgpDEAN4JkcnruENvXmRtbY8pakUg==
X-Received: by 2002:ac2:5f92:: with SMTP id r18mr10304695lfe.154.1586769511832;
        Mon, 13 Apr 2020 02:18:31 -0700 (PDT)
Received: from localhost.localdomain ([159.224.5.60])
        by smtp.googlemail.com with ESMTPSA id e16sm8339049ljh.18.2020.04.13.02.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 02:18:31 -0700 (PDT)
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
Subject: [PATCH 4/4] media: ov5647: Use gpiod_set_value_cansleep
Date:   Mon, 13 Apr 2020 12:17:47 +0300
Message-Id: <f496fe5d364748e9d625a634581a404f30a13efa.1586759968.git.roman.kovalivskyi@globallogic.com>
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

All calls to the gpio library are in contexts that can sleep,
therefore there is no issue with having those GPIOs controlled
by controllers which require sleeping (eg I2C GPIO expanders).

Switch to using gpiod_set_value_cansleep instead of gpiod_set_value
to avoid triggering the warning in gpiolib should the GPIO
controller need to sleep.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Roman Kovalivskyi <roman.kovalivskyi@globallogic.com>
---
 drivers/media/i2c/ov5647.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index 8a1a515388e0..07550377be2e 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -373,7 +373,7 @@ static int ov5647_sensor_power(struct v4l2_subdev *sd, int on)
 		dev_dbg(&client->dev, "OV5647 power on\n");
 
 		if (ov5647->pwdn) {
-			gpiod_set_value(ov5647->pwdn, 0);
+			gpiod_set_value_cansleep(ov5647->pwdn, 0);
 			msleep(PWDN_ACTIVE_DELAY_MS);
 		}
 
@@ -415,7 +415,7 @@ static int ov5647_sensor_power(struct v4l2_subdev *sd, int on)
 
 		clk_disable_unprepare(ov5647->xclk);
 
-		gpiod_set_value(ov5647->pwdn, 1);
+		gpiod_set_value_cansleep(ov5647->pwdn, 1);
 	}
 
 	/* Update the power count. */
@@ -648,13 +648,13 @@ static int ov5647_probe(struct i2c_client *client)
 		goto mutex_remove;
 
 	if (sensor->pwdn) {
-		gpiod_set_value(sensor->pwdn, 0);
+		gpiod_set_value_cansleep(sensor->pwdn, 0);
 		msleep(PWDN_ACTIVE_DELAY_MS);
 	}
 
 	ret = ov5647_detect(sd);
 
-	gpiod_set_value(sensor->pwdn, 1);
+	gpiod_set_value_cansleep(sensor->pwdn, 1);
 
 	if (ret < 0)
 		goto error;
-- 
2.17.1

