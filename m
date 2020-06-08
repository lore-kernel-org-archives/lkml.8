Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACE8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562EC2076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbgFHNX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 09:23:26 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41646 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbgFHNXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 09:23:20 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 85E6C1A010A;
        Mon,  8 Jun 2020 15:23:18 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5AB4A1A0120;
        Mon,  8 Jun 2020 15:23:08 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E07AB402FB;
        Mon,  8 Jun 2020 21:22:55 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, oleksandr.suvorov@toradex.com,
        stefan.agner@toradex.com, arnd@arndb.de, abel.vesa@nxp.com,
        peng.fan@nxp.com, aisheng.dong@nxp.com, tglx@linutronix.de,
        allison@lohutok.net, gregkh@linuxfoundation.org, info@metux.net,
        leonard.crestez@nxp.com, fugang.duan@nxp.com,
        daniel.baluta@nxp.com, yuehaibing@huawei.com, sfr@canb.auug.org.au,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/9] clk: imx: Support building SCU clock driver as module
Date:   Mon,  8 Jun 2020 21:12:10 +0800
Message-Id: <1591621936-11886-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591621936-11886-1-git-send-email-Anson.Huang@nxp.com>
References: <1591621936-11886-1-git-send-email-Anson.Huang@nxp.com>
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
 drivers/clk/imx/Kconfig   | 2 +-
 drivers/clk/imx/Makefile  | 5 ++---
 drivers/clk/imx/clk-scu.c | 5 +++++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index db0253f..503d6c8 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -5,7 +5,7 @@ config MXC_CLK
 	def_bool ARCH_MXC
 
 config MXC_CLK_SCU
-	bool
+	tristate "IMX SCU clock"
 	depends on IMX_SCU
 
 config CLK_IMX8MM
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 928f874..1af8cff 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -21,9 +21,8 @@ obj-$(CONFIG_MXC_CLK) += \
 	clk-sscg-pll.o \
 	clk-pll14xx.o
 
-obj-$(CONFIG_MXC_CLK_SCU) += \
-	clk-scu.o \
-	clk-lpcg-scu.o
+mxc-clk-scu-objs += clk-scu.o clk-lpcg-scu.o
+obj-$(CONFIG_MXC_CLK_SCU) += mxc-clk-scu.o
 
 obj-$(CONFIG_CLK_IMX8MM) += clk-imx8mm.o
 obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
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

