Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19214C54FD3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019152073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgCYPkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:40:08 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53400 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727702AbgCYPj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:39:29 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 30559200561;
        Wed, 25 Mar 2020 16:39:27 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2254120055D;
        Wed, 25 Mar 2020 16:39:27 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 6DA31203CE;
        Wed, 25 Mar 2020 16:39:26 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 05/13] clk: imx: gate2: Allow single bit gating clock
Date:   Wed, 25 Mar 2020 17:38:43 +0200
Message-Id: <1585150731-3354-6-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585150731-3354-1-git-send-email-abel.vesa@nxp.com>
References: <1585150731-3354-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audiomix on i.MX8MP registers two gates that share the same enable count
but use the same bit to control the gate instead of two bits. By adding
the flag IMX_CLK_GATE2_SINGLE_BIT we allow the gate2 to use the generic
gate ops for enable, disable and is_enabled.
For the disable_unused, nothing happens if this flag is specified.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-gate2.c | 31 +++++++++++++++++++++++--------
 drivers/clk/imx/clk.h       | 13 +++++++++++++
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
index ce0060e..b87ab3c 100644
--- a/drivers/clk/imx/clk-gate2.c
+++ b/drivers/clk/imx/clk-gate2.c
@@ -41,21 +41,26 @@ static int clk_gate2_enable(struct clk_hw *hw)
 	struct clk_gate2 *gate = to_clk_gate2(hw);
 	u32 reg;
 	unsigned long flags;
+	int ret = 0;
 
 	spin_lock_irqsave(gate->lock, flags);
 
 	if (gate->share_count && (*gate->share_count)++ > 0)
 		goto out;
 
-	reg = readl(gate->reg);
-	reg &= ~(3 << gate->bit_idx);
-	reg |= gate->cgr_val << gate->bit_idx;
-	writel(reg, gate->reg);
+	if (gate->flags & IMX_CLK_GATE2_SINGLE_BIT) {
+		ret = clk_gate_ops.enable(hw);
+	} else {
+		reg = readl(gate->reg);
+		reg &= ~(3 << gate->bit_idx);
+		reg |= gate->cgr_val << gate->bit_idx;
+		writel(reg, gate->reg);
+	}
 
 out:
 	spin_unlock_irqrestore(gate->lock, flags);
 
-	return 0;
+	return ret;
 }
 
 static void clk_gate2_disable(struct clk_hw *hw)
@@ -73,9 +78,13 @@ static void clk_gate2_disable(struct clk_hw *hw)
 			goto out;
 	}
 
-	reg = readl(gate->reg);
-	reg &= ~(3 << gate->bit_idx);
-	writel(reg, gate->reg);
+	if (gate->flags & IMX_CLK_GATE2_SINGLE_BIT) {
+		clk_gate_ops.disable(hw);
+	} else {
+		reg = readl(gate->reg);
+		reg &= ~(3 << gate->bit_idx);
+		writel(reg, gate->reg);
+	}
 
 out:
 	spin_unlock_irqrestore(gate->lock, flags);
@@ -95,6 +104,9 @@ static int clk_gate2_is_enabled(struct clk_hw *hw)
 {
 	struct clk_gate2 *gate = to_clk_gate2(hw);
 
+	if (gate->flags & IMX_CLK_GATE2_SINGLE_BIT)
+		return clk_gate_ops.is_enabled(hw);
+
 	return clk_gate2_reg_is_enabled(gate->reg, gate->bit_idx);
 }
 
@@ -104,6 +116,9 @@ static void clk_gate2_disable_unused(struct clk_hw *hw)
 	unsigned long flags;
 	u32 reg;
 
+	if (gate->flags & IMX_CLK_GATE2_SINGLE_BIT)
+		return;
+
 	spin_lock_irqsave(gate->lock, flags);
 
 	if (!gate->share_count || *gate->share_count == 0) {
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index f074dd8..01ff1db 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -5,6 +5,8 @@
 #include <linux/spinlock.h>
 #include <linux/clk-provider.h>
 
+#define IMX_CLK_GATE2_SINGLE_BIT	1
+
 extern spinlock_t imx_ccm_lock;
 
 void imx_check_clocks(struct clk *clks[], unsigned int count);
@@ -355,6 +357,17 @@ static inline struct clk_hw *imx_clk_hw_gate2_shared2(const char *name,
 				  &imx_ccm_lock, share_count);
 }
 
+static inline struct clk_hw *imx_dev_clk_hw_gate_shared(struct device *dev,
+				const char *name, const char *parent,
+				void __iomem *reg, u8 shift,
+				unsigned int *share_count)
+{
+	return clk_hw_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT |
+					CLK_OPS_PARENT_ENABLE, reg, shift, 0x3,
+					IMX_CLK_GATE2_SINGLE_BIT,
+					&imx_ccm_lock, share_count);
+}
+
 static inline struct clk *imx_clk_gate2_cgr(const char *name,
 		const char *parent, void __iomem *reg, u8 shift, u8 cgr_val)
 {
-- 
2.7.4

