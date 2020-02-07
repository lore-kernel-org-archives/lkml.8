Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E6BC2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 04:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3E022464
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 04:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="my3lFt6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgBGEoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 23:44:02 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33654 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgBGEoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 23:44:01 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0174huOv125816;
        Thu, 6 Feb 2020 22:43:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581050636;
        bh=BwL/SKvmR0aJ0N+Y6z1K8ee4J4DaLzQ3KJReRXUXHZM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=my3lFt6Nu7M+Q4BEryO2e0ZUbAXIfaoDgD5yLIbwACYPxiyvkqLydI8wd6aivJffY
         qouJsTE5/rxdfNYMANEKkBgxTFdY2jT/ww4Qtm/6k6Uck4CvymYCgKR3tL8VXGW31K
         OF4PzZsSuSrIJIY7VfhLxPR//HfaXNS3cwuLlny8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0174huAZ077523
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Feb 2020 22:43:56 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 6 Feb
 2020 22:43:56 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 6 Feb 2020 22:43:56 -0600
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0174hkKE120043;
        Thu, 6 Feb 2020 22:43:53 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>
Subject: [PATCH v2 2/2] clk: keystone: Add new driver to handle syscon based clocks
Date:   Fri, 7 Feb 2020 10:14:25 +0530
Message-ID: <20200207044425.32398-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207044425.32398-1-vigneshr@ti.com>
References: <20200207044425.32398-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On TI's AM654/J721e SoCs, certain clocks can be gated/ungated by setting a
single bit in SoC's System Control Module registers. Sometime more than
one clock control can be in the same register.
Add driver to support such clocks. Registers that control clocks will be
grouped into a syscon regmap. Clock provider node will be child of the
syscon node.
Driver currently supports controlling EHRPWM's TimeBase clock(TBCLK) for
AM654 SoC.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/clk/keystone/Kconfig      |   8 ++
 drivers/clk/keystone/Makefile     |   1 +
 drivers/clk/keystone/syscon-clk.c | 177 ++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 drivers/clk/keystone/syscon-clk.c

diff --git a/drivers/clk/keystone/Kconfig b/drivers/clk/keystone/Kconfig
index 38aeefb1e808..69ca3db1a99e 100644
--- a/drivers/clk/keystone/Kconfig
+++ b/drivers/clk/keystone/Kconfig
@@ -26,3 +26,11 @@ config TI_SCI_CLK_PROBE_FROM_FW
 	  This is mostly only useful for debugging purposes, and will
 	  increase the boot time of the device. If you want the clocks probed
 	  from firmware, say Y. Otherwise, say N.
+
+config TI_SYSCON_CLK
+	tristate "Syscon based clock driver for K2/K3 SoCs"
+	depends on (ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST) && OF
+	default (ARCH_KEYSTONE || ARCH_K3)
+	help
+	  This adds clock driver support for syscon based gate
+	  clocks on TI's K2 and K3 SoCs.
diff --git a/drivers/clk/keystone/Makefile b/drivers/clk/keystone/Makefile
index d044de6f965c..0e426e648f7c 100644
--- a/drivers/clk/keystone/Makefile
+++ b/drivers/clk/keystone/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+= pll.o gate.o
 obj-$(CONFIG_TI_SCI_CLK)		+= sci-clk.o
+obj-$(CONFIG_TI_SYSCON_CLK)		+= syscon-clk.o
diff --git a/drivers/clk/keystone/syscon-clk.c b/drivers/clk/keystone/syscon-clk.c
new file mode 100644
index 000000000000..42e7416371ff
--- /dev/null
+++ b/drivers/clk/keystone/syscon-clk.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+//
+
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+struct ti_syscon_gate_clk_priv {
+	struct clk_hw hw;
+	struct regmap *regmap;
+	u32 reg;
+	u32 idx;
+};
+
+struct ti_syscon_gate_clk_data {
+	char *name;
+	u32 offset;
+	u32 bit_idx;
+};
+
+static struct
+ti_syscon_gate_clk_priv *to_ti_syscon_gate_clk_priv(struct clk_hw *hw)
+{
+	return container_of(hw, struct ti_syscon_gate_clk_priv, hw);
+}
+
+static int ti_syscon_gate_clk_enable(struct clk_hw *hw)
+{
+	struct ti_syscon_gate_clk_priv *priv = to_ti_syscon_gate_clk_priv(hw);
+
+	return regmap_write_bits(priv->regmap, priv->reg, priv->idx,
+				 priv->idx);
+}
+
+static void ti_syscon_gate_clk_disable(struct clk_hw *hw)
+{
+	struct ti_syscon_gate_clk_priv *priv = to_ti_syscon_gate_clk_priv(hw);
+
+	regmap_write_bits(priv->regmap, priv->reg, priv->idx, 0);
+}
+
+static int ti_syscon_gate_clk_is_enabled(struct clk_hw *hw)
+{
+	unsigned int val;
+	struct ti_syscon_gate_clk_priv *priv = to_ti_syscon_gate_clk_priv(hw);
+
+	regmap_read(priv->regmap, priv->reg, &val);
+
+	return !!(val & priv->idx);
+}
+
+static const struct clk_ops ti_syscon_gate_clk_ops = {
+	.enable		= ti_syscon_gate_clk_enable,
+	.disable	= ti_syscon_gate_clk_disable,
+	.is_enabled	= ti_syscon_gate_clk_is_enabled,
+};
+
+static struct clk_hw
+*ti_syscon_gate_clk_register(struct device *dev, struct regmap *regmap,
+			     const struct ti_syscon_gate_clk_data *data)
+{
+	struct ti_syscon_gate_clk_priv *priv;
+	struct clk_init_data init;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = data->name;
+	init.ops = &ti_syscon_gate_clk_ops;
+	init.parent_names = NULL;
+	init.num_parents = 0;
+	init.flags = 0;
+
+	priv->regmap = regmap;
+	priv->reg = data->offset;
+	priv->idx = BIT(data->bit_idx);
+	priv->hw.init = &init;
+
+	ret = devm_clk_hw_register(dev, &priv->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &priv->hw;
+}
+
+static int ti_syscon_gate_clk_probe(struct platform_device *pdev)
+{
+	const struct ti_syscon_gate_clk_data *data, *p;
+	struct clk_hw_onecell_data *hw_data;
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	int num_clks = 0;
+	int i;
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	regmap = syscon_regmap_lookup_by_phandle(dev->of_node,
+						 "ti,tbclk-syscon");
+	if (IS_ERR(regmap)) {
+		if (PTR_ERR(regmap) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_err(dev, "failed to find parent regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	for (p = data; p->name; p++)
+		num_clks++;
+
+	hw_data = devm_kzalloc(dev, struct_size(hw_data, hws, num_clks),
+			       GFP_KERNEL);
+	if (!hw_data)
+		return -ENOMEM;
+
+	hw_data->num = num_clks;
+
+	for (i = 0; i < num_clks; i++) {
+		hw_data->hws[i] = ti_syscon_gate_clk_register(dev, regmap,
+							      &data[i]);
+		if (IS_ERR(hw_data->hws[i]))
+			dev_err(dev, "failed to register %s",
+				data[i].name);
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   hw_data);
+}
+
+#define TI_SYSCON_CLK_GATE(_name, _offset, _bit_idx)	\
+	{						\
+		.name = _name,				\
+		.offset = (_offset),			\
+		.bit_idx = (_bit_idx),			\
+	}
+
+static const struct ti_syscon_gate_clk_data am654_clk_data[] = {
+	TI_SYSCON_CLK_GATE("ehrpwm_tbclk0", 0x0, 0),
+	TI_SYSCON_CLK_GATE("ehrpwm_tbclk1", 0x4, 0),
+	TI_SYSCON_CLK_GATE("ehrpwm_tbclk2", 0x8, 0),
+	TI_SYSCON_CLK_GATE("ehrpwm_tbclk3", 0xc, 0),
+	TI_SYSCON_CLK_GATE("ehrpwm_tbclk4", 0x10, 0),
+	TI_SYSCON_CLK_GATE("ehrpwm_tbclk5", 0x14, 0),
+	{ /* Sentinel */ },
+};
+
+static const struct of_device_id ti_syscon_gate_clk_ids[] = {
+	{
+		.compatible = "ti,am654-ehrpwm-tbclk",
+		.data = &am654_clk_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ti_syscon_gate_clk_ids);
+
+static struct platform_driver ti_syscon_gate_clk_driver = {
+	.probe = ti_syscon_gate_clk_probe,
+	.driver = {
+		.name = "ti-syscon-gate-clk",
+		.of_match_table = ti_syscon_gate_clk_ids,
+	},
+};
+
+module_platform_driver(ti_syscon_gate_clk_driver);
+
+MODULE_AUTHOR("Vignesh Raghavendra <vigneshr@ti.com>");
+MODULE_DESCRIPTION("Syscon backed gate-clock driver");
+MODULE_LICENSE("GPL");
-- 
2.25.0

