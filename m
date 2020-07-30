Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E4AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 01:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6535F2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 01:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgG3B1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 21:27:23 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42512 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgG3B1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 21:27:22 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AB4C61A12E2;
        Thu, 30 Jul 2020 03:27:20 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 25B3E1A0291;
        Thu, 30 Jul 2020 03:27:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CF15D40302;
        Thu, 30 Jul 2020 03:27:05 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, arnd@arndb.de, peng.fan@nxp.com,
        abel.vesa@nxp.com, fugang.duan@nxp.com, daniel.baluta@nxp.com,
        yuehaibing@huawei.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V9 1/6] clk: imx6sl: Use BIT(x) to avoid shifting signed 32-bit value by 31 bits
Date:   Thu, 30 Jul 2020 09:22:49 +0800
Message-Id: <1596072174-16358-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596072174-16358-1-git-send-email-Anson.Huang@nxp.com>
References: <1596072174-16358-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use readl_relaxed() instead of __raw_readl(), and use BIT(x)
instead of (1 << X) to fix below build warning reported by kernel
test robot:

drivers/clk/imx/clk-imx6sl.c:149:49: warning: Shifting signed 32-bit
value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
     while (!(__raw_readl(anatop_base + PLL_ARM) & BM_PLL_ARM_LOCK))

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reported-by: kernel test robot <lkp@intel.com>
---
changes since V8:
	- explicitly include linux/bits.h.
---
 drivers/clk/imx/clk-imx6sl.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index 0f647d1..2f93619 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -3,6 +3,7 @@
  * Copyright 2013-2014 Freescale Semiconductor, Inc.
  */
 
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/err.h>
@@ -14,19 +15,19 @@
 #include "clk.h"
 
 #define CCSR			0xc
-#define BM_CCSR_PLL1_SW_CLK_SEL	(1 << 2)
+#define BM_CCSR_PLL1_SW_CLK_SEL	BIT(2)
 #define CACRR			0x10
 #define CDHIPR			0x48
-#define BM_CDHIPR_ARM_PODF_BUSY	(1 << 16)
+#define BM_CDHIPR_ARM_PODF_BUSY	BIT(16)
 #define ARM_WAIT_DIV_396M	2
 #define ARM_WAIT_DIV_792M	4
 #define ARM_WAIT_DIV_996M	6
 
 #define PLL_ARM			0x0
-#define BM_PLL_ARM_DIV_SELECT	(0x7f << 0)
-#define BM_PLL_ARM_POWERDOWN	(1 << 12)
-#define BM_PLL_ARM_ENABLE	(1 << 13)
-#define BM_PLL_ARM_LOCK		(1 << 31)
+#define BM_PLL_ARM_DIV_SELECT	0x7f
+#define BM_PLL_ARM_POWERDOWN	BIT(12)
+#define BM_PLL_ARM_ENABLE	BIT(13)
+#define BM_PLL_ARM_LOCK		BIT(31)
 #define PLL_ARM_DIV_792M	66
 
 static const char *step_sels[]		= { "osc", "pll2_pfd2", };
@@ -145,7 +146,7 @@ static void imx6sl_enable_pll_arm(bool enable)
 		val |= BM_PLL_ARM_ENABLE;
 		val &= ~BM_PLL_ARM_POWERDOWN;
 		writel_relaxed(val, anatop_base + PLL_ARM);
-		while (!(__raw_readl(anatop_base + PLL_ARM) & BM_PLL_ARM_LOCK))
+		while (!(readl_relaxed(anatop_base + PLL_ARM) & BM_PLL_ARM_LOCK))
 			;
 	} else {
 		 writel_relaxed(saved_pll_arm, anatop_base + PLL_ARM);
-- 
2.7.4

