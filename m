Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA677C5ACD9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8172076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgCRMEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:04:37 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59131 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgCRMEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:04:37 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jEXQW-00018c-2F; Wed, 18 Mar 2020 13:04:00 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jEXQT-0001Jn-Tr; Wed, 18 Mar 2020 13:03:57 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v1 3/6] ARM: dts: add Protonic WD2 board
Date:   Wed, 18 Mar 2020 13:03:51 +0100
Message-Id: <20200318120354.4989-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318120354.4989-1-o.rempel@pengutronix.de>
References: <20200318120354.4989-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Protonic WD2 board, which is an internal development
platform for low-cost agricultural Virtual Terminals based on COTS tablets
and web applications.
It inherits from the PRTI6Q base class.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/imx6q-prtwd2.dts            | 242 ++++++++++++++++++
 3 files changed, 244 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-prtwd2.dts

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 3b52b582efdf..5bdf8d38b2f0 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -120,6 +120,7 @@ properties:
               - fsl,imx6q-sabrelite
               - fsl,imx6q-sabresd
               - prt,prti6q                      # Protonic PRTI6Q board
+              - prt,prtwd2                      # Protonic WD2 board
               - technologic,imx6q-ts4900
               - technologic,imx6q-ts7970
               - toradex,apalis_imx6q            # Apalis iMX6 Module
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3f500a9e88a9..b6fc2b375a61 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -531,6 +531,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-phytec-pbab01.dtb \
 	imx6q-pistachio.dtb \
 	imx6q-prti6q.dtb \
+	imx6q-prtwd2.dtb \
 	imx6q-rex-pro.dtb \
 	imx6q-sabreauto.dtb \
 	imx6q-sabrelite.dtb \
diff --git a/arch/arm/boot/dts/imx6q-prtwd2.dts b/arch/arm/boot/dts/imx6q-prtwd2.dts
new file mode 100644
index 000000000000..275c291d1ef4
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-prtwd2.dts
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 Protonic Holland
+ */
+
+/dts-v1/;
+#include "imx6q.dtsi"
+#include "imx6qdl-prti6q.dtsi"
+
+/ {
+	model = "Protonic WD2 board";
+	compatible = "prt,prtwd2", "fsl,imx6q";
+
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0x20000000>;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	usdhc2_pwrseq: usdhc2_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wlan_npd>;
+		reset-gpios = <&gpio6 10 GPIO_ACTIVE_LOW>;
+	};
+
+	/* PRTWD2 rev 1 bitbang I2C for Ethernet Switch */
+	i2c@4 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpio1 22 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpio1 31 (GPIO_ACTIVE_HIGH)>;
+		i2c-gpio,delay-us = <20>;	/* ~10 kHz */
+		i2c-gpio,scl-output-only;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
+
+&iomuxc {
+	prti6q {
+		pinctrl_enet: enetgrp {
+			fsl,pins = <
+				/* MX6QDL_ENET_PINGRP4 */
+				MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0     0x1b0b0
+				MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1     0x1b0b0
+				MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER       0x130b0
+				MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN       0x1b0b0
+				MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0     0x1b0b0
+				MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1     0x1b0b0
+				MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN      0x1b0b0
+
+				MX6QDL_PAD_GPIO_16__ENET_REF_CLK   0x1b0b0
+				/* Phy reset */
+				MX6QDL_PAD_CSI0_DAT4__GPIO5_IO22   0x1b0b0
+				/* nINTRP */
+				MX6QDL_PAD_CSI0_DAT5__GPIO5_IO23   0x1b0b0
+			>;
+		};
+
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				/* SGTL5000 sys_mclk */
+				MX6QDL_PAD_CSI0_MCLK__CCM_CLKO1		0x030b0
+				/* CAN1_SR + CAN2_SR GPIO outputs */
+				MX6QDL_PAD_KEY_COL3__GPIO4_IO12		0x13070
+				MX6QDL_PAD_KEY_ROW3__GPIO4_IO13		0x13070
+				/* CAN1_TERM */
+				MX6QDL_PAD_GPIO_0__GPIO1_IO00		0x1b0b0
+				/* nON_SWITCH */
+				MX6QDL_PAD_EIM_CS0__GPIO2_IO23		0x1b0b0
+
+				/* HW revision detect */
+				/* REV_ID0 */
+				MX6QDL_PAD_SD4_DAT0__GPIO2_IO08 0x1b0b0
+				/* REV_ID1 */
+				MX6QDL_PAD_SD4_DAT1__GPIO2_IO09 0x1b0b0
+				/* REV_ID2 */
+				MX6QDL_PAD_SD4_DAT2__GPIO2_IO10 0x1b0b0
+				/* REV_ID3 */
+				MX6QDL_PAD_SD4_DAT3__GPIO2_IO11 0x1b0b0
+				/* REV_ID4 */
+				MX6QDL_PAD_SD4_DAT4__GPIO2_IO12 0x1b0b0
+
+				/* USB charging control */
+				MX6QDL_PAD_NANDF_CS0__GPIO6_IO11	0x130b0
+				MX6QDL_PAD_NANDF_CS1__GPIO6_IO14	0x130b0
+				MX6QDL_PAD_NANDF_CS2__GPIO6_IO15	0x130b0
+				MX6QDL_PAD_NANDF_CS3__GPIO6_IO16	0x130b0
+
+				MX6QDL_PAD_ENET_MDIO__GPIO1_IO22	0x1f8b0
+				MX6QDL_PAD_ENET_MDC__GPIO1_IO31		0x1f8b0
+			>;
+		};
+
+		pinctrl_usbotg: usbotggrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D21__USB_OTG_OC	0x1b0b0
+				/* power enable, high active */
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22	0x1b0b0
+			>;
+		};
+
+		pinctrl_leds: ledsgrp {
+			fsl,pins = <
+				/* DEBUG0 */
+				MX6QDL_PAD_DI0_DISP_CLK__GPIO4_IO16	0x1b0b0
+				/* DEBUG1 */
+				MX6QDL_PAD_DI0_PIN15__GPIO4_IO17	0x1b0b0
+				/* POWER_LED */
+				MX6QDL_PAD_EIM_CS1__GPIO2_IO24		0x1b0b0
+			>;
+		};
+
+		pinctrl_wlan_npd: wlan_npd {
+			fsl,pins = <
+				/* WL_REG_ON */
+				MX6QDL_PAD_NANDF_RB0__GPIO6_IO10	0x13069
+			>;
+		};
+
+		pinctrl_usdhc2: usdhc2grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD2_CMD__SD2_CMD		0x170b9
+				MX6QDL_PAD_SD2_CLK__SD2_CLK		0x100b9
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x170b9
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x170b9
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x170b9
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x170b9
+			>;
+		};
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-mode = "rmii";
+	clocks = <&clks IMX6QDL_CLK_ENET>,
+		 <&clks IMX6QDL_CLK_ENET>;
+	clock-names = "ipg", "ahb";
+	status = "okay";
+
+	fixedphy: fixed-link {
+		speed = <100>;
+		pause;
+		full-duplex;
+	};
+};
+
+&ecspi1 {
+	status = "disabled";
+};
+
+&flash {
+	status = "disabled";
+};
+
+&ecspi1 {
+	status = "disabled";
+};
+
+&audmux {
+	status = "disabled";
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+};
+
+&pcie {
+	status = "disabled";
+};
+
+&pwm1 {
+	status = "disabled";
+};
+
+&ssi1 {
+	status = "disabled";
+};
+
+&uart2 {
+	status = "disabled";
+};
+
+&uart5 {
+	status = "disabled";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	no-1-8-v;
+	non-removable;
+	mmc-pwrseq = <&usdhc2_pwrseq>;
+	pm-ignore-notify;
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	brcmf: bcrmf@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+&can2 {
+	status = "disabled";
+};
+
+&can_adc {
+	channel@4 {
+		reg = <4>;
+		ti,gain = <1>;
+		ti,datarate = <3>;
+	};
+
+	channel@5 {
+		reg = <5>;
+		ti,gain = <1>;
+		ti,datarate = <3>;
+	};
+
+	channel@6 {
+		reg = <6>;
+		ti,gain = <1>;
+		ti,datarate = <3>;
+	};
+
+	channel@7 {
+		reg = <7>;
+		ti,gain = <1>;
+		ti,datarate = <3>;
+	};
+};
-- 
2.25.1

