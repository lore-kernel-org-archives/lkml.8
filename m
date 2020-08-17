Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131C1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7BF72072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597648376;
	bh=LlkIH0oWEJxTuayVV7j0/zZciq+D6+8D+x+9rzX0KEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bbr3rt/zCCaWqFfK1CaQzd7H65NoqJGm0clQCSaodUaRvDySlTf9fgYEyqHa+qRzy
	 cvzn7dtN0O9bEKDHua8GXXGAhdoOuaYcq/iE6bDGTP0DcDovC5+Q/Tt8ptjyuPiQKk
	 YuqnBSpbvvyCd5OKXNYYA67elMKHbCkV/KTAfexw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgHQHMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbgHQHLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:11:38 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BF1C22D6F;
        Mon, 17 Aug 2020 07:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597648278;
        bh=LlkIH0oWEJxTuayVV7j0/zZciq+D6+8D+x+9rzX0KEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GIscSsKTbpvioOk5zPYS0vJADZ69J4tjZl/Ob8cAeCf6EzJRlhfppr+Q+YcbCHLJm
         v9CYhwuI4ni4+eWk+GnWlpBph5PvpHdB2COIZO2/PhYB0llwIG8tmw4ri73CPNxGg6
         iQ0aOSjp5lflvbE4W0SM6FNBXX9xbC6edGSLd1Qg=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZIa-00Bdl0-HG; Mon, 17 Aug 2020 09:11:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH v3 38/44] staging: regulator: hi6421v600-regulator: fix some coding style issues
Date:   Mon, 17 Aug 2020 09:10:57 +0200
Message-Id: <af5101fa2ab1d267ac5ac22603f95c6065ac110f.1597647359.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597647359.git.mchehab+huawei@kernel.org>
References: <cover.1597647359.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

