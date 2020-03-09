Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87104C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC7024656
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgCITni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:43:38 -0400
Received: from v6.sk ([167.172.42.174]:34656 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgCITnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:43:37 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 27E2661307;
        Mon,  9 Mar 2020 19:43:36 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 09/17] clk: mmp2: Add PLLs that are available on MMP3
Date:   Mon,  9 Mar 2020 20:42:46 +0100
Message-Id: <20200309194254.29009-10-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309194254.29009-1-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more PLLs on MMP3 and are configured slightly differently.
Tested on a MMP3-based Dell Wyse 3020 machine.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-of-mmp2.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
index 7594a8280b93a..310d77855f03f 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -57,10 +57,16 @@
 #define APMU_USBHSIC0	0xf8
 #define APMU_USBHSIC1	0xfc
 
-#define MPMU_FCCR	0x8
-#define MPMU_POSR	0x10
-#define MPMU_UART_PLL	0x14
-#define MPMU_PLL2_CR	0x34
+#define MPMU_FCCR		0x8
+#define MPMU_POSR		0x10
+#define MPMU_UART_PLL		0x14
+#define MPMU_PLL2_CR		0x34
+/* MMP3 specific below */
+#define MPMU_PLL3_CR		0x50
+#define MPMU_PLL3_CTRL1		0x58
+#define MPMU_PLL1_CTRL		0x5c
+#define MPMU_PLL_DIFF_CTRL	0x68
+#define MPMU_PLL2_CTRL1		0x414
 
 enum mmp2_clk_model {
 	CLK_MODEL_MMP2,
@@ -86,6 +92,14 @@ static struct mmp_param_pll_clk pll_clks[] = {
 	{MMP2_CLK_PLL2,   "pll2",           0, MPMU_PLL2_CR,       0x0300, MPMU_PLL2_CR, 10},
 };
 
+static struct mmp_param_pll_clk mmp3_pll_clks[] = {
+	{MMP2_CLK_PLL2,   "pll1",   797330000, MPMU_FCCR,          0x4000, MPMU_POSR,     0,      26000000, MPMU_PLL1_CTRL,      25},
+	{MMP2_CLK_PLL2,   "pll2",           0, MPMU_PLL2_CR,       0x0300, MPMU_PLL2_CR, 10,      26000000, MPMU_PLL2_CTRL1,     25},
+	{MMP3_CLK_PLL1_P, "pll1_p",         0, MPMU_PLL_DIFF_CTRL, 0x0010, 0,             0,     797330000, MPMU_PLL_DIFF_CTRL,   0},
+	{MMP3_CLK_PLL2_P, "pll2_p",         0, MPMU_PLL_DIFF_CTRL, 0x0100, MPMU_PLL2_CR, 10,      26000000, MPMU_PLL_DIFF_CTRL,   5},
+	{MMP3_CLK_PLL3,   "pll3",           0, MPMU_PLL3_CR,       0x0300, MPMU_PLL3_CR, 10,      26000000, MPMU_PLL3_CTRL1,     25},
+};
+
 static struct mmp_param_fixed_factor_clk fixed_factor_clks[] = {
 	{MMP2_CLK_PLL1_2, "pll1_2", "pll1", 1, 2, 0},
 	{MMP2_CLK_PLL1_4, "pll1_4", "pll1_2", 1, 2, 0},
@@ -127,9 +141,15 @@ static void mmp2_pll_init(struct mmp2_clk_unit *pxa_unit)
 	mmp_register_fixed_rate_clks(unit, fixed_rate_clks,
 					ARRAY_SIZE(fixed_rate_clks));
 
-	mmp_register_pll_clks(unit, pll_clks,
-				pxa_unit->mpmu_base,
-				ARRAY_SIZE(pll_clks));
+	if (pxa_unit->model == CLK_MODEL_MMP3) {
+		mmp_register_pll_clks(unit, mmp3_pll_clks,
+					pxa_unit->mpmu_base,
+					ARRAY_SIZE(mmp3_pll_clks));
+	} else {
+		mmp_register_pll_clks(unit, pll_clks,
+					pxa_unit->mpmu_base,
+					ARRAY_SIZE(pll_clks));
+	}
 
 	mmp_register_fixed_factor_clks(unit, fixed_factor_clks,
 					ARRAY_SIZE(fixed_factor_clks));
-- 
2.25.1

