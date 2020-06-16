Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D223C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D1B20739
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="u7ES9Sgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgFPI00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:26:26 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:19855 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgFPI0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592295983; x=1623831983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tnuVjKf68iQPKV3kfPktS/BFcn/FuHT5VzoKzWI08Qc=;
  b=u7ES9SgbX4jwrASuuNKS/j2+pS6aWFfUHFwWZiwuwSDe3C5oyi6G0thg
   PCEoJMT6waQMwj4spNmhD5UdDzMxCP2YaQwpC3cglKpvHCYGp0xyJZW7U
   reKxSudeYFa7vIJPByGvXLqCPILl8l1wSmbC40P/IR1S3kqBjpxlu0ryA
   TTy3yKeSoqKSWp3akAeVrUQcXTVVS9a7JfKt6s+5+aQVAKffJWu0qRUAI
   nSUZS6g6E01jtihZGp/PBit3Ulu7Bg1Z9+Vz/uQkqz8I1GVB6qEiIEr33
   BbwNiSXxulsrf1oVRLZd5uEDeTy9ri7PH/YFrdjlr0lO+FzW4kM2M2qBq
   Q==;
IronPort-SDR: 403Vml5SiLZQWr9N4Qe6SHADyH6fj9ZxzF3dkBVEWQ2JiTJzoavxQ25jGaO9NWS5gkBFuM8ikP
 u6HfRvuoZIsXFhsULnwdn5u8zfFQBQrwsX+eVQXiRH8Kt06V6+sYjjKeKbrrUzqqAGxqD2Dbvj
 IhEOA36cesYg0EpbkXJPndQJSDAqCPUowxDcJV2TXWWgpw+nRyJbL3KHIWz4NC81b2wPgkVwh9
 7tktFypAn7dy3UfevFOQyvI361KNi8GRHbDMben5EgN+dcpI6J13SJLC353r2lJ0xUsqRX3zNn
 sNU=
X-IronPort-AV: E=Sophos;i="5.73,518,1583218800"; 
   d="scan'208";a="79621947"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2020 01:26:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 16 Jun 2020 01:26:20 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 16 Jun 2020 01:26:18 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 3/3] hwmon: sparx5: Add Sparx5 SoC temperature driver
Date:   Tue, 16 Jun 2020 10:25:56 +0200
Message-ID: <20200616082556.27877-4-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616082556.27877-1-lars.povlsen@microchip.com>
References: <20200616082556.27877-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a temperature sensor driver to the Sparx5 SoC.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 drivers/hwmon/Kconfig       |  10 +++
 drivers/hwmon/Makefile      |   1 +
 drivers/hwmon/sparx5-temp.c | 136 ++++++++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)
 create mode 100644 drivers/hwmon/sparx5-temp.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 288ae9f63588c..7fb5e0c6c6306 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -515,6 +515,16 @@ config SENSORS_I5K_AMB
 	  This driver can also be built as a module. If so, the module
 	  will be called i5k_amb.
 
+config SENSORS_SPARX5
+	tristate "Sparx5 SoC temperature sensor"
+	depends on ARCH_SPARX5 || COMPILE_TEST
+	help
+	  If you say yes here you get support for temperature monitoring
+	  with the Microchip Sparx5 SoC.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called sparx5-temp.
+
 config SENSORS_F71805F
 	tristate "Fintek F71805F/FG, F71806F/FG and F71872F/FG"
 	depends on !PPC
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 3e32c21f5efe3..857293f650412 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -167,6 +167,7 @@ obj-$(CONFIG_SENSORS_SMM665)	+= smm665.o
 obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
 obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
+obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
 obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
 obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
 obj-$(CONFIG_SENSORS_TC74)	+= tc74.o
diff --git a/drivers/hwmon/sparx5-temp.c b/drivers/hwmon/sparx5-temp.c
new file mode 100644
index 0000000000000..4ed8a2aec3ae9
--- /dev/null
+++ b/drivers/hwmon/sparx5-temp.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Sparx5 SoC temperature sensor driver
+ *
+ * Copyright (C) 2020 Lars Povlsen <lars.povlsen@microchip.com>
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/hwmon.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/bitfield.h>
+
+#define TEMP_CTRL		0
+#define TEMP_CFG		4
+#define  TEMP_CFG_CYCLES	GENMASK(24, 15)
+#define  TEMP_CFG_ENA		BIT(0)
+#define TEMP_STAT		8
+#define  TEMP_STAT_VALID	BIT(12)
+#define  TEMP_STAT_TEMP		GENMASK(11, 0)
+
+struct s5_hwmon {
+	void __iomem *base;
+};
+
+static void s5_temp_enable(struct s5_hwmon *hwmon)
+{
+	u32 val = readl(hwmon->base + TEMP_CFG);
+	u32 clk = 250;
+
+	val &= ~TEMP_CFG_CYCLES;
+	val |= FIELD_PREP(TEMP_CFG_CYCLES, clk);
+	val |= TEMP_CFG_ENA;
+
+	writel(val, hwmon->base + TEMP_CFG);
+}
+
+static int s5_read(struct device *dev, enum hwmon_sensor_types type,
+		   u32 attr, int channel, long *temp)
+{
+	struct s5_hwmon *hwmon = dev_get_drvdata(dev);
+	int rc = 0, value;
+	u32 stat;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		stat = readl_relaxed(hwmon->base + TEMP_STAT);
+		if (!(stat & TEMP_STAT_VALID))
+			return -EIO;
+		value = stat & TEMP_STAT_TEMP;
+		value = DIV_ROUND_CLOSEST(value * 3522, 4096) - 1094;
+		value *= 100;
+		*temp = value;
+		break;
+	default:
+		rc = -EOPNOTSUPP;
+		break;
+	}
+
+	return rc;
+}
+
+static umode_t s5_is_visible(const void *_data, enum hwmon_sensor_types type,
+			     u32 attr, int channel)
+{
+	if (type != hwmon_temp)
+		return 0;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		return 0444;
+	default:
+		return 0;
+	}
+}
+
+static const struct hwmon_channel_info *s5_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops s5_hwmon_ops = {
+	.is_visible = s5_is_visible,
+	.read = s5_read,
+};
+
+static const struct hwmon_chip_info s5_chip_info = {
+	.ops = &s5_hwmon_ops,
+	.info = s5_info,
+};
+
+static int s5_temp_probe(struct platform_device *pdev)
+{
+	struct device *hwmon_dev;
+	struct s5_hwmon *hwmon;
+
+	hwmon = devm_kzalloc(&pdev->dev, sizeof(*hwmon), GFP_KERNEL);
+	if (!hwmon)
+		return -ENOMEM;
+
+	hwmon->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(hwmon->base))
+		return PTR_ERR(hwmon->base);
+
+	s5_temp_enable(hwmon);
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
+							 "s5_temp",
+							 hwmon,
+							 &s5_chip_info,
+							 NULL);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+const struct of_device_id s5_temp_match[] = {
+	{ .compatible = "microchip,sparx5-temp" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, s5_temp_match);
+
+static struct platform_driver s5_temp_driver = {
+	.probe = s5_temp_probe,
+	.driver = {
+		.name = "sparx5-temp",
+		.of_match_table = s5_temp_match,
+	},
+};
+
+module_platform_driver(s5_temp_driver);
+
+MODULE_AUTHOR("Lars Povlsen <lars.povlsen@microchip.com>");
+MODULE_DESCRIPTION("Sparx5 SoC temperature sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.27.0

