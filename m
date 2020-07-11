Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0702C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 17:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8683820786
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 17:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgGKROK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 13:14:10 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:38452 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728674AbgGKROJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 13:14:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 34404837F24C;
        Sat, 11 Jul 2020 17:14:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shape20_4a02b7826ed8
X-Filterd-Recvd-Size: 13491
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sat, 11 Jul 2020 17:14:07 +0000 (UTC)
Message-ID: <cbbc3fe69370d9c120c118a985841521db5ec769.camel@perches.com>
Subject: Re: [PATCH] regulator: Use const regulator_ops when possible
From:   Joe Perches <joe@perches.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 11 Jul 2020 10:14:06 -0700
In-Reply-To: <dab1ba1aa03a8236933cfb7a28937efb0b808f13.camel@perches.com>
References: <20200711114409.9911-1-rikard.falkeborn@gmail.com>
         <dab1ba1aa03a8236933cfb7a28937efb0b808f13.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add const to declaration of struct regulator_ops where appropriate.

Signed-off-by: Joe Perches <joe@perches.com>
---
Compiled/untested

 drivers/regulator/dummy.c              |  2 +-
 drivers/regulator/fixed.c              |  4 ++--
 drivers/regulator/pca9450-regulator.c  |  6 +++---
 drivers/regulator/stw481x-vmmc.c       |  2 +-
 drivers/regulator/tps51632-regulator.c |  2 +-
 drivers/regulator/tps6105x-regulator.c |  2 +-
 drivers/regulator/tps62360-regulator.c |  2 +-
 drivers/regulator/tps65086-regulator.c |  4 ++--
 drivers/regulator/tps65090-regulator.c |  8 ++++----
 drivers/regulator/tps6586x-regulator.c |  8 ++++----
 drivers/regulator/tps65910-regulator.c | 10 +++++-----
 drivers/regulator/tps65912-regulator.c |  4 ++--
 12 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/regulator/dummy.c b/drivers/regulator/dummy.c
index 74de6983c61a..306e417448ec 100644
--- a/drivers/regulator/dummy.c
+++ b/drivers/regulator/dummy.c
@@ -27,7 +27,7 @@ static struct regulator_init_data dummy_initdata = {
 	},
 };
 
-static struct regulator_ops dummy_ops;
+static const struct regulator_ops dummy_ops;
 
 static const struct regulator_desc dummy_desc = {
 	.name = "regulator-dummy",
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index d54830e48b8d..2ca84e88d34d 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -131,10 +131,10 @@ of_get_fixed_voltage_config(struct device *dev,
 	return config;
 }
 
-static struct regulator_ops fixed_voltage_ops = {
+static const struct regulator_ops fixed_voltage_ops = {
 };
 
-static struct regulator_ops fixed_voltage_clkenabled_ops = {
+static const struct regulator_ops fixed_voltage_clkenabled_ops = {
 	.enable = reg_clock_enable,
 	.disable = reg_clock_disable,
 	.is_enabled = reg_clock_is_enabled,
diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 02250459aa90..4747ceff99d0 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -90,7 +90,7 @@ static int pca9450_dvs_set_ramp_delay(struct regulator_dev *rdev,
 				  BUCK1_RAMP_MASK, ramp_value << 6);
 }
 
-static struct regulator_ops pca9450_dvs_buck_regulator_ops = {
+static const struct regulator_ops pca9450_dvs_buck_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -101,7 +101,7 @@ static struct regulator_ops pca9450_dvs_buck_regulator_ops = {
 	.set_ramp_delay = pca9450_dvs_set_ramp_delay,
 };
 
-static struct regulator_ops pca9450_buck_regulator_ops = {
+static const struct regulator_ops pca9450_buck_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -111,7 +111,7 @@ static struct regulator_ops pca9450_buck_regulator_ops = {
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
 };
 
-static struct regulator_ops pca9450_ldo_regulator_ops = {
+static const struct regulator_ops pca9450_ldo_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
diff --git a/drivers/regulator/stw481x-vmmc.c b/drivers/regulator/stw481x-vmmc.c
index 6dc2316daad3..1dd90aa1a79d 100644
--- a/drivers/regulator/stw481x-vmmc.c
+++ b/drivers/regulator/stw481x-vmmc.c
@@ -27,7 +27,7 @@ static const unsigned int stw481x_vmmc_voltages[] = {
 	3300000,
 };
 
-static struct regulator_ops stw481x_vmmc_ops = {
+static const struct regulator_ops stw481x_vmmc_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.enable      = regulator_enable_regmap,
 	.disable     = regulator_disable_regmap,
diff --git a/drivers/regulator/tps51632-regulator.c b/drivers/regulator/tps51632-regulator.c
index c139890c1514..a15e415e61d5 100644
--- a/drivers/regulator/tps51632-regulator.c
+++ b/drivers/regulator/tps51632-regulator.c
@@ -108,7 +108,7 @@ static int tps51632_dcdc_set_ramp_delay(struct regulator_dev *rdev,
 	return ret;
 }
 
-static struct regulator_ops tps51632_dcdc_ops = {
+static const struct regulator_ops tps51632_dcdc_ops = {
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
diff --git a/drivers/regulator/tps6105x-regulator.c b/drivers/regulator/tps6105x-regulator.c
index f8939af0bd2c..a6469fe05635 100644
--- a/drivers/regulator/tps6105x-regulator.c
+++ b/drivers/regulator/tps6105x-regulator.c
@@ -26,7 +26,7 @@ static const unsigned int tps6105x_voltages[] = {
 	5000000, /* There is an additional 5V */
 };
 
-static struct regulator_ops tps6105x_regulator_ops = {
+static const struct regulator_ops tps6105x_regulator_ops = {
 	.enable		= regulator_enable_regmap,
 	.disable	= regulator_disable_regmap,
 	.is_enabled	= regulator_is_enabled_regmap,
diff --git a/drivers/regulator/tps62360-regulator.c b/drivers/regulator/tps62360-regulator.c
index f6a6d36a6533..315cd5daf480 100644
--- a/drivers/regulator/tps62360-regulator.c
+++ b/drivers/regulator/tps62360-regulator.c
@@ -233,7 +233,7 @@ static unsigned int tps62360_get_mode(struct regulator_dev *rdev)
 				REGULATOR_MODE_FAST : REGULATOR_MODE_NORMAL;
 }
 
-static struct regulator_ops tps62360_dcdc_ops = {
+static const struct regulator_ops tps62360_dcdc_ops = {
 	.get_voltage_sel	= tps62360_dcdc_get_voltage_sel,
 	.set_voltage_sel	= tps62360_dcdc_set_voltage_sel,
 	.list_voltage		= regulator_list_voltage_linear,
diff --git a/drivers/regulator/tps65086-regulator.c b/drivers/regulator/tps65086-regulator.c
index 9910e949373c..f702e21224f6 100644
--- a/drivers/regulator/tps65086-regulator.c
+++ b/drivers/regulator/tps65086-regulator.c
@@ -101,7 +101,7 @@ static const struct linear_range tps65086_ldoa23_ranges[] = {
 };
 
 /* Operations permitted on regulators */
-static struct regulator_ops reg_ops = {
+static const struct regulator_ops reg_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -112,7 +112,7 @@ static struct regulator_ops reg_ops = {
 };
 
 /* Operations permitted on load switches */
-static struct regulator_ops switch_ops = {
+static const struct regulator_ops switch_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
diff --git a/drivers/regulator/tps65090-regulator.c b/drivers/regulator/tps65090-regulator.c
index f0b660e9f15f..1d2e04f452d4 100644
--- a/drivers/regulator/tps65090-regulator.c
+++ b/drivers/regulator/tps65090-regulator.c
@@ -47,7 +47,7 @@ struct tps65090_regulator {
 	int			overcurrent_wait;
 };
 
-static struct regulator_ops tps65090_ext_control_ops = {
+static const struct regulator_ops tps65090_ext_control_ops = {
 };
 
 /**
@@ -167,19 +167,19 @@ static int tps65090_fet_enable(struct regulator_dev *rdev)
 	return ret;
 }
 
-static struct regulator_ops tps65090_reg_control_ops = {
+static const struct regulator_ops tps65090_reg_control_ops = {
 	.enable		= regulator_enable_regmap,
 	.disable	= regulator_disable_regmap,
 	.is_enabled	= regulator_is_enabled_regmap,
 };
 
-static struct regulator_ops tps65090_fet_control_ops = {
+static const struct regulator_ops tps65090_fet_control_ops = {
 	.enable		= tps65090_fet_enable,
 	.disable	= regulator_disable_regmap,
 	.is_enabled	= regulator_is_enabled_regmap,
 };
 
-static struct regulator_ops tps65090_ldo_ops = {
+static const struct regulator_ops tps65090_ldo_ops = {
 };
 
 #define tps65090_REG_DESC(_id, _sname, _en_reg, _en_bits, _nvolt, _volt, _ops) \
diff --git a/drivers/regulator/tps6586x-regulator.c b/drivers/regulator/tps6586x-regulator.c
index 09e994e1f9a9..18bf4b885b08 100644
--- a/drivers/regulator/tps6586x-regulator.c
+++ b/drivers/regulator/tps6586x-regulator.c
@@ -60,7 +60,7 @@ struct tps6586x_regulator {
 	int enable_reg[2];
 };
 
-static struct regulator_ops tps6586x_rw_regulator_ops = {
+static const struct regulator_ops tps6586x_rw_regulator_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
@@ -71,7 +71,7 @@ static struct regulator_ops tps6586x_rw_regulator_ops = {
 	.disable = regulator_disable_regmap,
 };
 
-static struct regulator_ops tps6586x_rw_linear_regulator_ops = {
+static const struct regulator_ops tps6586x_rw_linear_regulator_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
@@ -81,7 +81,7 @@ static struct regulator_ops tps6586x_rw_linear_regulator_ops = {
 	.disable = regulator_disable_regmap,
 };
 
-static struct regulator_ops tps6586x_ro_regulator_ops = {
+static const struct regulator_ops tps6586x_ro_regulator_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
@@ -91,7 +91,7 @@ static struct regulator_ops tps6586x_ro_regulator_ops = {
 	.disable = regulator_disable_regmap,
 };
 
-static struct regulator_ops tps6586x_sys_regulator_ops = {
+static const struct regulator_ops tps6586x_sys_regulator_ops = {
 };
 
 static const unsigned int tps6586x_ldo0_voltages[] = {
diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index 4eb5b19d2344..faa5b3538167 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -757,7 +757,7 @@ static int tps65911_list_voltage(struct regulator_dev *dev, unsigned selector)
 }
 
 /* Regulator ops (except VRTC) */
-static struct regulator_ops tps65910_ops_dcdc = {
+static const struct regulator_ops tps65910_ops_dcdc = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -770,7 +770,7 @@ static struct regulator_ops tps65910_ops_dcdc = {
 	.map_voltage		= regulator_map_voltage_ascend,
 };
 
-static struct regulator_ops tps65910_ops_vdd3 = {
+static const struct regulator_ops tps65910_ops_vdd3 = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -781,7 +781,7 @@ static struct regulator_ops tps65910_ops_vdd3 = {
 	.map_voltage		= regulator_map_voltage_ascend,
 };
 
-static struct regulator_ops tps65910_ops_vbb = {
+static const struct regulator_ops tps65910_ops_vbb = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -793,7 +793,7 @@ static struct regulator_ops tps65910_ops_vbb = {
 	.map_voltage		= regulator_map_voltage_iterate,
 };
 
-static struct regulator_ops tps65910_ops = {
+static const struct regulator_ops tps65910_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -805,7 +805,7 @@ static struct regulator_ops tps65910_ops = {
 	.map_voltage		= regulator_map_voltage_ascend,
 };
 
-static struct regulator_ops tps65911_ops = {
+static const struct regulator_ops tps65911_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
diff --git a/drivers/regulator/tps65912-regulator.c b/drivers/regulator/tps65912-regulator.c
index 15c79931ea89..ef6ecdc1875b 100644
--- a/drivers/regulator/tps65912-regulator.c
+++ b/drivers/regulator/tps65912-regulator.c
@@ -57,7 +57,7 @@ static const struct linear_range tps65912_ldo_ranges[] = {
 };
 
 /* Operations permitted on DCDCx */
-static struct regulator_ops tps65912_ops_dcdc = {
+static const struct regulator_ops tps65912_ops_dcdc = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -67,7 +67,7 @@ static struct regulator_ops tps65912_ops_dcdc = {
 };
 
 /* Operations permitted on LDOx */
-static struct regulator_ops tps65912_ops_ldo = {
+static const struct regulator_ops tps65912_ops_ldo = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,


