Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7985EC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5545A206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgCFOMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:12:30 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39022 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgCFOM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:12:29 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E4CF7280694
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Andrzej Hajda <a.hajda@samsung.com>, megous@megous.com,
        anarsoul@gmail.com, Neil Armstrong <narmstrong@baylibre.com>,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        icenowy@aosc.io, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 2/4] mfd: anx7688: Add driver for Analogix ANX7688 chip
Date:   Fri,  6 Mar 2020 15:12:14 +0100
Message-Id: <20200306141217.423914-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306141217.423914-1-enric.balletbo@collabora.com>
References: <20200306141217.423914-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ANX7688 chip is a Type-C Port Controller, HDMI to DP converter and
USB-C mux between USB 3.0 lanes and the DP output.

For our use case a big part of the chip, like power supplies, control
gpios and usb-c parts are managed by an Embedded Controller, hence,
this is its simplest form of it. Other users of this chip might
introduce new functionalities as per their requirements.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3: None
Changes in v2: None

 drivers/mfd/Kconfig         | 11 +++++
 drivers/mfd/Makefile        |  1 +
 drivers/mfd/anx7688.c       | 87 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/anx7688.h | 39 +++++++++++++++++
 4 files changed, 138 insertions(+)
 create mode 100644 drivers/mfd/anx7688.c
 create mode 100644 include/linux/mfd/anx7688.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 2b203290e7b9..ac4ef4f20518 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -51,6 +51,17 @@ config MFD_ACT8945A
 	  linear regulators, along with a complete ActivePath battery
 	  charger.
 
+config MFD_ANX7688
+	tristate "Analogix ANX7688"
+	select MFD_CORE
+	select REGMAP_I2C
+	depends on I2C && OF
+	help
+	  Support the ANX7688 from Analogix. This device features a USB
+	  Type-C Port Controller (TCPC), and HDMI to DP converter, and
+	  USB-C mux between USB 3.0 lanes and the DP output of the
+	  embedded converter.
+
 config MFD_SUN4I_GPADC
 	tristate "Allwinner sunxi platforms' GPADC MFD driver"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index b83f172545e1..4c6ca8a7d260 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_MFD_88PM800)	+= 88pm800.o 88pm80x.o
 obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
 obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
 obj-$(CONFIG_MFD_SM501)		+= sm501.o
+obj-$(CONFIG_MFD_ANX7688)	+= anx7688.o
 obj-$(CONFIG_MFD_ASIC3)		+= asic3.o tmio_core.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
 obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
diff --git a/drivers/mfd/anx7688.c b/drivers/mfd/anx7688.c
new file mode 100644
index 000000000000..fab7ed410c46
--- /dev/null
+++ b/drivers/mfd/anx7688.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * HDMI to USB Type-C Bridge and Port Controller with MUX
+ *
+ * Copyright 2020 Google LLC
+ */
+
+#include <linux/i2c.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mfd/anx7688.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regmap.h>
+
+static const struct regmap_config anx7688_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int anx7688_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct anx7688 *anx7688;
+	u16 vendor, device;
+	u8 buffer[4];
+	int ret;
+
+	anx7688 = devm_kzalloc(dev, sizeof(*anx7688), GFP_KERNEL);
+	if (!anx7688)
+		return -ENOMEM;
+
+	anx7688->client = client;
+	i2c_set_clientdata(client, anx7688);
+
+	anx7688->regmap = devm_regmap_init_i2c(client, &anx7688_regmap_config);
+
+	/* Read both vendor and device id (4 bytes). */
+	ret = regmap_bulk_read(anx7688->regmap, ANX7688_VENDOR_ID_REG,
+			       buffer, 4);
+	if (ret) {
+		dev_err(dev, "Failed to read chip vendor/device id\n");
+		return ret;
+	}
+
+	vendor = (u16)buffer[1] << 8 | buffer[0];
+	device = (u16)buffer[3] << 8 | buffer[2];
+	if (vendor != ANX7688_VENDOR_ID || device != ANX7688_DEVICE_ID) {
+		dev_err(dev, "Invalid vendor/device id %04x/%04x\n",
+			vendor, device);
+		return -ENODEV;
+	}
+
+	ret = regmap_bulk_read(anx7688->regmap, ANX7688_FW_VERSION_REG,
+			       buffer, 2);
+	if (ret) {
+		dev_err(&client->dev, "Failed to read firmware version\n");
+		return ret;
+	}
+
+	anx7688->fw_version = (u16)buffer[0] << 8 | buffer[1];
+	dev_info(dev, "ANX7688 firwmare version 0x%04x\n",
+		 anx7688->fw_version);
+
+	return devm_of_platform_populate(dev);
+}
+
+static const struct of_device_id anx7688_match_table[] = {
+	{ .compatible = "analogix,anx7688", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, anx7688_match_table);
+
+static struct i2c_driver anx7688_driver = {
+	.probe_new = anx7688_i2c_probe,
+	.driver = {
+		.name = "anx7688",
+		.of_match_table = anx7688_match_table,
+	},
+};
+
+module_i2c_driver(anx7688_driver);
+
+MODULE_DESCRIPTION("HDMI to USB Type-C Bridge and Port Controller with MUX driver");
+MODULE_AUTHOR("Nicolas Boichat <drinkcat@chromium.org>");
+MODULE_AUTHOR("Enric Balletbo i Serra <enric.balletbo@collabora.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/anx7688.h b/include/linux/mfd/anx7688.h
new file mode 100644
index 000000000000..f2760856f045
--- /dev/null
+++ b/include/linux/mfd/anx7688.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * HDMI to USB Type-C Bridge and Port Controller with MUX
+ *
+ * Copyright 2020 Google LLC
+ */
+#ifndef __LINUX_MFD_ANX7688_H
+#define __LINUX_MFD_ANX7688_H
+
+#include <linux/types.h>
+
+/* Register addresses */
+#define ANX7688_VENDOR_ID_REG		0x00
+#define ANX7688_DEVICE_ID_REG		0x02
+
+#define ANX7688_FW_VERSION_REG		0x80
+
+#define ANX7688_DP_BANDWIDTH_REG	0x85
+#define ANX7688_DP_LANE_COUNT_REG	0x86
+
+#define ANX7688_VENDOR_ID		0x1f29
+#define ANX7688_DEVICE_ID		0x7688
+
+/* First supported firmware version (0.85) */
+#define ANX7688_MINIMUM_FW_VERSION	0x0085
+
+struct gpio_desc;
+struct i2c_client;
+struct regulator;
+struct regmap;
+
+struct anx7688 {
+	struct i2c_client *client;
+	struct regmap *regmap;
+
+	u16 fw_version;
+};
+
+#endif /* __LINUX_MFD_ANX7688_H */
-- 
2.25.1

