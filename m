Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9FFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46E33207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597247885;
	bh=fLI5W5fuj4I3WvedbK4hxsAEsLhRR3pILDLH1yVdBao=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=fSoqp5MWFjzz/tdmTl1Dg/NV2+vJlI1i+mwA8O21gezwazCcq43l9LAWWkvKGw+rs
	 fKQA49c+OQbAN7X7NbIWDQSCrMDN/ZMMNOQ/8MhzZtwTd8eYrUVlZlo5F8joi2loYR
	 dnWRaZ8y/V01t5fVkwFfxByn5/wcmV35psgL9XNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgHLP6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:58:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgHLP5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:04 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D64022EBD;
        Wed, 12 Aug 2020 15:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247821;
        bh=fLI5W5fuj4I3WvedbK4hxsAEsLhRR3pILDLH1yVdBao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQELB+d3a2PBrwAvMygMGEcmQ5vFPfBHjZFW9LJYCqOF4KrBOeLU+0sakQqkYiFeT
         JXqh3DYLJRKrt+5i9U4bmAvbv8nOnUrRDioZVaNaIBRIps/cAoMOifEyah/hQQ+JlT
         jGwvP4xisBuxcBU5AJbSQfczvATKWWIuGByEjFRw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7b-005t7D-5Y; Wed, 12 Aug 2020 17:56:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 35/44] staging: regulator: hi6421v600-regulator: add a driver-specific debug macro
Date:   Wed, 12 Aug 2020 17:56:45 +0200
Message-Id: <7cb10b3910e9fa3e52d36e4e416030175cc761ab.1597247164.git.mchehab+huawei@kernel.org>
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

Using dev_dbg() is not too nice, as, instead of printing the
name of the regulator, it prints "regulator.<number>", making
harder to associate what is happening with each ldo line.

So, add a debug-specific macro, which will print the rdev's
name, just like the regulator core.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../staging/hikey9xx/hi6421v600-regulator.c   | 61 ++++++++++---------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index 31b8ff19fd31..5ddaf7f8cacc 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
@@ -39,6 +39,9 @@
 #include <linux/uaccess.h>
 #include <linux/spmi.h>
 
+#define rdev_dbg(rdev, fmt, arg...)	\
+		 pr_debug("%s: %s: " fmt, rdev->desc->name, __func__, ##arg)
+
 struct hi6421v600_regulator {
 	struct regulator_desc rdesc;
 	struct hi6421_spmi_pmic *pmic;
@@ -60,10 +63,10 @@ static int hi6421_spmi_regulator_is_enabled(struct regulator_dev *rdev)
 
 	reg_val = hi6421_spmi_pmic_read(pmic, rdev->desc->enable_reg);
 
-	dev_dbg(&rdev->dev,
-		"%s: enable_reg=0x%x, val= 0x%x, enable_state=%d\n",
-		 __func__, rdev->desc->enable_reg,
-		reg_val, (reg_val & rdev->desc->enable_mask));
+	rdev_dbg(rdev,
+		 "enable_reg=0x%x, val= 0x%x, enable_state=%d\n",
+		 rdev->desc->enable_reg,
+		 reg_val, (reg_val & rdev->desc->enable_mask));
 
 	return ((reg_val & rdev->desc->enable_mask) != 0);
 }
@@ -73,21 +76,20 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 
-	dev_dbg(&rdev->dev, "%s: off_on_delay=%d us\n",
-		__func__, rdev->desc->off_on_delay);
-
 	/* cannot enable more than one regulator at one time */
 	mutex_lock(&enable_mutex);
 	usleep_range(HISI_REGS_ENA_PROTECT_TIME,
 		     HISI_REGS_ENA_PROTECT_TIME + 1000);
 
 	/* set enable register */
+	rdev_dbg(rdev,
+		 "off_on_delay=%d us, enable_reg=0x%x, enable_mask=0x%x\n",
+		 rdev->desc->off_on_delay, rdev->desc->enable_reg,
+		 rdev->desc->enable_mask);
+
 	hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
 			     rdev->desc->enable_mask,
 			     rdev->desc->enable_mask);
-	dev_dbg(&rdev->dev, "%s: enable_reg=0x%x, enable_mask=0x%x\n",
-		 __func__, rdev->desc->enable_reg,
-		 rdev->desc->enable_mask);
 
 	mutex_unlock(&enable_mutex);
 
@@ -100,6 +102,9 @@ static int hi6421_spmi_regulator_disable(struct regulator_dev *rdev)
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 
 	/* set enable register to 0 */
+	rdev_dbg(rdev, "enable_reg=0x%x, enable_mask=0x%x\n",
+		 rdev->desc->enable_reg, rdev->desc->enable_mask);
+
 	hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
 		      rdev->desc->enable_mask, 0);
 
@@ -117,9 +122,9 @@ static int hi6421_spmi_regulator_get_voltage_sel(struct regulator_dev *rdev)
 
 	selector = (reg_val & rdev->desc->vsel_mask) >>	(ffs(rdev->desc->vsel_mask) - 1);
 
-	dev_dbg(&rdev->dev,
-		"%s: vsel_reg=0x%x, value=0x%x, entry=0x%x, voltage=%d mV\n",
-		 __func__, rdev->desc->vsel_reg, reg_val, selector,
+	rdev_dbg(rdev,
+		"vsel_reg=0x%x, value=0x%x, entry=0x%x, voltage=%d mV\n",
+		 rdev->desc->vsel_reg, reg_val, selector,
 		rdev->desc->ops->list_voltage(rdev, selector) / 1000);
 
 	return selector;
@@ -139,15 +144,14 @@ static int hi6421_spmi_regulator_set_voltage_sel(struct regulator_dev *rdev,
 	reg_val = selector << (ffs(rdev->desc->vsel_mask) - 1);
 
 	/* set voltage selector */
-	hi6421_spmi_pmic_rmw(pmic, rdev->desc->vsel_reg,
-			     rdev->desc->vsel_mask, reg_val);
-
-	dev_dbg(&rdev->dev,
-		"%s: vsel_reg=0x%x, mask=0x%x, value=0x%x, voltage=%d mV\n",
-		 __func__,
+	rdev_dbg(rdev,
+		"vsel_reg=0x%x, mask=0x%x, value=0x%x, voltage=%d mV\n",
 		 rdev->desc->vsel_reg, rdev->desc->vsel_mask, reg_val,
 		 rdev->desc->ops->list_voltage(rdev, selector) / 1000);
 
+	hi6421_spmi_pmic_rmw(pmic, rdev->desc->vsel_reg,
+			     rdev->desc->vsel_mask, reg_val);
+
 	return 0;
 }
 
@@ -165,9 +169,9 @@ static unsigned int hi6421_spmi_regulator_get_mode(struct regulator_dev *rdev)
 	else
 		mode = REGULATOR_MODE_NORMAL;
 
-	dev_dbg(&rdev->dev,
-		"%s: enable_reg=0x%x, eco_mode_mask=0x%x, reg_val=0x%x, %s mode\n",
-		 __func__, rdev->desc->enable_reg, sreg->eco_mode_mask, reg_val,
+	rdev_dbg(rdev,
+		"enable_reg=0x%x, eco_mode_mask=0x%x, reg_val=0x%x, %s mode\n",
+		 rdev->desc->enable_reg, sreg->eco_mode_mask, reg_val,
 		 mode == REGULATOR_MODE_IDLE ? "idle" : "normal");
 
 	return mode;
@@ -192,13 +196,12 @@ static int hi6421_spmi_regulator_set_mode(struct regulator_dev *rdev,
 	}
 
 	/* set mode */
+	rdev_dbg(rdev, "enable_reg=0x%x, eco_mode_mask=0x%x, value=0x%x\n",
+		 rdev->desc->enable_reg, sreg->eco_mode_mask, val);
+
 	hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
 			     sreg->eco_mode_mask, val);
 
-	dev_dbg(&rdev->dev,
-		"%s: enable_reg=0x%x, eco_mode_mask=0x%x, value=0x%x\n",
-		 __func__, rdev->desc->enable_reg, sreg->eco_mode_mask, val);
-
 	return 0;
 }
 
@@ -209,10 +212,10 @@ static unsigned int hi6421_spmi_regulator_get_optimum_mode(struct regulator_dev
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
 
 	if (load_uA || ((unsigned int)load_uA > sreg->eco_uA)) {
-		dev_dbg(&rdev->dev, "%s: normal mode", __func__);
+		rdev_dbg(rdev, "normal mode");
 		return REGULATOR_MODE_NORMAL;
 	} else {
-		dev_dbg(&rdev->dev, "%s: idle mode", __func__);
+		rdev_dbg(rdev, "idle mode");
 		return REGULATOR_MODE_IDLE;
 	}
 }
@@ -373,7 +376,7 @@ static int hi6421_spmi_regulator_probe_ldo(struct platform_device *pdev,
 		goto probe_end;
 	}
 
-	dev_dbg(dev, "valid_modes_mask: 0x%x, valid_ops_mask: 0x%x\n",
+	rdev_dbg(rdev, "valid_modes_mask: 0x%x, valid_ops_mask: 0x%x\n",
 		 constraint->valid_modes_mask, constraint->valid_ops_mask);
 
 	dev_set_drvdata(dev, rdev);
-- 
2.26.2

