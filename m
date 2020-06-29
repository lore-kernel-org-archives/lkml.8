Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABE2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E622A206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbgF2TEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:04:07 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51254 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730626AbgF2TED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:04:03 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D6AF51A01F6;
        Mon, 29 Jun 2020 08:06:03 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 084551A01A5;
        Mon, 29 Jun 2020 08:05:53 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1B47B402F7;
        Mon, 29 Jun 2020 14:05:40 +0800 (SGT)
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
Subject: [PATCH V3 03/10] ARM: imx: Select MXC_CLK for each SoC
Date:   Mon, 29 Jun 2020 13:53:55 +0800
Message-Id: <1593410042-10598-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX common clock drivers may support module build, so it is NOT
selected by default, for ARCH_MXC ARMv7 platforms, need to select
it manually in each SoC to make build pass.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	- manually select the MXC_CLK in each SoC instead of selecting it
	  for ARCH_MXC.
---
 arch/arm/mach-imx/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index e7d7b90..a465c0f 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -58,6 +58,7 @@ config SOC_IMX21
 	select CPU_ARM926T
 	select IMX_HAVE_IOMUX_V1
 	select MXC_AVIC
+	select MXC_CLK
 
 config SOC_IMX27
 	bool
@@ -65,17 +66,20 @@ config SOC_IMX27
 	select IMX_HAVE_IOMUX_V1
 	select MXC_AVIC
 	select PINCTRL_IMX27
+	select MXC_CLK
 
 config SOC_IMX31
 	bool
 	select CPU_V6
 	select MXC_AVIC
+	select MXC_CLK
 
 config SOC_IMX35
 	bool
 	select ARCH_MXC_IOMUX_V3
 	select MXC_AVIC
 	select PINCTRL_IMX35
+	select MXC_CLK
 
 if ARCH_MULTI_V5
 
@@ -419,6 +423,7 @@ config SOC_IMX1
 	select CPU_ARM920T
 	select MXC_AVIC
 	select PINCTRL_IMX1
+	select MXC_CLK
 	help
 	  This enables support for Freescale i.MX1 processor
 
@@ -432,6 +437,7 @@ config SOC_IMX25
 	select CPU_ARM926T
 	select MXC_AVIC
 	select PINCTRL_IMX25
+	select MXC_CLK
 	help
 	  This enables support for Freescale i.MX25 processor
 endif
@@ -444,6 +450,7 @@ config SOC_IMX5
 	bool
 	select HAVE_IMX_SRC
 	select MXC_TZIC
+	select MXC_CLK
 
 config	SOC_IMX50
 	bool "i.MX50 support"
@@ -477,6 +484,7 @@ config SOC_IMX6
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
 	select MFD_SYSCON
+	select MXC_CLK
 	select PL310_ERRATA_769419 if CACHE_L2X0
 
 config SOC_IMX6Q
@@ -561,6 +569,7 @@ config SOC_IMX7D_CM4
 config SOC_IMX7D
 	bool "i.MX7 Dual support"
 	select PINCTRL_IMX7D
+	select MXC_CLK
 	select SOC_IMX7D_CA7 if ARCH_MULTI_V7
 	select SOC_IMX7D_CM4 if ARM_SINGLE_ARMV7M
 	select ARM_ERRATA_814220 if ARCH_MULTI_V7
@@ -571,6 +580,7 @@ config SOC_IMX7ULP
 	bool "i.MX7ULP support"
 	select CLKSRC_IMX_TPM
 	select PINCTRL_IMX7ULP
+	select MXC_CLK
 	select SOC_IMX7D_CA7 if ARCH_MULTI_V7
 	select SOC_IMX7D_CM4 if ARM_SINGLE_ARMV7M
 	help
@@ -580,6 +590,7 @@ config SOC_VF610
 	bool "Vybrid Family VF610 support"
 	select ARM_GIC if ARCH_MULTI_V7
 	select PINCTRL_VF610
+	select MXC_CLK
 
 	help
 	  This enables support for Freescale Vybrid VF610 processor.
-- 
2.7.4

