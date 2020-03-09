Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADA5C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1CE20409
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgCIUid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:38:33 -0400
Received: from mail.v3.sk ([167.172.186.51]:46422 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726932AbgCIUia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:38:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id ED623DEEA2;
        Mon,  9 Mar 2020 20:38:47 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QeRkQi-eNeSp; Mon,  9 Mar 2020 20:38:43 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 83C4FE01B5;
        Mon,  9 Mar 2020 20:38:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AjW6i3vZBvhs; Mon,  9 Mar 2020 20:38:42 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 876A0DFB05;
        Mon,  9 Mar 2020 20:38:42 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 4/4] mfd: ene-kb3930: Add driver for ENE KB3930 Embedded Controller
Date:   Mon,  9 Mar 2020 21:38:18 +0100
Message-Id: <20200309203818.31266-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309203818.31266-1-lkundrak@v3.sk>
References: <20200309203818.31266-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver provides access to the EC RAM of said embedded controller
attached to the I2C bus as well as optionally supporting its slightly wei=
rd
power-off/restart protocol.

A particular implementation of the EC firmware can be identified by a
model byte. If this driver identifies the Dell Ariel platform, it
registers the appropriate cells.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/mfd/Kconfig      |  10 ++
 drivers/mfd/Makefile     |   1 +
 drivers/mfd/ene-kb3930.c | 209 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+)
 create mode 100644 drivers/mfd/ene-kb3930.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 2b203290e7b9f..d34cf1a026c86 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -398,6 +398,16 @@ config MFD_DLN2
 	  etc. must be enabled in order to use the functionality of
 	  the device.
=20
+config MFD_ENE_KB3930
+	tristate "ENE KB3930 Embedded Controller support"
+	depends on I2C
+	depends on MACH_MMP3_DT || COMPILE_TEST
+	select MFD_CORE
+	help
+	  This adds support for accessing the registers on ENE KB3930, Embedded
+	  Controller. Additional drivers such as LEDS_ARIEL must be enabled in
+	  order to use the functionality of the device.
+
 config MFD_EXYNOS_LPASS
 	tristate "Samsung Exynos SoC Low Power Audio Subsystem"
 	depends on ARCH_EXYNOS || COMPILE_TEST
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index b83f172545e1e..ee9a5260a26cd 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_ARCH_BCM2835)	+=3D bcm2835-pm.o
 obj-$(CONFIG_MFD_BCM590XX)	+=3D bcm590xx.o
 obj-$(CONFIG_MFD_BD9571MWV)	+=3D bd9571mwv.o
 obj-$(CONFIG_MFD_CROS_EC_DEV)	+=3D cros_ec_dev.o
+obj-$(CONFIG_MFD_ENE_KB3930)	+=3D ene-kb3930.o
 obj-$(CONFIG_MFD_EXYNOS_LPASS)	+=3D exynos-lpass.o
=20
 obj-$(CONFIG_HTC_PASIC3)	+=3D htc-pasic3.o
diff --git a/drivers/mfd/ene-kb3930.c b/drivers/mfd/ene-kb3930.c
new file mode 100644
index 0000000000000..1123f3a1c816a
--- /dev/null
+++ b/drivers/mfd/ene-kb3930.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0-or-later
+/*
+ * ENE KB3930 Embedded Controller Driver
+ *
+ * Copyright (C) 2020 Lubomir Rintel
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+#include <linux/mfd/core.h>
+
+enum {
+	EC_DATA_IN	=3D 0x00,
+	EC_RAM_OUT	=3D 0x80,
+	EC_RAM_IN	=3D 0x81,
+};
+
+enum {
+	EC_MODEL_ID	=3D 0x30,
+	EC_VERSION_MAJ	=3D 0x31,
+	EC_VERSION_MIN	=3D 0x32,
+};
+
+struct kb3930 {
+	struct i2c_client *client;
+	struct regmap *ec_ram;
+	struct gpio_descs *off_gpios;
+};
+
+struct kb3930 *global_kb3930;
+
+static void kb3930_off(struct kb3930 *priv, int poweroff)
+{
+	gpiod_direction_output(priv->off_gpios->desc[1], poweroff);
+
+	while (1) {
+		mdelay(50);
+		gpiod_direction_output(priv->off_gpios->desc[0], 0);
+		mdelay(50);
+		gpiod_direction_output(priv->off_gpios->desc[0], 1);
+	}
+}
+
+static int kb3930_restart(struct notifier_block *this,
+			  unsigned long mode, void *cmd)
+{
+	kb3930_off(global_kb3930, 0);
+	return NOTIFY_DONE;
+}
+
+static void kb3930_power_off(void)
+{
+	kb3930_off(global_kb3930, 1);
+}
+
+static struct notifier_block kb3930_restart_nb =3D {
+	.notifier_call =3D kb3930_restart,
+	.priority =3D 128,
+};
+
+static const struct mfd_cell ariel_ec_cells[] =3D {
+	{ .name =3D "dell-wyse-ariel-led", },
+	{ .name =3D "dell-wyse-ariel-power", },
+};
+
+static int kb3930_ec_ram_reg_write(void *context, unsigned int reg,
+				   unsigned int val)
+{
+	struct kb3930 *priv =3D context;
+
+	return i2c_smbus_write_word_data(priv->client, EC_RAM_OUT,
+					 (val << 8) | reg);
+}
+
+static int kb3930_ec_ram_reg_read(void *context, unsigned int reg,
+				  unsigned int *val)
+{
+	struct kb3930 *priv =3D context;
+	int ret;
+
+	ret =3D i2c_smbus_write_word_data(priv->client, EC_RAM_IN, reg);
+	if (ret < 0)
+		return ret;
+
+	ret =3D i2c_smbus_read_word_data(priv->client, EC_DATA_IN);
+	if (ret < 0)
+		return ret;
+
+	*val =3D ret >> 8;
+	return 0;
+}
+
+static const struct regmap_config kb3930_ec_ram_regmap_config =3D {
+	.name =3D "ec_ram",
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+	.reg_stride =3D 1,
+	.max_register =3D 0xff,
+	.reg_write =3D kb3930_ec_ram_reg_write,
+	.reg_read =3D kb3930_ec_ram_reg_read,
+	.fast_io =3D false,
+};
+
+static int kb3930_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct device *dev =3D &client->dev;
+	struct device_node *np =3D dev->of_node;
+	struct kb3930 *priv;
+	unsigned int model_id;
+	int ret;
+
+	if (global_kb3930)
+		return -EEXIST;
+
+	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	global_kb3930 =3D priv;
+	priv->client =3D client;
+	i2c_set_clientdata(client, priv);
+
+	priv->ec_ram =3D devm_regmap_init(dev, NULL, priv,
+					&kb3930_ec_ram_regmap_config);
+	if (IS_ERR(priv->ec_ram))
+		return PTR_ERR(priv->ec_ram);
+
+	ret =3D regmap_read(priv->ec_ram, EC_MODEL_ID, &model_id);
+	if (ret < 0)
+		return ret;
+
+	if (model_id =3D=3D 'J') {
+		ret =3D devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
+					   ariel_ec_cells,
+					   ARRAY_SIZE(ariel_ec_cells),
+					   NULL, 0, NULL);
+		if (ret < 0)
+			return ret;
+	} else {
+		dev_err(dev, "unknown board model: %02x\n", model_id);
+		return -ENODEV;
+	}
+
+	if (of_property_read_bool (np, "system-power-controller")) {
+		priv->off_gpios =3D devm_gpiod_get_array_optional(dev, "off",
+								GPIOD_IN);
+	}
+	if (IS_ERR(priv->off_gpios))
+		return PTR_ERR(priv->off_gpios);
+	if (priv->off_gpios->ndescs < 2) {
+		dev_err(dev, "invalid off-gpios property\n");
+		return -EINVAL;
+	}
+	if (priv->off_gpios) {
+		register_restart_handler(&kb3930_restart_nb);
+		if (pm_power_off =3D=3D NULL)
+			pm_power_off =3D kb3930_power_off;
+	}
+
+	dev_info(dev, "ENE KB3930 Embedded Controller\n");
+	return 0;
+}
+
+static int kb3930_remove(struct i2c_client *client)
+{
+	struct kb3930 *priv =3D i2c_get_clientdata(client);
+
+	if (priv->off_gpios) {
+		if (pm_power_off =3D=3D kb3930_power_off)
+			pm_power_off =3D NULL;
+		unregister_restart_handler(&kb3930_restart_nb);
+	}
+	global_kb3930 =3D NULL;
+
+	return 0;
+}
+
+static const struct i2c_device_id kb3930_ids[] =3D {
+	{ "kb3930", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, kb3930_ids);
+
+static const struct of_device_id kb3930_dt_ids[] =3D {
+	{ .compatible =3D "ene,kb3930" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, kb3930_dt_ids);
+
+static struct i2c_driver kb3930_driver =3D {
+	.probe =3D kb3930_probe,
+	.remove =3D kb3930_remove,
+	.driver =3D {
+		.name =3D "ene-kb3930",
+		.of_match_table =3D of_match_ptr(kb3930_dt_ids),
+	},
+	.id_table =3D kb3930_ids,
+};
+
+module_i2c_driver(kb3930_driver);
+
+MODULE_AUTHOR("Lubomir Rintel <lkundrak@v3.sk>");
+MODULE_DESCRIPTION("ENE KB3930 Embedded Controller Driver");
+MODULE_LICENSE("Dual BSD/GPL");
--=20
2.25.1

