Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE27C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3212024649
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgBQD0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:26:55 -0500
Received: from inva020.nxp.com ([92.121.34.13]:46250 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbgBQD0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:26:47 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3E1FB1A1F30;
        Mon, 17 Feb 2020 04:26:45 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 37F211A1F3D;
        Mon, 17 Feb 2020 04:26:35 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 87FD0402E5;
        Mon, 17 Feb 2020 11:26:23 +0800 (SGT)
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
Subject: [PATCH 7/7] arch: arm64: dts: imx8qxp: add device node for CAN in ADMA SS
Date:   Mon, 17 Feb 2020 11:19:21 +0800
Message-Id: <1581909561-12058-8-git-send-email-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581909561-12058-1-git-send-email-qiangqing.zhang@nxp.com>
References: <1581909561-12058-1-git-send-email-qiangqing.zhang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device node for CAN in ADMA SS.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 47 +++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 59 +++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index f88402ee650c..72a45dd7129e 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -28,6 +28,25 @@
 		gpio = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	reg_can_en: regulator-can-en {
+		compatible = "regulator-fixed";
+		regulator-name = "can-en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416 3 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_can_stby: regulator-can-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "can-stby";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_can_en>;
+	};
 };
 
 &cm40_i2c {
@@ -80,6 +99,20 @@
 	};
 };
 
+&adma_flexcan0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan0>;
+	xceiver-supply = <&reg_can_stby>;
+	status = "okay";
+};
+
+&adma_flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_can_stby>;
+	status = "okay";
+};
+
 &adma_i2c1 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -207,6 +240,20 @@
 		>;
 	};
 
+	pinctrl_flexcan0: flexcan0grp {
+		fsl,pins = <
+			IMX8QXP_FLEXCAN0_TX_ADMA_FLEXCAN0_TX			0x00000021
+			IMX8QXP_FLEXCAN0_RX_ADMA_FLEXCAN0_RX			0x00000021
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			IMX8QXP_FLEXCAN1_TX_ADMA_FLEXCAN1_TX			0x00000021
+			IMX8QXP_FLEXCAN1_RX_ADMA_FLEXCAN1_RX			0x00000021
+		>;
+	};
+
 	pinctrl_ioexp_rst: ioexp_rst_grp {
 		fsl,pins = <
 			IMX8QXP_SPI2_SDO_LSIO_GPIO1_IO01			0x06000021
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index cd10519eced7..f549e33d1c82 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -34,6 +34,9 @@
 		serial1 = &adma_lpuart1;
 		serial2 = &adma_lpuart2;
 		serial3 = &adma_lpuart3;
+		can0 = &adma_flexcan0;
+		can1 = &adma_flexcan1;
+		can2 = &adma_flexcan2;
 	};
 
 	cpus {
@@ -384,6 +387,62 @@
 			power-domains = <&pd IMX_SC_R_I2C_3>;
 			status = "disabled";
 		};
+
+		adma_flexcan0: can@5a8d0000 {
+			compatible = "fsl,imx8qxp-flexcan", "fsl,imx8qm-flexcan";
+			reg = <0x5a8d0000 0x10000>;
+			interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			clocks = <&adma_lpcg IMX_ADMA_LPCG_CAN0_IPG_CLK>,
+				 <&adma_lpcg IMX_ADMA_LPCG_CAN0_IPG_PE_CLK>;
+			clock-names = "ipg", "per";
+			assigned-clocks = <&clk IMX_ADMA_CAN0_CLK>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&pd IMX_SC_R_CAN_0>;
+			/* SLSlice[4] */
+			fsl,clk-source = <0>;
+			status = "disabled";
+		};
+
+		adma_flexcan1: can@5a8e0000 {
+			compatible = "fsl,imx8qxp-flexcan", "fsl,imx8qm-flexcan";
+			reg = <0x5a8e0000 0x10000>;
+			interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			/* CAN0 clock and PD is shared among all CAN instances
+			 * as CAN1 shares CAN0's clock and to enable CAN0's
+			 * clock it has to be powered on.
+			 */
+			clocks = <&adma_lpcg IMX_ADMA_LPCG_CAN0_IPG_CLK>,
+				 <&adma_lpcg IMX_ADMA_LPCG_CAN0_IPG_PE_CLK>;
+			clock-names = "ipg", "per";
+			assigned-clocks = <&clk IMX_ADMA_CAN0_CLK>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&pd IMX_SC_R_CAN_1>;
+			/* SLSlice[4] */
+			fsl,clk-source = <0>;
+			status = "disabled";
+		};
+
+		adma_flexcan2: can@5a8f0000 {
+			compatible = "fsl,imx8qxp-flexcan", "fsl,imx8qm-flexcan";
+			reg = <0x5a8f0000 0x10000>;
+			interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			/* CAN0 clock and PD is shared among all CAN instances
+			 * as CAN2 shares CAN0's clock and to enable CAN0's
+			 * clock it has to be powered on.
+			 */
+			clocks = <&adma_lpcg IMX_ADMA_LPCG_CAN0_IPG_CLK>,
+				 <&adma_lpcg IMX_ADMA_LPCG_CAN0_IPG_PE_CLK>;
+			clock-names = "ipg", "per";
+			assigned-clocks = <&clk IMX_ADMA_CAN0_CLK>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&pd IMX_SC_R_CAN_2>;
+			/* SLSlice[4] */
+			fsl,clk-source = <0>;
+			status = "disabled";
+		};
 	};
 
 	conn_subsys: bus@5b000000 {
-- 
2.17.1

