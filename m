Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCD8C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 290202064B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgF2TFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:05:30 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41034 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730534AbgF2TEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:04:46 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E5D78200FE3;
        Mon, 29 Jun 2020 08:06:05 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1278F200EF8;
        Mon, 29 Jun 2020 08:05:55 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4F852402E0;
        Mon, 29 Jun 2020 14:05:42 +0800 (SGT)
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
Subject: [PATCH V3 04/10] clk: imx: Support building SCU clock driver as module
Date:   Mon, 29 Jun 2020 13:53:56 +0800
Message-Id: <1593410042-10598-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more and more requirements of building SoC specific drivers
as modules, add support for building SCU clock driver as module to meet
the requirement.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	- use separated line for each file which is included for build;
	- include linux/export.h where necessary.
---
 drivers/clk/imx/Kconfig        | 4 ++--
 drivers/clk/imx/Makefile       | 6 +++---
 drivers/clk/imx/clk-lpcg-scu.c | 2 ++
 drivers/clk/imx/clk-scu.c      | 5 +++++
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index db0253f..ded0643 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -5,8 +5,8 @@ config MXC_CLK
 	def_bool ARCH_MXC
 
 config MXC_CLK_SCU
-	bool
-	depends on IMX_SCU
+	tristate "IMX SCU clock"
+	depends on ARCH_MXC && IMX_SCU
 
 config CLK_IMX8MM
 	bool "IMX8MM CCM Clock Driver"
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 928f874..c6574a3 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -21,9 +21,9 @@ obj-$(CONFIG_MXC_CLK) += \
 	clk-sscg-pll.o \
 	clk-pll14xx.o
 
-obj-$(CONFIG_MXC_CLK_SCU) += \
-	clk-scu.o \
-	clk-lpcg-scu.o
+mxc-clk-scu-objs += clk-lpcg-scu.o
+mxc-clk-scu-objs += clk-scu.o
+obj-$(CONFIG_MXC_CLK_SCU) += mxc-clk-scu.o
 
 obj-$(CONFIG_CLK_IMX8MM) += clk-imx8mm.o
 obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
index a73a799..d4e78ca 100644
--- a/drivers/clk/imx/clk-lpcg-scu.c
+++ b/drivers/clk/imx/clk-lpcg-scu.c
@@ -6,6 +6,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -114,3 +115,4 @@ struct clk_hw *imx_clk_lpcg_scu(const char *name, const char *parent_name,
 
 	return hw;
 }
+EXPORT_SYMBOL_GPL(imx_clk_lpcg_scu);
diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index b8b2072..9688981 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -8,6 +8,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 
 #include "clk-scu.h"
@@ -132,6 +133,7 @@ int imx_clk_scu_init(void)
 {
 	return imx_scu_get_handle(&ccm_ipc_handle);
 }
+EXPORT_SYMBOL_GPL(imx_clk_scu_init);
 
 /*
  * clk_scu_recalc_rate - Get clock rate for a SCU clock
@@ -387,3 +389,6 @@ struct clk_hw *__imx_clk_scu(const char *name, const char * const *parents,
 
 	return hw;
 }
+EXPORT_SYMBOL_GPL(__imx_clk_scu);
+
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

