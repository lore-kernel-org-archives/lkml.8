Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF04AC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D8D2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgCCJEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:04:21 -0500
Received: from inva020.nxp.com ([92.121.34.13]:36372 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbgCCJDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:03:40 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A64831A145D;
        Tue,  3 Mar 2020 10:03:37 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8F9DD1A09DD;
        Tue,  3 Mar 2020 10:03:37 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7FF9420414;
        Tue,  3 Mar 2020 10:03:36 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 01/11] mfd: Add i.MX generic mix support
Date:   Tue,  3 Mar 2020 11:03:16 +0200
Message-Id: <1583226206-19758-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com>
References: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the i.MX SoCs have a IP for interfacing the dedicated IPs with
clocks, resets and interrupts, plus some other specific control registers.
To allow the functionality to be split between drivers, this MFD driver is
added that has only two purposes: register the devices and map the entire
register addresses. Everything else is left to the dedicated drivers that will
bind to the registered devices.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/mfd/Kconfig   | 11 +++++++++++
 drivers/mfd/Makefile  |  1 +
 drivers/mfd/imx-mix.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 drivers/mfd/imx-mix.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3c547ed..3c89288 100644
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
index 00000000..d3f8c71
--- /dev/null
+++ b/drivers/mfd/imx-mix.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
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
+static int imx_audiomix_probe(struct platform_device *pdev)
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
+static const struct of_device_id imx_audiomix_of_match[] = {
+	{ .compatible = "fsl,imx8mp-audiomix" },
+	{ /* Sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, imx_audiomix_of_match);
+
+static struct platform_driver imx_audiomix_driver = {
+	.probe = imx_audiomix_probe,
+	.driver = {
+		.name = "imx-audiomix",
+		.of_match_table = of_match_ptr(imx_audiomix_of_match),
+	},
+};
+module_platform_driver(imx_audiomix_driver);
-- 
2.7.4

