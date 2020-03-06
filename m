Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11767C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC3B2084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCFNBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:01:07 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:36060 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgCFNBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:01:05 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id A8E4B803087C;
        Fri,  6 Mar 2020 13:00:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MFpeuyWWjueb; Fri,  6 Mar 2020 16:00:58 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH 5/5] clk: Add Baikal-T1 CCU dividers driver
Date:   Fri, 6 Mar 2020 16:00:48 +0300
In-Reply-To: <20200306130048.8868-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306130048.8868-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306130059.A8E4B803087C@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Nearly each Baikal-T1 IP-core is supposed to have a clock source
of particular frequency. But since there are greater than five
IP-blocks embedded into the SoC, the CCU PLLs can't fulfill all the
devices needs. Baikal-T1 CCU provides a set of fixed and configurable
clocks dividers in order to generate a necessary signal for each chip
sub-block.

This driver creates the of-based hardware clocks for each divider
available in Baikal-T1 CCU. The same way as for PLLs we split the
functionality up into the clocks operations (gate, ungate, set rate,
etc) and hardware clocks declaration/registration procedures. So if
CLK_BT1_CCU is defined, then the first part is available in the
kernel, while CLK_BT1_CCU_DIV config makes the actual clocks being
registered at the time of_clk_init() is called.

All CCU dividers are distributed into two CCU sub-block: AXI-bus and
system devices reference clocks. So the first sub-block is used to
supply the clocks for AXI-bus interfaces (AXI clock domains) and the
second one provides the SoC IP-cores reference clocks. Each sub-block
is represented by a dedicated dts node, so they have different
compatible strings to distinguish one from another.

For some reason CCU provides the dividers of different types. Some
dividers can be gateable some can't, some are fixed while the others
are variable, some have special divider' limitations, some's got a
non-standard register layout and so on. In order to cover all of these
cases the hardware clocks driver is designed with an info-descriptor
pattern. So there are special static descriptors declared for the
dividers of each type with additional flags describing the block
peculiarity. These descriptors are then used to create hardware clocks
with proper operations.

Some CCU dividers also provides a way to reset a domain they generate
a clock for. So the CCU AXI dividers and CCU system devices clock
drivers also perform the reset controller registration.

Finally in addition to the clocks and reset functionality CCU exposes
several unrelated blocks like irqless Designware i2c controller with
indirectly accessed registers, AXI bus errors detector, DW PCIe
controller PM/clocks/reset manager, CPU/L2 settings block. They are
considered to be a part of CCU system devices clock sub-block and
some of them available as syscons when CLK_BT1_CCU_MFD config is
enabled.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 drivers/clk/baikal-t1/Kconfig       |  11 +
 drivers/clk/baikal-t1/Makefile      |   1 +
 drivers/clk/baikal-t1/ccu-div.c     | 531 ++++++++++++++++++++++++++++
 drivers/clk/baikal-t1/ccu-div.h     | 114 ++++++
 drivers/clk/baikal-t1/clk-ccu-div.c | 522 +++++++++++++++++++++++++++
 drivers/clk/baikal-t1/common.h      |   7 +
 6 files changed, 1186 insertions(+)
 create mode 100644 drivers/clk/baikal-t1/ccu-div.c
 create mode 100644 drivers/clk/baikal-t1/ccu-div.h
 create mode 100644 drivers/clk/baikal-t1/clk-ccu-div.c

diff --git a/drivers/clk/baikal-t1/Kconfig b/drivers/clk/baikal-t1/Kconfig
index 0e2fc86f3ab8..e77aef17f734 100644
--- a/drivers/clk/baikal-t1/Kconfig
+++ b/drivers/clk/baikal-t1/Kconfig
@@ -32,4 +32,15 @@ config CLK_BT1_CCU_PLL
 	  over the clock dividers to be only then used as an individual
 	  reference clocks of a target device.
 
+config CLK_BT1_CCU_DIV
+	bool "Baikal-T1 CCU Dividers support"
+	select RESET_CONTROLLER
+	default y
+	help
+	  Enable this to support the CCU dividers used to distribute clocks
+	  between AXI-bus and system devices coming from CCU PLLs of Baikal-T1
+	  SoCs. CCU dividers can be either configurable or with fixed divider,
+	  either gateable or ungateable. Some of the CCU dividers can be as well
+	  used to reset the domains they're supplying clocks too.
+
 endif
diff --git a/drivers/clk/baikal-t1/Makefile b/drivers/clk/baikal-t1/Makefile
index 559f034af19e..0daf1bfcb72f 100644
--- a/drivers/clk/baikal-t1/Makefile
+++ b/drivers/clk/baikal-t1/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CLK_BT1_CCU_PLL) += ccu-pll.o clk-ccu-pll.o
+obj-$(CONFIG_CLK_BT1_CCU_DIV) += ccu-div.o clk-ccu-div.o
diff --git a/drivers/clk/baikal-t1/ccu-div.c b/drivers/clk/baikal-t1/ccu-div.c
new file mode 100644
index 000000000000..5c49309d1fe5
--- /dev/null
+++ b/drivers/clk/baikal-t1/ccu-div.c
@@ -0,0 +1,531 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 BAIKAL ELECTRONICS, JSC
+ *
+ * Authors:
+ *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
+ *   Dmitry Dunaev <dmitry.dunaev@baikalelectronics.ru>
+ *
+ * Baikal-T1 CCU Divider interface driver.
+ */
+
+#define pr_fmt(fmt) "bt1-ccu-div: " fmt
+
+#include <linux/kernel.h>
+#include <linux/printk.h>
+#include <linux/bits.h>
+#include <linux/slab.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <linux/time64.h>
+#include <linux/debugfs.h>
+
+#include "ccu-div.h"
+#include "common.h"
+
+#define CCU_DIV_CTL			0x00
+#define CCU_DIV_CTL_EN			BIT(0)
+#define CCU_DIV_CTL_RST			BIT(1)
+#define CCU_DIV_CTL_SET_CLKDIV		BIT(2)
+#define CCU_DIV_CTL_CLKDIV_FLD		4
+#define CCU_DIV_CTL_CLKDIV_MASK(_width) \
+	GENMASK((_width) + CCU_DIV_CTL_CLKDIV_FLD - 1, CCU_DIV_CTL_CLKDIV_FLD)
+#define CCU_DIV_CTL_LOCK_SHIFTED	BIT(27)
+#define CCU_DIV_CTL_LOCK_NORMAL		BIT(31)
+
+#define CCU_DIV_RST_DELAY_US		1
+#define CCU_DIV_LOCK_DELAY_NS(_parent_rate, _div) ({		\
+	uint64_t _n = 4ULL * ((_div) ?: 1) * NSEC_PER_SEC;	\
+	do_div(_n, _parent_rate);				\
+	_n;							\
+})
+#define CCU_DIV_LOCK_CHECK_RETRIES	50
+
+#define CCU_DIV_CLKDIV_MIN		0
+#define CCU_DIV_CLKDIV_MAX(_mask) \
+	((_mask) >> CCU_DIV_CTL_CLKDIV_FLD)
+
+#define CCU_DIV_CALC_FREQ(_parent_rate, _div) \
+	((_parent_rate) / ((_div) ?: 1))
+
+static int ccu_div_var_update_clkdiv(struct ccu_div *div,
+				     unsigned long parent_rate,
+				     unsigned long divider)
+{
+	unsigned long nd;
+	u32 val, lock;
+	int count;
+
+	nd = CCU_DIV_LOCK_DELAY_NS(parent_rate, divider);
+
+	if (div->flags & CCU_DIV_LOCK_SHIFTED)
+		lock = CCU_DIV_CTL_LOCK_SHIFTED;
+	else
+		lock = CCU_DIV_CTL_LOCK_NORMAL;
+
+	ccu_update(div->reg, CCU_DIV_CTL_SET_CLKDIV, CCU_DIV_CTL_SET_CLKDIV);
+
+	count = CCU_DIV_LOCK_CHECK_RETRIES;
+	do {
+		ndelay(nd);
+		val = ccu_read(div->reg);
+	} while (!(val & lock) && --count);
+
+	return (val & lock) ? 0 : -ETIMEDOUT;
+}
+
+static int ccu_div_var_enable(struct clk_hw *hw)
+{
+	struct clk_hw *parent_hw = clk_hw_get_parent(hw);
+	struct ccu_div *div = to_ccu_div(hw);
+	unsigned long flags;
+	int ret;
+	u32 val;
+
+	if (!parent_hw) {
+		pr_err("Can't enable '%s' with no parent", clk_hw_get_name(hw));
+		return -EINVAL;
+	}
+
+	val = ccu_read(div->reg);
+	if (val & CCU_DIV_CTL_EN)
+		return 0;
+
+	spin_lock_irqsave(&div->reg_lock, flags);
+	ret = ccu_div_var_update_clkdiv(div, clk_hw_get_rate(parent_hw),
+		CCU_GET_VAR_FLD(CCU_DIV_CTL_CLKDIV, div->mask, val));
+	if (!ret)
+		ccu_write(div->reg, val | CCU_DIV_CTL_EN);
+	spin_unlock_irqrestore(&div->reg_lock, flags);
+	if (ret)
+		pr_err("Divider '%s' lock timed out\n", clk_hw_get_name(hw));
+
+	return ret;
+}
+
+static int ccu_div_gate_enable(struct clk_hw *hw)
+{
+	struct ccu_div *div = to_ccu_div(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(&div->reg_lock, flags);
+	ccu_update(div->reg, CCU_DIV_CTL_EN, CCU_DIV_CTL_EN);
+	spin_unlock_irqrestore(&div->reg_lock, flags);
+
+	return 0;
+}
+
+static void ccu_div_gate_disable(struct clk_hw *hw)
+{
+	struct ccu_div *div = to_ccu_div(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(&div->reg_lock, flags);
+	ccu_update(div->reg, CCU_DIV_CTL_EN, 0);
+	spin_unlock_irqrestore(&div->reg_lock, flags);
+}
+
+static int ccu_div_gate_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_div *div = to_ccu_div(hw);
+
+	return !!(ccu_read(div->reg) & CCU_DIV_CTL_EN);
+}
+
+static unsigned long ccu_div_var_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
+{
+	struct ccu_div *div = to_ccu_div(hw);
+	unsigned long divider;
+	u32 val;
+
+	val = ccu_read(div->reg);
+	divider = CCU_GET_VAR_FLD(CCU_DIV_CTL_CLKDIV, div->mask, val);
+
+	return CCU_DIV_CALC_FREQ(parent_rate, divider);
+}
+
+static inline unsigned long ccu_div_var_calc_divider(unsigned long rate,
+						     unsigned long parent_rate,
+						     unsigned int mask)
+{
+	unsigned long divider;
+
+	divider = parent_rate / rate;
+	return clamp_t(unsigned long, divider, CCU_DIV_CLKDIV_MIN,
+		       CCU_DIV_CLKDIV_MAX(mask));
+}
+
+static long ccu_div_var_round_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long *parent_rate)
+{
+	struct ccu_div *div = to_ccu_div(hw);
+	unsigned long divider;
+
+	divider = ccu_div_var_calc_divider(rate, *parent_rate, div->mask);
+
+	return CCU_DIV_CALC_FREQ(*parent_rate, divider);
+}
+
+/*
+ * This method is used for the clock divider blocks, which support the
+ * on-the-fly rate change. So due to lacking the EN bit functionality
+ * they can't be gated before the rate adjustment.
+ */
+static int ccu_div_var_set_rate_slow(struct clk_hw *hw, unsigned long rate,
+				     unsigned long parent_rate)
+{
+	struct ccu_div *div = to_ccu_div(hw);
+	unsigned long flags, divider;
+	u32 val;
+	int ret;
+
+	divider = ccu_div_var_calc_divider(rate, parent_rate, div->mask);
+	if (divider == 1 && div->flags & CCU_DIV_SKIP_ONE) {
+		divider = 0;
+	} else if (div->flags & CCU_DIV_SKIP_ONE_TO_THREE) {
+		if (divider == 1 || divider == 2)
+			divider = 0;
+		else if (divider == 3)
+			divider = 4;
+	}
+
+	val = CCU_SET_VAR_FLD(CCU_DIV_CTL_CLKDIV, div->mask, 0, divider);
+
+	spin_lock_irqsave(&div->reg_lock, flags);
+	ccu_update(div->reg, div->mask, val);
+	ret = ccu_div_var_update_clkdiv(div, parent_rate, divider);
+	spin_unlock_irqrestore(&div->reg_lock, flags);
+	if (ret)
+		pr_err("Divider '%s' lock timed out\n", clk_hw_get_name(hw));
+
+	return ret;
+}
+
+/*
+ * This method is used for the clock divider blocks, which don't support
+ * the on-the-fly rate change.
+ */
+static int ccu_div_var_set_rate_fast(struct clk_hw *hw, unsigned long rate,
+				     unsigned long parent_rate)
+{
+	struct ccu_div *div = to_ccu_div(hw);
+	unsigned long flags, divider = 1;
+	u32 val;
+
+	divider = ccu_div_var_calc_divider(rate, parent_rate, div->mask);
+	val = CCU_SET_VAR_FLD(CCU_DIV_CTL_CLKDIV, div->mask, 0, divider);
+
+	/*
+	 * Also disable the clock divider block if it was enabled by default
+	 * or by the bootloader.
+	 */
+	spin_lock_irqsave(&div->reg_lock, flags);
+	ccu_update(div->reg, div->mask | CCU_DIV_CTL_EN, val);
+	spin_unlock_irqrestore(&div->reg_lock, flags);
+
+	return 0;
+}
+
+static unsigned long ccu_div_fixed_recalc_rate(struct clk_hw *hw,
+					       unsigned long parent_rate)
+{
+	struct ccu_div *div = to_ccu_div(hw);
+
+	return CCU_DIV_CALC_FREQ(parent_rate, div->divider);
+}
+
+static long ccu_div_fixed_round_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long *parent_rate)
+{
+	struct ccu_div *div = to_ccu_div(hw);
+
+	return CCU_DIV_CALC_FREQ(*parent_rate, div->divider);
+}
+
+static int ccu_div_fixed_set_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long parent_rate)
+{
+	return 0;
+}
+
+int ccu_div_reset_domain(struct ccu_div *div)
+{
+	unsigned long flags;
+
+	if (!div || !(div->flags & CCU_DIV_RESET_DOMAIN))
+		return -EINVAL;
+
+	spin_lock_irqsave(&div->reg_lock, flags);
+	ccu_update(div->reg, CCU_DIV_CTL_RST, CCU_DIV_CTL_RST);
+	spin_unlock_irqrestore(&div->reg_lock, flags);
+
+	/* The next delay must be enough to cover all the resets. */
+	udelay(CCU_DIV_RST_DELAY_US);
+
+	return 0;
+}
+
+#ifdef CONFIG_DEBUG_FS
+
+#define CCU_DIV_DBGFS_BIT_ATTR(_name, _mask)			\
+static int ccu_div_dbgfs_##_name##_get(void *priv, u64 *val)	\
+{								\
+	struct ccu_div *div = priv;				\
+								\
+	*val = !!(ccu_read(div->reg) & _mask);			\
+								\
+	return 0;						\
+}								\
+static int ccu_div_dbgfs_##_name##_set(void *priv, u64 val)	\
+{								\
+	struct ccu_div *div = priv;				\
+	unsigned long flags;					\
+								\
+	spin_lock_irqsave(&div->reg_lock, flags);		\
+	ccu_update(div->reg, (_mask), val ? (_mask) : 0);	\
+	spin_unlock_irqrestore(&div->reg_lock, flags);		\
+								\
+	return 0;						\
+}								\
+DEFINE_DEBUGFS_ATTRIBUTE(ccu_div_dbgfs_##_name##_fops,		\
+	ccu_div_dbgfs_##_name##_get, ccu_div_dbgfs_##_name##_set, "%llu\n")
+
+CCU_DIV_DBGFS_BIT_ATTR(en, CCU_DIV_CTL_EN);
+CCU_DIV_DBGFS_BIT_ATTR(rst, CCU_DIV_CTL_RST);
+CCU_DIV_DBGFS_BIT_ATTR(set_clkdiv, CCU_DIV_CTL_SET_CLKDIV);
+CCU_DIV_DBGFS_BIT_ATTR(lock_shifted, CCU_DIV_CTL_LOCK_SHIFTED);
+CCU_DIV_DBGFS_BIT_ATTR(lock_normal, CCU_DIV_CTL_LOCK_NORMAL);
+
+static int ccu_div_dbgfs_var_clkdiv_get(void *priv, u64 *val)
+{
+	struct ccu_div *div = priv;
+	u32 data;
+
+	data = ccu_read(div->reg);
+	*val = CCU_GET_VAR_FLD(CCU_DIV_CTL_CLKDIV, div->mask, data);
+
+	return 0;
+}
+static int ccu_div_dbgfs_var_clkdiv_set(void *priv, u64 val)
+{
+	struct ccu_div *div = priv;
+	unsigned long flags;
+	u32 data;
+
+	val = clamp_t(u64, val, CCU_DIV_CLKDIV_MIN,
+		      CCU_DIV_CLKDIV_MAX(div->mask));
+	data = CCU_SET_VAR_FLD(CCU_DIV_CTL_CLKDIV, div->mask, 0, val);
+
+	spin_lock_irqsave(&div->reg_lock, flags);
+	ccu_update(div->reg, div->mask, data);
+	spin_unlock_irqrestore(&div->reg_lock, flags);
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(ccu_div_dbgfs_var_clkdiv_fops,
+	ccu_div_dbgfs_var_clkdiv_get, ccu_div_dbgfs_var_clkdiv_set, "%llu\n");
+
+static int ccu_div_dbgfs_fixed_clkdiv_get(void *priv, u64 *val)
+{
+	struct ccu_div *div = priv;
+
+	*val = div->divider;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(ccu_div_dbgfs_fixed_clkdiv_fops,
+	ccu_div_dbgfs_fixed_clkdiv_get, NULL, "%llu\n");
+
+static const struct debugfs_reg32 ccu_div_dbgfs_regs[] = {
+	CCU_DBGFS_REG("ctl", CCU_DIV_CTL)
+};
+
+static void ccu_div_var_debug_init(struct clk_hw *hw, struct dentry *dentry)
+{
+	struct ccu_div *div = to_ccu_div(hw);
+	struct debugfs_regset32 *regset;
+
+	regset = kzalloc(sizeof(*regset), GFP_KERNEL);
+	if (!regset)
+		return;
+
+	regset->regs = ccu_div_dbgfs_regs;
+	regset->nregs = ARRAY_SIZE(ccu_div_dbgfs_regs);
+	regset->base = div->reg;
+	debugfs_create_regset32("register", 0400, dentry, regset);
+
+	if (!(div->flags & CCU_DIV_NO_GATE)) {
+		debugfs_create_file_unsafe("en", 0600, dentry, div,
+					   &ccu_div_dbgfs_en_fops);
+	}
+
+	if (div->flags & CCU_DIV_RESET_DOMAIN) {
+		debugfs_create_file_unsafe("rst", 0200, dentry, div,
+					   &ccu_div_dbgfs_rst_fops);
+	}
+
+	debugfs_create_file_unsafe("set_clkdiv", 0200, dentry, div,
+				   &ccu_div_dbgfs_set_clkdiv_fops);
+	debugfs_create_file_unsafe("clkdiv", 0600, dentry, div,
+				   &ccu_div_dbgfs_var_clkdiv_fops);
+
+	if (div->flags & CCU_DIV_LOCK_SHIFTED) {
+		debugfs_create_file_unsafe("lock", 0400, dentry, div,
+					   &ccu_div_dbgfs_lock_shifted_fops);
+	} else {
+		debugfs_create_file_unsafe("lock", 0400, dentry, div,
+					   &ccu_div_dbgfs_lock_normal_fops);
+	}
+}
+
+static void ccu_div_gate_debug_init(struct clk_hw *hw, struct dentry *dentry)
+{
+	struct ccu_div *div = to_ccu_div(hw);
+	struct debugfs_regset32 *regset;
+
+	regset = kzalloc(sizeof(*regset), GFP_KERNEL);
+	if (!regset)
+		return;
+
+	regset->regs = ccu_div_dbgfs_regs;
+	regset->nregs = ARRAY_SIZE(ccu_div_dbgfs_regs);
+	regset->base = div->reg;
+	debugfs_create_regset32("register", 0400, dentry, regset);
+
+	debugfs_create_file_unsafe("en", 0600, dentry, div,
+				   &ccu_div_dbgfs_en_fops);
+
+	debugfs_create_file_unsafe("clkdiv", 0400, dentry, div,
+				   &ccu_div_dbgfs_fixed_clkdiv_fops);
+}
+
+static void ccu_div_fixed_debug_init(struct clk_hw *hw, struct dentry *dentry)
+{
+	struct ccu_div *div = to_ccu_div(hw);
+
+	debugfs_create_file_unsafe("clkdiv", 0400, dentry, div,
+				   &ccu_div_dbgfs_fixed_clkdiv_fops);
+}
+
+#else /* !CONFIG_DEBUG_FS */
+
+#define ccu_div_var_debug_init NULL
+#define ccu_div_gate_debug_init NULL
+#define ccu_div_fixed_debug_init NULL
+
+#endif /* !CONFIG_DEBUG_FS */
+
+static const struct clk_ops ccu_div_var_gate_to_set_ops = {
+	.enable = ccu_div_var_enable,
+	.disable = ccu_div_gate_disable,
+	.is_enabled = ccu_div_gate_is_enabled,
+	.recalc_rate = ccu_div_var_recalc_rate,
+	.round_rate = ccu_div_var_round_rate,
+	.set_rate = ccu_div_var_set_rate_fast,
+	.debug_init = ccu_div_var_debug_init
+};
+
+static const struct clk_ops ccu_div_var_nogate_ops = {
+	.recalc_rate = ccu_div_var_recalc_rate,
+	.round_rate = ccu_div_var_round_rate,
+	.set_rate = ccu_div_var_set_rate_slow,
+	.debug_init = ccu_div_var_debug_init
+};
+
+static const struct clk_ops ccu_div_gate_ops = {
+	.enable = ccu_div_gate_enable,
+	.disable = ccu_div_gate_disable,
+	.is_enabled = ccu_div_gate_is_enabled,
+	.recalc_rate = ccu_div_fixed_recalc_rate,
+	.round_rate = ccu_div_fixed_round_rate,
+	.set_rate = ccu_div_fixed_set_rate,
+	.debug_init = ccu_div_gate_debug_init
+};
+
+static const struct clk_ops ccu_div_fixed_ops = {
+	.recalc_rate = ccu_div_fixed_recalc_rate,
+	.round_rate = ccu_div_fixed_round_rate,
+	.set_rate = ccu_div_fixed_set_rate,
+	.debug_init = ccu_div_fixed_debug_init
+};
+
+struct ccu_div *ccu_div_hw_register(struct ccu_div_init_data *div_init)
+{
+	struct clk_parent_data parent_data = {0};
+	struct clk_init_data hw_init = {0};
+	struct ccu_div *div;
+	int ret;
+
+	if (!div_init)
+		return ERR_PTR(-EINVAL);
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	div->hw.init = &hw_init;
+	div->id = div_init->id;
+	div->reg = div_init->reg;
+	div->flags = div_init->flags;
+	spin_lock_init(&div->reg_lock);
+
+	hw_init.name = div_init->name;
+	hw_init.flags = CLK_IGNORE_UNUSED;
+
+	if (div_init->type == CCU_DIV_VAR) {
+		if (div_init->flags & CCU_DIV_NO_GATE) {
+			hw_init.ops = &ccu_div_var_nogate_ops;
+		} else {
+			hw_init.flags |= CLK_SET_RATE_GATE;
+			hw_init.ops = &ccu_div_var_gate_to_set_ops;
+		}
+		div->mask = CCU_DIV_CTL_CLKDIV_MASK(div_init->width);
+	} else if (div_init->type == CCU_DIV_GATE) {
+		hw_init.ops = &ccu_div_gate_ops;
+		div->divider = div_init->divider;
+	} else if (div_init->type == CCU_DIV_FIXED) {
+		hw_init.ops = &ccu_div_fixed_ops;
+		div->divider = div_init->divider;
+	} else {
+		ret = -EINVAL;
+		goto err_free_div;
+	}
+
+	if (div_init->flags & CCU_DIV_CRITICAL)
+		hw_init.flags |= CLK_IS_CRITICAL;
+
+	if (div_init->parent_name) {
+		parent_data.fw_name = div_init->parent_name;
+	} else if (div_init->parent_hw) {
+		parent_data.hw = div_init->parent_hw;
+	} else {
+		ret = -EINVAL;
+		goto err_free_div;
+	}
+	hw_init.parent_data = &parent_data;
+	hw_init.num_parents = 1;
+
+	ret = of_clk_hw_register(div_init->np, &div->hw);
+	if (ret)
+		goto err_free_div;
+
+	return div;
+
+err_free_div:
+	kfree(div);
+
+	return ERR_PTR(ret);
+}
+
+void ccu_div_hw_unregister(struct ccu_div *div)
+{
+	if (!div)
+		return;
+
+	clk_hw_unregister(&div->hw);
+
+	kfree(div);
+}
diff --git a/drivers/clk/baikal-t1/ccu-div.h b/drivers/clk/baikal-t1/ccu-div.h
new file mode 100644
index 000000000000..b166a1061078
--- /dev/null
+++ b/drivers/clk/baikal-t1/ccu-div.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 BAIKAL ELECTRONICS, JSC
+ *
+ * Baikal-T1 CCU Divider interface driver.
+ */
+#ifndef __CLK_BT1_CCU_DIV_H__
+#define __CLK_BT1_CCU_DIV_H__
+
+#include <linux/clk-provider.h>
+#include <linux/spinlock.h>
+#include <linux/bits.h>
+#include <linux/of.h>
+
+/*
+ * CCU Divider private flags.
+ * @CCU_DIV_NO_GATE: Some of CCU variable dividers can't be disabled due to
+ *		     lack of corresponding functionality.
+ * @CCU_DIV_CRITICAL: Even though there is a way to switch most of the dividers
+ *		      gate PLL off, there might be some, which shouldn't be.
+ * @CCU_DIV_SKIP_ONE: Due to some reason divider can't be set to 1.
+ *		      It can be 0 though, which is functionally the same.
+ * @CCU_DIV_SKIP_ONE_TO_THREE: For some reason divider can't be within [1,3].
+ *			       It can be either 0 or greater than 3.
+ * @CCU_DIV_LOCK_SHIFTED: Find lock-bit at non-standard position.
+ * @CCU_DIV_RESET_DOMAIN: Provide reset clock domain method.
+ */
+#define CCU_DIV_NO_GATE			BIT(0)
+#define CCU_DIV_CRITICAL		BIT(1)
+#define CCU_DIV_SKIP_ONE		BIT(2)
+#define CCU_DIV_SKIP_ONE_TO_THREE	BIT(3)
+#define CCU_DIV_LOCK_SHIFTED		BIT(4)
+#define CCU_DIV_RESET_DOMAIN		BIT(5)
+
+/*
+ * enum ccu_div_type - CCU Divider types.
+ * @CCU_DIV_VAR: Clocks gate with variable divider.
+ * @CCU_DIV_GATE: Clocks gate with fixed divider.
+ * @CCU_DIV_FIXED: Ungateable clock with fixed divider.
+ */
+enum ccu_div_type {
+	CCU_DIV_VAR,
+	CCU_DIV_GATE,
+	CCU_DIV_FIXED
+};
+
+/*
+ * struct ccu_div_init_data - CCU Divider initialization data.
+ * @id: Clocks private identifier.
+ * @reg: Divider registers base address.
+ * @name: Clocks name.
+ * @parent_name: Parent clocks name in a fw node.
+ * @parent_hw: Pointer to the parent clk_hw descriptor.
+ * @np: Pointer to the node describing the CCU Dividers.
+ * @type: CCU divider type (variable, fixed with and without gate).
+ * @width: Divider width if it's variable.
+ * @divider: Divider fixed value.
+ * @flags: CCU Divider private flags.
+ */
+struct ccu_div_init_data {
+	unsigned int id;
+	void __iomem *reg;
+	const char *name;
+	const char *parent_name;
+	const struct clk_hw *parent_hw;
+	struct device_node *np;
+	enum ccu_div_type type;
+	union {
+		unsigned int width;
+		unsigned int divider;
+	};
+	unsigned long flags;
+};
+
+/*
+ * struct ccu_div - CCU Divider descriptor.
+ * @hw: clk_hw of the divider.
+ * @id: Clock private identifier.
+ * @reg: Divider control register base address.
+ * @reg_lock: The control register access spin-lock.
+ * @mask: Divider field mask.
+ * @divider: Divider fixed value.
+ * @flags: Divider private flags.
+ */
+struct ccu_div {
+	struct clk_hw hw;
+	unsigned int id;
+	void __iomem *reg;
+	spinlock_t reg_lock;
+	union {
+		u32 mask;
+		unsigned int divider;
+	};
+	unsigned long flags;
+};
+#define to_ccu_div(_hw) container_of(_hw, struct ccu_div, hw)
+
+static inline struct clk_hw *ccu_div_get_clk_hw(struct ccu_div *div)
+{
+	return div ? &div->hw : NULL;
+}
+
+static inline unsigned int ccu_div_get_clk_id(struct ccu_div *div)
+{
+	return div ? div->id : -1;
+}
+
+extern struct ccu_div *ccu_div_hw_register(struct ccu_div_init_data *init);
+
+extern void ccu_div_hw_unregister(struct ccu_div *div);
+
+extern int ccu_div_reset_domain(struct ccu_div *div);
+
+#endif /* __CLK_BT1_CCU_DIV_H__ */
diff --git a/drivers/clk/baikal-t1/clk-ccu-div.c b/drivers/clk/baikal-t1/clk-ccu-div.c
new file mode 100644
index 000000000000..71165ffb7140
--- /dev/null
+++ b/drivers/clk/baikal-t1/clk-ccu-div.c
@@ -0,0 +1,522 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 BAIKAL ELECTRONICS, JSC
+ *
+ * Authors:
+ *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
+ *   Dmitry Dunaev <dmitry.dunaev@baikalelectronics.ru>
+ *
+ * Baikal-T1 CCU Divider clocks driver.
+ */
+
+#define pr_fmt(fmt) "bt1-ccu-div: " fmt
+
+#include <linux/kernel.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/clk-provider.h>
+#include <linux/reset-controller.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/ioport.h>
+
+#include <dt-bindings/clock/bt1-ccu.h>
+#include <dt-bindings/reset/bt1-ccu.h>
+
+#include "ccu-div.h"
+
+#define CCU_AXI_MAIN_BASE		0x000
+#define CCU_AXI_DDR_BASE		0x004
+#define CCU_AXI_SATA_BASE		0x008
+#define CCU_AXI_GMAC0_BASE		0x00C
+#define CCU_AXI_GMAC1_BASE		0x010
+#define CCU_AXI_XGMAC_BASE		0x014
+#define CCU_AXI_PCIE_M_BASE		0x018
+#define CCU_AXI_PCIE_S_BASE		0x01C
+#define CCU_AXI_USB_BASE		0x020
+#define CCU_AXI_HWA_BASE		0x024
+#define CCU_AXI_SRAM_BASE		0x028
+
+#define CCU_SYS_SATA_REF_BASE		0x000
+#define CCU_SYS_APB_BASE		0x004
+#define CCU_SYS_GMAC0_BASE		0x008
+#define CCU_SYS_GMAC1_BASE		0x00C
+#define CCU_SYS_XGMAC_BASE		0x010
+#define CCU_SYS_USB_BASE		0x014
+#define CCU_SYS_PVT_BASE		0x018
+#define CCU_SYS_HWA_BASE		0x01C
+#define CCU_SYS_UART_BASE		0x024
+#define CCU_SYS_TIMER0_BASE		0x028
+#define CCU_SYS_TIMER1_BASE		0x02C
+#define CCU_SYS_TIMER2_BASE		0x030
+#define CCU_SYS_WDT_BASE		0x0F0
+
+#define CCU_DIV_VAR_INFO(_id, _name, _pname, _base, _width, _flags)	\
+	{								\
+		.id = _id,						\
+		.name = _name,						\
+		.parent_name = _pname,					\
+		.parent_id = -1,					\
+		.base = _base,						\
+		.type = CCU_DIV_VAR,					\
+		.width = _width,					\
+		.flags = _flags						\
+	}
+
+#define CCU_DIV_GATE_INFO(_id, _name, _pname, _base, _divider)	\
+	{							\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _pname,				\
+		.parent_id = -1,				\
+		.base = _base,					\
+		.type = CCU_DIV_GATE,				\
+		.divider = _divider				\
+	}
+
+#define CCU_DIV_FIXED_INFO(_id, _name, _pname, _pid, _divider)	\
+	{							\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _pname,				\
+		.parent_id = _pid,				\
+		.type = CCU_DIV_FIXED,				\
+		.divider = _divider				\
+	}
+
+#define CCU_DIV_FIXED_EXT_INFO(_id, _name, _pname, _divider) \
+	CCU_DIV_FIXED_INFO(_id, _name, _pname, -1, _divider)
+
+#define CCU_DIV_FIXED_LOC_INFO(_id, _name, _pid, _divider) \
+	CCU_DIV_FIXED_INFO(_id, _name, NULL, _pid, _divider)
+
+#define CCU_DIV_RST_MAP(_rst_id, _clk_id)	\
+	{					\
+		.rst_id = _rst_id,		\
+		.clk_id = _clk_id		\
+	}
+
+#define CCU_AXI_DIV_NUM			ARRAY_SIZE(axi_info)
+#define CCU_AXI_RST_NUM			ARRAY_SIZE(axi_rst_map)
+
+#define CCU_SYS_DIV_NUM			ARRAY_SIZE(sys_info)
+#define CCU_SYS_RST_NUM			ARRAY_SIZE(sys_rst_map)
+
+struct ccu_div_info {
+	unsigned int id;
+	const char *name;
+	const char *parent_name;
+	unsigned int parent_id;
+	unsigned int base;
+	enum ccu_div_type type;
+	union {
+		unsigned int width;
+		unsigned int divider;
+	};
+	unsigned long flags;
+};
+
+struct ccu_div_rst_map {
+	unsigned int rst_id;
+	unsigned int clk_id;
+};
+
+struct ccu_div_data {
+	struct device_node *np;
+	void __iomem *regs;
+
+	unsigned int divs_num;
+	const struct ccu_div_info *divs_info;
+	struct ccu_div **divs;
+
+	unsigned int rst_num;
+	const struct ccu_div_rst_map *rst_map;
+	struct reset_controller_dev rcdev;
+};
+#define to_ccu_div_data(_rcdev) container_of(_rcdev, struct ccu_div_data, rcdev)
+
+static const struct ccu_div_info axi_info[] = {
+	CCU_DIV_VAR_INFO(CCU_AXI_MAIN_CLK, "axi_main_clk", "pcie_clk",
+			 CCU_AXI_MAIN_BASE, 4,
+			 CCU_DIV_CRITICAL | CCU_DIV_NO_GATE |
+			 CCU_DIV_RESET_DOMAIN),
+	CCU_DIV_VAR_INFO(CCU_AXI_DDR_CLK, "axi_ddr_clk", "sata_clk",
+			 CCU_AXI_DDR_BASE, 4,
+			 CCU_DIV_CRITICAL | CCU_DIV_RESET_DOMAIN),
+	CCU_DIV_VAR_INFO(CCU_AXI_SATA_CLK, "axi_sata_clk", "sata_clk",
+			 CCU_AXI_SATA_BASE, 4, CCU_DIV_RESET_DOMAIN),
+	CCU_DIV_VAR_INFO(CCU_AXI_GMAC0_CLK, "axi_gmac0_clk", "eth_clk",
+			 CCU_AXI_GMAC0_BASE, 4, CCU_DIV_RESET_DOMAIN),
+	CCU_DIV_VAR_INFO(CCU_AXI_GMAC1_CLK, "axi_gmac1_clk", "eth_clk",
+			 CCU_AXI_GMAC1_BASE, 4, CCU_DIV_RESET_DOMAIN),
+	CCU_DIV_VAR_INFO(CCU_AXI_XGMAC_CLK, "axi_xgmac_clk", "eth_clk",
+			 CCU_AXI_XGMAC_BASE, 4, CCU_DIV_RESET_DOMAIN),
+	CCU_DIV_VAR_INFO(CCU_AXI_PCIE_M_CLK, "axi_pcie_m_clk", "pcie_clk",
+			 CCU_AXI_PCIE_M_BASE, 4, CCU_DIV_RESET_DOMAIN),
+	CCU_DIV_VAR_INFO(CCU_AXI_PCIE_S_CLK, "axi_pcie_s_clk", "pcie_clk",
+			 CCU_AXI_PCIE_S_BASE, 4, CCU_DIV_RESET_DOMAIN),
+	CCU_DIV_VAR_INFO(CCU_AXI_USB_CLK, "axi_usb_clk", "sata_clk",
+			 CCU_AXI_USB_BASE, 4, CCU_DIV_RESET_DOMAIN),
+	CCU_DIV_VAR_INFO(CCU_AXI_HWA_CLK, "axi_hwa_clk", "sata_clk",
+			 CCU_AXI_HWA_BASE, 4, CCU_DIV_RESET_DOMAIN),
+	CCU_DIV_VAR_INFO(CCU_AXI_SRAM_CLK, "axi_sram_clk", "eth_clk",
+			 CCU_AXI_SRAM_BASE, 4, CCU_DIV_RESET_DOMAIN)
+};
+
+static const struct ccu_div_rst_map axi_rst_map[] = {
+	CCU_DIV_RST_MAP(CCU_AXI_MAIN_RST, CCU_AXI_MAIN_CLK),
+	CCU_DIV_RST_MAP(CCU_AXI_DDR_RST, CCU_AXI_DDR_CLK),
+	CCU_DIV_RST_MAP(CCU_AXI_SATA_RST, CCU_AXI_SATA_CLK),
+	CCU_DIV_RST_MAP(CCU_AXI_GMAC0_RST, CCU_AXI_GMAC0_CLK),
+	CCU_DIV_RST_MAP(CCU_AXI_GMAC1_RST, CCU_AXI_GMAC1_CLK),
+	CCU_DIV_RST_MAP(CCU_AXI_XGMAC_RST, CCU_AXI_XGMAC_CLK),
+	CCU_DIV_RST_MAP(CCU_AXI_PCIE_M_RST, CCU_AXI_PCIE_M_CLK),
+	CCU_DIV_RST_MAP(CCU_AXI_PCIE_S_RST, CCU_AXI_PCIE_S_CLK),
+	CCU_DIV_RST_MAP(CCU_AXI_USB_RST, CCU_AXI_USB_CLK),
+	CCU_DIV_RST_MAP(CCU_AXI_HWA_RST, CCU_AXI_HWA_CLK),
+	CCU_DIV_RST_MAP(CCU_AXI_SRAM_RST, CCU_AXI_SRAM_CLK)
+};
+
+static const struct ccu_div_info sys_info[] = {
+	CCU_DIV_VAR_INFO(CCU_SYS_SATA_REF_CLK, "sys_sata_ref_clk",
+			 "sata_clk", CCU_SYS_SATA_REF_BASE, 4,
+			 CCU_DIV_SKIP_ONE | CCU_DIV_LOCK_SHIFTED |
+			 CCU_DIV_RESET_DOMAIN),
+	CCU_DIV_VAR_INFO(CCU_SYS_APB_CLK, "sys_apb_clk",
+			 "pcie_clk", CCU_SYS_APB_BASE, 5,
+			 CCU_DIV_CRITICAL | CCU_DIV_NO_GATE |
+			 CCU_DIV_RESET_DOMAIN),
+	CCU_DIV_FIXED_LOC_INFO(CCU_SYS_GMAC0_CSR_CLK, "sys_gmac0_csr_clk",
+			       CCU_SYS_APB_CLK, 1),
+	CCU_DIV_GATE_INFO(CCU_SYS_GMAC0_TX_CLK, "sys_gmac0_tx_clk",
+			  "eth_clk", CCU_SYS_GMAC0_BASE, 5),
+	CCU_DIV_FIXED_EXT_INFO(CCU_SYS_GMAC0_PTP_CLK, "sys_gmac0_ptp_clk",
+			       "eth_clk", 10),
+	CCU_DIV_FIXED_LOC_INFO(CCU_SYS_GMAC1_CSR_CLK, "sys_gmac1_csr_clk",
+			       CCU_SYS_APB_CLK, 1),
+	CCU_DIV_GATE_INFO(CCU_SYS_GMAC1_TX_CLK, "sys_gmac1_tx_clk",
+			  "eth_clk", CCU_SYS_GMAC1_BASE, 5),
+	CCU_DIV_FIXED_EXT_INFO(CCU_SYS_GMAC1_PTP_CLK, "sys_gmac1_ptp_clk",
+			       "eth_clk", 10),
+	CCU_DIV_GATE_INFO(CCU_SYS_XGMAC_REF_CLK, "sys_xgmac_ref_clk",
+			  "eth_clk", CCU_SYS_XGMAC_BASE, 8),
+	CCU_DIV_FIXED_EXT_INFO(CCU_SYS_XGMAC_PTP_CLK, "sys_xgmac_ptp_clk",
+			       "eth_clk", 10),
+	CCU_DIV_GATE_INFO(CCU_SYS_USB_CLK, "sys_usb_clk",
+			  "eth_clk", CCU_SYS_USB_BASE, 10),
+	CCU_DIV_VAR_INFO(CCU_SYS_PVT_CLK, "sys_pvt_clk",
+			 "ref_clk", CCU_SYS_PVT_BASE, 5, 0),
+	CCU_DIV_VAR_INFO(CCU_SYS_HWA_CLK, "sys_hwa_clk",
+			 "sata_clk", CCU_SYS_HWA_BASE, 4, 0),
+	CCU_DIV_VAR_INFO(CCU_SYS_UART_CLK, "sys_uart_clk",
+			 "eth_clk", CCU_SYS_UART_BASE, 17, 0),
+	CCU_DIV_FIXED_LOC_INFO(CCU_SYS_SPI_CLK, "sys_spi_clk",
+			   CCU_SYS_APB_CLK, 1),
+	CCU_DIV_FIXED_EXT_INFO(CCU_SYS_I2C1_CLK, "sys_i2c1_clk",
+			       "eth_clk", 10),
+	CCU_DIV_FIXED_EXT_INFO(CCU_SYS_I2C2_CLK, "sys_i2c2_clk",
+			       "eth_clk", 10),
+	CCU_DIV_FIXED_EXT_INFO(CCU_SYS_GPIO_CLK, "sys_gpio_clk",
+			       "ref_clk", 25),
+	CCU_DIV_VAR_INFO(CCU_SYS_TIMER0_CLK, "sys_timer0_clk",
+			 "ref_clk", CCU_SYS_TIMER0_BASE, 17, 0),
+	CCU_DIV_VAR_INFO(CCU_SYS_TIMER1_CLK, "sys_timer1_clk",
+			 "ref_clk", CCU_SYS_TIMER1_BASE, 17, 0),
+	CCU_DIV_VAR_INFO(CCU_SYS_TIMER2_CLK, "sys_timer2_clk",
+			 "ref_clk", CCU_SYS_TIMER2_BASE, 17, 0),
+	CCU_DIV_VAR_INFO(CCU_SYS_WDT_CLK, "sys_wdt_clk",
+			 "eth_clk", CCU_SYS_WDT_BASE, 17,
+			 CCU_DIV_SKIP_ONE_TO_THREE)
+};
+
+static const struct ccu_div_rst_map sys_rst_map[] = {
+	CCU_DIV_RST_MAP(CCU_SYS_SATA_REF_RST, CCU_SYS_SATA_REF_CLK),
+	CCU_DIV_RST_MAP(CCU_SYS_APB_RST, CCU_SYS_APB_CLK),
+};
+
+static struct ccu_div *ccu_div_find_desc(struct ccu_div_data *data,
+					 unsigned int clk_id)
+{
+	struct ccu_div *div;
+	int idx;
+
+	for (idx = 0; idx < data->divs_num; ++idx) {
+		div = data->divs[idx];
+		if (clk_id == ccu_div_get_clk_id(div))
+			return div;
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int ccu_div_reset(struct reset_controller_dev *rcdev,
+			 unsigned long rst_id)
+{
+	struct ccu_div_data *data = to_ccu_div_data(rcdev);
+	const struct ccu_div_rst_map *map;
+	struct ccu_div *div;
+	int idx, ret;
+
+	for (idx = 0, map = data->rst_map; idx < data->rst_num; ++idx, ++map) {
+		if (map->rst_id == rst_id)
+			break;
+	}
+	if (idx == data->rst_num) {
+		pr_err("Invalid reset ID %lu specified\n", rst_id);
+		return -EINVAL;
+	}
+
+	div = ccu_div_find_desc(data, map->clk_id);
+	if (IS_ERR(div)) {
+		pr_err("Invalid clock ID %d in mapping\n", map->clk_id);
+		return PTR_ERR(div);
+	}
+
+	ret = ccu_div_reset_domain(div);
+	if (ret) {
+		pr_err("Reset isn't supported by divider %s\n",
+			clk_hw_get_name(ccu_div_get_clk_hw(div)));
+	}
+
+	return ret;
+}
+
+static const struct reset_control_ops ccu_div_rst_ops = {
+	.reset = ccu_div_reset,
+};
+
+static struct ccu_div_data *ccu_div_create_data(struct device_node *np,
+					unsigned int divs_num,
+					const struct ccu_div_info *divs_info,
+					unsigned int rst_num,
+					const struct ccu_div_rst_map *rst_map)
+{
+	struct ccu_div_data *data;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	data->divs = kcalloc(divs_num, sizeof(*data->divs), GFP_KERNEL);
+	if (!data->divs) {
+		kfree(data);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	data->np = np;
+	data->divs_num = divs_num;
+	data->divs_info = divs_info;
+	data->rst_num = rst_num;
+	data->rst_map = rst_map;
+
+	return data;
+}
+
+static void ccu_div_free_data(struct ccu_div_data *data)
+{
+	kfree(data->divs);
+
+	kfree(data);
+}
+
+static int ccu_div_request_regs(struct ccu_div_data *data)
+{
+	data->regs = of_io_request_and_map(data->np, 0,
+					   of_node_full_name(data->np));
+	if (IS_ERR(data->regs)) {
+		pr_err("Failed to request dividers '%s' registers\n",
+			of_node_full_name(data->np));
+		return PTR_ERR(data->regs);
+	}
+
+	return 0;
+}
+
+static void ccu_div_release_regs(struct ccu_div_data *data)
+{
+	struct resource res;
+
+	iounmap(data->regs);
+
+	/* Try to release the resource as well. */
+	if (of_address_to_resource(data->np, 0, &res))
+		return;
+
+	(void)release_mem_region(res.start, resource_size(&res));
+}
+
+static struct clk_hw *ccu_div_of_clk_hw_get(struct of_phandle_args *clkspec,
+					    void *priv)
+{
+	struct ccu_div_data *data = priv;
+	struct ccu_div *div;
+	unsigned int clk_id;
+
+	clk_id = clkspec->args[0];
+	div = ccu_div_find_desc(data, clk_id);
+	if (IS_ERR(div)) {
+		pr_info("Invalid clock ID %d specified\n", clk_id);
+		return ERR_CAST(div);
+	}
+
+	return ccu_div_get_clk_hw(div);
+}
+
+static int ccu_div_clk_register(struct ccu_div_data *data)
+{
+	int idx, ret;
+
+	for (idx = 0; idx < data->divs_num; ++idx) {
+		const struct ccu_div_info *info = &data->divs_info[idx];
+		struct ccu_div_init_data init = {0};
+
+		init.id = info->id;
+		init.np = data->np;
+		init.type = info->type;
+		init.flags = info->flags;
+
+		if (init.type == CCU_DIV_VAR) {
+			init.reg = data->regs + info->base;
+			init.width = info->width;
+		} else if (init.type == CCU_DIV_GATE) {
+			init.reg = data->regs + info->base;
+			init.divider = info->divider;
+		} else {
+			init.divider = info->divider;
+		}
+
+		if (info->parent_name) {
+			init.parent_name = info->parent_name;
+		} else {
+			struct ccu_div *div;
+
+			div = ccu_div_find_desc(data, info->parent_id);
+			if (IS_ERR_OR_NULL(div)) {
+				ret = -EINVAL;
+				pr_err("Invalid parent ID '%u'\n",
+					info->parent_id);
+				goto err_hw_unregister;
+			}
+
+			init.parent_hw = ccu_div_get_clk_hw(div);
+		}
+
+		ret = of_property_read_string_index(data->np,
+			"clock-output-names", init.id, &init.name);
+		if (ret)
+			init.name = info->name;
+
+		data->divs[idx] = ccu_div_hw_register(&init);
+		if (IS_ERR(data->divs[idx])) {
+			ret = PTR_ERR(data->divs[idx]);
+			pr_err("Couldn't register divider '%s' hw\n",
+				init.name);
+			goto err_hw_unregister;
+		}
+	}
+
+	ret = of_clk_add_hw_provider(data->np, ccu_div_of_clk_hw_get, data);
+	if (ret) {
+		pr_err("Couldn't register dividers '%s' clock provider\n",
+			of_node_full_name(data->np));
+		goto err_hw_unregister;
+	}
+
+	return 0;
+
+err_hw_unregister:
+	for (--idx; idx >= 0; --idx)
+		ccu_div_hw_unregister(data->divs[idx]);
+
+	return ret;
+}
+
+static void ccu_div_clk_unregister(struct ccu_div_data *data)
+{
+	int idx;
+
+	of_clk_del_provider(data->np);
+
+	for (idx = 0; idx < data->divs_num; ++idx)
+		ccu_div_hw_unregister(data->divs[idx]);
+}
+
+static int ccu_div_rst_register(struct ccu_div_data *data)
+{
+	int ret;
+
+	data->rcdev.ops = &ccu_div_rst_ops;
+	data->rcdev.of_node = data->np;
+	data->rcdev.nr_resets = data->rst_num;
+
+	ret = reset_controller_register(&data->rcdev);
+	if (ret) {
+		pr_err("Couldn't register divider '%s' reset controller\n",
+			of_node_full_name(data->np));
+	}
+
+	return ret;
+}
+
+static int ccu_div_init(struct device_node *np,
+			unsigned int divs_num,
+			const struct ccu_div_info *divs_info,
+			unsigned int rst_num,
+			const struct ccu_div_rst_map *rst_map)
+{
+	struct ccu_div_data *data;
+	int ret;
+
+	data = ccu_div_create_data(np, divs_num, divs_info, rst_num, rst_map);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	ret = ccu_div_request_regs(data);
+	if (ret)
+		goto err_free_data;
+
+	ret = ccu_div_clk_register(data);
+	if (ret)
+		goto err_release_regs;
+
+	ret = ccu_div_rst_register(data);
+	if (ret)
+		goto err_clk_unregister;
+
+	return 0;
+
+err_clk_unregister:
+	ccu_div_clk_unregister(data);
+
+err_release_regs:
+	ccu_div_release_regs(data);
+
+err_free_data:
+	ccu_div_free_data(data);
+
+	return ret;
+}
+
+
+static __init void ccu_axi_init(struct device_node *np)
+{
+	int ret;
+
+	ret = ccu_div_init(np, CCU_AXI_DIV_NUM, axi_info,
+			   CCU_AXI_RST_NUM, axi_rst_map);
+	if (!ret)
+		pr_info("CCU AXI-bus clocks/resets are initialized\n");
+}
+CLK_OF_DECLARE(ccu_axi, "be,bt1-ccu-axi", ccu_axi_init);
+
+static __init void ccu_sys_init(struct device_node *np)
+{
+	int ret;
+
+	ret = ccu_div_init(np, CCU_SYS_DIV_NUM, sys_info,
+			   CCU_SYS_RST_NUM, sys_rst_map);
+	if (!ret)
+		pr_info("CCU system devices clocks/resets are initialized\n");
+}
+CLK_OF_DECLARE_DRIVER(ccu_sys, "be,bt1-ccu-sys", ccu_sys_init);
diff --git a/drivers/clk/baikal-t1/common.h b/drivers/clk/baikal-t1/common.h
index 07c8d67f5275..34a3015c4633 100644
--- a/drivers/clk/baikal-t1/common.h
+++ b/drivers/clk/baikal-t1/common.h
@@ -13,10 +13,17 @@
 #define CCU_GET_FLD(_name, _data) \
 	(((u32)(_data) & _name ## _MASK) >> _name ## _FLD)
 
+#define CCU_GET_VAR_FLD(_name, _mask, _data) \
+	(((u32)(_data) & (u32)(_mask)) >> _name ## _FLD)
+
 #define CCU_SET_FLD(_name, _data, _val) \
 	(((u32)(_data) & ~_name ## _MASK) | \
 	(((u32)(_val) << _name ## _FLD) & _name ## _MASK))
 
+#define CCU_SET_VAR_FLD(_name, _mask, _data, _val) \
+	(((u32)(_data) & ~(u32)(_mask)) | \
+	(((u32)(_val) << _name ## _FLD) & (u32)(_mask)))
+
 #define CCU_DBGFS_REG(_name, _off)	\
 {					\
 	.name = _name,			\
-- 
2.25.1


