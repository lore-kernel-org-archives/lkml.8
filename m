Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD95DC433E7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 07:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A17207DA
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 07:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgH3Hr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 03:47:56 -0400
Received: from out28-52.mail.aliyun.com ([115.124.28.52]:33592 "EHLO
        out28-52.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgH3Hrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 03:47:53 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0126131-0.00618008-0.981207;FP=1908962570842754802|1|1|9|0|-1|-1|-1;HT=e02c03303;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.IQ3BIUl_1598773648;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IQ3BIUl_1598773648)
          by smtp.aliyun-inc.com(10.147.42.198);
          Sun, 30 Aug 2020 15:47:45 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     kishon@ti.com, vkoul@kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, christophe.jaillet@wanadoo.fr,
        aric.pzqi@ingenic.com, dongsheng.qiu@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH] USB: PHY: JZ4770: Use the generic PHY framework.
Date:   Sun, 30 Aug 2020 15:46:48 +0800
Message-Id: <20200830074648.116518-2-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200830074648.116518-1-zhouyanjie@wanyeetech.com>
References: <20200830074648.116518-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Used the generic PHY framework API to create the PHY,
and move the driver to driver/phy/ingenic.

Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
Co-developed-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
Signed-off-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/ingenic/Kconfig                        |  12 ++
 drivers/phy/ingenic/Makefile                       |   2 +
 .../phy-jz4770.c => phy/ingenic/phy-ingenic-usb.c} | 236 ++++++++++++---------
 drivers/usb/phy/Kconfig                            |   8 -
 drivers/usb/phy/Makefile                           |   1 -
 7 files changed, 155 insertions(+), 106 deletions(-)
 create mode 100644 drivers/phy/ingenic/Kconfig
 create mode 100644 drivers/phy/ingenic/Makefile
 rename drivers/{usb/phy/phy-jz4770.c => phy/ingenic/phy-ingenic-usb.c} (63%)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index de9362c25c07..0534b0fdd057 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -55,6 +55,7 @@ source "drivers/phy/broadcom/Kconfig"
 source "drivers/phy/cadence/Kconfig"
 source "drivers/phy/freescale/Kconfig"
 source "drivers/phy/hisilicon/Kconfig"
+source "drivers/phy/ingenic/Kconfig"
 source "drivers/phy/lantiq/Kconfig"
 source "drivers/phy/marvell/Kconfig"
 source "drivers/phy/mediatek/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index c27408e4daae..ab24f0d20763 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -14,6 +14,7 @@ obj-y					+= allwinner/	\
 					   cadence/	\
 					   freescale/	\
 					   hisilicon/	\
+					   ingenic/	\
 					   intel/	\
 					   lantiq/	\
 					   marvell/	\
diff --git a/drivers/phy/ingenic/Kconfig b/drivers/phy/ingenic/Kconfig
new file mode 100644
index 000000000000..b9581eae89dd
--- /dev/null
+++ b/drivers/phy/ingenic/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Phy drivers for Ingenic platforms
+#
+config PHY_INGENIC_USB
+	tristate "Ingenic SoCs USB PHY Driver"
+	depends on (MACH_INGENIC && MIPS) || COMPILE_TEST
+	depends on USB_SUPPORT
+	select GENERIC_PHY
+	help
+	  This driver provides USB PHY support for the USB controller found
+	  on the JZ-series and X-series SoCs from Ingenic.
diff --git a/drivers/phy/ingenic/Makefile b/drivers/phy/ingenic/Makefile
new file mode 100644
index 000000000000..65d5ea00fc9d
--- /dev/null
+++ b/drivers/phy/ingenic/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y		+= phy-ingenic-usb.o
diff --git a/drivers/usb/phy/phy-jz4770.c b/drivers/phy/ingenic/phy-ingenic-usb.c
similarity index 63%
rename from drivers/usb/phy/phy-jz4770.c
rename to drivers/phy/ingenic/phy-ingenic-usb.c
index f6d3731581eb..14029d89cd70 100644
--- a/drivers/usb/phy/phy-jz4770.c
+++ b/drivers/phy/ingenic/phy-ingenic-usb.c
@@ -7,12 +7,12 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
-#include <linux/usb/otg.h>
-#include <linux/usb/phy.h>
+#include <linux/phy/phy.h>
 
 /* OTGPHY register offsets */
 #define REG_USBPCR_OFFSET			0x00
@@ -97,68 +97,49 @@ enum ingenic_usb_phy_version {
 struct ingenic_soc_info {
 	enum ingenic_usb_phy_version version;
 
-	void (*usb_phy_init)(struct usb_phy *phy);
+	void (*usb_phy_init)(struct phy *phy);
 };
 
-struct jz4770_phy {
+struct ingenic_usb_phy {
 	const struct ingenic_soc_info *soc_info;
 
-	struct usb_phy phy;
-	struct usb_otg otg;
+	struct phy *phy;
 	struct device *dev;
 	void __iomem *base;
 	struct clk *clk;
 	struct regulator *vcc_supply;
 };
 
-static inline struct jz4770_phy *otg_to_jz4770_phy(struct usb_otg *otg)
+static int ingenic_usb_phy_init(struct phy *phy)
 {
-	return container_of(otg, struct jz4770_phy, otg);
-}
-
-static inline struct jz4770_phy *phy_to_jz4770_phy(struct usb_phy *phy)
-{
-	return container_of(phy, struct jz4770_phy, phy);
-}
-
-static int ingenic_usb_phy_set_peripheral(struct usb_otg *otg,
-				     struct usb_gadget *gadget)
-{
-	struct jz4770_phy *priv = otg_to_jz4770_phy(otg);
-	u32 reg;
+	struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
+	int err;
 
-	if (priv->soc_info->version >= ID_X1000) {
-		reg = readl(priv->base + REG_USBPCR1_OFFSET);
-		reg |= USBPCR1_BVLD_REG;
-		writel(reg, priv->base + REG_USBPCR1_OFFSET);
+	err = clk_prepare_enable(priv->clk);
+	if (err) {
+		dev_err(priv->dev, "Unable to start clock: %d\n", err);
+		return err;
 	}
 
-	reg = readl(priv->base + REG_USBPCR_OFFSET);
-	reg &= ~USBPCR_USB_MODE;
-	reg |= USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL | USBPCR_OTG_DISABLE;
-	writel(reg, priv->base + REG_USBPCR_OFFSET);
+	priv->soc_info->usb_phy_init(phy);
 
 	return 0;
 }
 
-static int ingenic_usb_phy_set_host(struct usb_otg *otg, struct usb_bus *host)
+static int ingenic_usb_phy_exit(struct phy *phy)
 {
-	struct jz4770_phy *priv = otg_to_jz4770_phy(otg);
-	u32 reg;
+	struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
 
-	reg = readl(priv->base + REG_USBPCR_OFFSET);
-	reg &= ~(USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL | USBPCR_OTG_DISABLE);
-	reg |= USBPCR_USB_MODE;
-	writel(reg, priv->base + REG_USBPCR_OFFSET);
+	clk_disable_unprepare(priv->clk);
+	regulator_disable(priv->vcc_supply);
 
 	return 0;
 }
 
-static int ingenic_usb_phy_init(struct usb_phy *phy)
+static int ingenic_usb_phy_power_on(struct phy *phy)
 {
-	struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
+	struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
 	int err;
-	u32 reg;
 
 	err = regulator_enable(priv->vcc_supply);
 	if (err) {
@@ -166,39 +147,71 @@ static int ingenic_usb_phy_init(struct usb_phy *phy)
 		return err;
 	}
 
-	err = clk_prepare_enable(priv->clk);
-	if (err) {
-		dev_err(priv->dev, "Unable to start clock: %d\n", err);
-		return err;
-	}
-
-	priv->soc_info->usb_phy_init(phy);
-
-	/* Wait for PHY to reset */
-	usleep_range(30, 300);
-	reg = readl(priv->base + REG_USBPCR_OFFSET);
-	writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
-	usleep_range(300, 1000);
-
 	return 0;
 }
 
-static void ingenic_usb_phy_shutdown(struct usb_phy *phy)
+static int ingenic_usb_phy_power_off(struct phy *phy)
 {
-	struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
+	struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
 
-	clk_disable_unprepare(priv->clk);
 	regulator_disable(priv->vcc_supply);
+
+	return 0;
 }
 
-static void ingenic_usb_phy_remove(void *phy)
+static int ingenic_usb_phy_set_mode(struct phy *phy,
+				  enum phy_mode mode, int submode)
 {
-	usb_remove_phy(phy);
+	struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
+	u32 reg;
+
+	switch (mode) {
+	case PHY_MODE_USB_HOST:
+		reg = readl(priv->base + REG_USBPCR_OFFSET);
+		reg &= ~(USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL | USBPCR_OTG_DISABLE);
+		reg |= USBPCR_USB_MODE;
+		writel(reg, priv->base + REG_USBPCR_OFFSET);
+
+		break;
+	case PHY_MODE_USB_DEVICE:
+		if (priv->soc_info->version >= ID_X1000) {
+			reg = readl(priv->base + REG_USBPCR1_OFFSET);
+			reg |= USBPCR1_BVLD_REG;
+			writel(reg, priv->base + REG_USBPCR1_OFFSET);
+		}
+
+		reg = readl(priv->base + REG_USBPCR_OFFSET);
+		reg &= ~USBPCR_USB_MODE;
+		reg |= USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL | USBPCR_OTG_DISABLE;
+		writel(reg, priv->base + REG_USBPCR_OFFSET);
+
+		break;
+	case PHY_MODE_USB_OTG:
+		reg = readl(priv->base + REG_USBPCR_OFFSET);
+		reg &= ~USBPCR_OTG_DISABLE;
+		reg |= USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL | USBPCR_USB_MODE;
+		writel(reg, priv->base + REG_USBPCR_OFFSET);
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
-static void jz4770_usb_phy_init(struct usb_phy *phy)
+static const struct phy_ops ingenic_usb_phy_ops = {
+	.init		= ingenic_usb_phy_init,
+	.exit		= ingenic_usb_phy_exit,
+	.power_on	= ingenic_usb_phy_power_on,
+	.power_off	= ingenic_usb_phy_power_off,
+	.set_mode	= ingenic_usb_phy_set_mode,
+	.owner		= THIS_MODULE,
+};
+
+static void jz4770_usb_phy_init(struct phy *phy)
 {
-	struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
+	struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
 	u32 reg;
 
 	reg = USBPCR_AVLD_REG | USBPCR_COMMONONN | USBPCR_IDPULLUP_ALWAYS |
@@ -206,11 +219,16 @@ static void jz4770_usb_phy_init(struct usb_phy *phy)
 		USBPCR_TXFSLSTUNE_DFT | USBPCR_TXRISETUNE_DFT | USBPCR_TXVREFTUNE_DFT |
 		USBPCR_POR;
 	writel(reg, priv->base + REG_USBPCR_OFFSET);
+
+	/* Wait for PHY to reset */
+	usleep_range(30, 300);
+	writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
+	usleep_range(300, 1000);
 }
 
-static void jz4780_usb_phy_init(struct usb_phy *phy)
+static void jz4780_usb_phy_init(struct phy *phy)
 {
-	struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
+	struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
 	u32 reg;
 
 	reg = readl(priv->base + REG_USBPCR1_OFFSET) | USBPCR1_USB_SEL |
@@ -219,11 +237,16 @@ static void jz4780_usb_phy_init(struct usb_phy *phy)
 
 	reg = USBPCR_TXPREEMPHTUNE | USBPCR_COMMONONN | USBPCR_POR;
 	writel(reg, priv->base + REG_USBPCR_OFFSET);
+
+	/* Wait for PHY to reset */
+	usleep_range(30, 300);
+	writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
+	usleep_range(300, 1000);
 }
 
-static void x1000_usb_phy_init(struct usb_phy *phy)
+static void x1000_usb_phy_init(struct phy *phy)
 {
-	struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
+	struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
 	u32 reg;
 
 	reg = readl(priv->base + REG_USBPCR1_OFFSET) | USBPCR1_WORD_IF_16BIT;
@@ -233,11 +256,16 @@ static void x1000_usb_phy_init(struct usb_phy *phy)
 		USBPCR_TXHSXVTUNE_DCR_15MV | USBPCR_TXVREFTUNE_INC_25PPT |
 		USBPCR_COMMONONN | USBPCR_POR;
 	writel(reg, priv->base + REG_USBPCR_OFFSET);
+
+	/* Wait for PHY to reset */
+	usleep_range(30, 300);
+	writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
+	usleep_range(300, 1000);
 }
 
-static void x1830_usb_phy_init(struct usb_phy *phy)
+static void x1830_usb_phy_init(struct phy *phy)
 {
-	struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
+	struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
 	u32 reg;
 
 	/* rdt */
@@ -250,6 +278,11 @@ static void x1830_usb_phy_init(struct usb_phy *phy)
 	reg = USBPCR_IDPULLUP_OTG | USBPCR_VBUSVLDEXT |	USBPCR_TXPREEMPHTUNE |
 		USBPCR_COMMONONN | USBPCR_POR;
 	writel(reg, priv->base + REG_USBPCR_OFFSET);
+
+	/* Wait for PHY to reset */
+	usleep_range(30, 300);
+	writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
+	usleep_range(300, 1000);
 }
 
 static const struct ingenic_soc_info jz4770_soc_info = {
@@ -285,78 +318,87 @@ static const struct of_device_id ingenic_usb_phy_of_matches[] = {
 };
 MODULE_DEVICE_TABLE(of, ingenic_usb_phy_of_matches);
 
-static int jz4770_phy_probe(struct platform_device *pdev)
+static int ingenic_usb_phy_probe(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-	struct jz4770_phy *priv;
+	struct ingenic_usb_phy *priv;
+	struct phy_provider *provider;
 	int err;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	priv->dev = &pdev->dev;
+
 	priv->soc_info = device_get_match_data(&pdev->dev);
 	if (!priv->soc_info) {
 		dev_err(&pdev->dev, "Error: No device match found\n");
 		return -ENODEV;
 	}
 
-	platform_set_drvdata(pdev, priv);
-	priv->dev = dev;
-	priv->phy.dev = dev;
-	priv->phy.otg = &priv->otg;
-	priv->phy.label = "ingenic-usb-phy";
-	priv->phy.init = ingenic_usb_phy_init;
-	priv->phy.shutdown = ingenic_usb_phy_shutdown;
-
-	priv->otg.state = OTG_STATE_UNDEFINED;
-	priv->otg.usb_phy = &priv->phy;
-	priv->otg.set_host = ingenic_usb_phy_set_host;
-	priv->otg.set_peripheral = ingenic_usb_phy_set_peripheral;
-
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base)) {
-		dev_err(dev, "Failed to map registers\n");
+		dev_err(priv->dev, "Failed to map registers\n");
 		return PTR_ERR(priv->base);
 	}
 
-	priv->clk = devm_clk_get(dev, NULL);
+	priv->clk = devm_clk_get(priv->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		err = PTR_ERR(priv->clk);
 		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get clock\n");
+			dev_err(priv->dev, "Failed to get clock\n");
 		return err;
 	}
 
-	priv->vcc_supply = devm_regulator_get(dev, "vcc");
+	priv->vcc_supply = devm_regulator_get(priv->dev, "vcc");
 	if (IS_ERR(priv->vcc_supply)) {
 		err = PTR_ERR(priv->vcc_supply);
 		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get regulator\n");
+			dev_err(priv->dev, "Failed to get regulator\n");
 		return err;
 	}
 
-	err = usb_add_phy(&priv->phy, USB_PHY_TYPE_USB2);
-	if (err) {
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Unable to register PHY\n");
-		return err;
+	priv->phy = devm_phy_create(priv->dev, NULL, &ingenic_usb_phy_ops);
+	if (IS_ERR(priv)) {
+		dev_err(priv->dev, "Failed to create PHY: %ld\n",	PTR_ERR(priv));
+		return PTR_ERR(priv);
 	}
 
-	return devm_add_action_or_reset(dev, ingenic_usb_phy_remove, &priv->phy);
+	provider = devm_of_phy_provider_register(priv->dev, of_phy_simple_xlate);
+	if (IS_ERR(provider)) {
+		dev_err(priv->dev, "Failed to register PHY provider: %ld\n", PTR_ERR(provider));
+		return PTR_ERR(provider);
+	}
+
+	platform_set_drvdata(pdev, priv);
+	phy_set_drvdata(priv->phy, priv);
+
+	return 0;
+}
+
+static int ingenic_usb_phy_remove(struct platform_device *pdev)
+{
+	struct ingenic_usb_phy *priv = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(priv->clk);
+	regulator_disable(priv->vcc_supply);
+
+	return 0;
 }
 
-static struct platform_driver ingenic_phy_driver = {
-	.probe		= jz4770_phy_probe,
+static struct platform_driver ingenic_usb_phy_driver = {
+	.probe		= ingenic_usb_phy_probe,
+	.remove		= ingenic_usb_phy_remove,
 	.driver		= {
-		.name	= "jz4770-phy",
+		.name	= "ingenic-usb-phy",
 		.of_match_table = of_match_ptr(ingenic_usb_phy_of_matches),
 	},
 };
-module_platform_driver(ingenic_phy_driver);
+module_platform_driver(ingenic_usb_phy_driver);
 
 MODULE_AUTHOR("周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>");
 MODULE_AUTHOR("漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>");
 MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
 MODULE_DESCRIPTION("Ingenic SoCs USB PHY driver");
+MODULE_ALIAS("jz4770_phy");
 MODULE_LICENSE("GPL");
diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index ef4787cd3d37..ff24fca0a2d9 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -184,12 +184,4 @@ config USB_ULPI_VIEWPORT
 	  Provides read/write operations to the ULPI phy register set for
 	  controllers with a viewport register (e.g. Chipidea/ARC controllers).
 
-config JZ4770_PHY
-	tristate "Ingenic SoCs Transceiver Driver"
-	depends on MIPS || COMPILE_TEST
-	select USB_PHY
-	help
-	  This driver provides PHY support for the USB controller found
-	  on the JZ-series and X-series SoCs from Ingenic.
-
 endmenu
diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
index b352bdbe8712..df1d99010079 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -24,4 +24,3 @@ obj-$(CONFIG_USB_MXS_PHY)		+= phy-mxs-usb.o
 obj-$(CONFIG_USB_ULPI)			+= phy-ulpi.o
 obj-$(CONFIG_USB_ULPI_VIEWPORT)		+= phy-ulpi-viewport.o
 obj-$(CONFIG_KEYSTONE_USB_PHY)		+= phy-keystone.o
-obj-$(CONFIG_JZ4770_PHY)		+= phy-jz4770.o
-- 
2.11.0

