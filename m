Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88710C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C8E420FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgG2OxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:53:18 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59120 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbgG2OxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:53:17 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5A5FF1A01FA;
        Wed, 29 Jul 2020 16:53:15 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A06891A0DFF;
        Wed, 29 Jul 2020 16:53:08 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DC0824031F;
        Wed, 29 Jul 2020 16:52:55 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, arnd@arndb.de, peng.fan@nxp.com,
        abel.vesa@nxp.com, fugang.duan@nxp.com, daniel.baluta@nxp.com,
        yuehaibing@huawei.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V7 6/6] clk: imx8qxp: Support building i.MX8QXP clock driver as module
Date:   Wed, 29 Jul 2020 22:48:37 +0800
Message-Id: <1596034117-24246-7-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596034117-24246-1-git-send-email-Anson.Huang@nxp.com>
References: <1596034117-24246-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change configuration to "tristate", add module author, description and
license to support building i.MX8QXP clock drivers as module.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
no change.
---
 drivers/clk/imx/Kconfig            | 10 ++++++----
 drivers/clk/imx/Makefile           |  9 ++++-----
 drivers/clk/imx/clk-imx8qxp-lpcg.c |  4 ++++
 drivers/clk/imx/clk-imx8qxp.c      |  4 ++++
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 3897712..e7defba 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -5,8 +5,9 @@ config MXC_CLK
 	depends on ARCH_MXC || COMPILE_TEST
 
 config MXC_CLK_SCU
-	bool
-	depends on IMX_SCU
+	tristate "IMX SCU clock"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on IMX_SCU && HAVE_ARM_SMCCC
 
 config CLK_IMX1
 	def_bool SOC_IMX1
@@ -97,8 +98,9 @@ config CLK_IMX8MQ
 	    Build the driver for i.MX8MQ CCM Clock Driver
 
 config CLK_IMX8QXP
-	bool "IMX8QXP SCU Clock"
-	depends on ARCH_MXC && IMX_SCU && ARM64
+	tristate "IMX8QXP SCU Clock"
+	depends on (ARCH_MXC && ARM64) || COMPILE_TEST
+	depends on IMX_SCU && HAVE_ARM_SMCCC
 	select MXC_CLK_SCU
 	help
 	  Build the driver for IMX8QXP SCU based clocks.
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 17f5d12..79e53f2 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -21,15 +21,14 @@ mxc-clk-objs += clk-pll14xx.o
 mxc-clk-objs += clk-sscg-pll.o
 obj-$(CONFIG_MXC_CLK) += mxc-clk.o
 
-obj-$(CONFIG_MXC_CLK_SCU) += \
-	clk-scu.o \
-	clk-lpcg-scu.o
-
 obj-$(CONFIG_CLK_IMX8MM) += clk-imx8mm.o
 obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
 obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o
 obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
-obj-$(CONFIG_CLK_IMX8QXP) += clk-imx8qxp.o clk-imx8qxp-lpcg.o
+
+obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o
+clk-imx-scu-$(CONFIG_CLK_IMX8QXP) += clk-scu.o clk-imx8qxp.o
+clk-imx-lpcg-scu-$(CONFIG_CLK_IMX8QXP) += clk-lpcg-scu.o clk-imx8qxp-lpcg.o
 
 obj-$(CONFIG_CLK_IMX1)   += clk-imx1.o
 obj-$(CONFIG_CLK_IMX21)  += clk-imx21.o
diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
index 04c8ee3..e947a70 100644
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
@@ -232,3 +232,7 @@ static struct platform_driver imx8qxp_lpcg_clk_driver = {
 };
 
 builtin_platform_driver(imx8qxp_lpcg_clk_driver);
+
+MODULE_AUTHOR("Aisheng Dong <aisheng.dong@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX8QXP LPCG clock driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 5e2903e..d650ca3 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -152,3 +152,7 @@ static struct platform_driver imx8qxp_clk_driver = {
 	.probe = imx8qxp_clk_probe,
 };
 builtin_platform_driver(imx8qxp_clk_driver);
+
+MODULE_AUTHOR("Aisheng Dong <aisheng.dong@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX8QXP clock driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

