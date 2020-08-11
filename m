Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6159AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E8872076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597160546;
	bh=vrO2mlrEnLJbtCe9AzG2p8KO2SOBwmQ4/eF/NzpDia8=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=bkahqjU20hSVSH8hyLFTo+oYpjQBvVq4JUU0+iZxFytP7k/fG0Udu/93Xfk9+ulO/
	 6gIcBf7gSV+titYWAvNDFzi35eTfD70jRYjbBG32G9Z71rvKxd1vLIDLqFy3e8YxkN
	 xuTRWDMKXha5WUPsJe5MyqfSsc6vkgKiETzXNWPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgHKPmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729042AbgHKPmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:42:11 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01A7720885;
        Tue, 11 Aug 2020 15:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160529;
        bh=vrO2mlrEnLJbtCe9AzG2p8KO2SOBwmQ4/eF/NzpDia8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zQ+63HSBU0VC4hjKaRXwhMAVR426hserFdaHUvh51Mtm2ke7/+HJ7yLB/dHauk+an
         jHkJzUtzoRHeCmf+lKk2stuUF3XnEiYSEuMIwq0oh0w8o7oR3RXTjIAYADcL9i3dUc
         lWPLUDmOaXWeQgpdA3BiOX3TudWgVDLRHDsXxb2E=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5WPZ-004bmz-Qp; Tue, 11 Aug 2020 17:42:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 17/33] mfd: pmic: add drivers for hi6421v600
Date:   Tue, 11 Aug 2020 17:41:43 +0200
Message-Id: <2b838df2029fc7f555e77df31c0a434649a2e77f.1597160086.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597160086.git.mchehab+huawei@kernel.org>
References: <cover.1597160086.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the code to better match other upstream drivers,
and change the binding logic to ensure that the PMIC SPMI
driver will run before the regulator code.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/mfd/Kconfig                           |  15 ++
 drivers/mfd/Makefile                          |   1 +
 .../{hisi_pmic_spmi.c => hi6421-spmi-pmic.c}  |  84 +++-----
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 ...egulator_spmi.c => hi6421v600-regulator.c} | 186 +++++++++---------
 .../mfd/{hisi_pmic.h => hi6421-spmi-pmic.h}   |   0
 7 files changed, 145 insertions(+), 150 deletions(-)
 rename drivers/mfd/{hisi_pmic_spmi.c => hi6421-spmi-pmic.c} (91%)
 rename drivers/regulator/{hisi_regulator_spmi.c => hi6421v600-regulator.c} (80%)
 rename include/linux/mfd/{hisi_pmic.h => hi6421-spmi-pmic.h} (100%)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index e42d11849947..04c249649532 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -497,6 +497,21 @@ config MFD_HI6421_PMIC
 	  menus in order to enable them.
 	  We communicate with the Hi6421 via memory-mapped I/O.
 
+config MFD_HI6421_SPMI
+	tristate "HiSilicon Hi6421v600 SPMI PMU/Codec IC"
+	depends on OF
+	select MFD_CORE
+	select REGMAP_MMIO
+	help
+	  Add support for HiSilicon Hi6421v600 SPMI PMIC. Hi6421 includes
+	  multi-functions, such as regulators, RTC, codec, Coulomb counter,
+	  etc.
+
+	  This driver includes core APIs _only_. You have to select
+	  individual components like voltage regulators under corresponding
+	  menus in order to enable them.
+	  We communicate with the Hi6421v600 via a SPMI bus.
+
 config MFD_HI655X_PMIC
 	tristate "HiSilicon Hi655X series PMU/Codec IC"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 9367a92f795a..2ac0727dafc9 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -233,6 +233,7 @@ obj-$(CONFIG_MFD_IPAQ_MICRO)	+= ipaq-micro.o
 obj-$(CONFIG_MFD_IQS62X)	+= iqs62x.o
 obj-$(CONFIG_MFD_MENF21BMC)	+= menf21bmc.o
 obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
+obj-$(CONFIG_MFD_HI6421_SPMI)	+= hi6421-spmi-pmic.o
 obj-$(CONFIG_MFD_HI655X_PMIC)   += hi655x-pmic.o
 obj-$(CONFIG_MFD_DLN2)		+= dln2.o
 obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
diff --git a/drivers/mfd/hisi_pmic_spmi.c b/drivers/mfd/hi6421-spmi-pmic.c
similarity index 91%
rename from drivers/mfd/hisi_pmic_spmi.c
rename to drivers/mfd/hi6421-spmi-pmic.c
index be42fed16bd2..939f7bd5d8ba 100644
--- a/drivers/mfd/hisi_pmic_spmi.c
+++ b/drivers/mfd/hi6421-spmi-pmic.c
@@ -24,13 +24,14 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/mfd/core.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/of_irq.h>
-#include <linux/mfd/hisi_pmic.h>
+#include <linux/mfd/hi6421-spmi-pmic.h>
 #include <linux/irq.h>
 #include <linux/spmi.h>
 #ifndef NO_IRQ
@@ -53,11 +54,8 @@
 /*define the first group interrupt register number*/
 #define HISI_PMIC_FIRST_GROUP_INT_NUM        2
 
-static const struct of_device_id of_hisi_pmic_match_tbl[] = {
-	{
-		.compatible = "hisilicon-hisi-pmic-spmi",
-	},
-	{ /* end */ }
+static const struct mfd_cell hi6421v600_devs[] = {
+	{ .name = "hi6421v600-regulator", },
 };
 
 /*
@@ -477,6 +475,22 @@ static int hisi_pmic_probe(struct spmi_device *pdev)
 		goto request_theaded_irq;
 	}
 
+	dev_set_drvdata(&pdev->dev, pmic);
+
+	/*
+	 * The logic below will rely that the pmic is already stored at
+	 * drvdata.
+	 */
+	dev_dbg(&pdev->dev, "SPMI-PMIC: adding childs for %pOF\n",
+		pdev->dev.of_node);
+	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
+				   hi6421v600_devs, ARRAY_SIZE(hi6421v600_devs),
+				   NULL, 0, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to add child devices: %d\n", ret);
+		return ret;
+	}
+
 after_irq_register:
 	return 0;
 
@@ -497,61 +511,21 @@ static void hisi_pmic_remove(struct spmi_device *pdev)
 	devm_kfree(&pdev->dev, pmic);
 }
 
-static int hisi_pmic_suspend(struct device *dev, pm_message_t state)
-{
-	struct hisi_pmic *pmic = dev_get_drvdata(dev);
+static const struct of_device_id pmic_spmi_id_table[] = {
+	{ .compatible = "hisilicon,hi6421-spmi-pmic" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pmic_spmi_id_table);
 
-	if (!pmic) {
-		pr_err("%s:pmic is NULL\n", __func__);
-		return -ENOMEM;
-	}
-
-	pr_info("%s:+\n", __func__);
-	pr_info("%s:-\n", __func__);
-
-	return 0;
-}
-
-static int hisi_pmic_resume(struct device *dev)
-{
-	struct hisi_pmic *pmic = dev_get_drvdata(dev);
-
-	if (!pmic) {
-		pr_err("%s:pmic is NULL\n", __func__);
-		return -ENOMEM;
-	}
-
-	pr_info("%s:+\n", __func__);
-	pr_info("%s:-\n", __func__);
-
-	return 0;
-}
-
-MODULE_DEVICE_TABLE(spmi, pmic_spmi_id);
 static struct spmi_driver hisi_pmic_driver = {
 	.driver = {
-		.name	= "hisi_pmic",
-		.owner  = THIS_MODULE,
-		.of_match_table = of_hisi_pmic_match_tbl,
-		.suspend = hisi_pmic_suspend,
-		.resume = hisi_pmic_resume,
+		.name	= "hi6421-spmi-pmic",
+		.of_match_table = pmic_spmi_id_table,
 	},
 	.probe	= hisi_pmic_probe,
 	.remove	= hisi_pmic_remove,
 };
+module_spmi_driver(hisi_pmic_driver);
 
-static int __init hisi_pmic_init(void)
-{
-	return spmi_driver_register(&hisi_pmic_driver);
-}
-
-static void __exit hisi_pmic_exit(void)
-{
-	spmi_driver_unregister(&hisi_pmic_driver);
-}
-
-subsys_initcall_sync(hisi_pmic_init);
-module_exit(hisi_pmic_exit);
-
-MODULE_DESCRIPTION("PMIC driver");
+MODULE_DESCRIPTION("HiSilicon Hi6421v600 SPMI PMIC driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index edb1c4f8b496..de8a78487bb9 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -356,6 +356,14 @@ config REGULATOR_HI6421V530
 	  provides 5 general purpose LDOs, and all of them come with support
 	  to either ECO (idle) or sleep mode.
 
+config REGULATOR_HI6421V600
+	tristate "HiSilicon Hi6421v600 PMIC voltage regulator support"
+	depends on MFD_HI6421_PMIC && OF
+	help
+	  This driver provides support for the voltage regulators on
+	  HiSilicon Hi6421v600 PMU / Codec IC.
+	  This is used on Kirin 3670 boards, like HiKey 970.
+
 config REGULATOR_HI655X
 	tristate "Hisilicon HI655X PMIC regulators support"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 0796e4a47afa..f59d5e3b5fd4 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_REGULATOR_FAN53555) += fan53555.o
 obj-$(CONFIG_REGULATOR_GPIO) += gpio-regulator.o
 obj-$(CONFIG_REGULATOR_HI6421) += hi6421-regulator.o
 obj-$(CONFIG_REGULATOR_HI6421V530) += hi6421v530-regulator.o
+obj-$(CONFIG_REGULATOR_HI6421V600) += hi6421v600-regulator.o
 obj-$(CONFIG_REGULATOR_HI655X) += hi655x-regulator.o
 obj-$(CONFIG_REGULATOR_ISL6271A) += isl6271a-regulator.o
 obj-$(CONFIG_REGULATOR_ISL9305) += isl9305.o
diff --git a/drivers/regulator/hisi_regulator_spmi.c b/drivers/regulator/hi6421v600-regulator.c
similarity index 80%
rename from drivers/regulator/hisi_regulator_spmi.c
rename to drivers/regulator/hi6421v600-regulator.c
index 5f6e4ba4b99e..9aaafcbb1a36 100644
--- a/drivers/regulator/hisi_regulator_spmi.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -31,7 +31,7 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
-#include <linux/mfd/hisi_pmic.h>
+#include <linux/mfd/hi6421-spmi-pmic.h>
 #include <linux/delay.h>
 #include <linux/time.h>
 #include <linux/version.h>
@@ -53,20 +53,11 @@ struct hisi_regulator {
 	u32 off_on_delay;
 	u32 eco_uA;
 	struct regulator_desc rdesc;
-	int (*dt_parse)(struct hisi_regulator *reg, struct spmi_device *spmi);
+	struct hisi_pmic *pmic;
 };
 
 static DEFINE_MUTEX(enable_mutex);
 
-static inline struct hisi_pmic *rdev_to_pmic(struct regulator_dev *dev)
-{
-	/* regulator_dev parent to->
-	 * hisi regulator platform device_dev parent to->
-	 * hisi pmic platform device_dev
-	 */
-	return dev_get_drvdata(rdev_get_dev(dev)->parent->parent);
-}
-
 /* helper function to ensure when it returns it is at least 'delay_us'
  * microseconds after 'since'.
  */
@@ -75,7 +66,7 @@ static int hisi_regulator_is_enabled(struct regulator_dev *dev)
 {
 	u32 reg_val;
 	struct hisi_regulator *sreg = rdev_get_drvdata(dev);
-	struct hisi_pmic *pmic = rdev_to_pmic(dev);
+	struct hisi_pmic *pmic = sreg->pmic;
 
 	reg_val = hisi_pmic_read(pmic, sreg->register_info.ctrl_reg);
 	pr_debug("<[%s]: ctrl_reg=0x%x,enable_state=%d>\n",
@@ -88,7 +79,7 @@ static int hisi_regulator_is_enabled(struct regulator_dev *dev)
 static int hisi_regulator_enable(struct regulator_dev *dev)
 {
 	struct hisi_regulator *sreg = rdev_get_drvdata(dev);
-	struct hisi_pmic *pmic = rdev_to_pmic(dev);
+	struct hisi_pmic *pmic = sreg->pmic;
 
 	/* keep a distance of off_on_delay from last time disabled */
 	usleep_range(sreg->off_on_delay, sreg->off_on_delay + 1000);
@@ -116,7 +107,7 @@ static int hisi_regulator_enable(struct regulator_dev *dev)
 static int hisi_regulator_disable(struct regulator_dev *dev)
 {
 	struct hisi_regulator *sreg = rdev_get_drvdata(dev);
-	struct hisi_pmic *pmic = rdev_to_pmic(dev);
+	struct hisi_pmic *pmic = sreg->pmic;
 
 	/* set enable register to 0 */
 	hisi_pmic_rmw(pmic, sreg->register_info.ctrl_reg,
@@ -128,7 +119,7 @@ static int hisi_regulator_disable(struct regulator_dev *dev)
 static int hisi_regulator_get_voltage(struct regulator_dev *dev)
 {
 	struct hisi_regulator *sreg = rdev_get_drvdata(dev);
-	struct hisi_pmic *pmic = rdev_to_pmic(dev);
+	struct hisi_pmic *pmic = sreg->pmic;
 	u32 reg_val, selector;
 
 	/* get voltage selector */
@@ -146,7 +137,7 @@ static int hisi_regulator_set_voltage(struct regulator_dev *dev,
 				      int min_uV, int max_uV, unsigned int *selector)
 {
 	struct hisi_regulator *sreg = rdev_get_drvdata(dev);
-	struct hisi_pmic *pmic = rdev_to_pmic(dev);
+	struct hisi_pmic *pmic = sreg->pmic;
 	u32 vsel;
 	int ret = 0;
 
@@ -179,7 +170,7 @@ static int hisi_regulator_set_voltage(struct regulator_dev *dev,
 static unsigned int hisi_regulator_get_mode(struct regulator_dev *dev)
 {
 	struct hisi_regulator *sreg = rdev_get_drvdata(dev);
-	struct hisi_pmic *pmic = rdev_to_pmic(dev);
+	struct hisi_pmic *pmic = sreg->pmic;
 	u32 reg_val;
 
 	reg_val = hisi_pmic_read(pmic, sreg->register_info.ctrl_reg);
@@ -198,7 +189,7 @@ static int hisi_regulator_set_mode(struct regulator_dev *dev,
 				   unsigned int mode)
 {
 	struct hisi_regulator *sreg = rdev_get_drvdata(dev);
-	struct hisi_pmic *pmic = rdev_to_pmic(dev);
+	struct hisi_pmic *pmic = sreg->pmic;
 	u32 eco_mode;
 
 	switch (mode) {
@@ -238,7 +229,7 @@ static unsigned int hisi_regulator_get_optimum_mode(struct regulator_dev *dev,
 }
 
 static int hisi_dt_parse_common(struct hisi_regulator *sreg,
-				struct spmi_device *pdev)
+				struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
@@ -296,7 +287,7 @@ static int hisi_dt_parse_common(struct hisi_regulator *sreg,
 }
 
 static int hisi_dt_parse_ldo(struct hisi_regulator *sreg,
-			     struct spmi_device *pdev)
+			     struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
@@ -355,47 +346,32 @@ static struct regulator_ops hisi_ldo_rops = {
 	.get_optimum_mode = hisi_regulator_get_optimum_mode,
 };
 
-static const struct hisi_regulator hisi_regulator_ldo = {
-	.rdesc = {
-	.ops = &hisi_ldo_rops,
-		.type = REGULATOR_VOLTAGE,
-		.owner = THIS_MODULE,
-		},
-	.dt_parse = hisi_dt_parse_ldo,
-};
+/*
+ * Used only for parsing the DT properties
+ */
 
-static const struct of_device_id of_hisi_regulator_match_tbl[] = {
+static const struct of_device_id of_hisi_pmic_match_tbl[] = {
 	{
-		.compatible = "hisilicon-hisi-ldo",
-		.data = &hisi_regulator_ldo,
+		.compatible = "hisilicon,hi6421-spmi-pmic-ldo",
 	},
-	{ /* end */ }
+	{ }
 };
 
-static int hisi_regulator_probe(struct spmi_device *pdev)
+static int hisi_regulator_probe_ldo(struct platform_device *pdev,
+				    struct device_node *np,
+				    struct hisi_pmic *pmic)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct regulator_desc *rdesc;
 	struct regulator_dev *rdev;
 	struct hisi_regulator *sreg = NULL;
 	struct regulator_init_data *initdata;
 	struct regulator_config config = { };
-	const struct of_device_id *match;
 	struct regulation_constraints *constraint;
 	const char *supplyname = NULL;
 	unsigned int temp_modes;
-
-	const struct hisi_regulator *template = NULL;
 	int ret = 0;
-	/* to check which type of regulator this is */
-	match = of_match_device(of_hisi_regulator_match_tbl, &pdev->dev);
-	if (!match) {
-		pr_err("get hisi regulator fail!\n\r");
-		return -EINVAL;
-	}
 
-	template = match->data;
 	initdata = of_get_regulator_init_data(dev, np, NULL);
 	if (!initdata) {
 		pr_err("get regulator init data error !\n");
@@ -421,20 +397,25 @@ static int hisi_regulator_probe(struct spmi_device *pdev)
 	}
 	constraint->valid_ops_mask |= temp_modes;
 
-	sreg = kmemdup(template, sizeof(*sreg), GFP_KERNEL);
+	sreg = kzalloc(sizeof(*sreg), GFP_KERNEL);
 	if (!sreg)
 		return -ENOMEM;
 
 	sreg->name = initdata->constraints.name;
+	sreg->pmic = pmic;
 	rdesc = &sreg->rdesc;
+
 	rdesc->name = sreg->name;
+	rdesc->ops = &hisi_ldo_rops;
+	rdesc->type = REGULATOR_VOLTAGE;
 	rdesc->min_uV = initdata->constraints.min_uV;
+
 	supplyname = of_get_property(np, "hisilicon,supply_name", NULL);
 	if (supplyname)
 		initdata->supply_regulator = supplyname;
 
-	/* to parse device tree data for regulator specific */
-	ret = sreg->dt_parse(sreg, pdev);
+	/* parse device tree data for regulator specific */
+	ret = hisi_dt_parse_ldo(sreg, pdev);
 	if (ret) {
 		dev_err(dev, "device tree parameter parse error!\n");
 		goto hisi_probe_end;
@@ -465,7 +446,59 @@ static int hisi_regulator_probe(struct spmi_device *pdev)
 	return ret;
 }
 
-static void hisi_regulator_remove(struct spmi_device *pdev)
+
+static int hisi_regulator_probe(struct platform_device *pdev)
+{
+	struct device *pmic_dev = pdev->dev.parent;
+	struct device_node *np = pmic_dev->of_node;
+	struct device_node *regulators, *child;
+	struct platform_device *new_pdev;
+	struct hisi_pmic *pmic;
+	int ret;
+
+	dev_dbg(&pdev->dev, "probing hi6421v600 regulator\n");
+	/*
+	 * This driver is meant to be called by hi6421-spmi-core,
+	 * which should first set drvdata. If this doesn't happen, hit
+	 * a warn on and return.
+	 */
+	pmic = dev_get_drvdata(pmic_dev);
+	if (WARN_ON(!pmic))
+		return -ENODEV;
+
+	regulators = of_get_child_by_name(np, "regulators");
+	if (!regulators) {
+		dev_err(&pdev->dev, "regulator node not found\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * Parse all LDO regulator nodes
+	 */
+	for_each_child_of_node(regulators, child) {
+		dev_dbg(&pdev->dev, "adding child %pOF\n", child);
+
+		new_pdev = platform_device_alloc(child->name, -1);
+		new_pdev->dev.parent = pmic_dev;
+		new_pdev->dev.of_node = of_node_get(child);
+
+		ret = platform_device_add(new_pdev);
+		if (ret < 0) {
+			platform_device_put(new_pdev);
+			continue;
+		}
+
+		ret = hisi_regulator_probe_ldo(new_pdev, child, pmic);
+		if (ret < 0)
+			platform_device_put(new_pdev);
+	}
+
+	of_node_put(regulators);
+
+	return 0;
+}
+
+static int hisi_regulator_remove(struct platform_device *pdev)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(&pdev->dev);
 	struct hisi_regulator *sreg = rdev_get_drvdata(rdev);
@@ -477,63 +510,26 @@ static void hisi_regulator_remove(struct spmi_device *pdev)
 		devm_kfree(&pdev->dev, (unsigned int *)sreg->rdesc.volt_table);
 
 	kfree(sreg);
-}
-
-static int hisi_regulator_suspend(struct device *dev, pm_message_t state)
-{
-	struct hisi_regulator *hisi_regulator = dev_get_drvdata(dev);
-
-	if (!hisi_regulator) {
-		pr_err("%s:regulator is NULL\n", __func__);
-		return -ENOMEM;
-	}
-
-	pr_info("%s:+\n", __func__);
-	pr_info("%s:-\n", __func__);
 
 	return 0;
 }
 
-static int hisi_regulator_resume(struct device *dev)
-{
-	struct hisi_regulator *hisi_regulator = dev_get_drvdata(dev);
-
-	if (!hisi_regulator) {
-		pr_err("%s:regulator is NULL\n", __func__);
-		return -ENOMEM;
-	}
-
-	pr_info("%s:+\n", __func__);
-	pr_info("%s:-\n", __func__);
-
-	return 0;
-}
+static const struct platform_device_id hi6421v600_regulator_table[] = {
+	{ .name = "hi6421v600-regulator" },
+	{},
+};
+MODULE_DEVICE_TABLE(platform, hi6421v600_regulator_table);
 
-static struct spmi_driver hisi_pmic_driver = {
+static struct platform_driver hi6421v600_regulator_driver = {
+	.id_table = hi6421v600_regulator_table,
 	.driver = {
-		.name	= "hisi_regulator",
-		.owner  = THIS_MODULE,
-		.of_match_table = of_hisi_regulator_match_tbl,
-		.suspend = hisi_regulator_suspend,
-		.resume = hisi_regulator_resume,
+		.name	= "hi6421v600-regulator",
 	},
 	.probe	= hisi_regulator_probe,
 	.remove	= hisi_regulator_remove,
 };
+module_platform_driver(hi6421v600_regulator_driver);
 
-static int __init hisi_regulator_init(void)
-{
-	return spmi_driver_register(&hisi_pmic_driver);
-}
-
-static void __exit hisi_regulator_exit(void)
-{
-	spmi_driver_unregister(&hisi_pmic_driver);
-}
-
-fs_initcall(hisi_regulator_init);
-module_exit(hisi_regulator_exit);
-
-MODULE_DESCRIPTION("Hisi regulator driver");
+MODULE_DESCRIPTION("Hi6421v600 regulator driver");
 MODULE_LICENSE("GPL v2");
 
diff --git a/include/linux/mfd/hisi_pmic.h b/include/linux/mfd/hi6421-spmi-pmic.h
similarity index 100%
rename from include/linux/mfd/hisi_pmic.h
rename to include/linux/mfd/hi6421-spmi-pmic.h
-- 
2.26.2

