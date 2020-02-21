Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CA3C11D24
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB398206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgBUCTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 21:19:20 -0500
Received: from inva020.nxp.com ([92.121.34.13]:34892 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbgBUCTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 21:19:20 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7F5EB1A6558;
        Fri, 21 Feb 2020 03:19:17 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 14D6E1A652F;
        Fri, 21 Feb 2020 03:19:12 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 87476402A0;
        Fri, 21 Feb 2020 10:19:05 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: dts: imx: make wdog node name generic
Date:   Fri, 21 Feb 2020 10:13:20 +0800
Message-Id: <1582251200-15562-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Node name should be generic, use "watchdog" instead of "wdog" for
wdog nodes.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 4 ++--
 arch/arm/boot/dts/imx6sl.dtsi  | 4 ++--
 arch/arm/boot/dts/imx6sx.dtsi  | 6 +++---
 arch/arm/boot/dts/imx6ul.dtsi  | 6 +++---
 arch/arm/boot/dts/imx7s.dtsi   | 8 ++++----
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 97c0a85..886ab81 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -669,14 +669,14 @@
 				status = "disabled";
 			};
 
-			wdog1: wdog@20bc000 {
+			wdog1: watchdog@20bc000 {
 				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_IPG>;
 			};
 
-			wdog2: wdog@20c0000 {
+			wdog2: watchdog@20c0000 {
 				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
 				reg = <0x020c0000 0x4000>;
 				interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index ea889f7..db626b2 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -499,14 +499,14 @@
 				status = "disabled";
 			};
 
-			wdog1: wdog@20bc000 {
+			wdog1: watchdog@20bc000 {
 				compatible = "fsl,imx6sl-wdt", "fsl,imx21-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SL_CLK_IPG>;
 			};
 
-			wdog2: wdog@20c0000 {
+			wdog2: watchdog@20c0000 {
 				compatible = "fsl,imx6sl-wdt", "fsl,imx21-wdt";
 				reg = <0x020c0000 0x4000>;
 				interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 1198117..6db9ca09 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -567,14 +567,14 @@
 				status = "disabled";
 			};
 
-			wdog1: wdog@20bc000 {
+			wdog1: watchdog@20bc000 {
 				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_IPG>;
 			};
 
-			wdog2: wdog@20c0000 {
+			wdog2: watchdog@20c0000 {
 				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
 				reg = <0x020c0000 0x4000>;
 				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
@@ -1289,7 +1289,7 @@
 				status = "disabled";
 			};
 
-			wdog3: wdog@2288000 {
+			wdog3: watchdog@2288000 {
 				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
 				reg = <0x02288000 0x4000>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 30cce35..e1807e9 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -531,14 +531,14 @@
 				status = "disabled";
 			};
 
-			wdog1: wdog@20bc000 {
+			wdog1: watchdog@20bc000 {
 				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6UL_CLK_WDOG1>;
 			};
 
-			wdog2: wdog@20c0000 {
+			wdog2: watchdog@20c0000 {
 				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
 				reg = <0x020c0000 0x4000>;
 				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
@@ -1007,7 +1007,7 @@
 				status = "disabled";
 			};
 
-			wdog3: wdog@21e4000 {
+			wdog3: watchdog@21e4000 {
 				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
 				reg = <0x021e4000 0x4000>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 1ac5045..196bbd6 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -406,14 +406,14 @@
 				gpio-ranges = <&iomuxc 0 139 16>;
 			};
 
-			wdog1: wdog@30280000 {
+			wdog1: watchdog@30280000 {
 				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
 				reg = <0x30280000 0x10000>;
 				interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_WDOG1_ROOT_CLK>;
 			};
 
-			wdog2: wdog@30290000 {
+			wdog2: watchdog@30290000 {
 				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
 				reg = <0x30290000 0x10000>;
 				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
@@ -421,7 +421,7 @@
 				status = "disabled";
 			};
 
-			wdog3: wdog@302a0000 {
+			wdog3: watchdog@302a0000 {
 				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
 				reg = <0x302a0000 0x10000>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
@@ -429,7 +429,7 @@
 				status = "disabled";
 			};
 
-			wdog4: wdog@302b0000 {
+			wdog4: watchdog@302b0000 {
 				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
 				reg = <0x302b0000 0x10000>;
 				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.7.4

