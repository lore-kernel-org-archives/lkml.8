Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B1AC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53FF206EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="pDAJc4nw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgICBvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 21:51:00 -0400
Received: from crapouillou.net ([89.234.176.41]:47324 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgICBu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 21:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599097856; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=T+uSrpaQChsNKCgzgdveBEoRYzW1erqJPJN6DAR4JzE=;
        b=pDAJc4nwGhmam1waBxjGznXngPXUC9iG7W9NRvB0+SsXfvmWDSRjQNveuzqDbl+SWaUIAV
        RaOJluNSDqTgmOQi1xMf0mrs3ykSZgxSzJleHcN+mmrs4ys9ePpbrJU9pEalk3ug0KwM1D
        /qoj2FDbo0+JM+mz1T9sqmvc9syPkUw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     od@zcrc.me, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/5] clk: ingenic: Use to_clk_info() macro for all clocks
Date:   Thu,  3 Sep 2020 03:50:44 +0200
Message-Id: <20200903015048.3091523-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The to_clk_info() previously had a BUG_ON() to check that it was only
called for PLL clocks. Yet, all the other clocks were doing the exact
same thing the macro does, in-line.

Move the to_clk_info() macro to the top of the file, remove the
hardcoded BUG_ON(), and use it everywhere it makes sense.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/cgu.c | 54 +++++++++++----------------------------
 1 file changed, 15 insertions(+), 39 deletions(-)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index d7981b670221..12b14286734c 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -21,6 +21,12 @@
 
 #define MHZ (1000 * 1000)
 
+static inline const struct ingenic_cgu_clk_info *
+to_clk_info(struct ingenic_clk *clk)
+{
+	return &clk->cgu->clock_info[clk->idx];
+}
+
 /**
  * ingenic_cgu_gate_get() - get the value of clock gate register bit
  * @cgu: reference to the CGU whose registers should be read
@@ -71,14 +77,13 @@ static unsigned long
 ingenic_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 {
 	struct ingenic_clk *ingenic_clk = to_ingenic_clk(hw);
+	const struct ingenic_cgu_clk_info *clk_info = to_clk_info(ingenic_clk);
 	struct ingenic_cgu *cgu = ingenic_clk->cgu;
-	const struct ingenic_cgu_clk_info *clk_info;
 	const struct ingenic_cgu_pll_info *pll_info;
 	unsigned m, n, od_enc, od;
 	bool bypass;
 	u32 ctl;
 
-	clk_info = &cgu->clock_info[ingenic_clk->idx];
 	BUG_ON(clk_info->type != CGU_CLK_PLL);
 	pll_info = &clk_info->pll;
 
@@ -144,18 +149,6 @@ ingenic_pll_calc(const struct ingenic_cgu_clk_info *clk_info,
 		n * od);
 }
 
-static inline const struct ingenic_cgu_clk_info *to_clk_info(
-		struct ingenic_clk *ingenic_clk)
-{
-	struct ingenic_cgu *cgu = ingenic_clk->cgu;
-	const struct ingenic_cgu_clk_info *clk_info;
-
-	clk_info = &cgu->clock_info[ingenic_clk->idx];
-	BUG_ON(clk_info->type != CGU_CLK_PLL);
-
-	return clk_info;
-}
-
 static long
 ingenic_pll_round_rate(struct clk_hw *hw, unsigned long req_rate,
 		       unsigned long *prate)
@@ -290,13 +283,11 @@ static const struct clk_ops ingenic_pll_ops = {
 static u8 ingenic_clk_get_parent(struct clk_hw *hw)
 {
 	struct ingenic_clk *ingenic_clk = to_ingenic_clk(hw);
+	const struct ingenic_cgu_clk_info *clk_info = to_clk_info(ingenic_clk);
 	struct ingenic_cgu *cgu = ingenic_clk->cgu;
-	const struct ingenic_cgu_clk_info *clk_info;
 	u32 reg;
 	u8 i, hw_idx, idx = 0;
 
-	clk_info = &cgu->clock_info[ingenic_clk->idx];
-
 	if (clk_info->type & CGU_CLK_MUX) {
 		reg = readl(cgu->base + clk_info->mux.reg);
 		hw_idx = (reg >> clk_info->mux.shift) &
@@ -318,14 +309,12 @@ static u8 ingenic_clk_get_parent(struct clk_hw *hw)
 static int ingenic_clk_set_parent(struct clk_hw *hw, u8 idx)
 {
 	struct ingenic_clk *ingenic_clk = to_ingenic_clk(hw);
+	const struct ingenic_cgu_clk_info *clk_info = to_clk_info(ingenic_clk);
 	struct ingenic_cgu *cgu = ingenic_clk->cgu;
-	const struct ingenic_cgu_clk_info *clk_info;
 	unsigned long flags;
 	u8 curr_idx, hw_idx, num_poss;
 	u32 reg, mask;
 
-	clk_info = &cgu->clock_info[ingenic_clk->idx];
-
 	if (clk_info->type & CGU_CLK_MUX) {
 		/*
 		 * Convert the parent index to the hardware index by adding
@@ -368,13 +357,11 @@ static unsigned long
 ingenic_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 {
 	struct ingenic_clk *ingenic_clk = to_ingenic_clk(hw);
+	const struct ingenic_cgu_clk_info *clk_info = to_clk_info(ingenic_clk);
 	struct ingenic_cgu *cgu = ingenic_clk->cgu;
-	const struct ingenic_cgu_clk_info *clk_info;
 	unsigned long rate = parent_rate;
 	u32 div_reg, div;
 
-	clk_info = &cgu->clock_info[ingenic_clk->idx];
-
 	if (clk_info->type & CGU_CLK_DIV) {
 		div_reg = readl(cgu->base + clk_info->div.reg);
 		div = (div_reg >> clk_info->div.shift) &
@@ -443,12 +430,9 @@ ingenic_clk_round_rate(struct clk_hw *hw, unsigned long req_rate,
 		       unsigned long *parent_rate)
 {
 	struct ingenic_clk *ingenic_clk = to_ingenic_clk(hw);
-	struct ingenic_cgu *cgu = ingenic_clk->cgu;
-	const struct ingenic_cgu_clk_info *clk_info;
+	const struct ingenic_cgu_clk_info *clk_info = to_clk_info(ingenic_clk);
 	unsigned int div = 1;
 
-	clk_info = &cgu->clock_info[ingenic_clk->idx];
-
 	if (clk_info->type & CGU_CLK_DIV)
 		div = ingenic_clk_calc_div(clk_info, *parent_rate, req_rate);
 	else if (clk_info->type & CGU_CLK_FIXDIV)
@@ -462,16 +446,14 @@ ingenic_clk_set_rate(struct clk_hw *hw, unsigned long req_rate,
 		     unsigned long parent_rate)
 {
 	struct ingenic_clk *ingenic_clk = to_ingenic_clk(hw);
+	const struct ingenic_cgu_clk_info *clk_info = to_clk_info(ingenic_clk);
 	struct ingenic_cgu *cgu = ingenic_clk->cgu;
-	const struct ingenic_cgu_clk_info *clk_info;
 	const unsigned timeout = 100;
 	unsigned long rate, flags;
 	unsigned int hw_div, div, i;
 	u32 reg, mask;
 	int ret = 0;
 
-	clk_info = &cgu->clock_info[ingenic_clk->idx];
-
 	if (clk_info->type & CGU_CLK_DIV) {
 		div = ingenic_clk_calc_div(clk_info, parent_rate, req_rate);
 		rate = DIV_ROUND_UP(parent_rate, div);
@@ -525,12 +507,10 @@ ingenic_clk_set_rate(struct clk_hw *hw, unsigned long req_rate,
 static int ingenic_clk_enable(struct clk_hw *hw)
 {
 	struct ingenic_clk *ingenic_clk = to_ingenic_clk(hw);
+	const struct ingenic_cgu_clk_info *clk_info = to_clk_info(ingenic_clk);
 	struct ingenic_cgu *cgu = ingenic_clk->cgu;
-	const struct ingenic_cgu_clk_info *clk_info;
 	unsigned long flags;
 
-	clk_info = &cgu->clock_info[ingenic_clk->idx];
-
 	if (clk_info->type & CGU_CLK_GATE) {
 		/* ungate the clock */
 		spin_lock_irqsave(&cgu->lock, flags);
@@ -547,12 +527,10 @@ static int ingenic_clk_enable(struct clk_hw *hw)
 static void ingenic_clk_disable(struct clk_hw *hw)
 {
 	struct ingenic_clk *ingenic_clk = to_ingenic_clk(hw);
+	const struct ingenic_cgu_clk_info *clk_info = to_clk_info(ingenic_clk);
 	struct ingenic_cgu *cgu = ingenic_clk->cgu;
-	const struct ingenic_cgu_clk_info *clk_info;
 	unsigned long flags;
 
-	clk_info = &cgu->clock_info[ingenic_clk->idx];
-
 	if (clk_info->type & CGU_CLK_GATE) {
 		/* gate the clock */
 		spin_lock_irqsave(&cgu->lock, flags);
@@ -564,12 +542,10 @@ static void ingenic_clk_disable(struct clk_hw *hw)
 static int ingenic_clk_is_enabled(struct clk_hw *hw)
 {
 	struct ingenic_clk *ingenic_clk = to_ingenic_clk(hw);
+	const struct ingenic_cgu_clk_info *clk_info = to_clk_info(ingenic_clk);
 	struct ingenic_cgu *cgu = ingenic_clk->cgu;
-	const struct ingenic_cgu_clk_info *clk_info;
 	int enabled = 1;
 
-	clk_info = &cgu->clock_info[ingenic_clk->idx];
-
 	if (clk_info->type & CGU_CLK_GATE)
 		enabled = !ingenic_cgu_gate_get(cgu, &clk_info->gate);
 
-- 
2.28.0

