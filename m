Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729C3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A91208B6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgGBP1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:27:39 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54424 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730257AbgGBP1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:27:37 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2A509200648;
        Thu,  2 Jul 2020 17:27:35 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3108F2009EA;
        Thu,  2 Jul 2020 17:27:25 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C5F03402F0;
        Thu,  2 Jul 2020 23:27:10 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, arnd@arndb.de, peng.fan@nxp.com,
        abel.vesa@nxp.com, j.remmet@phytec.de, sfr@canb.auug.org.au,
        georg.waibel@wiedemann-group.de, Georg.Waibel@wiedemann-group.com,
        laurent.pinchart@ideasonboard.com, chen.fang@nxp.com,
        fugang.duan@nxp.com, daniel.baluta@nxp.com, yuehaibing@huawei.com,
        horia.geanta@nxp.com, andrew.smirnov@gmail.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V5 5/6] clk: imx8m: Support module build
Date:   Thu,  2 Jul 2020 23:24:00 +0800
Message-Id: <1593703441-16944-6-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593703441-16944-1-git-send-email-Anson.Huang@nxp.com>
References: <1593703441-16944-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change configuration to "tristate", add module author, description
and license to support building i.MX8M SoCs clock driver as module.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/Kconfig      | 16 ++++++++--------
 drivers/clk/imx/clk-imx8mm.c |  4 ++++
 drivers/clk/imx/clk-imx8mn.c |  4 ++++
 drivers/clk/imx/clk-imx8mp.c |  4 ++++
 drivers/clk/imx/clk-imx8mq.c |  4 ++++
 5 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 595c435..4f4f86e 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -78,29 +78,29 @@ config CLK_VF610
 	select MXC_CLK
 
 config CLK_IMX8MM
-	bool "IMX8MM CCM Clock Driver"
-	depends on ARCH_MXC
+	tristate "IMX8MM CCM Clock Driver"
+	depends on ARCH_MXC || COMPILE_TEST
 	select MXC_CLK
 	help
 	    Build the driver for i.MX8MM CCM Clock Driver
 
 config CLK_IMX8MN
-	bool "IMX8MN CCM Clock Driver"
-	depends on ARCH_MXC
+	tristate "IMX8MN CCM Clock Driver"
+	depends on ARCH_MXC || COMPILE_TEST
 	select MXC_CLK
 	help
 	    Build the driver for i.MX8MN CCM Clock Driver
 
 config CLK_IMX8MP
-	bool "IMX8MP CCM Clock Driver"
-	depends on ARCH_MXC
+	tristate "IMX8MP CCM Clock Driver"
+	depends on ARCH_MXC || COMPILE_TEST
 	select MXC_CLK
 	help
 	    Build the driver for i.MX8MP CCM Clock Driver
 
 config CLK_IMX8MQ
-	bool "IMX8MQ CCM Clock Driver"
-	depends on ARCH_MXC
+	tristate "IMX8MQ CCM Clock Driver"
+	depends on ARCH_MXC || COMPILE_TEST
 	select MXC_CLK
 	help
 	    Build the driver for i.MX8MQ CCM Clock Driver
diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index b793264..0de0be0 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -657,3 +657,7 @@ static struct platform_driver imx8mm_clk_driver = {
 	},
 };
 module_platform_driver(imx8mm_clk_driver);
+
+MODULE_AUTHOR("Bai Ping <ping.bai@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX8MM clock driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 213cc37..e984de5 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -608,3 +608,7 @@ static struct platform_driver imx8mn_clk_driver = {
 	},
 };
 module_platform_driver(imx8mn_clk_driver);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX8MN clock driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index ca74771..f3cedf2 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -773,3 +773,7 @@ static struct platform_driver imx8mp_clk_driver = {
 	},
 };
 module_platform_driver(imx8mp_clk_driver);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX8MP clock driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index a64aace..a06cc21 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -643,3 +643,7 @@ static struct platform_driver imx8mq_clk_driver = {
 	},
 };
 module_platform_driver(imx8mq_clk_driver);
+
+MODULE_AUTHOR("Abel Vesa <abel.vesa@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX8MQ clock driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

