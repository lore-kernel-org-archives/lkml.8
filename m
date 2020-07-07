Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB785C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 23:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0CED2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 23:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgGGX2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 19:28:48 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42926 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728201AbgGGX2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 19:28:48 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C3EEC200988;
        Wed,  8 Jul 2020 01:28:45 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 10CE220000C;
        Wed,  8 Jul 2020 01:28:37 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 30F76402C8;
        Wed,  8 Jul 2020 07:28:26 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, oleksandr.suvorov@toradex.com,
        aford173@gmail.com, andreas@kemnade.info, hverkuil-cisco@xs4all.nl,
        bjorn.andersson@linaro.org, leoyang.li@nxp.com, vkoul@kernel.org,
        geert+renesas@glider.be, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/3] gpio: mxc: Support module build
Date:   Wed,  8 Jul 2020 07:25:21 +0800
Message-Id: <1594164323-14920-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change config to tristate, add module device table, module author,
description and license to support module build for i.MX GPIO driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/gpio/Kconfig    | 2 +-
 drivers/gpio/gpio-mxc.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 05e0801..4d09ec5 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -397,7 +397,7 @@ config GPIO_MVEBU
 	select REGMAP_MMIO
 
 config GPIO_MXC
-	def_bool y
+	tristate "i.MX GPIO support"
 	depends on ARCH_MXC || COMPILE_TEST
 	select GPIO_GENERIC
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 64278a4..643f4c55 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -15,6 +15,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/syscore_ops.h>
@@ -158,6 +159,7 @@ static const struct of_device_id mxc_gpio_dt_ids[] = {
 	{ .compatible = "fsl,imx7d-gpio", .data = &mxc_gpio_devtype[IMX35_GPIO], },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, mxc_gpio_dt_ids);
 
 /*
  * MX2 has one interrupt *for all* gpio ports. The list is used
@@ -604,3 +606,7 @@ static int __init gpio_mxc_init(void)
 	return platform_driver_register(&mxc_gpio_driver);
 }
 subsys_initcall(gpio_mxc_init);
+
+MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
+MODULE_DESCRIPTION("i.MX GPIO Driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

