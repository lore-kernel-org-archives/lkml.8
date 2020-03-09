Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3467AC10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B66A24656
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgCITnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:43:22 -0400
Received: from v6.sk ([167.172.42.174]:34600 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgCITnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:43:22 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 1419961300;
        Mon,  9 Mar 2020 19:43:20 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 05/17] clk: mmp2: Stop pretending PLL outputs are constant
Date:   Mon,  9 Mar 2020 20:42:42 +0100
Message-Id: <20200309194254.29009-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309194254.29009-1-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardcoded values for PLL1 and PLL2 are wrong. PLL1 is slightly
off -- it defaults to 797.33 MHz, not 800 MHz. PLL2 is disabled by default,
but also configurable.

Tested on a MMP2-based OLPC XO-1.75 laptop, with PLL1=797.33 and various
values of PLL2 set via set-pll2-520mhz, set-pll2-910mhz and
set-pll2-988mhz Open Firmware words.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-of-mmp2.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
index ee086d9714160..251d8d0e78abb 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2012 Marvell
  * Chao Xie <xiechao.mail@gmail.com>
+ * Copyright (C) 2020 Lubomir Rintel <lkundrak@v3.sk>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -55,7 +56,11 @@
 #define APMU_CCIC1	0xf4
 #define APMU_USBHSIC0	0xf8
 #define APMU_USBHSIC1	0xfc
+
+#define MPMU_FCCR	0x8
+#define MPMU_POSR	0x10
 #define MPMU_UART_PLL	0x14
+#define MPMU_PLL2_CR	0x34
 
 struct mmp2_clk_unit {
 	struct mmp_clk_unit unit;
@@ -67,11 +72,14 @@ struct mmp2_clk_unit {
 static struct mmp_param_fixed_rate_clk fixed_rate_clks[] = {
 	{MMP2_CLK_CLK32, "clk32", NULL, 0, 32768},
 	{MMP2_CLK_VCTCXO, "vctcxo", NULL, 0, 26000000},
-	{MMP2_CLK_PLL1, "pll1", NULL, 0, 800000000},
-	{MMP2_CLK_PLL2, "pll2", NULL, 0, 960000000},
 	{MMP2_CLK_USB_PLL, "usb_pll", NULL, 0, 480000000},
 };
 
+static struct mmp_param_pll_clk pll_clks[] = {
+	{MMP2_CLK_PLL1,   "pll1",   797330000, MPMU_FCCR,          0x4000, MPMU_POSR,     0},
+	{MMP2_CLK_PLL2,   "pll2",           0, MPMU_PLL2_CR,       0x0300, MPMU_PLL2_CR, 10},
+};
+
 static struct mmp_param_fixed_factor_clk fixed_factor_clks[] = {
 	{MMP2_CLK_PLL1_2, "pll1_2", "pll1", 1, 2, 0},
 	{MMP2_CLK_PLL1_4, "pll1_4", "pll1_2", 1, 2, 0},
@@ -113,6 +121,10 @@ static void mmp2_pll_init(struct mmp2_clk_unit *pxa_unit)
 	mmp_register_fixed_rate_clks(unit, fixed_rate_clks,
 					ARRAY_SIZE(fixed_rate_clks));
 
+	mmp_register_pll_clks(unit, pll_clks,
+				pxa_unit->mpmu_base,
+				ARRAY_SIZE(pll_clks));
+
 	mmp_register_fixed_factor_clks(unit, fixed_factor_clks,
 					ARRAY_SIZE(fixed_factor_clks));
 
-- 
2.25.1

