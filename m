Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93138C2D0E1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A2D204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgIJRa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:30:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54602 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgIJR2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:28:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5E5D929BB0D
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, fparent@baylibre.com,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        weiyi.lu@mediatek.com, Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 02/12] soc: mediatek: Add MediaTek SCPSYS power domains
Date:   Thu, 10 Sep 2020 19:28:16 +0200
Message-Id: <20200910172826.3074357-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910172826.3074357-1-enric.balletbo@collabora.com>
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The System Control Processor System (SCPSYS) has several power management
related tasks in the system. This driver implements support to handle
the different power domains supported in order to meet high performance
and low power requirements.

Co-developed-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/soc/mediatek/Kconfig          |  13 +
 drivers/soc/mediatek/Makefile         |   1 +
 drivers/soc/mediatek/mtk-pm-domains.c | 626 ++++++++++++++++++++++++++
 3 files changed, 640 insertions(+)
 create mode 100644 drivers/soc/mediatek/mtk-pm-domains.c

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index 59a56cd790ec..68d800f9e4a5 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -44,6 +44,19 @@ config MTK_SCPSYS
 	  Say yes here to add support for the MediaTek SCPSYS power domain
 	  driver.
 
+config MTK_SCPSYS_PM_DOMAINS
+	bool "MediaTek SCPSYS generic power domain"
+	default ARCH_MEDIATEK
+	depends on PM
+	depends on MTK_INFRACFG
+	select PM_GENERIC_DOMAINS
+	select REGMAP
+	help
+	  Say y here to enable power domain support.
+	  In order to meet high performance and low power requirements, the System
+	  Control Processor System (SCPSYS) has several power management related
+	  tasks in the system.
+
 config MTK_MMSYS
 	bool "MediaTek MMSYS Support"
 	default ARCH_MEDIATEK
diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
index 01f9f873634a..1e60fb4f89d4 100644
--- a/drivers/soc/mediatek/Makefile
+++ b/drivers/soc/mediatek/Makefile
@@ -3,4 +3,5 @@ obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
 obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
 obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
 obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
+obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) += mtk-pm-domains.o
 obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
new file mode 100644
index 000000000000..db631dbaf2e3
--- /dev/null
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -0,0 +1,626 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020 Collabora Ltd.
+ */
+#include <linux/clk.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_clk.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/soc/mediatek/infracfg.h>
+
+#include <dt-bindings/power/mt8173-power.h>
+
+#define MTK_POLL_DELAY_US   10
+#define MTK_POLL_TIMEOUT    USEC_PER_SEC
+
+#define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
+#define MTK_SCPD_FWAIT_SRAM		BIT(1)
+#define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
+
+#define SPM_VDE_PWR_CON			0x0210
+#define SPM_MFG_PWR_CON			0x0214
+#define SPM_VEN_PWR_CON			0x0230
+#define SPM_ISP_PWR_CON			0x0238
+#define SPM_DIS_PWR_CON			0x023c
+#define SPM_VEN2_PWR_CON		0x0298
+#define SPM_AUDIO_PWR_CON		0x029c
+#define SPM_MFG_2D_PWR_CON		0x02c0
+#define SPM_MFG_ASYNC_PWR_CON		0x02c4
+#define SPM_USB_PWR_CON			0x02cc
+
+#define SPM_PWR_STATUS			0x060c
+#define SPM_PWR_STATUS_2ND		0x0610
+
+#define PWR_RST_B_BIT			BIT(0)
+#define PWR_ISO_BIT			BIT(1)
+#define PWR_ON_BIT			BIT(2)
+#define PWR_ON_2ND_BIT			BIT(3)
+#define PWR_CLK_DIS_BIT			BIT(4)
+
+#define PWR_STATUS_DISP			BIT(3)
+#define PWR_STATUS_MFG			BIT(4)
+#define PWR_STATUS_ISP			BIT(5)
+#define PWR_STATUS_VDEC			BIT(7)
+#define PWR_STATUS_VENC_LT		BIT(20)
+#define PWR_STATUS_VENC			BIT(21)
+#define PWR_STATUS_MFG_2D		BIT(22)
+#define PWR_STATUS_MFG_ASYNC		BIT(23)
+#define PWR_STATUS_AUDIO		BIT(24)
+#define PWR_STATUS_USB			BIT(25)
+
+struct scpsys_bus_prot_data {
+	u32 bus_prot_mask;
+	bool bus_prot_reg_update;
+};
+
+/**
+ * struct scpsys_domain_data - scp domain data for power on/off flow
+ * @sta_mask: The mask for power on/off status bit.
+ * @ctl_offs: The offset for main power control register.
+ * @sram_pdn_bits: The mask for sram power control bits.
+ * @sram_pdn_ack_bits: The mask for sram power control acked bits.
+ * @caps: The flag for active wake-up action.
+ * @bp_infracfg: bus protection for infracfg subsystem
+ */
+struct scpsys_domain_data {
+	u32 sta_mask;
+	int ctl_offs;
+	u32 sram_pdn_bits;
+	u32 sram_pdn_ack_bits;
+	u8 caps;
+	const struct scpsys_bus_prot_data bp_infracfg;
+};
+
+struct scpsys_domain {
+	struct generic_pm_domain genpd;
+	const struct scpsys_domain_data *data;
+	struct scpsys *scpsys;
+	int num_clks;
+	struct clk_bulk_data *clks;
+	struct regmap *infracfg;
+};
+
+struct scpsys_soc_data {
+	const struct scpsys_domain_data *domains;
+	int num_domains;
+	int pwr_sta_offs;
+	int pwr_sta2nd_offs;
+};
+
+struct scpsys {
+	struct device *dev;
+	void __iomem *base;
+	const struct scpsys_soc_data *soc_data;
+	struct genpd_onecell_data pd_data;
+	struct generic_pm_domain *domains[];
+};
+
+#define to_scpsys_domain(gpd) container_of(gpd, struct scpsys_domain, genpd)
+
+static int scpsys_domain_is_on(struct scpsys_domain *pd)
+{
+	struct scpsys *scpsys = pd->scpsys;
+
+	u32 status = readl(scpsys->base + scpsys->soc_data->pwr_sta_offs) & pd->data->sta_mask;
+	u32 status2 = readl(scpsys->base + scpsys->soc_data->pwr_sta2nd_offs) & pd->data->sta_mask;
+
+	/*
+	 * A domain is on when both status bits are set. If only one is set
+	 * return an error. This happens while powering up a domain
+	 */
+
+	if (status && status2)
+		return true;
+	if (!status && !status2)
+		return false;
+
+	return -EINVAL;
+}
+
+static int scpsys_sram_enable(struct scpsys_domain *pd, void __iomem *ctl_addr)
+{
+	u32 pdn_ack = pd->data->sram_pdn_ack_bits;
+	u32 val;
+	int tmp;
+	int ret;
+
+	val = readl(ctl_addr);
+	val &= ~pd->data->sram_pdn_bits;
+	writel(val, ctl_addr);
+
+	/* Either wait until SRAM_PDN_ACK all 1 or 0 */
+	ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0, MTK_POLL_DELAY_US,
+				 MTK_POLL_TIMEOUT);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int scpsys_sram_disable(struct scpsys_domain *pd, void __iomem *ctl_addr)
+{
+	u32 pdn_ack = pd->data->sram_pdn_ack_bits;
+	u32 val;
+	int tmp;
+
+	val = readl(ctl_addr);
+	val |= pd->data->sram_pdn_bits;
+	writel(val, ctl_addr);
+
+	/* Either wait until SRAM_PDN_ACK all 1 or 0 */
+	return readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == pdn_ack, MTK_POLL_DELAY_US,
+				  MTK_POLL_TIMEOUT);
+}
+
+static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
+{
+	const struct scpsys_bus_prot_data *bp_data = &pd->data->bp_infracfg;
+
+	if (!bp_data->bus_prot_mask)
+		return 0;
+
+	return mtk_infracfg_set_bus_protection(pd->infracfg, bp_data->bus_prot_mask,
+					       bp_data->bus_prot_reg_update);
+}
+
+static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
+{
+	const struct scpsys_bus_prot_data *bp_data = &pd->data->bp_infracfg;
+
+	if (!bp_data->bus_prot_mask)
+		return 0;
+
+	return mtk_infracfg_clear_bus_protection(pd->infracfg, bp_data->bus_prot_mask,
+						 bp_data->bus_prot_reg_update);
+}
+
+static int scpsys_power_on(struct generic_pm_domain *genpd)
+{
+	struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
+	struct scpsys *scpsys = pd->scpsys;
+	void __iomem *ctl_addr = scpsys->base + pd->data->ctl_offs;
+	int ret, tmp;
+	u32 val;
+
+	ret = clk_bulk_enable(pd->num_clks, pd->clks);
+	if (ret)
+		return ret;
+
+	/* subsys power on */
+	val = readl(ctl_addr);
+	val |= PWR_ON_BIT;
+	writel(val, ctl_addr);
+	val |= PWR_ON_2ND_BIT;
+	writel(val, ctl_addr);
+
+	/* wait until PWR_ACK = 1 */
+	ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, tmp > 0, MTK_POLL_DELAY_US,
+				 MTK_POLL_TIMEOUT);
+	if (ret < 0)
+		goto err_pwr_ack;
+
+	val &= ~PWR_CLK_DIS_BIT;
+	writel(val, ctl_addr);
+
+	val &= ~PWR_ISO_BIT;
+	writel(val, ctl_addr);
+
+	val |= PWR_RST_B_BIT;
+	writel(val, ctl_addr);
+
+	ret = scpsys_sram_enable(pd, ctl_addr);
+	if (ret < 0)
+		goto err_pwr_ack;
+
+	ret = scpsys_bus_protect_disable(pd);
+	if (ret < 0)
+		goto err_pwr_ack;
+
+	return 0;
+
+err_pwr_ack:
+	clk_bulk_disable(pd->num_clks, pd->clks);
+	dev_err(scpsys->dev, "Failed to power on domain %s\n", genpd->name);
+
+	return ret;
+}
+
+static int scpsys_power_off(struct generic_pm_domain *genpd)
+{
+	struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
+	struct scpsys *scpsys = pd->scpsys;
+	void __iomem *ctl_addr = scpsys->base + pd->data->ctl_offs;
+	int ret, tmp;
+	u32 val;
+
+	ret = scpsys_bus_protect_enable(pd);
+	if (ret < 0)
+		return ret;
+
+	ret = scpsys_sram_disable(pd, ctl_addr);
+	if (ret < 0)
+		return ret;
+
+	/* subsys power off */
+	val = readl(ctl_addr);
+	val |= PWR_ISO_BIT;
+	writel(val, ctl_addr);
+
+	val &= ~PWR_RST_B_BIT;
+	writel(val, ctl_addr);
+
+	val |= PWR_CLK_DIS_BIT;
+	writel(val, ctl_addr);
+
+	val &= ~PWR_ON_BIT;
+	writel(val, ctl_addr);
+
+	val &= ~PWR_ON_2ND_BIT;
+	writel(val, ctl_addr);
+
+	/* wait until PWR_ACK = 0 */
+	ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, tmp == 0, MTK_POLL_DELAY_US,
+				 MTK_POLL_TIMEOUT);
+	if (ret < 0)
+		return ret;
+
+	clk_bulk_disable(pd->num_clks, pd->clks);
+
+	return 0;
+}
+
+static int scpsys_add_one_domain(struct scpsys *scpsys, struct device_node *node)
+{
+	const struct scpsys_domain_data *domain_data;
+	struct scpsys_domain *pd;
+	int i, ret;
+	u32 id;
+
+	ret = of_property_read_u32(node, "reg", &id);
+	if (ret) {
+		dev_err(scpsys->dev, "%pOFn: failed to retrieve domain id from reg: %d\n", node,
+			ret);
+		return -EINVAL;
+	}
+
+	if (id >= scpsys->soc_data->num_domains) {
+		dev_err(scpsys->dev, "%pOFn: invalid domain id %d\n", node, id);
+		return -EINVAL;
+	}
+
+	domain_data = &scpsys->soc_data->domains[id];
+	if (!domain_data) {
+		dev_err(scpsys->dev, "%pOFn: undefined domain id %d\n", node, id);
+		return -EINVAL;
+	}
+
+	pd = devm_kzalloc(scpsys->dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+	pd->data = domain_data;
+	pd->scpsys = scpsys;
+
+	pd->infracfg = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg");
+	if (IS_ERR(pd->infracfg))
+		pd->infracfg = NULL;
+
+	pd->num_clks = of_clk_get_parent_count(node);
+	if (pd->num_clks > 0) {
+		pd->clks = devm_kcalloc(scpsys->dev, pd->num_clks, sizeof(*pd->clks), GFP_KERNEL);
+		if (!pd->clks)
+			return -ENOMEM;
+	} else {
+		pd->num_clks = 0;
+	}
+
+	for (i = 0; i < pd->num_clks; i++) {
+		pd->clks[i].clk = of_clk_get(node, i);
+		if (IS_ERR(pd->clks[i].clk)) {
+			ret = PTR_ERR(pd->clks[i].clk);
+			dev_err(scpsys->dev, "%pOFn: failed to get clk at index %d: %d\n", node, i,
+				ret);
+			return ret;
+		}
+	}
+
+	ret = clk_bulk_prepare(pd->num_clks, pd->clks);
+	if (ret)
+		goto err_put_clocks;
+
+	/*
+	 * Initially turn on all domains to make the domains usable
+	 * with !CONFIG_PM and to get the hardware in sync with the
+	 * software.  The unused domains will be switched off during
+	 * late_init time.
+	 */
+	ret = scpsys_power_on(&pd->genpd);
+	if (ret < 0) {
+		dev_err(scpsys->dev, "failed to power on domain %pOFN with error %d\n", node, ret);
+		goto err_unprepare_clocks;
+	}
+
+	pd->genpd.name = node->name;
+	pd->genpd.power_off = scpsys_power_off;
+	pd->genpd.power_on = scpsys_power_on;
+
+	pm_genpd_init(&pd->genpd, NULL, false);
+
+	scpsys->domains[id] = &pd->genpd;
+	return 0;
+
+err_unprepare_clocks:
+	clk_bulk_unprepare(pd->num_clks, pd->clks);
+err_put_clocks:
+	clk_bulk_put(pd->num_clks, pd->clks);
+	devm_kfree(scpsys->dev, pd->clks);
+	pd->num_clks = 0;
+	return ret;
+}
+
+static int scpsys_add_subdomain(struct scpsys *scpsys, struct device_node *parent)
+{
+	struct device_node *child;
+	struct generic_pm_domain *child_pd, *parent_pd;
+	int ret;
+
+	for_each_child_of_node(parent, child) {
+		u32 id;
+
+		ret = of_property_read_u32(parent, "reg", &id);
+		if (ret) {
+			dev_err(scpsys->dev, "%pOFn: failed to get parent domain id: %d\n", child,
+				ret);
+			goto err_put_node;
+		}
+		parent_pd = scpsys->pd_data.domains[id];
+
+		ret = scpsys_add_one_domain(scpsys, child);
+		if (ret) {
+			dev_err(scpsys->dev, "error adding power domain for %pOFn: %d\n", child,
+				ret);
+			goto err_put_node;
+		}
+
+		ret = of_property_read_u32(child, "reg", &id);
+		if (ret) {
+			dev_err(scpsys->dev, "%pOFn: failed to get child domain id: %d\n", child,
+				ret);
+			goto err_put_node;
+		}
+		child_pd = scpsys->pd_data.domains[id];
+
+		ret = pm_genpd_add_subdomain(parent_pd, child_pd);
+		if (ret) {
+			dev_err(scpsys->dev, "failed to add %s subdomain to parent %s\n",
+				child_pd->name, parent_pd->name);
+			goto err_put_node;
+		} else {
+			dev_dbg(scpsys->dev, "%s add subdomain: %s\n", parent_pd->name,
+				child_pd->name);
+		}
+
+		/* recursive call to add all subdomains */
+		ret = scpsys_add_subdomain(scpsys, child);
+		if (ret)
+			goto err_put_node;
+	}
+
+	return 0;
+
+err_put_node:
+	of_node_put(child);
+	return ret;
+}
+
+static void scpsys_remove_one_domain(struct scpsys_domain *pd)
+{
+	int ret;
+
+	/*
+	 * We're in the error cleanup already, so we only complain,
+	 * but won't emit another error on top of the original one.
+	 */
+	ret = pm_genpd_remove(&pd->genpd);
+	if (ret < 0)
+		dev_err(pd->scpsys->dev,
+			"failed to remove domain '%s' : %d - state may be inconsistent\n",
+			pd->genpd.name, ret);
+
+	scpsys_power_off(&pd->genpd);
+
+	clk_bulk_unprepare(pd->num_clks, pd->clks);
+	clk_bulk_put(pd->num_clks, pd->clks);
+	pd->num_clks = 0;
+}
+
+static void scpsys_domain_cleanup(struct scpsys *scpsys)
+{
+	struct generic_pm_domain *genpd;
+	struct scpsys_domain *pd;
+	int i;
+
+	for (i = scpsys->pd_data.num_domains - 1; i >= 0; i--) {
+		genpd = scpsys->pd_data.domains[i];
+		if (genpd) {
+			pd = to_scpsys_domain(genpd);
+			scpsys_remove_one_domain(pd);
+		}
+	}
+}
+
+/*
+ * MT8173 power domain support
+ */
+
+static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
+	[MT8173_POWER_DOMAIN_VDEC] = {
+		.sta_mask = PWR_STATUS_VDEC,
+		.ctl_offs = SPM_VDE_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT8173_POWER_DOMAIN_VENC] = {
+		.sta_mask = PWR_STATUS_VENC,
+		.ctl_offs = SPM_VEN_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+	},
+	[MT8173_POWER_DOMAIN_ISP] = {
+		.sta_mask = PWR_STATUS_ISP,
+		.ctl_offs = SPM_ISP_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+	},
+	[MT8173_POWER_DOMAIN_MM] = {
+		.sta_mask = PWR_STATUS_DISP,
+		.ctl_offs = SPM_DIS_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			.bus_prot_reg_update = true,
+			.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MM_M0 |
+				MT8173_TOP_AXI_PROT_EN_MM_M1,
+		},
+	},
+	[MT8173_POWER_DOMAIN_VENC_LT] = {
+		.sta_mask = PWR_STATUS_VENC_LT,
+		.ctl_offs = SPM_VEN2_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+	},
+	[MT8173_POWER_DOMAIN_AUDIO] = {
+		.sta_mask = PWR_STATUS_AUDIO,
+		.ctl_offs = SPM_AUDIO_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+	},
+	[MT8173_POWER_DOMAIN_USB] = {
+		.sta_mask = PWR_STATUS_USB,
+		.ctl_offs = SPM_USB_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8173_POWER_DOMAIN_MFG_ASYNC] = {
+		.sta_mask = PWR_STATUS_MFG_ASYNC,
+		.ctl_offs = SPM_MFG_ASYNC_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = 0,
+	},
+	[MT8173_POWER_DOMAIN_MFG_2D] = {
+		.sta_mask = PWR_STATUS_MFG_2D,
+		.ctl_offs = SPM_MFG_2D_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+	},
+	[MT8173_POWER_DOMAIN_MFG] = {
+		.sta_mask = PWR_STATUS_MFG,
+		.ctl_offs = SPM_MFG_PWR_CON,
+		.sram_pdn_bits = GENMASK(13, 8),
+		.sram_pdn_ack_bits = GENMASK(21, 16),
+		.bp_infracfg = {
+			.bus_prot_reg_update = true,
+			.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MFG_S |
+				MT8173_TOP_AXI_PROT_EN_MFG_M0 |
+				MT8173_TOP_AXI_PROT_EN_MFG_M1 |
+				MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT,
+		},
+	},
+};
+
+static const struct scpsys_soc_data mt8173_scpsys_data = {
+	.domains = scpsys_domain_data_mt8173,
+	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8173),
+	.pwr_sta_offs = SPM_PWR_STATUS,
+	.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+};
+
+static const struct of_device_id scpsys_of_match[] = {
+	{
+		.compatible = "mediatek,mt8173-power-controller",
+		.data = &mt8173_scpsys_data,
+	},
+	{ }
+};
+
+static int scpsys_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	const struct scpsys_soc_data *soc;
+	struct device_node *node;
+	struct scpsys *scpsys;
+	struct resource *res;
+	int ret;
+
+	soc = of_device_get_match_data(&pdev->dev);
+	if (!soc) {
+		dev_err(&pdev->dev, "no power controller data\n");
+		return -EINVAL;
+	}
+
+	scpsys = devm_kzalloc(dev, struct_size(scpsys, domains, soc->num_domains), GFP_KERNEL);
+	if (!scpsys)
+		return -ENOMEM;
+
+	scpsys->dev = dev;
+	scpsys->soc_data = soc;
+
+	scpsys->pd_data.domains = scpsys->domains;
+	scpsys->pd_data.num_domains = soc->num_domains;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	scpsys->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(scpsys->base))
+		return -ENODEV;
+
+	ret = -ENODEV;
+	for_each_available_child_of_node(np, node) {
+		ret = scpsys_add_one_domain(scpsys, node);
+		if (ret) {
+			dev_err(dev, "failed to handle node %pOFN: %d\n", node, ret);
+			of_node_put(node);
+			goto err_cleanup_domains;
+		}
+
+		ret = scpsys_add_subdomain(scpsys, node);
+		if (ret) {
+			dev_err(dev, "failed to add subdomain node %pOFn: %d\n", node, ret);
+			of_node_put(node);
+			goto err_cleanup_domains;
+		}
+	}
+
+	if (ret) {
+		dev_dbg(dev, "no power domains present\n");
+		return ret;
+	}
+
+	ret = of_genpd_add_provider_onecell(np, &scpsys->pd_data);
+	if (ret) {
+		dev_err(dev, "failed to add provider: %d\n", ret);
+		goto err_cleanup_domains;
+	}
+
+	return 0;
+
+err_cleanup_domains:
+	scpsys_domain_cleanup(scpsys);
+	return ret;
+}
+
+static struct platform_driver scpsys_pm_domain_driver = {
+	.probe = scpsys_probe,
+	.driver = {
+		.name = "mtk-power-controller",
+		.suppress_bind_attrs = true,
+		.of_match_table = scpsys_of_match,
+	},
+};
+builtin_platform_driver(scpsys_pm_domain_driver);
-- 
2.28.0

