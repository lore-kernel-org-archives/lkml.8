Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25F8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9820220732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgHULrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 07:47:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:14303 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728449AbgHULlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 07:41:42 -0400
IronPort-SDR: QZqb8XrmKpPQEdentr8+Ajf41lIDL3SIcseqORwRh2yxk84nVa3XM+7hVkPTBuzQjIhWF0N58n
 tw625bwh0YoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="143305586"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="143305586"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 04:39:47 -0700
IronPort-SDR: j3tMWjCZ7yArgHI4C3YcGcdse4+ljSeZDeqwZVL5gaFdct47Q32IjyvGLrEY4EOLGSKPNmNYxT
 i8D+kNMOP4Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="327740423"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2020 04:39:44 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        andriy.shevchenko@intel.com, eswara.kota@linux.intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v7 3/3] phy: intel: Add Keem Bay eMMC PHY support
Date:   Fri, 21 Aug 2020 19:37:47 +0800
Message-Id: <20200821113747.2912-4-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200821113747.2912-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200821113747.2912-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for eMMC PHY on Intel Keem Bay SoC.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 drivers/phy/intel/Kconfig                  |  12 +
 drivers/phy/intel/Makefile                 |   1 +
 drivers/phy/intel/phy-intel-keembay-emmc.c | 310 +++++++++++++++++++++
 3 files changed, 323 insertions(+)
 create mode 100644 drivers/phy/intel/phy-intel-keembay-emmc.c

diff --git a/drivers/phy/intel/Kconfig b/drivers/phy/intel/Kconfig
index db8586c3eed8..dad72fc64871 100644
--- a/drivers/phy/intel/Kconfig
+++ b/drivers/phy/intel/Kconfig
@@ -2,6 +2,18 @@
 #
 # Phy drivers for Intel platforms
 #
+config PHY_INTEL_KEEMBAY_EMMC
+	tristate "Intel Keem Bay EMMC PHY driver"
+	depends on ARM64 || COMPILE_TEST
+	depends on OF && HAS_IOMEM
+	select GENERIC_PHY
+	select REGMAP_MMIO
+	help
+	  Choose this option if you have an Intel Keem Bay SoC.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called phy-keembay-emmc.ko.
+
 config PHY_INTEL_LGM_COMBO
 	bool "Intel Lightning Mountain ComboPHY driver"
 	depends on X86 || COMPILE_TEST
diff --git a/drivers/phy/intel/Makefile b/drivers/phy/intel/Makefile
index 662385d0a366..a5e0af5ccd75 100644
--- a/drivers/phy/intel/Makefile
+++ b/drivers/phy/intel/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PHY_INTEL_KEEMBAY_EMMC)	+= phy-intel-keembay-emmc.o
 obj-$(CONFIG_PHY_INTEL_LGM_COMBO)	+= phy-intel-lgm-combo.o
 obj-$(CONFIG_PHY_INTEL_LGM_EMMC)	+= phy-intel-lgm-emmc.o
diff --git a/drivers/phy/intel/phy-intel-keembay-emmc.c b/drivers/phy/intel/phy-intel-keembay-emmc.c
new file mode 100644
index 000000000000..c1a095c17165
--- /dev/null
+++ b/drivers/phy/intel/phy-intel-keembay-emmc.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Keem Bay eMMC PHY driver
+ * Copyright (C) 2020 Intel Corporation
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
+#define  OTAP_DLY_ENA_MASK	BIT(27)
+#define  OTAP_DLY_SEL_MASK	GENMASK(26, 23)
+#define  DLL_EN_MASK		BIT(10)
+#define  PWR_DOWN_MASK		BIT(0)
+
+#define PHY_CFG_2		0x2c
+#define  SEL_FREQ_MASK		GENMASK(12, 10)
+
+#define PHY_STAT		0x40
+#define  CAL_DONE_MASK		BIT(6)
+#define  IS_CALDONE(x)		((x) & CAL_DONE_MASK)
+#define  DLL_RDY_MASK		BIT(5)
+#define  IS_DLLRDY(x)		((x) & DLL_RDY_MASK)
+
+/* From ACS_eMMC51_16nFFC_RO1100_Userguide_v1p0.pdf p17 */
+#define FREQSEL_200M_170M	0x0
+#define FREQSEL_170M_140M	0x1
+#define FREQSEL_140M_110M	0x2
+#define FREQSEL_110M_80M	0x3
+#define FREQSEL_80M_50M		0x4
+
+#define maskval(mask, val)	(((val) << (ffs(mask) - 1)) & mask)
+
+struct keembay_emmc_phy {
+	struct regmap *syscfg;
+	struct clk *emmcclk;
+};
+
+static const struct regmap_config keembay_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+static int keembay_emmc_phy_power(struct phy *phy, bool on_off)
+{
+	struct keembay_emmc_phy *priv = phy_get_drvdata(phy);
+	unsigned int caldone;
+	unsigned int dllrdy;
+	unsigned int freqsel;
+	unsigned int mhz;
+	int ret;
+
+	/*
+	 * Keep phyctrl_pdb and phyctrl_endll low to allow
+	 * initialization of CALIO state M/C DFFs
+	 */
+	ret = regmap_update_bits(priv->syscfg, PHY_CFG_0, PWR_DOWN_MASK,
+				 maskval(PWR_DOWN_MASK, 0));
+	if (ret) {
+		dev_err(&phy->dev, "CALIO power down bar failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(priv->syscfg, PHY_CFG_0, DLL_EN_MASK,
+				 maskval(DLL_EN_MASK, 0));
+	if (ret) {
+		dev_err(&phy->dev, "turn off the dll failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Already finish power off above */
+	if (!on_off)
+		return 0;
+
+	mhz = DIV_ROUND_CLOSEST(clk_get_rate(priv->emmcclk), 1000000);
+	if (mhz <= 200 && mhz >= 170)
+		freqsel = FREQSEL_200M_170M;
+	else if (mhz <= 170 && mhz >= 140)
+		freqsel = FREQSEL_170M_140M;
+	else if (mhz <= 140 && mhz >= 110)
+		freqsel = FREQSEL_140M_110M;
+	else if (mhz <= 110 && mhz >= 80)
+		freqsel = FREQSEL_110M_80M;
+	else if (mhz <= 80 && mhz >= 50)
+		freqsel = FREQSEL_80M_50M;
+	else
+		freqsel = 0x0;
+
+	if (mhz < 50 || mhz > 200)
+		dev_warn(&phy->dev, "Unsupported rate: %d MHz\n", mhz);
+
+	/*
+	 * According to the user manual, calpad calibration
+	 * cycle takes more than 2us without the minimal recommended
+	 * value, so we may need a little margin here
+	 */
+	udelay(5);
+
+	ret = regmap_update_bits(priv->syscfg, PHY_CFG_0, PWR_DOWN_MASK,
+				 maskval(PWR_DOWN_MASK, 1));
+	if (ret) {
+		dev_err(&phy->dev, "CALIO power down bar failed: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * According to the user manual, it asks driver to wait 5us for
+	 * calpad busy trimming. However it is documented that this value is
+	 * PVT(A.K.A. process, voltage and temperature) relevant, so some
+	 * failure cases are found which indicates we should be more tolerant
+	 * to calpad busy trimming.
+	 */
+	ret = regmap_read_poll_timeout(priv->syscfg, PHY_STAT,
+				       caldone, IS_CALDONE(caldone),
+				       0, 50);
+	if (ret) {
+		dev_err(&phy->dev, "caldone failed, ret=%d\n", ret);
+		return ret;
+	}
+
+	/* Set the frequency of the DLL operation */
+	ret = regmap_update_bits(priv->syscfg, PHY_CFG_2, SEL_FREQ_MASK,
+				 maskval(SEL_FREQ_MASK, freqsel));
+	if (ret) {
+		dev_err(&phy->dev, "set the frequency of dll failed:%d\n", ret);
+		return ret;
+	}
+
+	/* Turn on the DLL */
+	ret = regmap_update_bits(priv->syscfg, PHY_CFG_0, DLL_EN_MASK,
+				 maskval(DLL_EN_MASK, 1));
+	if (ret) {
+		dev_err(&phy->dev, "turn on the dll failed: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * We turned on the DLL even though the rate was 0 because we the
+	 * clock might be turned on later.  ...but we can't wait for the DLL
+	 * to lock when the rate is 0 because it will never lock with no
+	 * input clock.
+	 *
+	 * Technically we should be checking the lock later when the clock
+	 * is turned on, but for now we won't.
+	 */
+	if (mhz == 0)
+		return 0;
+
+	/*
+	 * After enabling analog DLL circuits docs say that we need 10.2 us if
+	 * our source clock is at 50 MHz and that lock time scales linearly
+	 * with clock speed. If we are powering on the PHY and the card clock
+	 * is super slow (like 100kHz) this could take as long as 5.1 ms as
+	 * per the math: 10.2 us * (50000000 Hz / 100000 Hz) => 5.1 ms
+	 * hopefully we won't be running at 100 kHz, but we should still make
+	 * sure we wait long enough.
+	 *
+	 * NOTE: There appear to be corner cases where the DLL seems to take
+	 * extra long to lock for reasons that aren't understood. In some
+	 * extreme cases we've seen it take up to over 10ms (!). We'll be
+	 * generous and give it 50ms.
+	 */
+	ret = regmap_read_poll_timeout(priv->syscfg, PHY_STAT,
+				       dllrdy, IS_DLLRDY(dllrdy),
+				       0, 50 * USEC_PER_MSEC);
+	if (ret)
+		dev_err(&phy->dev, "dllrdy failed, ret=%d\n", ret);
+
+	return ret;
+}
+
+static int keembay_emmc_phy_init(struct phy *phy)
+{
+	struct keembay_emmc_phy *priv = phy_get_drvdata(phy);
+
+	/*
+	 * We purposely get the clock here and not in probe to avoid the
+	 * circular dependency problem. We expect:
+	 * - PHY driver to probe
+	 * - SDHCI driver to start probe
+	 * - SDHCI driver to register it's clock
+	 * - SDHCI driver to get the PHY
+	 * - SDHCI driver to init the PHY
+	 *
+	 * The clock is optional, so upon any error just return it like
+	 * any other error to user.
+	 */
+	priv->emmcclk = clk_get_optional(&phy->dev, "emmcclk");
+
+	return PTR_ERR_OR_ZERO(priv->emmcclk);
+}
+
+static int keembay_emmc_phy_exit(struct phy *phy)
+{
+	struct keembay_emmc_phy *priv = phy_get_drvdata(phy);
+
+	clk_put(priv->emmcclk);
+
+	return 0;
+};
+
+static int keembay_emmc_phy_power_on(struct phy *phy)
+{
+	struct keembay_emmc_phy *priv = phy_get_drvdata(phy);
+	int ret;
+
+	/* Delay chain based txclk: enable */
+	ret = regmap_update_bits(priv->syscfg, PHY_CFG_0, SEL_DLY_TXCLK_MASK,
+				 maskval(SEL_DLY_TXCLK_MASK, 1));
+	if (ret) {
+		dev_err(&phy->dev, "ERROR: delay chain txclk set: %d\n", ret);
+		return ret;
+	}
+
+	/* Output tap delay: enable */
+	ret = regmap_update_bits(priv->syscfg, PHY_CFG_0, OTAP_DLY_ENA_MASK,
+				 maskval(OTAP_DLY_ENA_MASK, 1));
+	if (ret) {
+		dev_err(&phy->dev, "ERROR: output tap delay set: %d\n", ret);
+		return ret;
+	}
+
+	/* Output tap delay */
+	ret = regmap_update_bits(priv->syscfg, PHY_CFG_0, OTAP_DLY_SEL_MASK,
+				 maskval(OTAP_DLY_SEL_MASK, 2));
+	if (ret) {
+		dev_err(&phy->dev, "ERROR: output tap delay select: %d\n", ret);
+		return ret;
+	}
+
+	/* Power up eMMC phy analog blocks */
+	return keembay_emmc_phy_power(phy, true);
+}
+
+static int keembay_emmc_phy_power_off(struct phy *phy)
+{
+	/* Power down eMMC phy analog blocks */
+	return keembay_emmc_phy_power(phy, false);
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
+	struct device_node *np = dev->of_node;
+	struct keembay_emmc_phy *priv;
+	struct phy *generic_phy;
+	struct phy_provider *phy_provider;
+	void __iomem *base;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->syscfg = devm_regmap_init_mmio(dev, base, &keembay_regmap_config);
+	if (IS_ERR(priv->syscfg))
+		return PTR_ERR(priv->syscfg);
+
+	generic_phy = devm_phy_create(dev, np, &ops);
+	if (IS_ERR(generic_phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(generic_phy);
+	}
+
+	phy_set_drvdata(generic_phy, priv);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id keembay_emmc_phy_dt_ids[] = {
+	{ .compatible = "intel,keembay-emmc-phy" },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, keembay_emmc_phy_dt_ids);
+
+static struct platform_driver keembay_emmc_phy_driver = {
+	.probe		= keembay_emmc_phy_probe,
+	.driver		= {
+		.name	= "keembay-emmc-phy",
+		.of_match_table = keembay_emmc_phy_dt_ids,
+	},
+};
+module_platform_driver(keembay_emmc_phy_driver);
+
+MODULE_AUTHOR("Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>");
+MODULE_DESCRIPTION("Intel Keem Bay eMMC PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

