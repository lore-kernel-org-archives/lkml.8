Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE1CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44806207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgFQFEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 01:04:53 -0400
Received: from inva021.nxp.com ([92.121.34.21]:56666 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgFQFEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 01:04:53 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D0B532003D0;
        Wed, 17 Jun 2020 07:04:51 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E20B82008A5;
        Wed, 17 Jun 2020 07:04:46 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9A6A3402B3;
        Wed, 17 Jun 2020 13:04:40 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, peng.fan@nxp.com, arnd@arndb.de,
        leonard.crestez@nxp.com, krzk@kernel.org, daniel.baluta@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] soc: imx-scu: Support module build
Date:   Wed, 17 Jun 2020 12:53:43 +0800
Message-Id: <1592369623-10723-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the configuration type to tristate, add module description,
author and license to support module build.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/soc/imx/Kconfig       | 2 +-
 drivers/soc/imx/soc-imx-scu.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index d515d2c..c255acb 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -9,7 +9,7 @@ config IMX_GPCV2_PM_DOMAINS
 	default y if SOC_IMX7D
 
 config IMX_SCU_SOC
-	bool "i.MX System Controller Unit SoC info support"
+	tristate "i.MX System Controller Unit SoC info support"
 	depends on IMX_SCU
 	select SOC_BUS
 	help
diff --git a/drivers/soc/imx/soc-imx-scu.c b/drivers/soc/imx/soc-imx-scu.c
index 20d37ea..bdd43ed 100644
--- a/drivers/soc/imx/soc-imx-scu.c
+++ b/drivers/soc/imx/soc-imx-scu.c
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/firmware/imx/rsrc.h>
 #include <linux/firmware/imx/sci.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 #include <linux/platform_device.h>
@@ -185,3 +186,7 @@ static int __init imx_scu_soc_init(void)
 	return PTR_ERR_OR_ZERO(pdev);
 }
 device_initcall(imx_scu_soc_init);
+
+MODULE_AUTHOR("Anson Huang <anson.huang@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX SCU SoC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

