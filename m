Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935E6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BFF4207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389322AbgFXGfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:35:43 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47426 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389209AbgFXGfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:35:39 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D75A200172;
        Wed, 24 Jun 2020 08:35:37 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E12E9200182;
        Wed, 24 Jun 2020 08:35:32 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0C813402E3;
        Wed, 24 Jun 2020 14:35:26 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        stefan@agner.ch, kernel@pengutronix.de, linus.walleij@linaro.org,
        s.hauer@pengutronix.de, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V6 4/9] pinctrl: imx8mn: Support building as module
Date:   Wed, 24 Jun 2020 14:23:59 +0800
Message-Id: <1592979844-18833-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592979844-18833-1-git-send-email-Anson.Huang@nxp.com>
References: <1592979844-18833-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change configuration to "tristate", add module device table,
author, description and license to support building i.MX8MN
pinctrl driver as module.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change.
---
 drivers/pinctrl/freescale/Kconfig          | 2 +-
 drivers/pinctrl/freescale/pinctrl-imx8mn.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
index 3681c4d..b909719 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -131,7 +131,7 @@ config PINCTRL_IMX8MM
 	  Say Y here to enable the imx8mm pinctrl driver
 
 config PINCTRL_IMX8MN
-	bool "IMX8MN pinctrl driver"
+	tristate "IMX8MN pinctrl driver"
 	depends on ARCH_MXC
 	select PINCTRL_IMX
 	help
diff --git a/drivers/pinctrl/freescale/pinctrl-imx8mn.c b/drivers/pinctrl/freescale/pinctrl-imx8mn.c
index 100ed8c..14c9deb 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx8mn.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx8mn.c
@@ -5,6 +5,7 @@
 
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
@@ -326,6 +327,7 @@ static const struct of_device_id imx8mn_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx8mn-iomuxc", .data = &imx8mn_pinctrl_info, },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, imx8mn_pinctrl_of_match);
 
 static int imx8mn_pinctrl_probe(struct platform_device *pdev)
 {
@@ -346,3 +348,7 @@ static int __init imx8mn_pinctrl_init(void)
 	return platform_driver_register(&imx8mn_pinctrl_driver);
 }
 arch_initcall(imx8mn_pinctrl_init);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX8MN pinctrl driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

