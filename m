Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD32C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A54972083B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597160571;
	bh=f5rNKeRTiDhWxwYQ8lCA5VoC9IYtrTSkweFnxXW5rHw=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=JSDn3g+K+tfp1BIvknT3Izbuv38e7YGGrI9BLvWj4MqPH3XOdQFYzVdAk+2DbWocR
	 5qspAVj7UI0IBSZm4hkbA+6ghZ2Pyvq9KeQCRxv7IvEjrbNBMO4HLI0xq1yfG0zk+L
	 MfMp1vegjFsLsEvhp5Vwkaqq085hCidb7Nc3SNlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgHKPmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729031AbgHKPmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:42:09 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3558222B4B;
        Tue, 11 Aug 2020 15:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160524;
        bh=f5rNKeRTiDhWxwYQ8lCA5VoC9IYtrTSkweFnxXW5rHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f3UJqPZypXKfNyzzRwFd5ZAuj5HtA99oU+vhbFl+MK/D6OvnkdzTAHkCT94gsdG1A
         AoVur4x58NCqRpGGE/S6MA//LN4lOB2/XwajRp1dy5MI4fQ+8vbS2Pok6/PzR7Uw2e
         3lcuZXEGCgRwz/Pxx43EwOAHSIppgkohIPDx4bss=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5WPa-004bnb-AI; Tue, 11 Aug 2020 17:42:02 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 29/33] regulator: hi6421v600-regulator: cleanup DT settings
Date:   Tue, 11 Aug 2020 17:41:55 +0200
Message-Id: <744ca4c1aa64feda785fc9ce7c8a375079d92886.1597160086.git.mchehab+huawei@kernel.org>
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

Currently, an array is used to store both vsel and enable
settings, mixing registers, masks and bit settings.

Change it in order to have one separate property for each.

This makes easier to understand the contents of the DT
file, and to describe it at the Documentation/.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/regulator/hi6421v600-regulator.c | 69 ++++++++++++++----------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index 21467fce9980..72f51594b5ff 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
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

