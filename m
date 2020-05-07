Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6B6C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6243920659
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgEGP5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:57:21 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46575 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbgEGP5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:57:18 -0400
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D75496000E;
        Thu,  7 May 2020 15:57:13 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v2 3/3] ARM: dts: at91: Remove the USB EP child node
Date:   Thu,  7 May 2020 17:56:51 +0200
Message-Id: <20200507155651.1094142-4-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507155651.1094142-1-gregory.clement@bootlin.com>
References: <20200507155651.1094142-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The endpoint configuration used to be stored in the device tree,
however the configuration depend on the "version" of the controller
itself.

Then the EP child node are useless and describe as deprecated in the
documentation binding: remove all the nodes from the SoC device tree
file. Remove also the #address-cells and #size-cells properties that
are no longer needed.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm/boot/dts/at91sam9g45.dtsi |  54 -------------
 arch/arm/boot/dts/at91sam9rl.dtsi  |  54 -------------
 arch/arm/boot/dts/at91sam9x5.dtsi  |  54 -------------
 arch/arm/boot/dts/sama5d2.dtsi     | 120 -----------------------------
 arch/arm/boot/dts/sama5d3.dtsi     | 107 -------------------------
 arch/arm/boot/dts/sama5d4.dtsi     | 120 -----------------------------
 6 files changed, 509 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index fd179097a4bf..342697f53cf7 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -1195,8 +1195,6 @@ spi1: spi@fffa8000 {
 			};
 
 			usb2: gadget@fff78000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
 				compatible = "atmel,at91sam9g45-udc";
 				reg = <0x00600000 0x80000
 				       0xfff78000 0x400>;
@@ -1204,58 +1202,6 @@ usb2: gadget@fff78000 {
 				clocks = <&udphs_clk>, <&utmi>;
 				clock-names = "pclk", "hclk";
 				status = "disabled";
-
-				ep@0 {
-					reg = <0>;
-					atmel,fifo-size = <64>;
-					atmel,nb-banks = <1>;
-				};
-
-				ep@1 {
-					reg = <1>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <2>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
-
-				ep@2 {
-					reg = <2>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <2>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
-
-				ep@3 {
-					reg = <3>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-				};
-
-				ep@4 {
-					reg = <4>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-				};
-
-				ep@5 {
-					reg = <5>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
-
-				ep@6 {
-					reg = <6>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
 			};
 
 			clk32k: sckc@fffffd50 {
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index ea024e4b6e09..4d70194fd808 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -299,8 +299,6 @@ trigger3 {
 			};
 
 			usb0: gadget@fffd4000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
 				compatible = "atmel,at91sam9rl-udc";
 				reg = <0x00600000 0x100000>,
 				      <0xfffd4000 0x4000>;
@@ -308,58 +306,6 @@ usb0: gadget@fffd4000 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 22>, <&pmc PMC_TYPE_CORE PMC_UTMI>;
 				clock-names = "pclk", "hclk";
 				status = "disabled";
-
-				ep@0 {
-					reg = <0>;
-					atmel,fifo-size = <64>;
-					atmel,nb-banks = <1>;
-				};
-
-				ep@1 {
-					reg = <1>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <2>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
-
-				ep@2 {
-					reg = <2>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <2>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
-
-				ep@3 {
-					reg = <3>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-				};
-
-				ep@4 {
-					reg = <4>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-				};
-
-				ep@5 {
-					reg = <5>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
-
-				ep@6 {
-					reg = <6>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
 			};
 
 			dma0: dma-controller@ffffe600 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 7c2eb93f8cac..948fe99ab6c3 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -867,8 +867,6 @@ spi1: spi@f0004000 {
 			};
 
 			usb2: gadget@f803c000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
 				compatible = "atmel,at91sam9g45-udc";
 				reg = <0x00500000 0x80000
 				       0xf803c000 0x400>;
@@ -876,58 +874,6 @@ usb2: gadget@f803c000 {
 				clocks = <&pmc PMC_TYPE_CORE PMC_UTMI>, <&pmc PMC_TYPE_PERIPHERAL 23>;
 				clock-names = "hclk", "pclk";
 				status = "disabled";
-
-				ep@0 {
-					reg = <0>;
-					atmel,fifo-size = <64>;
-					atmel,nb-banks = <1>;
-				};
-
-				ep@1 {
-					reg = <1>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <2>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
-
-				ep@2 {
-					reg = <2>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <2>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
-
-				ep@3 {
-					reg = <3>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-				};
-
-				ep@4 {
-					reg = <4>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-				};
-
-				ep@5 {
-					reg = <5>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
-
-				ep@6 {
-					reg = <6>;
-					atmel,fifo-size = <1024>;
-					atmel,nb-banks = <3>;
-					atmel,can-dma;
-					atmel,can-isoc;
-				};
 			};
 
 			watchdog: watchdog@fffffe40 {
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index ab550d69db91..1ae7a2ea696b 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -113,8 +113,6 @@ nfc_sram: sram@100000 {
 		};
 
 		usb0: gadget@300000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
 			compatible = "atmel,sama5d3-udc";
 			reg = <0x00300000 0x100000
 			       0xfc02c000 0x400>;
@@ -122,124 +120,6 @@ usb0: gadget@300000 {
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 42>, <&pmc PMC_TYPE_CORE PMC_UTMI>;
 			clock-names = "pclk", "hclk";
 			status = "disabled";
-
-			ep@0 {
-				reg = <0>;
-				atmel,fifo-size = <64>;
-				atmel,nb-banks = <1>;
-			};
-
-			ep@1 {
-				reg = <1>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <3>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@2 {
-				reg = <2>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <3>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@3 {
-				reg = <3>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@4 {
-				reg = <4>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@5 {
-				reg = <5>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@6 {
-				reg = <6>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@7 {
-				reg = <7>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@8 {
-				reg = <8>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@9 {
-				reg = <9>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@10 {
-				reg = <10>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@11 {
-				reg = <11>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@12 {
-				reg = <12>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@13 {
-				reg = <13>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@14 {
-				reg = <14>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@15 {
-				reg = <15>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
 		};
 
 		usb1: ohci@400000 {
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index f11b018e9173..10e4492af234 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1420,8 +1420,6 @@ nfc_sram: sram@200000 {
 		};
 
 		usb0: gadget@500000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
 			compatible = "atmel,sama5d3-udc";
 			reg = <0x00500000 0x100000
 			       0xf8030000 0x4000>;
@@ -1429,111 +1427,6 @@ usb0: gadget@500000 {
 			clocks = <&udphs_clk>, <&utmi>;
 			clock-names = "pclk", "hclk";
 			status = "disabled";
-
-			ep@0 {
-				reg = <0>;
-				atmel,fifo-size = <64>;
-				atmel,nb-banks = <1>;
-			};
-
-			ep@1 {
-				reg = <1>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <3>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@2 {
-				reg = <2>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <3>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@3 {
-				reg = <3>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-			};
-
-			ep@4 {
-				reg = <4>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-			};
-
-			ep@5 {
-				reg = <5>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-			};
-
-			ep@6 {
-				reg = <6>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-			};
-
-			ep@7 {
-				reg = <7>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-			};
-
-			ep@8 {
-				reg = <8>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-			};
-
-			ep@9 {
-				reg = <9>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-			};
-
-			ep@10 {
-				reg = <10>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-			};
-
-			ep@11 {
-				reg = <11>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-			};
-
-			ep@12 {
-				reg = <12>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-			};
-
-			ep@13 {
-				reg = <13>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-			};
-
-			ep@14 {
-				reg = <14>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-			};
-
-			ep@15 {
-				reg = <15>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-			};
 		};
 
 		usb1: ohci@600000 {
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index c9c0316b5b0e..b0d79524277e 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -96,8 +96,6 @@ nfc_sram: sram@100000 {
 		};
 
 		usb0: gadget@400000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
 			compatible = "atmel,sama5d3-udc";
 			reg = <0x00400000 0x100000
 			       0xfc02c000 0x4000>;
@@ -105,124 +103,6 @@ usb0: gadget@400000 {
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 47>, <&pmc PMC_TYPE_CORE PMC_UTMI>;
 			clock-names = "pclk", "hclk";
 			status = "disabled";
-
-			ep@0 {
-				reg = <0>;
-				atmel,fifo-size = <64>;
-				atmel,nb-banks = <1>;
-			};
-
-			ep@1 {
-				reg = <1>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <3>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@2 {
-				reg = <2>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <3>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@3 {
-				reg = <3>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@4 {
-				reg = <4>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@5 {
-				reg = <5>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@6 {
-				reg = <6>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@7 {
-				reg = <7>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-dma;
-				atmel,can-isoc;
-			};
-
-			ep@8 {
-				reg = <8>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@9 {
-				reg = <9>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@10 {
-				reg = <10>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@11 {
-				reg = <11>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@12 {
-				reg = <12>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@13 {
-				reg = <13>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@14 {
-				reg = <14>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
-
-			ep@15 {
-				reg = <15>;
-				atmel,fifo-size = <1024>;
-				atmel,nb-banks = <2>;
-				atmel,can-isoc;
-			};
 		};
 
 		usb1: ohci@500000 {
-- 
2.26.2

