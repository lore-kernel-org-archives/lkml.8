Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A8FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07CF5206F8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K/+QzAtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgHCX6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbgHCX6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:58:34 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49DFC061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 16:58:33 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v6so25145329iow.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VX3IFGCXLKQ3ciQfWuMzvjEwSKFjyXquwwCufu7gNeM=;
        b=K/+QzAtdFXjrAaJkDf+RUlpsgWfu+l71HO6iYOAg5+xvX2w0Dtb08xIPIh+49UwkwW
         XUbSOpD4TjxkBuMRztkm9Wn/PI+6r3TP6pfAA1IPkABBqIiQAJ5jJr1ZLteuFikejCqJ
         T9GkpAeZ6oNQTB/BuxcH4lPso6jzjYy7H0McI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VX3IFGCXLKQ3ciQfWuMzvjEwSKFjyXquwwCufu7gNeM=;
        b=Wr62yu213reqAbvO8Fywlr+FigIDSbduVo3ag6DCoXFiRnVFLu4uPBVZA4kJ9ZdSUl
         cq1pLVhTgZg52+5U7fDo4EeSg1UJpfWX5tZZirVSRMf+mx0sGx1Pg0nbd1WtbgPwpS1G
         8WZJEmEZ+mvvxhoeye+tx956P0gikD4k4hWLlntG0GvzC/29AjOzvccLyrT2viFymP24
         BF2EcY/Tb9fz82TcPqFU5DmbqcwHht44KELGCuGHg8ShWU68LJ/l2Az00ir1ccOq1Dm+
         8c4nFfxSpFTN5qbU7Ulldio/qJ8VnoftnB3nxh/89Z4ZyV/pJlLxSL1FTl/+d9GKY9Ht
         RP9Q==
X-Gm-Message-State: AOAM533mOyMoKp0/Wl/yjDQyPF4KWx+Yjd6Fb6o5xr/pmuNhFnRxxlPY
        kWmU5VgjSYDdAazq1YsHgrlX4g==
X-Google-Smtp-Source: ABdhPJz8wtmXY6tSGzp4CBkKD9BsMVRdic3yM1mUhcje+irH6PPP7bvUuLAGlxmIwsP0Mzv0obT+VA==
X-Received: by 2002:a05:6602:1495:: with SMTP id a21mr2412821iow.46.1596499113294;
        Mon, 03 Aug 2020 16:58:33 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id x185sm11075992iof.41.2020.08.03.16.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:58:32 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v5 14/15] iio: sx9310: Enable vdd and svdd regulators at probe
Date:   Mon,  3 Aug 2020 17:58:14 -0600
Message-Id: <20200803175559.v5.14.Ib7bdc8340021d8515b430498fb6686eedf22c9f2@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803235815.778997-1-campello@chromium.org>
References: <20200803235815.778997-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

Enable the main power supply (vdd) and digital IO power supply (svdd)
during probe so that the i2c communication and device works properly on
boards that aggressively power gate these supplies.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/iio/proximity/sx9310.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 60ca32885b664b..a68766708fb304 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 #include <linux/iio/buffer.h>
@@ -120,6 +121,7 @@ struct sx9310_data {
 	struct i2c_client *client;
 	struct iio_trigger *trig;
 	struct regmap *regmap;
+	struct regulator_bulk_data supplies[2];
 	/*
 	 * Last reading of the proximity status for each channel.
 	 * We only send an event to user space when this changes.
@@ -876,6 +878,13 @@ static int sx9310_set_indio_dev_name(struct device *dev,
 	return 0;
 }
 
+static void sx9310_regulator_disable(void *_data)
+{
+	struct sx9310_data *data = _data;
+
+	regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
+}
+
 static int sx9310_probe(struct i2c_client *client)
 {
 	int ret;
@@ -889,6 +898,8 @@ static int sx9310_probe(struct i2c_client *client)
 
 	data = iio_priv(indio_dev);
 	data->client = client;
+	data->supplies[0].supply = "vdd";
+	data->supplies[1].supply = "svdd";
 	mutex_init(&data->mutex);
 	init_completion(&data->completion);
 
@@ -896,6 +907,21 @@ static int sx9310_probe(struct i2c_client *client)
 	if (IS_ERR(data->regmap))
 		return PTR_ERR(data->regmap);
 
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->supplies),
+				      data->supplies);
+	if (ret)
+		return ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplies);
+	if (ret)
+		return ret;
+	/* Must wait for Tpor time after initial power up */
+	usleep_range(1000, 1100);
+
+	ret = devm_add_action_or_reset(dev, sx9310_regulator_disable, data);
+	if (ret)
+		return ret;
+
 	ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &data->whoami);
 	if (ret) {
 		dev_err(dev, "error in reading WHOAMI register: %d\n", ret);
-- 
2.28.0.163.g6104cc2f0b6-goog

