Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7571C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96FAB2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597648372;
	bh=ouoGiPnKj1lZ+PjwE0GBk4FRAAeLlElfXhUD6JMvcoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b2e3M/ijxZfe/wI5LXHHmLoLoKxZWEn/JDTnmKPqfgAhHFcUNk1vUlJmVx2Iwri5s
	 Y0Qr8pbP8eXfdP3QFFtyCG8m8W+LIHbQBG0do+tmkg3Djq77mOJTa005bIU8DbAsMr
	 RSSAdwHtT0kxKTzlpqRnWntxH4rKQJUlkIZbjvoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgHQHMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgHQHLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:11:34 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1790C22D0B;
        Mon, 17 Aug 2020 07:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597648278;
        bh=ouoGiPnKj1lZ+PjwE0GBk4FRAAeLlElfXhUD6JMvcoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ugGiIAjzbQdjl3UmB3S8t65sMNja4WoFynh76S8BWzXZPUb1eTQTm8aFrtHwh52U7
         5vbVb2yBTSp03WSUCGgF8/guYbQP3i279ME1Zd/KXohzEmICORwJlyFK++5qss28uU
         QKQOK2XKhe/tPV5fp6E+SmODtfYIMp2CToff4jEs=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZIa-00Bdke-7x; Mon, 17 Aug 2020 09:11:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH v3 30/44] staging: regulator: hi6421v600-regulator: use shorter names for OF properties
Date:   Mon, 17 Aug 2020 09:10:49 +0200
Message-Id: <98f66100263940901ba59ec187919e9cf5e64f31.1597647359.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597647359.git.mchehab+huawei@kernel.org>
References: <cover.1597647359.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the names of the OF properties, in order to make
them similar to other drivers and to make easier to understand
what each property means.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../staging/hikey9xx/hi6421v600-regulator.c   | 52 ++++++++-----------
 1 file changed, 21 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index 2d1096ecb277..e4a64893a7ad 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
@@ -196,14 +196,14 @@ static int hisi_regulator_set_mode(struct regulator_dev *rdev,
 {
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
 	struct hisi_pmic *pmic = sreg->pmic;
-	u32 eco_mode;
+	u32 val;
 
 	switch (mode) {
 	case REGULATOR_MODE_NORMAL:
-		eco_mode = HISI_ECO_MODE_DISABLE;
+		val = 0;
 		break;
 	case REGULATOR_MODE_IDLE:
-		eco_mode = HISI_ECO_MODE_ENABLE;
+		val = sreg->eco_mode_mask << (ffs(sreg->eco_mode_mask) - 1);
 		break;
 	default:
 		return -EINVAL;
@@ -211,15 +211,12 @@ static int hisi_regulator_set_mode(struct regulator_dev *rdev,
 
 	/* set mode */
 	hisi_pmic_rmw(pmic, rdev->desc->enable_reg,
-		      sreg->eco_mode_mask,
-		eco_mode << (ffs(sreg->eco_mode_mask) - 1));
+		      sreg->eco_mode_mask, val);
 
 	dev_dbg(&rdev->dev,
 		"%s: enable_reg=0x%x, eco_mode_mask=0x%x, value=0x%x\n",
-		 __func__,
-		rdev->desc->enable_reg,
-		sreg->eco_mode_mask,
-		eco_mode << (ffs(sreg->eco_mode_mask) - 1));
+		 __func__, rdev->desc->enable_reg, sreg->eco_mode_mask, val);
+
 	return 0;
 }
 
@@ -249,10 +246,10 @@ static int hisi_dt_parse(struct platform_device *pdev,
 	int ret;
 
 	/* parse .register_info.enable_reg */
-	ret = of_property_read_u32_array(np, "hisilicon,hisi-ctrl",
+	ret = of_property_read_u32_array(np, "hi6421-ctrl",
 					 register_info, 3);
 	if (ret) {
-		dev_err(dev, "no hisilicon,hisi-ctrl property set\n");
+		dev_err(dev, "no hi6421-ctrl property set\n");
 		return ret;
 	}
 	rdesc->enable_reg = register_info[0];
@@ -260,33 +257,33 @@ static int hisi_dt_parse(struct platform_device *pdev,
 	sreg->eco_mode_mask = register_info[2];
 
 	/* parse .register_info.vsel_reg */
-	ret = of_property_read_u32_array(np, "hisilicon,hisi-vset",
+	ret = of_property_read_u32_array(np, "hi6421-vsel",
 					 register_info, 2);
 	if (ret) {
-		dev_err(dev, "no hisilicon,hisi-vset property set\n");
+		dev_err(dev, "no hi6421-vsel property set\n");
 		return ret;
 	}
 	rdesc->vsel_reg = register_info[0];
 	rdesc->vsel_mask = register_info[1];
 
 	/* parse .off-on-delay */
-	ret = of_property_read_u32(np, "hisilicon,hisi-off-on-delay-us",
+	ret = of_property_read_u32(np, "off-on-delay-us",
 				   &rdesc->off_on_delay);
 	if (ret) {
-		dev_err(dev, "no hisilicon,hisi-off-on-delay-us property set\n");
+		dev_err(dev, "no off-on-delay-us property set\n");
 		return ret;
 	}
 
 	/* parse .enable_time */
-	ret = of_property_read_u32(np, "hisilicon,hisi-enable-time-us",
+	ret = of_property_read_u32(np, "startup-delay-us",
 				   &rdesc->enable_time);
 	if (ret) {
-		dev_err(dev, "no hisilicon,hisi-enable-time-us property set\n");
+		dev_err(dev, "no startup-delay-us property set\n");
 		return ret;
 	}
 
 	/* parse .eco_uA */
-	ret = of_property_read_u32(np, "hisilicon,hisi-eco-microamp",
+	ret = of_property_read_u32(np, "eco-microamp",
 				   &sreg->eco_uA);
 	if (ret) {
 		sreg->eco_uA = 0;
@@ -295,7 +292,7 @@ static int hisi_dt_parse(struct platform_device *pdev,
 
 	/* parse volt_table */
 
-	rdesc->n_voltages = of_property_count_u32_elems(np, "hisilicon,hisi-vset-table");
+	rdesc->n_voltages = of_property_count_u32_elems(np, "voltage-table");
 
 	v_table = devm_kzalloc(dev, sizeof(unsigned int) * rdesc->n_voltages,
 			       GFP_KERNEL);
@@ -303,10 +300,10 @@ static int hisi_dt_parse(struct platform_device *pdev,
 		return  -ENOMEM;
 	rdesc->volt_table = v_table;
 
-	ret = of_property_read_u32_array(np, "hisilicon,hisi-vset-table",
+	ret = of_property_read_u32_array(np, "voltage-table",
 					 v_table, rdesc->n_voltages);
 	if (ret) {
-		dev_err(dev, "no hisilicon,hisi-vset-table property set\n");
+		dev_err(dev, "no voltage-table property set\n");
 		return ret;
 	}
 
@@ -329,13 +326,6 @@ static struct regulator_ops hisi_ldo_rops = {
  * Used only for parsing the DT properties
  */
 
-static const struct of_device_id of_hisi_pmic_match_tbl[] = {
-	{
-		.compatible = "hisilicon,hi6421-spmi-pmic-ldo",
-	},
-	{ }
-};
-
 static int hisi_regulator_probe_ldo(struct platform_device *pdev,
 				    struct device_node *np,
 				    struct hisi_pmic *pmic)
@@ -360,14 +350,14 @@ static int hisi_regulator_probe_ldo(struct platform_device *pdev,
 	/* hisi regulator supports two modes */
 	constraint = &initdata->constraints;
 
-	ret = of_property_read_u32_array(np, "hisilicon,valid-modes-mask",
+	ret = of_property_read_u32_array(np, "valid-modes-mask",
 					 &constraint->valid_modes_mask, 1);
 	if (ret) {
 		dev_err(dev, "no valid modes mask\n");
 		ret = -ENODEV;
 		return ret;
 	}
-	ret = of_property_read_u32_array(np, "hisilicon,valid-idle-mask",
+	ret = of_property_read_u32_array(np, "valid-idle-mask",
 					 &temp_modes, 1);
 	if (ret) {
 		dev_err(dev, "no valid idle mask\n");
@@ -388,7 +378,7 @@ static int hisi_regulator_probe_ldo(struct platform_device *pdev,
 	rdesc->type = REGULATOR_VOLTAGE;
 	rdesc->min_uV = initdata->constraints.min_uV;
 
-	supplyname = of_get_property(np, "hisilicon,supply_name", NULL);
+	supplyname = of_get_property(np, "supply_name", NULL);
 	if (supplyname)
 		initdata->supply_regulator = supplyname;
 
-- 
2.26.2

