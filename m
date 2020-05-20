Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BDDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB0AC205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgETGkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 02:40:08 -0400
Received: from inva020.nxp.com ([92.121.34.13]:39850 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETGkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 02:40:06 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 446571A02DF;
        Wed, 20 May 2020 08:40:04 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4F71C1A02D9;
        Wed, 20 May 2020 08:40:00 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 181F4402B3;
        Wed, 20 May 2020 14:39:54 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: dts: imx: Make tempmon node as child of anatop node
Date:   Wed, 20 May 2020 14:30:16 +0800
Message-Id: <1589956216-22499-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6/7 SoCs' temperature sensor is inside anatop module from HW
perspective, so it should be a child node of anatop.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 22 +++++++++++-----------
 arch/arm/boot/dts/imx6sl.dtsi  | 20 ++++++++++----------
 arch/arm/boot/dts/imx6sll.dtsi | 20 ++++++++++----------
 arch/arm/boot/dts/imx6sx.dtsi  | 20 ++++++++++----------
 arch/arm/boot/dts/imx6ul.dtsi  | 20 ++++++++++----------
 arch/arm/boot/dts/imx7s.dtsi   | 20 ++++++++++----------
 6 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 39d4afd..43d44d5 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -69,17 +69,6 @@
 		};
 	};
 
-	tempmon: tempmon {
-		compatible = "fsl,imx6q-tempmon";
-		interrupt-parent = <&gpc>;
-		interrupts = <0 49 IRQ_TYPE_LEVEL_HIGH>;
-		fsl,tempmon = <&anatop>;
-		nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
-		nvmem-cell-names = "calib", "temp_grade";
-		clocks = <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
-		#thermal-sensor-cells = <0>;
-	};
-
 	ldb: ldb {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -795,6 +784,17 @@
 					anatop-min-voltage = <725000>;
 					anatop-max-voltage = <1450000>;
 				};
+
+				tempmon: tempmon {
+					compatible = "fsl,imx6q-tempmon";
+					interrupt-parent = <&gpc>;
+					interrupts = <0 49 IRQ_TYPE_LEVEL_HIGH>;
+					fsl,tempmon = <&anatop>;
+					nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
+					nvmem-cell-names = "calib", "temp_grade";
+					clocks = <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
+					#thermal-sensor-cells = <0>;
+				};
 			};
 
 			usbphy1: usbphy@20c9000 {
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 911d8cf..d8efc0a 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -93,16 +93,6 @@
 		};
 	};
 
-	tempmon: tempmon {
-		compatible = "fsl,imx6q-tempmon";
-		interrupts = <0 49 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-parent = <&gpc>;
-		fsl,tempmon = <&anatop>;
-		nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
-		nvmem-cell-names = "calib", "temp_grade";
-		clocks = <&clks IMX6SL_CLK_PLL3_USB_OTG>;
-	};
-
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupt-parent = <&gpc>;
@@ -628,6 +618,16 @@
 					anatop-min-voltage = <725000>;
 					anatop-max-voltage = <1450000>;
 				};
+
+				tempmon: tempmon {
+					compatible = "fsl,imx6q-tempmon";
+					interrupts = <0 49 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-parent = <&gpc>;
+					fsl,tempmon = <&anatop>;
+					nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
+					nvmem-cell-names = "calib", "temp_grade";
+					clocks = <&clks IMX6SL_CLK_PLL3_USB_OTG>;
+				};
 			};
 
 			usbphy1: usbphy@20c9000 {
diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index edd3abb..bf7f048 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -105,16 +105,6 @@
 		clock-output-names = "ipp_di1";
 	};
 
-	tempmon: temperature-sensor {
-		compatible = "fsl,imx6sll-tempmon", "fsl,imx6sx-tempmon";
-		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-parent = <&gpc>;
-		fsl,tempmon = <&anatop>;
-		nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
-		nvmem-cell-names = "calib", "temp_grade";
-		clocks = <&clks IMX6SLL_CLK_PLL3_USB_OTG>;
-	};
-
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -531,6 +521,16 @@
 					anatop-max-voltage = <3400000>;
 					anatop-enable-bit = <0>;
 				};
+
+				tempmon: temperature-sensor {
+					compatible = "fsl,imx6sll-tempmon", "fsl,imx6sx-tempmon";
+					interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-parent = <&gpc>;
+					fsl,tempmon = <&anatop>;
+					nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
+					nvmem-cell-names = "calib", "temp_grade";
+					clocks = <&clks IMX6SLL_CLK_PLL3_USB_OTG>;
+				};
 			};
 
 			usbphy1: usb-phy@20c9000 {
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index e031337..8c4473b 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -134,16 +134,6 @@
 		clock-output-names = "anaclk2";
 	};
 
-	tempmon: tempmon {
-		compatible = "fsl,imx6sx-tempmon", "fsl,imx6q-tempmon";
-		interrupt-parent = <&gpc>;
-		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-		fsl,tempmon = <&anatop>;
-		nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
-		nvmem-cell-names = "calib", "temp_grade";
-		clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
-	};
-
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupt-parent = <&gpc>;
@@ -696,6 +686,16 @@
 					anatop-min-voltage = <725000>;
 					anatop-max-voltage = <1450000>;
 				};
+
+				tempmon: tempmon {
+					compatible = "fsl,imx6sx-tempmon", "fsl,imx6q-tempmon";
+					interrupt-parent = <&gpc>;
+					interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+					fsl,tempmon = <&anatop>;
+					nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
+					nvmem-cell-names = "calib", "temp_grade";
+					clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
+				};
 			};
 
 			usbphy1: usbphy@20c9000 {
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 35e7301..505fd4f 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -131,16 +131,6 @@
 		clock-output-names = "ipp_di1";
 	};
 
-	tempmon: tempmon {
-		compatible = "fsl,imx6ul-tempmon", "fsl,imx6sx-tempmon";
-		interrupt-parent = <&gpc>;
-		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-		fsl,tempmon = <&anatop>;
-		nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
-		nvmem-cell-names = "calib", "temp_grade";
-		clocks = <&clks IMX6UL_CLK_PLL3_USB_OTG>;
-	};
-
 	pmu {
 		compatible = "arm,cortex-a7-pmu";
 		interrupt-parent = <&gpc>;
@@ -611,6 +601,16 @@
 					anatop-min-voltage = <725000>;
 					anatop-max-voltage = <1450000>;
 				};
+
+				tempmon: tempmon {
+					compatible = "fsl,imx6ul-tempmon", "fsl,imx6sx-tempmon";
+					interrupt-parent = <&gpc>;
+					interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+					fsl,tempmon = <&anatop>;
+					nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
+					nvmem-cell-names = "calib", "temp_grade";
+					clocks = <&clks IMX6UL_CLK_PLL3_USB_OTG>;
+				};
 			};
 
 			usbphy1: usbphy@20c9000 {
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 8bac491..3904558 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -147,16 +147,6 @@
 		};
 	};
 
-	tempmon: tempmon {
-		compatible = "fsl,imx7d-tempmon";
-		interrupt-parent = <&gpc>;
-		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-		fsl,tempmon = <&anatop>;
-		nvmem-cells = <&tempmon_calib>,	<&fuse_grade>;
-		nvmem-cell-names = "calib", "temp_grade";
-		clocks = <&clks IMX7D_PLL_SYS_MAIN_CLK>;
-	};
-
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupt-parent = <&intc>;
@@ -586,6 +576,16 @@
 					anatop-max-voltage = <1300000>;
 					anatop-enable-bit = <0>;
 				};
+
+				tempmon: tempmon {
+					compatible = "fsl,imx7d-tempmon";
+					interrupt-parent = <&gpc>;
+					interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+					fsl,tempmon = <&anatop>;
+					nvmem-cells = <&tempmon_calib>,	<&fuse_grade>;
+					nvmem-cell-names = "calib", "temp_grade";
+					clocks = <&clks IMX7D_PLL_SYS_MAIN_CLK>;
+				};
 			};
 
 			snvs: snvs@30370000 {
-- 
2.7.4

