Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F27C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC80720663
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgFRGPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:15:19 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53490 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbgFRGPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 02:15:07 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 87737200068;
        Thu, 18 Jun 2020 08:15:05 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 880DF200C24;
        Thu, 18 Jun 2020 08:15:01 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C3BC54030D;
        Thu, 18 Jun 2020 14:14:55 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/5] ARM: dts: imx6sx-sabreauto: Add cs42888 sound card support
Date:   Thu, 18 Jun 2020 14:03:49 +0800
Message-Id: <98c07c00c833080b561a2310cafcc79f8af78704.1592460381.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1592460381.git.shengjiu.wang@nxp.com>
References: <cover.1592460381.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1592460381.git.shengjiu.wang@nxp.com>
References: <cover.1592460381.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Complete the ESAI node and Add cs42888 sound card support.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 75 ++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6sx.dtsi          |  4 ++
 2 files changed, 79 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 772b8ac5d637..76a4c06e0ff2 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -67,6 +67,36 @@
 		vin-supply = <&reg_can_en>;
 	};
 
+	reg_cs42888: cs42888_supply {
+		compatible = "regulator-fixed";
+		regulator-name = "cs42888_supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	sound-cs42888 {
+		compatible = "fsl,imx6-sabreauto-cs42888",
+			     "fsl,imx-audio-cs42888";
+		model = "imx-cs42888";
+		audio-cpu = <&esai>;
+		audio-asrc = <&asrc>;
+		audio-codec = <&cs42888>;
+		audio-routing =
+			"Line Out Jack", "AOUT1L",
+			"Line Out Jack", "AOUT1R",
+			"Line Out Jack", "AOUT2L",
+			"Line Out Jack", "AOUT2R",
+			"Line Out Jack", "AOUT3L",
+			"Line Out Jack", "AOUT3R",
+			"Line Out Jack", "AOUT4L",
+			"Line Out Jack", "AOUT4R",
+			"AIN1L", "Line In Jack",
+			"AIN1R", "Line In Jack",
+			"AIN2L", "Line In Jack",
+			"AIN2R", "Line In Jack";
+	};
+
 	sound-spdif {
 		compatible = "fsl,imx-audio-spdif";
 		model = "imx-spdif";
@@ -79,6 +109,25 @@
 	clock-frequency = <24576000>;
 };
 
+&clks {
+	assigned-clocks = <&clks IMX6SX_PLL4_BYPASS_SRC>,
+			  <&clks IMX6SX_PLL4_BYPASS>,
+			  <&clks IMX6SX_CLK_PLL4_POST_DIV>;
+	assigned-clock-parents = <&clks IMX6SX_CLK_LVDS2_IN>,
+				 <&clks IMX6SX_PLL4_BYPASS_SRC>;
+	assigned-clock-rates = <0>, <0>, <24576000>;
+};
+
+&esai {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esai>;
+	assigned-clocks = <&clks IMX6SX_CLK_ESAI_SEL>,
+			<&clks IMX6SX_CLK_ESAI_EXTAL>;
+	assigned-clock-parents = <&clks IMX6SX_CLK_PLL4_AUDIO_DIV>;
+	assigned-clock-rates = <0>, <24576000>;
+	status = "okay";
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet1>;
@@ -200,6 +249,21 @@
 		>;
 	};
 
+	pinctrl_esai: esaigrp {
+		fsl,pins = <
+			MX6SX_PAD_CSI_DATA00__ESAI_TX_CLK   0x1b030
+			MX6SX_PAD_CSI_DATA01__ESAI_TX_FS    0x1b030
+			MX6SX_PAD_CSI_HSYNC__ESAI_TX0       0x1b030
+			MX6SX_PAD_CSI_DATA04__ESAI_TX1      0x1b030
+			MX6SX_PAD_CSI_DATA06__ESAI_TX2_RX3  0x1b030
+			MX6SX_PAD_CSI_DATA07__ESAI_TX3_RX2  0x1b030
+			MX6SX_PAD_CSI_DATA02__ESAI_RX_CLK   0x1b030
+			MX6SX_PAD_CSI_DATA03__ESAI_RX_FS    0x1b030
+			MX6SX_PAD_CSI_VSYNC__ESAI_TX5_RX0   0x1b030
+			MX6SX_PAD_CSI_DATA05__ESAI_TX4_RX1  0x1b030
+		>;
+	};
+
 	pinctrl_flexcan1: flexcan1grp {
 		fsl,pins = <
 			MX6SX_PAD_QSPI1B_DQS__CAN1_TX   0x1b020
@@ -326,6 +390,17 @@
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
 
+	cs42888: cs42888@48 {
+		compatible = "cirrus,cs42888";
+		reg = <0x48>;
+		clocks = <&anaclk2 0>;
+		clock-names = "mclk";
+		VA-supply = <&reg_cs42888>;
+		VD-supply = <&reg_cs42888>;
+		VLS-supply = <&reg_cs42888>;
+		VLC-supply = <&reg_cs42888>;
+	};
+
 	touchscreen@4 {
 		compatible = "eeti,egalax_ts";
 		reg = <0x04>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 8dc412b3862b..9f4f3c0aace5 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -341,6 +341,7 @@
 				};
 
 				esai: esai@2024000 {
+					compatible = "fsl,imx6sx-esai", "fsl,imx35-esai";
 					reg = <0x02024000 0x4000>;
 					interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SX_CLK_ESAI_IPG>,
@@ -350,6 +351,9 @@
 						 <&clks IMX6SX_CLK_SPBA>;
 					clock-names = "core", "mem", "extal",
 						      "fsys", "spba";
+					dmas = <&sdma 23 21 0>,
+					       <&sdma 24 21 0>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
-- 
2.21.0

