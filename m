Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1337AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3670207ED
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbgFHOs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 10:48:56 -0400
Received: from inva020.nxp.com ([92.121.34.13]:46544 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730103AbgFHOs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 10:48:27 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2F2021A26C4;
        Mon,  8 Jun 2020 16:48:25 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A44551A0127;
        Mon,  8 Jun 2020 16:48:20 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C4B94402F3;
        Mon,  8 Jun 2020 22:48:14 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        stefan@agner.ch, kernel@pengutronix.de, linus.walleij@linaro.org,
        s.hauer@pengutronix.de, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 5/9] pinctrl: imx8mq: Support building as module
Date:   Mon,  8 Jun 2020 22:37:32 +0800
Message-Id: <1591627056-19022-6-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591627056-19022-1-git-send-email-Anson.Huang@nxp.com>
References: <1591627056-19022-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support building i.MX8MQ pinctrl driver as module.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 drivers/pinctrl/freescale/Kconfig          | 2 +-
 drivers/pinctrl/freescale/pinctrl-imx8mq.c | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
index 4bb6aeb..f194996 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -145,7 +145,7 @@ config PINCTRL_IMX8MP
 	  Say Y here to enable the imx8mp pinctrl driver
 
 config PINCTRL_IMX8MQ
-	bool "IMX8MQ pinctrl driver"
+	tristate "IMX8MQ pinctrl driver"
 	depends on ARCH_MXC
 	select PINCTRL_IMX
 	help
diff --git a/drivers/pinctrl/freescale/pinctrl-imx8mq.c b/drivers/pinctrl/freescale/pinctrl-imx8mq.c
index 50aa1c0..db5b41a 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx8mq.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx8mq.c
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
@@ -329,6 +330,7 @@ static const struct of_device_id imx8mq_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx8mq-iomuxc", .data = &imx8mq_pinctrl_info, },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, imx8mq_pinctrl_of_match);
 
 static int imx8mq_pinctrl_probe(struct platform_device *pdev)
 {
@@ -345,8 +347,5 @@ static struct platform_driver imx8mq_pinctrl_driver = {
 	.probe = imx8mq_pinctrl_probe,
 };
 
-static int __init imx8mq_pinctrl_init(void)
-{
-	return platform_driver_register(&imx8mq_pinctrl_driver);
-}
-arch_initcall(imx8mq_pinctrl_init);
+module_platform_driver(imx8mq_pinctrl_driver);
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

