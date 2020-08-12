Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF3DC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4399E207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597247870;
	bh=7E5ppFauk/pcJwqzL6iFg+zOH5/hrnb16rE6Hs92m2c=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=KYRD8KTXR3UIBPgFKDEx7TaTHmOeMEs28eZ7EzjDKPoZCN9ftfPRDSc7dZu8PG69K
	 GUtSaaDd3DCU/n/GPjDxXT4QKh83/792raO9NfTL65voBaQj+IMbNmeJgKOnjswnHz
	 nWMQUxBbuom5ulZwzvNDPa9ucMRfBuH47ZNR+108=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgHLP5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:57:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgHLP5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:05 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A93523105;
        Wed, 12 Aug 2020 15:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247821;
        bh=7E5ppFauk/pcJwqzL6iFg+zOH5/hrnb16rE6Hs92m2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYQt1yGHmpZilccEBw2AzGEwSFBKmjnK5H3NI8pxQT0ArgBBQ55T/XkQm8ID/vRQC
         M5xomb28I2noJ9KnlenoCVuJTYP1iqeHMaeuKOPAh0ng1DICJ3YXDNGJjePwVscoer
         pukhGq45EodUAmVaEOGYKJ+IC2ZGMPGKCYYul7C4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7b-005t7R-Cc; Wed, 12 Aug 2020 17:56:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH 40/44] staging: regulator: hi6421v600-regulator: code cleanup
Date:   Wed, 12 Aug 2020 17:56:50 +0200
Message-Id: <5126904942bedf04ddf3c7fb675226e235109b85.1597247164.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do some code cleanup in order to make it cleaner for moving
it out of staging in the future.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../staging/hikey9xx/hi6421v600-regulator.c   | 74 ++++++++-----------
 1 file changed, 30 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index c80dfac1e4c3..29ef6bcadd84 100644
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

