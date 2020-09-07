Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E24C2BB84
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F572087D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599494528;
	bh=dESNgHq0mJtVPRbaRaMjf97WeJnyxn/0wfLlTJIH4/A=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=u11cfhux7vj5L8BeXBENDSyxP3WXBOMiIjuXTUkUh0FWVZhv+wIER+MnIbo1qnTU1
	 TXcK/L4AY0+AA0JzKnphYojo0GkdF3d4GZrTK9iyq16lZ8RDsRNnCtYwuIOo8SBaI6
	 qthGW+bqCTQdrEIxv/F64oCjrdcChtL4hynitAZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgIGQCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730060AbgIGQAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:00:19 -0400
Received: from mail.kernel.org (ip5f5ad5cf.dynamic.kabel-deutschland.de [95.90.213.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FCAA217A0;
        Mon,  7 Sep 2020 15:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599494379;
        bh=dESNgHq0mJtVPRbaRaMjf97WeJnyxn/0wfLlTJIH4/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5ACPZ6DtV6hIWpLBcX61vEQY5F/yET78dNskKtUkw0jLS4jDsVL8z2Z9w6hDAuhK
         3vYKiEEZhEZzGRVsVQ/hjRiD4AwSjIfX5Yyvr78+09YzM0jFI3GMx522hB+j77oWJ8
         FVFyoGs42RNtNKM2r9OsUEFk2bKypsWu8xPObC6k=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kFJYP-00ATul-6o; Mon, 07 Sep 2020 17:59:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yu Chen <chenyu56@huawei.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 03/11] phy: hisilicon: phy-hi3670-usb3: use a consistent namespace
Date:   Mon,  7 Sep 2020 17:59:27 +0200
Message-Id: <b025e362ab119ca5321e7a3754ee9ee73a6e1fbd.1599493845.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599493845.git.mchehab+huawei@kernel.org>
References: <cover.1599493845.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename hikey970 to hi3670, in order to use a namespace
similar to hi3660 driver.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bindings/phy/phy-hi3670-usb3.txt          |  4 +-
 drivers/phy/hisilicon/phy-hi3670-usb3.c       | 98 +++++++++----------
 2 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
index 4cb02612ff23..2fb27cb8beaf 100644
--- a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
+++ b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
@@ -2,7 +2,7 @@ Hisilicon Kirin970 usb PHY
 -----------------------
 
 Required properties:
-- compatible: should be "hisilicon,kirin970-usb-phy"
+- compatible: should be "hisilicon,hi3670-usb-phy"
 - #phy-cells: must be 0
 - hisilicon,pericrg-syscon: phandle of syscon used to control phy.
 - hisilicon,pctrl-syscon: phandle of syscon used to control phy.
@@ -14,7 +14,7 @@ Refer to phy/phy-bindings.txt for the generic PHY binding properties
 
 Example:
 	usb_phy: usbphy {
-		compatible = "hisilicon,kirin970-usb-phy";
+		compatible = "hisilicon,hi3670-usb-phy";
 		#phy-cells = <0>;
 		hisilicon,pericrg-syscon = <&crg_ctrl>;
 		hisilicon,pctrl-syscon = <&pctrl>;
diff --git a/drivers/phy/hisilicon/phy-hi3670-usb3.c b/drivers/phy/hisilicon/phy-hi3670-usb3.c
index 1d4caf7a2aaf..fd679b39185a 100644
--- a/drivers/phy/hisilicon/phy-hi3670-usb3.c
+++ b/drivers/phy/hisilicon/phy-hi3670-usb3.c
@@ -130,7 +130,7 @@
 #define TX_VBOOST_LVL_START		(6)
 #define TX_VBOOST_LVL_ENABLE		BIT(9)
 
-struct kirin970_priv {
+struct hi3670_priv {
 	struct device *dev;
 	struct regmap *peri_crg;
 	struct regmap *pctrl;
@@ -145,7 +145,7 @@ struct kirin970_priv {
 	u32 usb31misc_offset;
 };
 
-static int kirin970_phy_cr_clk(struct regmap *usb31misc)
+static int hi3670_phy_cr_clk(struct regmap *usb31misc)
 {
 	int ret;
 
@@ -162,13 +162,13 @@ static int kirin970_phy_cr_clk(struct regmap *usb31misc)
 	return ret;
 }
 
-static int kirin970_phy_cr_set_sel(struct regmap *usb31misc)
+static int hi3670_phy_cr_set_sel(struct regmap *usb31misc)
 {
 	return regmap_update_bits(usb31misc, USB_MISC_CFG54,
 			CFG54_USB31PHY_CR_SEL, CFG54_USB31PHY_CR_SEL);
 }
 
-static int kirin970_phy_cr_start(struct regmap *usb31misc, int direction)
+static int hi3670_phy_cr_start(struct regmap *usb31misc, int direction)
 {
 	int ret;
 
@@ -182,7 +182,7 @@ static int kirin970_phy_cr_start(struct regmap *usb31misc, int direction)
 	if (ret)
 		return ret;
 
-	ret = kirin970_phy_cr_clk(usb31misc);
+	ret = hi3670_phy_cr_clk(usb31misc);
 	if (ret)
 		return ret;
 
@@ -192,7 +192,7 @@ static int kirin970_phy_cr_start(struct regmap *usb31misc, int direction)
 	return ret;
 }
 
-static int kirin970_phy_cr_wait_ack(struct regmap *usb31misc)
+static int hi3670_phy_cr_wait_ack(struct regmap *usb31misc)
 {
 	u32 reg;
 	int retry = 100000;
@@ -205,7 +205,7 @@ static int kirin970_phy_cr_wait_ack(struct regmap *usb31misc)
 		if ((reg & CFG54_USB31PHY_CR_ACK) == CFG54_USB31PHY_CR_ACK)
 			return 0;
 
-		ret = kirin970_phy_cr_clk(usb31misc);
+		ret = hi3670_phy_cr_clk(usb31misc);
 		if (ret)
 			return ret;
 	}
@@ -213,7 +213,7 @@ static int kirin970_phy_cr_wait_ack(struct regmap *usb31misc)
 	return -ETIMEDOUT;
 }
 
-static int kirin970_phy_cr_set_addr(struct regmap *usb31misc, u32 addr)
+static int hi3670_phy_cr_set_addr(struct regmap *usb31misc, u32 addr)
 {
 	u32 reg;
 	int ret;
@@ -230,31 +230,31 @@ static int kirin970_phy_cr_set_addr(struct regmap *usb31misc, u32 addr)
 	return ret;
 }
 
-static int kirin970_phy_cr_read(struct regmap *usb31misc, u32 addr, u32 *val)
+static int hi3670_phy_cr_read(struct regmap *usb31misc, u32 addr, u32 *val)
 {
 	int reg;
 	int i;
 	int ret;
 
 	for (i = 0; i < 100; i++) {
-		ret = kirin970_phy_cr_clk(usb31misc);
+		ret = hi3670_phy_cr_clk(usb31misc);
 		if (ret)
 			return ret;
 	}
 
-	ret = kirin970_phy_cr_set_sel(usb31misc);
+	ret = hi3670_phy_cr_set_sel(usb31misc);
 	if (ret)
 		return ret;
 
-	ret = kirin970_phy_cr_set_addr(usb31misc, addr);
+	ret = hi3670_phy_cr_set_addr(usb31misc, addr);
 	if (ret)
 		return ret;
 
-	ret = kirin970_phy_cr_start(usb31misc, 0);
+	ret = hi3670_phy_cr_start(usb31misc, 0);
 	if (ret)
 		return ret;
 
-	ret = kirin970_phy_cr_wait_ack(usb31misc);
+	ret = hi3670_phy_cr_wait_ack(usb31misc);
 	if (ret)
 		return ret;
 
@@ -268,22 +268,22 @@ static int kirin970_phy_cr_read(struct regmap *usb31misc, u32 addr, u32 *val)
 	return 0;
 }
 
-static int kirin970_phy_cr_write(struct regmap *usb31misc, u32 addr, u32 val)
+static int hi3670_phy_cr_write(struct regmap *usb31misc, u32 addr, u32 val)
 {
 	int i;
 	int ret;
 
 	for (i = 0; i < 100; i++) {
-		ret = kirin970_phy_cr_clk(usb31misc);
+		ret = hi3670_phy_cr_clk(usb31misc);
 		if (ret)
 			return ret;
 	}
 
-	ret = kirin970_phy_cr_set_sel(usb31misc);
+	ret = hi3670_phy_cr_set_sel(usb31misc);
 	if (ret)
 		return ret;
 
-	ret = kirin970_phy_cr_set_addr(usb31misc, addr);
+	ret = hi3670_phy_cr_set_addr(usb31misc, addr);
 	if (ret)
 		return ret;
 
@@ -292,16 +292,16 @@ static int kirin970_phy_cr_write(struct regmap *usb31misc, u32 addr, u32 val)
 	if (ret)
 		return ret;
 
-	ret = kirin970_phy_cr_start(usb31misc, 1);
+	ret = hi3670_phy_cr_start(usb31misc, 1);
 	if (ret)
 		return ret;
 
-	ret = kirin970_phy_cr_wait_ack(usb31misc);
+	ret = hi3670_phy_cr_wait_ack(usb31misc);
 
 	return ret;
 }
 
-static int kirin970_phy_set_params(struct kirin970_priv *priv)
+static int hi3670_phy_set_params(struct hi3670_priv *priv)
 {
 	u32 reg;
 	int ret;
@@ -315,7 +315,7 @@ static int kirin970_phy_set_params(struct kirin970_priv *priv)
 	}
 
 	while (retry-- > 0) {
-		ret = kirin970_phy_cr_read(priv->usb31misc,
+		ret = hi3670_phy_cr_read(priv->usb31misc,
 				TX_VBOOST_LVL_REG, &reg);
 		if (!ret)
 			break;
@@ -329,14 +329,14 @@ static int kirin970_phy_set_params(struct kirin970_priv *priv)
 
 	reg |= (TX_VBOOST_LVL_ENABLE |
 			(priv->tx_vboost_lvl << TX_VBOOST_LVL_START));
-	ret = kirin970_phy_cr_write(priv->usb31misc, TX_VBOOST_LVL_REG, reg);
+	ret = hi3670_phy_cr_write(priv->usb31misc, TX_VBOOST_LVL_REG, reg);
 	if (ret)
 		dev_err(priv->dev, "write TX_VBOOST_LVL_REG failed\n");
 
 	return ret;
 }
 
-static int kirin970_is_abbclk_seleted(struct kirin970_priv *priv)
+static int hi3670_is_abbclk_seleted(struct hi3670_priv *priv)
 {
 	u32 reg;
 
@@ -356,12 +356,12 @@ static int kirin970_is_abbclk_seleted(struct kirin970_priv *priv)
 	return 0;
 }
 
-static int kirin970_config_phy_clock(struct kirin970_priv *priv)
+static int hi3670_config_phy_clock(struct hi3670_priv *priv)
 {
 	u32 val, mask;
 	int ret;
 
-	if (kirin970_is_abbclk_seleted(priv)) {
+	if (hi3670_is_abbclk_seleted(priv)) {
 		/* usb refclk iso disable */
 		ret = regmap_write(priv->peri_crg, PERI_CRG_ISODIS,
 				USB_REFCLK_ISO_EN);
@@ -427,7 +427,7 @@ static int kirin970_config_phy_clock(struct kirin970_priv *priv)
 	return ret;
 }
 
-static int kirin970_config_tca(struct kirin970_priv *priv)
+static int hi3670_config_tca(struct hi3670_priv *priv)
 {
 	u32 val, mask;
 	int ret;
@@ -477,9 +477,9 @@ static int kirin970_config_tca(struct kirin970_priv *priv)
 	return ret;
 }
 
-static int kirin970_phy_init(struct phy *phy)
+static int hi3670_phy_init(struct phy *phy)
 {
-	struct kirin970_priv *priv = phy_get_drvdata(phy);
+	struct hi3670_priv *priv = phy_get_drvdata(phy);
 	u32 val;
 	int ret;
 
@@ -490,7 +490,7 @@ static int kirin970_phy_init(struct phy *phy)
 	if (ret)
 		goto out;
 
-	ret = kirin970_config_phy_clock(priv);
+	ret = hi3670_config_phy_clock(priv);
 	if (ret)
 		goto out;
 
@@ -522,7 +522,7 @@ static int kirin970_phy_init(struct phy *phy)
 	if (ret)
 		goto out;
 
-	ret = kirin970_config_tca(priv);
+	ret = hi3670_config_tca(priv);
 	if (ret)
 		goto out;
 
@@ -554,7 +554,7 @@ static int kirin970_phy_init(struct phy *phy)
 
 	udelay(100);
 
-	ret = kirin970_phy_set_params(priv);
+	ret = hi3670_phy_set_params(priv);
 	if (ret)
 		goto out;
 
@@ -564,9 +564,9 @@ static int kirin970_phy_init(struct phy *phy)
 	return ret;
 }
 
-static int kirin970_phy_exit(struct phy *phy)
+static int hi3670_phy_exit(struct phy *phy)
 {
-	struct kirin970_priv *priv = phy_get_drvdata(phy);
+	struct hi3670_priv *priv = phy_get_drvdata(phy);
 	u32 mask;
 	int ret;
 
@@ -576,7 +576,7 @@ static int kirin970_phy_exit(struct phy *phy)
 	if (ret)
 		goto out;
 
-	if (kirin970_is_abbclk_seleted(priv)) {
+	if (hi3670_is_abbclk_seleted(priv)) {
 		/* disable usb_tcxo_en */
 		ret = regmap_write(priv->pctrl, PCTRL_PERI_CTRL3,
 				USB_TCXO_EN << PCTRL_PERI_CTRL3_MSK_START);
@@ -593,18 +593,18 @@ static int kirin970_phy_exit(struct phy *phy)
 	return ret;
 }
 
-static struct phy_ops kirin970_phy_ops = {
-	.init		= kirin970_phy_init,
-	.exit		= kirin970_phy_exit,
+static struct phy_ops hi3670_phy_ops = {
+	.init		= hi3670_phy_init,
+	.exit		= hi3670_phy_exit,
 	.owner		= THIS_MODULE,
 };
 
-static int kirin970_phy_probe(struct platform_device *pdev)
+static int hi3670_phy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
 	struct phy *phy;
-	struct kirin970_priv *priv;
+	struct hi3670_priv *priv;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -647,7 +647,7 @@ static int kirin970_phy_probe(struct platform_device *pdev)
 				&(priv->tx_vboost_lvl)))
 		priv->eye_diagram_param = KIRIN970_USB_DEFAULT_PHY_VBOOST;
 
-	phy = devm_phy_create(dev, NULL, &kirin970_phy_ops);
+	phy = devm_phy_create(dev, NULL, &hi3670_phy_ops);
 	if (IS_ERR(phy))
 		return PTR_ERR(phy);
 
@@ -656,20 +656,20 @@ static int kirin970_phy_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
-static const struct of_device_id kirin970_phy_of_match[] = {
-	{.compatible = "hisilicon,kirin970-usb-phy",},
+static const struct of_device_id hi3670_phy_of_match[] = {
+	{.compatible = "hisilicon,hi3670-usb-phy",},
 	{ },
 };
-MODULE_DEVICE_TABLE(of, kirin970_phy_of_match);
+MODULE_DEVICE_TABLE(of, hi3670_phy_of_match);
 
-static struct platform_driver kirin970_phy_driver = {
-	.probe	= kirin970_phy_probe,
+static struct platform_driver hi3670_phy_driver = {
+	.probe	= hi3670_phy_probe,
 	.driver = {
-		.name	= "kirin970-usb-phy",
-		.of_match_table	= kirin970_phy_of_match,
+		.name	= "hi3670-usb-phy",
+		.of_match_table	= hi3670_phy_of_match,
 	}
 };
-module_platform_driver(kirin970_phy_driver);
+module_platform_driver(hi3670_phy_driver);
 
 MODULE_AUTHOR("Yu Chen <chenyu56@huawei.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.26.2

