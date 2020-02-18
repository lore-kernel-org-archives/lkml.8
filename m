Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E40C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF3D20836
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgBRMc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 07:32:27 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:37551 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726551AbgBRMc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 07:32:26 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 01ICVdWY007990;
        Tue, 18 Feb 2020 14:31:39 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 316E76032F; Tue, 18 Feb 2020 14:31:39 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v4 1/3] arm: dts: modify NPCM7xx device tree clock parameter to clock constant
Date:   Tue, 18 Feb 2020 14:31:26 +0200
Message-Id: <20200218123128.17990-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200218123128.17990-1-tmaimon77@gmail.com>
References: <20200218123128.17990-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify NPCM7xx device tree clock parameter to clock constants that
define at include/dt-bindings/clock/nuvoton,npcm7xx-clock.h file.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 19 ++++++++++---------
 arch/arm/boot/dts/nuvoton-npcm750.dtsi        |  6 +++---
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
index d2d0761295a4..16a28c5c4131 100644
--- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -3,6 +3,7 @@
 // Copyright 2018 Google, Inc.
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
 
 / {
 	#address-cells = <1>;
@@ -80,7 +81,7 @@
 			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 			cache-unified;
 			cache-level = <2>;
-			clocks = <&clk 10>;
+			clocks = <&clk NPCM7XX_CLK_AXI>;
 			arm,shared-override;
 		};
 
@@ -120,7 +121,7 @@
 				compatible = "nuvoton,npcm750-timer";
 				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x8000 0x50>;
-				clocks = <&clk 5>;
+				clocks = <&clk NPCM7XX_CLK_TIMER>;
 			};
 
 			watchdog0: watchdog@801C {
@@ -128,7 +129,7 @@
 				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x801C 0x4>;
 				status = "disabled";
-				clocks = <&clk 5>;
+				clocks = <&clk NPCM7XX_CLK_TIMER>;
 			};
 
 			watchdog1: watchdog@901C {
@@ -136,7 +137,7 @@
 				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x901C 0x4>;
 				status = "disabled";
-				clocks = <&clk 5>;
+				clocks = <&clk NPCM7XX_CLK_TIMER>;
 			};
 
 			watchdog2: watchdog@a01C {
@@ -144,13 +145,13 @@
 				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0xa01C 0x4>;
 				status = "disabled";
-				clocks = <&clk 5>;
+				clocks = <&clk NPCM7XX_CLK_TIMER>;
 			};
 
 			serial0: serial@1000 {
 				compatible = "nuvoton,npcm750-uart";
 				reg = <0x1000 0x1000>;
-				clocks = <&clk 6>;
+				clocks = <&clk NPCM7XX_CLK_UART>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 				reg-shift = <2>;
 				status = "disabled";
@@ -159,7 +160,7 @@
 			serial1: serial@2000 {
 				compatible = "nuvoton,npcm750-uart";
 				reg = <0x2000 0x1000>;
-				clocks = <&clk 6>;
+				clocks = <&clk NPCM7XX_CLK_UART>;
 				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 				reg-shift = <2>;
 				status = "disabled";
@@ -168,7 +169,7 @@
 			serial2: serial@3000 {
 				compatible = "nuvoton,npcm750-uart";
 				reg = <0x3000 0x1000>;
-				clocks = <&clk 6>;
+				clocks = <&clk NPCM7XX_CLK_UART>;
 				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 				reg-shift = <2>;
 				status = "disabled";
@@ -177,7 +178,7 @@
 			serial3: serial@4000 {
 				compatible = "nuvoton,npcm750-uart";
 				reg = <0x4000 0x1000>;
-				clocks = <&clk 6>;
+				clocks = <&clk NPCM7XX_CLK_UART>;
 				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 				reg-shift = <2>;
 				status = "disabled";
diff --git a/arch/arm/boot/dts/nuvoton-npcm750.dtsi b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
index 6ac340533587..a37bb2294b8f 100644
--- a/arch/arm/boot/dts/nuvoton-npcm750.dtsi
+++ b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
@@ -17,7 +17,7 @@
 		cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
-			clocks = <&clk 0>;
+			clocks = <&clk NPCM7XX_CLK_CPU>;
 			clock-names = "clk_cpu";
 			reg = <0>;
 			next-level-cache = <&l2>;
@@ -26,7 +26,7 @@
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
-			clocks = <&clk 0>;
+			clocks = <&clk NPCM7XX_CLK_CPU>;
 			clock-names = "clk_cpu";
 			reg = <1>;
 			next-level-cache = <&l2>;
@@ -38,7 +38,7 @@
 			reg = <0x3fe600 0x20>;
 			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
 						  IRQ_TYPE_LEVEL_HIGH)>;
-			clocks = <&clk 5>;
+			clocks = <&clk NPCM7XX_CLK_AHB>;
 		};
 	};
 };
-- 
2.22.0

