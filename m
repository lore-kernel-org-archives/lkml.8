Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5DCC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F519206EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="HLeshW5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgICBvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 21:51:08 -0400
Received: from crapouillou.net ([89.234.176.41]:47364 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgICBvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 21:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599097857; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HbIYW/E4nZUqqBJuMSP1Qgg/wX6VkvJuMRuNgmZ+1yQ=;
        b=HLeshW5h1oxxTmCxz7YLZctvdZemiAFApmsyw0nKl6Z2EXCVZqJtvy3Eif3WLj405QtIma
        WlEM8wPbBZKJWlfHSUO7bN1hcwTxWSQqYy4HfrzPX8ggCUYJAH+M93q3pkVmWfI+vdU3sJ
        S02XO2lYPD98ef9V3WtPlQPQqVoPTdc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     od@zcrc.me, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/5] clk: ingenic: Use readl_poll_timeout instead of custom loop
Date:   Thu,  3 Sep 2020 03:50:45 +0200
Message-Id: <20200903015048.3091523-2-paul@crapouillou.net>
In-Reply-To: <20200903015048.3091523-1-paul@crapouillou.net>
References: <20200903015048.3091523-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the readl_poll_timeout() function instead of rolling our own
busy-wait loops. This makes the code simpler.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/cgu.c | 55 +++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index 12b14286734c..6bb5dedf0252 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -12,11 +12,14 @@
 #include <linux/clkdev.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/math64.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/time.h>
+
 #include "cgu.h"
 
 #define MHZ (1000 * 1000)
@@ -159,6 +162,16 @@ ingenic_pll_round_rate(struct clk_hw *hw, unsigned long req_rate,
 	return ingenic_pll_calc(clk_info, req_rate, *prate, NULL, NULL, NULL);
 }
 
+static inline int ingenic_pll_check_stable(struct ingenic_cgu *cgu,
+					   const struct ingenic_cgu_pll_info *pll_info)
+{
+	u32 ctl;
+
+	return readl_poll_timeout(cgu->base + pll_info->reg, ctl,
+				  ctl & BIT(pll_info->stable_bit),
+				  0, 100 * USEC_PER_MSEC);
+}
+
 static int
 ingenic_pll_set_rate(struct clk_hw *hw, unsigned long req_rate,
 		     unsigned long parent_rate)
@@ -201,9 +214,8 @@ static int ingenic_pll_enable(struct clk_hw *hw)
 	struct ingenic_cgu *cgu = ingenic_clk->cgu;
 	const struct ingenic_cgu_clk_info *clk_info = to_clk_info(ingenic_clk);
 	const struct ingenic_cgu_pll_info *pll_info = &clk_info->pll;
-	const unsigned int timeout = 100;
 	unsigned long flags;
-	unsigned int i;
+	int ret;
 	u32 ctl;
 
 	spin_lock_irqsave(&cgu->lock, flags);
@@ -219,20 +231,10 @@ static int ingenic_pll_enable(struct clk_hw *hw)
 
 	writel(ctl, cgu->base + pll_info->reg);
 
-	/* wait for the PLL to stabilise */
-	for (i = 0; i < timeout; i++) {
-		ctl = readl(cgu->base + pll_info->reg);
-		if (ctl & BIT(pll_info->stable_bit))
-			break;
-		mdelay(1);
-	}
-
+	ret = ingenic_pll_check_stable(cgu, pll_info);
 	spin_unlock_irqrestore(&cgu->lock, flags);
 
-	if (i == timeout)
-		return -EBUSY;
-
-	return 0;
+	return ret;
 }
 
 static void ingenic_pll_disable(struct clk_hw *hw)
@@ -441,6 +443,16 @@ ingenic_clk_round_rate(struct clk_hw *hw, unsigned long req_rate,
 	return DIV_ROUND_UP(*parent_rate, div);
 }
 
+static inline int ingenic_clk_check_stable(struct ingenic_cgu *cgu,
+					   const struct ingenic_cgu_clk_info *clk_info)
+{
+	u32 reg;
+
+	return readl_poll_timeout(cgu->base + clk_info->div.reg, reg,
+				  !(reg & BIT(clk_info->div.busy_bit)),
+				  0, 100 * USEC_PER_MSEC);
+}
+
 static int
 ingenic_clk_set_rate(struct clk_hw *hw, unsigned long req_rate,
 		     unsigned long parent_rate)
@@ -448,9 +460,8 @@ ingenic_clk_set_rate(struct clk_hw *hw, unsigned long req_rate,
 	struct ingenic_clk *ingenic_clk = to_ingenic_clk(hw);
 	const struct ingenic_cgu_clk_info *clk_info = to_clk_info(ingenic_clk);
 	struct ingenic_cgu *cgu = ingenic_clk->cgu;
-	const unsigned timeout = 100;
 	unsigned long rate, flags;
-	unsigned int hw_div, div, i;
+	unsigned int hw_div, div;
 	u32 reg, mask;
 	int ret = 0;
 
@@ -486,16 +497,8 @@ ingenic_clk_set_rate(struct clk_hw *hw, unsigned long req_rate,
 		writel(reg, cgu->base + clk_info->div.reg);
 
 		/* wait for the change to take effect */
-		if (clk_info->div.busy_bit != -1) {
-			for (i = 0; i < timeout; i++) {
-				reg = readl(cgu->base + clk_info->div.reg);
-				if (!(reg & BIT(clk_info->div.busy_bit)))
-					break;
-				mdelay(1);
-			}
-			if (i == timeout)
-				ret = -EBUSY;
-		}
+		if (clk_info->div.busy_bit != -1)
+			ret = ingenic_clk_check_stable(cgu, clk_info);
 
 		spin_unlock_irqrestore(&cgu->lock, flags);
 		return ret;
-- 
2.28.0

