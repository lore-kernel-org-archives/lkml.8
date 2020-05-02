Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C673C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B2221775
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="pFyhtwMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgEBLsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 07:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727791AbgEBLsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 07:48:31 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C860C061A0F;
        Sat,  2 May 2020 04:48:31 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g12so3064545wmh.3;
        Sat, 02 May 2020 04:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QFAHexGEnaXmwLdg5fSsXMiwNK3bsYkuiwFeQ5elT6s=;
        b=pFyhtwMpaZ3o/FB92DRrLDRT1f5GBNI2d/sKErFv2EVY2+CsKvc8/cCVNrW3yF6brL
         V1pY9VsGeka3mBBx8th1Djv31V96dCi8Iu+MKf9FQUKaPTMnLGJ2xSTGjJ5Lyf0R7q1V
         wJxqo9nrSZ2POeZZimRtumpaWPhiXPEeYi8aujAJjpvrdKDqrhfo1LutllVFe9oF4+aR
         YvuNw2BYeL/uKUK1SGZLLBOs6xNsZ8uoWt7u24H5xLrLRF4CUC7KWFy5tAYvLy6QmrT1
         QlhKxWOPZN4d1S3jao31Z3vQXv6Uxa8waUJlK8BlJI0sHJp+5mHg+5CZEy9NxxlNZOpJ
         JKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QFAHexGEnaXmwLdg5fSsXMiwNK3bsYkuiwFeQ5elT6s=;
        b=OMqmCRZyA2ymkAFFvFqDWtC1dn5aqPQyJbW879cWPzOp4qh44jyhHPq/sCsg1cT/uQ
         EhGqYLWwMZgLYamPgWAv+3vWvCtnWJX9XAh7GxpVRPW3gCjvLjYRcRNgy007UDQIlLnw
         4RcN9o4Pw/qMeDhN3MFCbNL7ZdF/OAxpS6ICPULrd2ZJ7PCraTjOxAF4h1EdxcWizMrA
         8OKjOI9QGUtd8DzWHjmBKzF67UnNs9UTmqFT+PmHClvP1ZthFlpWbniw7oizXeakjp/F
         EOZ4ytTiAC9vPca8FNdxoxzLDRsVuwBBuMpdJ7nu9ZOPm74k4hGVVQOKfmFaWUsm6eWY
         t/iQ==
X-Gm-Message-State: AGi0PuZ4/nOk9LpPr6oa1qeshctp6L4VdW2P23OCRO6ilFyfX00U2PVh
        tmaFeS35D0B00d+61xR7UZo=
X-Google-Smtp-Source: APiQypKFpubL84Iiz7KpmvLOkP1cjAkXYmyfiEm/mgIoIqq/wMO08G1Hjzh42HkwxMtoFbOyDkgMlQ==
X-Received: by 2002:a1c:2383:: with SMTP id j125mr4259706wmj.6.1588420110196;
        Sat, 02 May 2020 04:48:30 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id s17sm3801599wmc.48.2020.05.02.04.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 04:48:29 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     kishon@ti.com, robh+dt@kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hexdump0815@googlemail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/6] phy: amlogic: meson8b-usb2: Use a MMIO regmap
Date:   Sat,  2 May 2020 13:47:49 +0200
Message-Id: <20200502114752.1048500-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com>
References: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a MMIO regmap and switch to regmap_update_bits() to simplify the
code in the driver. Also switch to devm_platform_ioremap_resource()
instead of open-coding it. No functional changes intended.

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

