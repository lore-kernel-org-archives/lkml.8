Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1099C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53CC20838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgBZKKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:10:19 -0500
Received: from mga17.intel.com ([192.55.52.151]:43399 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgBZKKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 05:10:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 02:10:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,487,1574150400"; 
   d="scan'208";a="261012335"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga004.fm.intel.com with ESMTP; 26 Feb 2020 02:10:12 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kishon@ti.com, robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v3 3/3] phy: intel: Add driver support for Combophy
Date:   Wed, 26 Feb 2020 18:09:53 +0800
Message-Id: <48dbbe705a1f22fb9e088827ca0be149e8fbcd85.1582709320.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1582709320.git.eswara.kota@linux.intel.com>
References: <cover.1582709320.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1582709320.git.eswara.kota@linux.intel.com>
References: <cover.1582709320.git.eswara.kota@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combophy subsystem provides PHYs for various
controllers like PCIe, SATA and EMAC.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
Changes on v3:
 Use fwnode_to_regmap()
 Call devm_of_platform_populate() to populate child nodes
 Add SoC specific compatible "intel,combophy-lgm"
 Remove intel_iphy_names
 Remove struct phy entry in struct intel_cbphy_iphy
 Imporve if conditions logic
 Add description for enums
 Remove default case in switch {} intel_cbphy_set_mode() as it
  never happens.
 Use mutex_lock to synchronise ComboPhy initialization across
  two phys.
 Change init_cnt to u32 datatype as it is within mutex lock.
 Correct error handling of
  fwnode_property_read_u32_array(fwnode, "intel,phy-mode", ...)

 drivers/phy/intel/Kconfig           |  13 +
 drivers/phy/intel/Makefile          |   1 +
 drivers/phy/intel/phy-intel-combo.c | 672 ++++++++++++++++++++++++++++++++++++
 3 files changed, 686 insertions(+)
 create mode 100644 drivers/phy/intel/phy-intel-combo.c

diff --git a/drivers/phy/intel/Kconfig b/drivers/phy/intel/Kconfig
index 4ea6a8897cd7..bbd0792f5b43 100644
--- a/drivers/phy/intel/Kconfig
+++ b/drivers/phy/intel/Kconfig
@@ -2,6 +2,19 @@
 #
 # Phy drivers for Intel Lightning Mountain(LGM) platform
 #
+config PHY_INTEL_COMBO
+	bool "Intel Combo PHY driver"
+	depends on OF && HAS_IOMEM && (X86 || COMPILE_TEST)
+	select MFD_SYSCON
+	select GENERIC_PHY
+	select REGMAP
+	help
+	  Enable this to support Intel combo phy.
+
+	  This driver configures combo phy subsystem on Intel gateway
+	  chipsets which provides PHYs for various controllers, EMAC,
+	  SATA and PCIe.
+
 config PHY_INTEL_EMMC
 	tristate "Intel EMMC PHY driver"
 	select GENERIC_PHY
diff --git a/drivers/phy/intel/Makefile b/drivers/phy/intel/Makefile
index 6b876a75599d..233d530dadde 100644
--- a/drivers/phy/intel/Makefile
+++ b/drivers/phy/intel/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PHY_INTEL_COMBO)		+= phy-intel-combo.o
 obj-$(CONFIG_PHY_INTEL_EMMC)            += phy-intel-emmc.o
diff --git a/drivers/phy/intel/phy-intel-combo.c b/drivers/phy/intel/phy-intel-combo.c
new file mode 100644
index 000000000000..b75f60834eec
--- /dev/null
+++ b/drivers/phy/intel/phy-intel-combo.c
@@ -0,0 +1,672 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Combo-PHY driver
+ *
+ * Copyright (C) 2019 Intel Corporation.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_platform.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#define PCIE_PHY_GEN_CTRL	0x00
+#define PCIE_PHY_CLK_PAD	BIT(17)
+#define PCIE_PHY_MPLLA_CTRL	0x10
+#define PCIE_PHY_MPLLB_CTRL	0x14
+
+#define PCS_XF_ATE_OVRD_IN_2	0x3008
+#define ADAPT_REQ_MSK		0x30
+#define PCS_XF_RX_ADAPT_ACK	0x3010
+#define RX_ADAPT_ACK_BIT	BIT(0)
+
+#define CR_ADDR(addr, lane)	(((addr) + (lane) * 0x100) << 2)
+#define REG_COMBO_MODE(x)	((x) * 0x200)
+#define REG_CLK_DISABLE(x)	((x) * 0x200 + 0x124)
+
+#define COMBO_PHY_ID(x)		((x)->parent->id)
+#define PHY_ID(x)		((x)->id)
+
+#define CLK_100MHZ		100000000
+#define CLK_156_25MHZ		156250000
+
+static const unsigned long intel_iphy_clk_rates[] = {
+	CLK_100MHZ, CLK_156_25MHZ, CLK_100MHZ
+};
+
+enum {
+	PHY_0,
+	PHY_1,
+	PHY_MAX_NUM,
+};
+
+/*
+ * Clock register bitfields to enable clocks
+ * for ComboPhy according to the mode
+ */
+enum intel_phy_mode {
+	PHY_PCIE_MODE = 0,
+	PHY_XPCS_MODE,
+	PHY_SATA_MODE,
+	PHY_MAX_MODE,
+};
+
+/* ComboPhy mode register values */
+enum intel_combo_mode {
+	PCIE0_PCIE1_MODE = 0,
+	PCIE_DL_MODE,
+	RXAUI_MODE,
+	XPCS0_XPCS1_MODE,
+	SATA0_SATA1_MODE,
+	COMBO_PHY_MODE_MAX,
+};
+
+enum aggregated_mode {
+	PHY_SL_MODE,
+	PHY_DL_MODE,
+};
+
+struct intel_combo_phy;
+
+struct intel_cbphy_iphy {
+	struct device		*dev;
+	bool			enable;
+	struct intel_combo_phy	*parent;
+	struct reset_control	*app_rst;
+	u32			id;
+};
+
+struct intel_combo_phy {
+	struct device		*dev;
+	struct clk		*core_clk;
+	unsigned long		clk_rate;
+	void __iomem		*app_base;
+	void __iomem		*cr_base;
+	struct regmap		*syscfg;
+	struct regmap		*hsiocfg;
+	u32			id;
+	u32			bid;
+	struct reset_control	*phy_rst;
+	struct reset_control	*core_rst;
+	struct intel_cbphy_iphy	iphy[PHY_MAX_NUM];
+	enum intel_phy_mode	phy_mode;
+	enum aggregated_mode	aggr_mode;
+	u32			init_cnt;
+	struct mutex		lock;
+};
+
+static int intel_cbphy_iphy_enable(struct intel_cbphy_iphy *iphy, bool set)
+{
+	struct intel_combo_phy *cbphy = iphy->parent;
+	u32 mask = BIT(cbphy->phy_mode * 2 + iphy->id);
+	u32 val;
+
+	/* Register: 0 is enable, 1 is disable */
+	val = set ? 0 : mask;
+
+	return regmap_update_bits(cbphy->hsiocfg, REG_CLK_DISABLE(cbphy->bid),
+				  mask, val);
+}
+
+static int intel_cbphy_pcie_refclk_cfg(struct intel_cbphy_iphy *iphy, bool set)
+{
+	struct intel_combo_phy *cbphy = iphy->parent;
+	u32 mask = BIT(cbphy->id * 2 + iphy->id);
+	const u32 pad_dis_cfg_off = 0x174;
+	u32 val;
+
+	/* Register: 0 is enable, 1 is disable */
+	val = set ? 0 : mask;
+
+	return regmap_update_bits(cbphy->syscfg, pad_dis_cfg_off, mask, val);
+}
+
+static inline void combo_phy_w32_off_mask(void __iomem *base, unsigned int reg,
+					  u32 mask, u32 val)
+{
+	u32 reg_val;
+
+	reg_val = readl(base + reg);
+	reg_val &= ~mask;
+	reg_val |= FIELD_PREP(mask, val);
+	writel(reg_val, base + reg);
+}
+
+static int intel_cbphy_iphy_cfg(struct intel_cbphy_iphy *iphy,
+				int (*phy_cfg)(struct intel_cbphy_iphy *))
+{
+	struct intel_combo_phy *cbphy = iphy->parent;
+	struct intel_cbphy_iphy *sphy;
+	int ret;
+
+	ret = phy_cfg(iphy);
+	if (ret)
+		return ret;
+
+	if (cbphy->aggr_mode != PHY_DL_MODE)
+		return 0;
+
+	sphy = &cbphy->iphy[PHY_1];
+	ret = phy_cfg(sphy);
+
+	return ret;
+}
+
+static int intel_cbphy_pcie_en_pad_refclk(struct intel_cbphy_iphy *iphy)
+{
+	struct intel_combo_phy *cbphy = iphy->parent;
+	int ret;
+
+	ret = intel_cbphy_pcie_refclk_cfg(iphy, true);
+	if (ret) {
+		dev_err(iphy->dev, "Failed to enable PCIe pad refclk\n");
+		return ret;
+	}
+
+	if (cbphy->init_cnt)
+		return 0;
+
+	combo_phy_w32_off_mask(cbphy->app_base, PCIE_PHY_GEN_CTRL,
+			       PCIE_PHY_CLK_PAD, 0);
+	/*
+	 * No way to identify gen1/2/3/4 for mppla and mpplb, just delay
+	 * for stable plla(gen1/gen2) or pllb(gen3/gen4)
+	 */
+	usleep_range(50, 100);
+
+	return 0;
+}
+
+static int intel_cbphy_pcie_dis_pad_refclk(struct intel_cbphy_iphy *iphy)
+{
+	struct intel_combo_phy *cbphy = iphy->parent;
+	int ret;
+
+	ret = intel_cbphy_pcie_refclk_cfg(iphy, false);
+	if (ret) {
+		dev_err(iphy->dev, "Failed to disable PCIe pad refclk\n");
+		return ret;
+	}
+
+	if (cbphy->init_cnt)
+		return 0;
+
+	combo_phy_w32_off_mask(cbphy->app_base, PCIE_PHY_GEN_CTRL,
+			       PCIE_PHY_CLK_PAD, 1);
+
+	return 0;
+}
+
+static int intel_cbphy_set_mode(struct intel_combo_phy *cbphy)
+{
+	enum intel_combo_mode cb_mode = COMBO_PHY_MODE_MAX;
+	enum aggregated_mode aggr = cbphy->aggr_mode;
+	struct device *dev = cbphy->dev;
+	enum intel_phy_mode mode;
+	int ret;
+
+	mode = cbphy->phy_mode;
+
+	switch (mode) {
+	case PHY_PCIE_MODE:
+		cb_mode = (aggr == PHY_DL_MODE) ? PCIE_DL_MODE : PCIE0_PCIE1_MODE;
+		break;
+
+	case PHY_XPCS_MODE:
+		cb_mode = (aggr == PHY_DL_MODE) ? RXAUI_MODE : XPCS0_XPCS1_MODE;
+		break;
+
+	case PHY_SATA_MODE:
+		if (aggr == PHY_DL_MODE) {
+			dev_err(dev, "Mode:%u not support dual lane!\n", mode);
+			return -EINVAL;
+		}
+
+		cb_mode = SATA0_SATA1_MODE;
+		break;
+	}
+
+	ret = regmap_write(cbphy->hsiocfg, REG_COMBO_MODE(cbphy->bid), cb_mode);
+	if (ret)
+		dev_err(dev, "Failed to set ComboPhy mode: %d\n", ret);
+
+	return ret;
+}
+
+static void intel_cbphy_rst_assert(struct intel_combo_phy *cbphy)
+{
+	reset_control_assert(cbphy->core_rst);
+	reset_control_assert(cbphy->phy_rst);
+}
+
+static void intel_cbphy_rst_deassert(struct intel_combo_phy *cbphy)
+{
+	reset_control_deassert(cbphy->core_rst);
+	reset_control_deassert(cbphy->phy_rst);
+	/* Delay to ensure reset process is done */
+	usleep_range(10, 20);
+}
+
+static int intel_cbphy_iphy_power_on(struct intel_cbphy_iphy *iphy)
+{
+	struct intel_combo_phy *cbphy = iphy->parent;
+	struct device *dev = iphy->dev;
+	int ret;
+
+	if (cbphy->init_cnt) {
+		ret = clk_prepare_enable(cbphy->core_clk);
+		if (ret) {
+			dev_err(cbphy->dev, "Clock enable failed!\n");
+			return ret;
+		}
+
+		ret = clk_set_rate(cbphy->core_clk, cbphy->clk_rate);
+		if (ret) {
+			dev_err(cbphy->dev, "Clock freq set to %lu failed!\n",
+				cbphy->clk_rate);
+			goto clk_err;
+		}
+
+		intel_cbphy_rst_assert(cbphy);
+		intel_cbphy_rst_deassert(cbphy);
+		ret = intel_cbphy_set_mode(cbphy);
+		if (ret)
+			goto clk_err;
+	}
+
+	ret = intel_cbphy_iphy_enable(iphy, true);
+	if (ret) {
+		dev_err(dev, "Failed enabling Phy core\n");
+		goto clk_err;
+	}
+
+	ret = reset_control_deassert(iphy->app_rst);
+	if (ret) {
+		dev_err(dev, "PHY(%u:%u) phy deassert failed!\n",
+			COMBO_PHY_ID(iphy), PHY_ID(iphy));
+		goto clk_err;
+	}
+
+	/* Delay to ensure reset process is done */
+	udelay(1);
+
+	return 0;
+
+clk_err:
+	clk_disable_unprepare(cbphy->core_clk);
+
+	return ret;
+}
+
+static int intel_cbphy_iphy_power_off(struct intel_cbphy_iphy *iphy)
+{
+	struct intel_combo_phy *cbphy = iphy->parent;
+	struct device *dev = iphy->dev;
+	int ret;
+
+	ret = reset_control_assert(iphy->app_rst);
+	if (ret) {
+		dev_err(dev, "PHY(%u:%u) core assert failed!\n",
+			COMBO_PHY_ID(iphy), PHY_ID(iphy));
+		return ret;
+	}
+
+	ret = intel_cbphy_iphy_enable(iphy, false);
+	if (ret) {
+		dev_err(dev, "Failed disabling Phy core\n");
+		return ret;
+	}
+
+	if (!cbphy->init_cnt) {
+		clk_disable_unprepare(cbphy->core_clk);
+		intel_cbphy_rst_assert(cbphy);
+	}
+
+	return 0;
+}
+
+static int intel_cbphy_init(struct phy *phy)
+{
+	struct intel_cbphy_iphy *iphy = phy_get_drvdata(phy);
+	struct intel_combo_phy *cbphy = iphy->parent;
+	int ret;
+
+	mutex_lock(&cbphy->lock);
+	ret = intel_cbphy_iphy_cfg(iphy, intel_cbphy_iphy_power_on);
+	if (ret)
+		goto err;
+
+	if (cbphy->phy_mode == PHY_PCIE_MODE) {
+		ret = intel_cbphy_iphy_cfg(iphy, intel_cbphy_pcie_en_pad_refclk);
+		if (ret)
+			goto err;
+	}
+
+	cbphy->init_cnt++;
+
+err:
+	mutex_unlock(&cbphy->lock);
+
+	return ret;
+}
+
+static int intel_cbphy_exit(struct phy *phy)
+{
+	struct intel_cbphy_iphy *iphy = phy_get_drvdata(phy);
+	struct intel_combo_phy *cbphy = iphy->parent;
+	int ret;
+
+	mutex_lock(&cbphy->lock);
+	cbphy->init_cnt--;
+	if (cbphy->phy_mode == PHY_PCIE_MODE) {
+		ret = intel_cbphy_iphy_cfg(iphy, intel_cbphy_pcie_dis_pad_refclk);
+		if (ret)
+			goto err;
+	}
+
+	ret = intel_cbphy_iphy_cfg(iphy, intel_cbphy_iphy_power_off);
+
+err:
+	mutex_unlock(&cbphy->lock);
+
+	return ret;
+}
+
+static int intel_cbphy_calibrate(struct phy *phy)
+{
+	struct intel_cbphy_iphy *iphy = phy_get_drvdata(phy);
+	struct intel_combo_phy *cbphy = iphy->parent;
+	void __iomem *cr_base = cbphy->cr_base;
+	struct device *dev = iphy->dev;
+	int val, ret, id;
+
+	if (cbphy->phy_mode != PHY_XPCS_MODE)
+		return 0;
+
+	id = PHY_ID(iphy);
+
+	/* trigger auto RX adaptation */
+	combo_phy_w32_off_mask(cr_base, CR_ADDR(PCS_XF_ATE_OVRD_IN_2, id),
+			       ADAPT_REQ_MSK, 3);
+	/* Wait RX adaptation to finish */
+	ret = readl_poll_timeout(cr_base + CR_ADDR(PCS_XF_RX_ADAPT_ACK, id),
+				 val, val & RX_ADAPT_ACK_BIT, 10, 5000);
+	if (ret)
+		dev_err(dev, "RX Adaptation failed!\n");
+	else
+		dev_info(dev, "RX Adaptation success!\n");
+
+	/* Stop RX adaptation */
+	combo_phy_w32_off_mask(cr_base, CR_ADDR(PCS_XF_ATE_OVRD_IN_2, id),
+			       ADAPT_REQ_MSK, 0);
+
+	return ret;
+}
+
+static int intel_cbphy_iphy_dt_parse(struct intel_combo_phy *cbphy,
+				     struct fwnode_handle *fwnode, int idx)
+{
+	struct intel_cbphy_iphy *iphy = &cbphy->iphy[idx];
+	struct device *dev;
+	int ret;
+
+	dev = get_dev_from_fwnode(fwnode);
+	iphy->parent = cbphy;
+	iphy->dev = dev;
+	iphy->id = idx;
+
+	iphy->app_rst = devm_reset_control_get_optional(dev, NULL);
+	if (IS_ERR(iphy->app_rst)) {
+		ret = PTR_ERR(iphy->app_rst);
+		if (ret != -EPROBE_DEFER) {
+			dev_err(dev, "PHY[%u:%u] Get reset ctrl Err!\n",
+				COMBO_PHY_ID(iphy), PHY_ID(iphy));
+		}
+
+		return ret;
+	}
+
+	iphy->enable = true;
+
+	return 0;
+}
+
+static int intel_cbphy_dt_sanity_check(struct intel_combo_phy *cbphy)
+{
+	struct intel_cbphy_iphy *iphy0, *iphy1;
+
+	iphy0 = &cbphy->iphy[PHY_0];
+	iphy1 = &cbphy->iphy[PHY_1];
+
+	if (!iphy0->enable && !iphy1->enable) {
+		dev_err(cbphy->dev, "CBPHY%u both PHY disabled!\n", cbphy->id);
+		return -EINVAL;
+	}
+
+	if (cbphy->aggr_mode == PHY_DL_MODE &&
+	    (!iphy0->enable || !iphy1->enable)) {
+		dev_err(cbphy->dev,
+			"Dual lane mode but lane0: %s, lane1: %s\n",
+			iphy0->enable ? "on" : "off",
+			iphy1->enable ? "on" : "off");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int intel_cbphy_dt_parse(struct intel_combo_phy *cbphy)
+{
+	struct fwnode_reference_args ref;
+	struct device *dev = cbphy->dev;
+	struct fwnode_handle *fwnode;
+	struct platform_device *pdev;
+	int i, ret;
+	u32 prop;
+
+	cbphy->core_clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(cbphy->core_clk)) {
+		ret = PTR_ERR(cbphy->core_clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "CBPHY get clk failed:%d!\n", ret);
+		return ret;
+	}
+
+	cbphy->phy_rst = devm_reset_control_get_optional(dev, "phy");
+	if (IS_ERR(cbphy->phy_rst)) {
+		ret = PTR_ERR(cbphy->phy_rst);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Get phy reset err: %d!\n", ret);
+		return ret;
+	}
+
+	cbphy->core_rst = devm_reset_control_get_optional(dev, "core");
+	if (IS_ERR(cbphy->core_rst)) {
+		ret = PTR_ERR(cbphy->core_rst);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Get combo reset err: %d!\n", ret);
+		return ret;
+	}
+
+	pdev = to_platform_device(dev);
+	cbphy->app_base = devm_platform_ioremap_resource_byname(pdev, "app");
+	if (IS_ERR(cbphy->app_base))
+		return PTR_ERR(cbphy->app_base);
+
+	cbphy->cr_base = devm_platform_ioremap_resource_byname(pdev, "core");
+	if (IS_ERR(cbphy->cr_base))
+		return PTR_ERR(cbphy->cr_base);
+
+	fwnode = dev_fwnode(dev);
+	ret = fwnode_property_get_reference_args(fwnode, "intel,syscfg", NULL,
+						 1, 0, &ref);
+	if (ret < 0)
+		return ret;
+
+	cbphy->id = ref.args[0];
+	cbphy->syscfg = fwnode_to_regmap(ref.fwnode);
+	fwnode_handle_put(ref.fwnode);
+
+	ret = fwnode_property_get_reference_args(fwnode, "intel,hsio", NULL, 1,
+						 0, &ref);
+	if (ret < 0)
+		return ret;
+
+	cbphy->bid = ref.args[0];
+	cbphy->hsiocfg = fwnode_to_regmap(ref.fwnode);
+	fwnode_handle_put(ref.fwnode);
+
+	ret = fwnode_property_read_u32_array(fwnode, "intel,phy-mode", &prop, 1);
+	if (ret)
+		return ret;
+
+	if (prop >= PHY_MAX_MODE) {
+		dev_err(dev, "Invalid phy mode: %u\n", prop);
+		return -EINVAL;
+	}
+
+	cbphy->phy_mode = prop;
+	cbphy->clk_rate = intel_iphy_clk_rates[cbphy->phy_mode];
+
+	if (fwnode_property_present(fwnode, "intel,aggregation"))
+		cbphy->aggr_mode = PHY_DL_MODE;
+	else
+		cbphy->aggr_mode = PHY_SL_MODE;
+
+	ret = devm_of_platform_populate(dev);
+	if (ret) {
+		dev_err(dev, "Failed to populate child nodes: %d\n", ret);
+		return ret;
+	}
+
+	i = 0;
+	fwnode_for_each_available_child_node(dev_fwnode(dev), fwnode) {
+		if (i >= PHY_MAX_NUM) {
+			fwnode_handle_put(fwnode);
+			dev_err(dev, "Error: DT child number larger than %d\n",
+				PHY_MAX_NUM);
+			return -EINVAL;
+		}
+
+		ret = intel_cbphy_iphy_dt_parse(cbphy, fwnode, i);
+		if (ret) {
+			fwnode_handle_put(fwnode);
+			return ret;
+		}
+
+		i++;
+	}
+
+	return intel_cbphy_dt_sanity_check(cbphy);
+}
+
+static const struct phy_ops intel_cbphy_ops = {
+	.init =		intel_cbphy_init,
+	.exit =		intel_cbphy_exit,
+	.calibrate =	intel_cbphy_calibrate,
+	.owner =	THIS_MODULE,
+};
+
+static int intel_cbphy_iphy_create(struct intel_cbphy_iphy *iphy)
+{
+	struct intel_combo_phy *cbphy = iphy->parent;
+	struct phy_provider *phy_provider;
+	struct device *dev = iphy->dev;
+	struct phy *phy;
+
+	/* In dual mode skip phy creation for the second phy */
+	if (cbphy->aggr_mode == PHY_DL_MODE && iphy->id)
+		return 0;
+
+	phy = devm_phy_create(dev, NULL, &intel_cbphy_ops);
+	if (IS_ERR(phy)) {
+		dev_err(dev, "PHY[%u:%u]: create PHY instance failed!\n",
+			COMBO_PHY_ID(iphy), PHY_ID(iphy));
+		return PTR_ERR(phy);
+	}
+
+	phy_set_drvdata(phy, iphy);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider)) {
+		dev_err(dev, "PHY[%u:%u]: register phy provider failed!\n",
+			COMBO_PHY_ID(iphy), PHY_ID(iphy));
+	}
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static int intel_cbphy_create(struct intel_combo_phy *cbphy)
+{
+	struct intel_cbphy_iphy *iphy;
+	int i, ret;
+
+	for (i = 0; i < PHY_MAX_NUM; i++) {
+		iphy = &cbphy->iphy[i];
+		if (iphy->enable) {
+			ret = intel_cbphy_iphy_create(iphy);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int intel_cbphy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct intel_combo_phy *cbphy;
+	int ret;
+
+	cbphy = devm_kzalloc(dev, sizeof(*cbphy), GFP_KERNEL);
+	if (!cbphy)
+		return -ENOMEM;
+
+	cbphy->dev = dev;
+	cbphy->init_cnt = 0;
+	mutex_init(&cbphy->lock);
+	platform_set_drvdata(pdev, cbphy);
+	ret = intel_cbphy_dt_parse(cbphy);
+	if (ret)
+		return ret;
+
+	return intel_cbphy_create(cbphy);
+}
+
+static int intel_cbphy_remove(struct platform_device *pdev)
+{
+	struct intel_combo_phy *cbphy = platform_get_drvdata(pdev);
+
+	intel_cbphy_rst_assert(cbphy);
+	clk_disable_unprepare(cbphy->core_clk);
+	return 0;
+}
+
+static const struct of_device_id of_intel_cbphy_match[] = {
+	{ .compatible = "intel,combo-phy" },
+	{ .compatible = "intel,combophy-lgm" },
+	{}
+};
+
+static struct platform_driver intel_cbphy_driver = {
+	.probe = intel_cbphy_probe,
+	.remove = intel_cbphy_remove,
+	.driver = {
+		.name = "intel-combo-phy",
+		.of_match_table = of_intel_cbphy_match,
+	}
+};
+
+module_platform_driver(intel_cbphy_driver);
+
+MODULE_DESCRIPTION("Intel Combo-phy driver");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

