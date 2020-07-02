Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B38C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C37B32073E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgGBP1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:27:32 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54366 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730070AbgGBP12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:27:28 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2B3AD2009EF;
        Thu,  2 Jul 2020 17:27:26 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 69766200648;
        Thu,  2 Jul 2020 17:27:16 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7C9B0402EE;
        Thu,  2 Jul 2020 23:27:04 +0800 (SGT)
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
Subject: [PATCH V5 2/6] clk: imx: Support module build for i.MX5/6/7 and vf610
Date:   Thu,  2 Jul 2020 23:23:57 +0800
Message-Id: <1593703441-16944-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593703441-16944-1-git-send-email-Anson.Huang@nxp.com>
References: <1593703441-16944-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add module author, description and license to support module build
for i.MX5/6/7 and vf610 SoCs.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
New patch.
---
 drivers/clk/imx/clk-imx5.c    | 5 +++++
 drivers/clk/imx/clk-imx6q.c   | 5 +++++
 drivers/clk/imx/clk-imx6sl.c  | 5 +++++
 drivers/clk/imx/clk-imx6sll.c | 5 +++++
 drivers/clk/imx/clk-imx6sx.c  | 5 +++++
 drivers/clk/imx/clk-imx6ul.c  | 5 +++++
 drivers/clk/imx/clk-imx7d.c   | 5 +++++
 drivers/clk/imx/clk-imx7ulp.c | 5 +++++
 drivers/clk/imx/clk-vf610.c   | 5 +++++
 9 files changed, 45 insertions(+)

diff --git a/drivers/clk/imx/clk-imx5.c b/drivers/clk/imx/clk-imx5.c
index 01e079b..fcdd398 100644
--- a/drivers/clk/imx/clk-imx5.c
+++ b/drivers/clk/imx/clk-imx5.c
@@ -9,6 +9,7 @@
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -636,3 +637,7 @@ static void __init mx53_clocks_init(struct device_node *np)
 	imx_register_uart_clocks(uart_clks_mx50_mx53);
 }
 CLK_OF_DECLARE(imx53_ccm, "fsl,imx53-ccm", mx53_clocks_init);
+
+MODULE_AUTHOR("Shawn Guo <shawnguo@kernel.org>");
+MODULE_DESCRIPTION("NXP i.MX5 clock driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index ba33c79..46d31be 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -11,6 +11,7 @@
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -990,3 +991,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	imx_register_uart_clocks(uart_clks);
 }
 CLK_OF_DECLARE(imx6q, "fsl,imx6q-ccm", imx6q_clocks_init);
+
+MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
+MODULE_DESCRIPTION("NXP i.MX6Q clock driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index 0f647d1..f19d52f 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -6,6 +6,7 @@
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/err.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -455,3 +456,7 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	imx_register_uart_clocks(uart_clks);
 }
 CLK_OF_DECLARE(imx6sl, "fsl,imx6sl-ccm", imx6sl_clocks_init);
+
+MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
+MODULE_DESCRIPTION("NXP i.MX6SL clock driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/imx/clk-imx6sll.c b/drivers/clk/imx/clk-imx6sll.c
index 8e8288b..4ec0dea 100644
--- a/drivers/clk/imx/clk-imx6sll.c
+++ b/drivers/clk/imx/clk-imx6sll.c
@@ -11,6 +11,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 
@@ -376,3 +377,7 @@ static void __init imx6sll_clocks_init(struct device_node *ccm_node)
 	clk_set_rate(hws[IMX6SLL_CLK_AHB]->clk, 132000000);
 }
 CLK_OF_DECLARE_DRIVER(imx6sll, "fsl,imx6sll-ccm", imx6sll_clocks_init);
+
+MODULE_AUTHOR("Shawn Guo <shawnguo@kernel.org>");
+MODULE_DESCRIPTION("NXP i.MX6SLL clock driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index 89ba712..156163d 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -10,6 +10,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -564,3 +565,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	imx_register_uart_clocks(uart_clks);
 }
 CLK_OF_DECLARE(imx6sx, "fsl,imx6sx-ccm", imx6sx_clocks_init);
+
+MODULE_AUTHOR("Shawn Guo <shawnguo@kernel.org>");
+MODULE_DESCRIPTION("NXP i.MX6SX clock driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 5dbb6a9..090b684 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -10,6 +10,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -513,3 +514,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 }
 
 CLK_OF_DECLARE(imx6ul, "fsl,imx6ul-ccm", imx6ul_clocks_init);
+
+MODULE_AUTHOR("Frank Li <frank.li@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX6UL clock driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index b2057bd..1837c42 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -10,6 +10,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -906,3 +907,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 
 }
 CLK_OF_DECLARE(imx7d, "fsl,imx7d-ccm", imx7d_clocks_init);
+
+MODULE_AUTHOR("Frank Li <frank.li@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX7D clock driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index 634c0b6..d2eb80e 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -279,3 +280,7 @@ static void __init imx7ulp_clk_smc1_init(struct device_node *np)
 	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
 }
 CLK_OF_DECLARE(imx7ulp_clk_smc1, "fsl,imx7ulp-smc1", imx7ulp_clk_smc1_init);
+
+MODULE_AUTHOR("A.s. Dong <aisheng.dong@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX7ULP clock driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
index 5129ef8..bf174ac 100644
--- a/drivers/clk/imx/clk-vf610.c
+++ b/drivers/clk/imx/clk-vf610.c
@@ -5,6 +5,7 @@
 
 #include <linux/of_address.h>
 #include <linux/clk.h>
+#include <linux/module.h>
 #include <linux/syscore_ops.h>
 #include <dt-bindings/clock/vf610-clock.h>
 
@@ -468,3 +469,7 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 }
 CLK_OF_DECLARE(vf610, "fsl,vf610-ccm", vf610_clocks_init);
+
+MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
+MODULE_DESCRIPTION("NXP VF610 clock driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

