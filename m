Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0AEC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A54C82145D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgGNJLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:11:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:51794 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgGNJLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:11:50 -0400
IronPort-SDR: 2YivTD70UGgIt/VPD6Dcz6TXzWtyisi5pDmP7NskIEPvHuw9ImhBnZgJb3dLuz8dQfrEfSwdvA
 beClirzXF7uw==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="166951127"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="166951127"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 02:11:49 -0700
IronPort-SDR: yKTZT+SBvJfnSOK0GGyhxcmxNu/NPCJkYPAyUzt19BU5DaKxSE1d1rCkbTXanql2Rdv0hJHadm
 hhs3gAqBNffw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="307792061"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jul 2020 02:11:47 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar.linux@gmail.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v1] clk: intel: Address pending review concerns
Date:   Tue, 14 Jul 2020 17:11:44 +0800
Message-Id: <15ed3803e04699017c6a7909a8df83c215135a89.1594717630.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_hw_register() instead of clk_hw_register().
Remove unnecessary locking. Avoid memset by improving code.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 drivers/clk/x86/clk-cgu-pll.c |  2 +-
 drivers/clk/x86/clk-cgu.c     | 32 ++++++++++++--------------------
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/x86/clk-cgu-pll.c b/drivers/clk/x86/clk-cgu-pll.c
index c03cc6b85b9f..3179557b5f78 100644
--- a/drivers/clk/x86/clk-cgu-pll.c
+++ b/drivers/clk/x86/clk-cgu-pll.c
@@ -128,7 +128,7 @@ lgm_clk_register_pll(struct lgm_clk_provider *ctx,
 	pll->hw.init = &init;
 
 	hw = &pll->hw;
-	ret = clk_hw_register(dev, hw);
+	ret = devm_clk_hw_register(dev, hw);
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/drivers/clk/x86/clk-cgu.c b/drivers/clk/x86/clk-cgu.c
index 56af0e04ec1e..9a1be7035fd0 100644
--- a/drivers/clk/x86/clk-cgu.c
+++ b/drivers/clk/x86/clk-cgu.c
@@ -119,7 +119,7 @@ lgm_clk_register_mux(struct lgm_clk_provider *ctx,
 	mux->hw.init = &init;
 
 	hw = &mux->hw;
-	ret = clk_hw_register(dev, hw);
+	ret = devm_clk_hw_register(dev, hw);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -247,7 +247,7 @@ lgm_clk_register_divider(struct lgm_clk_provider *ctx,
 	div->hw.init = &init;
 
 	hw = &div->hw;
-	ret = clk_hw_register(dev, hw);
+	ret = devm_clk_hw_register(dev, hw);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -361,7 +361,7 @@ lgm_clk_register_gate(struct lgm_clk_provider *ctx,
 	gate->hw.init = &init;
 
 	hw = &gate->hw;
-	ret = clk_hw_register(dev, hw);
+	ret = devm_clk_hw_register(dev, hw);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -420,18 +420,14 @@ lgm_clk_ddiv_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 {
 	struct lgm_clk_ddiv *ddiv = to_lgm_clk_ddiv(hw);
 	unsigned int div0, div1, exdiv;
-	unsigned long flags;
 	u64 prate;
 
-	spin_lock_irqsave(&ddiv->lock, flags);
 	div0 = lgm_get_clk_val(ddiv->membase, ddiv->reg,
 			       ddiv->shift0, ddiv->width0) + 1;
 	div1 = lgm_get_clk_val(ddiv->membase, ddiv->reg,
 			       ddiv->shift1, ddiv->width1) + 1;
 	exdiv = lgm_get_clk_val(ddiv->membase, ddiv->reg,
 				ddiv->shift2, ddiv->width2);
-	spin_unlock_irqrestore(&ddiv->lock, flags);
-
 	prate = (u64)parent_rate;
 	do_div(prate, div0);
 	do_div(prate, div1);
@@ -548,24 +544,21 @@ lgm_clk_ddiv_round_rate(struct clk_hw *hw, unsigned long rate,
 		div = div * 2;
 		div = DIV_ROUND_CLOSEST_ULL((u64)div, 5);
 	}
+	spin_unlock_irqrestore(&ddiv->lock, flags);
 
-	if (div <= 0) {
-		spin_unlock_irqrestore(&ddiv->lock, flags);
+	if (div <= 0)
 		return *prate;
-	}
 
-	if (lgm_clk_get_ddiv_val(div, &ddiv1, &ddiv2) != 0) {
-		if (lgm_clk_get_ddiv_val(div + 1, &ddiv1, &ddiv2) != 0) {
-			spin_unlock_irqrestore(&ddiv->lock, flags);
+	if (lgm_clk_get_ddiv_val(div, &ddiv1, &ddiv2) != 0)
+		if (lgm_clk_get_ddiv_val(div + 1, &ddiv1, &ddiv2) != 0)
 			return -EINVAL;
-		}
-	}
 
 	rate64 = *prate;
 	do_div(rate64, ddiv1);
 	do_div(rate64, ddiv2);
 
 	/* if predivide bit is enabled, modify rounded rate by factor of 2.5 */
+	spin_lock_irqsave(&ddiv->lock, flags);
 	if (lgm_get_clk_val(ddiv->membase, ddiv->reg, ddiv->shift2, 1)) {
 		rate64 = rate64 * 2;
 		rate64 = DIV_ROUND_CLOSEST_ULL(rate64, 5);
@@ -588,19 +581,18 @@ int lgm_clk_register_ddiv(struct lgm_clk_provider *ctx,
 			  unsigned int nr_clk)
 {
 	struct device *dev = ctx->dev;
-	struct clk_init_data init = {};
-	struct lgm_clk_ddiv *ddiv;
 	struct clk_hw *hw;
 	unsigned int idx;
 	int ret;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
-		ddiv = NULL;
+		struct clk_init_data init = {};
+		struct lgm_clk_ddiv *ddiv = NULL;
+
 		ddiv = devm_kzalloc(dev, sizeof(*ddiv), GFP_KERNEL);
 		if (!ddiv)
 			return -ENOMEM;
 
-		memset(&init, 0, sizeof(init));
 		init.name = list->name;
 		init.ops = &lgm_clk_ddiv_ops;
 		init.flags = list->flags;
@@ -624,7 +616,7 @@ int lgm_clk_register_ddiv(struct lgm_clk_provider *ctx,
 		ddiv->hw.init = &init;
 
 		hw = &ddiv->hw;
-		ret = clk_hw_register(dev, hw);
+		ret = devm_clk_hw_register(dev, hw);
 		if (ret) {
 			dev_err(dev, "register clk: %s failed!\n", list->name);
 			return ret;
-- 
2.11.0

