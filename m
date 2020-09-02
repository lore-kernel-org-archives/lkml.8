Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15581C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD2720826
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgIBGtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:49:08 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:44838 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgIBGtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:49:05 -0400
Received: from localhost (unknown [192.168.167.32])
        by lucky1.263xmail.com (Postfix) with ESMTP id AA8F0A28B8;
        Wed,  2 Sep 2020 14:48:56 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P11834T140500898137856S1599029334223657_;
        Wed, 02 Sep 2020 14:48:56 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <9031bee566e3d13e8f138596523814dc>
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
Subject: [PATCH v1 1/6] clk: rockchip: Use clk_hw_register_composite instead of clk_register_composite calls
Date:   Wed,  2 Sep 2020 14:48:42 +0800
Message-Id: <20200902064847.18881-2-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902064847.18881-1-zhangqing@rock-chips.com>
References: <20200902064847.18881-1-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_hw_register_composite it's already exported.
Preparation for compilation of rK common clock drivers into modules.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-half-divider.c | 12 +++++----
 drivers/clk/rockchip/clk.c              | 35 ++++++++++++++-----------
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/rockchip/clk-half-divider.c b/drivers/clk/rockchip/clk-half-divider.c
index b333fc28c94b..35db0651ea1d 100644
--- a/drivers/clk/rockchip/clk-half-divider.c
+++ b/drivers/clk/rockchip/clk-half-divider.c
@@ -166,6 +166,7 @@ struct clk *rockchip_clk_register_halfdiv(const char *name,
 					  unsigned long flags,
 					  spinlock_t *lock)
 {
+	struct clk_hw *hw;
 	struct clk *clk;
 	struct clk_mux *mux = NULL;
 	struct clk_gate *gate = NULL;
@@ -212,12 +213,13 @@ struct clk *rockchip_clk_register_halfdiv(const char *name,
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
 
+	clk = hw->clk;
 	return clk;
 err_div:
 	kfree(gate);
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 546e810c3560..2cfebfb61814 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -43,6 +43,7 @@ static struct clk *rockchip_clk_register_branch(const char *name,
 		u8 gate_shift, u8 gate_flags, unsigned long flags,
 		spinlock_t *lock)
 {
+	struct clk_hw *hw;
 	struct clk *clk;
 	struct clk_mux *mux = NULL;
 	struct clk_gate *gate = NULL;
@@ -100,12 +101,12 @@ static struct clk *rockchip_clk_register_branch(const char *name,
 						: &clk_divider_ops;
 	}
 
-	clk = clk_register_composite(NULL, name, parent_names, num_parents,
-				     mux ? &mux->hw : NULL, mux_ops,
-				     div ? &div->hw : NULL, div_ops,
-				     gate ? &gate->hw : NULL, gate_ops,
-				     flags);
-
+	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
+				       mux ? &mux->hw : NULL, mux_ops,
+				       div ? &div->hw : NULL, div_ops,
+				       gate ? &gate->hw : NULL, gate_ops,
+				       flags);
+	clk = hw->clk;
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
 		goto err_composite;
@@ -214,6 +215,7 @@ static struct clk *rockchip_clk_register_frac_branch(
 		unsigned long flags, struct rockchip_clk_branch *child,
 		spinlock_t *lock)
 {
+	struct clk_hw *hw;
 	struct rockchip_clk_frac *frac;
 	struct clk *clk;
 	struct clk_gate *gate = NULL;
@@ -255,11 +257,12 @@ static struct clk *rockchip_clk_register_frac_branch(
 	div->approximation = rockchip_fractional_approximation;
 	div_ops = &clk_fractional_divider_ops;
 
-	clk = clk_register_composite(NULL, name, parent_names, num_parents,
-				     NULL, NULL,
-				     &div->hw, div_ops,
-				     gate ? &gate->hw : NULL, gate_ops,
-				     flags | CLK_SET_RATE_UNGATE);
+	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
+				       NULL, NULL,
+				       &div->hw, div_ops,
+				       gate ? &gate->hw : NULL, gate_ops,
+				       flags | CLK_SET_RATE_UNGATE);
+	clk = hw->clk;
 	if (IS_ERR(clk)) {
 		kfree(frac);
 		return clk;
@@ -320,6 +323,7 @@ static struct clk *rockchip_clk_register_factor_branch(const char *name,
 		int gate_offset, u8 gate_shift, u8 gate_flags,
 		unsigned long flags, spinlock_t *lock)
 {
+	struct clk_hw *hw;
 	struct clk *clk;
 	struct clk_gate *gate = NULL;
 	struct clk_fixed_factor *fix = NULL;
@@ -349,10 +353,11 @@ static struct clk *rockchip_clk_register_factor_branch(const char *name,
 	fix->mult = mult;
 	fix->div = div;
 
-	clk = clk_register_composite(NULL, name, parent_names, num_parents,
-				     NULL, NULL,
-				     &fix->hw, &clk_fixed_factor_ops,
-				     &gate->hw, &clk_gate_ops, flags);
+	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
+				       NULL, NULL,
+				       &fix->hw, &clk_fixed_factor_ops,
+				       &gate->hw, &clk_gate_ops, flags);
+	clk = hw->clk;
 	if (IS_ERR(clk)) {
 		kfree(fix);
 		kfree(gate);
-- 
2.17.1



