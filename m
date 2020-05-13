Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B1DC43445
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEED220708
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388996AbgEMOkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:40:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40974 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgEMOkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:40:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id j3so18046413ljg.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 07:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=njt/XgZKL+tLj0smApBArvMs6LwP+bSvfP2+U9R0aww=;
        b=Fn51XU4KZjSgar35dp6qLCcQ884lGquBJ0menN6WpyB5Dbv8CAj8AyapzUWGe8uo+6
         PtptE5U/zHm9/s4SxiCMkLMn8+/dl825Dutfpb4p7KYspudAE+JfFUvUNKkwg7l856Ir
         1NUFqfYpD47H4Tqfw4VzN73xWbUEArGSBrhSfQpOD65HkYALdbjqnstBuaRsKMI0pg+f
         SFnpIdbxlsvNJZIzH927EEQ65iD9CkTvf9/qwjvzuukolVKzP0QouKmHUjD4f6Si1I0l
         s7yvT2Zqz9xm3p6aOba/+KR4/ZlFF2HD4AeBlvnJM9UnViY6fAWBg0y08MEyBlVPIxf8
         ltyA==
X-Gm-Message-State: AOAM530FA6RtWsDNlNPlDhzr3PRhy3ULj+CtSoWfM/cdiFvdD4JlOxEw
        HYOF76e7kIDfmmAj/ZOZ5s6V3X6SkQk=
X-Google-Smtp-Source: ABdhPJwoF0+bkztTFDGHraC/F68UD4SwnDnFTN9zrmfQ5sSBrjH7rDN6MXDEuI+8mB06tjlKZbYE7A==
X-Received: by 2002:a2e:9084:: with SMTP id l4mr18300054ljg.132.1589380808931;
        Wed, 13 May 2020 07:40:08 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id z64sm16064469lfa.50.2020.05.13.07.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 07:40:08 -0700 (PDT)
Date:   Wed, 13 May 2020 17:39:21 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: bd718x7: remove voltage change restriction from
 BD71847 LDOs
Message-ID: <20200513143921.GA22143@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BD71837 had a HW "feature" where changing the regulator output
voltages of other regulators but bucks 1-4 might cause spikes if
regulators were enabled. Thus SW prohibit voltage changes for other
regulators except for bucks 1-4 when regulator is enabled.

The HW colleagues did inadvertly fix this issue for BD71847 and
BD71850.

The power-good detection for LDOs can still cause false alarms if
LDO voltage is changed upwards when LDO is enabled.

Allow LDO voltage changes and disabe the power-good monioring for
the duration of the LDO voltage change and enable it after LDO
voltage has stabilized. ROHM HW colleagues measured the safety
limit of 1000uS for guaranteeing the voltage has stabilized. Let's
use that for starters and add confiurable stabilization wait-time
later if needed.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/bd718x7-regulator.c | 170 ++++++++++++++++++++++++--
 1 file changed, 158 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index 1737bc978e5c..7b311389f925 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -62,10 +62,13 @@ static int bd718xx_buck1234_set_ramp_delay(struct regulator_dev *rdev,
  * is changed. Hence we return -EBUSY for these if voltage is changed
  * when BUCK/LDO is enabled.
  *
- * The LDO operation for BD71847 and BD71850 is icurrently unknown.
- * It's safer to still assume they can't be changed when enabled.
+ * On BD71847, BD71850, ... The LDO voltage can be changed when LDO is
+ * enabled. But if voltage is increased the LDO power-good monitoring
+ * must be disabled for the duration of changing + 1mS to ensure voltage
+ * has reached the higher level before HW does next under voltage detection
+ * cycle.
  */
-static int bd718xx_set_voltage_sel_restricted(struct regulator_dev *rdev,
+static int bd71837_set_voltage_sel_restricted(struct regulator_dev *rdev,
 						    unsigned int sel)
 {
 	if (regulator_is_enabled_regmap(rdev))
@@ -74,8 +77,123 @@ static int bd718xx_set_voltage_sel_restricted(struct regulator_dev *rdev,
 	return regulator_set_voltage_sel_regmap(rdev, sel);
 }
 
+static void voltage_change_done(struct regulator_dev *rdev, unsigned int sel,
+				unsigned int *mask)
+{
+	int ret;
+
+	if (*mask) {
+		/*
+		 * Let's allow scheduling as we use I2C anyways. We just need to
+		 * guarantee minimum of 1ms sleep - it shouldn't matter if we
+		 * exceed it due to the scheduling.
+		 */
+		msleep(1);
+		/*
+		 * Note for next hacker. The PWRGOOD should not be masked on
+		 * BD71847 so we will just unconditionally enable detection
+		 * when voltage is set.
+		 * If someone want's to disable PWRGOOD he must implement
+		 * caching and restoring the old value here. I am not
+		 * aware of such use-cases so for the sake of the simplicity
+		 * we just always enable PWRGOOD here.
+		 */
+		ret = regmap_update_bits(rdev->regmap, BD718XX_REG_MVRFLTMASK2,
+					 *mask, 0);
+		if (ret)
+			dev_err(&rdev->dev,
+				"Failed to re-enable voltage monitoring (%d)\n",
+				ret);
+	}
+}
+
+static int voltage_change_prepare(struct regulator_dev *rdev, unsigned int sel,
+				  unsigned int *mask)
+{
+	int ret;
+
+	*mask = 0;
+	if (regulator_is_enabled_regmap(rdev)) {
+		int now, new;
+
+		now = rdev->desc->ops->get_voltage_sel(rdev);
+		if (now < 0)
+			return now;
+
+		now = rdev->desc->ops->list_voltage(rdev, now);
+		if (now < 0)
+			return now;
+
+		new = rdev->desc->ops->list_voltage(rdev, sel);
+		if (new < 0)
+			return new;
+
+		/*
+		 * If we increase LDO voltage when LDO is enabled we need to
+		 * disable the power-good detection until voltage has reached
+		 * the new level. According to HW colleagues the maximum time
+		 * it takes is 1000us. I assume that on systems with light load
+		 * this might be less - and we could probably use DT to give
+		 * system specific delay value if performance matters.
+		 *
+		 * Well, knowing we use I2C here and can add scheduling delays
+		 * I don't think it is worth the hassle and I just add fixed
+		 * 1ms sleep here (and allow scheduling). If this turns out to
+		 * be a problem we can change it to delay and make the delay
+		 * time configurable.
+		 */
+		if (new > now) {
+			int ldo_offset = rdev->desc->id - BD718XX_LDO1;
+
+			*mask = BD718XX_LDO1_VRMON80 << ldo_offset;
+			ret = regmap_update_bits(rdev->regmap,
+						 BD718XX_REG_MVRFLTMASK2,
+						 *mask, *mask);
+			if (ret) {
+				dev_err(&rdev->dev,
+					"Failed to stop voltage monitoring\n");
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int bd718xx_set_voltage_sel_restricted(struct regulator_dev *rdev,
+						    unsigned int sel)
+{
+	int ret;
+	int mask;
+
+	ret = voltage_change_prepare(rdev, sel, &mask);
+	if (ret)
+		return ret;
+
+	ret = regulator_set_voltage_sel_regmap(rdev, sel);
+	voltage_change_done(rdev, sel, &mask);
+
+	return ret;
+}
+
 static int bd718xx_set_voltage_sel_pickable_restricted(
 		struct regulator_dev *rdev, unsigned int sel)
+{
+	int ret;
+	int mask;
+
+	ret = voltage_change_prepare(rdev, sel, &mask);
+	if (ret)
+		return ret;
+
+	ret = regulator_set_voltage_sel_pickable_regmap(rdev, sel);
+	voltage_change_done(rdev, sel, &mask);
+
+	return ret;
+}
+
+static int bd71837_set_voltage_sel_pickable_restricted(
+		struct regulator_dev *rdev, unsigned int sel)
 {
 	if (regulator_is_enabled_regmap(rdev))
 		return -EBUSY;
@@ -90,6 +208,16 @@ static const struct regulator_ops bd718xx_pickable_range_ldo_ops = {
 	.list_voltage = regulator_list_voltage_pickable_linear_range,
 	.set_voltage_sel = bd718xx_set_voltage_sel_pickable_restricted,
 	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
+
+};
+
+static const struct regulator_ops bd71837_pickable_range_ldo_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_pickable_linear_range,
+	.set_voltage_sel = bd71837_set_voltage_sel_pickable_restricted,
+	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
 };
 
 static const struct regulator_ops bd718xx_pickable_range_buck_ops = {
@@ -107,11 +235,20 @@ static const struct regulator_ops bd71837_pickable_range_buck_ops = {
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
 	.list_voltage = regulator_list_voltage_pickable_linear_range,
-	.set_voltage_sel = bd718xx_set_voltage_sel_pickable_restricted,
+	.set_voltage_sel = bd71837_set_voltage_sel_pickable_restricted,
 	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
 };
 
+static const struct regulator_ops bd71837_ldo_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = bd71837_set_voltage_sel_restricted,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+};
+
 static const struct regulator_ops bd718xx_ldo_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
@@ -121,6 +258,15 @@ static const struct regulator_ops bd718xx_ldo_regulator_ops = {
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 };
 
+static const struct regulator_ops bd71837_ldo_regulator_nolinear_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_table,
+	.set_voltage_sel = bd71837_set_voltage_sel_restricted,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+};
+
 static const struct regulator_ops bd718xx_ldo_regulator_nolinear_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
@@ -145,7 +291,7 @@ static const struct regulator_ops bd71837_buck_regulator_ops = {
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
 	.list_voltage = regulator_list_voltage_linear_range,
-	.set_voltage_sel = bd718xx_set_voltage_sel_restricted,
+	.set_voltage_sel = bd71837_set_voltage_sel_restricted,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
 };
@@ -938,7 +1084,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("LDO1"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO1,
-			.ops = &bd718xx_pickable_range_ldo_ops,
+			.ops = &bd71837_pickable_range_ldo_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_LDO1_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_ldo1_volts,
@@ -964,7 +1110,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("LDO2"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO2,
-			.ops = &bd718xx_ldo_regulator_nolinear_ops,
+			.ops = &bd71837_ldo_regulator_nolinear_ops,
 			.type = REGULATOR_VOLTAGE,
 			.volt_table = &ldo_2_volts[0],
 			.vsel_reg = BD718XX_REG_LDO2_VOLT,
@@ -986,7 +1132,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("LDO3"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO3,
-			.ops = &bd718xx_ldo_regulator_ops,
+			.ops = &bd71837_ldo_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_LDO3_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_ldo3_volts,
@@ -1009,7 +1155,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("LDO4"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO4,
-			.ops = &bd718xx_ldo_regulator_ops,
+			.ops = &bd71837_ldo_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_LDO4_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_ldo4_volts,
@@ -1032,7 +1178,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("LDO5"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO5,
-			.ops = &bd718xx_ldo_regulator_ops,
+			.ops = &bd71837_ldo_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD71837_LDO5_VOLTAGE_NUM,
 			.linear_ranges = bd71837_ldo5_volts,
@@ -1059,7 +1205,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("LDO6"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO6,
-			.ops = &bd718xx_ldo_regulator_ops,
+			.ops = &bd71837_ldo_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_LDO6_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_ldo6_volts,
@@ -1086,7 +1232,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("LDO7"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO7,
-			.ops = &bd718xx_ldo_regulator_ops,
+			.ops = &bd71837_ldo_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD71837_LDO7_VOLTAGE_NUM,
 			.linear_ranges = bd71837_ldo7_volts,

base-commit: 0553af564bdebbf9dd2396061208b46538df1c61
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
