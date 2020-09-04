Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A4DC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 002862087C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599215152;
	bh=P5xkN8PmDWM1AkyGGJIfWbrQnD51SoBF+MSMoAA8Lys=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=ZEEdz1aIynM4GqsqB9Xtud/vicrrAdAcRPGq2ZW5koe2uyGMZg6qv2vyflu0AXqaC
	 PRJUuUdpOioV/QF3Q4ynnJk/GFDYUPtU2Zht6TeJhPHebqN0GbhBkMiAahIQo9W5vB
	 TbXfqG10jYr7lTlTBjuwbrE/cnOc8V+e2zws0zZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgIDKZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729998AbgIDKXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:23:38 -0400
Received: from mail.kernel.org (ip5f5ad59b.dynamic.kabel-deutschland.de [95.90.213.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2BB42087C;
        Fri,  4 Sep 2020 10:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599215016;
        bh=P5xkN8PmDWM1AkyGGJIfWbrQnD51SoBF+MSMoAA8Lys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gmg0LHDh/rvsQ22ZoubN1z5GimZxcvwXd93TF6nH45rR0iuRWl/y+fSr8Pm+aKZ4/
         ON6Ay6QhTsrg6V/fdH4IoSvvTRB6/swiUKcom3UDgtLQ8CAmc5D8kqY2uHcvu7c1zS
         4FfaJASTl+vc4RhTQVz3vL3/xlRNKyUoYxESCLAU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kE8sX-005SvE-PV; Fri, 04 Sep 2020 12:23:33 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Yu Chen <chenyu56@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC 04/10] phy: hisilicon: phy-hi3670-usb3: fix coding style
Date:   Fri,  4 Sep 2020 12:23:26 +0200
Message-Id: <5df5d840bf169d6d87ff34e44c94d937775b2f41.1599214329.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599214329.git.mchehab+huawei@kernel.org>
References: <cover.1599214329.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address the issues reported by checkpatch --strict,
and add a SPDX tag.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/phy/hisilicon/phy-hi3670-usb3.c | 157 ++++++++++++------------
 1 file changed, 76 insertions(+), 81 deletions(-)

diff --git a/drivers/phy/hisilicon/phy-hi3670-usb3.c b/drivers/phy/hisilicon/phy-hi3670-usb3.c
index fd679b39185a..cb0bfcbbfbfa 100644
--- a/drivers/phy/hisilicon/phy-hi3670-usb3.c
+++ b/drivers/phy/hisilicon/phy-hi3670-usb3.c
@@ -1,28 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Phy provider for USB 3.1 controller on HiSilicon Kirin970 platform
  *
- * Copyright (C) 2017-2018 Hilisicon Electronics Co., Ltd.
+ * Copyright (C) 2017-2020 Hilisicon Electronics Co., Ltd.
  *		http://www.huawei.com
  *
  * Authors: Yu Chen <chenyu56@huawei.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2  of
- * the License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
+#include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/phy/phy.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/clk.h>
 
 #define SCTRL_SCDEEPSLEEPED		(0x0)
 #define USB_CLK_SELECTED		BIT(20)
@@ -116,7 +108,7 @@
 #define TCPC_VALID			BIT(4)
 #define TCPC_LOW_POWER_EN		BIT(3)
 #define TCPC_MUX_CONTROL_MASK		(3 << 0)
-#define TCPC_MUX_CONTROL_USB31		(1 << 0)
+#define TCPC_MUX_CONTROL_USB31		BIT(0)
 
 #define SYSMODE_CFG_TYPEC_DISABLE	BIT(3)
 
@@ -151,13 +143,13 @@ static int hi3670_phy_cr_clk(struct regmap *usb31misc)
 
 	/* Clock up */
 	ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
-			CFG54_USB31PHY_CR_CLK, CFG54_USB31PHY_CR_CLK);
+				 CFG54_USB31PHY_CR_CLK, CFG54_USB31PHY_CR_CLK);
 	if (ret)
 		return ret;
 
 	/* Clock down */
 	ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
-			CFG54_USB31PHY_CR_CLK, 0);
+				 CFG54_USB31PHY_CR_CLK, 0);
 
 	return ret;
 }
@@ -165,7 +157,7 @@ static int hi3670_phy_cr_clk(struct regmap *usb31misc)
 static int hi3670_phy_cr_set_sel(struct regmap *usb31misc)
 {
 	return regmap_update_bits(usb31misc, USB_MISC_CFG54,
-			CFG54_USB31PHY_CR_SEL, CFG54_USB31PHY_CR_SEL);
+				  CFG54_USB31PHY_CR_SEL, CFG54_USB31PHY_CR_SEL);
 }
 
 static int hi3670_phy_cr_start(struct regmap *usb31misc, int direction)
@@ -174,10 +166,12 @@ static int hi3670_phy_cr_start(struct regmap *usb31misc, int direction)
 
 	if (direction)
 		ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
-			CFG54_USB31PHY_CR_WR_EN, CFG54_USB31PHY_CR_WR_EN);
+					 CFG54_USB31PHY_CR_WR_EN,
+					 CFG54_USB31PHY_CR_WR_EN);
 	else
 		ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
-			CFG54_USB31PHY_CR_RD_EN, CFG54_USB31PHY_CR_RD_EN);
+					 CFG54_USB31PHY_CR_RD_EN,
+					 CFG54_USB31PHY_CR_RD_EN);
 
 	if (ret)
 		return ret;
@@ -187,7 +181,7 @@ static int hi3670_phy_cr_start(struct regmap *usb31misc, int direction)
 		return ret;
 
 	ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
-			CFG54_USB31PHY_CR_RD_EN | CFG54_USB31PHY_CR_WR_EN, 0);
+				 CFG54_USB31PHY_CR_RD_EN | CFG54_USB31PHY_CR_WR_EN, 0);
 
 	return ret;
 }
@@ -223,8 +217,7 @@ static int hi3670_phy_cr_set_addr(struct regmap *usb31misc, u32 addr)
 		return ret;
 
 	reg &= ~(CFG54_USB31PHY_CR_ADDR_MASK << CFG54_USB31PHY_CR_ADDR_SHIFT);
-	reg |= ((addr & CFG54_USB31PHY_CR_ADDR_MASK) <<
-			CFG54_USB31PHY_CR_ADDR_SHIFT);
+	reg |= ((addr & CFG54_USB31PHY_CR_ADDR_MASK) << CFG54_USB31PHY_CR_ADDR_SHIFT);
 	ret = regmap_write(usb31misc, USB_MISC_CFG54, reg);
 
 	return ret;
@@ -288,7 +281,7 @@ static int hi3670_phy_cr_write(struct regmap *usb31misc, u32 addr, u32 val)
 		return ret;
 
 	ret = regmap_write(usb31misc, USB_MISC_CFG58,
-			val & CFG58_USB31PHY_CR_DATA_MASK);
+			   val & CFG58_USB31PHY_CR_DATA_MASK);
 	if (ret)
 		return ret;
 
@@ -308,7 +301,7 @@ static int hi3670_phy_set_params(struct hi3670_priv *priv)
 	int retry = 3;
 
 	ret = regmap_write(priv->usb31misc, USB3OTG_CTRL4,
-			priv->eye_diagram_param);
+			   priv->eye_diagram_param);
 	if (ret) {
 		dev_err(priv->dev, "set USB3OTG_CTRL4 failed\n");
 		return ret;
@@ -316,10 +309,11 @@ static int hi3670_phy_set_params(struct hi3670_priv *priv)
 
 	while (retry-- > 0) {
 		ret = hi3670_phy_cr_read(priv->usb31misc,
-				TX_VBOOST_LVL_REG, &reg);
+					 TX_VBOOST_LVL_REG, &reg);
 		if (!ret)
 			break;
-		else if (ret != -ETIMEDOUT) {
+
+		if (ret != -ETIMEDOUT) {
 			dev_err(priv->dev, "read TX_VBOOST_LVL_REG failed\n");
 			return ret;
 		}
@@ -327,8 +321,7 @@ static int hi3670_phy_set_params(struct hi3670_priv *priv)
 	if (ret)
 		return ret;
 
-	reg |= (TX_VBOOST_LVL_ENABLE |
-			(priv->tx_vboost_lvl << TX_VBOOST_LVL_START));
+	reg |= (TX_VBOOST_LVL_ENABLE | (priv->tx_vboost_lvl << TX_VBOOST_LVL_START));
 	ret = hi3670_phy_cr_write(priv->usb31misc, TX_VBOOST_LVL_REG, reg);
 	if (ret)
 		dev_err(priv->dev, "write TX_VBOOST_LVL_REG failed\n");
@@ -364,24 +357,24 @@ static int hi3670_config_phy_clock(struct hi3670_priv *priv)
 	if (hi3670_is_abbclk_seleted(priv)) {
 		/* usb refclk iso disable */
 		ret = regmap_write(priv->peri_crg, PERI_CRG_ISODIS,
-				USB_REFCLK_ISO_EN);
+				   USB_REFCLK_ISO_EN);
 		if (ret)
 			goto out;
 
 		/* enable usb_tcxo_en */
 		ret = regmap_write(priv->pctrl, PCTRL_PERI_CTRL3,
-				USB_TCXO_EN |
-				(USB_TCXO_EN << PCTRL_PERI_CTRL3_MSK_START));
+				   USB_TCXO_EN |
+				   (USB_TCXO_EN << PCTRL_PERI_CTRL3_MSK_START));
 
 		/* select usbphy clk from abb */
 		mask = SC_CLK_USB3PHY_3MUX1_SEL;
 		ret = regmap_update_bits(priv->pctrl,
-				PCTRL_PERI_CTRL24, mask, 0);
+					 PCTRL_PERI_CTRL24, mask, 0);
 		if (ret)
 			goto out;
 
 		ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFGA0,
-				CFGA0_USB2PHY_REFCLK_SELECT, 0);
+					 CFGA0_USB2PHY_REFCLK_SELECT, 0);
 		if (ret)
 			goto out;
 
@@ -393,34 +386,36 @@ static int hi3670_config_phy_clock(struct hi3670_priv *priv)
 		ret = regmap_write(priv->usb31misc, USB3OTG_CTRL7, val);
 		if (ret)
 			goto out;
-	} else {
-		ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFG54,
-				CFG54_USB3PHY_REF_USE_PAD,
-				CFG54_USB3PHY_REF_USE_PAD);
-		if (ret)
-			goto out;
 
-		ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFGA0,
-				CFGA0_USB2PHY_REFCLK_SELECT,
-				CFGA0_USB2PHY_REFCLK_SELECT);
-		if (ret)
-			goto out;
-
-		ret = regmap_read(priv->usb31misc, USB3OTG_CTRL7, &val);
-		if (ret)
-			goto out;
-		val &= ~CTRL7_USB2_REFCLKSEL_MASK;
-		val |= CTRL7_USB2_REFCLKSEL_PAD;
-		ret = regmap_write(priv->usb31misc, USB3OTG_CTRL7, val);
-		if (ret)
-			goto out;
-
-		ret = regmap_write(priv->peri_crg,
-				PERI_CRG_PEREN6, GT_CLK_USB2PHY_REF);
-		if (ret)
-			goto out;
+		return 0;
 	}
 
+	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFG54,
+				 CFG54_USB3PHY_REF_USE_PAD,
+				 CFG54_USB3PHY_REF_USE_PAD);
+	if (ret)
+		goto out;
+
+	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFGA0,
+				 CFGA0_USB2PHY_REFCLK_SELECT,
+				 CFGA0_USB2PHY_REFCLK_SELECT);
+	if (ret)
+		goto out;
+
+	ret = regmap_read(priv->usb31misc, USB3OTG_CTRL7, &val);
+	if (ret)
+		goto out;
+	val &= ~CTRL7_USB2_REFCLKSEL_MASK;
+	val |= CTRL7_USB2_REFCLKSEL_PAD;
+	ret = regmap_write(priv->usb31misc, USB3OTG_CTRL7, val);
+	if (ret)
+		goto out;
+
+	ret = regmap_write(priv->peri_crg,
+			   PERI_CRG_PEREN6, GT_CLK_USB2PHY_REF);
+	if (ret)
+		goto out;
+
 	return 0;
 out:
 	dev_err(priv->dev, "failed to config phy clock ret: %d\n", ret);
@@ -437,7 +432,7 @@ static int hi3670_config_tca(struct hi3670_priv *priv)
 		goto out;
 
 	ret = regmap_write(priv->usb31misc, TCA_INTR_EN,
-			INTR_EN_XA_TIMEOUT_EVT_EN | INTR_EN_XA_ACK_EVT_EN);
+			   INTR_EN_XA_TIMEOUT_EVT_EN | INTR_EN_XA_ACK_EVT_EN);
 	if (ret)
 		goto out;
 
@@ -447,13 +442,13 @@ static int hi3670_config_tca(struct hi3670_priv *priv)
 		goto out;
 
 	ret = regmap_update_bits(priv->usb31misc, TCA_GCFG,
-			GCFG_ROLE_HSTDEV | GCFG_OP_MODE,
-			GCFG_ROLE_HSTDEV | GCFG_OP_MODE_CTRL_SYNC_MODE);
+				 GCFG_ROLE_HSTDEV | GCFG_OP_MODE,
+				 GCFG_ROLE_HSTDEV | GCFG_OP_MODE_CTRL_SYNC_MODE);
 	if (ret)
 		goto out;
 
 	ret = regmap_update_bits(priv->usb31misc, TCA_SYSMODE_CFG,
-			SYSMODE_CFG_TYPEC_DISABLE, 0);
+				 SYSMODE_CFG_TYPEC_DISABLE, 0);
 	if (ret)
 		goto out;
 
@@ -467,7 +462,7 @@ static int hi3670_config_tca(struct hi3670_priv *priv)
 		goto out;
 
 	ret = regmap_write(priv->usb31misc, TCA_VBUS_CTRL,
-		VBUS_CTRL_POWERPRESENT_OVERRD | VBUS_CTRL_VBUSVALID_OVERRD);
+			   VBUS_CTRL_POWERPRESENT_OVERRD | VBUS_CTRL_VBUSVALID_OVERRD);
 	if (ret)
 		goto out;
 
@@ -485,7 +480,7 @@ static int hi3670_phy_init(struct phy *phy)
 
 	/* assert controller */
 	val = CFGA0_VAUX_RESET | CFGA0_USB31C_RESET |
-		CFGA0_USB3PHY_RESET | CFGA0_USB2PHY_POR;
+	      CFGA0_USB3PHY_RESET | CFGA0_USB2PHY_POR;
 	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFGA0, val, 0);
 	if (ret)
 		goto out;
@@ -496,13 +491,13 @@ static int hi3670_phy_init(struct phy *phy)
 
 	/* Exit from IDDQ mode */
 	ret = regmap_update_bits(priv->usb31misc, USB3OTG_CTRL5,
-			CTRL5_USB2_SIDDQ, 0);
+				 CTRL5_USB2_SIDDQ, 0);
 	if (ret)
 		goto out;
 
 	/* Release USB31 PHY out of TestPowerDown mode */
 	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFG50,
-			CFG50_USB3_PHY_TEST_POWERDOWN, 0);
+				 CFG50_USB3_PHY_TEST_POWERDOWN, 0);
 	if (ret)
 		goto out;
 
@@ -512,13 +507,13 @@ static int hi3670_phy_init(struct phy *phy)
 	if (ret)
 		goto out;
 
-	udelay(100);
+	usleep_range(100, 120);
 
 	/* Tell the PHY power is stable */
 	val = CFG54_USB3_PHY0_ANA_PWR_EN | CFG54_PHY0_PCS_PWR_STABLE |
-		CFG54_PHY0_PMA_PWR_STABLE;
+	      CFG54_PHY0_PMA_PWR_STABLE;
 	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFG54,
-			val, val);
+				 val, val);
 	if (ret)
 		goto out;
 
@@ -528,8 +523,8 @@ static int hi3670_phy_init(struct phy *phy)
 
 	/* Enable SSC */
 	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFG5C,
-			CFG5C_USB3_PHY0_SS_MPLLA_SSC_EN,
-			CFG5C_USB3_PHY0_SS_MPLLA_SSC_EN);
+				 CFG5C_USB3_PHY0_SS_MPLLA_SSC_EN,
+				 CFG5C_USB3_PHY0_SS_MPLLA_SSC_EN);
 	if (ret)
 		goto out;
 
@@ -539,7 +534,7 @@ static int hi3670_phy_init(struct phy *phy)
 	if (ret)
 		goto out;
 
-	udelay(100);
+	usleep_range(100, 120);
 
 	/* Set fake vbus valid signal */
 	val = CTRL0_USB3_VBUSVLD | CTRL0_USB3_VBUSVLD_SEL;
@@ -552,7 +547,7 @@ static int hi3670_phy_init(struct phy *phy)
 	if (ret)
 		goto out;
 
-	udelay(100);
+	usleep_range(100, 120);
 
 	ret = hi3670_phy_set_params(priv);
 	if (ret)
@@ -579,10 +574,10 @@ static int hi3670_phy_exit(struct phy *phy)
 	if (hi3670_is_abbclk_seleted(priv)) {
 		/* disable usb_tcxo_en */
 		ret = regmap_write(priv->pctrl, PCTRL_PERI_CTRL3,
-				USB_TCXO_EN << PCTRL_PERI_CTRL3_MSK_START);
+				   USB_TCXO_EN << PCTRL_PERI_CTRL3_MSK_START);
 	} else {
 		ret = regmap_write(priv->peri_crg, PERI_CRG_PERDIS6,
-				GT_CLK_USB2PHY_REF);
+				   GT_CLK_USB2PHY_REF);
 		if (ret)
 			goto out;
 	}
@@ -612,39 +607,39 @@ static int hi3670_phy_probe(struct platform_device *pdev)
 
 	priv->dev = dev;
 	priv->peri_crg = syscon_regmap_lookup_by_phandle(dev->of_node,
-					"hisilicon,pericrg-syscon");
+							 "hisilicon,pericrg-syscon");
 	if (IS_ERR(priv->peri_crg)) {
 		dev_err(dev, "no hisilicon,pericrg-syscon\n");
 		return PTR_ERR(priv->peri_crg);
 	}
 
 	priv->pctrl = syscon_regmap_lookup_by_phandle(dev->of_node,
-					"hisilicon,pctrl-syscon");
+						      "hisilicon,pctrl-syscon");
 	if (IS_ERR(priv->pctrl)) {
 		dev_err(dev, "no hisilicon,pctrl-syscon\n");
 		return PTR_ERR(priv->pctrl);
 	}
 
 	priv->sctrl = syscon_regmap_lookup_by_phandle(dev->of_node,
-					"hisilicon,sctrl-syscon");
+						      "hisilicon,sctrl-syscon");
 	if (IS_ERR(priv->sctrl)) {
 		dev_err(dev, "no hisilicon,sctrl-syscon\n");
 		return PTR_ERR(priv->sctrl);
 	}
 
 	priv->usb31misc = syscon_regmap_lookup_by_phandle(dev->of_node,
-					"hisilicon,usb31-misc-syscon");
+							  "hisilicon,usb31-misc-syscon");
 	if (IS_ERR(priv->usb31misc)) {
 		dev_err(dev, "no hisilicon,usb31-misc-syscon\n");
 		return PTR_ERR(priv->usb31misc);
 	}
 
 	if (of_property_read_u32(dev->of_node, "eye-diagram-param",
-				&(priv->eye_diagram_param)))
+				 &priv->eye_diagram_param))
 		priv->eye_diagram_param = KIRIN970_USB_DEFAULT_PHY_PARAM;
 
 	if (of_property_read_u32(dev->of_node, "usb3-phy-tx-vboost-lvl",
-				&(priv->tx_vboost_lvl)))
+				 &priv->tx_vboost_lvl))
 		priv->eye_diagram_param = KIRIN970_USB_DEFAULT_PHY_VBOOST;
 
 	phy = devm_phy_create(dev, NULL, &hi3670_phy_ops);
@@ -657,7 +652,7 @@ static int hi3670_phy_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id hi3670_phy_of_match[] = {
-	{.compatible = "hisilicon,hi3670-usb-phy",},
+	{ .compatible = "hisilicon,hi3670-usb-phy" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, hi3670_phy_of_match);
-- 
2.26.2

