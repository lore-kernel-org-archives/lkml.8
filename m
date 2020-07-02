Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB13C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E34632070C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgGBCR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 22:17:57 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39312 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgGBCRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 22:17:55 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 56BE92005B7;
        Thu,  2 Jul 2020 04:17:52 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 243B9200803;
        Thu,  2 Jul 2020 04:17:45 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4627D40294;
        Thu,  2 Jul 2020 10:17:36 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        peng.fan@nxp.com, arnd@arndb.de, abel.vesa@nxp.com,
        aisheng.dong@nxp.com, fugang.duan@nxp.com, daniel.baluta@nxp.com,
        yuehaibing@huawei.com, sfr@canb.auug.org.au,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V4 2/5] clk: imx: Add clock configuration for ARMv7 platforms
Date:   Thu,  2 Jul 2020 10:14:31 +0800
Message-Id: <1593656074-10092-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593656074-10092-1-git-send-email-Anson.Huang@nxp.com>
References: <1593656074-10092-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CONFIG_CLK_xxx for i.MX ARMv7 platforms, and use it as build option
instead of CONFIG_SOC_xxx, the CONFIG_CLK_xxx will be selected by default
according to CONFIG_SOC_xxx.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V3:
	- Add clock configuration for each ARMv7.
---
 drivers/clk/imx/Kconfig  | 90 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/Makefile | 30 ++++++++--------
 2 files changed, 105 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index db0253f..09fc8ad 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -8,6 +8,96 @@ config MXC_CLK_SCU
 	bool
 	depends on IMX_SCU
 
+config CLK_IMX1
+         bool "IMX1 CCM Clock Driver"
+         depends on SOC_IMX1 || COMPILE_TEST
+         default SOC_IMX1
+         select MXC_CLK
+
+config CLK_IMX21
+         bool "IMX21 CCM Clock Driver"
+         depends on SOC_IMX21 || COMPILE_TEST
+         default SOC_IMX21
+         select MXC_CLK
+
+config CLK_IMX25
+         bool "IMX25 CCM Clock Driver"
+         depends on SOC_IMX25 || COMPILE_TEST
+         default SOC_IMX25
+         select MXC_CLK
+
+config CLK_IMX27
+         bool "IMX27 CCM Clock Driver"
+         depends on SOC_IMX27 || COMPILE_TEST
+         default SOC_IMX27
+         select MXC_CLK
+
+config CLK_IMX31
+         bool "IMX31 CCM Clock Driver"
+         depends on SOC_IMX31 || COMPILE_TEST
+         default SOC_IMX31
+         select MXC_CLK
+
+config CLK_IMX35
+         bool "IMX35 CCM Clock Driver"
+         depends on SOC_IMX35 || COMPILE_TEST
+         default SOC_IMX35
+         select MXC_CLK
+
+config CLK_IMX5
+         bool "IMX5 CCM Clock Driver"
+         depends on SOC_IMX5 || COMPILE_TEST
+         default SOC_IMX5
+         select MXC_CLK
+
+config CLK_IMX6Q
+         bool "IMX6Q CCM Clock Driver"
+         depends on SOC_IMX6Q || COMPILE_TEST
+         default SOC_IMX6Q
+         select MXC_CLK
+
+config CLK_IMX6SL
+         bool "IMX6SL CCM Clock Driver"
+         depends on SOC_IMX6SL || COMPILE_TEST
+         default SOC_IMX6SL
+         select MXC_CLK
+
+config CLK_IMX6SLL
+         bool "IMX6SLL CCM Clock Driver"
+         depends on SOC_IMX6SLL || COMPILE_TEST
+         default SOC_IMX6SLL
+         select MXC_CLK
+
+config CLK_IMX6SX
+         bool "IMX6SX CCM Clock Driver"
+         depends on SOC_IMX6SX || COMPILE_TEST
+         default SOC_IMX6SX
+         select MXC_CLK
+
+config CLK_IMX6UL
+         bool "IMX6UL CCM Clock Driver"
+         depends on SOC_IMX6UL || COMPILE_TEST
+         default SOC_IMX6UL
+         select MXC_CLK
+
+config CLK_IMX7D
+         bool "IMX7D CCM Clock Driver"
+         depends on SOC_IMX7D || COMPILE_TEST
+         default SOC_IMX7D
+         select MXC_CLK
+
+config CLK_IMX7ULP
+         bool "IMX7ULP Clock Driver"
+         depends on SOC_IMX7ULP || COMPILE_TEST
+         default SOC_IMX7ULP
+         select MXC_CLK
+
+config CLK_VF610
+         bool "VF610 Clock Driver"
+         depends on SOC_VF610 || COMPILE_TEST
+         default SOC_VF610
+         select MXC_CLK
+
 config CLK_IMX8MM
 	bool "IMX8MM CCM Clock Driver"
 	depends on ARCH_MXC
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 928f874..394ade7 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -31,18 +31,18 @@ obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o
 obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
 obj-$(CONFIG_CLK_IMX8QXP) += clk-imx8qxp.o clk-imx8qxp-lpcg.o
 
-obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
-obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
-obj-$(CONFIG_SOC_IMX25)  += clk-imx25.o
-obj-$(CONFIG_SOC_IMX27)  += clk-imx27.o
-obj-$(CONFIG_SOC_IMX31)  += clk-imx31.o
-obj-$(CONFIG_SOC_IMX35)  += clk-imx35.o
-obj-$(CONFIG_SOC_IMX5)   += clk-imx5.o
-obj-$(CONFIG_SOC_IMX6Q)  += clk-imx6q.o
-obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o
-obj-$(CONFIG_SOC_IMX6SLL) += clk-imx6sll.o
-obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
-obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
-obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
-obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
-obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
+obj-$(CONFIG_CLK_IMX1)   += clk-imx1.o
+obj-$(CONFIG_CLK_IMX21)  += clk-imx21.o
+obj-$(CONFIG_CLK_IMX25)  += clk-imx25.o
+obj-$(CONFIG_CLK_IMX27)  += clk-imx27.o
+obj-$(CONFIG_CLK_IMX31)  += clk-imx31.o
+obj-$(CONFIG_CLK_IMX35)  += clk-imx35.o
+obj-$(CONFIG_CLK_IMX5)   += clk-imx5.o
+obj-$(CONFIG_CLK_IMX6Q)  += clk-imx6q.o
+obj-$(CONFIG_CLK_IMX6SL) += clk-imx6sl.o
+obj-$(CONFIG_CLK_IMX6SLL) += clk-imx6sll.o
+obj-$(CONFIG_CLK_IMX6SX) += clk-imx6sx.o
+obj-$(CONFIG_CLK_IMX6UL) += clk-imx6ul.o
+obj-$(CONFIG_CLK_IMX7D)  += clk-imx7d.o
+obj-$(CONFIG_CLK_IMX7ULP) += clk-imx7ulp.o
+obj-$(CONFIG_CLK_VF610)  += clk-vf610.o
-- 
2.7.4

