Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABDDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E868120656
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="L4kosCPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgFROAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:00:35 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:52085 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgFROAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592488822; x=1624024822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QB9wm8Fo6I2/YhcmOTVX/KxCde3ih10btCAG/q4hqX4=;
  b=L4kosCPCQQTjhL4YoDHKx8mnea7vHmvlvObP5sEoK7jSBc4sYRh+8lLW
   n3kM+vBACoe0wNX1+RpwY0nq5nFpgi/77KJUif/6Kqi2dS3bunSf/D+r9
   asKX0TkJ+/Z9XwqvhnGT2KpmDU6cgWdqfwD6F9q9wkoFHgEUJYLUV6rUc
   D23fSNrYfiTBHQQeTcygpkl/irHiGh4Hbs/UMiy1HuG3O0NPePH4tIgOd
   Jx7cv/axetRlXc+GJJaIdspP7K8yuXsofnlKkkbS73afGU2ZjYLe9Mp7P
   73K1tO4nPjPjWfecTTwG8mnpdApsvR72w5YVhD/T1blsH7ANtz9KZNmli
   A==;
IronPort-SDR: f0aEsqmIh9JqiIDzUadnFBk2wzwGUZs/QD7/YV6FO8bg0GzRrNg+jDDGlVIWL0RO83y2JPv+eV
 IzAdzuYawhTHRKrus5guwGESAvJdrF1KFmaBPhuYl2tv6zMB78djyuqoEUbDYx99dk45VR2gUY
 brnG5tUri9rEbMY4DKKVGp0RApa4k3w0/5KtPyzD1/sKjV0qhThL205pEg8a28Xv7/LqHKIEcK
 aJ7xbZD0VfWgRKr27K1C5SO4+e8KV58U1+vMK/nQMFJfpOKX0CoM12LnZcefgM0ItAdJcXKxja
 0cM=
X-IronPort-AV: E=Sophos;i="5.73,526,1583218800"; 
   d="scan'208";a="78949088"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jun 2020 07:00:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 07:00:14 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 18 Jun 2020 07:00:18 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v4 3/3] hwmon: sparx5: Add Sparx5 SoC temperature driver
Date:   Thu, 18 Jun 2020 15:59:51 +0200
Message-ID: <20200618135951.25441-4-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618135951.25441-1-lars.povlsen@microchip.com>
References: <20200618135951.25441-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a temperature sensor driver to the Sparx5 SoC.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 Documentation/hwmon/sparx5-temp.rst |  33 ++++++
 drivers/hwmon/Kconfig               |  10 ++
 drivers/hwmon/Makefile              |   1 +
 drivers/hwmon/sparx5-temp.c         | 168 ++++++++++++++++++++++++++++
 4 files changed, 212 insertions(+)
 create mode 100644 Documentation/hwmon/sparx5-temp.rst
 create mode 100644 drivers/hwmon/sparx5-temp.c

diff --git a/Documentation/hwmon/sparx5-temp.rst b/Documentation/hwmon/sparx5-temp.rst
new file mode 100644
index 0000000000000..0140809089542
--- /dev/null
+++ b/Documentation/hwmon/sparx5-temp.rst
@@ -0,0 +1,33 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Microchip SparX-5 SoC
+=====================
+
+Supported chips:
+
+  * VSC7546, VSC7549, VSC755, VSC7556, and VSC7558 (Sparx5 series)
+
+    Prefix: 'sparx5-temp'
+
+    Addresses scanned: -
+
+    Datasheet: Provided by Microchip upon request and under NDA
+
+Author: Lars Povlsen <lars.povlsen@microchip.com>
+
+Description
+-----------
+
+The Sparx5 SoC contains a temperature sensor based on the MR74060
+Moortec IP.
+
+The sensor has a range of -40°C to +125°C and an accuracy of +/-5°C.
+
+Sysfs entries
+-------------
+
+The following attributes are supported.
+
+======================= ========================================================
+temp1_input		Die temperature (in millidegree Celsius.)
+======================= ========================================================
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
index 0000000000000..7d7a060259a80
--- /dev/null
+++ b/drivers/hwmon/sparx5-temp.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Sparx5 SoC temperature sensor driver
+ *
+ * Copyright (C) 2020 Lars Povlsen <lars.povlsen@microchip.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/hwmon.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
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
+	struct clk *clk;
+};
+
+static void s5_temp_clk_disable(void *data)
+{
+	struct clk *clk = data;
+
+	clk_disable_unprepare(clk);
+}
+
+static void s5_temp_enable(struct s5_hwmon *hwmon)
+{
+	u32 val = readl(hwmon->base + TEMP_CFG);
+	u32 clk = clk_get_rate(hwmon->clk) / USEC_PER_SEC;
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
+		/*
+		 * From register documentation:
+		 * Temp(C) = TEMP_SENSOR_STAT.TEMP / 4096 * 352.2 - 109.4
+		 */
+		value = DIV_ROUND_CLOSEST(value * 3522, 4096) - 1094;
+		/*
+		 * Scale down by 10 from above and multiply by 1000 to
+		 * have millidegrees as specified by the hwmon sysfs
+		 * interface.
+		 */
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
+	int ret;
+
+	hwmon = devm_kzalloc(&pdev->dev, sizeof(*hwmon), GFP_KERNEL);
+	if (!hwmon)
+		return -ENOMEM;
+
+	hwmon->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(hwmon->base))
+		return PTR_ERR(hwmon->base);
+
+	hwmon->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(hwmon->clk))
+		return PTR_ERR(hwmon->clk);
+
+	ret = clk_prepare_enable(hwmon->clk);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&pdev->dev, s5_temp_clk_disable,
+				       hwmon->clk);
+	if (ret)
+		return ret;
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

