Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1727C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C993246B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393129AbgAPRgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:36:22 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:55793 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404923AbgAPRfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:35:14 -0500
X-Originating-IP: 90.65.102.129
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id F148B240003;
        Thu, 16 Jan 2020 17:35:11 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] ARM: dts: at91: at91sam9n12: switch to new clock bindings
Date:   Thu, 16 Jan 2020 18:35:10 +0100
Message-Id: <20200116173510.427403-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch at91sam9n12 boards to the new PMC clock bindings.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/at91sam9n12.dtsi  | 324 +++-------------------------
 arch/arm/boot/dts/at91sam9n12ek.dts |   2 +-
 2 files changed, 29 insertions(+), 297 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 3a3e3e05fa13..5fa34914eca7 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -104,7 +104,7 @@ pmecc: ecc-engine@ffffe000 {
 			ramc0: ramc@ffffe800 {
 				compatible = "atmel,at91sam9g45-ddramc";
 				reg = <0xffffe800 0x200>;
-				clocks = <&ddrck>;
+				clocks = <&pmc PMC_TYPE_SYSTEM 2>;
 				clock-names = "ddrck";
 			};
 
@@ -116,278 +116,10 @@ smc: smc@ffffea00 {
 			pmc: pmc@fffffc00 {
 				compatible = "atmel,at91sam9n12-pmc", "syscon";
 				reg = <0xfffffc00 0x200>;
+				#clock-cells = <2>;
+				clocks = <&clk32k>, <&main_xtal>;
+				clock-names = "slow_clk", "main_xtal";
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-				interrupt-controller;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				#interrupt-cells = <1>;
-
-				main_rc_osc: main_rc_osc {
-					compatible = "atmel,at91sam9x5-clk-main-rc-osc";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_MOSCRCS>;
-					clock-frequency = <12000000>;
-					clock-accuracy = <50000000>;
-				};
-
-				main_osc: main_osc {
-					compatible = "atmel,at91rm9200-clk-main-osc";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_MOSCS>;
-					clocks = <&main_xtal>;
-				};
-
-				main: mainck {
-					compatible = "atmel,at91sam9x5-clk-main";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_MOSCSELS>;
-					clocks = <&main_rc_osc>, <&main_osc>;
-				};
-
-				plla: pllack {
-					compatible = "atmel,at91rm9200-clk-pll";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_LOCKA>;
-					clocks = <&main>;
-					reg = <0>;
-					atmel,clk-input-range = <2000000 32000000>;
-					#atmel,pll-clk-output-range-cells = <4>;
-					atmel,pll-clk-output-ranges = <745000000 800000000 0 0>,
-								      <695000000 750000000 1 0>,
-								      <645000000 700000000 2 0>,
-								      <595000000 650000000 3 0>,
-								      <545000000 600000000 0 1>,
-								      <495000000 555000000 1 1>,
-								      <445000000 500000000 2 1>,
-								      <400000000 450000000 3 1>;
-				};
-
-				plladiv: plladivck {
-					compatible = "atmel,at91sam9x5-clk-plldiv";
-					#clock-cells = <0>;
-					clocks = <&plla>;
-				};
-
-				pllb: pllbck {
-					compatible = "atmel,at91rm9200-clk-pll";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_LOCKB>;
-					clocks = <&main>;
-					reg = <1>;
-					atmel,clk-input-range = <2000000 32000000>;
-					#atmel,pll-clk-output-range-cells = <3>;
-					atmel,pll-clk-output-ranges = <30000000 100000000 0>;
-				};
-
-				mck: masterck {
-					compatible = "atmel,at91sam9x5-clk-master";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_MCKRDY>;
-					clocks = <&clk32k>, <&main>, <&plladiv>, <&pllb>;
-					atmel,clk-output-range = <0 133333333>;
-					atmel,clk-divisors = <1 2 4 3>;
-					atmel,master-clk-have-div3-pres;
-				};
-
-				usb: usbck {
-					compatible = "atmel,at91sam9n12-clk-usb";
-					#clock-cells = <0>;
-					clocks = <&pllb>;
-				};
-
-				prog: progck {
-					compatible = "atmel,at91sam9x5-clk-programmable";
-					#address-cells = <1>;
-					#size-cells = <0>;
-					interrupt-parent = <&pmc>;
-					clocks = <&clk32k>, <&main>, <&plladiv>, <&pllb>, <&mck>;
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
-				};
-
-				systemck {
-					compatible = "atmel,at91rm9200-clk-system";
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					ddrck: ddrck {
-						#clock-cells = <0>;
-						reg = <2>;
-						clocks = <&mck>;
-					};
-
-					lcdck: lcdck {
-						#clock-cells = <0>;
-						reg = <3>;
-						clocks = <&mck>;
-					};
-
-					uhpck: uhpck {
-						#clock-cells = <0>;
-						reg = <6>;
-						clocks = <&usb>;
-					};
-
-					udpck: udpck {
-						#clock-cells = <0>;
-						reg = <7>;
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
-				};
-
-				periphck {
-					compatible = "atmel,at91sam9x5-clk-peripheral";
-					#address-cells = <1>;
-					#size-cells = <0>;
-					clocks = <&mck>;
-
-					pioAB_clk: pioAB_clk {
-						#clock-cells = <0>;
-						reg = <2>;
-					};
-
-					pioCD_clk: pioCD_clk {
-						#clock-cells = <0>;
-						reg = <3>;
-					};
-
-					fuse_clk: fuse_clk {
-						#clock-cells = <0>;
-						reg = <4>;
-					};
-
-					usart0_clk: usart0_clk {
-						#clock-cells = <0>;
-						reg = <5>;
-					};
-
-					usart1_clk: usart1_clk {
-						#clock-cells = <0>;
-						reg = <6>;
-					};
-
-					usart2_clk: usart2_clk {
-						#clock-cells = <0>;
-						reg = <7>;
-					};
-
-					usart3_clk: usart3_clk {
-						#clock-cells = <0>;
-						reg = <8>;
-					};
-
-					twi0_clk: twi0_clk {
-						reg = <9>;
-						#clock-cells = <0>;
-					};
-
-					twi1_clk: twi1_clk {
-						#clock-cells = <0>;
-						reg = <10>;
-					};
-
-					mci0_clk: mci0_clk {
-						#clock-cells = <0>;
-						reg = <12>;
-					};
-
-					spi0_clk: spi0_clk {
-						#clock-cells = <0>;
-						reg = <13>;
-					};
-
-					spi1_clk: spi1_clk {
-						#clock-cells = <0>;
-						reg = <14>;
-					};
-
-					uart0_clk: uart0_clk {
-						#clock-cells = <0>;
-						reg = <15>;
-					};
-
-					uart1_clk: uart1_clk {
-						#clock-cells = <0>;
-						reg = <16>;
-					};
-
-					tcb_clk: tcb_clk {
-						#clock-cells = <0>;
-						reg = <17>;
-					};
-
-					pwm_clk: pwm_clk {
-						#clock-cells = <0>;
-						reg = <18>;
-					};
-
-					adc_clk: adc_clk {
-						#clock-cells = <0>;
-						reg = <19>;
-					};
-
-					dma0_clk: dma0_clk {
-						#clock-cells = <0>;
-						reg = <20>;
-					};
-
-					uhphs_clk: uhphs_clk {
-						#clock-cells = <0>;
-						reg = <22>;
-					};
-
-					udphs_clk: udphs_clk {
-						#clock-cells = <0>;
-						reg = <23>;
-					};
-
-					lcdc_clk: lcdc_clk {
-						#clock-cells = <0>;
-						reg = <25>;
-					};
-
-					sha_clk: sha_clk {
-						#clock-cells = <0>;
-						reg = <27>;
-					};
-
-					ssc0_clk: ssc0_clk {
-						#clock-cells = <0>;
-						reg = <28>;
-					};
-
-					aes_clk: aes_clk {
-						#clock-cells = <0>;
-						reg = <29>;
-					};
-
-					trng_clk: trng_clk {
-						#clock-cells = <0>;
-						reg = <30>;
-					};
-				};
 			};
 
 			rstc@fffffe00 {
@@ -406,7 +138,7 @@ pit: timer@fffffe30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffe30 0xf>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-				clocks = <&mck>;
+				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 			};
 
 			clk32k: sckc@fffffe50 {
@@ -422,7 +154,7 @@ mmc0: mmc@f0008000 {
 				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
 				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(0)>;
 				dma-names = "rxtx";
-				clocks = <&mci0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 12>;
 				clock-names = "mci_clk";
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -435,7 +167,7 @@ tcb0: timer@f8008000 {
 				#size-cells = <0>;
 				reg = <0xf8008000 0x100>;
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tcb_clk>, <&clk32k>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 17>, <&clk32k>;
 				clock-names = "t0_clk", "slow_clk";
 			};
 
@@ -445,7 +177,7 @@ tcb1: timer@f800c000 {
 				#size-cells = <0>;
 				reg = <0xf800c000 0x100>;
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tcb_clk>, <&clk32k>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 17>, <&clk32k>;
 				clock-names = "t0_clk", "slow_clk";
 			};
 
@@ -453,7 +185,7 @@ hlcdc: hlcdc@f8038000 {
 				compatible = "atmel,at91sam9n12-hlcdc";
 				reg = <0xf8038000 0x2000>;
 				interrupts = <25 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 25>, <&pmc PMC_TYPE_SYSTEM 3>, <&clk32k>;
 				clock-names = "periph_clk", "sys_clk", "slow_clk";
 				status = "disabled";
 
@@ -482,7 +214,7 @@ dma: dma-controller@ffffec00 {
 				reg = <0xffffec00 0x200>;
 				interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0>;
 				#dma-cells = <2>;
-				clocks = <&dma0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 20>;
 				clock-names = "dma_clk";
 			};
 
@@ -800,7 +532,7 @@ pioA: gpio@fffff400 {
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioAB_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 2>;
 				};
 
 				pioB: gpio@fffff600 {
@@ -811,7 +543,7 @@ pioB: gpio@fffff600 {
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioAB_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 2>;
 				};
 
 				pioC: gpio@fffff800 {
@@ -822,7 +554,7 @@ pioC: gpio@fffff800 {
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioCD_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 3>;
 				};
 
 				pioD: gpio@fffffa00 {
@@ -833,7 +565,7 @@ pioD: gpio@fffffa00 {
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioCD_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 3>;
 				};
 			};
 
@@ -843,7 +575,7 @@ dbgu: serial@fffff200 {
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
-				clocks = <&mck>;
+				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -857,7 +589,7 @@ ssc0: ssc@f0010000 {
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
-				clocks = <&ssc0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 28>;
 				clock-names = "pclk";
 				status = "disabled";
 			};
@@ -868,7 +600,7 @@ usart0: serial@f801c000 {
 				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart0>;
-				clocks = <&usart0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -879,7 +611,7 @@ usart1: serial@f8020000 {
 				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart1>;
-				clocks = <&usart1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -890,7 +622,7 @@ usart2: serial@f8024000 {
 				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart2>;
-				clocks = <&usart2_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -901,7 +633,7 @@ usart3: serial@f8028000 {
 				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart3>;
-				clocks = <&usart3_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -917,7 +649,7 @@ i2c0: i2c@f8010000 {
 				#size-cells = <0>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_i2c0>;
-				clocks = <&twi0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
 				status = "disabled";
 			};
 
@@ -932,7 +664,7 @@ i2c1: i2c@f8014000 {
 				#size-cells = <0>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_i2c1>;
-				clocks = <&twi1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
 				status = "disabled";
 			};
 
@@ -947,7 +679,7 @@ spi0: spi@f0000000 {
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi0>;
-				clocks = <&spi0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
 				clock-names = "spi_clk";
 				status = "disabled";
 			};
@@ -963,7 +695,7 @@ spi1: spi@f0004000 {
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi1>;
-				clocks = <&spi1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
 				clock-names = "spi_clk";
 				status = "disabled";
 			};
@@ -992,7 +724,7 @@ pwm0: pwm@f8034000 {
 				reg = <0xf8034000 0x300>;
 				interrupts = <18 IRQ_TYPE_LEVEL_HIGH 4>;
 				#pwm-cells = <3>;
-				clocks = <&pwm_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 18>;
 				status = "disabled";
 			};
 
@@ -1000,7 +732,7 @@ usb1: gadget@f803c000 {
 				compatible = "atmel,at91sam9260-udc";
 				reg = <0xf803c000 0x4000>;
 				interrupts = <23 IRQ_TYPE_LEVEL_HIGH 2>;
-				clocks = <&udphs_clk>, <&udpck>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 23>, <&pmc PMC_TYPE_SYSTEM 7>;
 				clock-names = "pclk", "hclk";
 				status = "disabled";
 			};
@@ -1010,7 +742,7 @@ usb0: ohci@500000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00500000 0x00100000>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
-			clocks = <&uhphs_clk>, <&uhphs_clk>, <&uhpck>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 22>, <&pmc PMC_TYPE_PERIPHERAL 22>, <&pmc PMC_TYPE_SYSTEM 6>;
 			clock-names = "ohci_clk", "hclk", "uhpck";
 			status = "disabled";
 		};
@@ -1028,7 +760,7 @@ ebi: ebi@10000000 {
 				  0x3 0x0 0x40000000 0x10000000
 				  0x4 0x0 0x50000000 0x10000000
 				  0x5 0x0 0x60000000 0x10000000>;
-			clocks = <&mck>;
+			clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 			status = "disabled";
 
 			nand_controller: nand-controller {
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index ea5cef0b0974..186c98160cab 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -59,7 +59,7 @@ i2c0: i2c@f8010000 {
 				wm8904: codec@1a {
 					compatible = "wlf,wm8904";
 					reg = <0x1a>;
-					clocks = <&pck0>;
+					clocks = <&pmc PMC_TYPE_SYSTEM 8>;
 					clock-names = "mclk";
 				};
 
-- 
2.24.1

