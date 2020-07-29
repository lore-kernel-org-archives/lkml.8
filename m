Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0475DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2C320829
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgG2OxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:53:13 -0400
Received: from inva020.nxp.com ([92.121.34.13]:58806 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbgG2OxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:53:10 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F159E1A01FA;
        Wed, 29 Jul 2020 16:53:07 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 42EEA1A0E27;
        Wed, 29 Jul 2020 16:53:01 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D8F0E4031D;
        Wed, 29 Jul 2020 16:52:52 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, arnd@arndb.de, peng.fan@nxp.com,
        abel.vesa@nxp.com, fugang.duan@nxp.com, daniel.baluta@nxp.com,
        yuehaibing@huawei.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V7 4/6] clk: imx: Add clock configuration for ARMv7 platforms
Date:   Wed, 29 Jul 2020 22:48:35 +0800
Message-Id: <1596034117-24246-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596034117-24246-1-git-send-email-Anson.Huang@nxp.com>
References: <1596034117-24246-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CONFIG_CLK_xxx for i.MX ARMv7 platforms, and use it as build option
instead of CONFIG_SOC_xxx, the CONFIG_CLK_xxx will be selected by default
according to CONFIG_SOC_xxx.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
no change.
---
 drivers/clk/imx/Kconfig  | 62 +++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/clk/imx/Makefile | 30 +++++++++++------------
 2 files changed, 76 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index ee854ac..e96bd38 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -2,12 +2,72 @@
 # common clock support for NXP i.MX SoC family.
 config MXC_CLK
 	tristate "IMX clock"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 
 config MXC_CLK_SCU
 	bool
 	depends on IMX_SCU
 
+config CLK_IMX1
+	def_bool SOC_IMX1
+	select MXC_CLK
+
+config CLK_IMX21
+	def_bool SOC_IMX21
+	select MXC_CLK
+
+config CLK_IMX25
+	def_bool SOC_IMX25
+	select MXC_CLK
+
+config CLK_IMX27
+	def_bool SOC_IMX27
+	select MXC_CLK
+
+config CLK_IMX31
+	def_bool SOC_IMX31
+	select MXC_CLK
+
+config CLK_IMX35
+	def_bool SOC_IMX35
+	select MXC_CLK
+
+config CLK_IMX5
+	def_bool SOC_IMX5
+	select MXC_CLK
+
+config CLK_IMX6Q
+	def_bool SOC_IMX6Q
+	select MXC_CLK
+
+config CLK_IMX6SL
+	def_bool SOC_IMX6SL
+	select MXC_CLK
+
+config CLK_IMX6SLL
+	def_bool SOC_IMX6SLL
+	select MXC_CLK
+
+config CLK_IMX6SX
+	def_bool SOC_IMX6SX
+	select MXC_CLK
+
+config CLK_IMX6UL
+	def_bool SOC_IMX6UL
+	select MXC_CLK
+
+config CLK_IMX7D
+	def_bool SOC_IMX7D
+	select MXC_CLK
+
+config CLK_IMX7ULP
+	def_bool SOC_IMX7ULP
+	select MXC_CLK
+
+config CLK_VF610
+	def_bool SOC_VF610
+	select MXC_CLK
+
 config CLK_IMX8MM
 	bool "IMX8MM CCM Clock Driver"
 	depends on ARCH_MXC
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 687207d..17f5d12 100644
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

