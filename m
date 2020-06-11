Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB34C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 459D52078D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgFKLqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:46:00 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38388 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgFKLp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:45:58 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 513B41A0713;
        Thu, 11 Jun 2020 13:45:56 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C50A41A070A;
        Thu, 11 Jun 2020 13:45:51 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E4BE4402BF;
        Thu, 11 Jun 2020 19:45:45 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        stefan@agner.ch, kernel@pengutronix.de, linus.walleij@linaro.org,
        s.hauer@pengutronix.de, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V5 2/9] pinctrl: imx: Support building i.MX pinctrl driver as module
Date:   Thu, 11 Jun 2020 19:34:48 +0800
Message-Id: <1591875295-19427-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591875295-19427-1-git-send-email-Anson.Huang@nxp.com>
References: <1591875295-19427-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export necessary functions to support building i.MX common pinctrl
driver and its user to be built as module.

i.MX common pinctrl driver should depend on CONFIG_OF to make sure
no build error when i.MX common pinctrl driver is enabled for difference
architectures without CONFIG_OF.

Also, module author, description and license should be added.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V4:
	- add module author and description.
---
 drivers/pinctrl/freescale/Kconfig       | 3 ++-
 drivers/pinctrl/freescale/pinctrl-imx.c | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
index a3a30f1d..e281c3f 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config PINCTRL_IMX
-	bool
+	tristate "IMX pinctrl driver"
+	depends on OF
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
 	select GENERIC_PINCONF
diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index c1faae1..28be1d6 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_address.h>
@@ -878,6 +879,7 @@ int imx_pinctrl_probe(struct platform_device *pdev,
 
 	return pinctrl_enable(ipctl->pctl);
 }
+EXPORT_SYMBOL_GPL(imx_pinctrl_probe);
 
 static int __maybe_unused imx_pinctrl_suspend(struct device *dev)
 {
@@ -897,3 +899,8 @@ const struct dev_pm_ops imx_pinctrl_pm_ops = {
 	SET_LATE_SYSTEM_SLEEP_PM_OPS(imx_pinctrl_suspend,
 					imx_pinctrl_resume)
 };
+EXPORT_SYMBOL_GPL(imx_pinctrl_pm_ops);
+
+MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
+MODULE_DESCRIPTION("NXP i.MX common pinctrl driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

