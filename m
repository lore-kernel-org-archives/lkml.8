Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59BEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 05:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94FC720829
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 05:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paU2l5VP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHNF7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 01:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgHNF7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 01:59:46 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81141C061757;
        Thu, 13 Aug 2020 22:59:46 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h12so4014869pgm.7;
        Thu, 13 Aug 2020 22:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yBh7JXw5U5KElYsot0BAZzrnYx4dukEbYVm0UZ65a4E=;
        b=paU2l5VPOs4rLBeGhabzWkt53NgsHsooyZyomoMg6uKUmrRiOtjYQje7rdaSIV0pRE
         rGD3L1rQCa1cVODn6FPLo2+ceAl84NdQl0B94alBMB1ftf3c9Jt0A7GDpjE9VJa4iJ+J
         pu/3wh50fCzS0OeJbGCvN1682neKD0tCt13bjWdVgaGoN/Xuvh4CtG+25jFp0zaYtgJT
         YkguiPcACn9PWRN9qMeL/107Khxy9WBI10lrlmmWR+Rx1hr3nK6nw4AY8Nh/VKttI+Ws
         RMaX719I5JvRbg9MeQnDwlE83vxYuk05LGMJjChYZ7wBNz4Ub6mkFFjtF0BXR0LfzmSF
         BDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yBh7JXw5U5KElYsot0BAZzrnYx4dukEbYVm0UZ65a4E=;
        b=JL6jrOFwM5orNDsMLGYkrFVJ/HcgIOTdZJUriGFdue4aQs6oWbqu22xktKoR/9chCA
         i4MUBNX834JLN2ssADzpZ1bW+AAY4zN/o0lZjj9EVEYGKmz2UESCIi0oeCLBAXbWf7Ks
         pNzLwPNJSf1RTw6usmyiPDHgEb8lz3JGCwCSIasZ/ZQ0xDfp0iNpM1gLhgIXi9GzdTrn
         fEA6qicFWhqtG1amZ3b9ZKws/0kiqfi4RUtu3FNIEyO7fGrko3chcmVG3PXPXSjuTny/
         6GcrmONi4u78eDbQdtDFXZLziNq2EAavQ0+AVVVZB9N1KQDShdhcU4BmWN2tEsnbpqaP
         xYEQ==
X-Gm-Message-State: AOAM530KCD8/UduppKxdRMIt346mepc26DnGiebRdOP6GD0iSPLuTxu+
        zrK1Sff0l230p9kKtnQ1jqsMN3QNRw5tiQ==
X-Google-Smtp-Source: ABdhPJz6hB0ldJA1h3n87SMU6jZRSFAeZkYEfAZHrmzKMu8sO6ho3YoBBOKBZXkhXwXFhFjSSJHzxg==
X-Received: by 2002:aa7:9386:: with SMTP id t6mr743339pfe.220.1597384785953;
        Thu, 13 Aug 2020 22:59:45 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:57b:d972:9074:cd57:5c25:5ca2])
        by smtp.gmail.com with ESMTPSA id l8sm7005708pjb.14.2020.08.13.22.59.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 22:59:45 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, gene_chen@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] regulator: Add support for RT4801 Display Bias regulator driver
Date:   Fri, 14 Aug 2020 13:59:33 +0800
Message-Id: <1597384773-18078-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Adds support for the RT4801 DSV. It has two regulators (DSVP/DSVN) with an I2C
interface. DSVP/DSVN can provide the display panel module for the positive/negative
voltage range from (+/-)4V to (+/-)6V.
---
 .../regulator/richtek,rt4801-regulator.yaml        |  80 ++++++++
 drivers/regulator/Kconfig                          |   7 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/rt4801-regulator.c               | 223 +++++++++++++++++++++
 4 files changed, 311 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
 create mode 100644 drivers/regulator/rt4801-regulator.c

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
new file mode 100644
index 00000000..28d30e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rt4801-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT4801 Display Bias regulators
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  Regulator nodes should be named to DSVP and DSVN. The
+  definition for each of these nodes is defined using the standard
+  binding for regulators at
+  Documentation/devicetree/bindings/regulator/regulator.txt.
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT4801H/DS4801H-00.pdf
+
+#The valid names for RT4801 regulator nodes are:
+#DSVP, DSVN
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt4801
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description: GPIOs to use to enable DSVP/DSVN regulator.
+      The first one is ENP to enable DSVP, and second one is ENM to enable DSVN.
+      Number of GPIO in the array list could be 1 or 2.
+      If only one gpio is specified, only one gpio used to control ENP/ENM.
+      Else both are spefied, DSVP/DSVN could be controlled individually.
+      Othersie, this property not specified. treat both as always-on regulator.
+    minItems: 1
+    maxItems: 2
+
+patternProperties:
+  "^DSV(P|N)$":
+    type: object
+    $ref: regulator.yaml#
+    description:
+      Properties for single display bias regulator.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties:
+  - enable-gpios
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rt4801@73 {
+            compatible = "richtek,rt4801";
+            reg = <0x73>;
+            enable-gpios = <&gpio26 2 0>, <&gpio26 3 0>;
+
+            dsvp: DSVP {
+                regulator-name = "rt4801,dsvp";
+                regulator-min-microvolt = <4000000>;
+                regulator-max-microvolt = <6000000>;
+                regulator-boot-on;
+            };
+            dsvn: DSVN {
+                regulator-name = "rt4801,dsvn";
+                regulator-min-microvolt = <4000000>;
+                regulator-max-microvolt = <6000000>;
+                regulator-boot-on;
+            };
+
+        };
+    };
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

