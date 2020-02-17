Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13D2C7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D237121744
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgBQD0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:26:48 -0500
Received: from inva020.nxp.com ([92.121.34.13]:46198 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727915AbgBQD0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:26:44 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A4C621A1F30;
        Mon, 17 Feb 2020 04:26:41 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A895E1A1F39;
        Mon, 17 Feb 2020 04:26:31 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 72D68402E0;
        Mon, 17 Feb 2020 11:26:20 +0800 (SGT)
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, aisheng.dong@nxp.com, peng.fan@nxp.com,
        fugang.duan@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 5/7] arch: arm64: dts: imx8qxp: add device node for I2C and INTMUX in CM40 SS
Date:   Mon, 17 Feb 2020 11:19:19 +0800
Message-Id: <1581909561-12058-6-git-send-email-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581909561-12058-1-git-send-email-qiangqing.zhang@nxp.com>
References: <1581909561-12058-1-git-send-email-qiangqing.zhang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device node for I2C and INTMUX in CM40 SS.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 27 +++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 47 +++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index d3d26cca7d52..f88402ee650c 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -30,6 +30,26 @@
 	};
 };
 
+&cm40_i2c {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_cm40_i2c>;
+	status = "okay";
+
+	pca6416: gpio@20 {
+		compatible = "nxp,pca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&cm40_intmux {
+	status = "okay";
+};
+
 &adma_lpuart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
@@ -161,6 +181,13 @@
 };
 
 &iomuxc {
+	pinctrl_cm40_i2c: cm40i2cgrp {
+		fsl,pins = <
+			IMX8QXP_ADC_IN1_M40_I2C0_SDA                            0x0600004c
+			IMX8QXP_ADC_IN0_M40_I2C0_SCL                            0x0600004c
+		>;
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			IMX8QXP_ENET0_MDC_CONN_ENET0_MDC			0x06000020
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index fb5f752b15fe..cd10519eced7 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -213,6 +213,53 @@
 		clock-output-names = "xtal_24MHz";
 	};
 
+	cm40_subsys: bus@34000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x34000000 0x0 0x34000000 0x4000000>;
+
+		cm40_lpcg: clock-controller@375d0000 {
+			compatible = "fsl,imx8qxp-lpcg-cm40";
+			reg = <0x375d0000 0x70000>;
+			#clock-cells = <1>;
+		};
+
+		cm40_i2c: i2c@37230000 {
+			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+			reg = <0x37230000 0x1000>;
+			interrupts = <9 0>;
+			interrupt-parent = <&cm40_intmux>;
+			clocks = <&cm40_lpcg IMX_CM40_LPCG_I2C_CLK>,
+				 <&cm40_lpcg IMX_CM40_LPCG_I2C_IPG_CLK>;
+			clock-names = "per", "ipg";
+			assigned-clocks = <&clk IMX_CM40_I2C_CLK>;
+			assigned-clock-rates = <24000000>;
+			power-domains = <&pd IMX_SC_R_M4_0_I2C>;
+			status = "disabled";
+		};
+
+		cm40_intmux: intmux@37400000 {
+			compatible = "fsl,imx-intmux";
+			reg = <0x37400000 0x1000>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			#interrupt-cells = <2>;
+			clocks = <&clk IMX_CM40_IPG_CLK>;
+			clock-names = "ipg";
+			power-domains = <&pd IMX_SC_R_M4_0_INTMUX>;
+			status = "disabled";
+		};
+	};
+
 	adma_subsys: bus@59000000 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.17.1

