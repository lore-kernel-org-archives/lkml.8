Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1F8C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34FC20866
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="dMcwB4GE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgBXQNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:13:38 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:52634 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbgBXQNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1582560811; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HwWywXWtl0lHU0hr4om7dgYTxZAMZAHHLQqSA06y8PA=;
        b=dMcwB4GEZfo+CJwU8C8yCM0YsSPkZyVEQtQdsM4q2wsELCEh/aQNBhlvs5jMUbYy8fO4ey
        N1xjYV4mrJuoiMMg0rh8440JwSY3x8+Cj9ktrfVzM13UnpGruI6vVVajoWlnU+9bPXiE3D
        //SycfvUDTEHB8t2i9Ig6hUW4BueL+U=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] usb: phy: Add driver for the Ingenic JZ4770 USB transceiver
Date:   Mon, 24 Feb 2020 13:13:16 -0300
Message-Id: <20200224161316.15070-2-paul@crapouillou.net>
In-Reply-To: <20200224161316.15070-1-paul@crapouillou.net>
References: <20200224161316.15070-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver to support the USB PHY found in the JZ4770 SoC from
Ingenic.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/phy/Kconfig      |   8 ++
 drivers/usb/phy/Makefile     |   1 +
 drivers/usb/phy/phy-jz4770.c | 242 +++++++++++++++++++++++++++++++++++
 3 files changed, 251 insertions(+)
 create mode 100644 drivers/usb/phy/phy-jz4770.c

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index ff24fca0a2d9..4b3fa78995cf 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -184,4 +184,12 @@ config USB_ULPI_VIEWPORT
 	  Provides read/write operations to the ULPI phy register set for
 	  controllers with a viewport register (e.g. Chipidea/ARC controllers).
 
+config JZ4770_PHY
+	tristate "Ingenic JZ4770 Transceiver Driver"
+	depends on MIPS || COMPILE_TEST
+	select USB_PHY
+	help
+	  This driver provides PHY support for the USB controller found
+	  on the JZ4770 SoC from Ingenic.
+
 endmenu
diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
index df1d99010079..b352bdbe8712 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_USB_MXS_PHY)		+= phy-mxs-usb.o
 obj-$(CONFIG_USB_ULPI)			+= phy-ulpi.o
 obj-$(CONFIG_USB_ULPI_VIEWPORT)		+= phy-ulpi-viewport.o
 obj-$(CONFIG_KEYSTONE_USB_PHY)		+= phy-keystone.o
+obj-$(CONFIG_JZ4770_PHY)		+= phy-jz4770.o
diff --git a/drivers/usb/phy/phy-jz4770.c b/drivers/usb/phy/phy-jz4770.c
new file mode 100644
index 000000000000..afc1b42f655a
--- /dev/null
+++ b/drivers/usb/phy/phy-jz4770.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ingenic JZ4770 USB PHY driver
+ * Copyright (c) Paul Cercueil <paul@crapouillou.net>
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/phy.h>
+
+#define REG_USBPCR_OFFSET	0x00
+#define REG_USBRDT_OFFSET	0x04
+#define REG_USBVBFIL_OFFSET	0x08
+#define REG_USBPCR1_OFFSET	0x0c
+
+/* USBPCR */
+#define USBPCR_USB_MODE		BIT(31)
+#define USBPCR_AVLD_REG		BIT(30)
+#define USBPCR_INCRM		BIT(27)
+#define USBPCR_CLK12_EN		BIT(26)
+#define USBPCR_COMMONONN	BIT(25)
+#define USBPCR_VBUSVLDEXT	BIT(24)
+#define USBPCR_VBUSVLDEXTSEL	BIT(23)
+#define USBPCR_POR		BIT(22)
+#define USBPCR_SIDDQ		BIT(21)
+#define USBPCR_OTG_DISABLE	BIT(20)
+#define USBPCR_TXPREEMPHTUNE	BIT(6)
+
+#define USBPCR_IDPULLUP_LSB	28
+#define USBPCR_IDPULLUP_MASK	GENMASK(29, USBPCR_IDPULLUP_LSB)
+#define USBPCR_IDPULLUP_ALWAYS	(3 << USBPCR_IDPULLUP_LSB)
+#define USBPCR_IDPULLUP_SUSPEND	(1 << USBPCR_IDPULLUP_LSB)
+#define USBPCR_IDPULLUP_OTG	(0 << USBPCR_IDPULLUP_LSB)
+
+#define USBPCR_COMPDISTUNE_LSB	17
+#define USBPCR_COMPDISTUNE_MASK	GENMASK(19, USBPCR_COMPDISTUNE_LSB)
+#define USBPCR_COMPDISTUNE_DFT	4
+
+#define USBPCR_OTGTUNE_LSB	14
+#define USBPCR_OTGTUNE_MASK	GENMASK(16, USBPCR_OTGTUNE_LSB)
+#define USBPCR_OTGTUNE_DFT	4
+
+#define USBPCR_SQRXTUNE_LSB	11
+#define USBPCR_SQRXTUNE_MASK	GENMASK(13, USBPCR_SQRXTUNE_LSB)
+#define USBPCR_SQRXTUNE_DFT	3
+
+#define USBPCR_TXFSLSTUNE_LSB	7
+#define USBPCR_TXFSLSTUNE_MASK	GENMASK(10, USBPCR_TXFSLSTUNE_LSB)
+#define USBPCR_TXFSLSTUNE_DFT	3
+
+#define USBPCR_TXRISETUNE_LSB	4
+#define USBPCR_TXRISETUNE_MASK	GENMASK(5, USBPCR_TXRISETUNE_LSB)
+#define USBPCR_TXRISETUNE_DFT	3
+
+#define USBPCR_TXVREFTUNE_LSB	0
+#define USBPCR_TXVREFTUNE_MASK	GENMASK(3, USBPCR_TXVREFTUNE_LSB)
+#define USBPCR_TXVREFTUNE_DFT	5
+
+/* USBRDT */
+#define USBRDT_VBFIL_LD_EN	BIT(25)
+#define USBRDT_IDDIG_EN		BIT(24)
+#define USBRDT_IDDIG_REG	BIT(23)
+
+#define USBRDT_USBRDT_LSB	0
+#define USBRDT_USBRDT_MASK	GENMASK(22, USBRDT_USBRDT_LSB)
+
+/* USBPCR1 */
+#define USBPCR1_UHC_POWON	BIT(5)
+
+struct jz4770_phy {
+	struct usb_phy phy;
+	struct usb_otg otg;
+	struct device *dev;
+	void __iomem *base;
+	struct clk *clk;
+	struct regulator *vcc_supply;
+};
+
+static inline struct jz4770_phy *otg_to_jz4770_phy(struct usb_otg *otg)
+{
+	return container_of(otg, struct jz4770_phy, otg);
+}
+
+static inline struct jz4770_phy *phy_to_jz4770_phy(struct usb_phy *phy)
+{
+	return container_of(phy, struct jz4770_phy, phy);
+}
+
+static int jz4770_phy_set_peripheral(struct usb_otg *otg,
+				     struct usb_gadget *gadget)
+{
+	struct jz4770_phy *priv = otg_to_jz4770_phy(otg);
+	u32 reg;
+
+	reg = readl(priv->base + REG_USBPCR_OFFSET);
+	reg &= ~USBPCR_USB_MODE;
+	reg |= USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL | USBPCR_OTG_DISABLE;
+	writel(reg, priv->base + REG_USBPCR_OFFSET);
+
+	return 0;
+}
+
+static int jz4770_phy_set_host(struct usb_otg *otg, struct usb_bus *host)
+{
+	struct jz4770_phy *priv = otg_to_jz4770_phy(otg);
+	u32 reg;
+
+	reg = readl(priv->base + REG_USBPCR_OFFSET);
+	reg &= ~(USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL | USBPCR_OTG_DISABLE);
+	reg |= USBPCR_USB_MODE;
+	writel(reg, priv->base + REG_USBPCR_OFFSET);
+
+	return 0;
+}
+
+static int jz4770_phy_init(struct usb_phy *phy)
+{
+	struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
+	int err;
+	u32 reg;
+
+	err = regulator_enable(priv->vcc_supply);
+	if (err) {
+		dev_err(priv->dev, "Unable to enable VCC: %d", err);
+		return err;
+	}
+
+	err = clk_prepare_enable(priv->clk);
+	if (err) {
+		dev_err(priv->dev, "Unable to start clock: %d", err);
+		return err;
+	}
+
+	reg = USBPCR_AVLD_REG | USBPCR_COMMONONN | USBPCR_IDPULLUP_ALWAYS |
+		(USBPCR_COMPDISTUNE_DFT << USBPCR_COMPDISTUNE_LSB) |
+		(USBPCR_OTGTUNE_DFT << USBPCR_OTGTUNE_LSB) |
+		(USBPCR_SQRXTUNE_DFT << USBPCR_SQRXTUNE_LSB) |
+		(USBPCR_TXFSLSTUNE_DFT << USBPCR_TXFSLSTUNE_LSB) |
+		(USBPCR_TXRISETUNE_DFT << USBPCR_TXRISETUNE_LSB) |
+		(USBPCR_TXVREFTUNE_DFT << USBPCR_TXVREFTUNE_LSB) |
+		USBPCR_POR;
+	writel(reg, priv->base + REG_USBPCR_OFFSET);
+
+	/* Wait for PHY to reset */
+	usleep_range(30, 300);
+	writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
+	usleep_range(300, 1000);
+
+	return 0;
+}
+
+static void jz4770_phy_shutdown(struct usb_phy *phy)
+{
+	struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
+
+	clk_disable_unprepare(priv->clk);
+	regulator_disable(priv->vcc_supply);
+}
+
+static void jz4770_phy_remove(void *phy)
+{
+	usb_remove_phy(phy);
+}
+
+static int jz4770_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct jz4770_phy *priv;
+	int err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+	priv->dev = dev;
+	priv->phy.dev = dev;
+	priv->phy.otg = &priv->otg;
+	priv->phy.label = "jz4770-phy";
+	priv->phy.init = jz4770_phy_init;
+	priv->phy.shutdown = jz4770_phy_shutdown;
+
+	priv->otg.state = OTG_STATE_UNDEFINED;
+	priv->otg.usb_phy = &priv->phy;
+	priv->otg.set_host = jz4770_phy_set_host;
+	priv->otg.set_peripheral = jz4770_phy_set_peripheral;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base)) {
+		dev_err(dev, "Failed to map registers");
+		return PTR_ERR(priv->base);
+	}
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		err = PTR_ERR(priv->clk);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get clock");
+		return err;
+	}
+
+	priv->vcc_supply = devm_regulator_get(dev, "vcc");
+	if (IS_ERR(priv->vcc_supply)) {
+		err = PTR_ERR(priv->vcc_supply);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "failed to get regulator");
+		return err;
+	}
+
+	err = usb_add_phy(&priv->phy, USB_PHY_TYPE_USB2);
+	if (err) {
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "Unable to register PHY");
+		return err;
+	}
+
+	return devm_add_action_or_reset(dev, jz4770_phy_remove, &priv->phy);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id jz4770_phy_of_matches[] = {
+	{ .compatible = "ingenic,jz4770-phy" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, jz4770_phy_of_matches);
+#endif
+
+static struct platform_driver jz4770_phy_driver = {
+	.probe		= jz4770_phy_probe,
+	.driver		= {
+		.name	= "jz4770-phy",
+		.of_match_table = of_match_ptr(jz4770_phy_of_matches),
+	},
+};
+module_platform_driver(jz4770_phy_driver);
+
+MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
+MODULE_DESCRIPTION("Ingenic JZ4770 USB PHY driver");
+MODULE_LICENSE("GPL");
-- 
2.25.0

