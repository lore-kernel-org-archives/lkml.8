Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D199C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DD42070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgCXMmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:42:04 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:58835 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbgCXMmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:42:03 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 8C370200018;
        Tue, 24 Mar 2020 12:42:00 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] ARM: dts: at91: rm9200: switch to new clock bindings
Date:   Tue, 24 Mar 2020 13:41:54 +0100
Message-Id: <20200324124154.368335-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch sama5d3 boards to the new PMC clock bindings.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi | 296 +++---------------------------
 1 file changed, 23 insertions(+), 273 deletions(-)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 44385718d9d4..a5040f5ea641 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -101,259 +101,9 @@ pmc: pmc@fffffc00 {
 				compatible = "atmel,at91rm9200-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-				interrupt-controller;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				#interrupt-cells = <1>;
-
-				main_osc: main_osc {
-					compatible = "atmel,at91rm9200-clk-main-osc";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_MOSCS>;
-					clocks = <&main_xtal>;
-				};
-
-				main: mainck {
-					compatible = "atmel,at91rm9200-clk-main";
-					#clock-cells = <0>;
-					clocks = <&main_osc>;
-				};
-
-				plla: pllack {
-					compatible = "atmel,at91rm9200-clk-pll";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_LOCKA>;
-					clocks = <&main>;
-					reg = <0>;
-					atmel,clk-input-range = <1000000 32000000>;
-					#atmel,pll-clk-output-range-cells = <3>;
-					atmel,pll-clk-output-ranges = <80000000 160000000 0>,
-								<150000000 180000000 2>;
-				};
-
-				pllb: pllbck {
-					compatible = "atmel,at91rm9200-clk-pll";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_LOCKB>;
-					clocks = <&main>;
-					reg = <1>;
-					atmel,clk-input-range = <1000000 32000000>;
-					#atmel,pll-clk-output-range-cells = <3>;
-					atmel,pll-clk-output-ranges = <80000000 160000000 0>,
-								<150000000 180000000 2>;
-				};
-
-				mck: masterck {
-					compatible = "atmel,at91rm9200-clk-master";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_MCKRDY>;
-					clocks = <&slow_xtal>, <&main>, <&plla>, <&pllb>;
-					atmel,clk-output-range = <0 80000000>;
-					atmel,clk-divisors = <1 2 3 4>;
-				};
-
-				usb: usbck {
-					compatible = "atmel,at91rm9200-clk-usb";
-					#clock-cells = <0>;
-					atmel,clk-divisors = <1 2 0 0>;
-					clocks = <&pllb>;
-				};
-
-				prog: progck {
-					compatible = "atmel,at91rm9200-clk-programmable";
-					#address-cells = <1>;
-					#size-cells = <0>;
-					interrupt-parent = <&pmc>;
-					clocks = <&slow_xtal>, <&main>, <&plla>, <&pllb>;
-
-					prog0: prog0 {
-						#clock-cells = <0>;
-						reg = <0>;
-						interrupts = <AT91_PMC_PCKRDY(0)>;
-					};
-
-					prog1: prog1 {
-						#clock-cells = <0>;
-						reg = <1>;
-						interrupts = <AT91_PMC_PCKRDY(1)>;
-					};
-
-					prog2: prog2 {
-						#clock-cells = <0>;
-						reg = <2>;
-						interrupts = <AT91_PMC_PCKRDY(2)>;
-					};
-
-					prog3: prog3 {
-						#clock-cells = <0>;
-						reg = <3>;
-						interrupts = <AT91_PMC_PCKRDY(3)>;
-					};
-				};
-
-				systemck {
-					compatible = "atmel,at91rm9200-clk-system";
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					udpck: udpck {
-						#clock-cells = <0>;
-						reg = <2>;
-						clocks = <&usb>;
-					};
-
-					uhpck: uhpck {
-						#clock-cells = <0>;
-						reg = <4>;
-						clocks = <&usb>;
-					};
-
-					pck0: pck0 {
-						#clock-cells = <0>;
-						reg = <8>;
-						clocks = <&prog0>;
-					};
-
-					pck1: pck1 {
-						#clock-cells = <0>;
-						reg = <9>;
-						clocks = <&prog1>;
-					};
-
-					pck2: pck2 {
-						#clock-cells = <0>;
-						reg = <10>;
-						clocks = <&prog2>;
-					};
-
-					pck3: pck3 {
-						#clock-cells = <0>;
-						reg = <11>;
-						clocks = <&prog3>;
-					};
-				};
-
-				periphck {
-					compatible = "atmel,at91rm9200-clk-peripheral";
-					#address-cells = <1>;
-					#size-cells = <0>;
-					clocks = <&mck>;
-
-					pioA_clk: pioA_clk {
-						#clock-cells = <0>;
-						reg = <2>;
-					};
-
-					pioB_clk: pioB_clk {
-						#clock-cells = <0>;
-						reg = <3>;
-					};
-
-					pioC_clk: pioC_clk {
-						#clock-cells = <0>;
-						reg = <4>;
-					};
-
-					pioD_clk: pioD_clk {
-						#clock-cells = <0>;
-						reg = <5>;
-					};
-
-					usart0_clk: usart0_clk {
-						#clock-cells = <0>;
-						reg = <6>;
-					};
-
-					usart1_clk: usart1_clk {
-						#clock-cells = <0>;
-						reg = <7>;
-					};
-
-					usart2_clk: usart2_clk {
-						#clock-cells = <0>;
-						reg = <8>;
-					};
-
-					usart3_clk: usart3_clk {
-						#clock-cells = <0>;
-						reg = <9>;
-					};
-
-					mci0_clk: mci0_clk {
-						#clock-cells = <0>;
-						reg = <10>;
-					};
-
-					udc_clk: udc_clk {
-						#clock-cells = <0>;
-						reg = <11>;
-					};
-
-					twi0_clk: twi0_clk {
-						reg = <12>;
-						#clock-cells = <0>;
-					};
-
-					spi0_clk: spi0_clk {
-						#clock-cells = <0>;
-						reg = <13>;
-					};
-
-					ssc0_clk: ssc0_clk {
-						#clock-cells = <0>;
-						reg = <14>;
-					};
-
-					ssc1_clk: ssc1_clk {
-						#clock-cells = <0>;
-						reg = <15>;
-					};
-
-					ssc2_clk: ssc2_clk {
-						#clock-cells = <0>;
-						reg = <16>;
-					};
-
-					tc0_clk: tc0_clk {
-						#clock-cells = <0>;
-						reg = <17>;
-					};
-
-					tc1_clk: tc1_clk {
-						#clock-cells = <0>;
-						reg = <18>;
-					};
-
-					tc2_clk: tc2_clk {
-						#clock-cells = <0>;
-						reg = <19>;
-					};
-
-					tc3_clk: tc3_clk {
-						#clock-cells = <0>;
-						reg = <20>;
-					};
-
-					tc4_clk: tc4_clk {
-						#clock-cells = <0>;
-						reg = <21>;
-					};
-
-					tc5_clk: tc5_clk {
-						#clock-cells = <0>;
-						reg = <22>;
-					};
-
-					ohci_clk: ohci_clk {
-						#clock-cells = <0>;
-						reg = <23>;
-					};
-
-					macb0_clk: macb0_clk {
-						#clock-cells = <0>;
-						reg = <24>;
-					};
-				};
+				#clock-cells = <2>;
+				clocks = <&slow_xtal>, <&main_xtal>;
+				clock-names = "slow_xtal", "main_xtal";
 			};
 
 			st: timer@fffffd00 {
@@ -383,7 +133,7 @@ tcb0: timer@fffa0000 {
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0
 					      18 IRQ_TYPE_LEVEL_HIGH 0
 					      19 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tc0_clk>, <&tc1_clk>, <&tc2_clk>, <&slow_xtal>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 17>, <&pmc PMC_TYPE_PERIPHERAL 18>, <&pmc PMC_TYPE_PERIPHERAL 19>, <&slow_xtal>;
 				clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
 			};
 
@@ -395,7 +145,7 @@ tcb1: timer@fffa4000 {
 				interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0
 					      21 IRQ_TYPE_LEVEL_HIGH 0
 					      22 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tc3_clk>, <&tc4_clk>, <&tc5_clk>, <&slow_xtal>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 20>, <&pmc PMC_TYPE_PERIPHERAL 21>, <&pmc PMC_TYPE_PERIPHERAL 22>, <&slow_xtal>;
 				clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
 			};
 
@@ -405,7 +155,7 @@ i2c0: i2c@fffb8000 {
 				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 6>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_twi>;
-				clocks = <&twi0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 12>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -415,7 +165,7 @@ mmc0: mmc@fffb4000 {
 				compatible = "atmel,hsmci";
 				reg = <0xfffb4000 0x4000>;
 				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&mci0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
 				clock-names = "mci_clk";
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -429,7 +179,7 @@ ssc0: ssc@fffd0000 {
 				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
-				clocks = <&ssc0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
 				clock-names = "pclk";
 				status = "disabled";
 			};
@@ -440,7 +190,7 @@ ssc1: ssc@fffd4000 {
 				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc1_tx &pinctrl_ssc1_rx>;
-				clocks = <&ssc1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
 				clock-names = "pclk";
 				status = "disabled";
 			};
@@ -451,7 +201,7 @@ ssc2: ssc@fffd8000 {
 				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc2_tx &pinctrl_ssc2_rx>;
-				clocks = <&ssc2_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
 				clock-names = "pclk";
 				status = "disabled";
 			};
@@ -463,7 +213,7 @@ macb0: ethernet@fffbc000 {
 				phy-mode = "rmii";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_macb_rmii>;
-				clocks = <&macb0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 24>;
 				clock-names = "ether_clk";
 				status = "disabled";
 			};
@@ -803,7 +553,7 @@ pioA: gpio@fffff400 {
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioA_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 2>;
 				};
 
 				pioB: gpio@fffff600 {
@@ -814,7 +564,7 @@ pioB: gpio@fffff600 {
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioB_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 3>;
 				};
 
 				pioC: gpio@fffff800 {
@@ -825,7 +575,7 @@ pioC: gpio@fffff800 {
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioC_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 4>;
 				};
 
 				pioD: gpio@fffffa00 {
@@ -836,7 +586,7 @@ pioD: gpio@fffffa00 {
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioD_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
 				};
 			};
 
@@ -846,7 +596,7 @@ dbgu: serial@fffff200 {
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
-				clocks = <&mck>;
+				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -859,7 +609,7 @@ usart0: serial@fffc0000 {
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart0>;
-				clocks = <&usart0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -872,7 +622,7 @@ usart1: serial@fffc4000 {
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart1>;
-				clocks = <&usart1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -885,7 +635,7 @@ usart2: serial@fffc8000 {
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart2>;
-				clocks = <&usart2_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -898,7 +648,7 @@ usart3: serial@fffcc000 {
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart3>;
-				clocks = <&usart3_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -907,7 +657,7 @@ usb1: gadget@fffb0000 {
 				compatible = "atmel,at91rm9200-udc";
 				reg = <0xfffb0000 0x4000>;
 				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 2>;
-				clocks = <&udc_clk>, <&udpck>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 11>, <&pmc PMC_TYPE_SYSTEM 2>;
 				clock-names = "pclk", "hclk";
 				status = "disabled";
 			};
@@ -920,7 +670,7 @@ spi0: spi@fffe0000 {
 				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi0>;
-				clocks = <&spi0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
 				clock-names = "spi_clk";
 				status = "disabled";
 			};
@@ -947,7 +697,7 @@ usb0: ohci@300000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00300000 0x100000>;
 			interrupts = <23 IRQ_TYPE_LEVEL_HIGH 2>;
-			clocks = <&ohci_clk>, <&ohci_clk>, <&uhpck>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 23>, <&pmc PMC_TYPE_PERIPHERAL 23>, <&pmc PMC_TYPE_SYSTEM 4>;
 			clock-names = "ohci_clk", "hclk", "uhpck";
 			status = "disabled";
 		};
-- 
2.25.1

