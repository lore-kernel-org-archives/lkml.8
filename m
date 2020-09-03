Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8070EC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BAB206EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="JPdHB4Yj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgICBvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 21:51:15 -0400
Received: from crapouillou.net ([89.234.176.41]:47810 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgICBvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 21:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599097858; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2yfd2xBfeCTBCbxJYFYKFlCLlxYijXGe2ZvjIsbsAzU=;
        b=JPdHB4YjDZRJqmUKLx5vIPHYk5LT7dGggJGhdGMLM1WU/lCIBgMttj+7lCMnkIZJJqJEdI
        EgSgkOvTA85iQZLWgV+pQX5+HF3orHfWw9uTifE+fuwpTLsTqAcyvJFHK73tZEuBsrvtDP
        HuGhNqYwgBEO+YPkaTSXuqwDDVGhOsg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     od@zcrc.me, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/5] clk: ingenic: Don't use CLK_SET_RATE_GATE for PLL
Date:   Thu,  3 Sep 2020 03:50:46 +0200
Message-Id: <20200903015048.3091523-3-paul@crapouillou.net>
In-Reply-To: <20200903015048.3091523-1-paul@crapouillou.net>
References: <20200903015048.3091523-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CLK_SET_RATE_GATE means that the clock must be gated when being
reclocked. This is not the case for the PLLs in Ingenic SoCs.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/cgu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index 6bb5dedf0252..521a40dfcb72 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -182,6 +182,7 @@ ingenic_pll_set_rate(struct clk_hw *hw, unsigned long req_rate,
 	const struct ingenic_cgu_pll_info *pll_info = &clk_info->pll;
 	unsigned long rate, flags;
 	unsigned int m, n, od;
+	int ret = 0;
 	u32 ctl;
 
 	rate = ingenic_pll_calc(clk_info, req_rate, parent_rate,
@@ -203,9 +204,14 @@ ingenic_pll_set_rate(struct clk_hw *hw, unsigned long req_rate,
 	ctl |= pll_info->od_encoding[od - 1] << pll_info->od_shift;
 
 	writel(ctl, cgu->base + pll_info->reg);
+
+	/* If the PLL is enabled, verify that it's stable */
+	if (ctl & BIT(pll_info->enable_bit))
+		ret = ingenic_pll_check_stable(cgu, pll_info);
+
 	spin_unlock_irqrestore(&cgu->lock, flags);
 
-	return 0;
+	return ret;
 }
 
 static int ingenic_pll_enable(struct clk_hw *hw)
@@ -662,7 +668,6 @@ static int ingenic_register_clock(struct ingenic_cgu *cgu, unsigned idx)
 		}
 	} else if (caps & CGU_CLK_PLL) {
 		clk_init.ops = &ingenic_pll_ops;
-		clk_init.flags |= CLK_SET_RATE_GATE;
 
 		caps &= ~CGU_CLK_PLL;
 
-- 
2.28.0

