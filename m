Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A25C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBC6920659
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbgFHOsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 10:48:30 -0400
Received: from inva021.nxp.com ([92.121.34.21]:38412 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730098AbgFHOsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 10:48:23 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8DA7D200E60;
        Mon,  8 Jun 2020 16:48:21 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0DFF6200E67;
        Mon,  8 Jun 2020 16:48:17 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 86B81402F0;
        Mon,  8 Jun 2020 22:48:11 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        stefan@agner.ch, kernel@pengutronix.de, linus.walleij@linaro.org,
        s.hauer@pengutronix.de, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 2/9] pinctrl: imx: Support building i.MX pinctrl driver as module
Date:   Mon,  8 Jun 2020 22:37:29 +0800
Message-Id: <1591627056-19022-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591627056-19022-1-git-send-email-Anson.Huang@nxp.com>
References: <1591627056-19022-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export necessary functions to support building i.MX common pinctrl
driver and its user to be built as module.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- Separate i.MX and i.MX SCU pinctrl driver to 2 patches;
	- Support building i.MX common pinctrl driver itself as module.
---
 drivers/pinctrl/freescale/Kconfig       | 2 +-
 drivers/pinctrl/freescale/pinctrl-imx.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
index a3a30f1d..58d48df 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config PINCTRL_IMX
-	bool
+	tristate "IMX pinctrl driver"
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
 	select GENERIC_PINCONF
diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index cb7e0f0..116d808 100644
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
@@ -897,3 +899,5 @@ const struct dev_pm_ops imx_pinctrl_pm_ops = {
 	SET_LATE_SYSTEM_SLEEP_PM_OPS(imx_pinctrl_suspend,
 					imx_pinctrl_resume)
 };
+EXPORT_SYMBOL_GPL(imx_pinctrl_pm_ops);
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

