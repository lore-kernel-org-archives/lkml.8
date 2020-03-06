Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD08C3F2D9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87252073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgCFG2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 01:28:20 -0500
Received: from mga11.intel.com ([192.55.52.93]:34721 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbgCFG2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 01:28:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 22:28:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,521,1574150400"; 
   d="scan'208";a="387737531"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga004.jf.intel.com with ESMTP; 05 Mar 2020 22:28:13 -0800
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        yixin.zhu@linux.intel.com, cheol.yong.kim@intel.com,
        rtanwar <rahul.tanwar@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v6 2/2] clk: intel: Add CGU clock driver for a new SoC
Date:   Fri,  6 Mar 2020 14:28:01 +0800
Message-Id: <62a564b4b17edea7fb86d7166e482e22fac3748c.1583475488.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1583475488.git.rahul.tanwar@linux.intel.com>
References: <cover.1583475488.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1583475488.git.rahul.tanwar@linux.intel.com>
References: <cover.1583475488.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: rtanwar <rahul.tanwar@intel.com>

Clock Generation Unit(CGU) is a new clock controller IP of a forthcoming
Intel network processor SoC named Lightning Mountain(LGM). It provides
programming interfaces to control & configure all CPU & peripheral clocks.
Add common clock framework based clock controller driver for CGU.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 drivers/clk/Kconfig           |   1 +
 drivers/clk/x86/Kconfig       |   8 +
 drivers/clk/x86/Makefile      |   1 +
 drivers/clk/x86/clk-cgu-pll.c | 156 +++++++++++
 drivers/clk/x86/clk-cgu.c     | 636 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/x86/clk-cgu.h     | 335 ++++++++++++++++++++++
 drivers/clk/x86/clk-lgm.c     | 492 ++++++++++++++++++++++++++++++++
 7 files changed, 1629 insertions(+)
 create mode 100644 drivers/clk/x86/Kconfig
 create mode 100644 drivers/clk/x86/clk-cgu-pll.c
 create mode 100644 drivers/clk/x86/clk-cgu.c
 create mode 100644 drivers/clk/x86/clk-cgu.h
 create mode 100644 drivers/clk/x86/clk-lgm.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index bcb257baed06..43dab257e7aa 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -360,6 +360,7 @@ source "drivers/clk/sunxi-ng/Kconfig"
 source "drivers/clk/tegra/Kconfig"
 source "drivers/clk/ti/Kconfig"
 source "drivers/clk/uniphier/Kconfig"
+source "drivers/clk/x86/Kconfig"
 source "drivers/clk/zynqmp/Kconfig"
 
 endmenu
diff --git a/drivers/clk/x86/Kconfig b/drivers/clk/x86/Kconfig
new file mode 100644
index 000000000000..69642e15fcc1
--- /dev/null
+++ b/drivers/clk/x86/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config CLK_LGM_CGU
+	depends on OF && HAS_IOMEM && (X86 || COMPILE_TEST)
+	select OF_EARLY_FLATTREE
+	bool "Clock driver for Lightning Mountain(LGM) platform"
+	help
+	  Clock Generation Unit(CGU) driver for Intel Lightning Mountain(LGM)
+	  network processor SoC.
diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile
index e3ec81e2a1c2..7c774ea7ddeb 100644
--- a/drivers/clk/x86/Makefile
+++ b/drivers/clk/x86/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_PMC_ATOM)		+= clk-pmc-atom.o
 obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)	+= clk-st.o
 clk-x86-lpss-objs		:= clk-lpt.o
 obj-$(CONFIG_X86_INTEL_LPSS)	+= clk-x86-lpss.o
+obj-$(CONFIG_CLK_LGM_CGU)	+= clk-cgu.o clk-cgu-pll.o clk-lgm.o
diff --git a/drivers/clk/x86/clk-cgu-pll.c b/drivers/clk/x86/clk-cgu-pll.c
new file mode 100644
index 000000000000..c03cc6b85b9f
--- /dev/null
+++ b/drivers/clk/x86/clk-cgu-pll.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Intel Corporation.
+ * Zhu YiXin <yixin.zhu@intel.com>
+ * Rahul Tanwar <rahul.tanwar@intel.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/iopoll.h>
+#include <linux/of.h>
+
+#include "clk-cgu.h"
+
+#define to_lgm_clk_pll(_hw)	container_of(_hw, struct lgm_clk_pll, hw)
+#define PLL_REF_DIV(x)		((x) + 0x08)
+
+/*
+ * Calculate formula:
+ * rate = (prate * mult + (prate * frac) / frac_div) / div
+ */
+static unsigned long
+lgm_pll_calc_rate(unsigned long prate, unsigned int mult,
+		  unsigned int div, unsigned int frac, unsigned int frac_div)
+{
+	u64 crate, frate, rate64;
+
+	rate64 = prate;
+	crate = rate64 * mult;
+	frate = rate64 * frac;
+	do_div(frate, frac_div);
+	crate += frate;
+	do_div(crate, div);
+
+	return crate;
+}
+
+static unsigned long lgm_pll_recalc_rate(struct clk_hw *hw, unsigned long prate)
+{
+	struct lgm_clk_pll *pll = to_lgm_clk_pll(hw);
+	unsigned int div, mult, frac;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pll->lock, flags);
+	mult = lgm_get_clk_val(pll->membase, PLL_REF_DIV(pll->reg), 0, 12);
+	div = lgm_get_clk_val(pll->membase, PLL_REF_DIV(pll->reg), 18, 6);
+	frac = lgm_get_clk_val(pll->membase, pll->reg, 2, 24);
+	spin_unlock_irqrestore(&pll->lock, flags);
+
+	if (pll->type == TYPE_LJPLL)
+		div *= 4;
+
+	return lgm_pll_calc_rate(prate, mult, div, frac, BIT(24));
+}
+
+static int lgm_pll_is_enabled(struct clk_hw *hw)
+{
+	struct lgm_clk_pll *pll = to_lgm_clk_pll(hw);
+	unsigned long flags;
+	unsigned int ret;
+
+	spin_lock_irqsave(&pll->lock, flags);
+	ret = lgm_get_clk_val(pll->membase, pll->reg, 0, 1);
+	spin_unlock_irqrestore(&pll->lock, flags);
+
+	return ret;
+}
+
+static int lgm_pll_enable(struct clk_hw *hw)
+{
+	struct lgm_clk_pll *pll = to_lgm_clk_pll(hw);
+	unsigned long flags;
+	u32 val;
+	int ret;
+
+	spin_lock_irqsave(&pll->lock, flags);
+	lgm_set_clk_val(pll->membase, pll->reg, 0, 1, 1);
+	ret = readl_poll_timeout_atomic(pll->membase + pll->reg,
+					val, (val & 0x1), 1, 100);
+	spin_unlock_irqrestore(&pll->lock, flags);
+
+	return ret;
+}
+
+static void lgm_pll_disable(struct clk_hw *hw)
+{
+	struct lgm_clk_pll *pll = to_lgm_clk_pll(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(&pll->lock, flags);
+	lgm_set_clk_val(pll->membase, pll->reg, 0, 1, 0);
+	spin_unlock_irqrestore(&pll->lock, flags);
+}
+
+static const struct clk_ops lgm_pll_ops = {
+	.recalc_rate = lgm_pll_recalc_rate,
+	.is_enabled = lgm_pll_is_enabled,
+	.enable = lgm_pll_enable,
+	.disable = lgm_pll_disable,
+};
+
+static struct clk_hw *
+lgm_clk_register_pll(struct lgm_clk_provider *ctx,
+		     const struct lgm_pll_clk_data *list)
+{
+	struct clk_init_data init = {};
+	struct lgm_clk_pll *pll;
+	struct device *dev = ctx->dev;
+	struct clk_hw *hw;
+	int ret;
+
+	init.ops = &lgm_pll_ops;
+	init.name = list->name;
+	init.flags = list->flags;
+	init.parent_data = list->parent_data;
+	init.num_parents = list->num_parents;
+
+	pll = devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->membase = ctx->membase;
+	pll->lock = ctx->lock;
+	pll->reg = list->reg;
+	pll->flags = list->flags;
+	pll->type = list->type;
+	pll->hw.init = &init;
+
+	hw = &pll->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return hw;
+}
+
+int lgm_clk_register_plls(struct lgm_clk_provider *ctx,
+			  const struct lgm_pll_clk_data *list,
+			  unsigned int nr_clk)
+{
+	struct clk_hw *hw;
+	int i;
+
+	for (i = 0; i < nr_clk; i++, list++) {
+		hw = lgm_clk_register_pll(ctx, list);
+		if (IS_ERR(hw)) {
+			dev_err(ctx->dev, "failed to register pll: %s\n",
+				list->name);
+			return PTR_ERR(hw);
+		}
+		ctx->clk_data.hws[list->id] = hw;
+	}
+
+	return 0;
+}
diff --git a/drivers/clk/x86/clk-cgu.c b/drivers/clk/x86/clk-cgu.c
new file mode 100644
index 000000000000..802a7fa88535
--- /dev/null
+++ b/drivers/clk/x86/clk-cgu.c
@@ -0,0 +1,636 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Intel Corporation.
+ * Zhu YiXin <yixin.zhu@intel.com>
+ * Rahul Tanwar <rahul.tanwar@intel.com>
+ */
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/of.h>
+
+#include "clk-cgu.h"
+
+#define GATE_HW_REG_STAT(reg)	((reg) + 0x0)
+#define GATE_HW_REG_EN(reg)	((reg) + 0x4)
+#define GATE_HW_REG_DIS(reg)	((reg) + 0x8)
+#define MAX_DDIV_REG	8
+#define MAX_DIVIDER_VAL 64
+
+#define to_lgm_clk_mux(_hw) container_of(_hw, struct lgm_clk_mux, hw)
+#define to_lgm_clk_divider(_hw) container_of(_hw, struct lgm_clk_divider, hw)
+#define to_lgm_clk_gate(_hw) container_of(_hw, struct lgm_clk_gate, hw)
+#define to_lgm_clk_ddiv(_hw) container_of(_hw, struct lgm_clk_ddiv, hw)
+
+static struct clk_hw *lgm_clk_register_fixed(struct lgm_clk_provider *ctx,
+					     const struct lgm_clk_branch *list)
+{
+	unsigned long flags;
+
+	if (list->div_flags & CLOCK_FLAG_VAL_INIT) {
+		spin_lock_irqsave(&ctx->lock, flags);
+		lgm_set_clk_val(ctx->membase, list->div_off, list->div_shift,
+				list->div_width, list->div_val);
+		spin_unlock_irqrestore(&ctx->lock, flags);
+	}
+
+	return clk_hw_register_fixed_rate(NULL, list->name,
+					  list->parent_data[0].name,
+					  list->flags, list->mux_flags);
+}
+
+static u8 lgm_clk_mux_get_parent(struct clk_hw *hw)
+{
+	struct lgm_clk_mux *mux = to_lgm_clk_mux(hw);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&mux->lock, flags);
+	if (mux->flags & MUX_CLK_SW)
+		val = mux->reg;
+	else
+		val = lgm_get_clk_val(mux->membase, mux->reg, mux->shift,
+				      mux->width);
+	spin_unlock_irqrestore(&mux->lock, flags);
+	return clk_mux_val_to_index(hw, NULL, mux->flags, val);
+}
+
+static int lgm_clk_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct lgm_clk_mux *mux = to_lgm_clk_mux(hw);
+	unsigned long flags;
+	u32 val;
+
+	val = clk_mux_index_to_val(NULL, mux->flags, index);
+	spin_lock_irqsave(&mux->lock, flags);
+	if (mux->flags & MUX_CLK_SW)
+		mux->reg = val;
+	else
+		lgm_set_clk_val(mux->membase, mux->reg, mux->shift,
+				mux->width, val);
+	spin_unlock_irqrestore(&mux->lock, flags);
+
+	return 0;
+}
+
+static int lgm_clk_mux_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
+{
+	struct lgm_clk_mux *mux = to_lgm_clk_mux(hw);
+
+	return clk_mux_determine_rate_flags(hw, req, mux->flags);
+}
+
+static const struct clk_ops lgm_clk_mux_ops = {
+	.get_parent = lgm_clk_mux_get_parent,
+	.set_parent = lgm_clk_mux_set_parent,
+	.determine_rate = lgm_clk_mux_determine_rate,
+};
+
+static struct clk_hw *
+lgm_clk_register_mux(struct lgm_clk_provider *ctx,
+		     const struct lgm_clk_branch *list)
+{
+	unsigned long flags, cflags = list->mux_flags;
+	struct device *dev = ctx->dev;
+	u8 shift = list->mux_shift;
+	u8 width = list->mux_width;
+	struct clk_init_data init = {};
+	struct lgm_clk_mux *mux;
+	u32 reg = list->mux_off;
+	struct clk_hw *hw;
+	int ret;
+
+	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = list->name;
+	init.ops = &lgm_clk_mux_ops;
+	init.flags = list->flags;
+	init.parent_data = list->parent_data;
+	init.num_parents = list->num_parents;
+
+	mux->membase = ctx->membase;
+	mux->lock = ctx->lock;
+	mux->reg = reg;
+	mux->shift = shift;
+	mux->width = width;
+	mux->flags = cflags;
+	mux->hw.init = &init;
+
+	hw = &mux->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (cflags & CLOCK_FLAG_VAL_INIT) {
+		spin_lock_irqsave(&mux->lock, flags);
+		lgm_set_clk_val(mux->membase, reg, shift, width, list->mux_val);
+		spin_unlock_irqrestore(&mux->lock, flags);
+	}
+
+	return hw;
+}
+
+static unsigned long
+lgm_clk_divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct lgm_clk_divider *divider = to_lgm_clk_divider(hw);
+	unsigned long flags;
+	unsigned int val;
+
+	spin_lock_irqsave(&divider->lock, flags);
+	val = lgm_get_clk_val(divider->membase, divider->reg,
+			      divider->shift, divider->width);
+	spin_unlock_irqrestore(&divider->lock, flags);
+
+	return divider_recalc_rate(hw, parent_rate, val, divider->table,
+				   divider->flags, divider->width);
+}
+
+static long
+lgm_clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
+			   unsigned long *prate)
+{
+	struct lgm_clk_divider *divider = to_lgm_clk_divider(hw);
+
+	return divider_round_rate(hw, rate, prate, divider->table,
+				  divider->width, divider->flags);
+}
+
+static int
+lgm_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
+			 unsigned long prate)
+{
+	struct lgm_clk_divider *divider = to_lgm_clk_divider(hw);
+	unsigned long flags;
+	int value;
+
+	value = divider_get_val(rate, prate, divider->table,
+				divider->width, divider->flags);
+	if (value < 0)
+		return value;
+
+	spin_lock_irqsave(&divider->lock, flags);
+	lgm_set_clk_val(divider->membase, divider->reg,
+			divider->shift, divider->width, value);
+	spin_unlock_irqrestore(&divider->lock, flags);
+
+	return 0;
+}
+
+static int lgm_clk_divider_enable_disable(struct clk_hw *hw, int enable)
+{
+	struct lgm_clk_divider *div = to_lgm_clk_divider(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(&div->lock, flags);
+	lgm_set_clk_val(div->membase, div->reg, div->shift_gate,
+			div->width_gate, enable);
+	spin_unlock_irqrestore(&div->lock, flags);
+	return 0;
+}
+
+static int lgm_clk_divider_enable(struct clk_hw *hw)
+{
+	return lgm_clk_divider_enable_disable(hw, 1);
+}
+
+static void lgm_clk_divider_disable(struct clk_hw *hw)
+{
+	lgm_clk_divider_enable_disable(hw, 0);
+}
+
+static const struct clk_ops lgm_clk_divider_ops = {
+	.recalc_rate = lgm_clk_divider_recalc_rate,
+	.round_rate = lgm_clk_divider_round_rate,
+	.set_rate = lgm_clk_divider_set_rate,
+	.enable = lgm_clk_divider_enable,
+	.disable = lgm_clk_divider_disable,
+};
+
+static struct clk_hw *
+lgm_clk_register_divider(struct lgm_clk_provider *ctx,
+			 const struct lgm_clk_branch *list)
+{
+	unsigned long flags, cflags = list->div_flags;
+	struct device *dev = ctx->dev;
+	struct lgm_clk_divider *div;
+	struct clk_init_data init = {};
+	u8 shift = list->div_shift;
+	u8 width = list->div_width;
+	u8 shift_gate = list->div_shift_gate;
+	u8 width_gate = list->div_width_gate;
+	u32 reg = list->div_off;
+	struct clk_hw *hw;
+	int ret;
+
+	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = list->name;
+	init.ops = &lgm_clk_divider_ops;
+	init.flags = list->flags;
+	init.parent_data = list->parent_data;
+	init.num_parents = 1;
+
+	div->membase = ctx->membase;
+	div->lock = ctx->lock;
+	div->reg = reg;
+	div->shift = shift;
+	div->width = width;
+	div->shift_gate	= shift_gate;
+	div->width_gate	= width_gate;
+	div->flags = cflags;
+	div->table = list->div_table;
+	div->hw.init = &init;
+
+	hw = &div->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (cflags & CLOCK_FLAG_VAL_INIT) {
+		spin_lock_irqsave(&div->lock, flags);
+		lgm_set_clk_val(div->membase, reg, shift, width, list->div_val);
+		spin_unlock_irqrestore(&div->lock, flags);
+	}
+
+	return hw;
+}
+
+static struct clk_hw *
+lgm_clk_register_fixed_factor(struct lgm_clk_provider *ctx,
+			      const struct lgm_clk_branch *list)
+{
+	unsigned long flags;
+	struct clk_hw *hw;
+
+	hw = clk_hw_register_fixed_factor(ctx->dev, list->name,
+					  list->parent_data[0].name, list->flags,
+					  list->mult, list->div);
+	if (IS_ERR(hw))
+		return ERR_CAST(hw);
+
+	if (list->div_flags & CLOCK_FLAG_VAL_INIT) {
+		spin_lock_irqsave(&ctx->lock, flags);
+		lgm_set_clk_val(ctx->membase, list->div_off, list->div_shift,
+				list->div_width, list->div_val);
+		spin_unlock_irqrestore(&ctx->lock, flags);
+	}
+
+	return hw;
+}
+
+static int lgm_clk_gate_enable(struct clk_hw *hw)
+{
+	struct lgm_clk_gate *gate = to_lgm_clk_gate(hw);
+	unsigned long flags;
+	unsigned int reg;
+
+	spin_lock_irqsave(&gate->lock, flags);
+	reg = GATE_HW_REG_EN(gate->reg);
+	lgm_set_clk_val(gate->membase, reg, gate->shift, 1, 1);
+	spin_unlock_irqrestore(&gate->lock, flags);
+
+	return 0;
+}
+
+static void lgm_clk_gate_disable(struct clk_hw *hw)
+{
+	struct lgm_clk_gate *gate = to_lgm_clk_gate(hw);
+	unsigned long flags;
+	unsigned int reg;
+
+	spin_lock_irqsave(&gate->lock, flags);
+	reg = GATE_HW_REG_DIS(gate->reg);
+	lgm_set_clk_val(gate->membase, reg, gate->shift, 1, 1);
+	spin_unlock_irqrestore(&gate->lock, flags);
+}
+
+static int lgm_clk_gate_is_enabled(struct clk_hw *hw)
+{
+	struct lgm_clk_gate *gate = to_lgm_clk_gate(hw);
+	unsigned int reg, ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gate->lock, flags);
+	reg = GATE_HW_REG_STAT(gate->reg);
+	ret = lgm_get_clk_val(gate->membase, reg, gate->shift, 1);
+	spin_unlock_irqrestore(&gate->lock, flags);
+
+	return ret;
+}
+
+static const struct clk_ops lgm_clk_gate_ops = {
+	.enable = lgm_clk_gate_enable,
+	.disable = lgm_clk_gate_disable,
+	.is_enabled = lgm_clk_gate_is_enabled,
+};
+
+static struct clk_hw *
+lgm_clk_register_gate(struct lgm_clk_provider *ctx,
+		      const struct lgm_clk_branch *list)
+{
+	unsigned long flags, cflags = list->gate_flags;
+	const char *pname = list->parent_data[0].name;
+	struct device *dev = ctx->dev;
+	u8 shift = list->gate_shift;
+	struct clk_init_data init = {};
+	struct lgm_clk_gate *gate;
+	u32 reg = list->gate_off;
+	struct clk_hw *hw;
+	int ret;
+
+	gate = devm_kzalloc(dev, sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = list->name;
+	init.ops = &lgm_clk_gate_ops;
+	init.flags = list->flags;
+	init.parent_names = pname ? &pname : NULL;
+	init.num_parents = pname ? 1 : 0;
+
+	gate->membase = ctx->membase;
+	gate->lock = ctx->lock;
+	gate->reg = reg;
+	gate->shift = shift;
+	gate->flags = cflags;
+	gate->hw.init = &init;
+
+	hw = &gate->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (cflags & CLOCK_FLAG_VAL_INIT) {
+		spin_lock_irqsave(&gate->lock, flags);
+		lgm_set_clk_val(gate->membase, reg, shift, 1, list->gate_val);
+		spin_unlock_irqrestore(&gate->lock, flags);
+	}
+
+	return hw;
+}
+
+int lgm_clk_register_branches(struct lgm_clk_provider *ctx,
+			      const struct lgm_clk_branch *list,
+			      unsigned int nr_clk)
+{
+	struct clk_hw *hw;
+	unsigned int idx;
+
+	for (idx = 0; idx < nr_clk; idx++, list++) {
+		switch (list->type) {
+		case CLK_TYPE_FIXED:
+			hw = lgm_clk_register_fixed(ctx, list);
+			break;
+		case CLK_TYPE_MUX:
+			hw = lgm_clk_register_mux(ctx, list);
+			break;
+		case CLK_TYPE_DIVIDER:
+			hw = lgm_clk_register_divider(ctx, list);
+			break;
+		case CLK_TYPE_FIXED_FACTOR:
+			hw = lgm_clk_register_fixed_factor(ctx, list);
+			break;
+		case CLK_TYPE_GATE:
+			hw = lgm_clk_register_gate(ctx, list);
+			break;
+		default:
+			dev_err(ctx->dev, "invalid clk type\n");
+			return -EINVAL;
+		}
+
+		if (IS_ERR(hw)) {
+			dev_err(ctx->dev,
+				"register clk: %s, type: %u failed!\n",
+				list->name, list->type);
+			return -EIO;
+		}
+		ctx->clk_data.hws[list->id] = hw;
+	}
+
+	return 0;
+}
+
+static unsigned long
+lgm_clk_ddiv_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct lgm_clk_ddiv *ddiv = to_lgm_clk_ddiv(hw);
+	unsigned int div0, div1, exdiv;
+	unsigned long flags;
+	u64 prate;
+
+	spin_lock_irqsave(&ddiv->lock, flags);
+	div0 = lgm_get_clk_val(ddiv->membase, ddiv->reg,
+			       ddiv->shift0, ddiv->width0) + 1;
+	div1 = lgm_get_clk_val(ddiv->membase, ddiv->reg,
+			       ddiv->shift1, ddiv->width1) + 1;
+	exdiv = lgm_get_clk_val(ddiv->membase, ddiv->reg,
+				ddiv->shift2, ddiv->width2);
+	spin_unlock_irqrestore(&ddiv->lock, flags);
+
+	prate = (u64)parent_rate;
+	do_div(prate, div0);
+	do_div(prate, div1);
+
+	if (exdiv) {
+		do_div(prate, ddiv->div);
+		prate *= ddiv->mult;
+	}
+
+	return prate;
+}
+
+static int lgm_clk_ddiv_enable(struct clk_hw *hw)
+{
+	struct lgm_clk_ddiv *ddiv = to_lgm_clk_ddiv(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ddiv->lock, flags);
+	lgm_set_clk_val(ddiv->membase, ddiv->reg, ddiv->shift_gate,
+			ddiv->width_gate, 1);
+	spin_unlock_irqrestore(&ddiv->lock, flags);
+	return 0;
+}
+
+static void lgm_clk_ddiv_disable(struct clk_hw *hw)
+{
+	struct lgm_clk_ddiv *ddiv = to_lgm_clk_ddiv(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ddiv->lock, flags);
+	lgm_set_clk_val(ddiv->membase, ddiv->reg, ddiv->shift_gate,
+			ddiv->width_gate, 0);
+	spin_unlock_irqrestore(&ddiv->lock, flags);
+}
+
+static int
+lgm_clk_get_ddiv_val(u32 div, u32 *ddiv1, u32 *ddiv2)
+{
+	u32 idx, temp;
+
+	*ddiv1 = 1;
+	*ddiv2 = 1;
+
+	if (div > MAX_DIVIDER_VAL)
+		div = MAX_DIVIDER_VAL;
+
+	if (div > 1) {
+		for (idx = 2; idx <= MAX_DDIV_REG; idx++) {
+			temp = DIV_ROUND_UP_ULL((u64)div, idx);
+			if (div % idx == 0 && temp <= MAX_DDIV_REG)
+				break;
+		}
+
+		if (idx > MAX_DDIV_REG)
+			return -EINVAL;
+
+		*ddiv1 = temp;
+		*ddiv2 = idx;
+	}
+
+	return 0;
+}
+
+static int
+lgm_clk_ddiv_set_rate(struct clk_hw *hw, unsigned long rate,
+		      unsigned long prate)
+{
+	struct lgm_clk_ddiv *ddiv = to_lgm_clk_ddiv(hw);
+	u32 div, ddiv1, ddiv2;
+	unsigned long flags;
+
+	div = DIV_ROUND_CLOSEST_ULL((u64)prate, rate);
+
+	spin_lock_irqsave(&ddiv->lock, flags);
+	if (lgm_get_clk_val(ddiv->membase, ddiv->reg, ddiv->shift2, 1)) {
+		div = DIV_ROUND_CLOSEST_ULL((u64)div, 5);
+		div = div * 2;
+	}
+
+	if (div <= 0) {
+		spin_unlock_irqrestore(&ddiv->lock, flags);
+		return -EINVAL;
+	}
+
+	if (lgm_clk_get_ddiv_val(div, &ddiv1, &ddiv2)) {
+		spin_unlock_irqrestore(&ddiv->lock, flags);
+		return -EINVAL;
+	}
+
+	lgm_set_clk_val(ddiv->membase, ddiv->reg, ddiv->shift0, ddiv->width0,
+			ddiv1 - 1);
+
+	lgm_set_clk_val(ddiv->membase, ddiv->reg,  ddiv->shift1, ddiv->width1,
+			ddiv2 - 1);
+	spin_unlock_irqrestore(&ddiv->lock, flags);
+
+	return 0;
+}
+
+static long
+lgm_clk_ddiv_round_rate(struct clk_hw *hw, unsigned long rate,
+			unsigned long *prate)
+{
+	struct lgm_clk_ddiv *ddiv = to_lgm_clk_ddiv(hw);
+	u32 div, ddiv1, ddiv2;
+	unsigned long flags;
+	u64 rate64 = rate;
+
+	div = DIV_ROUND_CLOSEST_ULL((u64)*prate, rate);
+
+	/* if predivide bit is enabled, modify div by factor of 2.5 */
+	spin_lock_irqsave(&ddiv->lock, flags);
+	if (lgm_get_clk_val(ddiv->membase, ddiv->reg, ddiv->shift2, 1)) {
+		div = div * 2;
+		div = DIV_ROUND_CLOSEST_ULL((u64)div, 5);
+	}
+
+	if (div <= 0) {
+		spin_unlock_irqrestore(&ddiv->lock, flags);
+		return *prate;
+	}
+
+	if (lgm_clk_get_ddiv_val(div, &ddiv1, &ddiv2) != 0) {
+		if (lgm_clk_get_ddiv_val(div + 1, &ddiv1, &ddiv2) != 0) {
+			spin_unlock_irqrestore(&ddiv->lock, flags);
+			return -EINVAL;
+		}
+	}
+
+	rate64 = *prate;
+	do_div(rate64, ddiv1);
+	do_div(rate64, ddiv2);
+
+	/* if predivide bit is enabled, modify rounded rate by factor of 2.5 */
+	if (lgm_get_clk_val(ddiv->membase, ddiv->reg, ddiv->shift2, 1)) {
+		rate64 = rate64 * 2;
+		rate64 = DIV_ROUND_CLOSEST_ULL(rate64, 5);
+	}
+	spin_unlock_irqrestore(&ddiv->lock, flags);
+
+	return rate64;
+}
+
+static const struct clk_ops lgm_clk_ddiv_ops = {
+	.recalc_rate = lgm_clk_ddiv_recalc_rate,
+	.enable	= lgm_clk_ddiv_enable,
+	.disable = lgm_clk_ddiv_disable,
+	.set_rate = lgm_clk_ddiv_set_rate,
+	.round_rate = lgm_clk_ddiv_round_rate,
+};
+
+int lgm_clk_register_ddiv(struct lgm_clk_provider *ctx,
+			  const struct lgm_clk_ddiv_data *list,
+			  unsigned int nr_clk)
+{
+	struct device *dev = ctx->dev;
+	struct clk_init_data init = {};
+	struct lgm_clk_ddiv *ddiv;
+	struct clk_hw *hw;
+	unsigned int idx;
+	int ret;
+
+	for (idx = 0; idx < nr_clk; idx++, list++) {
+		ddiv = NULL;
+		ddiv = devm_kzalloc(dev, sizeof(*ddiv), GFP_KERNEL);
+		if (!ddiv)
+			return -ENOMEM;
+
+		memset(&init, 0, sizeof(init));
+		init.name = list->name;
+		init.ops = &lgm_clk_ddiv_ops;
+		init.flags = list->flags;
+		init.parent_data = list->parent_data;
+		init.num_parents = 1;
+
+		ddiv->membase = ctx->membase;
+		ddiv->lock = ctx->lock;
+		ddiv->reg = list->reg;
+		ddiv->shift0 = list->shift0;
+		ddiv->width0 = list->width0;
+		ddiv->shift1 = list->shift1;
+		ddiv->width1 = list->width1;
+		ddiv->shift_gate = list->shift_gate;
+		ddiv->width_gate = list->width_gate;
+		ddiv->shift2 = list->ex_shift;
+		ddiv->width2 = list->ex_width;
+		ddiv->flags = list->div_flags;
+		ddiv->mult = 2;
+		ddiv->div = 5;
+		ddiv->hw.init = &init;
+
+		hw = &ddiv->hw;
+		ret = clk_hw_register(dev, hw);
+		if (ret) {
+			dev_err(dev, "register clk: %s failed!\n", list->name);
+			return ret;
+		}
+		ctx->clk_data.hws[list->id] = hw;
+	}
+
+	return 0;
+}
diff --git a/drivers/clk/x86/clk-cgu.h b/drivers/clk/x86/clk-cgu.h
new file mode 100644
index 000000000000..c916e568ea9e
--- /dev/null
+++ b/drivers/clk/x86/clk-cgu.h
@@ -0,0 +1,335 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright(c) 2020 Intel Corporation.
+ * Zhu YiXin <yixin.zhu@intel.com>
+ * Rahul Tanwar <rahul.tanwar@intel.com>
+ */
+
+#ifndef __CLK_CGU_H
+#define __CLK_CGU_H
+
+#include <linux/io.h>
+
+struct lgm_clk_mux {
+	struct clk_hw hw;
+	void __iomem *membase;
+	unsigned int reg;
+	u8 shift;
+	u8 width;
+	unsigned long flags;
+	spinlock_t lock;
+};
+
+struct lgm_clk_divider {
+	struct clk_hw hw;
+	void __iomem *membase;
+	unsigned int reg;
+	u8 shift;
+	u8 width;
+	u8 shift_gate;
+	u8 width_gate;
+	unsigned long flags;
+	const struct clk_div_table *table;
+	spinlock_t lock;
+};
+
+struct lgm_clk_ddiv {
+	struct clk_hw hw;
+	void __iomem *membase;
+	unsigned int reg;
+	u8 shift0;
+	u8 width0;
+	u8 shift1;
+	u8 width1;
+	u8 shift2;
+	u8 width2;
+	u8 shift_gate;
+	u8 width_gate;
+	unsigned int mult;
+	unsigned int div;
+	unsigned long flags;
+	spinlock_t lock;
+};
+
+struct lgm_clk_gate {
+	struct clk_hw hw;
+	void __iomem *membase;
+	unsigned int reg;
+	u8 shift;
+	unsigned long flags;
+	spinlock_t lock;
+};
+
+enum lgm_clk_type {
+	CLK_TYPE_FIXED,
+	CLK_TYPE_MUX,
+	CLK_TYPE_DIVIDER,
+	CLK_TYPE_FIXED_FACTOR,
+	CLK_TYPE_GATE,
+	CLK_TYPE_NONE,
+};
+
+/**
+ * struct lgm_clk_provider
+ * @membase: IO mem base address for CGU.
+ * @np: device node
+ * @dev: device
+ * @clk_data: array of hw clocks and clk number.
+ */
+struct lgm_clk_provider {
+	void __iomem *membase;
+	struct device_node *np;
+	struct device *dev;
+	struct clk_hw_onecell_data clk_data;
+	spinlock_t lock;
+};
+
+enum pll_type {
+	TYPE_ROPLL,
+	TYPE_LJPLL,
+	TYPE_NONE,
+};
+
+struct lgm_clk_pll {
+	struct clk_hw hw;
+	void __iomem *membase;
+	unsigned int reg;
+	unsigned long flags;
+	enum pll_type type;
+	spinlock_t lock;
+};
+
+/**
+ * struct lgm_pll_clk_data
+ * @id: platform specific id of the clock.
+ * @name: name of this pll clock.
+ * @parent_names: name of the parent clock.
+ * @num_parents: number of parents.
+ * @flags: optional flags for basic clock.
+ * @type: platform type of pll.
+ * @reg: offset of the register.
+ */
+struct lgm_pll_clk_data {
+	unsigned int id;
+	const char *name;
+	const struct clk_parent_data *parent_data;
+	u8 num_parents;
+	unsigned long flags;
+	enum pll_type type;
+	int reg;
+};
+
+#define LGM_PLL(_id, _name, _pdata, _flags,		\
+		_reg, _type)				\
+	{						\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_data = _pdata,			\
+		.num_parents = ARRAY_SIZE(_pdata),	\
+		.flags = _flags,			\
+		.reg = _reg,				\
+		.type = _type,				\
+	}
+
+struct lgm_clk_ddiv_data {
+	unsigned int id;
+	const char *name;
+	const struct clk_parent_data *parent_data;
+	u8 flags;
+	unsigned long div_flags;
+	unsigned int reg;
+	u8 shift0;
+	u8 width0;
+	u8 shift1;
+	u8 width1;
+	u8 shift_gate;
+	u8 width_gate;
+	u8 ex_shift;
+	u8 ex_width;
+};
+
+#define LGM_DDIV(_id, _name, _pname, _flags, _reg,		\
+		 _shft0, _wdth0, _shft1, _wdth1,		\
+		 _shft_gate, _wdth_gate, _xshft, _df)		\
+	{							\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_data = &(const struct clk_parent_data){	\
+			.fw_name = _pname,			\
+			.name = _pname,				\
+		},						\
+		.flags = _flags,				\
+		.reg = _reg,					\
+		.shift0 = _shft0,				\
+		.width0 = _wdth0,				\
+		.shift1 = _shft1,				\
+		.width1 = _wdth1,				\
+		.shift_gate = _shft_gate,			\
+		.width_gate = _wdth_gate,			\
+		.ex_shift = _xshft,				\
+		.ex_width = 1,					\
+		.div_flags = _df,				\
+	}
+
+struct lgm_clk_branch {
+	unsigned int id;
+	enum lgm_clk_type type;
+	const char *name;
+	const struct clk_parent_data *parent_data;
+	u8 num_parents;
+	unsigned long flags;
+	unsigned int mux_off;
+	u8 mux_shift;
+	u8 mux_width;
+	unsigned long mux_flags;
+	unsigned int mux_val;
+	unsigned int div_off;
+	u8 div_shift;
+	u8 div_width;
+	u8 div_shift_gate;
+	u8 div_width_gate;
+	unsigned long div_flags;
+	unsigned int div_val;
+	const struct clk_div_table *div_table;
+	unsigned int gate_off;
+	u8 gate_shift;
+	unsigned long gate_flags;
+	unsigned int gate_val;
+	unsigned int mult;
+	unsigned int div;
+};
+
+/* clock flags definition */
+#define CLOCK_FLAG_VAL_INIT	BIT(16)
+#define MUX_CLK_SW		BIT(17)
+
+#define LGM_MUX(_id, _name, _pdata, _f, _reg,		\
+		_shift, _width, _cf, _v)		\
+	{						\
+		.id = _id,				\
+		.type = CLK_TYPE_MUX,			\
+		.name = _name,				\
+		.parent_data = _pdata,			\
+		.num_parents = ARRAY_SIZE(_pdata),	\
+		.flags = _f,				\
+		.mux_off = _reg,			\
+		.mux_shift = _shift,			\
+		.mux_width = _width,			\
+		.mux_flags = _cf,			\
+		.mux_val = _v,				\
+	}
+
+#define LGM_DIV(_id, _name, _pname, _f, _reg, _shift, _width,	\
+		_shift_gate, _width_gate, _cf, _v, _dtable)	\
+	{							\
+		.id = _id,					\
+		.type = CLK_TYPE_DIVIDER,			\
+		.name = _name,					\
+		.parent_data = &(const struct clk_parent_data){	\
+			.fw_name = _pname,			\
+			.name = _pname,				\
+		},						\
+		.num_parents = 1,				\
+		.flags = _f,					\
+		.div_off = _reg,				\
+		.div_shift = _shift,				\
+		.div_width = _width,				\
+		.div_shift_gate = _shift_gate,			\
+		.div_width_gate = _width_gate,			\
+		.div_flags = _cf,				\
+		.div_val = _v,					\
+		.div_table = _dtable,				\
+	}
+
+#define LGM_GATE(_id, _name, _pname, _f, _reg,			\
+		 _shift, _cf, _v)				\
+	{							\
+		.id = _id,					\
+		.type = CLK_TYPE_GATE,				\
+		.name = _name,					\
+		.parent_data = &(const struct clk_parent_data){	\
+			.fw_name = _pname,			\
+			.name = _pname,				\
+		},						\
+		.num_parents = !_pname ? 0 : 1,			\
+		.flags = _f,					\
+		.gate_off = _reg,				\
+		.gate_shift = _shift,				\
+		.gate_flags = _cf,				\
+		.gate_val = _v,					\
+	}
+
+#define LGM_FIXED(_id, _name, _pname, _f, _reg,			\
+		  _shift, _width, _cf, _freq, _v)		\
+	{							\
+		.id = _id,					\
+		.type = CLK_TYPE_FIXED,				\
+		.name = _name,					\
+		.parent_data = &(const struct clk_parent_data){	\
+			.fw_name = _pname,			\
+			.name = _pname,				\
+		},						\
+		.num_parents = !_pname ? 0 : 1,			\
+		.flags = _f,					\
+		.div_off = _reg,				\
+		.div_shift = _shift,				\
+		.div_width = _width,				\
+		.div_flags = _cf,				\
+		.div_val = _v,					\
+		.mux_flags = _freq,				\
+	}
+
+#define LGM_FIXED_FACTOR(_id, _name, _pname, _f, _reg,		\
+			 _shift, _width, _cf, _v, _m, _d)	\
+	{							\
+		.id = _id,					\
+		.type = CLK_TYPE_FIXED_FACTOR,			\
+		.name = _name,					\
+		.parent_data = &(const struct clk_parent_data){	\
+			.fw_name = _pname,			\
+			.name = _pname,				\
+		},						\
+		.num_parents = 1,				\
+		.flags = _f,					\
+		.div_off = _reg,				\
+		.div_shift = _shift,				\
+		.div_width = _width,				\
+		.div_flags = _cf,				\
+		.div_val = _v,					\
+		.mult = _m,					\
+		.div = _d,					\
+	}
+
+static inline void lgm_set_clk_val(void __iomem *membase, u32 reg,
+				   u8 shift, u8 width, u32 set_val)
+{
+	u32 mask = (GENMASK(width - 1, 0) << shift);
+	u32 regval;
+
+	regval = readl(membase + reg);
+	regval = (regval & ~mask) | ((set_val << shift) & mask);
+	writel(regval, membase + reg);
+}
+
+static inline u32 lgm_get_clk_val(void __iomem *membase, u32 reg,
+				  u8 shift, u8 width)
+{
+	u32 mask = (GENMASK(width - 1, 0) << shift);
+	u32 val;
+
+	val = readl(membase + reg);
+	val = (val & mask) >> shift;
+
+	return val;
+}
+
+int lgm_clk_register_branches(struct lgm_clk_provider *ctx,
+			      const struct lgm_clk_branch *list,
+			      unsigned int nr_clk);
+int lgm_clk_register_plls(struct lgm_clk_provider *ctx,
+			  const struct lgm_pll_clk_data *list,
+			  unsigned int nr_clk);
+int lgm_clk_register_ddiv(struct lgm_clk_provider *ctx,
+			  const struct lgm_clk_ddiv_data *list,
+			  unsigned int nr_clk);
+#endif	/* __CLK_CGU_H */
diff --git a/drivers/clk/x86/clk-lgm.c b/drivers/clk/x86/clk-lgm.c
new file mode 100644
index 000000000000..ffbd2c425dc3
--- /dev/null
+++ b/drivers/clk/x86/clk-lgm.c
@@ -0,0 +1,492 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Intel Corporation.
+ * Zhu YiXin <yixin.zhu@intel.com>
+ * Rahul Tanwar <rahul.tanwar@intel.com>
+ */
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/clock/intel,lgm-clk.h>
+#include "clk-cgu.h"
+
+#define PLL_DIV_WIDTH		4
+#define PLL_DDIV_WIDTH		3
+
+/* Gate0 clock shift */
+#define G_C55_SHIFT		7
+#define G_QSPI_SHIFT		9
+#define G_EIP197_SHIFT		11
+#define G_VAULT130_SHIFT	12
+#define G_TOE_SHIFT		13
+#define G_SDXC_SHIFT		14
+#define G_EMMC_SHIFT		15
+#define G_SPIDBG_SHIFT		17
+#define G_DMA3_SHIFT		28
+
+/* Gate1 clock shift */
+#define G_DMA0_SHIFT		0
+#define G_LEDC0_SHIFT		1
+#define G_LEDC1_SHIFT		2
+#define G_I2S0_SHIFT		3
+#define G_I2S1_SHIFT		4
+#define G_EBU_SHIFT		5
+#define G_PWM_SHIFT		6
+#define G_I2C0_SHIFT		7
+#define G_I2C1_SHIFT		8
+#define G_I2C2_SHIFT		9
+#define G_I2C3_SHIFT		10
+
+#define G_SSC0_SHIFT		12
+#define G_SSC1_SHIFT		13
+#define G_SSC2_SHIFT		14
+#define G_SSC3_SHIFT		15
+
+#define G_GPTC0_SHIFT		17
+#define G_GPTC1_SHIFT		18
+#define G_GPTC2_SHIFT		19
+#define G_GPTC3_SHIFT		20
+
+#define G_ASC0_SHIFT		22
+#define G_ASC1_SHIFT		23
+#define G_ASC2_SHIFT		24
+#define G_ASC3_SHIFT		25
+
+#define G_PCM0_SHIFT		27
+#define G_PCM1_SHIFT		28
+#define G_PCM2_SHIFT		29
+
+/* Gate2 clock shift */
+#define G_PCIE10_SHIFT		1
+#define G_PCIE11_SHIFT		2
+#define G_PCIE30_SHIFT		3
+#define G_PCIE31_SHIFT		4
+#define G_PCIE20_SHIFT		5
+#define G_PCIE21_SHIFT		6
+#define G_PCIE40_SHIFT		7
+#define G_PCIE41_SHIFT		8
+
+#define G_XPCS0_SHIFT		10
+#define G_XPCS1_SHIFT		11
+#define G_XPCS2_SHIFT		12
+#define G_XPCS3_SHIFT		13
+#define G_SATA0_SHIFT		14
+#define G_SATA1_SHIFT		15
+#define G_SATA2_SHIFT		16
+#define G_SATA3_SHIFT		17
+
+/* Gate3 clock shift */
+#define G_ARCEM4_SHIFT		0
+#define G_IDMAR1_SHIFT		2
+#define G_IDMAT0_SHIFT		3
+#define G_IDMAT1_SHIFT		4
+#define G_IDMAT2_SHIFT		5
+
+#define G_PPV4_SHIFT		8
+#define G_GSWIPO_SHIFT		9
+#define G_CQEM_SHIFT		10
+#define G_XPCS5_SHIFT		14
+#define G_USB1_SHIFT		25
+#define G_USB2_SHIFT		26
+
+
+/* Register definition */
+#define CGU_PLL0CZ_CFG0		0x000
+#define CGU_PLL0CM0_CFG0	0x020
+#define CGU_PLL0CM1_CFG0	0x040
+#define CGU_PLL0B_CFG0		0x060
+#define CGU_PLL1_CFG0		0x080
+#define CGU_PLL2_CFG0		0x0A0
+#define CGU_PLLPP_CFG0		0x0C0
+#define CGU_LJPLL3_CFG0		0x0E0
+#define CGU_LJPLL4_CFG0		0x100
+#define CGU_C55_PCMCR		0x18C
+#define CGU_PCMCR		0x190
+#define CGU_IF_CLK1		0x1A0
+#define CGU_IF_CLK2		0x1A4
+#define CGU_GATE0		0x300
+#define CGU_GATE1		0x310
+#define CGU_GATE2		0x320
+#define CGU_GATE3		0x310
+
+#define PLL_DIV(x)		((x) + 0x04)
+#define PLL_SSC(x)		((x) + 0x10)
+
+#define CLK_NR_CLKS		(LGM_GCLK_USB2 + 1)
+
+/*
+ * Below table defines the pair's of regval & effective dividers.
+ * It's more efficient to provide an explicit table due to non-linear
+ * relation between values.
+ */
+static const struct clk_div_table pll_div[] = {
+	{ .val = 0, .div = 1 },
+	{ .val = 1, .div = 2 },
+	{ .val = 2, .div = 3 },
+	{ .val = 3, .div = 4 },
+	{ .val = 4, .div = 5 },
+	{ .val = 5, .div = 6 },
+	{ .val = 6, .div = 8 },
+	{ .val = 7, .div = 10 },
+	{ .val = 8, .div = 12 },
+	{ .val = 9, .div = 16 },
+	{ .val = 10, .div = 20 },
+	{ .val = 11, .div = 24 },
+	{ .val = 12, .div = 32 },
+	{ .val = 13, .div = 40 },
+	{ .val = 14, .div = 48 },
+	{ .val = 15, .div = 64 },
+	{}
+};
+
+static const struct clk_div_table dcl_div[] = {
+	{ .val = 0, .div = 6  },
+	{ .val = 1, .div = 12 },
+	{ .val = 2, .div = 24 },
+	{ .val = 3, .div = 32 },
+	{ .val = 4, .div = 48 },
+	{ .val = 5, .div = 96 },
+	{}
+};
+
+static const struct clk_parent_data pll_p[] = {
+	{ .fw_name = "osc", .name = "osc" },
+};
+static const struct clk_parent_data pllcm_p[] = {
+	{ .fw_name = "cpu_cm", .name = "cpu_cm" },
+};
+static const struct clk_parent_data emmc_p[] = {
+	{ .fw_name = "emmc4", .name = "emmc4" },
+	{ .fw_name = "noc4", .name = "noc4" },
+};
+static const struct clk_parent_data sdxc_p[] = {
+	{ .fw_name = "sdxc3", .name = "sdxc3" },
+	{ .fw_name = "sdxc2", .name = "sdxc2" },
+};
+static const struct clk_parent_data pcm_p[] = {
+	{ .fw_name = "v_docsis", .name = "v_docsis" },
+	{ .fw_name = "dcl", .name = "dcl" },
+};
+static const struct clk_parent_data cbphy_p[] = {
+	{ .fw_name = "dd_serdes", .name = "dd_serdes" },
+	{ .fw_name = "dd_pcie", .name = "dd_pcie" },
+};
+
+static const struct lgm_pll_clk_data lgm_pll_clks[] = {
+	LGM_PLL(LGM_CLK_PLL0CZ, "pll0cz", pll_p, CLK_IGNORE_UNUSED,
+		CGU_PLL0CZ_CFG0, TYPE_ROPLL),
+	LGM_PLL(LGM_CLK_PLL0CM0, "pll0cm0", pllcm_p, CLK_IGNORE_UNUSED,
+		CGU_PLL0CM0_CFG0, TYPE_ROPLL),
+	LGM_PLL(LGM_CLK_PLL0CM1, "pll0cm1", pllcm_p, CLK_IGNORE_UNUSED,
+		CGU_PLL0CM1_CFG0, TYPE_ROPLL),
+	LGM_PLL(LGM_CLK_PLL0B, "pll0b", pll_p, CLK_IGNORE_UNUSED,
+		CGU_PLL0B_CFG0, TYPE_ROPLL),
+	LGM_PLL(LGM_CLK_PLL1, "pll1", pll_p, 0, CGU_PLL1_CFG0, TYPE_ROPLL),
+	LGM_PLL(LGM_CLK_PLL2, "pll2", pll_p, CLK_IGNORE_UNUSED,
+		CGU_PLL2_CFG0, TYPE_ROPLL),
+	LGM_PLL(LGM_CLK_PLLPP, "pllpp", pll_p, 0, CGU_PLLPP_CFG0, TYPE_ROPLL),
+	LGM_PLL(LGM_CLK_LJPLL3, "ljpll3", pll_p, 0, CGU_LJPLL3_CFG0, TYPE_LJPLL),
+	LGM_PLL(LGM_CLK_LJPLL4, "ljpll4", pll_p, 0, CGU_LJPLL4_CFG0, TYPE_LJPLL),
+};
+
+static const struct lgm_clk_branch lgm_branch_clks[] = {
+	LGM_DIV(LGM_CLK_PP_HW, "pp_hw", "pllpp", 0, PLL_DIV(CGU_PLLPP_CFG0),
+		0, PLL_DIV_WIDTH, 24, 1, 0, 0, pll_div),
+	LGM_DIV(LGM_CLK_PP_UC, "pp_uc", "pllpp", 0, PLL_DIV(CGU_PLLPP_CFG0),
+		4, PLL_DIV_WIDTH, 25, 1, 0, 0, pll_div),
+	LGM_DIV(LGM_CLK_PP_FXD, "pp_fxd", "pllpp", 0, PLL_DIV(CGU_PLLPP_CFG0),
+		8, PLL_DIV_WIDTH, 26, 1, 0, 0, pll_div),
+	LGM_DIV(LGM_CLK_PP_TBM, "pp_tbm", "pllpp", 0, PLL_DIV(CGU_PLLPP_CFG0),
+		12, PLL_DIV_WIDTH, 27, 1, 0, 0, pll_div),
+	LGM_DIV(LGM_CLK_DDR, "ddr", "pll2", CLK_IGNORE_UNUSED,
+		PLL_DIV(CGU_PLL2_CFG0), 0, PLL_DIV_WIDTH, 24, 1, 0, 0,
+		pll_div),
+	LGM_DIV(LGM_CLK_CM, "cpu_cm", "pll0cz", 0, PLL_DIV(CGU_PLL0CZ_CFG0),
+		0, PLL_DIV_WIDTH, 24, 1, 0, 0, pll_div),
+
+	LGM_DIV(LGM_CLK_IC, "cpu_ic", "pll0cz", CLK_IGNORE_UNUSED,
+		PLL_DIV(CGU_PLL0CZ_CFG0), 4, PLL_DIV_WIDTH, 25,
+		1, 0, 0, pll_div),
+
+	LGM_DIV(LGM_CLK_SDXC3, "sdxc3", "pll0cz", 0, PLL_DIV(CGU_PLL0CZ_CFG0),
+		8, PLL_DIV_WIDTH, 26, 1, 0, 0, pll_div),
+
+	LGM_DIV(LGM_CLK_CPU0, "cm0", "pll0cm0",
+		CLK_IGNORE_UNUSED, PLL_DIV(CGU_PLL0CM0_CFG0),
+		0, PLL_DIV_WIDTH, 24, 1, 0, 0, pll_div),
+	LGM_DIV(LGM_CLK_CPU1, "cm1", "pll0cm1",
+		CLK_IGNORE_UNUSED, PLL_DIV(CGU_PLL0CM1_CFG0),
+		0, PLL_DIV_WIDTH, 24, 1, 0, 0, pll_div),
+
+	/*
+	 * Marking ngi_clk (next generation interconnect) and noc_clk
+	 * (network on chip peripheral clk) as critical clocks because
+	 * these are shared parent clock sources for many different
+	 * peripherals.
+	 */
+	LGM_DIV(LGM_CLK_NGI, "ngi", "pll0b",
+		(CLK_IGNORE_UNUSED|CLK_IS_CRITICAL), PLL_DIV(CGU_PLL0B_CFG0),
+		0, PLL_DIV_WIDTH, 24, 1, 0, 0, pll_div),
+	LGM_DIV(LGM_CLK_NOC4, "noc4", "pll0b",
+		(CLK_IGNORE_UNUSED|CLK_IS_CRITICAL), PLL_DIV(CGU_PLL0B_CFG0),
+		4, PLL_DIV_WIDTH, 25, 1, 0, 0, pll_div),
+	LGM_DIV(LGM_CLK_SW, "switch", "pll0b", 0, PLL_DIV(CGU_PLL0B_CFG0),
+		8, PLL_DIV_WIDTH, 26, 1, 0, 0, pll_div),
+	LGM_DIV(LGM_CLK_QSPI, "qspi", "pll0b", 0, PLL_DIV(CGU_PLL0B_CFG0),
+		12, PLL_DIV_WIDTH, 27, 1, 0, 0, pll_div),
+	LGM_DIV(LGM_CLK_CT, "v_ct", "pll1", 0, PLL_DIV(CGU_PLL1_CFG0),
+		0, PLL_DIV_WIDTH, 24, 1, 0, 0, pll_div),
+	LGM_DIV(LGM_CLK_DSP, "v_dsp", "pll1", 0, PLL_DIV(CGU_PLL1_CFG0),
+		8, PLL_DIV_WIDTH, 26, 1, 0, 0, pll_div),
+	LGM_DIV(LGM_CLK_VIF, "v_ifclk", "pll1", 0, PLL_DIV(CGU_PLL1_CFG0),
+		12, PLL_DIV_WIDTH, 27, 1, 0, 0, pll_div),
+
+	LGM_FIXED_FACTOR(LGM_CLK_EMMC4, "emmc4", "sdxc3", 0,  0,
+			 0, 0, 0, 0, 1, 4),
+	LGM_FIXED_FACTOR(LGM_CLK_SDXC2, "sdxc2", "noc4", 0,  0,
+			 0, 0, 0, 0, 1, 4),
+	LGM_MUX(LGM_CLK_EMMC, "emmc", emmc_p, 0, CGU_IF_CLK1,
+		0, 1, CLK_MUX_ROUND_CLOSEST, 0),
+	LGM_MUX(LGM_CLK_SDXC, "sdxc", sdxc_p, 0, CGU_IF_CLK1,
+		1, 1, CLK_MUX_ROUND_CLOSEST, 0),
+	LGM_FIXED(LGM_CLK_OSC, "osc", NULL, 0, 0, 0, 0, 0, 40000000, 0),
+	LGM_FIXED(LGM_CLK_SLIC, "slic", NULL, 0, CGU_IF_CLK1,
+		  8, 2, CLOCK_FLAG_VAL_INIT, 8192000, 2),
+	LGM_FIXED(LGM_CLK_DOCSIS, "v_docsis", NULL, 0, 0, 0, 0, 0, 16000000, 0),
+	LGM_DIV(LGM_CLK_DCL, "dcl", "v_ifclk", 0, CGU_PCMCR,
+		25, 3, 0, 0, 0, 0, dcl_div),
+	LGM_MUX(LGM_CLK_PCM, "pcm", pcm_p, 0, CGU_C55_PCMCR,
+		0, 1, CLK_MUX_ROUND_CLOSEST, 0),
+	LGM_FIXED_FACTOR(LGM_CLK_DDR_PHY, "ddr_phy", "ddr",
+			 CLK_IGNORE_UNUSED, 0,
+			 0, 0, 0, 0, 2, 1),
+	LGM_FIXED_FACTOR(LGM_CLK_PONDEF, "pondef", "dd_pool",
+			 CLK_SET_RATE_PARENT, 0, 0, 0, 0, 0, 1, 2),
+	LGM_MUX(LGM_CLK_CBPHY0, "cbphy0", cbphy_p, 0, 0,
+		0, 0, MUX_CLK_SW | CLK_MUX_ROUND_CLOSEST, 0),
+	LGM_MUX(LGM_CLK_CBPHY1, "cbphy1", cbphy_p, 0, 0,
+		0, 0, MUX_CLK_SW | CLK_MUX_ROUND_CLOSEST, 0),
+	LGM_MUX(LGM_CLK_CBPHY2, "cbphy2", cbphy_p, 0, 0,
+		0, 0, MUX_CLK_SW | CLK_MUX_ROUND_CLOSEST, 0),
+	LGM_MUX(LGM_CLK_CBPHY3, "cbphy3", cbphy_p, 0, 0,
+		0, 0, MUX_CLK_SW | CLK_MUX_ROUND_CLOSEST, 0),
+
+	LGM_GATE(LGM_GCLK_C55, "g_c55", NULL, 0, CGU_GATE0,
+		 G_C55_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_QSPI, "g_qspi", "qspi", 0, CGU_GATE0,
+		 G_QSPI_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_EIP197, "g_eip197", NULL, 0, CGU_GATE0,
+		 G_EIP197_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_VAULT, "g_vault130", NULL, 0, CGU_GATE0,
+		 G_VAULT130_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_TOE, "g_toe", NULL, 0, CGU_GATE0,
+		 G_TOE_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_SDXC, "g_sdxc", "sdxc", 0, CGU_GATE0,
+		 G_SDXC_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_EMMC, "g_emmc", "emmc", 0, CGU_GATE0,
+		 G_EMMC_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_SPI_DBG, "g_spidbg", NULL, 0, CGU_GATE0,
+		 G_SPIDBG_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_DMA3, "g_dma3", NULL, 0, CGU_GATE0,
+		 G_DMA3_SHIFT, 0, 0),
+
+	LGM_GATE(LGM_GCLK_DMA0, "g_dma0", NULL, 0, CGU_GATE1,
+		 G_DMA0_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_LEDC0, "g_ledc0", NULL, 0, CGU_GATE1,
+		 G_LEDC0_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_LEDC1, "g_ledc1", NULL, 0, CGU_GATE1,
+		 G_LEDC1_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_I2S0, "g_i2s0", NULL, 0, CGU_GATE1,
+		 G_I2S0_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_I2S1, "g_i2s1", NULL, 0, CGU_GATE1,
+		 G_I2S1_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_EBU, "g_ebu", NULL, 0, CGU_GATE1,
+		 G_EBU_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_PWM, "g_pwm", NULL, 0, CGU_GATE1,
+		 G_PWM_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_I2C0, "g_i2c0", NULL, 0, CGU_GATE1,
+		 G_I2C0_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_I2C1, "g_i2c1", NULL, 0, CGU_GATE1,
+		 G_I2C1_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_I2C2, "g_i2c2", NULL, 0, CGU_GATE1,
+		 G_I2C2_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_I2C3, "g_i2c3", NULL, 0, CGU_GATE1,
+		 G_I2C3_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_SSC0, "g_ssc0", "noc4", 0, CGU_GATE1,
+		 G_SSC0_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_SSC1, "g_ssc1", "noc4", 0, CGU_GATE1,
+		 G_SSC1_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_SSC2, "g_ssc2", "noc4", 0, CGU_GATE1,
+		 G_SSC2_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_SSC3, "g_ssc3", "noc4", 0, CGU_GATE1,
+		 G_SSC3_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_GPTC0, "g_gptc0", "noc4", 0, CGU_GATE1,
+		 G_GPTC0_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_GPTC1, "g_gptc1", "noc4", 0, CGU_GATE1,
+		 G_GPTC1_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_GPTC2, "g_gptc2", "noc4", 0, CGU_GATE1,
+		 G_GPTC2_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_GPTC3, "g_gptc3", "osc", 0, CGU_GATE1,
+		 G_GPTC3_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_ASC0, "g_asc0", "noc4", 0, CGU_GATE1,
+		 G_ASC0_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_ASC1, "g_asc1", "noc4", 0, CGU_GATE1,
+		 G_ASC1_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_ASC2, "g_asc2", "noc4", 0, CGU_GATE1,
+		 G_ASC2_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_ASC3, "g_asc3", "osc", 0, CGU_GATE1,
+		 G_ASC3_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_PCM0, "g_pcm0", NULL, 0, CGU_GATE1,
+		 G_PCM0_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_PCM1, "g_pcm1", NULL, 0, CGU_GATE1,
+		 G_PCM1_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_PCM2, "g_pcm2", NULL, 0, CGU_GATE1,
+		 G_PCM2_SHIFT, 0, 0),
+
+	LGM_GATE(LGM_GCLK_PCIE10, "g_pcie10", NULL, 0, CGU_GATE2,
+		 G_PCIE10_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_PCIE11, "g_pcie11", NULL, 0, CGU_GATE2,
+		 G_PCIE11_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_PCIE30, "g_pcie30", NULL, 0, CGU_GATE2,
+		 G_PCIE30_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_PCIE31, "g_pcie31", NULL, 0, CGU_GATE2,
+		 G_PCIE31_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_PCIE20, "g_pcie20", NULL, 0, CGU_GATE2,
+		 G_PCIE20_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_PCIE21, "g_pcie21", NULL, 0, CGU_GATE2,
+		 G_PCIE21_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_PCIE40, "g_pcie40", NULL, 0, CGU_GATE2,
+		 G_PCIE40_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_PCIE41, "g_pcie41", NULL, 0, CGU_GATE2,
+		 G_PCIE41_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_XPCS0, "g_xpcs0", NULL, 0, CGU_GATE2,
+		 G_XPCS0_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_XPCS1, "g_xpcs1", NULL, 0, CGU_GATE2,
+		 G_XPCS1_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_XPCS2, "g_xpcs2", NULL, 0, CGU_GATE2,
+		 G_XPCS2_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_XPCS3, "g_xpcs3", NULL, 0, CGU_GATE2,
+		 G_XPCS3_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_SATA0, "g_sata0", NULL, 0, CGU_GATE2,
+		 G_SATA0_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_SATA1, "g_sata1", NULL, 0, CGU_GATE2,
+		 G_SATA1_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_SATA2, "g_sata2", NULL, 0, CGU_GATE2,
+		 G_SATA2_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_SATA3, "g_sata3", NULL, 0, CGU_GATE2,
+		 G_SATA3_SHIFT, 0, 0),
+
+	LGM_GATE(LGM_GCLK_ARCEM4, "g_arcem4", NULL, 0, CGU_GATE3,
+		 G_ARCEM4_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_IDMAR1, "g_idmar1", NULL, 0, CGU_GATE3,
+		 G_IDMAR1_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_IDMAT0, "g_idmat0", NULL, 0, CGU_GATE3,
+		 G_IDMAT0_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_IDMAT1, "g_idmat1", NULL, 0, CGU_GATE3,
+		 G_IDMAT1_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_IDMAT2, "g_idmat2", NULL, 0, CGU_GATE3,
+		 G_IDMAT2_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_PPV4, "g_ppv4", NULL, 0, CGU_GATE3,
+		 G_PPV4_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_GSWIPO, "g_gswipo", "switch", 0, CGU_GATE3,
+		 G_GSWIPO_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_CQEM, "g_cqem", "switch", 0, CGU_GATE3,
+		 G_CQEM_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_XPCS5, "g_xpcs5", NULL, 0, CGU_GATE3,
+		 G_XPCS5_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_USB1, "g_usb1", NULL, 0, CGU_GATE3,
+		 G_USB1_SHIFT, 0, 0),
+	LGM_GATE(LGM_GCLK_USB2, "g_usb2", NULL, 0, CGU_GATE3,
+		 G_USB2_SHIFT, 0, 0),
+};
+
+
+static const struct lgm_clk_ddiv_data lgm_ddiv_clks[] = {
+	LGM_DDIV(LGM_CLK_CML, "dd_cml", "ljpll3", 0,
+		 PLL_DIV(CGU_LJPLL3_CFG0), 0, PLL_DDIV_WIDTH,
+		 3, PLL_DDIV_WIDTH, 24, 1, 29, 0),
+	LGM_DDIV(LGM_CLK_SERDES, "dd_serdes", "ljpll3", 0,
+		 PLL_DIV(CGU_LJPLL3_CFG0), 6, PLL_DDIV_WIDTH,
+		 9, PLL_DDIV_WIDTH, 25, 1, 28, 0),
+	LGM_DDIV(LGM_CLK_POOL, "dd_pool", "ljpll3", 0,
+		 PLL_DIV(CGU_LJPLL3_CFG0), 12, PLL_DDIV_WIDTH,
+		 15, PLL_DDIV_WIDTH, 26, 1, 28, 0),
+	LGM_DDIV(LGM_CLK_PTP, "dd_ptp", "ljpll3", 0,
+		 PLL_DIV(CGU_LJPLL3_CFG0), 18, PLL_DDIV_WIDTH,
+		 21, PLL_DDIV_WIDTH, 27, 1, 28, 0),
+	LGM_DDIV(LGM_CLK_PCIE, "dd_pcie", "ljpll4", 0,
+		 PLL_DIV(CGU_LJPLL4_CFG0), 0, PLL_DDIV_WIDTH,
+		 3, PLL_DDIV_WIDTH, 24, 1, 29, 0),
+};
+
+static inline struct lgm_clk_provider *
+lgm_clk_init(struct device *dev, unsigned int nr_clks)
+{
+	struct lgm_clk_provider *ctx;
+
+	ctx = devm_kzalloc(dev, struct_size(ctx, clk_data.hws, nr_clks),
+			   GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->clk_data.num = nr_clks;
+
+	return ctx;
+}
+
+static int lgm_cgu_probe(struct platform_device *pdev)
+{
+	struct lgm_clk_provider *ctx;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	ctx = lgm_clk_init(dev, CLK_NR_CLKS);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ctx->membase = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ctx->membase))
+		return PTR_ERR(ctx->membase);
+
+	ctx->np = np;
+	ctx->dev = dev;
+	spin_lock_init(&ctx->lock);
+
+	ret = lgm_clk_register_plls(ctx, lgm_pll_clks,
+				    ARRAY_SIZE(lgm_pll_clks));
+	if (ret)
+		return ret;
+
+	ret = lgm_clk_register_branches(ctx, lgm_branch_clks,
+					ARRAY_SIZE(lgm_branch_clks));
+	if (ret)
+		return ret;
+
+	ret = lgm_clk_register_ddiv(ctx, lgm_ddiv_clks,
+				    ARRAY_SIZE(lgm_ddiv_clks));
+	if (ret)
+		return ret;
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					  &ctx->clk_data);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id of_lgm_cgu_match[] = {
+	{ .compatible = "intel,cgu-lgm" },
+	{}
+};
+
+static struct platform_driver lgm_cgu_driver = {
+	.probe = lgm_cgu_probe,
+	.driver = {
+		   .name = "cgu-lgm",
+		   .of_match_table = of_lgm_cgu_match,
+	},
+};
+
+builtin_platform_driver(lgm_cgu_driver);
-- 
2.11.0

