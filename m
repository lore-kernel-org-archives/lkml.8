Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB140C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868D320675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgCIM6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 08:58:55 -0400
Received: from v6.sk ([167.172.42.174]:34434 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgCIM6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:58:55 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id AF58360EEE;
        Mon,  9 Mar 2020 12:58:52 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] phy: Add USB HSIC PHY driver for Marvell MMP3 SoC
Date:   Mon,  9 Mar 2020 13:58:48 +0100
Message-Id: <20200309125848.547664-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PHY driver for the HSICs found on Marvell MMP3 SoC. The driver is
rather straightforward -- the PHY essentially just needs to be enabled.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/phy/marvell/Kconfig         | 12 +++++
 drivers/phy/marvell/Makefile        |  1 +
 drivers/phy/marvell/phy-mmp3-hsic.c | 82 +++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 drivers/phy/marvell/phy-mmp3-hsic.c

diff --git a/drivers/phy/marvell/Kconfig b/drivers/phy/marvell/Kconfig
index 8f6273c837ec3..6c96f2bf52665 100644
--- a/drivers/phy/marvell/Kconfig
+++ b/drivers/phy/marvell/Kconfig
@@ -116,3 +116,15 @@ config PHY_MMP3_USB
 	  The PHY driver will be used by Marvell udc/ehci/otg driver.
 
 	  To compile this driver as a module, choose M here.
+
+config PHY_MMP3_HSIC
+	tristate "Marvell MMP3 USB HSIC PHY Driver"
+	depends on MACH_MMP3_DT || COMPILE_TEST
+	select GENERIC_PHY
+	help
+	  Enable this to support Marvell MMP3 USB HSIC PHY driver for
+	  Marvell MMP3 SoC. This driver will be used my the Marvell EHCI
+	  driver to initialize the interface to internal USB HSIC
+	  components on MMP3-based boards.
+
+	  To compile this driver as a module, choose M here.
diff --git a/drivers/phy/marvell/Makefile b/drivers/phy/marvell/Makefile
index 5a106b1549f41..7f296ef028292 100644
--- a/drivers/phy/marvell/Makefile
+++ b/drivers/phy/marvell/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+= phy-armada375-usb2.o
 obj-$(CONFIG_PHY_BERLIN_SATA)		+= phy-berlin-sata.o
 obj-$(CONFIG_PHY_BERLIN_USB)		+= phy-berlin-usb.o
 obj-$(CONFIG_PHY_MMP3_USB)		+= phy-mmp3-usb.o
+obj-$(CONFIG_PHY_MMP3_HSIC)		+= phy-mmp3-hsic.o
 obj-$(CONFIG_PHY_MVEBU_A3700_COMPHY)	+= phy-mvebu-a3700-comphy.o
 obj-$(CONFIG_PHY_MVEBU_A3700_UTMI)	+= phy-mvebu-a3700-utmi.o
 obj-$(CONFIG_PHY_MVEBU_A38X_COMPHY)	+= phy-armada38x-comphy.o
diff --git a/drivers/phy/marvell/phy-mmp3-hsic.c b/drivers/phy/marvell/phy-mmp3-hsic.c
new file mode 100644
index 0000000000000..f7b430f6f6f05
--- /dev/null
+++ b/drivers/phy/marvell/phy-mmp3-hsic.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020 Lubomir Rintel <lkundrak@v3.sk>
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+#define HSIC_CTRL	0x08
+#define HSIC_ENABLE	BIT(7)
+#define PLL_BYPASS	BIT(4)
+
+static int mmp3_hsic_phy_init(struct phy *phy)
+{
+	void __iomem *base = phy_get_drvdata(phy);
+	u32 hsic_ctrl;
+
+	hsic_ctrl = readl_relaxed(base + HSIC_CTRL);
+	hsic_ctrl |= HSIC_ENABLE;
+	hsic_ctrl |= PLL_BYPASS;
+	writel_relaxed(hsic_ctrl, base + HSIC_CTRL);
+
+	return 0;
+}
+
+static const struct phy_ops mmp3_hsic_phy_ops = {
+	.init		= mmp3_hsic_phy_init,
+	.owner		= THIS_MODULE,
+};
+
+static const struct of_device_id mmp3_hsic_phy_of_match[] = {
+	{ .compatible = "marvell,mmp3-hsic-phy", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mmp3_hsic_phy_of_match);
+
+static int mmp3_hsic_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct phy_provider *provider;
+	struct resource *resource;
+	void __iomem *base;
+	struct phy *phy;
+
+	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, resource);
+	if (IS_ERR(base)) {
+		dev_err(dev, "failed to remap PHY regs\n");
+		return PTR_ERR(base);
+	}
+
+	phy = devm_phy_create(dev, NULL, &mmp3_hsic_phy_ops);
+	if (IS_ERR(phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(phy);
+	}
+
+	phy_set_drvdata(phy, base);
+	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(provider)) {
+		dev_err(dev, "failed to register PHY provider\n");
+		return PTR_ERR(provider);
+	}
+
+	return 0;
+}
+
+static struct platform_driver mmp3_hsic_phy_driver = {
+	.probe		= mmp3_hsic_phy_probe,
+	.driver		= {
+		.name	= "mmp3-hsic-phy",
+		.of_match_table = mmp3_hsic_phy_of_match,
+	},
+};
+module_platform_driver(mmp3_hsic_phy_driver);
+
+MODULE_AUTHOR("Lubomir Rintel <lkundrak@v3.sk>");
+MODULE_DESCRIPTION("Marvell MMP3 USB HSIC PHY Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

