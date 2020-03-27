Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CC6C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE4B206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgC0Udq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:33:46 -0400
Received: from lists.gateworks.com ([108.161.130.12]:43560 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbgC0Udp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 16:33:45 -0400
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1jHvhH-0006P8-NI; Fri, 27 Mar 2020 20:35:19 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Lee Jones <lee.jones@linaro.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Jones <rjones@gateworks.com>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v8 2/3] mfd: add Gateworks System Controller core driver
Date:   Fri, 27 Mar 2020 13:33:33 -0700
Message-Id: <1585341214-25285-3-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585341214-25285-1-git-send-email-tharvey@gateworks.com>
References: <1585341214-25285-1-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gateworks System Controller (GSC) is an I2C slave controller
implemented with an MSP430 micro-controller whose firmware embeds the
following features:
 - I/O expander (16 GPIO's) using PCA955x protocol
 - Real Time Clock using DS1672 protocol
 - User EEPROM using AT24 protocol
 - HWMON using custom protocol
 - Interrupt controller with tamper detect, user pushbotton
 - Watchdog controller capable of full board power-cycle
 - Power Control capable of full board power-cycle

see http://trac.gateworks.com/wiki/gsc for more details

Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v8:
- whitespace fixes
- describe sub-devices in Kconfig
- add error print for invalid command
- update copyright
- use devm_of_platform_populate
- use probe_new
- move hwmon's regmap init to hwmon

v7:
- remove irq from private data struct

v6:
- remove duplicate signature and fix commit log

v5:
- simplify powerdown function

v4:
- remove hwmon max reg check/define
- fix powerdown function

v3:
- rename gsc->gateworks-gsc
- remove uncecessary include for linux/mfd/core.h
- upercase I2C in comments
- remove i2c debug
- remove uncecessary comments
- don't use KBUILD_MODNAME for name
- remove unnecessary v1/v2/v3 tracking
- unregister hwmon i2c adapter on remove

v2:
- change license comment block style
- remove COMPILE_TEST (Randy)
- fixed whitespace issues
- replaced a printk with dev_err
---
 MAINTAINERS                 |   8 ++
 drivers/mfd/Kconfig         |  10 ++
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/gateworks-gsc.c | 288 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/gsc.h     |  73 +++++++++++
 5 files changed, 380 insertions(+)
 create mode 100644 drivers/mfd/gateworks-gsc.c
 create mode 100644 include/linux/mfd/gsc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 56765f5..bb79b60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6839,6 +6839,14 @@ F:	tools/testing/selftests/futex/
 F:	tools/perf/bench/futex*
 F:	Documentation/*futex*
 
+GATEWORKS SYSTEM CONTROLLER (GSC) DRIVER
+M:	Tim Harvey <tharvey@gateworks.com>
+M:	Robert Jones <rjones@gateworks.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
+F:	drivers/mfd/gateworks-gsc.c
+F:	include/linux/mfd/gsc.h
+
 GCC PLUGINS
 M:	Kees Cook <keescook@chromium.org>
 R:	Emese Revfy <re.emese@gmail.com>
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 4209008..d84725a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -407,6 +407,16 @@ config MFD_EXYNOS_LPASS
 	  Select this option to enable support for Samsung Exynos Low Power
 	  Audio Subsystem.
 
+config MFD_GATEWORKS_GSC
+	tristate "Gateworks System Controller"
+	depends on (I2C && OF)
+	select MFD_CORE
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	help
+	  Enable support for the Gateworks System Controller found
+	  on Gateworks Single Board Computers.
+
 config MFD_MC13XXX
 	tristate
 	depends on (SPI_MASTER || I2C)
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index aed99f0..c82b442 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
 obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
 obj-$(CONFIG_MFD_CROS_EC_DEV)	+= cros_ec_dev.o
 obj-$(CONFIG_MFD_EXYNOS_LPASS)	+= exynos-lpass.o
+obj-$(CONFIG_MFD_GATEWORKS_GSC)	+= gateworks-gsc.o
 
 obj-$(CONFIG_HTC_PASIC3)	+= htc-pasic3.o
 obj-$(CONFIG_HTC_I2CPLD)	+= htc-i2cpld.o
diff --git a/drivers/mfd/gateworks-gsc.c b/drivers/mfd/gateworks-gsc.c
new file mode 100644
index 00000000..020e1e1
--- /dev/null
+++ b/drivers/mfd/gateworks-gsc.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The Gateworks System Controller (GSC) is a multi-function
+ * device designed for use in Gateworks Single Board Computers.
+ * The control interface is I2C, with an interrupt. The device supports
+ * system functions such as pushbutton monitoring, multiple ADC's for
+ * voltage and temperature, fan controller, and watchdog monitor.
+ *
+ * Copyright (C) 2020 Gateworks Corporation
+ */
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/gsc.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+/*
+ * The GSC suffers from an errata where occasionally during
+ * ADC cycles the chip can NAK I2C transactions. To ensure we have reliable
+ * register access we place retries around register access.
+ */
+#define I2C_RETRIES	3
+
+static int gsc_regmap_regwrite(void *context, unsigned int reg,
+			       unsigned int val)
+{
+	struct i2c_client *client = context;
+	int retry, ret;
+
+	for (retry = 0; retry < I2C_RETRIES; retry++) {
+		ret = i2c_smbus_write_byte_data(client, reg, val);
+		/*
+		 * -EAGAIN returned when the i2c host controller is busy
+		 * -EIO returned when i2c device is busy
+		 */
+		if (ret != -EAGAIN && ret != -EIO)
+			break;
+	}
+
+	return 0;
+}
+
+static int gsc_regmap_regread(void *context, unsigned int reg,
+			      unsigned int *val)
+{
+	struct i2c_client *client = context;
+	int retry, ret;
+
+	for (retry = 0; retry < I2C_RETRIES; retry++) {
+		ret = i2c_smbus_read_byte_data(client, reg);
+		/*
+		 * -EAGAIN returned when the i2c host controller is busy
+		 * -EIO returned when i2c device is busy
+		 */
+		if (ret != -EAGAIN && ret != -EIO)
+			break;
+	}
+	*val = ret & 0xff;
+
+	return 0;
+}
+
+/*
+ * gsc_powerdown - API to use GSC to power down board for a specific time
+ *
+ * secs - number of seconds to remain powered off
+ */
+static int gsc_powerdown(struct gsc_dev *gsc, unsigned long secs)
+{
+	int ret;
+	unsigned char regs[4];
+
+	dev_info(&gsc->i2c->dev, "GSC powerdown for %ld seconds\n",
+		 secs);
+
+	regs[0] = secs & 0xff;
+	regs[1] = (secs >> 8) & 0xff;
+	regs[2] = (secs >> 16) & 0xff;
+	regs[3] = (secs >> 24) & 0xff;
+
+	ret = regmap_bulk_write(gsc->regmap, GSC_TIME_ADD, regs, 4);
+	if (ret)
+		return ret;
+
+	regs[0] = 1 << GSC_CTRL_1_LATCH_SLEEP_ADD;
+
+	ret = regmap_update_bits(gsc->regmap, GSC_CTRL_1, regs[0], regs[0]);
+	if (ret)
+		return ret;
+
+	regs[0] = (1 << GSC_CTRL_1_ACTIVATE_SLEEP) |
+		(1 << GSC_CTRL_1_SLEEP_ENABLE);
+
+	ret = regmap_update_bits(gsc->regmap, GSC_CTRL_1, regs[0], regs[0]);
+
+	return ret;
+}
+
+static ssize_t gsc_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct gsc_dev *gsc = dev_get_drvdata(dev);
+	const char *name = attr->attr.name;
+	int rz = 0;
+
+	if (strcasecmp(name, "fw_version") == 0)
+		rz = sprintf(buf, "%d\n", gsc->fwver);
+	else if (strcasecmp(name, "fw_crc") == 0)
+		rz = sprintf(buf, "0x%04x\n", gsc->fwcrc);
+	else
+		dev_err(dev, "invalid command: '%s'\n", name);
+
+	return rz;
+}
+
+static ssize_t gsc_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	struct gsc_dev *gsc = dev_get_drvdata(dev);
+	const char *name = attr->attr.name;
+	long value;
+
+	if (strcasecmp(name, "powerdown") == 0) {
+		if (kstrtol(buf, 0, &value) == 0)
+			gsc_powerdown(gsc, value);
+	} else {
+		dev_err(dev, "invalid command: '%s\n", name);
+	}
+
+	return count;
+}
+
+static struct device_attribute attr_fwver =
+	__ATTR(fw_version, 0440, gsc_show, NULL);
+static struct device_attribute attr_fwcrc =
+	__ATTR(fw_crc, 0440, gsc_show, NULL);
+static struct device_attribute attr_pwrdown =
+	__ATTR(powerdown, 0220, NULL, gsc_store);
+
+static struct attribute *gsc_attrs[] = {
+	&attr_fwver.attr,
+	&attr_fwcrc.attr,
+	&attr_pwrdown.attr,
+	NULL,
+};
+
+static struct attribute_group attr_group = {
+	.attrs = gsc_attrs,
+};
+
+static const struct of_device_id gsc_of_match[] = {
+	{ .compatible = "gw,gsc", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gsc_of_match);
+
+static const struct regmap_config gsc_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_NONE,
+	.max_register = 0xf,
+};
+
+static const struct regmap_irq gsc_irqs[] = {
+	REGMAP_IRQ_REG(GSC_IRQ_PB, 0, BIT(GSC_IRQ_PB)),
+	REGMAP_IRQ_REG(GSC_IRQ_KEY_ERASED, 0, BIT(GSC_IRQ_KEY_ERASED)),
+	REGMAP_IRQ_REG(GSC_IRQ_EEPROM_WP, 0, BIT(GSC_IRQ_EEPROM_WP)),
+	REGMAP_IRQ_REG(GSC_IRQ_RESV, 0, BIT(GSC_IRQ_RESV)),
+	REGMAP_IRQ_REG(GSC_IRQ_GPIO, 0, BIT(GSC_IRQ_GPIO)),
+	REGMAP_IRQ_REG(GSC_IRQ_TAMPER, 0, BIT(GSC_IRQ_TAMPER)),
+	REGMAP_IRQ_REG(GSC_IRQ_WDT_TIMEOUT, 0, BIT(GSC_IRQ_WDT_TIMEOUT)),
+	REGMAP_IRQ_REG(GSC_IRQ_SWITCH_HOLD, 0, BIT(GSC_IRQ_SWITCH_HOLD)),
+};
+
+static const struct regmap_irq_chip gsc_irq_chip = {
+	.name = "gateworks-gsc",
+	.irqs = gsc_irqs,
+	.num_irqs = ARRAY_SIZE(gsc_irqs),
+	.num_regs = 1,
+	.status_base = GSC_IRQ_STATUS,
+	.mask_base = GSC_IRQ_ENABLE,
+	.mask_invert = true,
+	.ack_base = GSC_IRQ_STATUS,
+	.ack_invert = true,
+};
+
+static int gsc_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct gsc_dev *gsc;
+	int ret;
+	unsigned int reg;
+
+	gsc = devm_kzalloc(dev, sizeof(*gsc), GFP_KERNEL);
+	if (!gsc)
+		return -ENOMEM;
+
+	gsc->dev = &client->dev;
+	gsc->i2c = client;
+	i2c_set_clientdata(client, gsc);
+
+	gsc->bus.reg_write = gsc_regmap_regwrite;
+	gsc->bus.reg_read = gsc_regmap_regread;
+	gsc->regmap = devm_regmap_init(dev, &gsc->bus, client,
+				       &gsc_regmap_config);
+	if (IS_ERR(gsc->regmap))
+		return PTR_ERR(gsc->regmap);
+
+	if (regmap_read(gsc->regmap, GSC_FW_VER, &reg))
+		return -EIO;
+	gsc->fwver = reg;
+
+	regmap_read(gsc->regmap, GSC_FW_CRC, &reg);
+	gsc->fwcrc = reg;
+	regmap_read(gsc->regmap, GSC_FW_CRC + 1, &reg);
+	gsc->fwcrc |= reg << 8;
+
+	gsc->i2c_hwmon = i2c_new_dummy_device(client->adapter, GSC_HWMON);
+	if (!gsc->i2c_hwmon) {
+		dev_err(dev, "Failed to allocate I2C device for HWMON\n");
+		return -ENODEV;
+	}
+	i2c_set_clientdata(gsc->i2c_hwmon, gsc);
+
+	ret = devm_regmap_add_irq_chip(dev, gsc->regmap, client->irq,
+				       IRQF_ONESHOT | IRQF_SHARED |
+				       IRQF_TRIGGER_FALLING, 0,
+				       &gsc_irq_chip, &gsc->irq_chip_data);
+	if (ret)
+		goto err_regmap;
+
+	dev_info(dev, "Gateworks System Controller v%d: fw 0x%04x\n",
+		 gsc->fwver, gsc->fwcrc);
+
+	ret = sysfs_create_group(&dev->kobj, &attr_group);
+	if (ret)
+		dev_err(dev, "failed to create sysfs attrs\n");
+
+	ret = devm_of_platform_populate(dev);
+	if (ret)
+		goto err_sysfs;
+
+	return 0;
+
+err_sysfs:
+	sysfs_remove_group(&dev->kobj, &attr_group);
+err_regmap:
+	i2c_unregister_device(gsc->i2c_hwmon);
+
+	return ret;
+}
+
+static int gsc_remove(struct i2c_client *client)
+{
+	struct gsc_dev *gsc = i2c_get_clientdata(client);
+
+	sysfs_remove_group(&client->dev.kobj, &attr_group);
+	i2c_unregister_device(gsc->i2c_hwmon);
+
+	return 0;
+}
+
+static const struct i2c_device_id gsc_id_table[] = {
+	{"gsc", GSC_MISC },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, gsc_id_table);
+
+static struct i2c_driver gsc_driver = {
+	.driver = {
+		.name	= "gateworks-gsc",
+		.of_match_table = gsc_of_match,
+	},
+	.id_table	= gsc_id_table,
+	.probe_new	= gsc_probe,
+	.remove		= gsc_remove,
+};
+
+module_i2c_driver(gsc_driver);
+
+MODULE_AUTHOR("Tim Harvey <tharvey@gateworks.com>");
+MODULE_DESCRIPTION("I2C Core interface for GSC");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/gsc.h b/include/linux/mfd/gsc.h
new file mode 100644
index 00000000..fc33647
--- /dev/null
+++ b/include/linux/mfd/gsc.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2020 Gateworks Corporation
+ */
+#ifndef __LINUX_MFD_GSC_H_
+#define __LINUX_MFD_GSC_H_
+
+#include <linux/regmap.h>
+
+/* Device Addresses */
+#define GSC_MISC	0x20
+#define GSC_UPDATE	0x21
+#define GSC_GPIO	0x23
+#define GSC_HWMON	0x29
+#define GSC_EEPROM0	0x50
+#define GSC_EEPROM1	0x51
+#define GSC_EEPROM2	0x52
+#define GSC_EEPROM3	0x53
+#define GSC_RTC		0x68
+
+/* Register offsets */
+#define GSC_CTRL_0	0x00
+#define GSC_CTRL_1	0x01
+#define GSC_TIME	0x02
+#define GSC_TIME_ADD	0x06
+#define GSC_IRQ_STATUS	0x0A
+#define GSC_IRQ_ENABLE	0x0B
+#define GSC_FW_CRC	0x0C
+#define GSC_FW_VER	0x0E
+#define GSC_WP		0x0F
+
+/* Bit definitions */
+#define GSC_CTRL_0_PB_HARD_RESET	0
+#define GSC_CTRL_0_PB_CLEAR_SECURE_KEY	1
+#define GSC_CTRL_0_PB_SOFT_POWER_DOWN	2
+#define GSC_CTRL_0_PB_BOOT_ALTERNATE	3
+#define GSC_CTRL_0_PERFORM_CRC		4
+#define GSC_CTRL_0_TAMPER_DETECT	5
+#define GSC_CTRL_0_SWITCH_HOLD		6
+
+#define GSC_CTRL_1_SLEEP_ENABLE		0
+#define GSC_CTRL_1_ACTIVATE_SLEEP	1
+#define GSC_CTRL_1_LATCH_SLEEP_ADD	2
+#define GSC_CTRL_1_SLEEP_NOWAKEPB	3
+#define GSC_CTRL_1_WDT_TIME		4
+#define GSC_CTRL_1_WDT_ENABLE		5
+#define GSC_CTRL_1_SWITCH_BOOT_ENABLE	6
+#define GSC_CTRL_1_SWITCH_BOOT_CLEAR	7
+
+#define GSC_IRQ_PB			0
+#define GSC_IRQ_KEY_ERASED		1
+#define GSC_IRQ_EEPROM_WP		2
+#define GSC_IRQ_RESV			3
+#define GSC_IRQ_GPIO			4
+#define GSC_IRQ_TAMPER			5
+#define GSC_IRQ_WDT_TIMEOUT		6
+#define GSC_IRQ_SWITCH_HOLD		7
+
+struct gsc_dev {
+	struct device *dev;
+
+	struct i2c_client *i2c;		/* 0x20: interrupt controller, WDT */
+	struct i2c_client *i2c_hwmon;	/* 0x29: hwmon, fan controller */
+
+	struct regmap *regmap;
+	struct regmap_bus bus;
+	struct regmap_irq_chip_data *irq_chip_data;
+
+	unsigned int fwver;
+	unsigned short fwcrc;
+};
+
+#endif /* __LINUX_MFD_GSC_H_ */
-- 
2.7.4

