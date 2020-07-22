Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D65C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CA5620656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgGVGeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 02:34:37 -0400
Received: from out28-146.mail.aliyun.com ([115.124.28.146]:51432 "EHLO
        out28-146.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgGVGeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:34:36 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0360785-0.000278501-0.963643;FP=0|0|0|0|0|-1|-1|-1;HT=e01l04362;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.I5ji.5V_1595399657;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I5ji.5V_1595399657)
          by smtp.aliyun-inc.com(10.147.44.129);
          Wed, 22 Jul 2020 14:34:25 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, paul@crapouillou.net,
        prasannatsmkumar@gmail.com, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH v4 2/3] USB: PHY: JZ4770: Add support for new Ingenic SoCs.
Date:   Wed, 22 Jul 2020 14:33:54 +0800
Message-Id: <20200722063355.67781-3-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200722063355.67781-1-zhouyanjie@wanyeetech.com>
References: <20200722063355.67781-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for probing the phy-jz4770 driver on the JZ4780 SoC,
the X1000 SoC and the X1830 SoC from Ingenic.

Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
Co-developed-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
Signed-off-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---

Notes:
    v1->v2:
    Add bindings for the JZ4780 SoC.
    
    v2->v3:
    Use "of_device_get_match_data" instead "of_match_device"
    to get version information.
    
    v3->v4:
    Fix typos.

 drivers/usb/phy/Kconfig      |   4 +-
 drivers/usb/phy/phy-jz4770.c | 174 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 133 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 4b3fa78995cf..775f0dd7b5f5 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -185,11 +185,11 @@ config USB_ULPI_VIEWPORT
 	  controllers with a viewport register (e.g. Chipidea/ARC controllers).
 
 config JZ4770_PHY
-	tristate "Ingenic JZ4770 Transceiver Driver"
+	tristate "Ingenic SoCs Transceiver Driver"
 	depends on MIPS || COMPILE_TEST
 	select USB_PHY
 	help
 	  This driver provides PHY support for the USB controller found
-	  on the JZ4770 SoC from Ingenic.
+	  on the JZ4770/JZ4780/X1000/X1830 SoC from Ingenic.
 
 endmenu
diff --git a/drivers/usb/phy/phy-jz4770.c b/drivers/usb/phy/phy-jz4770.c
index 8f62dc2a90ff..cd49b32b4c13 100644
--- a/drivers/usb/phy/phy-jz4770.c
+++ b/drivers/usb/phy/phy-jz4770.c
@@ -1,27 +1,30 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Ingenic JZ4770 USB PHY driver
+ * Ingenic SoCs USB PHY driver
  * Copyright (c) Paul Cercueil <paul@crapouillou.net>
+ * Copyright (c) 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
+ * Copyright (c) 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
  */
 
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/phy.h>
 
+/* OTGPHY register offsets */
 #define REG_USBPCR_OFFSET	0x00
 #define REG_USBRDT_OFFSET	0x04
 #define REG_USBVBFIL_OFFSET	0x08
 #define REG_USBPCR1_OFFSET	0x0c
 
-/* USBPCR */
+/* bits within the USBPCR register */
 #define USBPCR_USB_MODE		BIT(31)
 #define USBPCR_AVLD_REG		BIT(30)
-#define USBPCR_INCRM		BIT(27)
-#define USBPCR_CLK12_EN		BIT(26)
+#define USBPCR_INCR_MASK	BIT(27)
 #define USBPCR_COMMONONN	BIT(25)
 #define USBPCR_VBUSVLDEXT	BIT(24)
 #define USBPCR_VBUSVLDEXTSEL	BIT(23)
@@ -32,46 +35,80 @@
 
 #define USBPCR_IDPULLUP_LSB	28
 #define USBPCR_IDPULLUP_MASK	GENMASK(29, USBPCR_IDPULLUP_LSB)
-#define USBPCR_IDPULLUP_ALWAYS	(3 << USBPCR_IDPULLUP_LSB)
-#define USBPCR_IDPULLUP_SUSPEND	(1 << USBPCR_IDPULLUP_LSB)
-#define USBPCR_IDPULLUP_OTG	(0 << USBPCR_IDPULLUP_LSB)
+#define USBPCR_IDPULLUP_ALWAYS	(0x2 << USBPCR_IDPULLUP_LSB)
+#define USBPCR_IDPULLUP_SUSPEND	(0x1 << USBPCR_IDPULLUP_LSB)
+#define USBPCR_IDPULLUP_OTG	(0x0 << USBPCR_IDPULLUP_LSB)
 
 #define USBPCR_COMPDISTUNE_LSB	17
 #define USBPCR_COMPDISTUNE_MASK	GENMASK(19, USBPCR_COMPDISTUNE_LSB)
-#define USBPCR_COMPDISTUNE_DFT	4
+#define USBPCR_COMPDISTUNE_DFT	(0x4 << USBPCR_COMPDISTUNE_LSB)
 
 #define USBPCR_OTGTUNE_LSB	14
 #define USBPCR_OTGTUNE_MASK	GENMASK(16, USBPCR_OTGTUNE_LSB)
-#define USBPCR_OTGTUNE_DFT	4
+#define USBPCR_OTGTUNE_DFT	(0x4 << USBPCR_OTGTUNE_LSB)
 
 #define USBPCR_SQRXTUNE_LSB	11
 #define USBPCR_SQRXTUNE_MASK	GENMASK(13, USBPCR_SQRXTUNE_LSB)
-#define USBPCR_SQRXTUNE_DFT	3
+#define USBPCR_SQRXTUNE_DCR_20PCT	(0x7 << USBPCR_SQRXTUNE_LSB)
+#define USBPCR_SQRXTUNE_DFT	(0x3 << USBPCR_SQRXTUNE_LSB)
 
 #define USBPCR_TXFSLSTUNE_LSB	7
 #define USBPCR_TXFSLSTUNE_MASK	GENMASK(10, USBPCR_TXFSLSTUNE_LSB)
-#define USBPCR_TXFSLSTUNE_DFT	3
+#define USBPCR_TXFSLSTUNE_DCR_50PPT	(0xf << USBPCR_TXFSLSTUNE_LSB)
+#define USBPCR_TXFSLSTUNE_DCR_25PPT	(0x7 << USBPCR_TXFSLSTUNE_LSB)
+#define USBPCR_TXFSLSTUNE_DFT	(0x3 << USBPCR_TXFSLSTUNE_LSB)
+#define USBPCR_TXFSLSTUNE_INC_25PPT	(0x1 << USBPCR_TXFSLSTUNE_LSB)
+#define USBPCR_TXFSLSTUNE_INC_50PPT	(0x0 << USBPCR_TXFSLSTUNE_LSB)
+
+#define USBPCR_TXHSXVTUNE_LSB	4
+#define USBPCR_TXHSXVTUNE_MASK	GENMASK(5, USBPCR_TXHSXVTUNE_LSB)
+#define USBPCR_TXHSXVTUNE_DFT	(0x3 << USBPCR_TXHSXVTUNE_LSB)
+#define USBPCR_TXHSXVTUNE_DCR_15MV	(0x1 << USBPCR_TXHSXVTUNE_LSB)
 
 #define USBPCR_TXRISETUNE_LSB	4
 #define USBPCR_TXRISETUNE_MASK	GENMASK(5, USBPCR_TXRISETUNE_LSB)
-#define USBPCR_TXRISETUNE_DFT	3
+#define USBPCR_TXRISETUNE_DFT	(0x3 << USBPCR_TXRISETUNE_LSB)
 
 #define USBPCR_TXVREFTUNE_LSB	0
 #define USBPCR_TXVREFTUNE_MASK	GENMASK(3, USBPCR_TXVREFTUNE_LSB)
-#define USBPCR_TXVREFTUNE_DFT	5
+#define USBPCR_TXVREFTUNE_INC_25PPT	(0x7 << USBPCR_TXVREFTUNE_LSB)
+#define USBPCR_TXVREFTUNE_DFT	(0x5 << USBPCR_TXVREFTUNE_LSB)
 
-/* USBRDT */
+/* bits within the USBRDTR register */
+#define USBRDT_UTMI_RST		BIT(27)
+#define USBRDT_HB_MASK		BIT(26)
 #define USBRDT_VBFIL_LD_EN	BIT(25)
 #define USBRDT_IDDIG_EN		BIT(24)
 #define USBRDT_IDDIG_REG	BIT(23)
-
-#define USBRDT_USBRDT_LSB	0
-#define USBRDT_USBRDT_MASK	GENMASK(22, USBRDT_USBRDT_LSB)
-
-/* USBPCR1 */
-#define USBPCR1_UHC_POWON	BIT(5)
+#define USBRDT_VBFIL_EN		BIT(2)
+
+/* bits within the USBPCR1 register */
+#define USBPCR1_BVLD_REG			BIT(31)
+#define USBPCR1_DPPD				BIT(29)
+#define USBPCR1_DMPD				BIT(28)
+#define USBPCR1_USB_SEL				BIT(28)
+#define USBPCR1_WORD_IF_16BIT		BIT(19)
+
+#define USBPCR1_REFCLKSEL_LSB		26
+#define USBPCR1_REFCLKSEL_MASK		GENMASK(27, USBPCR1_REFCLKDIV_LSB)
+#define USBPCR1_REFCLKSEL_CLKCORE	(0x3 << USBPCR1_REFCLKSEL_LSB)
+
+#define USBPCR1_REFCLKDIV_LSB		24
+#define USBPCR1_REFCLKDIV_MASK		GENMASK(25, USBPCR1_REFCLKDIV_LSB)
+#define USBPCR1_REFCLKDIV_48M		(0x2 << USBPCR1_REFCLKDIV_LSB)
+#define USBPCR1_REFCLKDIV_24M		(0x1 << USBPCR1_REFCLKDIV_LSB)
+#define USBPCR1_REFCLKDIV_12M		(0x0 << USBPCR1_REFCLKDIV_LSB)
+
+enum ingenic_usb_phy_version {
+	ID_JZ4770,
+	ID_JZ4780,
+	ID_X1000,
+	ID_X1830,
+};
 
 struct jz4770_phy {
+	enum ingenic_usb_phy_version version;
+
 	struct usb_phy phy;
 	struct usb_otg otg;
 	struct device *dev;
@@ -96,6 +133,12 @@ static int jz4770_phy_set_peripheral(struct usb_otg *otg,
 	struct jz4770_phy *priv = otg_to_jz4770_phy(otg);
 	u32 reg;
 
+	if (priv->version >= ID_X1000) {
+		reg = readl(priv->base + REG_USBPCR1_OFFSET);
+		reg |= USBPCR1_BVLD_REG;
+		writel(reg, priv->base + REG_USBPCR1_OFFSET);
+	}
+
 	reg = readl(priv->base + REG_USBPCR_OFFSET);
 	reg &= ~USBPCR_USB_MODE;
 	reg |= USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL | USBPCR_OTG_DISABLE;
@@ -135,17 +178,59 @@ static int jz4770_phy_init(struct usb_phy *phy)
 		return err;
 	}
 
-	reg = USBPCR_AVLD_REG | USBPCR_COMMONONN | USBPCR_IDPULLUP_ALWAYS |
-		(USBPCR_COMPDISTUNE_DFT << USBPCR_COMPDISTUNE_LSB) |
-		(USBPCR_OTGTUNE_DFT << USBPCR_OTGTUNE_LSB) |
-		(USBPCR_SQRXTUNE_DFT << USBPCR_SQRXTUNE_LSB) |
-		(USBPCR_TXFSLSTUNE_DFT << USBPCR_TXFSLSTUNE_LSB) |
-		(USBPCR_TXRISETUNE_DFT << USBPCR_TXRISETUNE_LSB) |
-		(USBPCR_TXVREFTUNE_DFT << USBPCR_TXVREFTUNE_LSB) |
-		USBPCR_POR;
+	if (priv->version >= ID_X1830) {
+		/* rdt */
+		writel(USBRDT_VBFIL_EN | USBRDT_UTMI_RST, priv->base + REG_USBRDT_OFFSET);
+
+		reg = readl(priv->base + REG_USBPCR1_OFFSET) | USBPCR1_WORD_IF_16BIT |
+			USBPCR1_DMPD | USBPCR1_DPPD;
+		writel(reg, priv->base + REG_USBPCR1_OFFSET);
+
+		reg = USBPCR_IDPULLUP_OTG | USBPCR_VBUSVLDEXT |	USBPCR_TXPREEMPHTUNE;
+	} else if (priv->version >= ID_X1000) {
+		reg = readl(priv->base + REG_USBPCR1_OFFSET) | USBPCR1_WORD_IF_16BIT;
+		writel(reg, priv->base + REG_USBPCR1_OFFSET);
+
+		reg = USBPCR_SQRXTUNE_DCR_20PCT | USBPCR_TXPREEMPHTUNE |
+			USBPCR_TXHSXVTUNE_DCR_15MV | USBPCR_TXVREFTUNE_INC_25PPT;
+	} else if (priv->version >= ID_JZ4780) {
+		reg = readl(priv->base + REG_USBPCR1_OFFSET) | USBPCR1_USB_SEL |
+			USBPCR1_WORD_IF_16BIT;
+		writel(reg, priv->base + REG_USBPCR1_OFFSET);
+
+		reg = USBPCR_TXPREEMPHTUNE;
+	} else {
+		reg = USBPCR_AVLD_REG | USBPCR_IDPULLUP_ALWAYS |
+			USBPCR_COMPDISTUNE_DFT | USBPCR_OTGTUNE_DFT |
+			USBPCR_SQRXTUNE_DFT | USBPCR_TXFSLSTUNE_DFT |
+			USBPCR_TXRISETUNE_DFT | USBPCR_TXVREFTUNE_DFT;
+	}
+
+	reg |= USBPCR_COMMONONN | USBPCR_POR;
 	writel(reg, priv->base + REG_USBPCR_OFFSET);
 
-	/* Wait for PHY to reset */
+	/*
+	 * Power-On Reset(POR)
+	 * Function:This customer-specific signal resets all test registers
+	 * and state machines in the USB 2.0 nanoPHY.
+	 * The POR signal must be asserted for a minimum of 10 μs.
+	 * For POR timing information:
+	 *
+	 * T0: Power-on reset (POR) is initiated. 0 (reference).
+	 * T1: T1 indicates when POR can be set to 1’b0. (To provide examples,
+	 * values for T2 and T3 are also shown where T1 = T0 + 30 μs.);
+	 * In general, T1 must be ≥ T0 + 10 μs. T0 + 10 μs ≤ T1.
+	 * T2: T2 indicates when PHYCLOCK, CLK48MOHCI, and CLK12MOHCI are
+	 * available at the macro output, based on the USB 2.0 nanoPHY
+	 * reference clock source.
+	 * Crystal:
+	 *    • When T1 = T0 + 10 μs:
+	 *      T2 < T1 + 805 μs = T0 + 815 μs
+	 *    • When T1 = T0 + 30 μs:
+	 *      T2 < T1 + 805 μs = T0 + 835 μs
+	 * see "Reset and Power-Saving Signals" on page 60 an “Powering Up
+	 * and Powering Down the USB 2.0 nanoPHY” on page 73.
+	 */
 	usleep_range(30, 300);
 	writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
 	usleep_range(300, 1000);
@@ -166,6 +251,15 @@ static void jz4770_phy_remove(void *phy)
 	usb_remove_phy(phy);
 }
 
+static const struct of_device_id ingenic_usb_phy_of_matches[] = {
+	{ .compatible = "ingenic,jz4770-phy", .data = (void *) ID_JZ4770 },
+	{ .compatible = "ingenic,jz4780-phy", .data = (void *) ID_JZ4780 },
+	{ .compatible = "ingenic,x1000-phy", .data = (void *) ID_X1000 },
+	{ .compatible = "ingenic,x1830-phy", .data = (void *) ID_X1830 },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ingenic_usb_phy_of_matches);
+
 static int jz4770_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -176,11 +270,13 @@ static int jz4770_phy_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->version = (enum ingenic_usb_phy_version)of_device_get_match_data(dev);
+
 	platform_set_drvdata(pdev, priv);
 	priv->dev = dev;
 	priv->phy.dev = dev;
 	priv->phy.otg = &priv->otg;
-	priv->phy.label = "jz4770-phy";
+	priv->phy.label = "ingenic-usb-phy";
 	priv->phy.init = jz4770_phy_init;
 	priv->phy.shutdown = jz4770_phy_shutdown;
 
@@ -221,23 +317,15 @@ static int jz4770_phy_probe(struct platform_device *pdev)
 	return devm_add_action_or_reset(dev, jz4770_phy_remove, &priv->phy);
 }
 
-#ifdef CONFIG_OF
-static const struct of_device_id jz4770_phy_of_matches[] = {
-	{ .compatible = "ingenic,jz4770-phy" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, jz4770_phy_of_matches);
-#endif
-
-static struct platform_driver jz4770_phy_driver = {
+static struct platform_driver ingenic_usb_phy_driver = {
 	.probe		= jz4770_phy_probe,
 	.driver		= {
-		.name	= "jz4770-phy",
-		.of_match_table = of_match_ptr(jz4770_phy_of_matches),
+		.name	= "ingenic-usb-phy",
+		.of_match_table = of_match_ptr(ingenic_usb_phy_of_matches),
 	},
 };
-module_platform_driver(jz4770_phy_driver);
+module_platform_driver(ingenic_usb_phy_driver);
 
 MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
-MODULE_DESCRIPTION("Ingenic JZ4770 USB PHY driver");
+MODULE_DESCRIPTION("Ingenic SoCs USB PHY driver");
 MODULE_LICENSE("GPL");
-- 
2.11.0

