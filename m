Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D72C3524F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9B02051A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axnVS9F+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgBDLEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:04:45 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:34766 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgBDLEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:04:34 -0500
Received: by mail-wr1-f45.google.com with SMTP id t2so22467317wrr.1;
        Tue, 04 Feb 2020 03:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5Vu7GOw3hfDN9bKb8xO8b5RUA3Z5/JkB36ThlQ0BzbE=;
        b=axnVS9F+GwHD7s1CCgLEVJO5pEAvzYrHa2vI3LPPFpHufmA74ligAmv32KhJueRzDZ
         hm6HSEMk2TKHLiix7V5V9A7SNEnnHNMDNE8W80AXou15vpLqg7Vz8BTWM2LX1+UvYQvY
         mvCHwygSSDNpeEnX8eBkpkI0/9xIE8cUQ15xJIkXUl/rWJsIrSGYkygco0BdURJ/SDjA
         AkuLny2gc1TFdRSnUCD8ZLWXmI8K46DgJRV6BLEvaLet9v1WGAwAGUfUBLoboo+g8YFf
         vv7qVnyjiMDYtmT6ptOtLpDbg1NhvgWwnuTw4UY2W7lL1rO0dpdqaNQY4xLq6SyrNIjR
         ipMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5Vu7GOw3hfDN9bKb8xO8b5RUA3Z5/JkB36ThlQ0BzbE=;
        b=CkSZS8hbBqi6/n0iZ5Y6SCrlaX5+w7I3jbNnXQE4qpkul/RE55dcyr518nCb0ChByb
         6fBjk09uIbf6psLiRt8GKU9jlxFONAa+rmDVqjcSDJt4Fap41Gx9HdDe2iOtJqyCk9E9
         oYVA0/61/pX7BgLsYOY4sQbsu/LViKbrSZU40TY9+J0ogSGBYtQXIa+3+fR+WtBaR3RJ
         v268WBpTzlje4YaM/J4WRNYutzBGbMWHPcVhUS+je7qP6kJUjtvwpLgKr+v0B9aQJeKx
         1b0bB5CJ/IEjtGkLts2XBl3b55cHNEnCerOaglF6lkevmWPX32IxOu0m/deW82Pqnm0N
         RAdA==
X-Gm-Message-State: APjAAAXYFITJCKheXYq9chQtBXyVIma16aMMowrLYVpmdDSwcorUH6hB
        g+Q6KxZwYbjuM6nSlRQBleQ=
X-Google-Smtp-Source: APXvYqzySwFjYBo4kwgAAHH3q/jqseH7FGaUBNJX1qhIcZBC6oxmwntFR49Kr35Ww9/3+4cu+QsoHg==
X-Received: by 2002:adf:f28c:: with SMTP id k12mr22723917wro.360.1580814271685;
        Tue, 04 Feb 2020 03:04:31 -0800 (PST)
Received: from localhost.localdomain (p5B3F65E4.dip0.t-ipconnect.de. [91.63.101.228])
        by smtp.gmail.com with ESMTPSA id y185sm3476935wmg.2.2020.02.04.03.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 03:04:31 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] regulator: mp5416: add mp5416 regulator driver
Date:   Tue,  4 Feb 2020 12:04:18 +0100
Message-Id: <20200204110419.25933-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204110419.25933-1-sravanhome@gmail.com>
References: <20200204110419.25933-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding regulator driver for the device mp5416.
The MP5416 PMIC device contains four DC-DC buck converters and
five regulators, accessed over I2C.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/regulator/Kconfig  |  10 ++
 drivers/regulator/Makefile |   1 +
 drivers/regulator/mp5416.c | 245 +++++++++++++++++++++++++++++++++++++
 3 files changed, 256 insertions(+)
 create mode 100644 drivers/regulator/mp5416.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 074a2ef55943..b8ae513514a8 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -613,6 +613,16 @@ config REGULATOR_MCP16502
 	  through the regulator interface. In addition it enables
 	  suspend-to-ram/standby transition.
 
+config REGULATOR_MP5416
+	tristate "Monolithic MP5416 PMIC"
+	depends on I2C && OF
+	select REGMAP_I2C
+	help
+	  Say y here to support the MP5416 PMIC. This will enable supports
+	  the software controllable 4 buck and 4 LDO regulators.
+	  Say M here if you want to include support for the regulator as a
+	  module.
+
 config REGULATOR_MP8859
 	tristate "MPS MP8859 regulator driver"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index c0d6b96ebd78..bc69d6481646 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_REGULATOR_MC13783) += mc13783-regulator.o
 obj-$(CONFIG_REGULATOR_MC13892) += mc13892-regulator.o
 obj-$(CONFIG_REGULATOR_MC13XXX_CORE) +=  mc13xxx-regulator-core.o
 obj-$(CONFIG_REGULATOR_MCP16502) += mcp16502.o
+obj-$(CONFIG_REGULATOR_MP5416) += mp5416.o
 obj-$(CONFIG_REGULATOR_MP8859) += mp8859.o
 obj-$(CONFIG_REGULATOR_MPQ7920) += mpq7920.o
 obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
diff --git a/drivers/regulator/mp5416.c b/drivers/regulator/mp5416.c
new file mode 100644
index 000000000000..7954ad17249b
--- /dev/null
+++ b/drivers/regulator/mp5416.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// mp5416.c  - regulator driver for mps mp5416
+//
+// Copyright 2020 Monolithic Power Systems, Inc
+//
+// Author: Saravanan Sekar <sravanhome@gmail.com>
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/i2c.h>
+
+#define MP5416_REG_CTL0			0x00
+#define MP5416_REG_CTL1			0x01
+#define MP5416_REG_CTL2			0x02
+#define MP5416_REG_ILIM			0x03
+#define MP5416_REG_BUCK1		0x04
+#define MP5416_REG_BUCK2		0x05
+#define MP5416_REG_BUCK3		0x06
+#define MP5416_REG_BUCK4		0x07
+#define MP5416_REG_LDO1			0x08
+#define MP5416_REG_LDO2			0x09
+#define MP5416_REG_LDO3			0x0a
+#define MP5416_REG_LDO4			0x0b
+
+#define MP5416_REGULATOR_EN		BIT(7)
+#define MP5416_MASK_VSET		0x7f
+#define MP5416_MASK_BUCK1_ILIM		0xc0
+#define MP5416_MASK_BUCK2_ILIM		0x0c
+#define MP5416_MASK_BUCK3_ILIM		0x30
+#define MP5416_MASK_BUCK4_ILIM		0x03
+#define MP5416_MASK_DVS_SLEWRATE	0xc0
+
+/* values in uV */
+#define MP5416_VOLT1_MIN		600000
+#define MP5416_VOLT1_MAX		2187500
+#define MP5416_VOLT1_STEP		12500
+#define MP5416_VOLT2_MIN		800000
+#define MP5416_VOLT2_MAX		3975000
+#define MP5416_VOLT2_STEP		25000
+
+#define MP5416_VOLT1_RANGE \
+	((MP5416_VOLT1_MAX - MP5416_VOLT1_MIN)/MP5416_VOLT1_STEP + 1)
+#define MP5416_VOLT2_RANGE \
+	((MP5416_VOLT2_MAX - MP5416_VOLT2_MIN)/MP5416_VOLT2_STEP + 1)
+
+#define MP5416BUCK(_name, _id, _ilim, _dreg, _dval, _vsel)		\
+	[MP5416_BUCK ## _id] = {					\
+		.id = MP5416_BUCK ## _id,				\
+		.name = _name,						\
+		.of_match = _name,					\
+		.regulators_node = "regulators",			\
+		.ops = &mp5416_buck_ops,				\
+		.min_uV = MP5416_VOLT ##_vsel## _MIN,			\
+		.uV_step = MP5416_VOLT ##_vsel## _STEP,			\
+		.n_voltages = MP5416_VOLT ##_vsel## _RANGE,		\
+		.curr_table = _ilim,					\
+		.n_current_limits = ARRAY_SIZE(_ilim),			\
+		.csel_reg = MP5416_REG_ILIM,				\
+		.csel_mask = MP5416_MASK_BUCK ## _id ##_ILIM,		\
+		.vsel_reg = MP5416_REG_BUCK ## _id,			\
+		.vsel_mask = MP5416_MASK_VSET,				\
+		.enable_reg = MP5416_REG_BUCK ## _id,			\
+		.enable_mask = MP5416_REGULATOR_EN,			\
+		.active_discharge_on	= _dval,			\
+		.active_discharge_reg	= _dreg,			\
+		.active_discharge_mask	= _dval,			\
+		.owner			= THIS_MODULE,			\
+	}
+
+#define MP5416LDO(_name, _id)						\
+	[MP5416_LDO ## _id] = {						\
+		.id = MP5416_LDO ## _id,				\
+		.name = _name,						\
+		.of_match = _name,					\
+		.regulators_node = "regulators",			\
+		.ops = &mp5416_ldo_ops,					\
+		.min_uV = MP5416_VOLT2_MIN,				\
+		.uV_step = MP5416_VOLT2_STEP,				\
+		.n_voltages = MP5416_VOLT2_RANGE,			\
+		.vsel_reg = MP5416_REG_LDO ##_id,			\
+		.vsel_mask = MP5416_MASK_VSET,				\
+		.enable_reg = MP5416_REG_LDO ##_id,			\
+		.enable_mask = MP5416_REGULATOR_EN,			\
+		.active_discharge_on	= BIT(_id),			\
+		.active_discharge_reg	= MP5416_REG_CTL2,		\
+		.active_discharge_mask	= BIT(_id),			\
+		.owner			= THIS_MODULE,			\
+	}
+
+enum mp5416_regulators {
+	MP5416_BUCK1,
+	MP5416_BUCK2,
+	MP5416_BUCK3,
+	MP5416_BUCK4,
+	MP5416_LDO1,
+	MP5416_LDO2,
+	MP5416_LDO3,
+	MP5416_LDO4,
+	MP5416_MAX_REGULATORS,
+};
+
+static const struct regmap_config mp5416_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x0d,
+};
+
+/* Current limits array (in uA)
+ * ILIM1 & ILIM3
+ */
+static const unsigned int mp5416_I_limits1[] = {
+	3800000, 4600000, 5600000, 6800000
+};
+
+/* ILIM2 & ILIM4 */
+static const unsigned int mp5416_I_limits2[] = {
+	2200000, 3200000, 4200000, 5200000
+};
+
+static int mp5416_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay);
+
+static const struct regulator_ops mp5416_ldo_ops = {
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.list_voltage		= regulator_list_voltage_linear,
+	.map_voltage		= regulator_map_voltage_linear,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.set_active_discharge	= regulator_set_active_discharge_regmap,
+};
+
+static const struct regulator_ops mp5416_buck_ops = {
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.list_voltage		= regulator_list_voltage_linear,
+	.map_voltage		= regulator_map_voltage_linear,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.set_active_discharge	= regulator_set_active_discharge_regmap,
+	.get_current_limit	= regulator_get_current_limit_regmap,
+	.set_current_limit	= regulator_set_current_limit_regmap,
+	.set_ramp_delay		= mp5416_set_ramp_delay,
+};
+
+static struct regulator_desc mp5416_regulators_desc[MP5416_MAX_REGULATORS] = {
+	MP5416BUCK("buck1", 1, mp5416_I_limits1, MP5416_REG_CTL1, BIT(0), 1),
+	MP5416BUCK("buck2", 2, mp5416_I_limits2, MP5416_REG_CTL1, BIT(1), 2),
+	MP5416BUCK("buck3", 3, mp5416_I_limits1, MP5416_REG_CTL1, BIT(2), 1),
+	MP5416BUCK("buck4", 4, mp5416_I_limits2, MP5416_REG_CTL2, BIT(5), 2),
+	MP5416LDO("ldo1", 1),
+	MP5416LDO("ldo2", 2),
+	MP5416LDO("ldo3", 3),
+	MP5416LDO("ldo4", 4),
+};
+
+/*
+ * DVS ramp rate BUCK1 to BUCK4
+ * 00: 32mV/us
+ * 01: 16mV/us
+ * 10: 8mV/us
+ * 11: 4mV/us
+ */
+static int mp5416_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
+{
+	unsigned int ramp_val;
+
+	if (ramp_delay > 32000 || ramp_delay < 0)
+		return -EINVAL;
+
+	if (ramp_delay <= 4000)
+		ramp_val = 3;
+	else if (ramp_delay <= 8000)
+		ramp_val = 2;
+	else if (ramp_delay <= 16000)
+		ramp_val = 1;
+	else
+		ramp_val = 0;
+
+	return regmap_update_bits(rdev->regmap, MP5416_REG_CTL2,
+				  MP5416_MASK_DVS_SLEWRATE, ramp_val << 6);
+}
+
+static int mp5416_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct regulator_config config = { NULL, };
+	struct regulator_dev *rdev;
+	struct regmap *regmap;
+	int i;
+
+	regmap = devm_regmap_init_i2c(client, &mp5416_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to allocate regmap!\n");
+		return PTR_ERR(regmap);
+	}
+
+	config.dev = dev;
+	config.regmap = regmap;
+
+	for (i = 0; i < MP5416_MAX_REGULATORS; i++) {
+		rdev = devm_regulator_register(dev,
+					       &mp5416_regulators_desc[i],
+					       &config);
+		if (IS_ERR(rdev)) {
+			dev_err(dev, "Failed to register regulator!\n");
+			return PTR_ERR(rdev);
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id mp5416_of_match[] = {
+	{ .compatible = "mps,mp5416" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mp5416_of_match);
+
+static const struct i2c_device_id mp5416_id[] = {
+	{ "mp5416", },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, mp5416_id);
+
+static struct i2c_driver mp5416_regulator_driver = {
+	.driver = {
+		.name = "mp5416",
+		.of_match_table = of_match_ptr(mp5416_of_match),
+	},
+	.probe_new = mp5416_i2c_probe,
+	.id_table = mp5416_id,
+};
+module_i2c_driver(mp5416_regulator_driver);
+
+MODULE_AUTHOR("Saravanan Sekar <sravanhome@gmail.com>");
+MODULE_DESCRIPTION("MP5416 PMIC regulator driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

