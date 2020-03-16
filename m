Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BD3C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D6E2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbgCPOcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:32:04 -0400
Received: from smtp2.ustc.edu.cn ([202.38.64.46]:44741 "EHLO ustc.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731465AbgCPOcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:32:03 -0400
Received: from xhacker (unknown [101.86.20.80])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygA3PZHdjW9eWEBPAA--.20080S2;
        Mon, 16 Mar 2020 22:31:58 +0800 (CST)
Date:   Mon, 16 Mar 2020 22:30:20 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/4] regulator: add support for MP8869 regulator
Message-ID: <20200316223020.1a6d92ae@xhacker>
In-Reply-To: <20200316222808.6453d849@xhacker>
References: <20200316222808.6453d849@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygA3PZHdjW9eWEBPAA--.20080S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XryUuFyrGw4fAFW3uFWkCrg_yoW3ZrWxpF
        45GFy3Cr48ZFWfGFWxCF9Fk3WYqws2g34xAryfGw4avanxtFyfZF1DZryavF95Gr95CF1U
        tayUCayxuF47X3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyFb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s02
        6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
        0_Gr0_Zr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
        JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8DxhJUUUUU==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

The MP8869 from Monolithic Power Systems is a single output DC/DC
converter. The voltage can be controlled via I2C.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/Kconfig  |   7 ++
 drivers/regulator/Makefile |   1 +
 drivers/regulator/mp886x.c | 230 +++++++++++++++++++++++++++++++++++++
 3 files changed, 238 insertions(+)
 create mode 100644 drivers/regulator/mp886x.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 64a39f34ef37..f4b72cb098ef 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -635,6 +635,13 @@ config REGULATOR_MP8859
 	  Say M here if you want to include support for the regulator as a
 	  module. The module will be named "mp8859".
 
+config REGULATOR_MP886X
+	tristate "MPS MP8869 regulator driver"
+	depends on I2C && (OF || COMPILE_TEST)
+	select REGMAP_I2C
+	help
+	  This driver supports the MP8869 voltage regulator.
+
 config REGULATOR_MPQ7920
 	tristate "Monolithic MPQ7920 PMIC"
 	depends on I2C && OF
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index bc69d6481646..6610ee001d9a 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_REGULATOR_MC13XXX_CORE) +=  mc13xxx-regulator-core.o
 obj-$(CONFIG_REGULATOR_MCP16502) += mcp16502.o
 obj-$(CONFIG_REGULATOR_MP5416) += mp5416.o
 obj-$(CONFIG_REGULATOR_MP8859) += mp8859.o
+obj-$(CONFIG_REGULATOR_MP886X) += mp886x.o
 obj-$(CONFIG_REGULATOR_MPQ7920) += mpq7920.o
 obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
diff --git a/drivers/regulator/mp886x.c b/drivers/regulator/mp886x.c
new file mode 100644
index 000000000000..f77321a449ca
--- /dev/null
+++ b/drivers/regulator/mp886x.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// MP8869 regulator driver
+//
+// Copyright (C) 2020 Synaptics Incorporated
+//
+// Author: Jisheng Zhang <jszhang@kernel.org>
+
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+#define MP886X_VSEL		0x00
+#define  MP886X_V_BOOT		(1 << 7)
+#define MP886X_SYSCNTLREG1	0x01
+#define  MP886X_MODE		(1 << 0)
+#define  MP886X_GO		(1 << 6)
+#define  MP886X_EN		(1 << 7)
+
+struct mp886x_device_info {
+	struct device *dev;
+	struct regulator_desc desc;
+	struct regulator_init_data *regulator;
+	struct gpio_desc *en_gpio;
+	u32 r[2];
+	unsigned int sel;
+};
+
+static int mp886x_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	switch (mode) {
+	case REGULATOR_MODE_FAST:
+		regmap_update_bits(rdev->regmap, MP886X_SYSCNTLREG1,
+				   MP886X_MODE, MP886X_MODE);
+		break;
+	case REGULATOR_MODE_NORMAL:
+		regmap_update_bits(rdev->regmap, MP886X_SYSCNTLREG1,
+				   MP886X_MODE, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static unsigned int mp886x_get_mode(struct regulator_dev *rdev)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, MP886X_SYSCNTLREG1, &val);
+	if (ret < 0)
+		return ret;
+	if (val & MP886X_MODE)
+		return REGULATOR_MODE_FAST;
+	else
+		return REGULATOR_MODE_NORMAL;
+}
+
+static int mp8869_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
+{
+	int ret;
+
+	ret = regmap_update_bits(rdev->regmap, MP886X_SYSCNTLREG1,
+				 MP886X_GO, MP886X_GO);
+	if (ret < 0)
+		return ret;
+
+	sel <<= ffs(rdev->desc->vsel_mask) - 1;
+	return regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg,
+				  MP886X_V_BOOT | rdev->desc->vsel_mask, sel);
+}
+
+static inline unsigned int mp8869_scale(unsigned int uv, u32 r1, u32 r2)
+{
+	u32 tmp = uv * r1 / r2;
+
+	return uv + tmp;
+}
+
+static int mp8869_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct mp886x_device_info *di = rdev_get_drvdata(rdev);
+	int ret, uv;
+	unsigned int val;
+	bool fbloop;
+
+	ret = regmap_read(rdev->regmap, rdev->desc->vsel_reg, &val);
+	if (ret)
+		return ret;
+
+	fbloop = val & MP886X_V_BOOT;
+	if (fbloop) {
+		uv = rdev->desc->min_uV;
+		uv = mp8869_scale(uv, di->r[0], di->r[1]);
+		return regulator_map_voltage_linear(rdev, uv, uv);
+	}
+
+	val &= rdev->desc->vsel_mask;
+	val >>= ffs(rdev->desc->vsel_mask) - 1;
+
+	return val;
+}
+
+static const struct regulator_ops mp8869_regulator_ops = {
+	.set_voltage_sel = mp8869_set_voltage_sel,
+	.get_voltage_sel = mp8869_get_voltage_sel,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.map_voltage = regulator_map_voltage_linear,
+	.list_voltage = regulator_list_voltage_linear,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mp886x_set_mode,
+	.get_mode = mp886x_get_mode,
+};
+
+static int mp886x_regulator_register(struct mp886x_device_info *di,
+				     struct regulator_config *config)
+{
+	struct regulator_desc *rdesc = &di->desc;
+	struct regulator_dev *rdev;
+
+	rdesc->name = "mp886x-reg";
+	rdesc->supply_name = "vin";
+	rdesc->ops = of_device_get_match_data(di->dev);
+	rdesc->type = REGULATOR_VOLTAGE;
+	rdesc->n_voltages = 128;
+	rdesc->enable_reg = MP886X_SYSCNTLREG1;
+	rdesc->enable_mask = MP886X_EN;
+	rdesc->min_uV = 600000;
+	rdesc->uV_step = 10000;
+	rdesc->vsel_reg = MP886X_VSEL;
+	rdesc->vsel_mask = 0x3f;
+	rdesc->owner = THIS_MODULE;
+
+	rdev = devm_regulator_register(di->dev, &di->desc, config);
+	if (IS_ERR(rdev))
+		return PTR_ERR(rdev);
+	di->sel = rdesc->ops->get_voltage_sel(rdev);
+	return 0;
+}
+
+static const struct regmap_config mp886x_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int mp886x_i2c_probe(struct i2c_client *client,
+			    const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct device_node *np = dev->of_node;
+	struct mp886x_device_info *di;
+	struct regulator_config config = { };
+	struct regmap *regmap;
+	int ret;
+
+	di = devm_kzalloc(dev, sizeof(struct mp886x_device_info), GFP_KERNEL);
+	if (!di)
+		return -ENOMEM;
+
+	di->regulator = of_get_regulator_init_data(dev, np, &di->desc);
+	if (!di->regulator) {
+		dev_err(dev, "Platform data not found!\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32_array(np, "mps,fb-voltage-divider",
+					 di->r, 2);
+	if (ret)
+		return ret;
+
+	di->en_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(di->en_gpio))
+		return PTR_ERR(di->en_gpio);
+
+	di->dev = dev;
+
+	regmap = devm_regmap_init_i2c(client, &mp886x_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to allocate regmap!\n");
+		return PTR_ERR(regmap);
+	}
+	i2c_set_clientdata(client, di);
+
+	config.dev = di->dev;
+	config.init_data = di->regulator;
+	config.regmap = regmap;
+	config.driver_data = di;
+	config.of_node = np;
+
+	ret = mp886x_regulator_register(di, &config);
+	if (ret < 0)
+		dev_err(dev, "Failed to register regulator!\n");
+	return ret;
+}
+
+static const struct of_device_id mp886x_dt_ids[] = {
+	{
+		.compatible = "mps,mp8869",
+		.data = &mp8869_regulator_ops
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mp886x_dt_ids);
+
+static const struct i2c_device_id mp886x_id[] = {
+	{ "mp886x", },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, mp886x_id);
+
+static struct i2c_driver mp886x_regulator_driver = {
+	.driver = {
+		.name = "mp886x-regulator",
+		.of_match_table = of_match_ptr(mp886x_dt_ids),
+	},
+	.probe = mp886x_i2c_probe,
+	.id_table = mp886x_id,
+};
+module_i2c_driver(mp886x_regulator_driver);
+
+MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
+MODULE_DESCRIPTION("MP886x regulator driver");
+MODULE_LICENSE("GPL v2");
-- 
2.24.0


