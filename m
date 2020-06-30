Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B955C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A1420775
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TVHb36ON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgF3Swe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgF3Swd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:52:33 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AF4C061755;
        Tue, 30 Jun 2020 11:52:32 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id lx13so3024161ejb.4;
        Tue, 30 Jun 2020 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x1hIIo4nOQO0M8wI9A91M+Eiy/l3RYgHSzm5nX9C1bQ=;
        b=TVHb36ONM2fcgGTvlVRuiRUuWwLp6Byiz1Moe9l37BVuEc9AlWrnLz6h4IbGmkqYxH
         i7L+gHQtOdIpCCRxveWEDbGPhQPjpt2p7NlLxCYEf1YV4Pnpw+WZ0uBSV+Wjbce9s0Tz
         PBiGpiVvxKOPZYWTldgQqIm56HIUL6sbnWyPgiYXcaBDEurkLMHSwu4BedyJA7/1tYI5
         YzbqLAIldmkmX1gvruJjnoKyARIwDx9bUiDMx6ENr81HhSy5vhB2LCaoBDL/Iko3bFNh
         J2FtRwnUbKSdbNv/jvo6aR4ito4L4PJDx6hnbphHKelAZPIi8c3Lghm8Sl94bm4V150u
         fCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x1hIIo4nOQO0M8wI9A91M+Eiy/l3RYgHSzm5nX9C1bQ=;
        b=cydAgTfGrBCnI/pUnPe21wNWrl/plAD+tku9VhjQ4TAflwz8d7tfgnMeQEysll+A0R
         QNqXv+3nCmAFqoVO+tl+OZ1fCl7/FNN8eJzPA2GnzYZyCYqKH3ou/JTkpZra3vrhe+XN
         Ey9J50XaZPoYS1eLPahhP1jEAOw6OdCjXWmnUnsclsUv8DT8Id7SujMFb9voKp/TvgVB
         MBclL4PZWbJ0wFDnLYRtCe4vKpr9yTeIlpkJ0TQaCeNRNAC1sq93eXk+r7bzkdIVviQO
         cIVJxgrD0ayXI++nfiwWAB4QvwFzt9eqROBVhjmw7WpfV7FmDNLsHCi04Q0Muz4c66BH
         wu9w==
X-Gm-Message-State: AOAM5327lcvIXhrt6EiJbJOGL4caobv5OJtzEV0m2zrAv5OoVfAfH3Df
        oEHroNBlfhz5DS3iM/A4oQIvXnEG
X-Google-Smtp-Source: ABdhPJyjXa1DDZu7KMeQoI4KZYShkmwY7ol+euVdCZuSZMQawjxl8yZyLed5a2BWI00jbk3M/W5nNw==
X-Received: by 2002:a17:906:95d6:: with SMTP id n22mr19484275ejy.138.1593543151539;
        Tue, 30 Jun 2020 11:52:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:bb9:bc00::fc])
        by smtp.googlemail.com with ESMTPSA id e16sm2677238ejt.14.2020.06.30.11.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 11:52:31 -0700 (PDT)
From:   Christoph Fritz <chf.fritz@googlemail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] regulator: fan53880: Add initial support
Date:   Tue, 30 Jun 2020 20:52:02 +0200
Message-Id: <20200630185203.22882-2-chf.fritz@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630185203.22882-1-chf.fritz@googlemail.com>
References: <20200630185203.22882-1-chf.fritz@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for ON Semiconductor FAN53880 regulator.

The FAN53880 is an I2C porgrammable power management IC (PMIC)
that contains a BUCK (step-down converter), four LDOs (low dropouts)
and one BOOST (step-up converter).  It is designed for mobile power
applications.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/regulator/Kconfig    |  10 ++
 drivers/regulator/Makefile   |   1 +
 drivers/regulator/fan53880.c | 179 +++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 drivers/regulator/fan53880.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index edb1c4f8b496..69fcfdc50ada 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -326,6 +326,16 @@ config REGULATOR_FAN53555
 	  input voltage supply of 2.5V to 5.5V. The output voltage is
 	  programmed through an I2C interface.
 
+config REGULATOR_FAN53880
+	tristate "Fairchild FAN53880 Regulator"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This driver supports Fairchild (ON Semiconductor) FAN53880
+	  regulator. The regulator is a programmable power management IC
+	  (PMIC), it is controlled by I2C and provides one BUCK, one BOOST
+	  and four LDO outputs.
+
 config REGULATOR_GPIO
 	tristate "GPIO regulator support"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index e8f163371071..7b7d2eeb78c2 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_REGULATOR_DA9211) += da9211-regulator.o
 obj-$(CONFIG_REGULATOR_DBX500_PRCMU) += dbx500-prcmu.o
 obj-$(CONFIG_REGULATOR_DB8500_PRCMU) += db8500-prcmu.o
 obj-$(CONFIG_REGULATOR_FAN53555) += fan53555.o
+obj-$(CONFIG_REGULATOR_FAN53880) += fan53880.o
 obj-$(CONFIG_REGULATOR_GPIO) += gpio-regulator.o
 obj-$(CONFIG_REGULATOR_HI6421) += hi6421-regulator.o
 obj-$(CONFIG_REGULATOR_HI6421V530) += hi6421v530-regulator.o
diff --git a/drivers/regulator/fan53880.c b/drivers/regulator/fan53880.c
new file mode 100644
index 000000000000..114c6bd3d962
--- /dev/null
+++ b/drivers/regulator/fan53880.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+
+enum fan53880_regulator_ids {
+	FAN53880_LDO1,
+	FAN53880_LDO2,
+	FAN53880_LDO3,
+	FAN53880_LDO4,
+	FAN53880_BUCK,
+	FAN53880_BOOST,
+};
+
+enum fan53880_registers {
+	FAN53880_PRODUCT_ID = 0x00,
+	FAN53880_SILICON_REV,
+	FAN53880_BUCKVOUT,
+	FAN53880_BOOSTVOUT,
+	FAN53880_LDO1VOUT,
+	FAN53880_LDO2VOUT,
+	FAN53880_LDO3VOUT,
+	FAN53880_LDO4VOUT,
+	FAN53880_IOUT,
+	FAN53880_ENABLE,
+	FAN53880_ENABLE_BOOST,
+};
+
+#define FAN53880_ID	0x01
+
+static const struct regulator_ops fan53880_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+};
+
+#define FAN53880_LDO(_num, _supply, _default)				\
+	[FAN53880_LDO ## _num] = {					\
+		.name =		   "LDO"#_num,				\
+		.of_match =	   of_match_ptr("LDO"#_num),		\
+		.regulators_node = of_match_ptr("regulators"),		\
+		.type =		   REGULATOR_VOLTAGE,			\
+		.linear_ranges =   (struct regulator_linear_range[]) {	\
+		      REGULATOR_LINEAR_RANGE(_default, 0x0, 0x0, 0),	\
+		      REGULATOR_LINEAR_RANGE(800000, 0xf, 0x73, 25000),	\
+		},							\
+		.n_linear_ranges = 2,					\
+		.vsel_reg =	   FAN53880_LDO ## _num ## VOUT,	\
+		.vsel_mask =	   0x7f,				\
+		.enable_reg =	   FAN53880_ENABLE,			\
+		.enable_mask =	   BIT(_num - 1),			\
+		.enable_time =	   150,					\
+		.supply_name =	   _supply,				\
+		.ops =		   &fan53880_ops,			\
+	}
+
+static const struct regulator_desc fan53880_regulators[] = {
+	FAN53880_LDO(1, "VIN12", 2800000),
+	FAN53880_LDO(2, "VIN12", 2800000),
+	FAN53880_LDO(3, "VIN3", 1800000),
+	FAN53880_LDO(4, "VIN4", 1800000),
+	[FAN53880_BUCK] = {
+		.name =		   "BUCK",
+		.of_match =	   of_match_ptr("BUCK"),
+		.regulators_node = of_match_ptr("regulators"),
+		.type =		   REGULATOR_VOLTAGE,
+		.linear_ranges =   (struct regulator_linear_range[]) {
+		      REGULATOR_LINEAR_RANGE(1100000, 0x0, 0x0, 0),
+		      REGULATOR_LINEAR_RANGE(600000, 0x1f, 0xf7, 12500),
+		},
+		.n_linear_ranges = 2,
+		.vsel_reg =	   FAN53880_BUCKVOUT,
+		.vsel_mask =	   0x7f,
+		.enable_reg =	   FAN53880_ENABLE,
+		.enable_mask =	   0x10,
+		.enable_time =	   480,
+		.supply_name =	   "PVIN",
+		.ops =		   &fan53880_ops,
+	},
+	[FAN53880_BOOST] = {
+		.name =		   "BOOST",
+		.of_match =	   of_match_ptr("BOOST"),
+		.regulators_node = of_match_ptr("regulators"),
+		.type =		   REGULATOR_VOLTAGE,
+		.linear_ranges =   (struct regulator_linear_range[]) {
+		      REGULATOR_LINEAR_RANGE(5000000, 0x0, 0x0, 0),
+		      REGULATOR_LINEAR_RANGE(3000000, 0x4, 0x70, 25000),
+		},
+		.n_linear_ranges = 2,
+		.vsel_reg =	   FAN53880_BOOSTVOUT,
+		.vsel_mask =	   0x7f,
+		.enable_reg =	   FAN53880_ENABLE_BOOST,
+		.enable_mask =	   0xff,
+		.enable_time =	   580,
+		.supply_name =	   "PVIN",
+		.ops =		   &fan53880_ops,
+	},
+};
+
+static const struct regmap_config fan53880_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = FAN53880_ENABLE_BOOST,
+};
+
+static int fan53880_i2c_probe(struct i2c_client *i2c,
+			     const struct i2c_device_id *id)
+{
+	struct regulator_config config = { };
+	struct regulator_dev *rdev;
+	struct regmap *regmap;
+	int i, ret;
+	unsigned int data;
+
+	regmap = devm_regmap_init_i2c(i2c, &fan53880_regmap);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&i2c->dev, "Failed to create regmap: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_read(regmap, FAN53880_PRODUCT_ID, &data);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to read PRODUCT_ID: %d\n", ret);
+		return ret;
+	}
+	if (data != FAN53880_ID) {
+		dev_err(&i2c->dev, "Unsupported device id: 0x%x.\n", data);
+		return -ENODEV;
+	}
+
+	config.dev = &i2c->dev;
+	config.init_data = NULL;
+
+	for (i = 0; i < ARRAY_SIZE(fan53880_regulators); i++) {
+		rdev = devm_regulator_register(&i2c->dev,
+					       &fan53880_regulators[i],
+					       &config);
+		if (IS_ERR(rdev)) {
+			ret = PTR_ERR(rdev);
+			dev_err(&i2c->dev, "Failed to register %s: %d\n",
+				fan53880_regulators[i].name, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id fan53880_dt_ids[] = {
+	{ .compatible = "onnn,fan53880", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, fan53880_dt_ids);
+
+static const struct i2c_device_id fan53880_i2c_id[] = {
+	{ "fan53880", },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, fan53880_i2c_id);
+
+static struct i2c_driver fan53880_regulator_driver = {
+	.driver = {
+		.name = "fan53880",
+		.of_match_table	= of_match_ptr(fan53880_dt_ids),
+	},
+	.probe = fan53880_i2c_probe,
+	.id_table = fan53880_i2c_id,
+};
+module_i2c_driver(fan53880_regulator_driver);
+
+MODULE_DESCRIPTION("FAN53880 PMIC voltage regulator driver");
+MODULE_AUTHOR("Christoph Fritz <chf.fritz@googlemail.com>");
+MODULE_LICENSE("GPL");
-- 
2.20.1

