Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA49CC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA262063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgF2Soz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:44:55 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53502 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbgF2Soo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:44:44 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8480A201028;
        Mon, 29 Jun 2020 12:25:33 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 01D6B20101F;
        Mon, 29 Jun 2020 12:25:26 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9807F402A0;
        Mon, 29 Jun 2020 18:25:16 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, arnd@arndb.de,
        stefan.agner@toradex.com, oleksandr.suvorov@toradex.com,
        bjorn.andersson@linaro.org, leoyang.li@nxp.com, vkoul@kernel.org,
        geert+renesas@glider.be, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/3] reset: imx7: Support module build
Date:   Mon, 29 Jun 2020 18:13:41 +0800
Message-Id: <1593425623-31810-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add module device table, module license to support module build.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/reset/Kconfig      | 4 ++--
 drivers/reset/reset-imx7.c | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index d9efbfd..033ab60 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -65,9 +65,9 @@ config RESET_HSDK
 	  This enables the reset controller driver for HSDK board.
 
 config RESET_IMX7
-	bool "i.MX7/8 Reset Driver" if COMPILE_TEST
+	tristate "i.MX7/8 Reset Driver"
 	depends on HAS_IOMEM
-	default SOC_IMX7D || (ARM64 && ARCH_MXC)
+	depends on SOC_IMX7D || (ARM64 && ARCH_MXC) || COMPILE_TEST
 	select MFD_SYSCON
 	help
 	  This enables the reset controller driver for i.MX7 SoCs.
diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index d170fe6..4660c93 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -8,7 +8,7 @@
  */
 
 #include <linux/mfd/syscon.h>
-#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
@@ -386,6 +386,7 @@ static const struct of_device_id imx7_reset_dt_ids[] = {
 	{ .compatible = "fsl,imx8mp-src", .data = &variant_imx8mp },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, imx7_reset_dt_ids);
 
 static struct platform_driver imx7_reset_driver = {
 	.probe	= imx7_reset_probe,
@@ -395,3 +396,4 @@ static struct platform_driver imx7_reset_driver = {
 	},
 };
 builtin_platform_driver(imx7_reset_driver);
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

