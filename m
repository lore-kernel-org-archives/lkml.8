Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB076C3F2CE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40CD20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbgCPKhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:37:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:26973 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730497AbgCPKhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:37:50 -0400
IronPort-SDR: sbCteuD/nhCsAE1CircgkTC/qsvG7ZeW3uhEbRJc2ExfXqTrpG5qPdFzdgKIKWO4KSLEwR3/y2
 DRwwvLc6dVxQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 03:37:50 -0700
IronPort-SDR: gFwou/57le0NTu39jsUAN1FulRBhsf48NWxdSpRLbz7q/j9AsGu1NJOyYfnFS39DmqnigOXOgu
 yBQg9Kh7pVrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,560,1574150400"; 
   d="scan'208";a="267522708"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by fmsmga004.fm.intel.com with ESMTP; 16 Mar 2020 03:37:48 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH 2/2] phy: intel: Add Keem Bay eMMC PHY support
Date:   Mon, 16 Mar 2020 18:37:26 +0800
Message-Id: <20200316103726.16339-3-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200316103726.16339-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200316103726.16339-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for eMMC PHY on Intel Keem Bay SoC.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 drivers/phy/intel/Kconfig            |   7 +
 drivers/phy/intel/Makefile           |   1 +
 drivers/phy/intel/phy-keembay-emmc.c | 231 +++++++++++++++++++++++++++
 3 files changed, 239 insertions(+)
 create mode 100644 drivers/phy/intel/phy-keembay-emmc.c

diff --git a/drivers/phy/intel/Kconfig b/drivers/phy/intel/Kconfig
index 4ea6a8897cd7..56dc4d817c5f 100644
--- a/drivers/phy/intel/Kconfig
+++ b/drivers/phy/intel/Kconfig
@@ -7,3 +7,10 @@ config PHY_INTEL_EMMC
 	select GENERIC_PHY
 	help
 	  Enable this to support the Intel EMMC PHY
+
+config PHY_KEEMBAY_EMMC
+	tristate "Intel Keem Bay EMMC PHY Driver"
+	depends on OF
+	select GENERIC_PHY
+	help
+	  Enable this to support the Keem Bay EMMC PHY.
diff --git a/drivers/phy/intel/Makefile b/drivers/phy/intel/Makefile
index 6b876a75599d..bdf769671198 100644
--- a/drivers/phy/intel/Makefile
+++ b/drivers/phy/intel/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PHY_INTEL_EMMC)            += phy-intel-emmc.o
+obj-$(CONFIG_PHY_KEEMBAY_EMMC)		+= phy-keembay-emmc.o
diff --git a/drivers/phy/intel/phy-keembay-emmc.c b/drivers/phy/intel/phy-keembay-emmc.c
new file mode 100644
index 000000000000..490c0f79dc8d
--- /dev/null
+++ b/drivers/phy/intel/phy-keembay-emmc.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Keem Bay eMMC PHY driver
+ * Copyright (C) 2019 Intel Corporation
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+/* eMMC/SD/SDIO core/phy configuration registers */
+#define PHY_CFG_0		0x24
+#define  SEL_DLY_TXCLK_MASK	BIT(29)
+#define  SEL_DLY_TXCLK_SHIFT	29
+#define  OTAP_DLY_ENA_MASK	BIT(27)
+#define  OTAP_DLY_ENA_SHIFT	27
+#define  OTAP_DLY_SEL_MASK	GENMASK(26, 23)
+#define  OTAP_DLY_SEL_SHIFT	23
+#define  DLL_EN_MASK		BIT(10)
+#define  DLL_EN_SHIFT		10
+#define  PWR_DOWN_MASK		BIT(0)
+#define  PWR_DOWN_SHIFT		0
+
+#define PHY_CFG_2		0x2c
+#define  SEL_FREQ_MASK		GENMASK(12, 10)
+#define  SEL_FREQ_SHIFT		10
+
+#define PHY_STAT		0x40
+#define  CAL_DONE		BIT(6)
+#define  DLL_RDY		BIT(5)
+
+/* From ACS_eMMC51_16nFFC_RO1100_Userguide_v1p0.pdf p17 */
+#define FREQSEL_200M_170M	0x0
+#define FREQSEL_170M_140M	0x1
+#define FREQSEL_140M_110M	0x2
+#define FREQSEL_110M_80M	0x3
+#define FREQSEL_80M_50M		0x4
+
+struct keembay_emmc_phy {
+	struct regmap	*reg_base;
+	struct clk	*emmcclk;
+};
+
+static int keembay_emmc_phy_power(struct phy *phy, bool power_on)
+{
+	struct keembay_emmc_phy *kmb_phy = phy_get_drvdata(phy);
+	unsigned int freqsel = FREQSEL_200M_170M;
+	unsigned long rate;
+	u32 val;
+	int ret;
+
+	regmap_update_bits(kmb_phy->reg_base, PHY_CFG_0, PWR_DOWN_MASK,
+			   (0x0 << PWR_DOWN_SHIFT) & PWR_DOWN_MASK);
+	regmap_update_bits(kmb_phy->reg_base, PHY_CFG_0, DLL_EN_MASK,
+			   (0x0 << DLL_EN_SHIFT) & DLL_EN_MASK);
+
+	if (!power_on)
+		return 0;
+
+	rate = clk_get_rate(kmb_phy->emmcclk);
+
+	if (rate != 0) {
+		switch (rate) {
+		case 170000001 ... 200000000:
+			freqsel = FREQSEL_200M_170M;
+			break;
+		case 140000001 ... 170000000:
+			freqsel = FREQSEL_170M_140M;
+			break;
+		case 110000001 ... 140000000:
+			freqsel = FREQSEL_140M_110M;
+			break;
+		case 80000001 ... 110000000:
+			freqsel = FREQSEL_110M_80M;
+			break;
+		case 50000000 ... 80000000:
+			freqsel = FREQSEL_80M_50M;
+			break;
+		default:
+			break;
+		}
+
+		if ((rate < 50000000) || (rate > 200000000))
+			dev_warn(&phy->dev, "Unsupported rate: %lu\n", rate);
+	}
+
+	udelay(5);
+
+	regmap_update_bits(kmb_phy->reg_base, PHY_CFG_0, PWR_DOWN_MASK,
+			   (0x1 << PWR_DOWN_SHIFT) & PWR_DOWN_MASK);
+
+	ret = regmap_read_poll_timeout(kmb_phy->reg_base, PHY_STAT,
+				       val, (val & CAL_DONE),
+				       0, 50 * USEC_PER_MSEC);
+	if (ret) {
+		dev_err(&phy->dev, "caldone failed, ret=%d\n", ret);
+		return ret;
+	}
+
+	/* Set the frequency of the DLL operation */
+	regmap_update_bits(kmb_phy->reg_base, PHY_CFG_2, SEL_FREQ_MASK,
+			   (freqsel << SEL_FREQ_SHIFT) & SEL_FREQ_MASK);
+
+	/* Enable DLL */
+	regmap_update_bits(kmb_phy->reg_base, PHY_CFG_0, DLL_EN_MASK,
+			   (0x1 << DLL_EN_SHIFT) & DLL_EN_MASK);
+
+	if (rate == 0)
+		return 0;
+
+	ret = regmap_read_poll_timeout(kmb_phy->reg_base, PHY_STAT,
+				       val, (val & DLL_RDY),
+				       0, 50 * USEC_PER_MSEC);
+	if (ret) {
+		dev_err(&phy->dev, "dllrdy failed, ret=%d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int keembay_emmc_phy_init(struct phy *phy)
+{
+	struct keembay_emmc_phy *kmb_phy = phy_get_drvdata(phy);
+
+	kmb_phy->emmcclk = clk_get(&phy->dev, "emmcclk");
+	if (IS_ERR(kmb_phy->emmcclk)) {
+		dev_dbg(&phy->dev, "Error getting emmcclk\n");
+		kmb_phy->emmcclk = NULL;
+	}
+
+	return 0;
+}
+
+static int keembay_emmc_phy_exit(struct phy *phy)
+{
+	struct keembay_emmc_phy *kmb_phy = phy_get_drvdata(phy);
+
+	clk_put(kmb_phy->emmcclk);
+
+	return 0;
+};
+
+static int keembay_emmc_phy_power_on(struct phy *phy)
+{
+	struct keembay_emmc_phy *kmb_phy = phy_get_drvdata(phy);
+
+	/* Select the Delay chain based txclk */
+	regmap_update_bits(kmb_phy->reg_base, PHY_CFG_0, SEL_DLY_TXCLK_MASK,
+			   (0x1 << SEL_DLY_TXCLK_SHIFT) & SEL_DLY_TXCLK_MASK);
+
+	/* Output TAP Delay Enable */
+	regmap_update_bits(kmb_phy->reg_base, PHY_CFG_0, OTAP_DLY_ENA_MASK,
+			   (0x1 << OTAP_DLY_ENA_SHIFT) & OTAP_DLY_ENA_MASK);
+
+	/* Output TAP Delay Select */
+	regmap_update_bits(kmb_phy->reg_base, PHY_CFG_0, OTAP_DLY_SEL_MASK,
+			   (0x2 << OTAP_DLY_SEL_SHIFT) & OTAP_DLY_SEL_MASK);
+
+	return keembay_emmc_phy_power(phy, 1);
+}
+
+static int keembay_emmc_phy_power_off(struct phy *phy)
+{
+	return keembay_emmc_phy_power(phy, 0);
+}
+
+static const struct phy_ops ops = {
+	.init		= keembay_emmc_phy_init,
+	.exit		= keembay_emmc_phy_exit,
+	.power_on	= keembay_emmc_phy_power_on,
+	.power_off	= keembay_emmc_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static int keembay_emmc_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct keembay_emmc_phy *kmb_phy;
+	struct phy *generic_phy;
+	struct phy_provider *phy_provider;
+
+	if (!dev->parent || !dev->parent->of_node)
+		return -ENODEV;
+
+	kmb_phy = devm_kzalloc(dev, sizeof(*kmb_phy), GFP_KERNEL);
+	if (!kmb_phy)
+		return -ENOMEM;
+
+	kmb_phy->reg_base = syscon_regmap_lookup_by_phandle(dev->of_node,
+							    "intel,syscon");
+	if (IS_ERR(kmb_phy->reg_base)) {
+		dev_err(dev, "failed to find syscon\n");
+		return PTR_ERR(kmb_phy->reg_base);
+	}
+
+	generic_phy = devm_phy_create(dev, dev->of_node, &ops);
+	if (IS_ERR(generic_phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(generic_phy);
+	}
+
+	phy_set_drvdata(generic_phy, kmb_phy);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id keembay_emmc_phy_of_match[] = {
+	{ .compatible = "intel,keembay-emmc-phy" },
+	{}
+};
+
+static struct platform_driver keembay_emmc_phy_driver = {
+	.probe		= keembay_emmc_phy_probe,
+	.driver		= {
+		.name	= "keembay-emmc-phy",
+		.of_match_table = keembay_emmc_phy_of_match,
+	},
+};
+module_platform_driver(keembay_emmc_phy_driver);
+
+MODULE_AUTHOR("Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>");
+MODULE_DESCRIPTION("Keem Bay EMMC PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

