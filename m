Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2F0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EA4420674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbgHQWec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:34:32 -0400
Received: from mail.v3.sk ([167.172.186.51]:54256 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729947AbgHQWe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:34:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 283AEDFA73;
        Mon, 17 Aug 2020 22:33:30 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wEwqFHfQGGNu; Mon, 17 Aug 2020 22:33:28 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 685CEDF880;
        Mon, 17 Aug 2020 22:33:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cxjoEFMROsQ1; Mon, 17 Aug 2020 22:33:22 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 1286BDFA73;
        Mon, 17 Aug 2020 22:33:17 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [RESEND PATCH v3 3/3] phy: Add USB HSIC PHY driver for Marvell MMP3 SoC
Date:   Tue, 18 Aug 2020 00:34:00 +0200
Message-Id: <20200817223400.403505-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817223400.403505-1-lkundrak@v3.sk>
References: <20200817223400.403505-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PHY driver for the HSICs found on Marvell MMP3 SoC. The driver is
rather straightforward -- the PHY essentially just needs to be enabled.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Explicitely cast drvdata pointer to make sparse happy

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
=20
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
@@ -3,6 +3,7 @@ obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+=3D phy-armada375=
-usb2.o
 obj-$(CONFIG_PHY_BERLIN_SATA)		+=3D phy-berlin-sata.o
 obj-$(CONFIG_PHY_BERLIN_USB)		+=3D phy-berlin-usb.o
 obj-$(CONFIG_PHY_MMP3_USB)		+=3D phy-mmp3-usb.o
+obj-$(CONFIG_PHY_MMP3_HSIC)		+=3D phy-mmp3-hsic.o
 obj-$(CONFIG_PHY_MVEBU_A3700_COMPHY)	+=3D phy-mvebu-a3700-comphy.o
 obj-$(CONFIG_PHY_MVEBU_A3700_UTMI)	+=3D phy-mvebu-a3700-utmi.o
 obj-$(CONFIG_PHY_MVEBU_A38X_COMPHY)	+=3D phy-armada38x-comphy.o
diff --git a/drivers/phy/marvell/phy-mmp3-hsic.c b/drivers/phy/marvell/ph=
y-mmp3-hsic.c
new file mode 100644
index 0000000000000..47c1e8894939f
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
+	void __iomem *base =3D (void __iomem *)phy_get_drvdata(phy);
+	u32 hsic_ctrl;
+
+	hsic_ctrl =3D readl_relaxed(base + HSIC_CTRL);
+	hsic_ctrl |=3D HSIC_ENABLE;
+	hsic_ctrl |=3D PLL_BYPASS;
+	writel_relaxed(hsic_ctrl, base + HSIC_CTRL);
+
+	return 0;
+}
+
+static const struct phy_ops mmp3_hsic_phy_ops =3D {
+	.init		=3D mmp3_hsic_phy_init,
+	.owner		=3D THIS_MODULE,
+};
+
+static const struct of_device_id mmp3_hsic_phy_of_match[] =3D {
+	{ .compatible =3D "marvell,mmp3-hsic-phy", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mmp3_hsic_phy_of_match);
+
+static int mmp3_hsic_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct phy_provider *provider;
+	struct resource *resource;
+	void __iomem *base;
+	struct phy *phy;
+
+	resource =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base =3D devm_ioremap_resource(dev, resource);
+	if (IS_ERR(base)) {
+		dev_err(dev, "failed to remap PHY regs\n");
+		return PTR_ERR(base);
+	}
+
+	phy =3D devm_phy_create(dev, NULL, &mmp3_hsic_phy_ops);
+	if (IS_ERR(phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(phy);
+	}
+
+	phy_set_drvdata(phy, (void *)base);
+	provider =3D devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(provider)) {
+		dev_err(dev, "failed to register PHY provider\n");
+		return PTR_ERR(provider);
+	}
+
+	return 0;
+}
+
+static struct platform_driver mmp3_hsic_phy_driver =3D {
+	.probe		=3D mmp3_hsic_phy_probe,
+	.driver		=3D {
+		.name	=3D "mmp3-hsic-phy",
+		.of_match_table =3D mmp3_hsic_phy_of_match,
+	},
+};
+module_platform_driver(mmp3_hsic_phy_driver);
+
+MODULE_AUTHOR("Lubomir Rintel <lkundrak@v3.sk>");
+MODULE_DESCRIPTION("Marvell MMP3 USB HSIC PHY Driver");
+MODULE_LICENSE("GPL");
--=20
2.26.2

