Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90236C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D4FC20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M21M4p/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgHNP1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgHNP1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:27:25 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BD7C061384;
        Fri, 14 Aug 2020 08:27:24 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f5so4322309plr.9;
        Fri, 14 Aug 2020 08:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6PESmeoUjW2fKqrp7LdS6qEafazVRqSyS0MARpkUEoo=;
        b=M21M4p/NU7AXdkjPS6Jge1nzj5yk9/VCGKQkkkEWeg+UVIHxPsY4ZUp1dH6d1w7wIK
         ggZpH+mirPtLS81+ls/XZ3tKP60LzarwzBdY2hHmlXiQ3nqTMk8cTgGNaNzkNcYFD4mS
         KrQW1yg7tUk3pQLTgt3T2dbMMvW2ElO52F9JXyUy8flbSwaOIt+U4JG4GyXbx7BT6VAd
         a3JYqcCMH4XpBmzOp5jgNOuBSU5insEx3parVUtvwtKZyiR23plsfOvFCTu9HNHwBgEI
         Z+gUMYb0BDCk3go1cLBSul5Oqhz0gPHVwGmdiYX9OObB+BFWO0Dmi6D7DwhIqHjrtqJJ
         HD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6PESmeoUjW2fKqrp7LdS6qEafazVRqSyS0MARpkUEoo=;
        b=U0Npup2MPaU91vCaiLmwSl3g4kMKu3LPhDKPgWw54+FcoKxJCJ5o5vuWGrL1EEf0rf
         sTiJ8ZzsEFOL09n7ki5Nb3T5evF3zyitN+m478j8GcaON2H7kclzyooshood0TdtUD2f
         L2Z6IPbtTPBWcbdWxYDChJ/foOlEZuEelFyv8CnIgctSrGIhRp4yMZAXG+N7lORak5HT
         lUrng5vAjmuz4xcw+ZDsE2ttISLACScw6/sXktyOJh2SCx0zgVj7gtuJMaG/rTZEkvyR
         1nI13r+FlL36TcL8ndujuiSQUQA/3Wx2MBC2ItXg8Ztg1s/pgavlRYui3EFpl8NFLjJ8
         W+Fg==
X-Gm-Message-State: AOAM530P2DKEsEUqE5E7UcLW0KJuxxQlLeN8aoOng8xE+FFN/2ScRPpU
        jqkDFmQKBrzpY+s3IEUlWqk=
X-Google-Smtp-Source: ABdhPJxRREdeVCxyM1JZZ06Ce3hpwTUABb4f4Ec1vU/vEgTMStEWotVhrvBrSF2MUbh2/XU3Vxv+HA==
X-Received: by 2002:a17:902:8504:: with SMTP id bj4mr2299389plb.231.1597418844336;
        Fri, 14 Aug 2020 08:27:24 -0700 (PDT)
Received: from localhost.localdomain ([123.110.251.91])
        by smtp.gmail.com with ESMTPSA id e29sm9746680pfj.92.2020.08.14.08.27.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2020 08:27:23 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, gene_chen@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] regulator: rt4801: Add support for RT4801 Display Bias regulator driver
Date:   Fri, 14 Aug 2020 23:27:03 +0800
Message-Id: <1597418824-15906-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Adds support for the RT4801 DSV. It has two regulators (DSVP/DSVN) with
an I2C interface. DSVP/DSVN can provide the display panel module for the
positive/negative voltage range from (+/-)4V to (+/-)6V.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/Kconfig            |   7 ++
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/rt4801-regulator.c | 223 +++++++++++++++++++++++++++++++++++
 3 files changed, 231 insertions(+)
 create mode 100644 drivers/regulator/rt4801-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index de17ef7..2786f11 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -894,6 +894,13 @@ config REGULATOR_RN5T618
 config REGULATOR_ROHM
 	tristate
 
+config REGULATOR_RT4801
+	tristate "Richtek RT4801 Regulators"
+	depends on I2C
+	help
+	  This adds support for voltage regulators in Richtek RT4801 Display Bias IC.
+	  The device supports two regulators (DSVP/DSVN).
+
 config REGULATOR_RT5033
 	tristate "Richtek RT5033 Regulators"
 	depends on MFD_RT5033
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index d8d3ecf..d091e52d 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -111,6 +111,7 @@ obj-$(CONFIG_REGULATOR_RC5T583)  += rc5t583-regulator.o
 obj-$(CONFIG_REGULATOR_RK808)   += rk808-regulator.o
 obj-$(CONFIG_REGULATOR_RN5T618) += rn5t618-regulator.o
 obj-$(CONFIG_REGULATOR_ROHM)	+= rohm-regulator.o
+obj-$(CONFIG_REGULATOR_RT4801)	+= rt4801-regulator.o
 obj-$(CONFIG_REGULATOR_RT5033)	+= rt5033-regulator.o
 obj-$(CONFIG_REGULATOR_S2MPA01) += s2mpa01.o
 obj-$(CONFIG_REGULATOR_S2MPS11) += s2mps11.o
diff --git a/drivers/regulator/rt4801-regulator.c b/drivers/regulator/rt4801-regulator.c
new file mode 100644
index 00000000..0ddc670
--- /dev/null
+++ b/drivers/regulator/rt4801-regulator.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+
+#define RT4801_REG_VOP	0x00
+#define RT4801_REG_VON	0x01
+#define RT4801_REG_APPS	0x03
+
+#define VOUT_MASK	0x1F
+
+#define MIN_UV		4000000
+#define STEP_UV		100000
+#define MAX_UV		6000000
+#define N_VOLTAGES	((MAX_UV - MIN_UV) / STEP_UV + 1)
+
+#define DSV_OUT_POS	0
+#define DSV_OUT_NEG	1
+#define DSV_OUT_MAX	2
+
+#define DSVP_ENABLE	BIT(0)
+#define DSVN_ENABLE	BIT(1)
+#define DSVALL_ENABLE	(DSVP_ENABLE | DSVN_ENABLE)
+
+struct rt4801_priv {
+	struct device *dev;
+	struct gpio_descs *enable_gpios;
+	unsigned int enable_flag;
+	unsigned int volt_sel[DSV_OUT_MAX];
+};
+
+static int rt4801_set_voltage_sel(struct regulator_dev *rdev, unsigned int selector)
+{
+	struct rt4801_priv *priv = rdev_get_drvdata(rdev);
+	int id = rdev_get_id(rdev), ret;
+
+	if (priv->enable_flag & BIT(id)) {
+		ret = regulator_set_voltage_sel_regmap(rdev, selector);
+		if (ret)
+			return ret;
+	}
+
+	priv->volt_sel[id] = selector;
+	return 0;
+}
+
+static int rt4801_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct rt4801_priv *priv = rdev_get_drvdata(rdev);
+	int id = rdev_get_id(rdev);
+
+	if (priv->enable_flag & BIT(id))
+		return regulator_get_voltage_sel_regmap(rdev);
+
+	return priv->volt_sel[id];
+}
+
+static int rt4801_enable(struct regulator_dev *rdev)
+{
+	struct rt4801_priv *priv = rdev_get_drvdata(rdev);
+	struct gpio_descs *gpios = priv->enable_gpios;
+	int id = rdev_get_id(rdev), ret;
+
+	if (gpios->ndescs <= id) {
+		dev_warn(&rdev->dev, "no dedicated gpio can control\n");
+		goto bypass_gpio;
+	}
+
+	gpiod_set_value(gpios->desc[id], 1);
+
+bypass_gpio:
+	ret = regmap_write(rdev->regmap, rdev->desc->vsel_reg, priv->volt_sel[id]);
+	if (ret)
+		return ret;
+
+	priv->enable_flag |= BIT(id);
+	return 0;
+}
+
+static int rt4801_disable(struct regulator_dev *rdev)
+{
+	struct rt4801_priv *priv = rdev_get_drvdata(rdev);
+	struct gpio_descs *gpios = priv->enable_gpios;
+	int id = rdev_get_id(rdev);
+
+	if (gpios->ndescs <= id) {
+		dev_warn(&rdev->dev, "no dedicated gpio can control\n");
+		goto bypass_gpio;
+	}
+
+	gpiod_set_value(gpios->desc[id], 0);
+
+bypass_gpio:
+	priv->enable_flag &= ~BIT(id);
+	return 0;
+}
+
+static int rt4801_is_enabled(struct regulator_dev *rdev)
+{
+	struct rt4801_priv *priv = rdev_get_drvdata(rdev);
+	int id = rdev_get_id(rdev);
+
+	return !!(priv->enable_flag & BIT(id));
+}
+
+static const struct regulator_ops rt4801_regulator_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.set_voltage_sel = rt4801_set_voltage_sel,
+	.get_voltage_sel = rt4801_get_voltage_sel,
+	.enable = rt4801_enable,
+	.disable = rt4801_disable,
+	.is_enabled = rt4801_is_enabled,
+};
+
+static const struct regulator_desc rt4801_regulator_descs[] = {
+	{
+		.name = "DSVP",
+		.ops = &rt4801_regulator_ops,
+		.of_match = of_match_ptr("DSVP"),
+		.type = REGULATOR_VOLTAGE,
+		.id = DSV_OUT_POS,
+		.min_uV = MIN_UV,
+		.uV_step = STEP_UV,
+		.n_voltages = N_VOLTAGES,
+		.owner = THIS_MODULE,
+		.vsel_reg = RT4801_REG_VOP,
+		.vsel_mask = VOUT_MASK,
+	},
+	{
+		.name = "DSVN",
+		.ops = &rt4801_regulator_ops,
+		.of_match = of_match_ptr("DSVN"),
+		.type = REGULATOR_VOLTAGE,
+		.id = DSV_OUT_NEG,
+		.min_uV = MIN_UV,
+		.uV_step = STEP_UV,
+		.n_voltages = N_VOLTAGES,
+		.owner = THIS_MODULE,
+		.vsel_reg = RT4801_REG_VON,
+		.vsel_mask = VOUT_MASK,
+	},
+};
+
+static const struct regmap_config rt4801_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RT4801_REG_APPS,
+};
+
+static int rt4801_probe(struct i2c_client *i2c)
+{
+	struct rt4801_priv *priv;
+	struct regmap *regmap;
+	int i;
+
+	priv = devm_kzalloc(&i2c->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &i2c->dev;
+	/* bootloader will on, driver only reconfigure enable to all output high */
+	priv->enable_flag = DSVALL_ENABLE;
+
+	regmap = devm_regmap_init_i2c(i2c, &rt4801_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&i2c->dev, "Failed to init regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	priv->enable_gpios = devm_gpiod_get_array_optional(&i2c->dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->enable_gpios)) {
+		dev_err(&i2c->dev, "Failed to get gpios\n");
+		return PTR_ERR(priv->enable_gpios);
+	}
+
+	for (i = 0; i < DSV_OUT_MAX; i++) {
+		const struct regulator_desc *desc = rt4801_regulator_descs + i;
+		struct regulator_config config = { .dev = &i2c->dev, .driver_data = priv,
+						   .regmap = regmap, };
+		struct regulator_dev *rdev;
+		unsigned int val;
+		int ret;
+
+		/* initialize volt_sel variable */
+		ret = regmap_read(regmap, desc->vsel_reg, &val);
+		if (ret)
+			return ret;
+
+		priv->volt_sel[i] = val & desc->vsel_mask;
+
+		rdev = devm_regulator_register(&i2c->dev, desc, &config);
+		if (IS_ERR(rdev)) {
+			dev_err(&i2c->dev, "Failed to register [%d] regulator\n", i);
+			return PTR_ERR(rdev);
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id rt4801_of_id[] = {
+	{ .compatible = "richtek,rt4801", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rt4801_of_id);
+
+static struct i2c_driver rt4801_driver = {
+	.driver = {
+		.name = "rt4801",
+		.of_match_table = of_match_ptr(rt4801_of_id),
+	},
+	.probe_new = rt4801_probe,
+};
+module_i2c_driver(rt4801_driver);
+
+MODULE_AUTHOR("ChiYuan Hwang <cy_huang@richtek.com>");
+MODULE_DESCRIPTION("Richtek RT4801 Display Bias Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

