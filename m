Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDB3C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDBB2207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597247887;
	bh=vGosXmStFqBqsvu6v4zgK+x2NCOWHs5Iy+l8WTm4Zc8=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=cFOcVVBWwmT5ri8/2aPTfFYZ8SSt4wOrnGF+NPLw998SrdsGMLgRFyOsmB5JO3nZc
	 zMn1GIEQ7p1vKj5lZPpNP5IZk2L+LZgsWua5faZX8B6MU2caSMzMBqC6OB4w/R9Gal
	 XM7NvO+T4kFVH1DYvhQBhlfswjG7Sk4By1K0QnZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgHLP6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:58:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbgHLP5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:05 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 126EF22EBF;
        Wed, 12 Aug 2020 15:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247821;
        bh=vGosXmStFqBqsvu6v4zgK+x2NCOWHs5Iy+l8WTm4Zc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PH1xDpSN8xV7rdAR1KlDqcxzjbZtzLv1IK+QHYNtBancb/hvyUHCGC7JLBHL0eHB6
         rUPwdcIHjjaA6Rz2AcxY76w45Ey1x2RiQYch08yiGR4edwg3ciAxCLgO/fTRu5ckJ6
         bR16XwGOQvKvvA16Z6efJTdbqan/P9OlDxKxFUsM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7b-005t7I-84; Wed, 12 Aug 2020 17:56:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 37/44] staging: regulator: hi6421v600-regulator: cleanup DT settings
Date:   Wed, 12 Aug 2020 17:56:47 +0200
Message-Id: <b73be90e0496dec1735fe706a53705fb5587059d.1597247164.git.mchehab+huawei@kernel.org>
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

Currently, an array is used to store both vsel and enable
settings, mixing registers, masks and bit settings.

Change it in order to have one separate property for each.

This makes easier to understand the contents of the DT
file, and to describe it at the Documentation/.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../staging/hikey9xx/hi6421v600-regulator.c   | 69 +++++++++++--------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index 21467fce9980..72f51594b5ff 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
@@ -45,8 +45,7 @@
 struct hi6421v600_regulator {
 	struct regulator_desc rdesc;
 	struct hi6421_spmi_pmic *pmic;
-	u8 eco_mode_mask;
-	u32 eco_uA;
+	u32 eco_mode_mask, eco_uA;
 };
 
 static DEFINE_MUTEX(enable_mutex);
@@ -226,36 +225,49 @@ static int hi6421_spmi_dt_parse(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	unsigned int register_info[3] = {0};
 	unsigned int *v_table;
 	int ret;
 
-	/* parse .register_info.enable_reg */
-	ret = of_property_read_u32_array(np, "hi6421-ctrl",
-					 register_info, 3);
+	ret = of_property_read_u32(np, "reg", &rdesc->enable_reg);
 	if (ret) {
-		dev_err(dev, "no hi6421-ctrl property set\n");
+		dev_err(dev, "missing reg property\nn");
 		return ret;
 	}
-	rdesc->enable_reg = register_info[0];
-	rdesc->enable_mask = register_info[1];
-	sreg->eco_mode_mask = register_info[2];
 
-	/* parse .register_info.vsel_reg */
-	ret = of_property_read_u32_array(np, "hi6421-vsel",
-					 register_info, 2);
+	ret = of_property_read_u32(np, "vsel-reg", &rdesc->vsel_reg);
 	if (ret) {
-		dev_err(dev, "no hi6421-vsel property set\n");
+		dev_err(dev, "missing vsel-reg property\n");
 		return ret;
 	}
-	rdesc->vsel_reg = register_info[0];
-	rdesc->vsel_mask = register_info[1];
+
+	ret = of_property_read_u32(np, "enable-mask", &rdesc->enable_mask);
+	if (ret) {
+		dev_err(dev, "missing enable-mask property\n");
+		return ret;
+	}
+
+	/*
+	 * Not all regulators work on idle mode
+	 */
+	ret = of_property_read_u32(np, "idle-mode-mask", &sreg->eco_mode_mask);
+	if (ret) {
+		dev_dbg(dev, "LDO doesn't support economy mode.\n");
+		sreg->eco_mode_mask = 0;
+		sreg->eco_uA = 0;
+	} else {
+		ret = of_property_read_u32(np, "eco-microamp",
+					&sreg->eco_uA);
+		if (ret) {
+			dev_err(dev, "missing eco-microamp property\n");
+			return ret;
+		}
+	}
 
 	/* parse .off-on-delay */
 	ret = of_property_read_u32(np, "off-on-delay-us",
 				   &rdesc->off_on_delay);
 	if (ret) {
-		dev_err(dev, "no off-on-delay-us property set\n");
+		dev_err(dev, "missing off-on-delay-us property\n");
 		return ret;
 	}
 
@@ -263,21 +275,13 @@ static int hi6421_spmi_dt_parse(struct platform_device *pdev,
 	ret = of_property_read_u32(np, "startup-delay-us",
 				   &rdesc->enable_time);
 	if (ret) {
-		dev_err(dev, "no startup-delay-us property set\n");
+		dev_err(dev, "missing startup-delay-us property\n");
 		return ret;
 	}
 
 	/* FIXME: are there a better value for this? */
 	rdesc->ramp_delay = rdesc->enable_time;
 
-	/* parse .eco_uA */
-	ret = of_property_read_u32(np, "eco-microamp",
-				   &sreg->eco_uA);
-	if (ret) {
-		sreg->eco_uA = 0;
-		ret = 0;
-	}
-
 	/* parse volt_table */
 
 	rdesc->n_voltages = of_property_count_u32_elems(np, "voltage-table");
@@ -291,10 +295,21 @@ static int hi6421_spmi_dt_parse(struct platform_device *pdev,
 	ret = of_property_read_u32_array(np, "voltage-table",
 					 v_table, rdesc->n_voltages);
 	if (ret) {
-		dev_err(dev, "no voltage-table property set\n");
+		dev_err(dev, "missing voltage-table property\n");
 		return ret;
 	}
 
+	/*
+	 * Instead of explicitly requiring a mask for the voltage selector,
+	 * as they all start from bit zero (at least on the known LDOs),
+	 * just use the number of voltages at the voltage table, getting the
+	 * minimal mask that would pick everything.
+	 */
+	rdesc->vsel_mask = (1 << (fls(rdesc->n_voltages) - 1)) - 1;
+
+	dev_dbg(dev, "voltage selector settings: reg: 0x%x, mask: 0x%x",
+		rdesc->vsel_reg, rdesc->vsel_mask);
+
 	return 0;
 }
 
-- 
2.26.2

