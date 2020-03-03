Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A3DC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26742146E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgCCJDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:03:45 -0500
Received: from inva020.nxp.com ([92.121.34.13]:36518 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727992AbgCCJDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:03:43 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CA6871A1469;
        Tue,  3 Mar 2020 10:03:40 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BD7231A1465;
        Tue,  3 Mar 2020 10:03:40 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C3DD920414;
        Tue,  3 Mar 2020 10:03:39 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 04/11] clk: imx: Add gate shared for i.MX8MP audiomix
Date:   Tue,  3 Mar 2020 11:03:19 +0200
Message-Id: <1583226206-19758-5-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com>
References: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newer i.MX platform use some gates that have a shared control bit
between them.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/Makefile          |   2 +-
 drivers/clk/imx/clk-gate-shared.c | 111 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h             |   4 ++
 3 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-gate-shared.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 928f874c..799a8ef 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -27,7 +27,7 @@ obj-$(CONFIG_MXC_CLK_SCU) += \
 
 obj-$(CONFIG_CLK_IMX8MM) += clk-imx8mm.o
 obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
-obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o
+obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o clk-gate-shared.o
 obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
 obj-$(CONFIG_CLK_IMX8QXP) += clk-imx8qxp.o clk-imx8qxp-lpcg.o
 
diff --git a/drivers/clk/imx/clk-gate-shared.c b/drivers/clk/imx/clk-gate-shared.c
new file mode 100644
index 00000000..961a0e3
--- /dev/null
+++ b/drivers/clk/imx/clk-gate-shared.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 NXP.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include "clk.h"
+
+/**
+ * struct clk_gate_shared - i.MX specific gate clock having the gate flag
+ * shared with other gate clocks
+ */
+struct clk_gate_shared {
+	struct clk_gate	gate;
+	spinlock_t	*lock;
+	unsigned int	*share_count;
+};
+
+static int clk_gate_shared_enable(struct clk_hw *hw)
+{
+	struct clk_gate *gate = to_clk_gate(hw);
+	struct clk_gate_shared *shgate = container_of(gate,
+					struct clk_gate_shared, gate);
+	unsigned long flags = 0;
+	int ret = 0;
+
+	spin_lock_irqsave(shgate->lock, flags);
+
+	if (shgate->share_count && (*shgate->share_count)++ > 0)
+		goto out;
+
+	ret = clk_gate_ops.enable(hw);
+out:
+	spin_unlock_irqrestore(shgate->lock, flags);
+
+	return ret;
+}
+
+static void clk_gate_shared_disable(struct clk_hw *hw)
+{
+	struct clk_gate *gate = to_clk_gate(hw);
+	struct clk_gate_shared *shgate = container_of(gate,
+					struct clk_gate_shared, gate);
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(shgate->lock, flags);
+
+	if (shgate->share_count) {
+		if (WARN_ON(*shgate->share_count == 0))
+			goto out;
+		else if (--(*shgate->share_count) > 0)
+			goto out;
+	}
+
+	clk_gate_ops.disable(hw);
+out:
+	spin_unlock_irqrestore(shgate->lock, flags);
+}
+
+static int clk_gate_shared_is_enabled(struct clk_hw *hw)
+{
+	return clk_gate_ops.is_enabled(hw);
+}
+
+static const struct clk_ops clk_gate_shared_ops = {
+	.enable = clk_gate_shared_enable,
+	.disable = clk_gate_shared_disable,
+	.is_enabled = clk_gate_shared_is_enabled,
+};
+
+struct clk_hw *imx_dev_clk_hw_gate_shared(struct device *dev, const char *name,
+				const char *parent, void __iomem *reg,
+				u8 shift, unsigned int *share_count)
+{
+	struct clk_gate_shared *shgate;
+	struct clk_gate *gate;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	int ret;
+
+	shgate = kzalloc(sizeof(*shgate), GFP_KERNEL);
+	if (!shgate)
+		return ERR_PTR(-ENOMEM);
+	gate = &shgate->gate;
+
+	init.name = name;
+	init.ops = &clk_gate_shared_ops;
+	init.flags = CLK_OPS_PARENT_ENABLE;
+	init.parent_names = parent ? &parent : NULL;
+	init.num_parents = parent ? 1 : 0;
+
+	gate->reg = reg;
+	gate->bit_idx = shift;
+	gate->lock = NULL;
+	gate->hw.init = &init;
+	shgate->lock = &imx_ccm_lock;
+	shgate->share_count = share_count;
+
+	hw = &gate->hw;
+
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(shgate);
+		return ERR_PTR(ret);
+	}
+
+	return hw;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index f074dd8..51d6c26 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -151,6 +151,10 @@ struct clk_hw *imx_clk_hw_sscg_pll(const char *name,
 				void __iomem *base,
 				unsigned long flags);
 
+struct clk_hw *imx_dev_clk_hw_gate_shared(struct device *dev, const char *name,
+				const char *parent, void __iomem *reg,
+				u8 shift, unsigned int *share_count);
+
 enum imx_pllv3_type {
 	IMX_PLLV3_GENERIC,
 	IMX_PLLV3_SYS,
-- 
2.7.4

