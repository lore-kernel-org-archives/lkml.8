Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475D5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BDCD207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597247890;
	bh=LlkIH0oWEJxTuayVV7j0/zZciq+D6+8D+x+9rzX0KEo=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=1w9WMOLBVqfs+NeGhiEW6CelWfynbFY+tRR9c/UeKVh3Jfwu3p4fZl6L78RM6yIwJ
	 nwCYOGjhZ5LmVM08lm8jqbH31eV5nmMJAxI8DtYAz80wa1Uh67t9q+X8kG5PMnmo/7
	 Sb58seZ7swct8k+lffrltQRrj2u7ZgwaU+7DDgro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgHLP6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgHLP5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:05 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2956323102;
        Wed, 12 Aug 2020 15:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247821;
        bh=LlkIH0oWEJxTuayVV7j0/zZciq+D6+8D+x+9rzX0KEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DZDL/pIWryhiDHhiYESf1TelqAQDPnZrxliRtzbRXG4onqmbPq0PpC0HVjSQYL8g0
         q97Uk+QRYJAXtwidFeEbhxrD2giaStZ8TZDAWNkSVONeC0hvIilsmnrWdLAPAgXMJi
         e00ifrir9+QNvLdShrY+QfhTr4mcSXz29Pe22J+g=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7b-005t7L-9U; Wed, 12 Aug 2020 17:56:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 38/44] staging: regulator: hi6421v600-regulator: fix some coding style issues
Date:   Wed, 12 Aug 2020 17:56:48 +0200
Message-Id: <785cb5fe6033e641ac12cebe25aa5983aed204f7.1597247164.git.mchehab+huawei@kernel.org>
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

Fix the remaining issues complained by checkpatch.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../staging/hikey9xx/hi6421v600-regulator.c   | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index 72f51594b5ff..c80dfac1e4c3 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
@@ -40,7 +40,7 @@
 #include <linux/spmi.h>
 
 #define rdev_dbg(rdev, fmt, arg...)	\
-		 pr_debug("%s: %s: " fmt, rdev->desc->name, __func__, ##arg)
+		 pr_debug("%s: %s: " fmt, (rdev)->desc->name, __func__, ##arg)
 
 struct hi6421v600_regulator {
 	struct regulator_desc rdesc;
@@ -105,7 +105,7 @@ static int hi6421_spmi_regulator_disable(struct regulator_dev *rdev)
 		 rdev->desc->enable_reg, rdev->desc->enable_mask);
 
 	hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
-		      rdev->desc->enable_mask, 0);
+			     rdev->desc->enable_mask, 0);
 
 	return 0;
 }
@@ -122,7 +122,7 @@ static int hi6421_spmi_regulator_get_voltage_sel(struct regulator_dev *rdev)
 	selector = (reg_val & rdev->desc->vsel_mask) >>	(ffs(rdev->desc->vsel_mask) - 1);
 
 	rdev_dbg(rdev,
-		"vsel_reg=0x%x, value=0x%x, entry=0x%x, voltage=%d mV\n",
+		 "vsel_reg=0x%x, value=0x%x, entry=0x%x, voltage=%d mV\n",
 		 rdev->desc->vsel_reg, reg_val, selector,
 		rdev->desc->ops->list_voltage(rdev, selector) / 1000);
 
@@ -144,7 +144,7 @@ static int hi6421_spmi_regulator_set_voltage_sel(struct regulator_dev *rdev,
 
 	/* set voltage selector */
 	rdev_dbg(rdev,
-		"vsel_reg=0x%x, mask=0x%x, value=0x%x, voltage=%d mV\n",
+		 "vsel_reg=0x%x, mask=0x%x, value=0x%x, voltage=%d mV\n",
 		 rdev->desc->vsel_reg, rdev->desc->vsel_mask, reg_val,
 		 rdev->desc->ops->list_voltage(rdev, selector) / 1000);
 
@@ -169,7 +169,7 @@ static unsigned int hi6421_spmi_regulator_get_mode(struct regulator_dev *rdev)
 		mode = REGULATOR_MODE_NORMAL;
 
 	rdev_dbg(rdev,
-		"enable_reg=0x%x, eco_mode_mask=0x%x, reg_val=0x%x, %s mode\n",
+		 "enable_reg=0x%x, eco_mode_mask=0x%x, reg_val=0x%x, %s mode\n",
 		 rdev->desc->enable_reg, sreg->eco_mode_mask, reg_val,
 		 mode == REGULATOR_MODE_IDLE ? "idle" : "normal");
 
@@ -177,7 +177,7 @@ static unsigned int hi6421_spmi_regulator_get_mode(struct regulator_dev *rdev)
 }
 
 static int hi6421_spmi_regulator_set_mode(struct regulator_dev *rdev,
-				   unsigned int mode)
+					  unsigned int mode)
 {
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
@@ -204,9 +204,10 @@ static int hi6421_spmi_regulator_set_mode(struct regulator_dev *rdev,
 	return 0;
 }
 
-static unsigned int hi6421_spmi_regulator_get_optimum_mode(struct regulator_dev *rdev,
-						    int input_uV, int output_uV,
-						    int load_uA)
+static unsigned int
+hi6421_spmi_regulator_get_optimum_mode(struct regulator_dev *rdev,
+				       int input_uV, int output_uV,
+				       int load_uA)
 {
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
 
@@ -220,7 +221,7 @@ static unsigned int hi6421_spmi_regulator_get_optimum_mode(struct regulator_dev
 }
 
 static int hi6421_spmi_dt_parse(struct platform_device *pdev,
-			 struct hi6421v600_regulator *sreg,
+				struct hi6421v600_regulator *sreg,
 			 struct regulator_desc *rdesc)
 {
 	struct device *dev = &pdev->dev;
@@ -256,7 +257,7 @@ static int hi6421_spmi_dt_parse(struct platform_device *pdev,
 		sreg->eco_uA = 0;
 	} else {
 		ret = of_property_read_u32(np, "eco-microamp",
-					&sreg->eco_uA);
+					   &sreg->eco_uA);
 		if (ret) {
 			dev_err(dev, "missing eco-microamp property\n");
 			return ret;
@@ -331,8 +332,8 @@ static struct regulator_ops hi6421_spmi_ldo_rops = {
  */
 
 static int hi6421_spmi_regulator_probe_ldo(struct platform_device *pdev,
-				    struct device_node *np,
-				    struct hi6421_spmi_pmic *pmic)
+					   struct device_node *np,
+					   struct hi6421_spmi_pmic *pmic)
 {
 	struct device *dev = &pdev->dev;
 	struct regulator_desc *rdesc;
@@ -404,7 +405,6 @@ static int hi6421_spmi_regulator_probe_ldo(struct platform_device *pdev,
 	return ret;
 }
 
-
 static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
 {
 	struct device *pmic_dev = pdev->dev.parent;
-- 
2.26.2

