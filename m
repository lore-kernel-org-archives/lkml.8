Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06292C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B82AF20709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgICSjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:39:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44052 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgICSjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:39:18 -0400
Received: by mail-lj1-f195.google.com with SMTP id b19so4912689lji.11;
        Thu, 03 Sep 2020 11:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9wrRpSXu9dVvScOdmhAd1OqaGua8P6/Pp56reDVLhFE=;
        b=TA/81UylCklNdbI4tdwyAYGA2ORp8Mb1X1761GezFuncTJ3YyCmUYg5xBtv0amZ6mh
         1GoeexiznWT0/occ8seiF2PWZpbMMu5b+Zi9X/U8fl7135WCRyZK1W5Z7oe6NoodoZKW
         +CVioSdh9Qj9AtT/GqE8k88B++PSfHvZZaowrKM/8HXldGgHa8q/zT6mz5D7fuewHd0f
         L5X1NAybZQxbNm66xKPrVLZOdtBw6y3IHdtHeaVOFcL7vDI7MSagpYIO3nyMvTt2cZnl
         EWcrt4kOuCVyJKTfN7jOvJHXg8zRlRnmsStu9RFpiulVMMFl1Q1/zK3zh855p7sBXgok
         r3Pw==
X-Gm-Message-State: AOAM533JMNxw6xp+z5U+s1f/HLwVXFkW3piceB4m87lrXG6Lgb7FtZiX
        aPscLmA5CUQrZBAHlIEMgG4=
X-Google-Smtp-Source: ABdhPJyZG3vhNALIcT6arQddIMGn4rxR5tM8yFMYebmSTUl1OeNnuSwAS736S+dyLnUNJ8hzfto3Pw==
X-Received: by 2002:a2e:a16c:: with SMTP id u12mr1569139ljl.266.1599158350255;
        Thu, 03 Sep 2020 11:39:10 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id l16sm775356ljb.72.2020.09.03.11.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 11:39:09 -0700 (PDT)
Date:   Thu, 3 Sep 2020 21:39:02 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [PATCH 4/4] regulator: bd718x7 fix regulator states at SUSPEND
Message-ID: <6ebba33dd08f2dcc9f1137bbff4d2dc905278a5a.1599029335.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1599029334.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1599029334.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BD718(37/47/50) regulator enable states can be controlled
either by SW or by PMIC internal state machine. The bd718x7
driver has not supported leaving the regulators under HW state
machine control (except for cases where this is required to
avoid boot-up problems due to critical regulators being turned
OFF at reset when SNVS used as reset state).

On some systems this is undesirable as there now are setups where
mixture of SW and HW state machine controlled regulators is needed.

Specifically, some SoCs signal SUSPEND state change to PMIC via
STBY_REQ line. Now there are setups that expect certain regulators
then to be disabled (by PMIC state machine) while other regulators
should stay enabled (regardless of HW state => SW control required).

Add support for a new device-tree property
"rohm,no-regulator-enable-control" which can be used to leave
regulator(s) under HW state machine control.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/bd718x7-regulator.c | 417 +++++++++++++++++---------
 1 file changed, 268 insertions(+), 149 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index a72031595b9e..159c917b9c4c 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -15,6 +15,39 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/slab.h>
 
+/*
+ * BD718(37/47/50) have two "enable control modes". ON/OFF can either be
+ * controlled by software - or by PMIC internal HW state machine. Whether
+ * regulator should be under SW or HW control can be defined from device-tree.
+ * Let's provide separate ops for regulators to use depending on the "enable
+ * control mode".
+ */
+#define BD718XX_HWOPNAME(swopname) swopname##_hwcontrol
+
+#define BD718XX_OPS(name, _list_voltage, _map_voltage, _set_voltage_sel, \
+		   _get_voltage_sel, _set_voltage_time_sel, _set_ramp_delay) \
+static const struct regulator_ops name = {			\
+	.enable = regulator_enable_regmap,			\
+	.disable = regulator_disable_regmap,			\
+	.is_enabled = regulator_is_enabled_regmap,		\
+	.list_voltage = (_list_voltage),			\
+	.map_voltage = (_map_voltage),				\
+	.set_voltage_sel = (_set_voltage_sel),			\
+	.get_voltage_sel = (_get_voltage_sel),			\
+	.set_voltage_time_sel = (_set_voltage_time_sel),	\
+	.set_ramp_delay = (_set_ramp_delay),			\
+};								\
+								\
+static const struct regulator_ops BD718XX_HWOPNAME(name) = {	\
+	.is_enabled = always_enabled_by_hwstate,		\
+	.list_voltage = (_list_voltage),			\
+	.map_voltage = (_map_voltage),				\
+	.set_voltage_sel = (_set_voltage_sel),			\
+	.get_voltage_sel = (_get_voltage_sel),			\
+	.set_voltage_time_sel = (_set_voltage_time_sel),	\
+	.set_ramp_delay = (_set_ramp_delay),			\
+}								\
+
 /*
  * BUCK1/2/3/4
  * BUCK1RAMPRATE[1:0] BUCK1 DVS ramp rate setting
@@ -55,6 +88,38 @@ static int bd718xx_buck1234_set_ramp_delay(struct regulator_dev *rdev,
 				  BUCK_RAMPRATE_MASK, ramp_value << 6);
 }
 
+/* These functions are used when regulators are under HW state machine control.
+ * We assume PMIC is in RUN state because SW running and able to query the
+ * status. Most of the regulators have fixed ON or OFF state at RUN/IDLE so for
+ * them we just return a constant. BD71837 BUCK3 and BUCK4 are exceptions as
+ * they support configuring the ON/OFF state for RUN.
+ *
+ * Note for next hacker - these PMICs have a register where the HW state can be
+ * read. If assuming RUN appears to be false in your use-case - you can
+ * implement state reading (although that is not going to be atomic) before
+ * returning the enable state.
+ */
+static int always_enabled_by_hwstate(struct regulator_dev *rdev)
+{
+	return 1;
+}
+
+static int never_enabled_by_hwstate(struct regulator_dev *rdev)
+{
+	return 0;
+}
+
+static int bd71837_get_buck34_enable_hwctrl(struct regulator_dev *rdev)
+{
+	int ret;
+	unsigned int val;
+
+	ret = regmap_read(rdev->regmap, rdev->desc->enable_reg, &val);
+	if (ret)
+		return ret;
+
+	return !!(BD718XX_BUCK_RUN_ON & val);
+}
 /*
  * On BD71837 (not on BD71847, BD71850, ...)
  * Bucks 1 to 4 support DVS. PWM mode is used when voltage is changed.
@@ -71,7 +136,7 @@ static int bd718xx_buck1234_set_ramp_delay(struct regulator_dev *rdev,
 static int bd71837_set_voltage_sel_restricted(struct regulator_dev *rdev,
 						    unsigned int sel)
 {
-	if (regulator_is_enabled_regmap(rdev))
+	if (rdev->desc->ops->is_enabled(rdev))
 		return -EBUSY;
 
 	return regulator_set_voltage_sel_regmap(rdev, sel);
@@ -113,7 +178,7 @@ static int voltage_change_prepare(struct regulator_dev *rdev, unsigned int sel,
 	int ret;
 
 	*mask = 0;
-	if (regulator_is_enabled_regmap(rdev)) {
+	if (rdev->desc->ops->is_enabled(rdev)) {
 		int now, new;
 
 		now = rdev->desc->ops->get_voltage_sel(rdev);
@@ -195,133 +260,90 @@ static int bd718xx_set_voltage_sel_pickable_restricted(
 static int bd71837_set_voltage_sel_pickable_restricted(
 		struct regulator_dev *rdev, unsigned int sel)
 {
-	if (regulator_is_enabled_regmap(rdev))
+	if (rdev->desc->ops->is_enabled(rdev))
 		return -EBUSY;
 
 	return regulator_set_voltage_sel_pickable_regmap(rdev, sel);
 }
 
-static const struct regulator_ops bd718xx_pickable_range_ldo_ops = {
-	.enable = regulator_enable_regmap,
-	.disable = regulator_disable_regmap,
-	.is_enabled = regulator_is_enabled_regmap,
+/*
+ * OPS common for BD71847 and BD71850
+ */
+BD718XX_OPS(bd718xx_pickable_range_ldo_ops,
+	    regulator_list_voltage_pickable_linear_range, NULL,
+	    bd718xx_set_voltage_sel_pickable_restricted,
+	    regulator_get_voltage_sel_pickable_regmap, NULL, NULL);
+
+/* BD71847 and BD71850 LDO 5 is by default OFF at RUN state */
+static const struct regulator_ops bd718xx_ldo5_ops_hwstate = {
+	.is_enabled = never_enabled_by_hwstate,
 	.list_voltage = regulator_list_voltage_pickable_linear_range,
 	.set_voltage_sel = bd718xx_set_voltage_sel_pickable_restricted,
 	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
-
 };
 
-static const struct regulator_ops bd71837_pickable_range_ldo_ops = {
-	.enable = regulator_enable_regmap,
-	.disable = regulator_disable_regmap,
-	.is_enabled = regulator_is_enabled_regmap,
-	.list_voltage = regulator_list_voltage_pickable_linear_range,
-	.set_voltage_sel = bd71837_set_voltage_sel_pickable_restricted,
-	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
-};
-
-static const struct regulator_ops bd718xx_pickable_range_buck_ops = {
-	.enable = regulator_enable_regmap,
-	.disable = regulator_disable_regmap,
-	.is_enabled = regulator_is_enabled_regmap,
-	.list_voltage = regulator_list_voltage_pickable_linear_range,
-	.set_voltage_sel = regulator_set_voltage_sel_pickable_regmap,
-	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
-	.set_voltage_time_sel = regulator_set_voltage_time_sel,
-};
+BD718XX_OPS(bd718xx_pickable_range_buck_ops,
+	    regulator_list_voltage_pickable_linear_range, NULL,
+	    regulator_set_voltage_sel_pickable_regmap,
+	    regulator_get_voltage_sel_pickable_regmap,
+	    regulator_set_voltage_time_sel, NULL);
 
-static const struct regulator_ops bd71837_pickable_range_buck_ops = {
-	.enable = regulator_enable_regmap,
-	.disable = regulator_disable_regmap,
-	.is_enabled = regulator_is_enabled_regmap,
-	.list_voltage = regulator_list_voltage_pickable_linear_range,
-	.set_voltage_sel = bd71837_set_voltage_sel_pickable_restricted,
-	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
-	.set_voltage_time_sel = regulator_set_voltage_time_sel,
-};
-
-static const struct regulator_ops bd71837_ldo_regulator_ops = {
-	.enable = regulator_enable_regmap,
-	.disable = regulator_disable_regmap,
-	.is_enabled = regulator_is_enabled_regmap,
-	.list_voltage = regulator_list_voltage_linear_range,
-	.set_voltage_sel = bd71837_set_voltage_sel_restricted,
-	.get_voltage_sel = regulator_get_voltage_sel_regmap,
-};
+BD718XX_OPS(bd718xx_ldo_regulator_ops, regulator_list_voltage_linear_range,
+	    NULL, bd718xx_set_voltage_sel_restricted,
+	    regulator_get_voltage_sel_regmap, NULL, NULL);
 
-static const struct regulator_ops bd718xx_ldo_regulator_ops = {
-	.enable = regulator_enable_regmap,
-	.disable = regulator_disable_regmap,
-	.is_enabled = regulator_is_enabled_regmap,
-	.list_voltage = regulator_list_voltage_linear_range,
-	.set_voltage_sel = bd718xx_set_voltage_sel_restricted,
-	.get_voltage_sel = regulator_get_voltage_sel_regmap,
-};
+BD718XX_OPS(bd718xx_ldo_regulator_nolinear_ops, regulator_list_voltage_table,
+	    NULL, bd718xx_set_voltage_sel_restricted,
+	    regulator_get_voltage_sel_regmap, NULL, NULL);
 
-static const struct regulator_ops bd71837_ldo_regulator_nolinear_ops = {
-	.enable = regulator_enable_regmap,
-	.disable = regulator_disable_regmap,
-	.is_enabled = regulator_is_enabled_regmap,
-	.list_voltage = regulator_list_voltage_table,
-	.set_voltage_sel = bd71837_set_voltage_sel_restricted,
-	.get_voltage_sel = regulator_get_voltage_sel_regmap,
-};
+BD718XX_OPS(bd718xx_buck_regulator_ops, regulator_list_voltage_linear_range,
+	    NULL, regulator_set_voltage_sel_regmap,
+	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
+	    NULL);
 
-static const struct regulator_ops bd718xx_ldo_regulator_nolinear_ops = {
-	.enable = regulator_enable_regmap,
-	.disable = regulator_disable_regmap,
-	.is_enabled = regulator_is_enabled_regmap,
-	.list_voltage = regulator_list_voltage_table,
-	.set_voltage_sel = bd718xx_set_voltage_sel_restricted,
-	.get_voltage_sel = regulator_get_voltage_sel_regmap,
-};
+BD718XX_OPS(bd718xx_buck_regulator_nolinear_ops, regulator_list_voltage_table,
+	    regulator_map_voltage_ascend, regulator_set_voltage_sel_regmap,
+	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
+	    NULL);
 
-static const struct regulator_ops bd718xx_buck_regulator_ops = {
-	.enable = regulator_enable_regmap,
-	.disable = regulator_disable_regmap,
-	.is_enabled = regulator_is_enabled_regmap,
-	.list_voltage = regulator_list_voltage_linear_range,
-	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-	.get_voltage_sel = regulator_get_voltage_sel_regmap,
-	.set_voltage_time_sel = regulator_set_voltage_time_sel,
-};
-
-static const struct regulator_ops bd71837_buck_regulator_ops = {
-	.enable = regulator_enable_regmap,
-	.disable = regulator_disable_regmap,
-	.is_enabled = regulator_is_enabled_regmap,
-	.list_voltage = regulator_list_voltage_linear_range,
-	.set_voltage_sel = bd71837_set_voltage_sel_restricted,
-	.get_voltage_sel = regulator_get_voltage_sel_regmap,
-	.set_voltage_time_sel = regulator_set_voltage_time_sel,
-};
-
-static const struct regulator_ops bd718xx_buck_regulator_nolinear_ops = {
-	.enable = regulator_enable_regmap,
-	.disable = regulator_disable_regmap,
-	.is_enabled = regulator_is_enabled_regmap,
-	.list_voltage = regulator_list_voltage_table,
-	.map_voltage = regulator_map_voltage_ascend,
-	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-	.get_voltage_sel = regulator_get_voltage_sel_regmap,
-	.set_voltage_time_sel = regulator_set_voltage_time_sel,
-};
-
-static const struct regulator_ops bd71837_buck_regulator_nolinear_ops = {
-	.enable = regulator_enable_regmap,
-	.disable = regulator_disable_regmap,
-	.is_enabled = regulator_is_enabled_regmap,
-	.list_voltage = regulator_list_voltage_table,
-	.map_voltage = regulator_map_voltage_ascend,
-	.set_voltage_sel = bd718xx_set_voltage_sel_restricted,
-	.get_voltage_sel = regulator_get_voltage_sel_regmap,
-	.set_voltage_time_sel = regulator_set_voltage_time_sel,
-};
-
-static const struct regulator_ops bd718xx_dvs_buck_regulator_ops = {
-	.enable = regulator_enable_regmap,
-	.disable = regulator_disable_regmap,
-	.is_enabled = regulator_is_enabled_regmap,
+/*
+ * OPS for BD71837
+ */
+BD718XX_OPS(bd71837_pickable_range_ldo_ops,
+	    regulator_list_voltage_pickable_linear_range, NULL,
+	    bd71837_set_voltage_sel_pickable_restricted,
+	    regulator_get_voltage_sel_pickable_regmap, NULL, NULL);
+
+BD718XX_OPS(bd71837_pickable_range_buck_ops,
+	    regulator_list_voltage_pickable_linear_range, NULL,
+	    bd71837_set_voltage_sel_pickable_restricted,
+	    regulator_get_voltage_sel_pickable_regmap,
+	    regulator_set_voltage_time_sel, NULL);
+
+BD718XX_OPS(bd71837_ldo_regulator_ops, regulator_list_voltage_linear_range,
+	    NULL, bd71837_set_voltage_sel_restricted,
+	    regulator_get_voltage_sel_regmap, NULL, NULL);
+
+BD718XX_OPS(bd71837_ldo_regulator_nolinear_ops, regulator_list_voltage_table,
+	    NULL, bd71837_set_voltage_sel_restricted,
+	    regulator_get_voltage_sel_regmap, NULL, NULL);
+
+BD718XX_OPS(bd71837_buck_regulator_ops, regulator_list_voltage_linear_range,
+	    NULL, bd71837_set_voltage_sel_restricted,
+	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
+	    NULL);
+
+BD718XX_OPS(bd71837_buck_regulator_nolinear_ops, regulator_list_voltage_table,
+	    regulator_map_voltage_ascend, bd718xx_set_voltage_sel_restricted,
+	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
+	    NULL);
+/*
+ * BD71837 bucks 3 and 4 support defining their enable/disable state also
+ * when buck enable state is under HW state machine control. In that case the
+ * bit [2] in CTRL register is used to indicate if regulator should be ON.
+ */
+static const struct regulator_ops bd71837_buck34_ops_hwctrl = {
+	.is_enabled = bd71837_get_buck34_enable_hwctrl,
 	.list_voltage = regulator_list_voltage_linear_range,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
@@ -329,6 +351,14 @@ static const struct regulator_ops bd718xx_dvs_buck_regulator_ops = {
 	.set_ramp_delay = bd718xx_buck1234_set_ramp_delay,
 };
 
+/*
+ * OPS for all of the ICs - BD718(37/47/50)
+ */
+BD718XX_OPS(bd718xx_dvs_buck_regulator_ops, regulator_list_voltage_linear_range,
+	    NULL, regulator_set_voltage_sel_regmap,
+	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
+	    bd718xx_buck1234_set_ramp_delay);
+
 /*
  * BD71837 BUCK1/2/3/4
  * BD71847 BUCK1/2
@@ -543,14 +573,37 @@ static int buck_set_hw_dvs_levels(struct device_node *np,
 	return rohm_regulator_set_dvs_levels(&data->dvs, np, desc, cfg->regmap);
 }
 
-static const struct bd718xx_regulator_data bd71847_regulators[] = {
+const struct regulator_ops *bd71847_swcontrol_ops[] = {
+	&bd718xx_dvs_buck_regulator_ops, &bd718xx_dvs_buck_regulator_ops,
+	&bd718xx_pickable_range_buck_ops, &bd718xx_pickable_range_buck_ops,
+	&bd718xx_buck_regulator_nolinear_ops, &bd718xx_buck_regulator_ops,
+	&bd718xx_pickable_range_ldo_ops, &bd718xx_ldo_regulator_nolinear_ops,
+	&bd718xx_ldo_regulator_ops, &bd718xx_ldo_regulator_ops,
+	&bd718xx_pickable_range_ldo_ops, &bd718xx_ldo_regulator_ops,
+};
+
+const struct regulator_ops *bd71847_hwcontrol_ops[] = {
+	&BD718XX_HWOPNAME(bd718xx_dvs_buck_regulator_ops),
+	&BD718XX_HWOPNAME(bd718xx_dvs_buck_regulator_ops),
+	&BD718XX_HWOPNAME(bd718xx_pickable_range_buck_ops),
+	&BD718XX_HWOPNAME(bd718xx_pickable_range_buck_ops),
+	&BD718XX_HWOPNAME(bd718xx_buck_regulator_nolinear_ops),
+	&BD718XX_HWOPNAME(bd718xx_buck_regulator_ops),
+	&BD718XX_HWOPNAME(bd718xx_pickable_range_ldo_ops),
+	&BD718XX_HWOPNAME(bd718xx_ldo_regulator_nolinear_ops),
+	&BD718XX_HWOPNAME(bd718xx_ldo_regulator_ops),
+	&BD718XX_HWOPNAME(bd718xx_ldo_regulator_ops),
+	&bd718xx_ldo5_ops_hwstate,
+	&BD718XX_HWOPNAME(bd718xx_ldo_regulator_ops),
+};
+
+static struct bd718xx_regulator_data bd71847_regulators[] = {
 	{
 		.desc = {
 			.name = "buck1",
 			.of_match = of_match_ptr("BUCK1"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK1,
-			.ops = &bd718xx_dvs_buck_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_DVS_BUCK_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_dvs_buck_volts,
@@ -585,7 +638,6 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 			.of_match = of_match_ptr("BUCK2"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK2,
-			.ops = &bd718xx_dvs_buck_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_DVS_BUCK_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_dvs_buck_volts,
@@ -616,7 +668,6 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 			.of_match = of_match_ptr("BUCK3"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK3,
-			.ops = &bd718xx_pickable_range_buck_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD71847_BUCK3_VOLTAGE_NUM,
 			.linear_ranges = bd71847_buck3_volts,
@@ -643,7 +694,6 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 			.of_match = of_match_ptr("BUCK4"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK4,
-			.ops = &bd718xx_pickable_range_buck_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD71847_BUCK4_VOLTAGE_NUM,
 			.linear_ranges = bd71847_buck4_volts,
@@ -670,7 +720,6 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 			.of_match = of_match_ptr("BUCK5"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK5,
-			.ops = &bd718xx_buck_regulator_nolinear_ops,
 			.type = REGULATOR_VOLTAGE,
 			.volt_table = &bd718xx_3rd_nodvs_buck_volts[0],
 			.n_voltages = ARRAY_SIZE(bd718xx_3rd_nodvs_buck_volts),
@@ -692,7 +741,6 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 			.of_match = of_match_ptr("BUCK6"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK6,
-			.ops = &bd718xx_buck_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_4TH_NODVS_BUCK_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_4th_nodvs_buck_volts,
@@ -716,7 +764,6 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 			.of_match = of_match_ptr("LDO1"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO1,
-			.ops = &bd718xx_pickable_range_ldo_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_LDO1_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_ldo1_volts,
@@ -742,7 +789,6 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 			.of_match = of_match_ptr("LDO2"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO2,
-			.ops = &bd718xx_ldo_regulator_nolinear_ops,
 			.type = REGULATOR_VOLTAGE,
 			.volt_table = &ldo_2_volts[0],
 			.vsel_reg = BD718XX_REG_LDO2_VOLT,
@@ -764,7 +810,6 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 			.of_match = of_match_ptr("LDO3"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO3,
-			.ops = &bd718xx_ldo_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_LDO3_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_ldo3_volts,
@@ -787,7 +832,6 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 			.of_match = of_match_ptr("LDO4"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO4,
-			.ops = &bd718xx_ldo_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_LDO4_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_ldo4_volts,
@@ -810,7 +854,6 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 			.of_match = of_match_ptr("LDO5"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO5,
-			.ops = &bd718xx_pickable_range_ldo_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD71847_LDO5_VOLTAGE_NUM,
 			.linear_ranges = bd71847_ldo5_volts,
@@ -836,7 +879,6 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 			.of_match = of_match_ptr("LDO6"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO6,
-			.ops = &bd718xx_ldo_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_LDO6_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_ldo6_volts,
@@ -857,14 +899,41 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 	},
 };
 
-static const struct bd718xx_regulator_data bd71837_regulators[] = {
+const struct regulator_ops *bd71837_swcontrol_ops[] = {
+	&bd718xx_dvs_buck_regulator_ops, &bd718xx_dvs_buck_regulator_ops,
+	&bd718xx_dvs_buck_regulator_ops, &bd718xx_dvs_buck_regulator_ops,
+	&bd71837_pickable_range_buck_ops, &bd71837_buck_regulator_ops,
+	&bd71837_buck_regulator_nolinear_ops, &bd71837_buck_regulator_ops,
+	&bd71837_pickable_range_ldo_ops, &bd71837_ldo_regulator_nolinear_ops,
+	&bd71837_ldo_regulator_ops, &bd71837_ldo_regulator_ops,
+	&bd71837_ldo_regulator_ops, &bd71837_ldo_regulator_ops,
+	&bd71837_ldo_regulator_ops,
+};
+
+const struct regulator_ops *bd71837_hwcontrol_ops[] = {
+	&BD718XX_HWOPNAME(bd718xx_dvs_buck_regulator_ops),
+	&BD718XX_HWOPNAME(bd718xx_dvs_buck_regulator_ops),
+	&bd71837_buck34_ops_hwctrl, &bd71837_buck34_ops_hwctrl,
+	&BD718XX_HWOPNAME(bd71837_pickable_range_buck_ops),
+	&BD718XX_HWOPNAME(bd71837_buck_regulator_ops),
+	&BD718XX_HWOPNAME(bd71837_buck_regulator_nolinear_ops),
+	&BD718XX_HWOPNAME(bd71837_buck_regulator_ops),
+	&BD718XX_HWOPNAME(bd71837_pickable_range_ldo_ops),
+	&BD718XX_HWOPNAME(bd71837_ldo_regulator_nolinear_ops),
+	&BD718XX_HWOPNAME(bd71837_ldo_regulator_ops),
+	&BD718XX_HWOPNAME(bd71837_ldo_regulator_ops),
+	&BD718XX_HWOPNAME(bd71837_ldo_regulator_ops),
+	&BD718XX_HWOPNAME(bd71837_ldo_regulator_ops),
+	&BD718XX_HWOPNAME(bd71837_ldo_regulator_ops),
+};
+
+static struct bd718xx_regulator_data bd71837_regulators[] = {
 	{
 		.desc = {
 			.name = "buck1",
 			.of_match = of_match_ptr("BUCK1"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK1,
-			.ops = &bd718xx_dvs_buck_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_DVS_BUCK_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_dvs_buck_volts,
@@ -898,7 +967,6 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("BUCK2"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK2,
-			.ops = &bd718xx_dvs_buck_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_DVS_BUCK_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_dvs_buck_volts,
@@ -929,7 +997,6 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("BUCK3"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK3,
-			.ops = &bd718xx_dvs_buck_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_DVS_BUCK_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_dvs_buck_volts,
@@ -958,7 +1025,6 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("BUCK4"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK4,
-			.ops = &bd718xx_dvs_buck_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_DVS_BUCK_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_dvs_buck_volts,
@@ -987,7 +1053,6 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("BUCK5"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK5,
-			.ops = &bd71837_pickable_range_buck_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD71837_BUCK5_VOLTAGE_NUM,
 			.linear_ranges = bd71837_buck5_volts,
@@ -1014,7 +1079,6 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("BUCK6"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK6,
-			.ops = &bd71837_buck_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD71837_BUCK6_VOLTAGE_NUM,
 			.linear_ranges = bd71837_buck6_volts,
@@ -1038,7 +1102,6 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("BUCK7"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK7,
-			.ops = &bd71837_buck_regulator_nolinear_ops,
 			.type = REGULATOR_VOLTAGE,
 			.volt_table = &bd718xx_3rd_nodvs_buck_volts[0],
 			.n_voltages = ARRAY_SIZE(bd718xx_3rd_nodvs_buck_volts),
@@ -1060,7 +1123,6 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("BUCK8"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK8,
-			.ops = &bd71837_buck_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_4TH_NODVS_BUCK_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_4th_nodvs_buck_volts,
@@ -1084,7 +1146,6 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("LDO1"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO1,
-			.ops = &bd71837_pickable_range_ldo_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_LDO1_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_ldo1_volts,
@@ -1110,7 +1171,6 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("LDO2"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO2,
-			.ops = &bd71837_ldo_regulator_nolinear_ops,
 			.type = REGULATOR_VOLTAGE,
 			.volt_table = &ldo_2_volts[0],
 			.vsel_reg = BD718XX_REG_LDO2_VOLT,
@@ -1132,7 +1192,6 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("LDO3"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO3,
-			.ops = &bd71837_ldo_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_LDO3_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_ldo3_volts,
@@ -1155,7 +1214,6 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("LDO4"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO4,
-			.ops = &bd71837_ldo_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_LDO4_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_ldo4_volts,
@@ -1178,7 +1236,6 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("LDO5"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO5,
-			.ops = &bd71837_ldo_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD71837_LDO5_VOLTAGE_NUM,
 			.linear_ranges = bd71837_ldo5_volts,
@@ -1205,7 +1262,6 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("LDO6"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO6,
-			.ops = &bd71837_ldo_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_LDO6_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_ldo6_volts,
@@ -1232,7 +1288,6 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("LDO7"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_LDO7,
-			.ops = &bd71837_ldo_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD71837_LDO7_VOLTAGE_NUM,
 			.linear_ranges = bd71837_ldo7_volts,
@@ -1251,15 +1306,57 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 	},
 };
 
+static void mark_hw_controlled(struct device *dev, struct device_node *np,
+			       struct bd718xx_regulator_data *reg_data,
+			       unsigned int num_reg_data, int *info)
+{
+	int i;
+
+	for (i = 1; i <= num_reg_data; i++) {
+		if (!of_node_name_eq(np, reg_data[i-1].desc.of_match))
+			continue;
+
+		*info |= 1 << (i - 1);
+		dev_dbg(dev, "regulator %d runlevel controlled\n", i);
+		return;
+	}
+	dev_warn(dev, "Bad regulator node\n");
+}
+
+static int get_hw_controlled_regulators(struct device *dev,
+					struct bd718xx_regulator_data *reg_data,
+					unsigned int num_reg_data, int *info)
+{
+	struct device_node *np;
+	struct device_node *nproot = dev->of_node;
+	const char *prop = "rohm,no-regulator-enable-control";
+
+	*info = 0;
+
+	nproot = of_get_child_by_name(nproot, "regulators");
+	if (!nproot) {
+		dev_err(dev, "failed to find regulators node\n");
+		return -ENODEV;
+	}
+	for_each_child_of_node(nproot, np)
+		if (of_property_read_bool(np, prop))
+			mark_hw_controlled(dev, np, reg_data, num_reg_data,
+					   info);
+
+	of_node_put(nproot);
+	return 0;
+}
+
 static int bd718xx_probe(struct platform_device *pdev)
 {
 	struct bd718xx *mfd;
 	struct regulator_config config = { 0 };
-	int i, j, err;
+	int i, j, err, omit_enable;
 	bool use_snvs;
-	const struct bd718xx_regulator_data *reg_data;
+	struct bd718xx_regulator_data *reg_data;
 	unsigned int num_reg_data;
 	enum rohm_chip_type chip = platform_get_device_id(pdev)->driver_data;
+	const struct regulator_ops **swops, **hwops;
 
 	mfd = dev_get_drvdata(pdev->dev.parent);
 	if (!mfd) {
@@ -1272,10 +1369,14 @@ static int bd718xx_probe(struct platform_device *pdev)
 	case ROHM_CHIP_TYPE_BD71837:
 		reg_data = bd71837_regulators;
 		num_reg_data = ARRAY_SIZE(bd71837_regulators);
+		swops = &bd71837_swcontrol_ops[0];
+		hwops = &bd71837_hwcontrol_ops[0];
 		break;
 	case ROHM_CHIP_TYPE_BD71847:
 		reg_data = bd71847_regulators;
 		num_reg_data = ARRAY_SIZE(bd71847_regulators);
+		swops = &bd71847_swcontrol_ops[0];
+		hwops = &bd71847_hwcontrol_ops[0];
 		break;
 	default:
 		dev_err(&pdev->dev, "Unsupported chip type\n");
@@ -1321,16 +1422,33 @@ static int bd718xx_probe(struct platform_device *pdev)
 
 	config.dev = pdev->dev.parent;
 	config.regmap = mfd->chip.regmap;
+	/*
+	 * There are cases when we want to leave the enable-control for
+	 * the HW state machine and use this driver only for voltage control.
+	 * One special case is when we use PMIC_STBY_REQ line from SoC to PMIC
+	 * in order to set the system to SUSPEND state.
+	 *
+	 * If regulator is taken under SW control the regulator state will not
+	 * be affected by PMIC state machine - Eg. regulator is likely to stay
+	 * on even in SUSPEND
+	 */
+	get_hw_controlled_regulators(pdev->dev.parent, reg_data, num_reg_data,
+				     &omit_enable);
 
 	for (i = 0; i < num_reg_data; i++) {
 
-		const struct regulator_desc *desc;
+		struct regulator_desc *desc;
 		struct regulator_dev *rdev;
-		const struct bd718xx_regulator_data *r;
+		struct bd718xx_regulator_data *r;
+		int no_enable_control = omit_enable & (1 << i);
 
 		r = &reg_data[i];
 		desc = &r->desc;
 
+		if (no_enable_control)
+			desc->ops = hwops[i];
+		else
+			desc->ops = swops[i];
 
 		rdev = devm_regulator_register(&pdev->dev, desc, &config);
 		if (IS_ERR(rdev)) {
@@ -1357,8 +1475,9 @@ static int bd718xx_probe(struct platform_device *pdev)
 		 * enable SW control for crucial regulators if snvs state is
 		 * used
 		 */
-		if (!use_snvs || !rdev->constraints->always_on ||
-		    !rdev->constraints->boot_on) {
+		if (!no_enable_control && (!use_snvs ||
+		    !rdev->constraints->always_on ||
+		    !rdev->constraints->boot_on)) {
 			err = regmap_update_bits(mfd->chip.regmap, r->init.reg,
 						 r->init.mask, r->init.val);
 			if (err) {
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
