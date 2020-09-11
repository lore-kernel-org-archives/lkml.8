Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FEBC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 05:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97250221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 05:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgIKFKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 01:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgIKFKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 01:10:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EABC061756
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 22:10:09 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kGbJh-0005w7-ER; Fri, 11 Sep 2020 07:09:45 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kGbJf-0003vS-3G; Fri, 11 Sep 2020 07:09:43 +0200
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
Subject: [PATCH v2 3/3] ARM: dts: add Plymovent M2M board
Date:   Fri, 11 Sep 2020 07:09:41 +0200
Message-Id: <20200911050941.15013-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911050941.15013-1-o.rempel@pengutronix.de>
References: <20200911050941.15013-1-o.rempel@pengutronix.de>
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

Plymovent M2M is a control interface produced for the Plymovent filter
systems.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/Makefile          |   1 +
 arch/arm/boot/dts/imx6dl-plym2m.dts | 394 ++++++++++++++++++++++++++++
 2 files changed, 395 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-plym2m.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4572db3fa5ae..3c3811fd8613 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -455,6 +455,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-pico-hobbit.dtb \
 	imx6dl-pico-nymph.dtb \
 	imx6dl-pico-pi.dtb \
+	imx6dl-plym2m.dtb \
 	imx6dl-prtrvt.dtb \
 	imx6dl-prtvt7.dtb \
 	imx6dl-rex-basic.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-plym2m.dts b/arch/arm/boot/dts/imx6dl-plym2m.dts
new file mode 100644
index 000000000000..4f96e05aa03f
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-plym2m.dts
@@ -0,0 +1,394 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+// SPDX-FileCopyrightText: 2014 Protonic Holland
+// SPDX-FileCopyrightText: 2020 Oleksij Rempel <kernel@pengutronix.de>, Pengutronix
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include "imx6dl.dtsi"
+
+/ {
+	model = "Plymovent M2M board";
+	compatible = "ply,plym2m", "fsl,imx6dl";
+
+	chosen {
+		stdout-path = &uart4;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 500000 0>;
+		brightness-levels = <0 1000>;
+		num-interpolated-steps = <20>;
+		default-brightness-level = <19>;
+		power-supply = <&reg_12v0>;
+	};
+
+	display {
+		compatible = "fsl,imx-parallel-display";
+		pinctrl-0 = <&pinctrl_ipu1_disp>;
+		pinctrl-names = "default";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			display_in: endpoint {
+				remote-endpoint = <&ipu1_di0_disp0>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			display_out: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds>;
+
+		led-debug {
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	panel {
+		compatible = "edt,etm0700g0bdh6";
+		backlight = <&backlight>;
+		power-supply = <&reg_3v3>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display_out>;
+			};
+		};
+	};
+
+	clk50m_phy: phy-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_5v0: regulator-5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_12v0: regulator-12v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "12v0";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1>;
+	xceiver-supply = <&reg_5v0>;
+	status = "okay";
+};
+
+&ecspi1 {
+	cs-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-mode = "rmii";
+	clocks = <&clks IMX6QDL_CLK_ENET>,
+		 <&clks IMX6QDL_CLK_ENET>,
+		 <&clk50m_phy>;
+	clock-names = "ipg", "ahb", "ptp";
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* Microchip KSZ8081RNA PHY */
+		rgmii_phy: ethernet-phy@0 {
+			reg = <0>;
+			interrupts-extended = <&gpio5 23 IRQ_TYPE_LEVEL_LOW>;
+			reset-gpios = <&gpio5 22 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <300>;
+		};
+	};
+};
+
+&gpio1 {
+	gpio-line-names =
+		"CAN1_TERM", "SD1_CD", "", "", "", "", "", "",
+		"DEBUG_0", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio2 {
+	gpio-line-names =
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "ECSPI2_SS0", "", "", "", "TSC_BUSY", "";
+};
+
+&gpio3 {
+	gpio-line-names =
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "ECSPI1_SS1", "TSC_PENIRQ", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio4 {
+	gpio-line-names =
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "CAN1_SR", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio5 {
+	gpio-line-names =
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "ETH_RESET", "ETH_INTRP",
+		"", "", "", "", "", "", "", "";
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	/* additional i2c devices are added automatically by the boot loader */
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	temperature-sensor@70 {
+		compatible = "ti,tmp103";
+		reg = <0x70>;
+	};
+};
+
+&ipu1_di0_disp0 {
+	remote-endpoint = <&display_in>;
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+&usbphynop1 {
+	status = "disabled";
+};
+
+&usbphynop2 {
+	status = "disabled";
+};
+
+&usbotg {
+	phy_type = "utmi";
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	cd-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+	no-1-8-v;
+	disable-wp;
+	cap-sd-highspeed;
+	no-mmc;
+	no-sdio;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	bus-width = <8>;
+	no-1-8-v;
+	non-removable;
+	no-sd;
+	no-sdio;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_can1: can1grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX		0x1b000
+			MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX		0x3008
+			/* CAN1_SR */
+			MX6QDL_PAD_KEY_COL3__GPIO4_IO12			0x13008
+			/* CAN1_TERM */
+			MX6QDL_PAD_GPIO_0__GPIO1_IO00			0x1b088
+		>;
+	};
+
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D17__ECSPI1_MISO			0x1b000
+			MX6QDL_PAD_EIM_D18__ECSPI1_MOSI			0x3008
+			MX6QDL_PAD_EIM_D16__ECSPI1_SCLK			0x3008
+			/* CS */
+			MX6QDL_PAD_EIM_D19__GPIO3_IO19			0x3008
+		>;
+	};
+
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			/* MX6QDL_ENET_PINGRP4 */
+			MX6QDL_PAD_ENET_MDC__ENET_MDC			0x1b0b0
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO			0x1b0b0
+			MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0		0x1b0b0
+			MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1		0x1b0b0
+			MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER		0x1b0b0
+			MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN		0x1b0b0
+			MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0		0x1b0b0
+			MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1		0x1b0b0
+			MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN		0x1b0b0
+
+			MX6QDL_PAD_GPIO_16__ENET_REF_CLK		0x1b0b0
+			/* Phy reset */
+			MX6QDL_PAD_CSI0_DAT4__GPIO5_IO22		0x1b0b0
+			/* nINTRP */
+			MX6QDL_PAD_CSI0_DAT5__GPIO5_IO23		0x1b0b0
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA			0x4001f8b1
+			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL			0x4001f8b1
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_5__I2C3_SCL			0x4001b8b1
+			MX6QDL_PAD_GPIO_6__I2C3_SDA			0x4001b8b1
+		>;
+	};
+
+	pinctrl_ipu1_disp: ipudisp1grp {
+		fsl,pins = <
+			/* DSE 0x30 => 25 Ohm, 0x20 => 37 Ohm, 0x10 => 75 Ohm */
+			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK	0x30
+			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15		0x30
+			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02		0x30
+			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03		0x30
+			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00	0x30
+			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01	0x30
+			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02	0x30
+			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03	0x30
+			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04	0x30
+			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05	0x30
+			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06	0x30
+			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07	0x30
+			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08	0x30
+			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09	0x30
+			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10	0x30
+			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11	0x30
+			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12	0x30
+			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13	0x30
+			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14	0x30
+			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15	0x30
+			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16	0x30
+			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17	0x30
+		>;
+	};
+
+	pinctrl_leds: ledsgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_8__GPIO1_IO08			0x1b0b0
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_9__PWM1_OUT			0x8
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA		0x1b0b1
+			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA		0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__SD1_CMD			0x170f9
+			MX6QDL_PAD_SD1_CLK__SD1_CLK			0x100f9
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0			0x170f9
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1			0x170f9
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2			0x170f9
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3			0x170f9
+			MX6QDL_PAD_GPIO_1__GPIO1_IO01			0x1b0b0
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_CMD__SD3_CMD			0x17099
+			MX6QDL_PAD_SD3_CLK__SD3_CLK			0x10099
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0			0x17099
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1			0x17099
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2			0x17099
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3			0x17099
+			MX6QDL_PAD_SD3_DAT4__SD3_DATA4			0x17099
+			MX6QDL_PAD_SD3_DAT5__SD3_DATA5			0x17099
+			MX6QDL_PAD_SD3_DAT6__SD3_DATA6			0x17099
+			MX6QDL_PAD_SD3_DAT7__SD3_DATA7			0x17099
+			MX6QDL_PAD_SD3_RST__SD3_RESET			0x1b0b1
+		>;
+	};
+};
-- 
2.28.0

