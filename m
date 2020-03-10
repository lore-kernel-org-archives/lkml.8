Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94947C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608B124649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QRGCvhJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgCJNqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:46:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52686 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbgCJNqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:46:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id 11so1154139wmo.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SK2ACwWj4lXPZztrhL5ypsF7ZRI2Ajh3tUYrQYQb/ck=;
        b=QRGCvhJbycW67eXyvDQKHjDgCytARTvLmhCj+3kVjKRJ5BzZO03ZUX8NIjURDreCmO
         MufO9YNjX5lRy3zjSo2ujr+Nq74OQVTZkeLZ8KYdYrEpV9pJbKfXMYPYRDigKlHnsS8m
         fTM74ucaeCRSbGcs2lGx9MBy/MRn2i+6pcfAbu3335hJyObodAZwlD2LIty6cw26jxQC
         Mkx8RFdLfmcDG7uG2BYPCcJALs+lWOECjeCo+F+UEpL1pmyLJy2t+JXO19Oj1qsOc57h
         9NRHULAHbldJnVfBQbzFanccl0SaRFV2Dw+XXNCl9e5cbp5VMr7NpSydOW7/rq6ExCCW
         Bi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SK2ACwWj4lXPZztrhL5ypsF7ZRI2Ajh3tUYrQYQb/ck=;
        b=lqmx58+rYeJGy2FxNj7Au3kKWUGbBqyOY1RZ0kHOK/opBSQfy2tbG3o2J0eAuQp+5X
         KaJxGix6daH1IgPXeZrHeXnwI5f8z1NnyZfoehHwQK0322gGl6Ag4ULt1fZKTKKmBsSe
         +jVotfLIZeP6UW0Yg4GKr9d00i5weFm+d88znj4XRZls89sFY/+YAnV6NtcAxMmA12UV
         hm9T8+LMgKJilKVsswEfWwTR4nkK2JIXZTte7wFUXP484h9fVWPBY2JUgeAendimmuiL
         wbzwTRDUCuolBf09A4aqTroJNLXJAjgNeTOlocmP/THxpL2x+KG7fs8lAgegbeoqa6z6
         uJJw==
X-Gm-Message-State: ANhLgQ1++IbQ8S7/XvYCqr5BEQttKrt2ypTlC4dfkz/wMkCemMiSDuO2
        0oynCH2KdJM5PjFyJTNaqW+5ig==
X-Google-Smtp-Source: ADFU+vsO1nDuauJHy/jSe0u+TGLnvM1d86GxQUS3PxHVMyTDLP0mt+nT/F7FcqhHSYpZ/Vops2x68g==
X-Received: by 2002:a1c:a9cf:: with SMTP id s198mr2169499wme.115.1583847970294;
        Tue, 10 Mar 2020 06:46:10 -0700 (PDT)
Received: from xps7590.local ([2a02:2450:102f:13b8:e50c:c780:9a1:8b61])
        by smtp.gmail.com with ESMTPSA id d63sm4074009wmd.44.2020.03.10.06.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:46:09 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     ben.kao@intel.com, mchehab@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, matthias.bgg@gmail.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        andriy.shevchenko@linux.intel.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Dongchun Zhu <dongchun.zhu@mediatek.com>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Robert Foss <robert.foss@linaro.org>
Subject: [v1 2/3] media: ov8856: Add devicetree support
Date:   Tue, 10 Mar 2020 14:46:02 +0100
Message-Id: <20200310134603.30260-3-robert.foss@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310134603.30260-1-robert.foss@linaro.org>
References: <20200310134603.30260-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree match table, and enable ov8856_probe()
to initialize power, clocks and reset pins.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/media/i2c/ov8856.c | 105 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
index 8655842af275..1769acdfaa44 100644
--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -3,10 +3,13 @@
 
 #include <asm/unaligned.h>
 #include <linux/acpi.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-fwnode.h>
@@ -19,6 +22,8 @@
 #define OV8856_LINK_FREQ_180MHZ		180000000ULL
 #define OV8856_SCLK			144000000ULL
 #define OV8856_MCLK			19200000
+#define OV8856_XVCLK_19_2		19200000
+#define OV8856_XVCLK_24			24000000
 #define OV8856_DATA_LANES		4
 #define OV8856_RGB_DEPTH		10
 
@@ -64,6 +69,14 @@
 
 #define to_ov8856(_sd)			container_of(_sd, struct ov8856, sd)
 
+static const char * const ov8856_supply_names[] = {
+	"dovdd",	/* Digital I/O power */
+	"avdd",		/* Analog power */
+	"dvdd",		/* Digital core power */
+};
+
+#define OV8856_NUM_SUPPLIES ARRAY_SIZE(ov8856_supply_names)
+
 enum {
 	OV8856_LINK_FREQ_720MBPS,
 	OV8856_LINK_FREQ_360MBPS,
@@ -566,6 +579,10 @@ struct ov8856 {
 	struct media_pad pad;
 	struct v4l2_ctrl_handler ctrl_handler;
 
+	struct clk		*xvclk;
+	struct gpio_desc	*n_shutdn_gpio;
+	struct regulator_bulk_data supplies[OV8856_NUM_SUPPLIES];
+
 	/* V4L2 Controls */
 	struct v4l2_ctrl *link_freq;
 	struct v4l2_ctrl *pixel_rate;
@@ -908,6 +925,45 @@ static int ov8856_set_stream(struct v4l2_subdev *sd, int enable)
 	return ret;
 }
 
+static int __ov8856_power_on(struct ov8856 *ov8856)
+{
+	struct i2c_client *client = v4l2_get_subdevdata(&ov8856->sd);
+	int ret;
+
+	ret = clk_prepare_enable(ov8856->xvclk);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to enable xvclk\n");
+		return ret;
+	}
+
+	gpiod_set_value_cansleep(ov8856->n_shutdn_gpio, GPIOD_OUT_LOW);
+
+	ret = regulator_bulk_enable(OV8856_NUM_SUPPLIES, ov8856->supplies);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to enable regulators\n");
+		goto disable_clk;
+	}
+
+	gpiod_set_value_cansleep(ov8856->n_shutdn_gpio, GPIOD_OUT_HIGH);
+
+	usleep_range(1500, 1800);
+
+	return 0;
+
+disable_clk:
+	clk_disable_unprepare(ov8856->xvclk);
+
+	return ret;
+}
+
+static void __ov8856_power_off(struct ov8856 *ov8856)
+{
+	gpiod_set_value_cansleep(ov8856->n_shutdn_gpio, GPIOD_OUT_LOW);
+	regulator_bulk_disable(OV8856_NUM_SUPPLIES, ov8856->supplies);
+	clk_disable_unprepare(ov8856->xvclk);
+}
+
+
 static int __maybe_unused ov8856_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -1175,7 +1231,7 @@ static int ov8856_remove(struct i2c_client *client)
 static int ov8856_probe(struct i2c_client *client)
 {
 	struct ov8856 *ov8856;
-	int ret;
+	int i, ret;
 
 	ret = ov8856_check_hwcfg(&client->dev);
 	if (ret) {
@@ -1189,10 +1245,45 @@ static int ov8856_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	v4l2_i2c_subdev_init(&ov8856->sd, client, &ov8856_subdev_ops);
+	ov8856->xvclk = devm_clk_get(&client->dev, "xvclk");
+	if (IS_ERR(ov8856->xvclk)) {
+		dev_err(&client->dev, "failed to get xvclk\n");
+		return -EINVAL;
+	}
+
+	ret = clk_set_rate(ov8856->xvclk, OV8856_XVCLK_24);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to set xvclk rate (24MHz)\n");
+		return ret;
+	}
+
+	ov8856->n_shutdn_gpio = devm_gpiod_get(&client->dev, "reset",
+					       GPIOD_OUT_LOW);
+	if (IS_ERR(ov8856->n_shutdn_gpio)) {
+		dev_err(&client->dev, "failed to get reset-gpios\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < OV8856_NUM_SUPPLIES; i++)
+		ov8856->supplies[i].supply = ov8856_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&client->dev, OV8856_NUM_SUPPLIES,
+				      ov8856->supplies);
+	if (ret) {
+		dev_warn(&client->dev, "failed to get regulators\n");
+		return ret;
+	}
+
+	ret = __ov8856_power_on(ov8856);
+	if (ret) {
+		dev_warn(&client->dev, "failed to power on\n");
+		return ret;
+	}
+
 	ret = ov8856_identify_module(ov8856);
 	if (ret) {
 		dev_err(&client->dev, "failed to find sensor: %d", ret);
-		return ret;
+		goto probe_power_off;
 	}
 
 	mutex_init(&ov8856->mutex);
@@ -1238,6 +1329,9 @@ static int ov8856_probe(struct i2c_client *client)
 	v4l2_ctrl_handler_free(ov8856->sd.ctrl_handler);
 	mutex_destroy(&ov8856->mutex);
 
+probe_power_off:
+	__ov8856_power_off(ov8856);
+
 	return ret;
 }
 
@@ -1254,11 +1348,18 @@ static const struct acpi_device_id ov8856_acpi_ids[] = {
 MODULE_DEVICE_TABLE(acpi, ov8856_acpi_ids);
 #endif
 
+static const struct of_device_id ov8856_of_match[] = {
+	{ .compatible = "ovti,ov8856" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ov8856_of_match);
+
 static struct i2c_driver ov8856_i2c_driver = {
 	.driver = {
 		.name = "ov8856",
 		.pm = &ov8856_pm_ops,
 		.acpi_match_table = ACPI_PTR(ov8856_acpi_ids),
+		.of_match_table = ov8856_of_match,
 	},
 	.probe_new = ov8856_probe,
 	.remove = ov8856_remove,
-- 
2.20.1

