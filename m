Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72CFC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876B22082E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgA0KZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 05:25:50 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56575 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgA0KZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:25:49 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1iw1aR-0002B4-4Y; Mon, 27 Jan 2020 11:25:43 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1iw1aP-0008OY-Fb; Mon, 27 Jan 2020 11:25:41 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jean Delvare <jdelvare@suse.com>, Markus Pietrek <mpie@msc-ge.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 1/2] hwmon: (powr1220) Add support for Lattice's POWR1014 power manager IC
Date:   Mon, 27 Jan 2020 11:25:39 +0100
Message-Id: <20200127102540.31742-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Pietrek <mpie@msc-ge.com>

This patch adds support for Lattice's POWR1014 power manager IC. Read
access to all the ADCs on the chip are supported through the hwmon
sysfs files.

The main difference of POWR1014 compared to POWR1220 is amount of VMON
input lines: 10 on POWR1014 and 12 lines on POWR1220.

Signed-off-by: Markus Pietrek <mpie@msc-ge.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/hwmon/powr1220.c | 65 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/powr1220.c b/drivers/hwmon/powr1220.c
index 65997421ee3c..ad7a82f132e6 100644
--- a/drivers/hwmon/powr1220.c
+++ b/drivers/hwmon/powr1220.c
@@ -19,6 +19,9 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 
+#define I2C_CLIENT_DATA_1014 1014
+#define I2C_CLIENT_DATA_1220 1220
+
 #define ADC_STEP_MV			2
 #define ADC_MAX_LOW_MEASUREMENT_MV	2000
 
@@ -246,6 +249,51 @@ static SENSOR_DEVICE_ATTR_RO(in11_label, powr1220_label, VMON12);
 static SENSOR_DEVICE_ATTR_RO(in12_label, powr1220_label, VCCA);
 static SENSOR_DEVICE_ATTR_RO(in13_label, powr1220_label, VCCINP);
 
+static struct attribute *powr1014_attrs[] = {
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_in5_input.dev_attr.attr,
+	&sensor_dev_attr_in6_input.dev_attr.attr,
+	&sensor_dev_attr_in7_input.dev_attr.attr,
+	&sensor_dev_attr_in8_input.dev_attr.attr,
+	&sensor_dev_attr_in9_input.dev_attr.attr,
+	&sensor_dev_attr_in12_input.dev_attr.attr,
+	&sensor_dev_attr_in13_input.dev_attr.attr,
+
+	&sensor_dev_attr_in0_highest.dev_attr.attr,
+	&sensor_dev_attr_in1_highest.dev_attr.attr,
+	&sensor_dev_attr_in2_highest.dev_attr.attr,
+	&sensor_dev_attr_in3_highest.dev_attr.attr,
+	&sensor_dev_attr_in4_highest.dev_attr.attr,
+	&sensor_dev_attr_in5_highest.dev_attr.attr,
+	&sensor_dev_attr_in6_highest.dev_attr.attr,
+	&sensor_dev_attr_in7_highest.dev_attr.attr,
+	&sensor_dev_attr_in8_highest.dev_attr.attr,
+	&sensor_dev_attr_in9_highest.dev_attr.attr,
+	&sensor_dev_attr_in12_highest.dev_attr.attr,
+	&sensor_dev_attr_in13_highest.dev_attr.attr,
+
+	&sensor_dev_attr_in0_label.dev_attr.attr,
+	&sensor_dev_attr_in1_label.dev_attr.attr,
+	&sensor_dev_attr_in2_label.dev_attr.attr,
+	&sensor_dev_attr_in3_label.dev_attr.attr,
+	&sensor_dev_attr_in4_label.dev_attr.attr,
+	&sensor_dev_attr_in5_label.dev_attr.attr,
+	&sensor_dev_attr_in6_label.dev_attr.attr,
+	&sensor_dev_attr_in7_label.dev_attr.attr,
+	&sensor_dev_attr_in8_label.dev_attr.attr,
+	&sensor_dev_attr_in9_label.dev_attr.attr,
+	&sensor_dev_attr_in12_label.dev_attr.attr,
+	&sensor_dev_attr_in13_label.dev_attr.attr,
+
+	NULL
+};
+
+ATTRIBUTE_GROUPS(powr1014);
+
 static struct attribute *powr1220_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in1_input.dev_attr.attr,
@@ -300,9 +348,21 @@ ATTRIBUTE_GROUPS(powr1220);
 static int powr1220_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
+	const struct attribute_group **attr_groups = NULL;
 	struct powr1220_data *data;
 	struct device *hwmon_dev;
 
+	switch (id->driver_data) {
+	case I2C_CLIENT_DATA_1014:
+		attr_groups = powr1014_groups;
+		break;
+	case I2C_CLIENT_DATA_1220:
+		attr_groups = powr1220_groups;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
@@ -314,13 +374,14 @@ static int powr1220_probe(struct i2c_client *client,
 	data->client = client;
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
-			client->name, data, powr1220_groups);
+			client->name, data, attr_groups);
 
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id powr1220_ids[] = {
-	{ "powr1220", 0, },
+	{ "powr1014", I2C_CLIENT_DATA_1014, },
+	{ "powr1220", I2C_CLIENT_DATA_1220, },
 	{ }
 };
 
-- 
2.25.0

