Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DEEC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05AEE20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbgEKT0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:26:17 -0400
Received: from v6.sk ([167.172.42.174]:52424 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731334AbgEKT0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:26:16 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 25C72610CF;
        Mon, 11 May 2020 19:25:43 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 10/10] clk: mmp2: Add support for power islands
Date:   Mon, 11 May 2020 21:25:17 +0200
Message-Id: <20200511192517.1206442-11-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511192517.1206442-1-lkundrak@v3.sk>
References: <20200511192517.1206442-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apart from the clocks and resets, the PMU hardware also controls power
to peripherals that are on separate power islands. On MMP2, that's the
GC860 GPU and the SSPA audio interface, while on MMP3 also the camera
interface is on a separate island, along with the pair of GC2000 and GC300
GPUs and the SSPA.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/mach-mmp/Kconfig     |   2 +
 drivers/clk/mmp/Makefile      |   2 +-
 drivers/clk/mmp/clk-of-mmp2.c |  42 +++++++++++++
 drivers/clk/mmp/clk.h         |  10 +++
 drivers/clk/mmp/pwr-island.c  | 115 ++++++++++++++++++++++++++++++++++
 5 files changed, 170 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mmp/pwr-island.c

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index b58a03b18bde..8a1519e6be6f 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -125,6 +125,8 @@ config MACH_MMP2_DT
 	select PINCTRL_SINGLE
 	select ARCH_HAS_RESET_CONTROLLER
 	select CPU_PJ4
+	select PM_GENERIC_DOMAINS if PM
+	select PM_GENERIC_DOMAINS_OF if PM && OF
 	help
 	  Include support for Marvell MMP2 based platforms using
 	  the device tree.
diff --git a/drivers/clk/mmp/Makefile b/drivers/clk/mmp/Makefile
index 14dc8a8a9d08..f9fab883a13b 100644
--- a/drivers/clk/mmp/Makefile
+++ b/drivers/clk/mmp/Makefile
@@ -8,7 +8,7 @@ obj-y += clk-apbc.o clk-apmu.o clk-frac.o clk-mix.o clk-gate.o clk.o
 obj-$(CONFIG_RESET_CONTROLLER) += reset.o
 
 obj-$(CONFIG_MACH_MMP_DT) += clk-of-pxa168.o clk-of-pxa910.o
-obj-$(CONFIG_COMMON_CLK_MMP2) += clk-of-mmp2.o clk-pll.o
+obj-$(CONFIG_COMMON_CLK_MMP2) += clk-of-mmp2.o clk-pll.o pwr-island.o
 
 obj-$(CONFIG_CPU_PXA168) += clk-pxa168.o
 obj-$(CONFIG_CPU_PXA910) += clk-pxa910.o
diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
index c686c16fca82..84498d1c3544 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -17,8 +17,10 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/of_address.h>
+#include <linux/clk.h>
 
 #include <dt-bindings/clock/marvell,mmp2.h>
+#include <dt-bindings/power/marvell,mmp2.h>
 
 #include "clk.h"
 #include "reset.h"
@@ -63,6 +65,7 @@
 #define APMU_USBHSIC1	0xfc
 #define APMU_GPU	0xcc
 #define APMU_AUDIO	0x10c
+#define APMU_CAMERA	0x1fc
 
 #define MPMU_FCCR		0x8
 #define MPMU_POSR		0x10
@@ -86,6 +89,8 @@ enum mmp2_clk_model {
 struct mmp2_clk_unit {
 	struct mmp_clk_unit unit;
 	enum mmp2_clk_model model;
+	struct genpd_onecell_data pd_data;
+	struct generic_pm_domain *pm_domains[MMP2_NR_POWER_DOMAINS];
 	void __iomem *mpmu_base;
 	void __iomem *apmu_base;
 	void __iomem *apbc_base;
@@ -473,6 +478,41 @@ static void mmp2_clk_reset_init(struct device_node *np,
 	mmp_clk_reset_register(np, cells, nr_resets);
 }
 
+static void mmp2_pm_domain_init(struct device_node *np,
+				struct mmp2_clk_unit *pxa_unit)
+{
+	if (pxa_unit->model == CLK_MODEL_MMP3) {
+		pxa_unit->pm_domains[MMP2_POWER_DOMAIN_GPU]
+			= mmp_pm_domain_register("GPU",
+				pxa_unit->apmu_base + APMU_GPU,
+				0x0600, 0x40003, 0x18000c, 0, &gpu_lock);
+	} else {
+		pxa_unit->pm_domains[MMP2_POWER_DOMAIN_GPU]
+			= mmp_pm_domain_register("GPU",
+				pxa_unit->apmu_base + APMU_GPU,
+				0x8600, 0x00003, 0x00000c,
+				MMP_PM_DOMAIN_NO_DISABLE, &gpu_lock);
+	}
+	pxa_unit->pd_data.num_domains++;
+
+	pxa_unit->pm_domains[MMP2_POWER_DOMAIN_AUDIO]
+		= mmp_pm_domain_register("Audio",
+			pxa_unit->apmu_base + APMU_AUDIO,
+			0x600, 0, 0, 0, &audio_lock);
+	pxa_unit->pd_data.num_domains++;
+
+	if (pxa_unit->model == CLK_MODEL_MMP3) {
+		pxa_unit->pm_domains[MMP3_POWER_DOMAIN_CAMERA]
+			= mmp_pm_domain_register("Camera",
+				pxa_unit->apmu_base + APMU_CAMERA,
+				0x600, 0, 0, 0, NULL);
+		pxa_unit->pd_data.num_domains++;
+	}
+
+	pxa_unit->pd_data.domains = pxa_unit->pm_domains;
+	of_genpd_add_provider_onecell(np, &pxa_unit->pd_data);
+}
+
 static void __init mmp2_clk_init(struct device_node *np)
 {
 	struct mmp2_clk_unit *pxa_unit;
@@ -504,6 +544,8 @@ static void __init mmp2_clk_init(struct device_node *np)
 		goto unmap_apmu_region;
 	}
 
+	mmp2_pm_domain_init(np, pxa_unit);
+
 	mmp_clk_init(np, &pxa_unit->unit, MMP2_NR_CLKS);
 
 	mmp2_main_clk_init(pxa_unit);
diff --git a/drivers/clk/mmp/clk.h b/drivers/clk/mmp/clk.h
index 0efd5b0b2f01..bfa2adc24a7c 100644
--- a/drivers/clk/mmp/clk.h
+++ b/drivers/clk/mmp/clk.h
@@ -3,6 +3,7 @@
 #define __MACH_MMP_CLK_H
 
 #include <linux/clk-provider.h>
+#include <linux/pm_domain.h>
 #include <linux/clkdev.h>
 
 #define APBC_NO_BUS_CTRL	BIT(0)
@@ -259,4 +260,13 @@ void mmp_clk_init(struct device_node *np, struct mmp_clk_unit *unit,
 		int nr_clks);
 void mmp_clk_add(struct mmp_clk_unit *unit, unsigned int id,
 		struct clk *clk);
+
+/* Power islands */
+#define MMP_PM_DOMAIN_NO_DISABLE		BIT(0)
+
+struct generic_pm_domain *mmp_pm_domain_register(const char *name,
+		void __iomem *reg,
+		u32 power_on, u32 reset, u32 clock_enable,
+		unsigned int flags, spinlock_t *lock);
+
 #endif
diff --git a/drivers/clk/mmp/pwr-island.c b/drivers/clk/mmp/pwr-island.c
new file mode 100644
index 000000000000..ab57c0e995c1
--- /dev/null
+++ b/drivers/clk/mmp/pwr-island.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MMP PMU power island support
+ *
+ * Copyright (C) 2020 Lubomir Rintel <lkundrak@v3.sk>
+ */
+
+#include <linux/pm_domain.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+
+#include "clk.h"
+
+#define to_mmp_pm_domain(genpd) container_of(genpd, struct mmp_pm_domain, genpd)
+
+struct mmp_pm_domain {
+	struct generic_pm_domain genpd;
+	void __iomem *reg;
+	spinlock_t *lock;
+	u32 power_on;
+	u32 reset;
+	u32 clock_enable;
+	unsigned int flags;
+};
+
+static int mmp_pm_domain_power_on(struct generic_pm_domain *genpd)
+{
+	struct mmp_pm_domain *pm_domain = to_mmp_pm_domain(genpd);
+	unsigned long flags = 0;
+	u32 val;
+
+	if (pm_domain->lock)
+		spin_lock_irqsave(pm_domain->lock, flags);
+
+	val = readl(pm_domain->reg);
+
+	/* Turn on the power island */
+	val |= pm_domain->power_on;
+	writel(val, pm_domain->reg);
+
+	/* Disable isolation */
+	val |= 0x100;
+	writel(val, pm_domain->reg);
+
+	/* Some blocks need to be reset after a power up */
+	if (pm_domain->reset || pm_domain->clock_enable) {
+		u32 after_power_on = val;
+
+		val &= ~pm_domain->reset;
+		writel(val, pm_domain->reg);
+
+		val |= pm_domain->clock_enable;
+		writel(val, pm_domain->reg);
+
+		val |= pm_domain->reset;
+		writel(val, pm_domain->reg);
+
+		writel(after_power_on, pm_domain->reg);
+	}
+
+	if (pm_domain->lock)
+		spin_unlock_irqrestore(pm_domain->lock, flags);
+
+	return 0;
+}
+
+static int mmp_pm_domain_power_off(struct generic_pm_domain *genpd)
+{
+	struct mmp_pm_domain *pm_domain = to_mmp_pm_domain(genpd);
+	unsigned long flags = 0;
+	u32 val;
+
+	if (pm_domain->flags & MMP_PM_DOMAIN_NO_DISABLE)
+		return 0;
+
+	if (pm_domain->lock)
+		spin_lock_irqsave(pm_domain->lock, flags);
+
+	/* Turn off and isolate the the power island. */
+	val = readl(pm_domain->reg);
+	val &= ~pm_domain->power_on;
+	val &= ~0x100;
+	writel(val, pm_domain->reg);
+
+	if (pm_domain->lock)
+		spin_unlock_irqrestore(pm_domain->lock, flags);
+
+	return 0;
+}
+
+struct generic_pm_domain *mmp_pm_domain_register(const char *name,
+		void __iomem *reg,
+		u32 power_on, u32 reset, u32 clock_enable,
+		unsigned int flags, spinlock_t *lock)
+{
+	struct mmp_pm_domain *pm_domain;
+
+	pm_domain = kzalloc(sizeof(*pm_domain), GFP_KERNEL);
+	if (!pm_domain)
+		return ERR_PTR(-ENOMEM);
+
+	pm_domain->reg = reg;
+	pm_domain->power_on = power_on;
+	pm_domain->reset = reset;
+	pm_domain->clock_enable = clock_enable;
+	pm_domain->flags = flags;
+	pm_domain->lock = lock;
+
+	pm_genpd_init(&pm_domain->genpd, NULL, true);
+	pm_domain->genpd.name = name;
+	pm_domain->genpd.power_on = mmp_pm_domain_power_on;
+	pm_domain->genpd.power_off = mmp_pm_domain_power_off;
+
+	return &pm_domain->genpd;
+}
-- 
2.26.2

