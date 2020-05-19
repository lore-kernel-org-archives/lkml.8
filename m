Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0750C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807AE2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgESWmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 18:42:23 -0400
Received: from v6.sk ([167.172.42.174]:58564 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbgESWmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:42:18 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 1D60F612FE;
        Tue, 19 May 2020 22:42:16 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 13/13] clk: mmp2: Add audio clock controller driver
Date:   Wed, 20 May 2020 00:41:51 +0200
Message-Id: <20200519224151.2074597-14-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519224151.2074597-1-lkundrak@v3.sk>
References: <20200519224151.2074597-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a driver for a block that generates master and bit clocks for
the I2S interface. It's separate from the PMUs that generate clocks for
the peripherals.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Utilize runtime PM along with pm_clk to enable/disable clocks
- Rework the driver to use regular clk_mux, clk_div and clk_gate;
  save/restore the registers on PM suspend/resume
- Use #defines for regiser offsets instead of an enum
- Constify some structs
- Remove an extra comma afer a sentinel
- Remove an line break before module_platform_driver()
- Replace __raw_readl()/__raw_writel() with readl()/writel()
- Use clk_add_hw_provider() instead of clk_add_provider()
- Utilize clk_parent_data[] with .fw_name instead of clk_hw[] with
  __clk_get_hw(devm_clk_get()) to refer to parent clocks from outside the
  audio clock controller

 drivers/clk/Kconfig         |   6 +
 drivers/clk/mmp/Makefile    |   1 +
 drivers/clk/mmp/clk-audio.c | 443 ++++++++++++++++++++++++++++++++++++
 3 files changed, 450 insertions(+)
 create mode 100644 drivers/clk/mmp/clk-audio.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 5401d4a00eba..f0a01c439789 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -341,6 +341,12 @@ config COMMON_CLK_MMP2
 	help
 	  Support for Marvell MMP2 and MMP3 SoC clocks
 
+config COMMON_CLK_MMP2_AUDIO
+        tristate "Clock driver for MMP2 Audio subsystem"
+        depends on COMMON_CLK_MMP2 || COMPILE_TEST
+        help
+          This driver supports clocks for Audio subsystem on MMP2 SoC.
+
 config COMMON_CLK_BD718XX
 	tristate "Clock driver for 32K clk gates on ROHM PMICs"
 	depends on MFD_ROHM_BD718XX || MFD_ROHM_BD70528 || MFD_ROHM_BD71828
diff --git a/drivers/clk/mmp/Makefile b/drivers/clk/mmp/Makefile
index f9fab883a13b..cbcc2f8430a2 100644
--- a/drivers/clk/mmp/Makefile
+++ b/drivers/clk/mmp/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_RESET_CONTROLLER) += reset.o
 
 obj-$(CONFIG_MACH_MMP_DT) += clk-of-pxa168.o clk-of-pxa910.o
 obj-$(CONFIG_COMMON_CLK_MMP2) += clk-of-mmp2.o clk-pll.o pwr-island.o
+obj-$(CONFIG_COMMON_CLK_MMP2_AUDIO) += clk-audio.o
 
 obj-$(CONFIG_CPU_PXA168) += clk-pxa168.o
 obj-$(CONFIG_CPU_PXA910) += clk-pxa910.o
diff --git a/drivers/clk/mmp/clk-audio.c b/drivers/clk/mmp/clk-audio.c
new file mode 100644
index 000000000000..eea69d498bd2
--- /dev/null
+++ b/drivers/clk/mmp/clk-audio.c
@@ -0,0 +1,443 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MMP Audio Clock Controller driver
+ *
+ * Copyright (C) 2020 Lubomir Rintel <lkundrak@v3.sk>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_clock.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <dt-bindings/clock/marvell,mmp2-audio.h>
+
+/* Audio Controller Registers */
+#define SSPA_AUD_CTRL				0x04
+#define SSPA_AUD_PLL_CTRL0			0x08
+#define SSPA_AUD_PLL_CTRL1			0x0c
+
+/* SSPA Audio Control Register */
+#define SSPA_AUD_CTRL_SYSCLK_SHIFT		0
+#define SSPA_AUD_CTRL_SYSCLK_DIV_SHIFT		1
+#define SSPA_AUD_CTRL_SSPA0_MUX_SHIFT		7
+#define SSPA_AUD_CTRL_SSPA0_SHIFT		8
+#define SSPA_AUD_CTRL_SSPA0_DIV_SHIFT		9
+#define SSPA_AUD_CTRL_SSPA1_SHIFT		16
+#define SSPA_AUD_CTRL_SSPA1_DIV_SHIFT		17
+#define SSPA_AUD_CTRL_SSPA1_MUX_SHIFT		23
+#define SSPA_AUD_CTRL_DIV_MASK			0x7e
+
+/* SSPA Audio PLL Control 0 Register */
+#define SSPA_AUD_PLL_CTRL0_DIV_OCLK_MODULO_MASK (0x7 << 28)
+#define SSPA_AUD_PLL_CTRL0_DIV_OCLK_MODULO(x)	((x) << 28)
+#define SSPA_AUD_PLL_CTRL0_FRACT_MASK		(0xfffff << 8)
+#define SSPA_AUD_PLL_CTRL0_FRACT(x)		((x) << 8)
+#define SSPA_AUD_PLL_CTRL0_ENA_DITHER		(1 << 7)
+#define SSPA_AUD_PLL_CTRL0_ICP_2UA		(0 << 5)
+#define SSPA_AUD_PLL_CTRL0_ICP_5UA		(1 << 5)
+#define SSPA_AUD_PLL_CTRL0_ICP_7UA		(2 << 5)
+#define SSPA_AUD_PLL_CTRL0_ICP_10UA		(3 << 5)
+#define SSPA_AUD_PLL_CTRL0_DIV_FBCCLK_MASK	(0x3 << 3)
+#define SSPA_AUD_PLL_CTRL0_DIV_FBCCLK(x)	((x) << 3)
+#define SSPA_AUD_PLL_CTRL0_DIV_MCLK_MASK	(0x1 << 2)
+#define SSPA_AUD_PLL_CTRL0_DIV_MCLK(x)		((x) << 2)
+#define SSPA_AUD_PLL_CTRL0_PD_OVPROT_DIS	(1 << 1)
+#define SSPA_AUD_PLL_CTRL0_PU			(1 << 0)
+
+/* SSPA Audio PLL Control 1 Register */
+#define SSPA_AUD_PLL_CTRL1_SEL_FAST_CLK		(1 << 24)
+#define SSPA_AUD_PLL_CTRL1_CLK_SEL_MASK		(1 << 11)
+#define SSPA_AUD_PLL_CTRL1_CLK_SEL_AUDIO_PLL	(1 << 11)
+#define SSPA_AUD_PLL_CTRL1_CLK_SEL_VCXO		(0 << 11)
+#define SSPA_AUD_PLL_CTRL1_DIV_OCLK_PATTERN_MASK (0x7ff << 0)
+#define SSPA_AUD_PLL_CTRL1_DIV_OCLK_PATTERN(x)	((x) << 0)
+
+struct mmp2_audio_clk {
+	void __iomem *mmio_base;
+
+	struct clk_hw audio_pll_hw;
+	struct clk_mux sspa_mux;
+	struct clk_mux sspa1_mux;
+	struct clk_divider sysclk_div;
+	struct clk_divider sspa0_div;
+	struct clk_divider sspa1_div;
+	struct clk_gate sysclk_gate;
+	struct clk_gate sspa0_gate;
+	struct clk_gate sspa1_gate;
+
+	u32 aud_ctrl;
+	u32 aud_pll_ctrl0;
+	u32 aud_pll_ctrl1;
+
+	spinlock_t lock;
+
+	/* Must be last */
+	struct clk_hw_onecell_data clk_data;
+};
+
+static const struct {
+	unsigned long parent_rate;
+	unsigned long freq_vco;
+	unsigned char mclk;
+	unsigned char fbcclk;
+	unsigned short fract;
+} predivs[] = {
+	{ 26000000, 135475200, 0, 0, 0x8a18 },
+	{ 26000000, 147456000, 0, 1, 0x0da1 },
+	{ 38400000, 135475200, 1, 2, 0x8208 },
+	{ 38400000, 147456000, 1, 3, 0xaaaa },
+};
+
+static const struct {
+	unsigned char divisor;
+	unsigned char modulo;
+	unsigned char pattern;
+} postdivs[] = {
+	{   1,	3,  0, },
+	{   2,	5,  0, },
+	{   4,	0,  0, },
+	{   6,	1,  1, },
+	{   8,	1,  0, },
+	{   9,	1,  2, },
+	{  12,	2,  1, },
+	{  16,	2,  0, },
+	{  18,	2,  2, },
+	{  24,	4,  1, },
+	{  36,	4,  2, },
+	{  48,	6,  1, },
+	{  72,	6,  2, },
+};
+
+static unsigned long audio_pll_recalc_rate(struct clk_hw *hw,
+					   unsigned long parent_rate)
+{
+	struct mmp2_audio_clk *priv = container_of(hw, struct mmp2_audio_clk, audio_pll_hw);
+	unsigned int prediv;
+	unsigned int postdiv;
+	u32 aud_pll_ctrl0;
+	u32 aud_pll_ctrl1;
+
+	aud_pll_ctrl0 = readl(priv->mmio_base + SSPA_AUD_PLL_CTRL0);
+	aud_pll_ctrl0 &= SSPA_AUD_PLL_CTRL0_DIV_OCLK_MODULO_MASK |
+			 SSPA_AUD_PLL_CTRL0_FRACT_MASK |
+			 SSPA_AUD_PLL_CTRL0_ENA_DITHER |
+			 SSPA_AUD_PLL_CTRL0_DIV_FBCCLK_MASK |
+			 SSPA_AUD_PLL_CTRL0_DIV_MCLK_MASK |
+			 SSPA_AUD_PLL_CTRL0_PU;
+
+	aud_pll_ctrl1 = readl(priv->mmio_base + SSPA_AUD_PLL_CTRL1);
+	aud_pll_ctrl1 &= SSPA_AUD_PLL_CTRL1_CLK_SEL_MASK |
+			 SSPA_AUD_PLL_CTRL1_DIV_OCLK_PATTERN_MASK;
+
+	for (prediv = 0; prediv < ARRAY_SIZE(predivs); prediv++) {
+		if (predivs[prediv].parent_rate != parent_rate)
+			continue;
+		for (postdiv = 0; postdiv < ARRAY_SIZE(postdivs); postdiv++) {
+			unsigned long freq;
+			u32 val;
+
+			val = SSPA_AUD_PLL_CTRL0_ENA_DITHER;
+			val |= SSPA_AUD_PLL_CTRL0_PU;
+			val |= SSPA_AUD_PLL_CTRL0_DIV_OCLK_MODULO(postdivs[postdiv].modulo);
+			val |= SSPA_AUD_PLL_CTRL0_FRACT(predivs[prediv].fract);
+			val |= SSPA_AUD_PLL_CTRL0_DIV_FBCCLK(predivs[prediv].fbcclk);
+			val |= SSPA_AUD_PLL_CTRL0_DIV_MCLK(predivs[prediv].mclk);
+			if (val != aud_pll_ctrl0)
+				continue;
+
+			val = SSPA_AUD_PLL_CTRL1_CLK_SEL_AUDIO_PLL;
+			val |= SSPA_AUD_PLL_CTRL1_DIV_OCLK_PATTERN(postdivs[postdiv].pattern);
+			if (val != aud_pll_ctrl1)
+				continue;
+
+			freq = predivs[prediv].freq_vco;
+			freq /= postdivs[postdiv].divisor;
+			return freq;
+		}
+	}
+
+	return 0;
+}
+
+static long audio_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long *parent_rate)
+{
+	unsigned int prediv;
+	unsigned int postdiv;
+	long rounded = 0;
+
+	for (prediv = 0; prediv < ARRAY_SIZE(predivs); prediv++) {
+		if (predivs[prediv].parent_rate != *parent_rate)
+			continue;
+		for (postdiv = 0; postdiv < ARRAY_SIZE(postdivs); postdiv++) {
+			long freq = predivs[prediv].freq_vco;
+
+			freq /= postdivs[postdiv].divisor;
+			if (freq == rate)
+				return rate;
+			if (freq < rate)
+				continue;
+			if (rounded && freq > rounded)
+				continue;
+			rounded = freq;
+		}
+	}
+
+	return rounded;
+}
+
+static int audio_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long parent_rate)
+{
+	struct mmp2_audio_clk *priv = container_of(hw, struct mmp2_audio_clk, audio_pll_hw);
+	unsigned int prediv;
+	unsigned int postdiv;
+	unsigned long val;
+
+	for (prediv = 0; prediv < ARRAY_SIZE(predivs); prediv++) {
+		if (predivs[prediv].parent_rate != parent_rate)
+			continue;
+
+		for (postdiv = 0; postdiv < ARRAY_SIZE(postdivs); postdiv++) {
+			if (rate * postdivs[postdiv].divisor != predivs[prediv].freq_vco)
+				continue;
+
+			val = SSPA_AUD_PLL_CTRL0_ENA_DITHER;
+			val |= SSPA_AUD_PLL_CTRL0_PU;
+			val |= SSPA_AUD_PLL_CTRL0_DIV_OCLK_MODULO(postdivs[postdiv].modulo);
+			val |= SSPA_AUD_PLL_CTRL0_FRACT(predivs[prediv].fract);
+			val |= SSPA_AUD_PLL_CTRL0_DIV_FBCCLK(predivs[prediv].fbcclk);
+			val |= SSPA_AUD_PLL_CTRL0_DIV_MCLK(predivs[prediv].mclk);
+			writel(val, priv->mmio_base + SSPA_AUD_PLL_CTRL0);
+
+			val = SSPA_AUD_PLL_CTRL1_CLK_SEL_AUDIO_PLL;
+			val |= SSPA_AUD_PLL_CTRL1_DIV_OCLK_PATTERN(postdivs[postdiv].pattern);
+			writel(val, priv->mmio_base + SSPA_AUD_PLL_CTRL1);
+
+			return 0;
+		}
+	}
+
+	return -ERANGE;
+}
+
+static const struct clk_ops audio_pll_ops = {
+	.recalc_rate = audio_pll_recalc_rate,
+	.round_rate = audio_pll_round_rate,
+	.set_rate = audio_pll_set_rate,
+};
+
+static int register_clocks(struct mmp2_audio_clk *priv, struct device *dev)
+{
+	const struct clk_parent_data sspa_mux_parents[] = {
+		{ .hw = &priv->audio_pll_hw },
+		{ .fw_name = "i2s0" },
+	};
+	const struct clk_parent_data sspa1_mux_parents[] = {
+		{ .hw = &priv->audio_pll_hw },
+		{ .fw_name = "i2s1" },
+	};
+	int ret;
+
+	priv->audio_pll_hw.init = CLK_HW_INIT_FW_NAME("audio_pll",
+				"vctcxo", &audio_pll_ops,
+				CLK_SET_RATE_PARENT);
+	ret = devm_clk_hw_register(dev, &priv->audio_pll_hw);
+	if (ret)
+		return ret;
+
+	priv->sspa_mux.hw.init = CLK_HW_INIT_PARENTS_DATA("sspa_mux",
+				sspa_mux_parents, &clk_mux_ops,
+				CLK_SET_RATE_PARENT);
+	priv->sspa_mux.reg = priv->mmio_base + SSPA_AUD_CTRL;
+	priv->sspa_mux.mask = 1;
+	priv->sspa_mux.shift = SSPA_AUD_CTRL_SSPA0_MUX_SHIFT;
+	ret = devm_clk_hw_register(dev, &priv->sspa_mux.hw);
+	if (ret)
+		return ret;
+
+	priv->sysclk_div.hw.init = CLK_HW_INIT_HW("sys_div",
+				&priv->sspa_mux.hw, &clk_divider_ops,
+				CLK_SET_RATE_PARENT);
+	priv->sysclk_div.reg = priv->mmio_base + SSPA_AUD_CTRL;
+	priv->sysclk_div.shift = SSPA_AUD_CTRL_SYSCLK_DIV_SHIFT;
+	priv->sysclk_div.width = 6;
+	priv->sysclk_div.flags = CLK_DIVIDER_ONE_BASED;
+	priv->sysclk_div.flags |= CLK_DIVIDER_ROUND_CLOSEST;
+	priv->sysclk_div.flags |= CLK_DIVIDER_ALLOW_ZERO;
+	ret = devm_clk_hw_register(dev, &priv->sysclk_div.hw);
+	if (ret)
+		return ret;
+
+	priv->sysclk_gate.hw.init = CLK_HW_INIT_HW("sys_clk",
+				&priv->sysclk_div.hw, &clk_gate_ops,
+				CLK_SET_RATE_PARENT);
+	priv->sysclk_gate.reg = priv->mmio_base + SSPA_AUD_CTRL;
+	priv->sysclk_gate.bit_idx = SSPA_AUD_CTRL_SYSCLK_SHIFT;
+	ret = devm_clk_hw_register(dev, &priv->sysclk_gate.hw);
+	if (ret)
+		return ret;
+
+	priv->sspa0_div.hw.init = CLK_HW_INIT_HW("sspa0_div",
+				&priv->sspa_mux.hw, &clk_divider_ops, 0);
+	priv->sspa0_div.reg = priv->mmio_base + SSPA_AUD_CTRL;
+	priv->sspa0_div.shift = SSPA_AUD_CTRL_SSPA0_DIV_SHIFT;
+	priv->sspa0_div.width = 6;
+	priv->sspa0_div.flags = CLK_DIVIDER_ONE_BASED;
+	priv->sspa0_div.flags |= CLK_DIVIDER_ROUND_CLOSEST;
+	priv->sspa0_div.flags |= CLK_DIVIDER_ALLOW_ZERO;
+	ret = devm_clk_hw_register(dev, &priv->sspa0_div.hw);
+	if (ret)
+		return ret;
+
+	priv->sspa0_gate.hw.init = CLK_HW_INIT_HW("sspa0_clk",
+				&priv->sspa0_div.hw, &clk_gate_ops,
+				CLK_SET_RATE_PARENT);
+	priv->sspa0_gate.reg = priv->mmio_base + SSPA_AUD_CTRL;
+	priv->sspa0_gate.bit_idx = SSPA_AUD_CTRL_SSPA0_SHIFT;
+	ret = devm_clk_hw_register(dev, &priv->sspa0_gate.hw);
+	if (ret)
+		return ret;
+
+	priv->sspa1_mux.hw.init = CLK_HW_INIT_PARENTS_DATA("sspa1_mux",
+				sspa1_mux_parents, &clk_mux_ops,
+				CLK_SET_RATE_PARENT);
+	priv->sspa1_mux.reg = priv->mmio_base + SSPA_AUD_CTRL;
+	priv->sspa1_mux.mask = 1;
+	priv->sspa1_mux.shift = SSPA_AUD_CTRL_SSPA1_MUX_SHIFT;
+	ret = devm_clk_hw_register(dev, &priv->sspa1_mux.hw);
+	if (ret)
+		return ret;
+
+	priv->sspa1_div.hw.init = CLK_HW_INIT_HW("sspa1_div",
+				&priv->sspa1_mux.hw, &clk_divider_ops, 0);
+	priv->sspa1_div.reg = priv->mmio_base + SSPA_AUD_CTRL;
+	priv->sspa1_div.shift = SSPA_AUD_CTRL_SSPA1_DIV_SHIFT;
+	priv->sspa1_div.width = 6;
+	priv->sspa1_div.flags = CLK_DIVIDER_ONE_BASED;
+	priv->sspa1_div.flags |= CLK_DIVIDER_ROUND_CLOSEST;
+	priv->sspa1_div.flags |= CLK_DIVIDER_ALLOW_ZERO;
+	ret = devm_clk_hw_register(dev, &priv->sspa1_div.hw);
+	if (ret)
+		return ret;
+
+	priv->sspa1_gate.hw.init = CLK_HW_INIT_HW("sspa1_clk",
+				&priv->sspa1_div.hw, &clk_gate_ops,
+				CLK_SET_RATE_PARENT);
+	priv->sspa1_gate.reg = priv->mmio_base + SSPA_AUD_CTRL;
+	priv->sspa1_gate.bit_idx = SSPA_AUD_CTRL_SSPA1_SHIFT;
+	ret = devm_clk_hw_register(dev, &priv->sspa1_gate.hw);
+	if (ret)
+		return ret;
+
+	priv->clk_data.hws[MMP2_CLK_AUDIO_SYSCLK] = &priv->sysclk_gate.hw;
+	priv->clk_data.hws[MMP2_CLK_AUDIO_SSPA0] = &priv->sspa0_gate.hw;
+	priv->clk_data.hws[MMP2_CLK_AUDIO_SSPA1] = &priv->sspa1_gate.hw;
+	priv->clk_data.num = MMP2_CLK_AUDIO_NR_CLKS;
+
+	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
+				      &priv->clk_data);
+}
+
+static int mmp2_audio_clk_probe(struct platform_device *pdev)
+{
+	struct mmp2_audio_clk *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, clk_data.hws,
+					MMP2_CLK_AUDIO_NR_CLKS),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->lock);
+	platform_set_drvdata(pdev, priv);
+
+	priv->mmio_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->mmio_base))
+		return PTR_ERR(priv->mmio_base);
+
+	pm_runtime_enable(&pdev->dev);
+	ret = pm_clk_create(&pdev->dev);
+	if (ret)
+		goto disable_pm_runtime;
+
+	ret = pm_clk_add(&pdev->dev, "audio");
+	if (ret)
+		goto destroy_pm_clk;
+
+	ret = register_clocks(priv, &pdev->dev);
+	if (ret)
+		goto destroy_pm_clk;
+
+	return 0;
+
+destroy_pm_clk:
+	pm_clk_destroy(&pdev->dev);
+disable_pm_runtime:
+	pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+static int mmp2_audio_clk_remove(struct platform_device *pdev)
+{
+	pm_clk_destroy(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static int __maybe_unused mmp2_audio_clk_suspend(struct device *dev)
+{
+	struct mmp2_audio_clk *priv = dev_get_drvdata(dev);
+
+	priv->aud_ctrl = readl(priv->mmio_base + SSPA_AUD_CTRL);
+	priv->aud_pll_ctrl0 = readl(priv->mmio_base + SSPA_AUD_PLL_CTRL0);
+	priv->aud_pll_ctrl1 = readl(priv->mmio_base + SSPA_AUD_PLL_CTRL1);
+	pm_clk_suspend(dev);
+
+	return 0;
+}
+
+static int __maybe_unused mmp2_audio_clk_resume(struct device *dev)
+{
+	struct mmp2_audio_clk *priv = dev_get_drvdata(dev);
+
+	pm_clk_resume(dev);
+	writel(priv->aud_ctrl, priv->mmio_base + SSPA_AUD_CTRL);
+	writel(priv->aud_pll_ctrl0, priv->mmio_base + SSPA_AUD_PLL_CTRL0);
+	writel(priv->aud_pll_ctrl1, priv->mmio_base + SSPA_AUD_PLL_CTRL1);
+
+	return 0;
+}
+
+static const struct dev_pm_ops mmp2_audio_clk_pm_ops = {
+	SET_RUNTIME_PM_OPS(mmp2_audio_clk_suspend, mmp2_audio_clk_resume, NULL)
+};
+
+static const struct of_device_id mmp2_audio_clk_of_match[] = {
+	{ .compatible = "marvell,mmp2-audio-clock" },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, mmp2_audio_clk_of_match);
+
+static struct platform_driver mmp2_audio_clk_driver = {
+	.driver = {
+		.name = "mmp2-audio-clock",
+		.of_match_table = of_match_ptr(mmp2_audio_clk_of_match),
+		.pm = &mmp2_audio_clk_pm_ops,
+	},
+	.probe = mmp2_audio_clk_probe,
+	.remove = mmp2_audio_clk_remove,
+};
+module_platform_driver(mmp2_audio_clk_driver);
+
+MODULE_AUTHOR("Lubomir Rintel <lkundrak@v3.sk>");
+MODULE_DESCRIPTION("Clock driver for MMP2 Audio subsystem");
+MODULE_LICENSE("GPL");
-- 
2.26.2

