Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940E2C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 04:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE002083B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 04:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgGLEoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 00:44:22 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:37136 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgGLEoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 00:44:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 1C36A2013E75;
        Sun, 12 Jul 2020 12:44:17 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6WB6qsAVC-Dx; Sun, 12 Jul 2020 12:44:17 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 008462013F67;
        Sun, 12 Jul 2020 12:44:17 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id F1BACC019F4;
        Sun, 12 Jul 2020 12:44:16 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id EEE69202299; Sun, 12 Jul 2020 12:44:16 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] hwmon: shtc1: add support for device tree bindings
Date:   Sun, 12 Jul 2020 12:44:09 +0800
Message-Id: <20200712044411.23323-2-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200712044411.23323-1-chris.ruehl@gtsys.com.hk>
References: <20200712044411.23323-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for DTS bindings for the sensirion shtc1,shtw1 and shtc3.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/shtc1.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/shtc1.c b/drivers/hwmon/shtc1.c
index a0078ccede03..7993a5ff8768 100644
--- a/drivers/hwmon/shtc1.c
+++ b/drivers/hwmon/shtc1.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/platform_data/shtc1.h>
+#include <linux/of.h>
 
 /* commands (high precision mode) */
 static const unsigned char shtc1_cmd_measure_blocking_hpm[]    = { 0x7C, 0xA2 };
@@ -196,6 +197,7 @@ static int shtc1_probe(struct i2c_client *client,
 	enum shtcx_chips chip = id->driver_data;
 	struct i2c_adapter *adap = client->adapter;
 	struct device *dev = &client->dev;
+	struct device_node *np = dev->of_node;
 
 	if (!i2c_check_functionality(adap, I2C_FUNC_I2C)) {
 		dev_err(dev, "plain i2c transactions not supported\n");
@@ -233,8 +235,14 @@ static int shtc1_probe(struct i2c_client *client,
 	data->client = client;
 	data->chip = chip;
 
-	if (client->dev.platform_data)
-		data->setup = *(struct shtc1_platform_data *)dev->platform_data;
+	if (np) {
+		data->setup.blocking_io = of_property_read_bool(np, "sensirion,blocking-io");
+		data->setup.high_precision = !of_property_read_bool(np, "sensicon,low-precision");
+	} else {
+		if (client->dev.platform_data)
+			data->setup = *(struct shtc1_platform_data *)dev->platform_data;
+	}
+
 	shtc1_select_command(data);
 	mutex_init(&data->update_lock);
 
@@ -257,8 +265,19 @@ static const struct i2c_device_id shtc1_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, shtc1_id);
 
+static const struct of_device_id shtc1_of_match[] = {
+	{ .compatible = "sensirion,shtc1" },
+	{ .compatible = "sensirion,shtw1" },
+	{ .compatible = "sensirion,shtc3" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, shtc1_of_match);
+
 static struct i2c_driver shtc1_i2c_driver = {
-	.driver.name  = "shtc1",
+	.driver = {
+		.name = "shtc1",
+		.of_match_table = shtc1_of_match,
+	},
 	.probe        = shtc1_probe,
 	.id_table     = shtc1_id,
 };
-- 
2.20.1

