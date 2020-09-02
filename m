Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAFAC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84FDB20826
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgIBGtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:49:15 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:38532 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgIBGtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:49:05 -0400
Received: from localhost (unknown [192.168.167.32])
        by lucky1.263xmail.com (Postfix) with ESMTP id 76658C64C8;
        Wed,  2 Sep 2020 14:49:00 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P11834T140500898137856S1599029334223657_;
        Wed, 02 Sep 2020 14:48:59 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <2f67782fa89e65d172c349c035c9cf16>
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
Subject: [PATCH v1 4/6] clk: rockchip: Export some clock common APIs for module drivers
Date:   Wed,  2 Sep 2020 14:48:45 +0800
Message-Id: <20200902064847.18881-5-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902064847.18881-1-zhangqing@rock-chips.com>
References: <20200902064847.18881-1-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used by the Rockchip clk driver, export it to allow that
driver to be compiled as a module.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk.c | 52 ++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 2cfebfb61814..796338c3bd6f 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -366,8 +366,9 @@ static struct clk *rockchip_clk_register_factor_branch(const char *name,
 	return clk;
 }
 
-struct rockchip_clk_provider * __init rockchip_clk_init(struct device_node *np,
-			void __iomem *base, unsigned long nr_clks)
+struct rockchip_clk_provider *rockchip_clk_init(struct device_node *np,
+						void __iomem *base,
+						unsigned long nr_clks)
 {
 	struct rockchip_clk_provider *ctx;
 	struct clk **clk_table;
@@ -399,14 +400,16 @@ struct rockchip_clk_provider * __init rockchip_clk_init(struct device_node *np,
 	kfree(ctx);
 	return ERR_PTR(-ENOMEM);
 }
+EXPORT_SYMBOL(rockchip_clk_init);
 
-void __init rockchip_clk_of_add_provider(struct device_node *np,
-				struct rockchip_clk_provider *ctx)
+void rockchip_clk_of_add_provider(struct device_node *np,
+				  struct rockchip_clk_provider *ctx)
 {
 	if (of_clk_add_provider(np, of_clk_src_onecell_get,
 				&ctx->clk_data))
 		pr_err("%s: could not register clk provider\n", __func__);
 }
+EXPORT_SYMBOL(rockchip_clk_of_add_provider);
 
 void rockchip_clk_add_lookup(struct rockchip_clk_provider *ctx,
 			     struct clk *clk, unsigned int id)
@@ -414,8 +417,9 @@ void rockchip_clk_add_lookup(struct rockchip_clk_provider *ctx,
 	if (ctx->clk_data.clks && id)
 		ctx->clk_data.clks[id] = clk;
 }
+EXPORT_SYMBOL(rockchip_clk_add_lookup);
 
-void __init rockchip_clk_register_plls(struct rockchip_clk_provider *ctx,
+void rockchip_clk_register_plls(struct rockchip_clk_provider *ctx,
 				struct rockchip_pll_clock *list,
 				unsigned int nr_pll, int grf_lock_offset)
 {
@@ -438,11 +442,11 @@ void __init rockchip_clk_register_plls(struct rockchip_clk_provider *ctx,
 		rockchip_clk_add_lookup(ctx, clk, list->id);
 	}
 }
+EXPORT_SYMBOL(rockchip_clk_register_plls);
 
-void __init rockchip_clk_register_branches(
-				      struct rockchip_clk_provider *ctx,
-				      struct rockchip_clk_branch *list,
-				      unsigned int nr_clk)
+void rockchip_clk_register_branches(struct rockchip_clk_provider *ctx,
+				    struct rockchip_clk_branch *list,
+				    unsigned int nr_clk)
 {
 	struct clk *clk = NULL;
 	unsigned int idx;
@@ -571,14 +575,15 @@ void __init rockchip_clk_register_branches(
 		rockchip_clk_add_lookup(ctx, clk, list->id);
 	}
 }
-
-void __init rockchip_clk_register_armclk(struct rockchip_clk_provider *ctx,
-			unsigned int lookup_id,
-			const char *name, const char *const *parent_names,
-			u8 num_parents,
-			const struct rockchip_cpuclk_reg_data *reg_data,
-			const struct rockchip_cpuclk_rate_table *rates,
-			int nrates)
+EXPORT_SYMBOL(rockchip_clk_register_branches);
+
+void rockchip_clk_register_armclk(struct rockchip_clk_provider *ctx,
+				  unsigned int lookup_id,
+				  const char *name, const char *const *parent_names,
+				  u8 num_parents,
+				  const struct rockchip_cpuclk_reg_data *reg_data,
+				  const struct rockchip_cpuclk_rate_table *rates,
+				  int nrates)
 {
 	struct clk *clk;
 
@@ -593,9 +598,10 @@ void __init rockchip_clk_register_armclk(struct rockchip_clk_provider *ctx,
 
 	rockchip_clk_add_lookup(ctx, clk, lookup_id);
 }
+EXPORT_SYMBOL(rockchip_clk_register_armclk);
 
-void __init rockchip_clk_protect_critical(const char *const clocks[],
-					  int nclocks)
+void rockchip_clk_protect_critical(const char *const clocks[],
+				   int nclocks)
 {
 	int i;
 
@@ -607,6 +613,7 @@ void __init rockchip_clk_protect_critical(const char *const clocks[],
 			clk_prepare_enable(clk);
 	}
 }
+EXPORT_SYMBOL(rockchip_clk_protect_critical);
 
 static void __iomem *rst_base;
 static unsigned int reg_restart;
@@ -626,10 +633,10 @@ static struct notifier_block rockchip_restart_handler = {
 	.priority = 128,
 };
 
-void __init
+void
 rockchip_register_restart_notifier(struct rockchip_clk_provider *ctx,
-					       unsigned int reg,
-					       void (*cb)(void))
+				   unsigned int reg,
+				   void (*cb)(void))
 {
 	int ret;
 
@@ -641,3 +648,4 @@ rockchip_register_restart_notifier(struct rockchip_clk_provider *ctx,
 		pr_err("%s: cannot register restart handler, %d\n",
 		       __func__, ret);
 }
+EXPORT_SYMBOL(rockchip_register_restart_notifier);
-- 
2.17.1



