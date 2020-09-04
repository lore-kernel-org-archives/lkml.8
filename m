Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11A6C2BC84
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97DFE206A5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgIDHoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:44:30 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:44000 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgIDHoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:44:17 -0400
Received: from localhost (unknown [192.168.167.223])
        by lucky1.263xmail.com (Postfix) with ESMTP id 39744A28D4;
        Fri,  4 Sep 2020 15:44:10 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P15471T140656136742656S1599205448140075_;
        Fri, 04 Sep 2020 15:44:10 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <8b926b330aefa52891ba72ba4efc267b>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v3 1/6] clk: rockchip: Use clk_hw_register_composite instead of clk_register_composite calls
Date:   Fri,  4 Sep 2020 15:44:00 +0800
Message-Id: <20200904074405.24439-2-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904074405.24439-1-zhangqing@rock-chips.com>
References: <20200904074405.24439-1-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_hw_register_composite it's already exported.
Preparation for compilation of rK common clock drivers into modules.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
 drivers/clk/rockchip/clk-half-divider.c | 18 ++++----
 drivers/clk/rockchip/clk.c              | 61 ++++++++++++-------------
 2 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/clk/rockchip/clk-half-divider.c b/drivers/clk/rockchip/clk-half-divider.c
index b333fc28c94b..e97fd3dfbae7 100644
--- a/drivers/clk/rockchip/clk-half-divider.c
+++ b/drivers/clk/rockchip/clk-half-divider.c
@@ -166,7 +166,7 @@ struct clk *rockchip_clk_register_halfdiv(const char *name,
 					  unsigned long flags,
 					  spinlock_t *lock)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_mux *mux = NULL;
 	struct clk_gate *gate = NULL;
 	struct clk_divider *div = NULL;
@@ -212,16 +212,18 @@ struct clk *rockchip_clk_register_halfdiv(const char *name,
 		div_ops = &clk_half_divider_ops;
 	}
 
-	clk = clk_register_composite(NULL, name, parent_names, num_parents,
-				     mux ? &mux->hw : NULL, mux_ops,
-				     div ? &div->hw : NULL, div_ops,
-				     gate ? &gate->hw : NULL, gate_ops,
-				     flags);
+	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
+				       mux ? &mux->hw : NULL, mux_ops,
+				       div ? &div->hw : NULL, div_ops,
+				       gate ? &gate->hw : NULL, gate_ops,
+				       flags);
+	if (IS_ERR(hw))
+		goto err_div;
 
-	return clk;
+	return hw->clk;
 err_div:
 	kfree(gate);
 err_gate:
 	kfree(mux);
-	return ERR_PTR(-ENOMEM);
+	return ERR_CAST(hw);
 }
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 546e810c3560..46409972983e 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -43,7 +43,7 @@ static struct clk *rockchip_clk_register_branch(const char *name,
 		u8 gate_shift, u8 gate_flags, unsigned long flags,
 		spinlock_t *lock)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_mux *mux = NULL;
 	struct clk_gate *gate = NULL;
 	struct clk_divider *div = NULL;
@@ -100,20 +100,18 @@ static struct clk *rockchip_clk_register_branch(const char *name,
 						: &clk_divider_ops;
 	}
 
-	clk = clk_register_composite(NULL, name, parent_names, num_parents,
-				     mux ? &mux->hw : NULL, mux_ops,
-				     div ? &div->hw : NULL, div_ops,
-				     gate ? &gate->hw : NULL, gate_ops,
-				     flags);
-
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		goto err_composite;
+	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
+				       mux ? &mux->hw : NULL, mux_ops,
+				       div ? &div->hw : NULL, div_ops,
+				       gate ? &gate->hw : NULL, gate_ops,
+				       flags);
+	if (IS_ERR(hw)) {
+		kfree(div);
+		kfree(gate);
+		return ERR_CAST(hw);
 	}
 
-	return clk;
-err_composite:
-	kfree(div);
+	return hw->clk;
 err_div:
 	kfree(gate);
 err_gate:
@@ -214,8 +212,8 @@ static struct clk *rockchip_clk_register_frac_branch(
 		unsigned long flags, struct rockchip_clk_branch *child,
 		spinlock_t *lock)
 {
+	struct clk_hw *hw;
 	struct rockchip_clk_frac *frac;
-	struct clk *clk;
 	struct clk_gate *gate = NULL;
 	struct clk_fractional_divider *div = NULL;
 	const struct clk_ops *div_ops = NULL, *gate_ops = NULL;
@@ -255,14 +253,14 @@ static struct clk *rockchip_clk_register_frac_branch(
 	div->approximation = rockchip_fractional_approximation;
 	div_ops = &clk_fractional_divider_ops;
 
-	clk = clk_register_composite(NULL, name, parent_names, num_parents,
-				     NULL, NULL,
-				     &div->hw, div_ops,
-				     gate ? &gate->hw : NULL, gate_ops,
-				     flags | CLK_SET_RATE_UNGATE);
-	if (IS_ERR(clk)) {
+	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
+				       NULL, NULL,
+				       &div->hw, div_ops,
+				       gate ? &gate->hw : NULL, gate_ops,
+				       flags | CLK_SET_RATE_UNGATE);
+	if (IS_ERR(hw)) {
 		kfree(frac);
-		return clk;
+		return ERR_CAST(hw);
 	}
 
 	if (child) {
@@ -292,7 +290,7 @@ static struct clk *rockchip_clk_register_frac_branch(
 		mux_clk = clk_register(NULL, &frac_mux->hw);
 		if (IS_ERR(mux_clk)) {
 			kfree(frac);
-			return clk;
+			return mux_clk;
 		}
 
 		rockchip_clk_add_lookup(ctx, mux_clk, child->id);
@@ -301,7 +299,7 @@ static struct clk *rockchip_clk_register_frac_branch(
 		if (frac->mux_frac_idx >= 0) {
 			pr_debug("%s: found fractional parent in mux at pos %d\n",
 				 __func__, frac->mux_frac_idx);
-			ret = clk_notifier_register(clk, &frac->clk_nb);
+			ret = clk_notifier_register(hw->clk, &frac->clk_nb);
 			if (ret)
 				pr_err("%s: failed to register clock notifier for %s\n",
 						__func__, name);
@@ -311,7 +309,7 @@ static struct clk *rockchip_clk_register_frac_branch(
 		}
 	}
 
-	return clk;
+	return hw->clk;
 }
 
 static struct clk *rockchip_clk_register_factor_branch(const char *name,
@@ -320,7 +318,7 @@ static struct clk *rockchip_clk_register_factor_branch(const char *name,
 		int gate_offset, u8 gate_shift, u8 gate_flags,
 		unsigned long flags, spinlock_t *lock)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_gate *gate = NULL;
 	struct clk_fixed_factor *fix = NULL;
 
@@ -349,16 +347,17 @@ static struct clk *rockchip_clk_register_factor_branch(const char *name,
 	fix->mult = mult;
 	fix->div = div;
 
-	clk = clk_register_composite(NULL, name, parent_names, num_parents,
-				     NULL, NULL,
-				     &fix->hw, &clk_fixed_factor_ops,
-				     &gate->hw, &clk_gate_ops, flags);
-	if (IS_ERR(clk)) {
+	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
+				       NULL, NULL,
+				       &fix->hw, &clk_fixed_factor_ops,
+				       &gate->hw, &clk_gate_ops, flags);
+	if (IS_ERR(hw)) {
 		kfree(fix);
 		kfree(gate);
+		return ERR_CAST(hw);
 	}
 
-	return clk;
+	return hw->clk;
 }
 
 struct rockchip_clk_provider * __init rockchip_clk_init(struct device_node *np,
-- 
2.17.1



