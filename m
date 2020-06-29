Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF35BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A02B920663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbgF2TEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:04:12 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51252 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730627AbgF2TED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:04:03 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D08C31A01C3;
        Mon, 29 Jun 2020 08:06:09 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C40791A01BA;
        Mon, 29 Jun 2020 08:05:58 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2EEE340318;
        Mon, 29 Jun 2020 14:05:44 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, oleksandr.suvorov@toradex.com,
        stefan.agner@toradex.com, arnd@arndb.de, peng.fan@nxp.com,
        abel.vesa@nxp.com, aisheng.dong@nxp.com, fugang.duan@nxp.com,
        daniel.baluta@nxp.com, yuehaibing@huawei.com, sfr@canb.auug.org.au,
        viro@zeniv.linux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 05/10] clk: imx: Support building i.MX common clock driver as module
Date:   Mon, 29 Jun 2020 13:53:57 +0800
Message-Id: <1593410042-10598-6-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more and more requirements of building SoC specific drivers
as modules, add support for building i.MX common clock driver as module
to meet the requirement.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	- remove __setup_param() change for module build, it is already fix in
	  a new patch;
	- include linux/export.h where necessary;
	- use separate line for each file which is included for build.
---
 drivers/clk/imx/Kconfig            |  8 ++++++--
 drivers/clk/imx/Makefile           | 40 +++++++++++++++++++-------------------
 drivers/clk/imx/clk-composite-8m.c |  2 ++
 drivers/clk/imx/clk-cpu.c          |  2 ++
 drivers/clk/imx/clk-frac-pll.c     |  2 ++
 drivers/clk/imx/clk-gate2.c        |  2 ++
 drivers/clk/imx/clk-pll14xx.c      |  5 +++++
 drivers/clk/imx/clk-sscg-pll.c     |  2 ++
 drivers/clk/imx/clk.c              | 20 +++++++++++++------
 9 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index ded0643..678113b 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # common clock support for NXP i.MX SoC family.
 config MXC_CLK
-	bool
-	def_bool ARCH_MXC
+	tristate "IMX clock"
+	depends on ARCH_MXC
 
 config MXC_CLK_SCU
 	tristate "IMX SCU clock"
@@ -11,24 +11,28 @@ config MXC_CLK_SCU
 config CLK_IMX8MM
 	bool "IMX8MM CCM Clock Driver"
 	depends on ARCH_MXC
+	select MXC_CLK
 	help
 	    Build the driver for i.MX8MM CCM Clock Driver
 
 config CLK_IMX8MN
 	bool "IMX8MN CCM Clock Driver"
 	depends on ARCH_MXC
+	select MXC_CLK
 	help
 	    Build the driver for i.MX8MN CCM Clock Driver
 
 config CLK_IMX8MP
 	bool "IMX8MP CCM Clock Driver"
 	depends on ARCH_MXC
+	select MXC_CLK
 	help
 	    Build the driver for i.MX8MP CCM Clock Driver
 
 config CLK_IMX8MQ
 	bool "IMX8MQ CCM Clock Driver"
 	depends on ARCH_MXC
+	select MXC_CLK
 	help
 	    Build the driver for i.MX8MQ CCM Clock Driver
 
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index c6574a3..38fb9d5 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -1,25 +1,25 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_MXC_CLK) += \
-	clk.o \
-	clk-busy.o \
-	clk-composite-8m.o \
-	clk-cpu.o \
-	clk-composite-7ulp.o \
-	clk-divider-gate.o \
-	clk-fixup-div.o \
-	clk-fixup-mux.o \
-	clk-frac-pll.o \
-	clk-gate-exclusive.o \
-	clk-gate2.o \
-	clk-pfd.o \
-	clk-pfdv2.o \
-	clk-pllv1.o \
-	clk-pllv2.o \
-	clk-pllv3.o \
-	clk-pllv4.o \
-	clk-sscg-pll.o \
-	clk-pll14xx.o
+mxc-clk-objs += clk.o
+mxc-clk-objs += clk-busy.o
+mxc-clk-objs += clk-composite-7ulp.o
+mxc-clk-objs += clk-composite-8m.o
+mxc-clk-objs += clk-cpu.o
+mxc-clk-objs += clk-divider-gate.o
+mxc-clk-objs += clk-fixup-div.o
+mxc-clk-objs += clk-fixup-mux.o
+mxc-clk-objs += clk-frac-pll.o
+mxc-clk-objs += clk-gate2.o
+mxc-clk-objs += clk-gate-exclusive.o
+mxc-clk-objs += clk-pfd.o
+mxc-clk-objs += clk-pfdv2.o
+mxc-clk-objs += clk-pllv1.o
+mxc-clk-objs += clk-pllv2.o
+mxc-clk-objs += clk-pllv3.o
+mxc-clk-objs += clk-pllv4.o
+mxc-clk-objs += clk-pll14xx.o
+mxc-clk-objs += clk-sscg-pll.o
+obj-$(CONFIG_MXC_CLK) += mxc-clk.o
 
 mxc-clk-scu-objs += clk-lpcg-scu.o
 mxc-clk-scu-objs += clk-scu.o
diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index d2b5af8..78fb7e5 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 
@@ -243,3 +244,4 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 	kfree(mux);
 	return ERR_CAST(hw);
 }
+EXPORT_SYMBOL_GPL(imx8m_clk_hw_composite_flags);
diff --git a/drivers/clk/imx/clk-cpu.c b/drivers/clk/imx/clk-cpu.c
index cb182be..cb6ca4c 100644
--- a/drivers/clk/imx/clk-cpu.c
+++ b/drivers/clk/imx/clk-cpu.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include "clk.h"
 
@@ -104,3 +105,4 @@ struct clk_hw *imx_clk_hw_cpu(const char *name, const char *parent_name,
 
 	return hw;
 }
+EXPORT_SYMBOL_GPL(imx_clk_hw_cpu);
diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.c
index 101e0a3..c703056 100644
--- a/drivers/clk/imx/clk-frac-pll.c
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -10,6 +10,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/slab.h>
@@ -233,3 +234,4 @@ struct clk_hw *imx_clk_hw_frac_pll(const char *name,
 
 	return hw;
 }
+EXPORT_SYMBOL_GPL(imx_clk_hw_frac_pll);
diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
index b87ab3c..512f675 100644
--- a/drivers/clk/imx/clk-gate2.c
+++ b/drivers/clk/imx/clk-gate2.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/io.h>
@@ -177,3 +178,4 @@ struct clk_hw *clk_hw_register_gate2(struct device *dev, const char *name,
 
 	return hw;
 }
+EXPORT_SYMBOL_GPL(clk_hw_register_gate2);
diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index f9eb189..f5c3e7e 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -6,6 +6,7 @@
 #include <linux/bitops.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/slab.h>
@@ -68,6 +69,7 @@ struct imx_pll14xx_clk imx_1443x_pll = {
 	.rate_table = imx_pll1443x_tbl,
 	.rate_count = ARRAY_SIZE(imx_pll1443x_tbl),
 };
+EXPORT_SYMBOL_GPL(imx_1443x_pll);
 
 struct imx_pll14xx_clk imx_1443x_dram_pll = {
 	.type = PLL_1443X,
@@ -75,12 +77,14 @@ struct imx_pll14xx_clk imx_1443x_dram_pll = {
 	.rate_count = ARRAY_SIZE(imx_pll1443x_tbl),
 	.flags = CLK_GET_RATE_NOCACHE,
 };
+EXPORT_SYMBOL_GPL(imx_1443x_dram_pll);
 
 struct imx_pll14xx_clk imx_1416x_pll = {
 	.type = PLL_1416X,
 	.rate_table = imx_pll1416x_tbl,
 	.rate_count = ARRAY_SIZE(imx_pll1416x_tbl),
 };
+EXPORT_SYMBOL_GPL(imx_1416x_pll);
 
 static const struct imx_pll14xx_rate_table *imx_get_pll_settings(
 		struct clk_pll14xx *pll, unsigned long rate)
@@ -436,3 +440,4 @@ struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
 
 	return hw;
 }
+EXPORT_SYMBOL_GPL(imx_dev_clk_hw_pll14xx);
diff --git a/drivers/clk/imx/clk-sscg-pll.c b/drivers/clk/imx/clk-sscg-pll.c
index 773d8a5..9d6cdff 100644
--- a/drivers/clk/imx/clk-sscg-pll.c
+++ b/drivers/clk/imx/clk-sscg-pll.c
@@ -10,6 +10,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/slab.h>
@@ -537,3 +538,4 @@ struct clk_hw *imx_clk_hw_sscg_pll(const char *name,
 
 	return hw;
 }
+EXPORT_SYMBOL_GPL(imx_clk_hw_sscg_pll);
diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 87ab8db..3cd106c 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -3,6 +3,7 @@
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -13,6 +14,7 @@
 #define CCDR_MMDC_CH1_MASK		BIT(16)
 
 DEFINE_SPINLOCK(imx_ccm_lock);
+EXPORT_SYMBOL_GPL(imx_ccm_lock);
 
 void imx_unregister_clocks(struct clk *clks[], unsigned int count)
 {
@@ -29,8 +31,9 @@ void imx_unregister_hw_clocks(struct clk_hw *hws[], unsigned int count)
 	for (i = 0; i < count; i++)
 		clk_hw_unregister(hws[i]);
 }
+EXPORT_SYMBOL_GPL(imx_unregister_hw_clocks);
 
-void __init imx_mmdc_mask_handshake(void __iomem *ccm_base,
+void imx_mmdc_mask_handshake(void __iomem *ccm_base,
 				    unsigned int chn)
 {
 	unsigned int reg;
@@ -59,8 +62,9 @@ void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count)
 			pr_err("i.MX clk %u: register failed with %ld\n",
 			       i, PTR_ERR(clks[i]));
 }
+EXPORT_SYMBOL_GPL(imx_check_clk_hws);
 
-static struct clk * __init imx_obtain_fixed_clock_from_dt(const char *name)
+static struct clk *imx_obtain_fixed_clock_from_dt(const char *name)
 {
 	struct of_phandle_args phandle;
 	struct clk *clk = ERR_PTR(-ENODEV);
@@ -80,7 +84,7 @@ static struct clk * __init imx_obtain_fixed_clock_from_dt(const char *name)
 	return clk;
 }
 
-struct clk * __init imx_obtain_fixed_clock(
+struct clk *imx_obtain_fixed_clock(
 			const char *name, unsigned long rate)
 {
 	struct clk *clk;
@@ -91,7 +95,7 @@ struct clk * __init imx_obtain_fixed_clock(
 	return clk;
 }
 
-struct clk_hw * __init imx_obtain_fixed_clock_hw(
+struct clk_hw *imx_obtain_fixed_clock_hw(
 			const char *name, unsigned long rate)
 {
 	struct clk *clk;
@@ -113,6 +117,7 @@ struct clk_hw * imx_obtain_fixed_clk_hw(struct device_node *np,
 
 	return __clk_get_hw(clk);
 }
+EXPORT_SYMBOL_GPL(imx_obtain_fixed_clk_hw);
 
 /*
  * This fixups the register CCM_CSCMR1 write value.
@@ -143,7 +148,7 @@ void imx_cscmr1_fixup(u32 *val)
 static int imx_keep_uart_clocks;
 static struct clk ** const *imx_uart_clocks;
 
-static int __init imx_keep_uart_clocks_param(char *str)
+static int __maybe_unused imx_keep_uart_clocks_param(char *str)
 {
 	imx_keep_uart_clocks = 1;
 
@@ -164,8 +169,9 @@ void imx_register_uart_clocks(struct clk ** const clks[])
 			clk_prepare_enable(*imx_uart_clocks[i]);
 	}
 }
+EXPORT_SYMBOL_GPL(imx_register_uart_clocks);
 
-static int __init imx_clk_disable_uart(void)
+static int imx_clk_disable_uart(void)
 {
 	if (imx_keep_uart_clocks && imx_uart_clocks) {
 		int i;
@@ -177,3 +183,5 @@ static int __init imx_clk_disable_uart(void)
 	return 0;
 }
 late_initcall_sync(imx_clk_disable_uart);
+
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

