Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2A5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 166462076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597160620;
	bh=tQmgyPtacMB8NZXr7YiMcqpCRzKmGc4+iJGDUNelrV4=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=nHM14lDiUSoBeLgfPjro9zHG6Ihpf76z3KvcO9yseKE9cFhSzRFStSeXYO4R2ajt0
	 I5eRWLzDU8tpB/tBrribsrBlTo1jd/2c3aBA6qsO2/NpWlqAkhrZhGjHEbbWHD7Z0r
	 guGmpNuDbhOcAjgI7NYOlbR7skaQUq74K506fevg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgHKPng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:43:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728997AbgHKPmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:42:06 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD48D22D07;
        Tue, 11 Aug 2020 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160524;
        bh=tQmgyPtacMB8NZXr7YiMcqpCRzKmGc4+iJGDUNelrV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAjWVPtFwBGAw9Oh8AyJqOgnszp69xQkCwFESPJ6P7luJEooiZBnRYcXl2Y6azROQ
         wVLNrY+CnvBVKGuy2di6/lRSg7Bvbjw9Xb3YuY93Vw8cFC3Uu8FmmN/ahhhgFx4JeK
         9X1eGEOr6hL6EoxemjSDhidclYA7CgprgGht5W00=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5WPZ-004bnD-VS; Tue, 11 Aug 2020 17:42:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 21/33] regulator: hi6421v600-regulator: cleanup debug messages
Date:   Tue, 11 Aug 2020 17:41:47 +0200
Message-Id: <3d25b6b08ad2719f7687af4b235e40a4b7f93609.1597160086.git.mchehab+huawei@kernel.org>
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

- use dev_foo() instead of pr_foo();
- cleanup the messages, making them more standard and easier
  to understand.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/regulator/hi6421v600-regulator.c | 76 +++++++++++++++---------
 1 file changed, 47 insertions(+), 29 deletions(-)

diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index 7d82d11f4b52..2d1096ecb277 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -59,9 +59,11 @@ static int hisi_regulator_is_enabled(struct regulator_dev *rdev)
 	struct hisi_pmic *pmic = sreg->pmic;
 
 	reg_val = hisi_pmic_read(pmic, rdev->desc->enable_reg);
-	pr_debug("<[%s]: enable_reg=0x%x,enable_state=%d>\n",
+
+	dev_dbg(&rdev->dev,
+		"%s: enable_reg=0x%x, val= 0x%x, enable_state=%d\n",
 		 __func__, rdev->desc->enable_reg,
-		(reg_val & rdev->desc->enable_mask));
+		reg_val, (reg_val & rdev->desc->enable_mask));
 
 	return ((reg_val & rdev->desc->enable_mask) != 0);
 }
@@ -74,7 +76,8 @@ static int hisi_regulator_enable(struct regulator_dev *rdev)
 	/* keep a distance of off_on_delay from last time disabled */
 	usleep_range(rdev->desc->off_on_delay, rdev->desc->off_on_delay + 1000);
 
-	pr_debug("<[%s]: off_on_delay=%dus>\n", __func__, rdev->desc->off_on_delay);
+	dev_dbg(&rdev->dev, "%s: off_on_delay=%d us\n",
+		__func__, rdev->desc->off_on_delay);
 
 	/* cannot enable more than one regulator at one time */
 	mutex_lock(&enable_mutex);
@@ -85,7 +88,7 @@ static int hisi_regulator_enable(struct regulator_dev *rdev)
 	hisi_pmic_rmw(pmic, rdev->desc->enable_reg,
 		      rdev->desc->enable_mask,
 				rdev->desc->enable_mask);
-	pr_debug("<[%s]: enable_reg=0x%x,enable_mask=0x%x>\n",
+	dev_dbg(&rdev->dev, "%s: enable_reg=0x%x, enable_mask=0x%x\n",
 		 __func__, rdev->desc->enable_reg,
 		 rdev->desc->enable_mask);
 
@@ -111,16 +114,20 @@ static int hisi_regulator_get_voltage(struct regulator_dev *rdev)
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
 	struct hisi_pmic *pmic = sreg->pmic;
 	u32 reg_val, selector;
+	int vol;
 
 	/* get voltage selector */
 	reg_val = hisi_pmic_read(pmic, rdev->desc->vsel_reg);
-	pr_debug("<[%s]: vsel_reg=0x%x>\n",
-		 __func__, rdev->desc->vsel_reg);
-
 	selector = (reg_val & rdev->desc->vsel_mask) >>
 				(ffs(rdev->desc->vsel_mask) - 1);
 
-	return rdev->desc->ops->list_voltage(rdev, selector);
+	vol = rdev->desc->ops->list_voltage(rdev, selector);
+
+	dev_dbg(&rdev->dev,
+		"%s: vsel_reg=0x%x, val=0x%x, entry=0x%x, voltage=%d mV\n",
+		 __func__, rdev->desc->vsel_reg, reg_val, selector, vol/ 1000);
+
+	return vol;
 }
 
 static int hisi_regulator_set_voltage(struct regulator_dev *rdev,
@@ -129,10 +136,14 @@ static int hisi_regulator_set_voltage(struct regulator_dev *rdev,
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
 	struct hisi_pmic *pmic = sreg->pmic;
 	u32 vsel;
-	int ret = 0;
+	int uV, ret = 0;
 
 	for (vsel = 0; vsel < rdev->desc->n_voltages; vsel++) {
-		int uV = rdev->desc->volt_table[vsel];
+		uV = rdev->desc->volt_table[vsel];
+		dev_dbg(&rdev->dev,
+			"%s: min %d, max %d, value[%u] = %d\n",
+			__func__, min_uV, max_uV, vsel, uV);
+
 		/* Break at the first in-range value */
 		if (min_uV <= uV && uV <= max_uV)
 			break;
@@ -146,13 +157,14 @@ static int hisi_regulator_set_voltage(struct regulator_dev *rdev,
 	/* set voltage selector */
 	hisi_pmic_rmw(pmic, rdev->desc->vsel_reg,
 		      rdev->desc->vsel_mask,
-		vsel << (ffs(rdev->desc->vsel_mask) - 1));
+		      vsel << (ffs(rdev->desc->vsel_mask) - 1));
 
-	pr_debug("<[%s]: vsel_reg=0x%x, vsel_mask=0x%x, value=0x%x>\n",
+	dev_dbg(&rdev->dev,
+		"%s: vsel_reg=0x%x, vsel_mask=0x%x, value=0x%x, voltage=%d mV\n",
 		 __func__,
 		 rdev->desc->vsel_reg,
 		 rdev->desc->vsel_mask,
-		 vsel << (ffs(rdev->desc->vsel_mask) - 1));
+		 vsel << (ffs(rdev->desc->vsel_mask) - 1), uV / 1000);
 
 	return ret;
 }
@@ -162,17 +174,21 @@ static unsigned int hisi_regulator_get_mode(struct regulator_dev *rdev)
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
 	struct hisi_pmic *pmic = sreg->pmic;
 	u32 reg_val;
+	unsigned int mode;
 
 	reg_val = hisi_pmic_read(pmic, rdev->desc->enable_reg);
-	pr_debug("<[%s]: reg_val=%d, enable_reg=0x%x, eco_mode_mask=0x%x>\n",
-		 __func__, reg_val,
-		rdev->desc->enable_reg,
-		sreg->eco_mode_mask);
 
 	if (reg_val & sreg->eco_mode_mask)
-		return REGULATOR_MODE_IDLE;
+		mode = REGULATOR_MODE_IDLE;
 	else
-		return REGULATOR_MODE_NORMAL;
+		mode = REGULATOR_MODE_NORMAL;
+
+	dev_dbg(&rdev->dev,
+		"%s: enable_reg=0x%x, eco_mode_mask=0x%x, reg_val=0x%x, %s mode\n",
+		 __func__, rdev->desc->enable_reg, sreg->eco_mode_mask, reg_val,
+		 mode == REGULATOR_MODE_IDLE ? "idle" : "normal");
+
+	return mode;
 }
 
 static int hisi_regulator_set_mode(struct regulator_dev *rdev,
@@ -198,7 +214,8 @@ static int hisi_regulator_set_mode(struct regulator_dev *rdev,
 		      sreg->eco_mode_mask,
 		eco_mode << (ffs(sreg->eco_mode_mask) - 1));
 
-	pr_debug("<[%s]: enable_reg=0x%x, eco_mode_mask=0x%x, value=0x%x>\n",
+	dev_dbg(&rdev->dev,
+		"%s: enable_reg=0x%x, eco_mode_mask=0x%x, value=0x%x\n",
 		 __func__,
 		rdev->desc->enable_reg,
 		sreg->eco_mode_mask,
@@ -212,10 +229,13 @@ static unsigned int hisi_regulator_get_optimum_mode(struct regulator_dev *rdev,
 {
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
 
-	if (load_uA || ((unsigned int)load_uA > sreg->eco_uA))
+	if (load_uA || ((unsigned int)load_uA > sreg->eco_uA)) {
+		dev_dbg(&rdev->dev, "%s: normal mode", __func__);
 		return REGULATOR_MODE_NORMAL;
-	else
+	} else {
+		dev_dbg(&rdev->dev, "%s: idle mode", __func__);
 		return REGULATOR_MODE_IDLE;
+	}
 }
 
 static int hisi_dt_parse(struct platform_device *pdev,
@@ -333,7 +353,7 @@ static int hisi_regulator_probe_ldo(struct platform_device *pdev,
 
 	initdata = of_get_regulator_init_data(dev, np, NULL);
 	if (!initdata) {
-		pr_err("get regulator init data error !\n");
+		dev_err(dev, "failed to get regulator data\n");
 		return -EINVAL;
 	}
 
@@ -343,14 +363,14 @@ static int hisi_regulator_probe_ldo(struct platform_device *pdev,
 	ret = of_property_read_u32_array(np, "hisilicon,valid-modes-mask",
 					 &constraint->valid_modes_mask, 1);
 	if (ret) {
-		pr_err("no hisilicon,valid-modes-mask property set\n");
+		dev_err(dev, "no valid modes mask\n");
 		ret = -ENODEV;
 		return ret;
 	}
 	ret = of_property_read_u32_array(np, "hisilicon,valid-idle-mask",
 					 &temp_modes, 1);
 	if (ret) {
-		pr_err("no hisilicon,valid-modes-mask property set\n");
+		dev_err(dev, "no valid idle mask\n");
 		ret = -ENODEV;
 		return ret;
 	}
@@ -374,10 +394,8 @@ static int hisi_regulator_probe_ldo(struct platform_device *pdev,
 
 	/* parse device tree data for regulator specific */
 	ret = hisi_dt_parse(pdev, sreg, rdesc);
-	if (ret) {
-		dev_err(dev, "device tree parameter parse error!\n");
+	if (ret)
 		goto hisi_probe_end;
-	}
 
 	config.dev = &pdev->dev;
 	config.init_data = initdata;
@@ -393,7 +411,7 @@ static int hisi_regulator_probe_ldo(struct platform_device *pdev,
 		goto hisi_probe_end;
 	}
 
-	pr_debug("[%s]:valid_modes_mask[0x%x], valid_ops_mask[0x%x]\n",
+	dev_dbg(dev, "%s:valid_modes_mask: 0x%x, valid_ops_mask: 0x%x\n",
 		 rdesc->name,
 		 constraint->valid_modes_mask, constraint->valid_ops_mask);
 
-- 
2.26.2

