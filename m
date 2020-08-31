Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC8AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78FE020678
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgHaRMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:12:14 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:47735 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgHaRLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:11:45 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 6FF12C0005;
        Mon, 31 Aug 2020 17:11:40 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/5] ARM: dts: at91: fix sram nodes
Date:   Mon, 31 Aug 2020 19:11:25 +0200
Message-Id: <20200831171129.3886857-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831171129.3886857-1-alexandre.belloni@bootlin.com>
References: <20200831171129.3886857-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ranges, #address-cells and #size-cells properties are mandatory, add
them to the sram nodes.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi  | 3 +++
 arch/arm/boot/dts/at91sam9260.dtsi | 3 +++
 arch/arm/boot/dts/at91sam9261.dtsi | 3 +++
 arch/arm/boot/dts/at91sam9263.dtsi | 6 ++++++
 arch/arm/boot/dts/at91sam9g20.dtsi | 3 +++
 arch/arm/boot/dts/at91sam9g45.dtsi | 3 +++
 arch/arm/boot/dts/at91sam9n12.dtsi | 3 +++
 arch/arm/boot/dts/at91sam9rl.dtsi  | 3 +++
 arch/arm/boot/dts/at91sam9x5.dtsi  | 3 +++
 arch/arm/boot/dts/at91sam9xe.dtsi  | 3 +++
 arch/arm/boot/dts/sam9x60.dtsi     | 3 +++
 arch/arm/boot/dts/sama5d2.dtsi     | 7 +++++++
 arch/arm/boot/dts/sama5d3.dtsi     | 6 ++++++
 arch/arm/boot/dts/sama5d4.dtsi     | 6 ++++++
 14 files changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 231313e4c926..1724e14d9994 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -71,6 +71,9 @@ main_xtal: main_xtal {
 	sram: sram@200000 {
 		compatible = "mmio-sram";
 		reg = <0x00200000 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x00200000 0x4000>;
 	};
 
 	ahb {
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 85041ad5e29a..f6ac5346f910 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -74,6 +74,9 @@ adc_op_clk: adc_op_clk{
 	sram0: sram@2ff000 {
 		compatible = "mmio-sram";
 		reg = <0x002ff000 0x2000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x002ff000 0x2000>;
 	};
 
 	ahb {
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index bb6480afc6f6..980cc308fec5 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -65,6 +65,9 @@ slow_xtal: slow_xtal {
 	sram: sram@300000 {
 		compatible = "mmio-sram";
 		reg = <0x00300000 0x28000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x00300000 0x28000>;
 	};
 
 	ahb {
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index a94fa2ae482c..a321c68be64f 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -67,11 +67,17 @@ slow_xtal: slow_xtal {
 	sram0: sram@300000 {
 		compatible = "mmio-sram";
 		reg = <0x00300000 0x14000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x00300000 0x14000>;
 	};
 
 	sram1: sram@500000 {
 		compatible = "mmio-sram";
 		reg = <0x00500000 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x00500000 0x4000>;
 	};
 
 	ahb {
diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 4117cf880508..86b4e943089a 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -22,6 +22,9 @@ sram0: sram@2ff000 {
 	sram1: sram@2fc000 {
 		compatible = "mmio-sram";
 		reg = <0x002fc000 0x8000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x002fc000 0x8000>;
 	};
 
 	ahb {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 8fe2dbd39040..984b5292a129 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -79,6 +79,9 @@ adc_op_clk: adc_op_clk{
 	sram: sram@300000 {
 		compatible = "mmio-sram";
 		reg = <0x00300000 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x00300000 0x10000>;
 	};
 
 	ahb {
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 9e1dc0070193..5c27ead05284 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -69,6 +69,9 @@ main_xtal: main_xtal {
 	sram: sram@300000 {
 		compatible = "mmio-sram";
 		reg = <0x00300000 0x8000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x00300000 0x8000>;
 	};
 
 	ahb {
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index b737f21f1b4c..eb5bea473bc8 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -76,6 +76,9 @@ adc_op_clk: adc_op_clk{
 	sram: sram@300000 {
 		compatible = "mmio-sram";
 		reg = <0x00300000 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x00300000 0x10000>;
 	};
 
 	ahb {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 442d3b8cda69..a5a1838c2524 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -77,6 +77,9 @@ adc_op_clk: adc_op_clk{
 	sram: sram@300000 {
 		compatible = "mmio-sram";
 		reg = <0x00300000 0x8000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x00300000 0x8000>;
 	};
 
 	ahb {
diff --git a/arch/arm/boot/dts/at91sam9xe.dtsi b/arch/arm/boot/dts/at91sam9xe.dtsi
index 3f9d8caf8b0a..f571f77779c3 100644
--- a/arch/arm/boot/dts/at91sam9xe.dtsi
+++ b/arch/arm/boot/dts/at91sam9xe.dtsi
@@ -19,5 +19,8 @@ sram0: sram@2ff000 {
 	sram1: sram@300000 {
 		compatible = "mmio-sram";
 		reg = <0x00300000 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x00300000 0x4000>;
 	};
 };
diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
index 3a9fa40b2b1c..3e85c2a0d198 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -62,6 +62,9 @@ main_xtal: main_xtal {
 	sram: sram@300000 {
 		compatible = "mmio-sram";
 		reg = <0x00300000 0x100000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x00300000 0x100000>;
 	};
 
 	ahb {
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index d7f25706892d..ddd7f9b05aa2 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -94,6 +94,9 @@ main_xtal: main_xtal {
 	ns_sram: sram@200000 {
 		compatible = "mmio-sram";
 		reg = <0x00200000 0x20000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x00200000 0x20000>;
 	};
 
 	ahb {
@@ -106,6 +109,10 @@ nfc_sram: sram@100000 {
 			compatible = "mmio-sram";
 			no-memory-wc;
 			reg = <0x00100000 0x2400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x00100000 0x2400>;
+
 		};
 
 		usb0: gadget@300000 {
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 0bb5b6fa0748..4f9001188511 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -83,6 +83,9 @@ adc_op_clk: adc_op_clk{
 	sram: sram@300000 {
 		compatible = "mmio-sram";
 		reg = <0x00300000 0x20000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x00300000 0x20000>;
 	};
 
 	ahb {
@@ -1073,6 +1076,9 @@ nfc_sram: sram@200000 {
 			compatible = "mmio-sram";
 			no-memory-wc;
 			reg = <0x200000 0x2400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x200000 0x2400>;
 		};
 
 		usb0: gadget@500000 {
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 2d9f853ab15f..1aca4b462f52 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -81,6 +81,9 @@ adc_op_clk: adc_op_clk{
 	ns_sram: sram@210000 {
 		compatible = "mmio-sram";
 		reg = <0x00210000 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x00210000 0x10000>;
 	};
 
 	ahb {
@@ -93,6 +96,9 @@ nfc_sram: sram@100000 {
 			compatible = "mmio-sram";
 			no-memory-wc;
 			reg = <0x100000 0x2400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x100000 0x2400>;
 		};
 
 		usb0: gadget@400000 {
-- 
2.26.2

