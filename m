Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873C7C2D0FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6132124927
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="sXzujmne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbgELWYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731973AbgELWYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:24:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D27C061A0C;
        Tue, 12 May 2020 15:24:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n5so10956079wmd.0;
        Tue, 12 May 2020 15:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PjJLkn9PoPDXRl4+jY4u2mwSqR91lgzHQdcLZQFcvtw=;
        b=sXzujmneDvKtWimMIKGU6JMKfbjB6Ol4KRmuhfTQBHl1w+F4CnrMRDOwjoG47CskiG
         d7gnwknBYen2iiPHjHFJBtk4N4QfiNjwg+3f1RuhEUCDEiJmm1pMssgzTsHRUHZNujIU
         +/2N8a4FeAJzcjvxw9cEtxUusZnr/4HgLjAlXwipu/gDNoPuWAYVmg1PAe3OfPtb3far
         g/Fb3qg2CuzCF/vmvAEM59Xc/A2X6gm6p21MZJAVDCcxpF6/AGj9VSVof+gBjVeaokjf
         7Nqj8uLBqRdzconWE2YTdQpE5erNsBy80ZTGBCZAP4KBIFhhilgUwYKS0XMUmFMkVf9p
         YUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PjJLkn9PoPDXRl4+jY4u2mwSqR91lgzHQdcLZQFcvtw=;
        b=t8w0S2AsAIQAzGl+2mvtrSFpvJ1gYjA+SgKgi37vo5mvvc8paOqAkWKy8JRIwfRF8H
         GSeukHOaRxa/6fpCucF0n2svnzIcEQwoOtVjDkN+h+IF920/TPoKUUSwUFdiHtrDYDLs
         crF+v4B+Nvmt4AgVKL3tEhkvpcYdGAopnhJU0vZLDHHECEDUeq4HSa1yl7lWNUGbbRMA
         gDq3iFYbLYlStY8bHGLt9/mzxZvcCy8A/EH02itNjGC0uXtVxv2USULaZi0bolHoU9AG
         ZGuQPoT5HS/0SvQyB9MAz0VHFyWrk2FBPESOr+CEE66tAVKPiIl5hMdXNHmliHqMZui/
         BDgQ==
X-Gm-Message-State: AGi0PuY24pmKcZNgrEzS9Z17oN5UwtyhEwUAGusVNJzcEj4tuFCuFeQW
        b5ZRgQ8yg9NVRZ/ElQsTjtk=
X-Google-Smtp-Source: APiQypK5Co/sSecmnb8Pg+BTKxMJYZynYQrKN0eBRku8rZYr9eaJGjy5BjtcYQplq4sjlCVvi1mXEQ==
X-Received: by 2002:a1c:e305:: with SMTP id a5mr22450878wmh.1.1589322276996;
        Tue, 12 May 2020 15:24:36 -0700 (PDT)
Received: from localhost.localdomain (p200300F137132E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3713:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b2sm21758758wrm.30.2020.05.12.15.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:24:36 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     kishon@ti.com, robh+dt@kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hexdump0815@googlemail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>
Subject: [PATCH v2 3/6] phy: amlogic: meson8b-usb2: Use a MMIO regmap
Date:   Wed, 13 May 2020 00:24:21 +0200
Message-Id: <20200512222424.549351-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512222424.549351-1-martin.blumenstingl@googlemail.com>
References: <20200512222424.549351-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a MMIO regmap and switch to regmap_update_bits() to simplify the
code in the driver. Also switch to devm_platform_ioremap_resource()
instead of open-coding it. No functional changes intended.

Tested-by: Thomas Graichen <thomas.graichen@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/phy/amlogic/Kconfig            |  1 +
 drivers/phy/amlogic/phy-meson8b-usb2.c | 73 ++++++++++++--------------
 2 files changed, 35 insertions(+), 39 deletions(-)

diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
index 71801e30d601..3495b23af797 100644
--- a/drivers/phy/amlogic/Kconfig
+++ b/drivers/phy/amlogic/Kconfig
@@ -9,6 +9,7 @@ config PHY_MESON8B_USB2
 	depends on USB_SUPPORT
 	select USB_COMMON
 	select GENERIC_PHY
+	select REGMAP_MMIO
 	help
 	  Enable this to support the Meson USB2 PHYs found in Meson8,
 	  Meson8b and GXBB SoCs.
diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
index bd66bd723e4a..86824cc21f11 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -10,6 +10,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -105,34 +106,24 @@
 #define ACA_ENABLE_COMPLETE_TIME			50
 
 struct phy_meson8b_usb2_priv {
-	void __iomem		*regs;
+	struct regmap		*regmap;
 	enum usb_dr_mode	dr_mode;
 	struct clk		*clk_usb_general;
 	struct clk		*clk_usb;
 	struct reset_control	*reset;
 };
 
-static u32 phy_meson8b_usb2_read(struct phy_meson8b_usb2_priv *phy_priv,
-				 u32 reg)
-{
-	return readl(phy_priv->regs + reg);
-}
-
-static void phy_meson8b_usb2_mask_bits(struct phy_meson8b_usb2_priv *phy_priv,
-				       u32 reg, u32 mask, u32 value)
-{
-	u32 data;
-
-	data = phy_meson8b_usb2_read(phy_priv, reg);
-	data &= ~mask;
-	data |= (value & mask);
-
-	writel(data, phy_priv->regs + reg);
-}
+static const struct regmap_config phy_meson8b_usb2_regmap_conf = {
+	.reg_bits = 8,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = REG_TUNE,
+};
 
 static int phy_meson8b_usb2_power_on(struct phy *phy)
 {
 	struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
+	u32 reg;
 	int ret;
 
 	if (!IS_ERR_OR_NULL(priv->reset)) {
@@ -156,34 +147,34 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
 		return ret;
 	}
 
-	phy_meson8b_usb2_mask_bits(priv, REG_CONFIG, REG_CONFIG_CLK_32k_ALTSEL,
-				   REG_CONFIG_CLK_32k_ALTSEL);
+	regmap_update_bits(priv->regmap, REG_CONFIG, REG_CONFIG_CLK_32k_ALTSEL,
+			   REG_CONFIG_CLK_32k_ALTSEL);
 
-	phy_meson8b_usb2_mask_bits(priv, REG_CTRL, REG_CTRL_REF_CLK_SEL_MASK,
-				   0x2 << REG_CTRL_REF_CLK_SEL_SHIFT);
+	regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_REF_CLK_SEL_MASK,
+			   0x2 << REG_CTRL_REF_CLK_SEL_SHIFT);
 
-	phy_meson8b_usb2_mask_bits(priv, REG_CTRL, REG_CTRL_FSEL_MASK,
-				   0x5 << REG_CTRL_FSEL_SHIFT);
+	regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_FSEL_MASK,
+			   0x5 << REG_CTRL_FSEL_SHIFT);
 
 	/* reset the PHY */
-	phy_meson8b_usb2_mask_bits(priv, REG_CTRL, REG_CTRL_POWER_ON_RESET,
-				   REG_CTRL_POWER_ON_RESET);
+	regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_POWER_ON_RESET,
+			   REG_CTRL_POWER_ON_RESET);
 	udelay(RESET_COMPLETE_TIME);
-	phy_meson8b_usb2_mask_bits(priv, REG_CTRL, REG_CTRL_POWER_ON_RESET, 0);
+	regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_POWER_ON_RESET, 0);
 	udelay(RESET_COMPLETE_TIME);
 
-	phy_meson8b_usb2_mask_bits(priv, REG_CTRL, REG_CTRL_SOF_TOGGLE_OUT,
-				   REG_CTRL_SOF_TOGGLE_OUT);
+	regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_SOF_TOGGLE_OUT,
+			   REG_CTRL_SOF_TOGGLE_OUT);
 
 	if (priv->dr_mode == USB_DR_MODE_HOST) {
-		phy_meson8b_usb2_mask_bits(priv, REG_ADP_BC,
-					   REG_ADP_BC_ACA_ENABLE,
-					   REG_ADP_BC_ACA_ENABLE);
+		regmap_update_bits(priv->regmap, REG_ADP_BC,
+				   REG_ADP_BC_ACA_ENABLE,
+				   REG_ADP_BC_ACA_ENABLE);
 
 		udelay(ACA_ENABLE_COMPLETE_TIME);
 
-		if (phy_meson8b_usb2_read(priv, REG_ADP_BC) &
-			REG_ADP_BC_ACA_PIN_FLOAT) {
+		regmap_read(priv->regmap, REG_ADP_BC, &reg);
+		if (reg & REG_ADP_BC_ACA_PIN_FLOAT) {
 			dev_warn(&phy->dev, "USB ID detect failed!\n");
 			clk_disable_unprepare(priv->clk_usb);
 			clk_disable_unprepare(priv->clk_usb_general);
@@ -213,18 +204,22 @@ static const struct phy_ops phy_meson8b_usb2_ops = {
 static int phy_meson8b_usb2_probe(struct platform_device *pdev)
 {
 	struct phy_meson8b_usb2_priv *priv;
-	struct resource *res;
 	struct phy *phy;
 	struct phy_provider *phy_provider;
+	void __iomem *base;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(priv->regs))
-		return PTR_ERR(priv->regs);
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					     &phy_meson8b_usb2_regmap_conf);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
 
 	priv->clk_usb_general = devm_clk_get(&pdev->dev, "usb_general");
 	if (IS_ERR(priv->clk_usb_general))
-- 
2.26.2

