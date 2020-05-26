Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8258CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B4FD2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgEZOms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 10:42:48 -0400
Received: from out28-2.mail.aliyun.com ([115.124.28.2]:42941 "EHLO
        out28-2.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbgEZOmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 10:42:47 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436595|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.262833-0.000428458-0.736738;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03312;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.Hdvl59T_1590504067;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Hdvl59T_1590504067)
          by smtp.aliyun-inc.com(10.147.41.143);
          Tue, 26 May 2020 22:42:42 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
Subject: [PATCH v10 6/6] clk: X1000: Add FIXDIV for SSI clock of X1000.
Date:   Tue, 26 May 2020 22:40:44 +0800
Message-Id: <20200526144044.71413-8-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200526144044.71413-1-zhouyanjie@wanyeetech.com>
References: <20200526144044.71413-1-zhouyanjie@wanyeetech.com>
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
2.Clocks of LCD, OTG, EMC, EFUSE, OST, TCU, and gates of CPU, PCLK
  are also added.
3.Use "CLK_OF_DECLARE_DRIVER" like the other CGU drivers.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v5:
    New patch.
    
    V5->v6:
    Add missing part of X1000's CGU.
    
    v6->v7:
    Update commit message.
    
    v7->v8:
    No change.
    
    v8->v9:
    Add Paul Cercueil's Reviewed-by, somehow his emails are not displayed
    on the mailing list and patchwork of clock framework subsystem.
    
    v9->v10:
    No change.

 drivers/clk/ingenic/x1000-cgu.c | 110 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 105 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/ingenic/x1000-cgu.c b/drivers/clk/ingenic/x1000-cgu.c
index c33934d8ac14..68c6e62457e1 100644
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
@@ -20,6 +20,9 @@
 #define CGU_REG_CLKGR		0x20
 #define CGU_REG_OPCR		0x24
 #define CGU_REG_DDRCDR		0x2c
+#define CGU_REG_USBPCR		0x3c
+#define CGU_REG_USBPCR1		0x48
+#define CGU_REG_USBCDR		0x50
 #define CGU_REG_MACCDR		0x54
 #define CGU_REG_I2SCDR		0x60
 #define CGU_REG_LPCDR		0x64
@@ -40,8 +43,47 @@
 #define OPCR_SPENDN0		BIT(7)
 #define OPCR_SPENDN1		BIT(6)
 
+/* bits within the USBPCR register */
+#define USBPCR_SIDDQ		BIT(21)
+#define USBPCR_OTG_DISABLE	BIT(20)
+
 static struct ingenic_cgu *cgu;
 
+static int x1000_usb_phy_enable(struct clk_hw *hw)
+{
+	void __iomem *reg_opcr		= cgu->base + CGU_REG_OPCR;
+	void __iomem *reg_usbpcr	= cgu->base + CGU_REG_USBPCR;
+
+	writel(readl(reg_opcr) | OPCR_SPENDN0, reg_opcr);
+	writel(readl(reg_usbpcr) & ~USBPCR_OTG_DISABLE & ~USBPCR_SIDDQ, reg_usbpcr);
+	return 0;
+}
+
+static void x1000_usb_phy_disable(struct clk_hw *hw)
+{
+	void __iomem *reg_opcr		= cgu->base + CGU_REG_OPCR;
+	void __iomem *reg_usbpcr	= cgu->base + CGU_REG_USBPCR;
+
+	writel(readl(reg_opcr) & ~OPCR_SPENDN0, reg_opcr);
+	writel(readl(reg_usbpcr) | USBPCR_OTG_DISABLE | USBPCR_SIDDQ, reg_usbpcr);
+}
+
+static int x1000_usb_phy_is_enabled(struct clk_hw *hw)
+{
+	void __iomem *reg_opcr		= cgu->base + CGU_REG_OPCR;
+	void __iomem *reg_usbpcr	= cgu->base + CGU_REG_USBPCR;
+
+	return (readl(reg_opcr) & OPCR_SPENDN0) &&
+		!(readl(reg_usbpcr) & USBPCR_SIDDQ) &&
+		!(readl(reg_usbpcr) & USBPCR_OTG_DISABLE);
+}
+
+static const struct clk_ops x1000_otg_phy_ops = {
+	.enable		= x1000_usb_phy_enable,
+	.disable	= x1000_usb_phy_disable,
+	.is_enabled	= x1000_usb_phy_is_enabled,
+};
+
 static const s8 pll_od_encoding[8] = {
 	0x0, 0x1, -1, 0x2, -1, -1, -1, 0x3,
 };
@@ -101,6 +143,15 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 		},
 	},
 
+
+	/* Custom (SoC-specific) OTG PHY */
+
+	[X1000_CLK_OTGPHY] = {
+		"otg_phy", CGU_CLK_CUSTOM,
+		.parents = { -1, -1, X1000_CLK_EXCLK, -1 },
+		.custom = { &x1000_otg_phy_ops },
+	},
+
 	/* Muxes & dividers */
 
 	[X1000_CLK_SCLKA] = {
@@ -116,9 +167,10 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 	},
 
 	[X1000_CLK_CPU] = {
-		"cpu", CGU_CLK_DIV,
+		"cpu", CGU_CLK_DIV | CGU_CLK_GATE,
 		.parents = { X1000_CLK_CPUMUX, -1, -1, -1 },
 		.div = { CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 30 },
 	},
 
 	[X1000_CLK_L2CACHE] = {
@@ -147,9 +199,10 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 	},
 
 	[X1000_CLK_PCLK] = {
-		"pclk", CGU_CLK_DIV,
+		"pclk", CGU_CLK_DIV | CGU_CLK_GATE,
 		.parents = { X1000_CLK_AHB2PMUX, -1, -1, -1 },
 		.div = { CGU_REG_CPCCR, 16, 1, 4, 20, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 28 },
 	},
 
 	[X1000_CLK_DDR] = {
@@ -162,12 +215,20 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 
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
@@ -188,6 +249,15 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
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
@@ -195,14 +265,32 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
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
@@ -245,12 +333,24 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 		.gate = { CGU_REG_CLKGR, 16 },
 	},
 
+	[X1000_CLK_TCU] = {
+		"tcu", CGU_CLK_GATE,
+		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 18 },
+	},
+
 	[X1000_CLK_SSI] = {
 		"ssi", CGU_CLK_GATE,
 		.parents = { X1000_CLK_SSIMUX, -1, -1, -1 },
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
-- 
2.11.0

