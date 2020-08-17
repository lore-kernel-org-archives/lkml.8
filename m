Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B994BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F572072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597648383;
	bh=eROR1DPjPL2KofMZwQrTAD/ruHZPtMAu1xbkY55t+cY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lJTRYrZjRd16Ylj+Huie4P5/c6vaIThuPGUQhM8MftEpCOpbkMQb3gaONYOVdIgQi
	 VuL1CbYtOgyS33PzL3KMaqnPxkshPq/4tWViB+Tj1+WVOD76gTna2yyOmMmJuWYlT0
	 h+FtsLVXclfg/P3GBoLtuG8twlJ2yZuWcP5Ol5T4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgHQHNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:13:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgHQHLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:11:42 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64C6A22DA9;
        Mon, 17 Aug 2020 07:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597648278;
        bh=eROR1DPjPL2KofMZwQrTAD/ruHZPtMAu1xbkY55t+cY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MNMJkJ0jnXCGpCN79AHLtH7r2meSEJlCo3nYSgUHBsqdRw5FviF4uSGCW72WY+obz
         nwqAR8NNpmWz7C+WGLHtl/0MPWIUrt6gyjhqA9uZV7uMaV/56UYQeCTYt42sVSNjeg
         XsvSwW1iRjzSy0BR+3WhTFmgYjDlR5/gCosaJDm0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZIa-00Bdl6-JN; Mon, 17 Aug 2020 09:11:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v3 40/44] staging: regulator: hi6421v600-regulator: code cleanup
Date:   Mon, 17 Aug 2020 09:10:59 +0200
Message-Id: <32fadb359c1817992af78052e2d9448b8c5fc61f.1597647359.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597647359.git.mchehab+huawei@kernel.org>
References: <cover.1597647359.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do some code cleanup in order to make it cleaner for moving
it out of staging in the future.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../staging/hikey9xx/hi6421v600-regulator.c   | 80 ++++++++-----------
 1 file changed, 33 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index c80dfac1e4c3..82635ff54a74 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
@@ -15,29 +15,28 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
  */
 
-#include <linux/slab.h>
+#include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/module.h>
 #include <linux/err.h>
 #include <linux/io.h>
-#include <linux/platform_device.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mfd/hi6421-spmi-pmic.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
-#include <linux/mfd/hi6421-spmi-pmic.h>
-#include <linux/delay.h>
-#include <linux/time.h>
-#include <linux/version.h>
 #include <linux/seq_file.h>
-#include <linux/uaccess.h>
+#include <linux/slab.h>
 #include <linux/spmi.h>
+#include <linux/time.h>
+#include <linux/uaccess.h>
+#include <linux/version.h>
 
 #define rdev_dbg(rdev, fmt, arg...)	\
 		 pr_debug("%s: %s: " fmt, (rdev)->desc->name, __func__, ##arg)
@@ -50,15 +49,16 @@ struct hi6421v600_regulator {
 
 static DEFINE_MUTEX(enable_mutex);
 
-/* helper function to ensure when it returns it is at least 'delay_us'
+/*
+ * helper function to ensure when it returns it is at least 'delay_us'
  * microseconds after 'since'.
  */
 
 static int hi6421_spmi_regulator_is_enabled(struct regulator_dev *rdev)
 {
-	u32 reg_val;
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
+	u32 reg_val;
 
 	reg_val = hi6421_spmi_pmic_read(pmic, rdev->desc->enable_reg);
 
@@ -136,7 +136,6 @@ static int hi6421_spmi_regulator_set_voltage_sel(struct regulator_dev *rdev,
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 	u32 reg_val;
 
-	/* unlikely to happen. sanity test done by regulator core */
 	if (unlikely(selector >= rdev->desc->n_voltages))
 		return -EINVAL;
 
@@ -158,8 +157,8 @@ static unsigned int hi6421_spmi_regulator_get_mode(struct regulator_dev *rdev)
 {
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
-	u32 reg_val;
 	unsigned int mode;
+	u32 reg_val;
 
 	reg_val = hi6421_spmi_pmic_read(pmic, rdev->desc->enable_reg);
 
@@ -211,13 +210,10 @@ hi6421_spmi_regulator_get_optimum_mode(struct regulator_dev *rdev,
 {
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
 
-	if (load_uA || ((unsigned int)load_uA > sreg->eco_uA)) {
-		rdev_dbg(rdev, "normal mode");
+	if (load_uA || ((unsigned int)load_uA > sreg->eco_uA))
 		return REGULATOR_MODE_NORMAL;
-	} else {
-		rdev_dbg(rdev, "idle mode");
-		return REGULATOR_MODE_IDLE;
-	}
+
+	return REGULATOR_MODE_IDLE;
 }
 
 static int hi6421_spmi_dt_parse(struct platform_device *pdev,
@@ -231,7 +227,7 @@ static int hi6421_spmi_dt_parse(struct platform_device *pdev,
 
 	ret = of_property_read_u32(np, "reg", &rdesc->enable_reg);
 	if (ret) {
-		dev_err(dev, "missing reg property\nn");
+		dev_err(dev, "missing reg property\n");
 		return ret;
 	}
 
@@ -256,8 +252,7 @@ static int hi6421_spmi_dt_parse(struct platform_device *pdev,
 		sreg->eco_mode_mask = 0;
 		sreg->eco_uA = 0;
 	} else {
-		ret = of_property_read_u32(np, "eco-microamp",
-					   &sreg->eco_uA);
+		ret = of_property_read_u32(np, "eco-microamp", &sreg->eco_uA);
 		if (ret) {
 			dev_err(dev, "missing eco-microamp property\n");
 			return ret;
@@ -308,13 +303,13 @@ static int hi6421_spmi_dt_parse(struct platform_device *pdev,
 	 */
 	rdesc->vsel_mask = (1 << (fls(rdesc->n_voltages) - 1)) - 1;
 
-	dev_dbg(dev, "voltage selector settings: reg: 0x%x, mask: 0x%x",
+	dev_dbg(dev, "voltage selector settings: reg: 0x%x, mask: 0x%x\n",
 		rdesc->vsel_reg, rdesc->vsel_mask);
 
 	return 0;
 }
 
-static struct regulator_ops hi6421_spmi_ldo_rops = {
+static const struct regulator_ops hi6421_spmi_ldo_rops = {
 	.is_enabled = hi6421_spmi_regulator_is_enabled,
 	.enable = hi6421_spmi_regulator_enable,
 	.disable = hi6421_spmi_regulator_disable,
@@ -327,23 +322,19 @@ static struct regulator_ops hi6421_spmi_ldo_rops = {
 	.get_optimum_mode = hi6421_spmi_regulator_get_optimum_mode,
 };
 
-/*
- * Used only for parsing the DT properties
- */
-
 static int hi6421_spmi_regulator_probe_ldo(struct platform_device *pdev,
 					   struct device_node *np,
 					   struct hi6421_spmi_pmic *pmic)
 {
-	struct device *dev = &pdev->dev;
-	struct regulator_desc *rdesc;
-	struct regulator_dev *rdev;
-	struct hi6421v600_regulator *sreg = NULL;
+	struct regulation_constraints *constraint;
 	struct regulator_init_data *initdata;
 	struct regulator_config config = { };
-	struct regulation_constraints *constraint;
-	const char *supplyname = NULL;
-	int ret = 0;
+	struct hi6421v600_regulator *sreg;
+	struct device *dev = &pdev->dev;
+	struct regulator_desc *rdesc;
+	struct regulator_dev *rdev;
+	const char *supplyname;
+	int ret;
 
 	initdata = of_get_regulator_init_data(dev, np, NULL);
 	if (!initdata) {
@@ -351,7 +342,7 @@ static int hi6421_spmi_regulator_probe_ldo(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	sreg = kzalloc(sizeof(*sreg), GFP_KERNEL);
+	sreg = devm_kzalloc(dev, sizeof(*sreg), GFP_KERNEL);
 	if (!sreg)
 		return -ENOMEM;
 
@@ -370,7 +361,7 @@ static int hi6421_spmi_regulator_probe_ldo(struct platform_device *pdev,
 	/* parse device tree data for regulator specific */
 	ret = hi6421_spmi_dt_parse(pdev, sreg, rdesc);
 	if (ret)
-		goto probe_end;
+		return ret;
 
 	/* hisi regulator supports two modes */
 	constraint = &initdata->constraints;
@@ -391,18 +382,15 @@ static int hi6421_spmi_regulator_probe_ldo(struct platform_device *pdev,
 	if (IS_ERR(rdev)) {
 		dev_err(dev, "failed to register %s\n",
 			rdesc->name);
-		ret = PTR_ERR(rdev);
-		goto probe_end;
+		return PTR_ERR(rdev);
 	}
 
 	rdev_dbg(rdev, "valid_modes_mask: 0x%x, valid_ops_mask: 0x%x\n",
 		 constraint->valid_modes_mask, constraint->valid_ops_mask);
 
 	dev_set_drvdata(dev, rdev);
-probe_end:
-	if (ret)
-		kfree(sreg);
-	return ret;
+
+	return 0;
 }
 
 static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
@@ -414,7 +402,6 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
 	struct hi6421_spmi_pmic *pmic;
 	int ret;
 
-	dev_dbg(&pdev->dev, "probing hi6421v600 regulator\n");
 	/*
 	 * This driver is meant to be called by hi6421-spmi-core,
 	 * which should first set drvdata. If this doesn't happen, hit
@@ -463,7 +450,6 @@ static int hi6421_spmi_regulator_remove(struct platform_device *pdev)
 
 	regulator_unregister(rdev);
 
-	/* TODO: should i worry about that? devm_kzalloc */
 	if (rdev->desc->volt_table)
 		devm_kfree(&pdev->dev, (unsigned int *)rdev->desc->volt_table);
 
-- 
2.26.2

