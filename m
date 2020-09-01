Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D84C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A0B7206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PFNW8z3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgIAWbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:31:39 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47148 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgIAWbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:31:17 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 081MV7Ci011960;
        Tue, 1 Sep 2020 17:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598999467;
        bh=Yd3vtqhEXUYBJs790wvZthLwGwrz+f/3CptyNXimaQA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PFNW8z3Twn1dXApk/wUnCLzdW/F2YrsJR/I9kGGhU6nhNsWMIf1IS89Z3C8tb5hGX
         cZgwiSsdTdjGtZn8Q1gNCEfkqzwtmXMwB/fM5NblkhYR6ASj7QzJaZpQXvlAvEljBQ
         0e4wGT1mstY8aBFfclcSCOOoXhG/z4HbKGC5Hrns=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 081MV6Uf053956
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Sep 2020 17:31:07 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 1 Sep
 2020 17:31:06 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 1 Sep 2020 17:31:06 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 081MV6sb025399;
        Tue, 1 Sep 2020 17:31:06 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH 7/7] arm64: dts: ti: k3-*: Fix up node_name_chars_strict errors
Date:   Tue, 1 Sep 2020 17:30:59 -0500
Message-ID: <20200901223059.14801-8-nm@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901223059.14801-1-nm@ti.com>
References: <20200901223059.14801-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with W=2 throws up a bunch of easy to fixup errors..
node_name_chars_strict is one of them.. Knock those out.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi       |  6 +++---
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi        |  4 ++--
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 16 ++++++++--------
 .../dts/ti/k3-am654-industrial-thermal.dtsi    | 12 ++++++------
 .../boot/dts/ti/k3-j721e-common-proc-board.dts | 18 +++++++++---------
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi      |  6 +++---
 .../arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi |  2 +-
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi    |  2 +-
 8 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 9c96e3f58c86..ff3e38408dbc 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -305,7 +305,7 @@
 		no-1-8-v;
 	};
 
-	scm_conf: scm_conf@100000 {
+	scm_conf: scm-conf@100000 {
 		compatible = "syscon", "simple-mfd";
 		reg = <0 0x00100000 0 0x1c000>;
 		#address-cells = <1>;
@@ -344,7 +344,7 @@
 					<0x4090 0x3>; /* SERDES1 lane select */
 		};
 
-		dss_oldi_io_ctrl: dss_oldi_io_ctrl@41E0 {
+		dss_oldi_io_ctrl: dss-oldi-io-ctrl@41E0 {
 			compatible = "syscon";
 			reg = <0x0000041E0 0x14>;
 		};
@@ -445,7 +445,7 @@
 		ti,interrupt-ranges = <0 392 32>;
 	};
 
-	main_navss {
+	main-navss {
 		compatible = "simple-mfd";
 		#address-cells = <2>;
 		#size-cells = <2>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 6dfec68ac865..435e51019287 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -6,7 +6,7 @@
  */
 
 &cbass_mcu {
-	mcu_conf: scm_conf@40f00000 {
+	mcu_conf: scm-conf@40f00000 {
 		compatible = "syscon", "simple-mfd";
 		reg = <0x0 0x40f00000 0x0 0x20000>;
 		#address-cells = <1>;
@@ -116,7 +116,7 @@
 		};
 	};
 
-	mcu_navss {
+	mcu-navss {
 		compatible = "simple-mfd";
 		#address-cells = <2>;
 		#size-cells = <2>;
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 86c9074cb070..d12dd89f3405 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -29,7 +29,7 @@
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
-		secure_ddr: secure_ddr@9e800000 {
+		secure_ddr: secure-ddr@9e800000 {
 			reg = <0 0x9e800000 0 0x01800000>; /* for OP-TEE */
 			alignment = <0x1000>;
 			no-map;
@@ -70,14 +70,14 @@
 		>;
 	};
 
-	push_button_pins_default: push_button__pins_default {
+	push_button_pins_default: push-button-pins-default {
 		pinctrl-single,pins = <
 			AM65X_WKUP_IOPAD(0x0030, PIN_INPUT, 7) /* (R5) WKUP_GPIO0_24 */
 			AM65X_WKUP_IOPAD(0x003c, PIN_INPUT, 7) /* (P2) WKUP_GPIO0_27 */
 		>;
 	};
 
-	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins_default {
+	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins-default {
 		pinctrl-single,pins = <
 			AM65X_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* (V1) MCU_OSPI0_CLK */
 			AM65X_WKUP_IOPAD(0x0008, PIN_INPUT, 0)	 /* (U2) MCU_OSPI0_DQS */
@@ -93,13 +93,13 @@
 		>;
 	};
 
-	wkup_pca554_default: wkup_pca554_default {
+	wkup_pca554_default: wkup-pca554-default {
 		pinctrl-single,pins = <
 			AM65X_WKUP_IOPAD(0x0034, PIN_INPUT, 7) /* (T1) MCU_OSPI1_CLK.WKUP_GPIO0_25 */
 		>;
 	};
 
-	mcu_cpsw_pins_default: mcu_cpsw_pins_default {
+	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
 		pinctrl-single,pins = <
 			AM65X_WKUP_IOPAD(0x0058, PIN_OUTPUT, 0) /* (N4) MCU_RGMII1_TX_CTL */
 			AM65X_WKUP_IOPAD(0x005c, PIN_INPUT, 0) /* (N5) MCU_RGMII1_RX_CTL */
@@ -116,7 +116,7 @@
 		>;
 	};
 
-	mcu_mdio_pins_default: mcu_mdio1_pins_default {
+	mcu_mdio_pins_default: mcu-mdio1-pins-default {
 		pinctrl-single,pins = <
 			AM65X_WKUP_IOPAD(0x008c, PIN_OUTPUT, 0) /* (L1) MCU_MDIO0_MDC */
 			AM65X_WKUP_IOPAD(0x0088, PIN_INPUT, 0) /* (L4) MCU_MDIO0_MDIO */
@@ -167,7 +167,7 @@
 		>;
 	};
 
-	main_mmc1_pins_default: main_mmc1_pins_default {
+	main_mmc1_pins_default: main-mmc1-pins-default {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x02d4, PIN_INPUT_PULLDOWN, 0) /* (C27) MMC1_CLK */
 			AM65X_IOPAD(0x02d8, PIN_INPUT_PULLUP, 0) /* (C28) MMC1_CMD */
@@ -180,7 +180,7 @@
 		>;
 	};
 
-	usb1_pins_default: usb1_pins_default {
+	usb1_pins_default: usb1-pins-default {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x02c0, PIN_OUTPUT, 0) /* (AC8) USB1_DRVVBUS */
 		>;
diff --git a/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
index cdc3d40c3f60..9021c738056b 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
@@ -2,13 +2,13 @@
 
 #include <dt-bindings/thermal/thermal.h>
 
-mpu0_thermal: mpu0_thermal {
+mpu0_thermal: mpu0-thermal {
 	polling-delay-passive = <250>; /* milliseconds */
 	polling-delay = <500>; /* milliseconds */
 	thermal-sensors = <&wkup_vtm0 0>;
 
 	trips {
-		mpu0_crit: mpu0_crit {
+		mpu0_crit: mpu0-crit {
 			temperature = <125000>; /* milliCelsius */
 			hysteresis = <2000>; /* milliCelsius */
 			type = "critical";
@@ -16,13 +16,13 @@ mpu0_thermal: mpu0_thermal {
 	};
 };
 
-mpu1_thermal: mpu1_thermal {
+mpu1_thermal: mpu1-thermal {
 	polling-delay-passive = <250>; /* milliseconds */
 	polling-delay = <500>; /* milliseconds */
 	thermal-sensors = <&wkup_vtm0 1>;
 
 	trips {
-		mpu1_crit: mpu1_crit {
+		mpu1_crit: mpu1-crit {
 			temperature = <125000>; /* milliCelsius */
 			hysteresis = <2000>; /* milliCelsius */
 			type = "critical";
@@ -30,13 +30,13 @@ mpu1_thermal: mpu1_thermal {
 	};
 };
 
-mcu_thermal: mcu_thermal {
+mcu_thermal: mcu-thermal {
 	polling-delay-passive = <250>; /* milliseconds */
 	polling-delay = <500>; /* milliseconds */
 	thermal-sensors = <&wkup_vtm0 2>;
 
 	trips {
-		mcu_crit: mcu_crit {
+		mcu_crit: mcu-crit {
 			temperature = <125000>; /* milliCelsius */
 			hysteresis = <2000>; /* milliCelsius */
 			type = "critical";
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index c355692796a9..648267284582 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -86,13 +86,13 @@
 };
 
 &main_pmx0 {
-	sw10_button_pins_default: sw10_button_pins_default {
+	sw10_button_pins_default: sw10-button-pins-default {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x0, PIN_INPUT, 7) /* (AC18) EXTINTn.GPIO0_0 */
 		>;
 	};
 
-	main_mmc1_pins_default: main_mmc1_pins_default {
+	main_mmc1_pins_default: main-mmc1-pins-default {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x254, PIN_INPUT, 0) /* (R29) MMC1_CMD */
 			J721E_IOPAD(0x250, PIN_INPUT, 0) /* (P25) MMC1_CLK */
@@ -106,14 +106,14 @@
 		>;
 	};
 
-	main_usbss0_pins_default: main_usbss0_pins_default {
+	main_usbss0_pins_default: main-usbss0-pins-default {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x290, PIN_OUTPUT, 0) /* (U6) USB0_DRVVBUS */
 			J721E_IOPAD(0x210, PIN_INPUT, 7) /* (W3) MCAN1_RX.GPIO1_3 */
 		>;
 	};
 
-	main_usbss1_pins_default: main_usbss1_pins_default {
+	main_usbss1_pins_default: main-usbss1-pins-default {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x214, PIN_OUTPUT, 4) /* (V4) MCAN1_TX.USB1_DRVVBUS */
 		>;
@@ -153,7 +153,7 @@
 		>;
 	};
 
-	mcasp10_pins_default: mcasp10_pins_default {
+	mcasp10_pins_default: mcasp10-pins-default {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x158, PIN_OUTPUT_PULLDOWN, 12) /* (U23) RGMII5_TX_CTL.MCASP10_ACLKX */
 			J721E_IOPAD(0x15c, PIN_OUTPUT_PULLDOWN, 12) /* (U26) RGMII5_RX_CTL.MCASP10_AFSX */
@@ -167,7 +167,7 @@
 		>;
 	};
 
-	audi_ext_refclk2_pins_default: audi_ext_refclk2_pins_default {
+	audi_ext_refclk2_pins_default: audi-ext-refclk2-pins-default {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x1a4, PIN_OUTPUT, 3) /* (W26) RGMII6_RXC.AUDIO_EXT_REFCLK2 */
 		>;
@@ -175,7 +175,7 @@
 };
 
 &wkup_pmx0 {
-	sw11_button_pins_default: sw11_button_pins_default {
+	sw11_button_pins_default: sw11-button-pins-default {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0xcc, PIN_INPUT, 7) /* (G28) WKUP_GPIO0_7 */
 		>;
@@ -194,7 +194,7 @@
 		>;
 	};
 
-	mcu_cpsw_pins_default: mcu_cpsw_pins_default {
+	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0x0058, PIN_OUTPUT, 0) /* MCU_RGMII1_TX_CTL */
 			J721E_WKUP_IOPAD(0x005c, PIN_INPUT, 0) /* MCU_RGMII1_RX_CTL */
@@ -211,7 +211,7 @@
 		>;
 	};
 
-	mcu_mdio_pins_default: mcu_mdio1_pins_default {
+	mcu_mdio_pins_default: mcu-mdio1-pins-default {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0x008c, PIN_OUTPUT, 0) /* MCU_MDIO0_MDC */
 			J721E_WKUP_IOPAD(0x0088, PIN_INPUT, 0) /* MCU_MDIO0_MDIO */
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 1d2a7c05b6f3..ea57d07777ba 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -86,7 +86,7 @@
 		ti,interrupt-ranges = <8 392 56>;
 	};
 
-	main_navss {
+	main-navss {
 		compatible = "simple-mfd";
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -888,7 +888,7 @@
 		no-1-8-v;
 	};
 
-	usbss0: cdns_usb@4104000 {
+	usbss0: cdns-usb@4104000 {
 		compatible = "ti,j721e-usb";
 		reg = <0x00 0x4104000 0x00 0x100>;
 		dma-coherent;
@@ -918,7 +918,7 @@
 		};
 	};
 
-	usbss1: cdns_usb@4114000 {
+	usbss1: cdns-usb@4114000 {
 		compatible = "ti,j721e-usb";
 		reg = <0x00 0x4114000 0x00 0x100>;
 		dma-coherent;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 81801f519a61..03fa69c0a038 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -249,7 +249,7 @@
 		};
 	};
 
-	mcu_navss {
+	mcu-navss {
 		compatible = "simple-mfd";
 		#address-cells = <2>;
 		#size-cells = <2>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
index d69d90c8b5e3..5dc3ba739131 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
@@ -71,7 +71,7 @@
 };
 
 &wkup_pmx0 {
-	wkup_i2c0_pins_default: wkup_i2c0_pins_default {
+	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0xf8, PIN_INPUT_PULLUP, 0) /* (J25) WKUP_I2C0_SCL */
 			J721E_WKUP_IOPAD(0xfc, PIN_INPUT_PULLUP, 0) /* (H24) WKUP_I2C0_SDA */
-- 
2.17.1

