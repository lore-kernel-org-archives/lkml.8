Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DB0C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4773020E65
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgHaRMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:12:12 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:35739 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbgHaRLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:11:45 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 35C1C60008;
        Mon, 31 Aug 2020 17:11:42 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/5] ARM: at91: dts: move mmc pinctrl-names property to board dts
Date:   Mon, 31 Aug 2020 19:11:26 +0200
Message-Id: <20200831171129.3886857-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831171129.3886857-1-alexandre.belloni@bootlin.com>
References: <20200831171129.3886857-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having the pinctrl-names property in the dtsi leads to dtbs_check warnings
when the board dts doesn't define pinctrl-0. Instead, move the property to
the board dts actually using the mmc node.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/animeo_ip.dts             | 1 +
 arch/arm/boot/dts/at91-ariag25.dts          | 1 +
 arch/arm/boot/dts/at91-ariettag25.dts       | 1 +
 arch/arm/boot/dts/at91-cosino.dtsi          | 1 +
 arch/arm/boot/dts/at91-cosino_mega2560.dts  | 1 +
 arch/arm/boot/dts/at91-foxg20.dts           | 1 +
 arch/arm/boot/dts/at91-qil_a9260.dts        | 1 +
 arch/arm/boot/dts/at91-sam9_l9260.dts       | 1 +
 arch/arm/boot/dts/at91-wb45n.dtsi           | 1 +
 arch/arm/boot/dts/at91rm9200.dtsi           | 1 -
 arch/arm/boot/dts/at91sam9260.dtsi          | 1 -
 arch/arm/boot/dts/at91sam9260ek.dts         | 1 +
 arch/arm/boot/dts/at91sam9263.dtsi          | 2 --
 arch/arm/boot/dts/at91sam9263ek.dts         | 1 +
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi | 1 +
 arch/arm/boot/dts/at91sam9g45.dtsi          | 2 --
 arch/arm/boot/dts/at91sam9m10g45ek.dts      | 2 ++
 arch/arm/boot/dts/at91sam9x5.dtsi           | 2 --
 arch/arm/boot/dts/at91sam9x5ek.dtsi         | 2 ++
 arch/arm/boot/dts/pm9g45.dts                | 1 +
 20 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
index c36d28c295d6..6d7fc9c6c6e0 100644
--- a/arch/arm/boot/dts/animeo_ip.dts
+++ b/arch/arm/boot/dts/animeo_ip.dts
@@ -81,6 +81,7 @@ mmc0: mmc@fffa8000 {
 				pinctrl-0 = <&pinctrl_mmc0_clk
 					     &pinctrl_mmc0_slot1_cmd_dat0
 					     &pinctrl_mmc0_slot1_dat1_3>;
+				pinctrl-names = "default";
 				status = "okay";
 
 				slot@1 {
diff --git a/arch/arm/boot/dts/at91-ariag25.dts b/arch/arm/boot/dts/at91-ariag25.dts
index dbfefef2869d..2ef39ecbda18 100644
--- a/arch/arm/boot/dts/at91-ariag25.dts
+++ b/arch/arm/boot/dts/at91-ariag25.dts
@@ -93,6 +93,7 @@ &mmc0 {
 	pinctrl-0 = <
 		&pinctrl_mmc0_slot0_clk_cmd_dat0
 		&pinctrl_mmc0_slot0_dat1_3>;
+	pinctrl-names = "default";
 	status = "okay";
 
 	slot@0 {
diff --git a/arch/arm/boot/dts/at91-ariettag25.dts b/arch/arm/boot/dts/at91-ariettag25.dts
index 0267e72c074a..2eb494f49078 100644
--- a/arch/arm/boot/dts/at91-ariettag25.dts
+++ b/arch/arm/boot/dts/at91-ariettag25.dts
@@ -48,6 +48,7 @@ &mmc0 {
 	pinctrl-0 = <
 		&pinctrl_mmc0_slot0_clk_cmd_dat0
 		&pinctrl_mmc0_slot0_dat1_3>;
+	pinctrl-names = "default";
 	status = "okay";
 
 	slot@0 {
diff --git a/arch/arm/boot/dts/at91-cosino.dtsi b/arch/arm/boot/dts/at91-cosino.dtsi
index feebd54f670e..91e386d4872f 100644
--- a/arch/arm/boot/dts/at91-cosino.dtsi
+++ b/arch/arm/boot/dts/at91-cosino.dtsi
@@ -112,6 +112,7 @@ &mmc0 {
 		&pinctrl_board_mmc0
 		&pinctrl_mmc0_slot0_clk_cmd_dat0
 		&pinctrl_mmc0_slot0_dat1_3>;
+	pinctrl-names = "default";
 	status = "okay";
 
 	slot@0 {
diff --git a/arch/arm/boot/dts/at91-cosino_mega2560.dts b/arch/arm/boot/dts/at91-cosino_mega2560.dts
index 73e88d1ba4ed..04cb7bee937d 100644
--- a/arch/arm/boot/dts/at91-cosino_mega2560.dts
+++ b/arch/arm/boot/dts/at91-cosino_mega2560.dts
@@ -34,6 +34,7 @@ &mmc1 {
 	pinctrl-0 = <
 		&pinctrl_mmc1_slot0_clk_cmd_dat0
 		&pinctrl_mmc1_slot0_dat1_3>;
+	pinctrl-names = "default";
 	status = "okay";
 
 	slot@0 {
diff --git a/arch/arm/boot/dts/at91-foxg20.dts b/arch/arm/boot/dts/at91-foxg20.dts
index 683b9e37f9c5..c0509c4e5138 100644
--- a/arch/arm/boot/dts/at91-foxg20.dts
+++ b/arch/arm/boot/dts/at91-foxg20.dts
@@ -55,6 +55,7 @@ mmc0: mmc@fffa8000 {
 					&pinctrl_mmc0_clk
 					&pinctrl_mmc0_slot1_cmd_dat0
 					&pinctrl_mmc0_slot1_dat1_3>;
+				pinctrl-names = "default";
 				status = "okay";
 
 				slot@1 {
diff --git a/arch/arm/boot/dts/at91-qil_a9260.dts b/arch/arm/boot/dts/at91-qil_a9260.dts
index a50b7fd2149f..ee8525d5a5da 100644
--- a/arch/arm/boot/dts/at91-qil_a9260.dts
+++ b/arch/arm/boot/dts/at91-qil_a9260.dts
@@ -52,6 +52,7 @@ mmc0: mmc@fffa8000 {
 					&pinctrl_mmc0_clk
 					&pinctrl_mmc0_slot0_cmd_dat0
 					&pinctrl_mmc0_slot0_dat1_3>;
+				pinctrl-names = "default";
 				status = "okay";
 				slot@0 {
 					reg = <0>;
diff --git a/arch/arm/boot/dts/at91-sam9_l9260.dts b/arch/arm/boot/dts/at91-sam9_l9260.dts
index 954404ed8158..f475c0b0f1de 100644
--- a/arch/arm/boot/dts/at91-sam9_l9260.dts
+++ b/arch/arm/boot/dts/at91-sam9_l9260.dts
@@ -49,6 +49,7 @@ &pinctrl_board_mmc0
 					&pinctrl_mmc0_clk
 					&pinctrl_mmc0_slot1_cmd_dat0
 					&pinctrl_mmc0_slot1_dat1_3>;
+				pinctrl-names = "default";
 				status = "okay";
 
 				slot@1 {
diff --git a/arch/arm/boot/dts/at91-wb45n.dtsi b/arch/arm/boot/dts/at91-wb45n.dtsi
index ebe61a25ca96..e3d98306ee3a 100644
--- a/arch/arm/boot/dts/at91-wb45n.dtsi
+++ b/arch/arm/boot/dts/at91-wb45n.dtsi
@@ -145,6 +145,7 @@ &usb2 {
 };
 
 &mmc0 {
+	pinctrl-names = "default";
 	pinctrl-0 = <
 		&pinctrl_mmc0_slot0_clk_cmd_dat0
 		&pinctrl_mmc0_slot0_dat1_3>;
diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 1724e14d9994..0ea0aff2a024 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -173,7 +173,6 @@ mmc0: mmc@fffb4000 {
 				clock-names = "mci_clk";
 				#address-cells = <1>;
 				#size-cells = <0>;
-				pinctrl-names = "default";
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index f6ac5346f910..b07578ff214c 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -654,7 +654,6 @@ mmc0: mmc@fffa8000 {
 				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				pinctrl-names = "default";
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
 				clock-names = "mci_clk";
 				status = "disabled";
diff --git a/arch/arm/boot/dts/at91sam9260ek.dts b/arch/arm/boot/dts/at91sam9260ek.dts
index 81f808a10931..657dc3a420d6 100644
--- a/arch/arm/boot/dts/at91sam9260ek.dts
+++ b/arch/arm/boot/dts/at91sam9260ek.dts
@@ -55,6 +55,7 @@ &pinctrl_board_mmc0_slot1
 					&pinctrl_mmc0_clk
 					&pinctrl_mmc0_slot1_cmd_dat0
 					&pinctrl_mmc0_slot1_dat1_3>;
+				pinctrl-names = "default";
 				status = "okay";
 				slot@1 {
 					reg = <1>;
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index a321c68be64f..aea70a32511c 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -654,7 +654,6 @@ mmc0: mmc@fff80000 {
 				compatible = "atmel,hsmci";
 				reg = <0xfff80000 0x600>;
 				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 0>;
-				pinctrl-names = "default";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
@@ -666,7 +665,6 @@ mmc1: mmc@fff84000 {
 				compatible = "atmel,hsmci";
 				reg = <0xfff84000 0x600>;
 				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 0>;
-				pinctrl-names = "default";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index 62d218542a48..bf89cb2bbdd9 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -72,6 +72,7 @@ &pinctrl_board_mmc0
 					&pinctrl_mmc0_clk
 					&pinctrl_mmc0_slot0_cmd_dat0
 					&pinctrl_mmc0_slot0_dat1_3>;
+				pinctrl-names = "default";
 				status = "okay";
 				slot@0 {
 					reg = <0>;
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index bda22700110c..c65651549692 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -93,6 +93,7 @@ &pinctrl_board_mmc0_slot1
 					&pinctrl_mmc0_clk
 					&pinctrl_mmc0_slot1_cmd_dat0
 					&pinctrl_mmc0_slot1_dat1_3>;
+				pinctrl-names = "default";
 				status = "okay";
 				slot@1 {
 					reg = <1>;
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 984b5292a129..1e1b7490ee0a 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -875,7 +875,6 @@ mmc0: mmc@fff80000 {
 				compatible = "atmel,hsmci";
 				reg = <0xfff80000 0x600>;
 				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 0>;
-				pinctrl-names = "default";
 				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(0)>;
 				dma-names = "rxtx";
 				#address-cells = <1>;
@@ -889,7 +888,6 @@ mmc1: mmc@fffd0000 {
 				compatible = "atmel,hsmci";
 				reg = <0xfffd0000 0x600>;
 				interrupts = <29 IRQ_TYPE_LEVEL_HIGH 0>;
-				pinctrl-names = "default";
 				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(13)>;
 				dma-names = "rxtx";
 				#address-cells = <1>;
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index a3a5c82d9f29..09b29126f60d 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -99,6 +99,7 @@ mmc0: mmc@fff80000 {
 					&pinctrl_board_mmc0
 					&pinctrl_mmc0_slot0_clk_cmd_dat0
 					&pinctrl_mmc0_slot0_dat1_3>;
+				pinctrl-names = "default";
 				status = "okay";
 				slot@0 {
 					reg = <0>;
@@ -112,6 +113,7 @@ mmc1: mmc@fffd0000 {
 					&pinctrl_board_mmc1
 					&pinctrl_mmc1_slot0_clk_cmd_dat0
 					&pinctrl_mmc1_slot0_dat1_3>;
+				pinctrl-names = "default";
 				status = "okay";
 				slot@0 {
 					reg = <0>;
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index a5a1838c2524..79076e4ed1e0 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -651,7 +651,6 @@ mmc0: mmc@f0008000 {
 				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
 				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(0)>;
 				dma-names = "rxtx";
-				pinctrl-names = "default";
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 12>;
 				clock-names = "mci_clk";
 				#address-cells = <1>;
@@ -665,7 +664,6 @@ mmc1: mmc@f000c000 {
 				interrupts = <26 IRQ_TYPE_LEVEL_HIGH 0>;
 				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(0)>;
 				dma-names = "rxtx";
-				pinctrl-names = "default";
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 26>;
 				clock-names = "mci_clk";
 				#address-cells = <1>;
diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index c934928742b0..6d1264de6060 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -56,6 +56,7 @@ &mmc0 {
 		&pinctrl_board_mmc0
 		&pinctrl_mmc0_slot0_clk_cmd_dat0
 		&pinctrl_mmc0_slot0_dat1_3>;
+	pinctrl-names = "default";
 	status = "okay";
 
 	slot@0 {
@@ -70,6 +71,7 @@ &mmc1 {
 		&pinctrl_board_mmc1
 		&pinctrl_mmc1_slot0_clk_cmd_dat0
 		&pinctrl_mmc1_slot0_dat1_3>;
+	pinctrl-names = "default";
 	status = "okay";
 
 	slot@0 {
diff --git a/arch/arm/boot/dts/pm9g45.dts b/arch/arm/boot/dts/pm9g45.dts
index 4dfe0f15d7bd..f52f5eea430a 100644
--- a/arch/arm/boot/dts/pm9g45.dts
+++ b/arch/arm/boot/dts/pm9g45.dts
@@ -68,6 +68,7 @@ mmc0: mmc@fff80000 {
 					&pinctrl_board_mmc
 					&pinctrl_mmc0_slot0_clk_cmd_dat0
 					&pinctrl_mmc0_slot0_dat1_3>;
+				pinctrl-names = "default";
 				status = "okay";
 				slot@0 {
 					reg = <0>;
-- 
2.26.2

