Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DE2C4332D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 08:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D073B20753
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 08:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgCVIWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 04:22:00 -0400
Received: from out28-121.mail.aliyun.com ([115.124.28.121]:55884 "EHLO
        out28-121.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgCVIV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 04:21:59 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07526577|-1;CH=green;DM=||false|;DS=CONTINUE|ham_regular_dialog|0.0234105-0.000504511-0.976085;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03312;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.H3MM99h_1584865287;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.H3MM99h_1584865287)
          by smtp.aliyun-inc.com(10.147.40.200);
          Sun, 22 Mar 2020 16:21:40 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, paul@crapouillou.net,
        dongsheng.qiu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH v6 6/6] clk: X1000: Add FIXDIV for SSI clock of X1000.
Date:   Sun, 22 Mar 2020 16:21:02 +0800
Message-Id: <1584865262-25297-8-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584865262-25297-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1584865262-25297-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.The SSI clock of X1000 not like JZ4770 and JZ4780, they are not
  directly derived from the output of SSIPLL, but from the clock
  obtained by dividing the frequency by 2. "X1000_CLK_SSIPLL_DIV2"
  is added for this purpose, and ensure that it initialized before
  "X1000_CLK_SSIMUX" when initializing the clocks.
2.Clocks of LCD, OTG, EMC, EFUSE, OST, and gates of CPU, PCLK
  are also added.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---

Notes:
    v5:
    New patch.
    
    V5->v6:
    Add missing part of X1000's CGU.

 drivers/clk/ingenic/x1000-cgu.c | 56 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/ingenic/x1000-cgu.c b/drivers/clk/ingenic/x1000-cgu.c
index 6f0ec9d..7e3ef0d 100644
--- a/drivers/clk/ingenic/x1000-cgu.c
+++ b/drivers/clk/ingenic/x1000-cgu.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * X1000 SoC CGU driver
- * Copyright (c) 2019 Zhou Yanjie <zhouyanjie@zoho.com>
+ * Copyright (c) 2019 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
  */
 
 #include <linux/clk-provider.h>
@@ -18,6 +18,7 @@
 #define CGU_REG_CLKGR		0x20
 #define CGU_REG_OPCR		0x24
 #define CGU_REG_DDRCDR		0x2c
+#define CGU_REG_USBCDR		0x50
 #define CGU_REG_MACCDR		0x54
 #define CGU_REG_I2SCDR		0x60
 #define CGU_REG_LPCDR		0x64
@@ -114,9 +115,10 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 	},
 
 	[X1000_CLK_CPU] = {
-		"cpu", CGU_CLK_DIV,
+		"cpu", CGU_CLK_DIV | CGU_CLK_GATE,
 		.parents = { X1000_CLK_CPUMUX, -1, -1, -1 },
 		.div = { CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 30 },
 	},
 
 	[X1000_CLK_L2CACHE] = {
@@ -145,9 +147,10 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 	},
 
 	[X1000_CLK_PCLK] = {
-		"pclk", CGU_CLK_DIV,
+		"pclk", CGU_CLK_DIV | CGU_CLK_GATE,
 		.parents = { X1000_CLK_AHB2PMUX, -1, -1, -1 },
 		.div = { CGU_REG_CPCCR, 16, 1, 4, 20, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 28 },
 	},
 
 	[X1000_CLK_DDR] = {
@@ -160,12 +163,20 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 
 	[X1000_CLK_MAC] = {
 		"mac", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
-		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL},
+		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL },
 		.mux = { CGU_REG_MACCDR, 31, 1 },
 		.div = { CGU_REG_MACCDR, 0, 1, 8, 29, 28, 27 },
 		.gate = { CGU_REG_CLKGR, 25 },
 	},
 
+	[X1000_CLK_LCD] = {
+		"lcd", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL },
+		.mux = { CGU_REG_LPCDR, 31, 1 },
+		.div = { CGU_REG_LPCDR, 0, 1, 8, 28, 27, 26 },
+		.gate = { CGU_REG_CLKGR, 23 },
+	},
+
 	[X1000_CLK_MSCMUX] = {
 		"msc_mux", CGU_CLK_MUX,
 		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL},
@@ -186,6 +197,15 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 		.gate = { CGU_REG_CLKGR, 5 },
 	},
 
+	[X1000_CLK_OTG] = {
+		"otg", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
+		.parents = { X1000_CLK_EXCLK, -1,
+					 X1000_CLK_APLL, X1000_CLK_MPLL },
+		.mux = { CGU_REG_USBCDR, 30, 2 },
+		.div = { CGU_REG_USBCDR, 0, 1, 8, 29, 28, 27 },
+		.gate = { CGU_REG_CLKGR, 3 },
+	},
+
 	[X1000_CLK_SSIPLL] = {
 		"ssi_pll", CGU_CLK_MUX | CGU_CLK_DIV,
 		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL, -1, -1 },
@@ -193,14 +213,32 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 		.div = { CGU_REG_SSICDR, 0, 1, 8, 29, 28, 27 },
 	},
 
+	[X1000_CLK_SSIPLL_DIV2] = {
+		"ssi_pll_div2", CGU_CLK_FIXDIV,
+		.parents = { X1000_CLK_SSIPLL },
+		.fixdiv = { 2 },
+	},
+
 	[X1000_CLK_SSIMUX] = {
 		"ssi_mux", CGU_CLK_MUX,
-		.parents = { X1000_CLK_EXCLK, X1000_CLK_SSIPLL, -1, -1 },
+		.parents = { X1000_CLK_EXCLK, X1000_CLK_SSIPLL_DIV2, -1, -1 },
 		.mux = { CGU_REG_SSICDR, 30, 1 },
 	},
 
 	/* Gate-only clocks */
 
+	[X1000_CLK_EMC] = {
+		"emc", CGU_CLK_GATE,
+		.parents = { X1000_CLK_AHB2, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 0 },
+	},
+
+	[X1000_CLK_EFUSE] = {
+		"efuse", CGU_CLK_GATE,
+		.parents = { X1000_CLK_AHB2, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 1 },
+	},
+
 	[X1000_CLK_SFC] = {
 		"sfc", CGU_CLK_GATE,
 		.parents = { X1000_CLK_SSIPLL, -1, -1, -1 },
@@ -249,6 +287,12 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 		.gate = { CGU_REG_CLKGR, 19 },
 	},
 
+	[X1000_CLK_OST] = {
+		"ost", CGU_CLK_GATE,
+		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 20 },
+	},
+
 	[X1000_CLK_PDMA] = {
 		"pdma", CGU_CLK_GATE,
 		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
@@ -275,4 +319,4 @@ static void __init x1000_cgu_init(struct device_node *np)
 
 	ingenic_cgu_register_syscore_ops(cgu);
 }
-CLK_OF_DECLARE(x1000_cgu, "ingenic,x1000-cgu", x1000_cgu_init);
+CLK_OF_DECLARE_DRIVER(x1000_cgu, "ingenic,x1000-cgu", x1000_cgu_init);
-- 
2.7.4

