Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E00C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B24C20774
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgC3MG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:06:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53893 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730096AbgC3MGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:06:55 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jItBj-0001OM-Sp; Mon, 30 Mar 2020 14:06:43 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jItBi-0002Zr-Nh; Mon, 30 Mar 2020 14:06:42 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v4 4/5] ARM: dts: add Protonic VT7 board
Date:   Mon, 30 Mar 2020 14:06:39 +0200
Message-Id: <20200330120640.9810-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200330120640.9810-1-o.rempel@pengutronix.de>
References: <20200330120640.9810-1-o.rempel@pengutronix.de>
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

The Protonic VT7 is a mid-class ISObus Virtual Terminal with a 7 inch
touchscreen display.

Signed-off-by: Robin van der Gracht <robin@protonic.nl>
Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/imx6dl-prtvt7.dts           | 473 ++++++++++++++++++
 3 files changed, 475 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-prtvt7.dts

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 5bdf8d38b2f0..424be1edf005 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -168,6 +168,7 @@ properties:
               - emtrion,emcon-mx6-avari   # emCON-MX6S or emCON-MX6DL SoM on Avari Base
               - fsl,imx6dl-sabreauto      # i.MX6 DualLite/Solo SABRE Automotive Board
               - fsl,imx6dl-sabresd        # i.MX6 DualLite SABRE Smart Device Board
+              - prt,prtvt7                # Protonic VT7 board
               - technologic,imx6dl-ts4900
               - technologic,imx6dl-ts7970
               - toradex,colibri_imx6dl          # Colibri iMX6 Module
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b6fc2b375a61..e53abe1de259 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -446,6 +446,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-nitrogen6x.dtb \
 	imx6dl-phytec-mira-rdk-nand.dtb \
 	imx6dl-phytec-pbab01.dtb \
+	imx6dl-prtvt7.dtb \
 	imx6dl-rex-basic.dtb \
 	imx6dl-riotboard.dtb \
 	imx6dl-sabreauto.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-prtvt7.dts b/arch/arm/boot/dts/imx6dl-prtvt7.dts
new file mode 100644
index 000000000000..c90c0e197b64
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-prtvt7.dts
@@ -0,0 +1,473 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2016 Protonic Holland
+ */
+
+/dts-v1/;
+#include "imx6dl.dtsi"
+#include "imx6qdl-prti6q.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/sound/fsl-imx-audmux.h>
+
+/ {
+	model = "Protonic VT7";
+	compatible = "prt,prtvt7", "fsl,imx6dl";
+
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0x20000000>;
+	};
+
+	backlight_lcd: backlight-lcd {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 500000>;
+		brightness-levels = <0 20 81 248 1000>;
+		default-brightness-level = <20>;
+		num-interpolated-steps = <21>;
+		power-supply = <&reg_12v_bl>;
+		enable-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+
+	display {
+		compatible = "fsl,imx-parallel-display";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu1_disp>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interface-pix-fmt = "rgb24";
+		status = "okay";
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
+	keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		esc {
+			label = "GPIO Key ESC";
+			linux,code = <KEY_ESC>;
+			gpios = <&gpio_pca 0 GPIO_ACTIVE_LOW>;
+		};
+
+		up {
+			label = "GPIO Key UP";
+			linux,code = <KEY_UP>;
+			gpios = <&gpio_pca 1 GPIO_ACTIVE_LOW>;
+		};
+
+		down {
+			label = "GPIO Key DOWN";
+			linux,code = <KEY_DOWN>;
+			gpios = <&gpio_pca 4 GPIO_ACTIVE_LOW>;
+		};
+
+		enter {
+			label = "GPIO Key Enter";
+			linux,code = <KEY_ENTER>;
+			gpios = <&gpio_pca 3 GPIO_ACTIVE_LOW>;
+		};
+
+		cycle {
+			label = "GPIO Key CYCLE";
+			linux,code = <KEY_CYCLEWINDOWS>;
+			gpios = <&gpio_pca 2 GPIO_ACTIVE_LOW>;
+		};
+
+		f1 {
+			label = "GPIO Key F1";
+			linux,code = <KEY_F1>;
+			gpios = <&gpio_pca 14 GPIO_ACTIVE_LOW>;
+		};
+
+		f2 {
+			label = "GPIO Key F2";
+			linux,code = <KEY_F2>;
+			gpios = <&gpio_pca 13 GPIO_ACTIVE_LOW>;
+		};
+
+		f3 {
+			label = "GPIO Key F3";
+			linux,code = <KEY_F3>;
+			gpios = <&gpio_pca 12 GPIO_ACTIVE_LOW>;
+		};
+
+		f4 {
+			label = "GPIO Key F4";
+			linux,code = <KEY_F4>;
+			gpios = <&gpio_pca 11 GPIO_ACTIVE_LOW>;
+		};
+
+		f5 {
+			label = "GPIO Key F5";
+			linux,code = <KEY_F5>;
+			gpios = <&gpio_pca 10 GPIO_ACTIVE_LOW>;
+		};
+
+		f6 {
+			label = "GPIO Key F6";
+			linux,code = <KEY_F6>;
+			gpios = <&gpio_pca 5 GPIO_ACTIVE_LOW>;
+		};
+
+		f7 {
+			label = "GPIO Key F7";
+			linux,code = <KEY_F7>;
+			gpios = <&gpio_pca 6 GPIO_ACTIVE_LOW>;
+		};
+
+		f8 {
+			label = "GPIO Key F8";
+			linux,code = <KEY_F8>;
+			gpios = <&gpio_pca 7 GPIO_ACTIVE_LOW>;
+		};
+
+		f9 {
+			label = "GPIO Key F9";
+			linux,code = <KEY_F9>;
+			gpios = <&gpio_pca 8 GPIO_ACTIVE_LOW>;
+		};
+
+		f10 {
+			label = "GPIO Key F10";
+			linux,code = <KEY_F10>;
+			gpios = <&gpio_pca 9 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds>;
+
+		led-debug0 {
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	panel {
+		compatible = "innolux,g070y2t0ec";
+		backlight = <&backlight_lcd>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display_out>;
+			};
+		};
+	};
+
+	reg_12v_bl: regulator-bl-12v {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_12v_bl>;
+		regulator-name = "12v-bl";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		gpio = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_1v8: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "prti6q-sgtl5000";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Line", "Line In Jack",
+			"Headphone", "Headphone Jack",
+			"Speaker", "External Speaker";
+		simple-audio-card,routing =
+			"MIC_IN", "Microphone Jack",
+			"LINE_IN", "Line In Jack",
+			"Headphone Jack", "HP_OUT",
+			"External Speaker", "LINE_OUT";
+
+		simple-audio-card,cpu {
+			sound-dai = <&ssi1>;
+			system-clock-frequency = <0>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+			bitclock-master;
+			frame-master;
+		};
+	};
+};
+
+&clks {
+	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>;
+	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>;
+};
+
+&ecspi2 {
+	cs-gpios = <&gpio2 26 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	status = "okay";
+
+	tsc@0 {
+		compatible = "ti,tsc2046";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tsc>;
+		spi-max-frequency = <100000>;
+		interrupts-extended = <&gpio3 20 IRQ_TYPE_EDGE_FALLING>;
+		pendown-gpio = <&gpio3 20 GPIO_ACTIVE_HIGH>;
+		vcc-supply = <&reg_3v3>;
+
+		ti,vref-delay-usecs = /bits/ 16 <100>;
+
+		ti,x-min = /bits/ 16 <0>;
+		ti,x-max = /bits/ 16 <8000>;
+		ti,y-min = /bits/ 16 <0>;
+		ti,y-max = /bits/ 16 <4800>;
+		ti,x-plate-ohms = /bits/ 16 <800>;
+		ti,y-plate-ohms = /bits/ 16 <300>;
+		ti,pressure-max = /bits/ 16 <4095>;
+
+		ti,skip-samples = <2>;
+		ti,sample-period-msecs = <10>;
+		ti,report-period-msecs = <30>;
+
+		ti,filter-tolerance = <80>;
+		ti,touch-resistance-threshold = <3500>;
+	};
+};
+
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux>;
+	status = "okay";
+
+	mux_ssi1 {
+		fsl,audmux-port = <0>;
+		fsl,port-config = <
+			IMX_AUDMUX_V2_PTCR_SYN 		0
+			IMX_AUDMUX_V2_PTCR_TFSEL(2) 	0
+			IMX_AUDMUX_V2_PTCR_TCSEL(2) 	0
+			IMX_AUDMUX_V2_PTCR_TFSDIR 	0
+			IMX_AUDMUX_V2_PTCR_TCLKDIR IMX_AUDMUX_V2_PDCR_RXDSEL(2)
+		>;
+	};
+
+	mux_pins3 {
+		fsl,audmux-port = <2>;
+		fsl,port-config = <
+			IMX_AUDMUX_V2_PTCR_SYN IMX_AUDMUX_V2_PDCR_RXDSEL(0)
+			0		       IMX_AUDMUX_V2_PDCR_TXRXEN
+		>;
+	};
+};
+
+&can1 {
+	pinctrl-0 = <&pinctrl_can1 &pinctrl_can1phy>;
+};
+
+&i2c1 {
+	sgtl5000: codec@a {
+		compatible = "fsl,sgtl5000";
+		reg = <0xa>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_codec>;
+		#sound-dai-cells = <0>;
+		clocks = <&clks 201>;
+		VDDA-supply = <&reg_3v3>;
+		VDDIO-supply = <&reg_3v3>;
+		VDDD-supply = <&reg_1v8>;
+	};
+};
+
+&i2c3 {
+	rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+
+	gpio_pca: gpio@74 {
+		compatible = "nxp,pca9539";
+		reg = <0x74>;
+		interrupts-extended = <&gpio4 5 IRQ_TYPE_LEVEL_LOW>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+};
+
+&ipu1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ipu1_csi0>;
+	status = "okay";
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
+&snvs_poweroff {
+	status = "okay";
+};
+
+&snvs_pwrkey {
+	status = "okay";
+};
+
+&ssi1 {
+	#sound-dai-cells = <0>;
+	fsl,mode = "i2s-slave";
+	status = "okay";
+};
+
+&usbh1 {
+	status = "disabled";
+};
+
+&vpu {
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl_audmux: audmuxgrp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_MCLK__CCM_CLKO1		0x030b0
+			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x130b0
+			MX6QDL_PAD_CSI0_DAT4__AUD3_TXC		0x130b0
+			MX6QDL_PAD_CSI0_DAT5__AUD3_TXD		0x110b0
+			MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS		0x130b0
+		>;
+	};
+
+	pinctrl_can1phy: can1phy {
+		fsl,pins = <
+			/* CAN1_SR */
+			MX6QDL_PAD_KEY_COL3__GPIO4_IO12		0x13070
+			/* CAN1_TERM */
+			MX6QDL_PAD_GPIO_0__GPIO1_IO00		0x1b0b0
+		>;
+	};
+
+	pinctrl_codec: codecgrp {
+		fsl,pins = <
+			/* AUDIO_nRESET */
+			MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21	0x1f0b0
+		>;
+	};
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_OE__ECSPI2_MISO		0x100b1
+			MX6QDL_PAD_EIM_CS0__ECSPI2_SCLK		0x100b1
+			MX6QDL_PAD_EIM_CS1__ECSPI2_MOSI		0x100b1
+			MX6QDL_PAD_EIM_RW__GPIO2_IO26		0x000b1
+		>;
+	};
+
+	pinctrl_ipu1_csi0: ipu1csi0grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT13__IPU1_CSI0_DATA13	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT14__IPU1_CSI0_DATA14	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT15__IPU1_CSI0_DATA15	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT16__IPU1_CSI0_DATA16	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT17__IPU1_CSI0_DATA17	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT18__IPU1_CSI0_DATA18	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT19__IPU1_CSI0_DATA19	0x1b0b0
+			MX6QDL_PAD_CSI0_PIXCLK__IPU1_CSI0_PIXCLK 0x1b0b0
+			/* ITU656_nRESET */
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x1b0b0
+			/* ITU656_nPDN */
+			MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20	0x1b0b0
+		>;
+	};
+
+	pinctrl_ipu1_disp: ipudisp1grp {
+		fsl,pins = <
+			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0xb0
+			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15	   0xb0
+
+			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00 0xb0
+			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01 0xb0
+			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02 0xb0
+			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03 0xb0
+			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04 0xb0
+			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05 0xb0
+			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06 0xb0
+			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07 0xb0
+
+			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08 0xb0
+			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09 0xb0
+			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10 0xb0
+			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11 0xb0
+			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12 0xb0
+			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13 0xb0
+			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14 0xb0
+			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15 0xb0
+
+			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16 0xb0
+			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17 0xb0
+			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18 0xb0
+			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19 0xb0
+			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20 0xb0
+			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21 0xb0
+			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22 0xb0
+			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23 0xb0
+		>;
+	};
+
+	pinctrl_leds: ledsgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_8__GPIO1_IO08		0x1b0b0
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_9__PWM1_OUT		0x1b0b0
+		>;
+	};
+
+	pinctrl_reg_12v_bl: 12blgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_7__GPIO1_IO07		0x1b0b0
+		>;
+	};
+
+	pinctrl_tsc: tscgrp {
+
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D20__GPIO3_IO20		0x1b0b0
+			MX6QDL_PAD_EIM_EB2__GPIO2_IO30		0x1b0b0
+		>;
+	};
+};
-- 
2.26.0.rc2

