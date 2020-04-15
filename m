Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1D6C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4002192A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635539AbgDOIGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:06:41 -0400
Received: from inva020.nxp.com ([92.121.34.13]:39724 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408042AbgDOID2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:03:28 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 065C51A079B;
        Wed, 15 Apr 2020 10:03:06 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ED3BE1A079F;
        Wed, 15 Apr 2020 10:03:05 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 5E8DC202B0;
        Wed, 15 Apr 2020 10:03:05 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lee Jones <lee.jones@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v3 01/13] mfd: Add i.MX generic mix support
Date:   Wed, 15 Apr 2020 11:02:41 +0300
Message-Id: <1586937773-5836-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586937773-5836-1-git-send-email-abel.vesa@nxp.com>
References: <1586937773-5836-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the i.MX SoCs have a IP for interfacing the dedicated IPs with
clocks, resets and interrupts, plus some other specific control registers.
To allow the functionality to be split between drivers, this MFD driver is
added that has only two purposes: register the devices and map the entire
register addresses. Everything else is left to the dedicated drivers that
will bind to the registered devices.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/mfd/Kconfig   | 11 +++++++++++
 drivers/mfd/Makefile  |  1 +
 drivers/mfd/imx-mix.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 drivers/mfd/imx-mix.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 0a59249..7eeb17f 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -460,6 +460,17 @@ config MFD_MX25_TSADC
 	  i.MX25 processors. They consist of a conversion queue for general
 	  purpose ADC and a queue for Touchscreens.
 
+config MFD_IMX_MIX
+	tristate "NXP i.MX Generic Mix Control Driver"
+	depends on OF || COMPILE_TEST
+	help
+	  Enable generic mixes support. On some i.MX platforms, there are
+	  devices that are a mix of multiple functionalities like reset
+	  controllers, clock controllers and some others. In order to split
+	  those functionalities between the right drivers, this MFD populates
+	  with virtual devices based on what's found in the devicetree node,
+	  leaving the rest of the behavior control to the dedicated driver.
+
 config MFD_HI6421_PMIC
 	tristate "HiSilicon Hi6421 PMU/Codec IC"
 	depends on OF
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f935d10..5b2ae5d 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -113,6 +113,7 @@ obj-$(CONFIG_MFD_TWL4030_AUDIO)	+= twl4030-audio.o
 obj-$(CONFIG_TWL6040_CORE)	+= twl6040.o
 
 obj-$(CONFIG_MFD_MX25_TSADC)	+= fsl-imx25-tsadc.o
+obj-$(CONFIG_MFD_IMX_MIX)	+= imx-mix.o
 
 obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
 obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
diff --git a/drivers/mfd/imx-mix.c b/drivers/mfd/imx-mix.c
new file mode 100644
index 00000000..4ea456f
--- /dev/null
+++ b/drivers/mfd/imx-mix.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2019 NXP.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+
+#include <linux/mfd/core.h>
+
+static int imx_mix_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *base;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	dev_set_drvdata(dev, base);
+
+	return devm_of_platform_populate(dev);
+}
+
+static const struct of_device_id imx_mix_of_match[] = {
+	{ .compatible = "fsl,imx8mp-mix" },
+	{ /* Sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, imx_mix_of_match);
+
+static struct platform_driver imx_mix_driver = {
+	.probe = imx_mix_probe,
+	.driver = {
+		.name = "imx-mix",
+		.of_match_table = of_match_ptr(imx_mix_of_match),
+	},
+};
+module_platform_driver(imx_mix_driver);
-- 
2.7.4

