Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D21C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB7A206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgD1JaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:30:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34734 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbgD1JaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:30:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id f11so16120010ljp.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 02:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RMKJe0vs45K008KktXNlTIscxQGnUeyd6oU1z9Nrkq8=;
        b=E/3ht2aOo38atSlGEg/jnwcos70B7FeUpZXDM8GscD0LfbC8wBKkXnOMeWmKMoElkG
         ULz3CXqW6cUNr4xa2spm4cXhyBhHtZeOh85HkcaKcGcBM6LJjAvDcFaYEdtsiXf1mVqJ
         8zThbuWGg/cAjcrMHc5D9r7r8Iilsho4SHlbBvK0FISW+aOWHYxDxFFzFU0uOpEUCehM
         hKuGXXTeTNqyxvS3+dQ12IDmoDlZ2ViEua5xfOtrInsPDF1vUt+usG5wNkiaYxS3M0YM
         HNKH6J1rXm3I+W1FHVq5b+g5JQNFgBCXv6OC8s0LNdgq50pNv8fAkUL0vgIvLOBv0Ovx
         GlHA==
X-Gm-Message-State: AGi0PuZqEHEsst1CfUdk0MV0eXDlll+oT4abuyv/rZ45KtqZFAtt/X75
        nlUAgonn7ZjfBzBklYUERrA=
X-Google-Smtp-Source: APiQypJgH2H5jGUZgLdFAQxJN4fxDgJFb9Ey2aVIzUqMqjLmn4mRdJKnJ1VFLthG/ojOQ0e+wWN1Bw==
X-Received: by 2002:a2e:a365:: with SMTP id i5mr15617409ljn.293.1588066209143;
        Tue, 28 Apr 2020 02:30:09 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id i3sm12391412ljg.82.2020.04.28.02.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 02:30:07 -0700 (PDT)
Date:   Tue, 28 Apr 2020 12:29:30 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: bd718x7: remove voltage change restriction from
 BD71847
Message-ID: <20200428092930.GA9721@localhost.localdomain>
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
BD71850. Remove voltage change restrictions from other PMICs but
BD71837.

The LDO voltage changing is still restricted. I did not yet receive
answer whether there is voltage spikes to be expected for LDOs. I
only know that the power-good detection for LDOs can cause false
alarms if LDO voltage is changed when LDO is enabled. We might be
able to work-around this by disabling the power-good monioring for
the duration of the LDO voltage change - but as I said, I don't
know yet. Let's fix it later if we can confirm that also LDO voltage
changes are safe.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/bd718x7-regulator.c | 46 ++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index cf3872837abc..f901eee9492d 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -55,10 +55,15 @@ static int bd718xx_buck1234_set_ramp_delay(struct regulator_dev *rdev,
 				  BUCK_RAMPRATE_MASK, ramp_value << 6);
 }
 
-/* Bucks 1 to 4 support DVS. PWM mode is used when voltage is changed.
+/*
+ * On BD71837 (not on BD71847, BD71850, ...)
+ * Bucks 1 to 4 support DVS. PWM mode is used when voltage is changed.
  * Bucks 5 to 8 and LDOs can use PFM and must be disabled when voltage
  * is changed. Hence we return -EBUSY for these if voltage is changed
  * when BUCK/LDO is enabled.
+ *
+ * The LDO operation for BD71847 and BD71850 is icurrently unknown.
+ * It's safer to still assume they can't be changed when enabled.
  */
 static int bd718xx_set_voltage_sel_restricted(struct regulator_dev *rdev,
 						    unsigned int sel)
@@ -88,6 +93,16 @@ static const struct regulator_ops bd718xx_pickable_range_ldo_ops = {
 };
 
 static const struct regulator_ops bd718xx_pickable_range_buck_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_pickable_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_pickable_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+};
+
+static const struct regulator_ops bd71837_pickable_range_buck_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -116,6 +131,16 @@ static const struct regulator_ops bd718xx_ldo_regulator_nolinear_ops = {
 };
 
 static const struct regulator_ops bd718xx_buck_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+};
+
+static const struct regulator_ops bd71837_buck_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -126,6 +151,17 @@ static const struct regulator_ops bd718xx_buck_regulator_ops = {
 };
 
 static const struct regulator_ops bd718xx_buck_regulator_nolinear_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_ascend,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+};
+
+static const struct regulator_ops bd71837_buck_regulator_nolinear_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -805,7 +841,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("BUCK5"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK5,
-			.ops = &bd718xx_pickable_range_buck_ops,
+			.ops = &bd71837_pickable_range_buck_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD71837_BUCK5_VOLTAGE_NUM,
 			.linear_ranges = bd71837_buck5_volts,
@@ -832,7 +868,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("BUCK6"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK6,
-			.ops = &bd718xx_buck_regulator_ops,
+			.ops = &bd71837_buck_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD71837_BUCK6_VOLTAGE_NUM,
 			.linear_ranges = bd71837_buck6_volts,
@@ -856,7 +892,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("BUCK7"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK7,
-			.ops = &bd718xx_buck_regulator_nolinear_ops,
+			.ops = &bd71837_buck_regulator_nolinear_ops,
 			.type = REGULATOR_VOLTAGE,
 			.volt_table = &bd718xx_3rd_nodvs_buck_volts[0],
 			.n_voltages = ARRAY_SIZE(bd718xx_3rd_nodvs_buck_volts),
@@ -878,7 +914,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.of_match = of_match_ptr("BUCK8"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = BD718XX_BUCK8,
-			.ops = &bd718xx_buck_regulator_ops,
+			.ops = &bd71837_buck_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
 			.n_voltages = BD718XX_4TH_NODVS_BUCK_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_4th_nodvs_buck_volts,
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
