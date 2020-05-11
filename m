Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3763C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A90E220752
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbgEKTZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:25:42 -0400
Received: from v6.sk ([167.172.42.174]:52348 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731534AbgEKTZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:25:39 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 73A93610D3;
        Mon, 11 May 2020 19:25:38 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 07/10] clk: mmp2: Add the I2C clocks
Date:   Mon, 11 May 2020 21:25:14 +0200
Message-Id: <20200511192517.1206442-8-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511192517.1206442-1-lkundrak@v3.sk>
References: <20200511192517.1206442-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A pair of fractional clock sources for PLLs and gates.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-of-mmp2.c | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
index ac88ea99b7c6..dcdff06a698a 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -67,6 +67,9 @@
 #define MPMU_POSR		0x10
 #define MPMU_UART_PLL		0x14
 #define MPMU_PLL2_CR		0x34
+#define MPMU_I2S0_PLL		0x40
+#define MPMU_I2S1_PLL		0x44
+#define MPMU_ACGR		0x1024
 /* MMP3 specific below */
 #define MPMU_PLL3_CR		0x50
 #define MPMU_PLL3_CTRL1		0x58
@@ -91,6 +94,7 @@ static struct mmp_param_fixed_rate_clk fixed_rate_clks[] = {
 	{MMP2_CLK_CLK32, "clk32", NULL, 0, 32768},
 	{MMP2_CLK_VCTCXO, "vctcxo", NULL, 0, 26000000},
 	{MMP2_CLK_USB_PLL, "usb_pll", NULL, 0, 480000000},
+	{0, "i2s_pll", NULL, 0, 99666667},
 };
 
 static struct mmp_param_pll_clk pll_clks[] = {
@@ -139,6 +143,34 @@ static struct mmp_clk_factor_tbl uart_factor_tbl[] = {
 	{.num = 3521, .den = 689},	/*19.23MHZ */
 };
 
+static struct mmp_clk_factor_masks i2s_factor_masks = {
+	.factor = 2,
+	.num_mask = 0x7fff,
+	.den_mask = 0x1fff,
+	.num_shift = 0,
+	.den_shift = 15,
+	.enable_mask = 0xd0000000,
+};
+
+static struct mmp_clk_factor_tbl i2s_factor_tbl[] = {
+	{.num = 24868, .den =  511},	/*  2.0480 MHz */
+	{.num = 28003, .den =  793},	/*  2.8224 MHz */
+	{.num = 24941, .den = 1025},	/*  4.0960 MHz */
+	{.num = 28003, .den = 1586},	/*  5.6448 MHz */
+	{.num = 31158, .den = 2561},	/*  8.1920 MHz */
+	{.num = 16288, .den = 1845},	/* 11.2896 MHz */
+	{.num = 20772, .den = 2561},	/* 12.2880 MHz */
+	{.num =  8144, .den = 1845},	/* 22.5792 MHz */
+	{.num = 10386, .den = 2561},	/* 24.5760 MHz */
+};
+
+static DEFINE_SPINLOCK(acgr_lock);
+
+static struct mmp_param_gate_clk mpmu_gate_clks[] = {
+	{MMP2_CLK_I2S0, "i2s0_clk", "i2s0_pll", CLK_SET_RATE_PARENT, MPMU_ACGR, 0x200000, 0x200000, 0x0, 0, &acgr_lock},
+	{MMP2_CLK_I2S1, "i2s1_clk", "i2s1_pll", CLK_SET_RATE_PARENT, MPMU_ACGR, 0x100000, 0x100000, 0x0, 0, &acgr_lock},
+};
+
 static void mmp2_main_clk_init(struct mmp2_clk_unit *pxa_unit)
 {
 	struct clk *clk;
@@ -166,6 +198,20 @@ static void mmp2_main_clk_init(struct mmp2_clk_unit *pxa_unit)
 				&uart_factor_masks, uart_factor_tbl,
 				ARRAY_SIZE(uart_factor_tbl), NULL);
 	mmp_clk_add(unit, MMP2_CLK_UART_PLL, clk);
+
+	mmp_clk_register_factor("i2s0_pll", "pll1_4",
+				CLK_SET_RATE_PARENT,
+				pxa_unit->mpmu_base + MPMU_I2S0_PLL,
+				&i2s_factor_masks, i2s_factor_tbl,
+				ARRAY_SIZE(i2s_factor_tbl), NULL);
+	mmp_clk_register_factor("i2s1_pll", "pll1_4",
+				CLK_SET_RATE_PARENT,
+				pxa_unit->mpmu_base + MPMU_I2S1_PLL,
+				&i2s_factor_masks, i2s_factor_tbl,
+				ARRAY_SIZE(i2s_factor_tbl), NULL);
+
+	mmp_register_gate_clks(unit, mpmu_gate_clks, pxa_unit->mpmu_base,
+				ARRAY_SIZE(mpmu_gate_clks));
 }
 
 static DEFINE_SPINLOCK(uart0_lock);
-- 
2.26.2

