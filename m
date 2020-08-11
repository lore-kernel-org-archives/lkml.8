Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACDFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AFD520782
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597160387;
	bh=L1UzGtVpD4/a3VN+N9MwFCOknwzMw43v0OgEvqRVx2E=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mbM0rQ1lCUASczqPAyqnz4KK8Ko9+CUuDujy+RdSvzOppmFoo08ST20g6wzU9d1+5
	 kBtrJ85MURZKaSUcXmEyzJF+qHMuCFk7bkmp9ExzdtBsEiZIxwRuB4wzI9fqwpa/x1
	 zCqIjFfCUft7zHIDnmxvn2n7xjw1on49jdh2nFXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgHKPjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbgHKPjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:39:37 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B189720771;
        Tue, 11 Aug 2020 15:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160377;
        bh=L1UzGtVpD4/a3VN+N9MwFCOknwzMw43v0OgEvqRVx2E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GJmQI3xeFcjuZ3XM6Wf46J8YSR4fkyZqoMRZu5sxGUPwELm5Km2lV2SfZUHqIwLYV
         sy6POMfWdHUGQCM+4sj1/mzKl6QENeApb3ySi0r1MRrNR0Tw2fxLyx9Pa/g0nqeEQ5
         BIOYisRfLrsRDpIUvU8lJbAZON3a3lKfNneiQtPg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] arm64: dts: imx8mm-var-som-symphony: Add Variscite Symphony board with VAR-SOM-MX8MM
Date:   Tue, 11 Aug 2020 17:39:16 +0200
Message-Id: <20200811153916.5455-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811153916.5455-1-krzk@kernel.org>
References: <20200811153916.5455-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DTS for Variscite Symphony evaluation kit with VAR-SOM-MX8MM
System on Module.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mm-var-som-symphony.dts | 244 ++++++++++++++++++
 2 files changed, 245 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index a39f0a1723e0..dcfb8750cd78 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -29,6 +29,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
new file mode 100644
index 000000000000..5bfb650a04cc
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2020 Krzysztof Kozlowski <krzk@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "imx8mm-var-som.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-MX8MM Symphony evaluation board";
+	compatible = "variscite,var-som-mx8mm-symphony", "variscite,var-som-mx8mm", "fsl,imx8mm";
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_led>;
+
+		status {
+			label = "status";
+			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+
+	reg_usdhc2_vmmc: regulator-1 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usb_otg2_vbus: regulator-2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usb_otg2_vbus>;
+		regulator-name = "usb_otg2_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		back {
+			label = "Back";
+			gpios = <&pca9534 1 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_BACK>;
+		};
+
+		home {
+			label = "Home";
+			gpios = <&pca9534 2 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOME>;
+		};
+
+		menu {
+			label = "Menu";
+			gpios = <&pca9534 3 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MENU>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		heartbeat {
+			label = "Heartbeat";
+			gpios = <&pca9534 0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&ethphy {
+	reset-gpios = <&pca9534 5 GPIO_ACTIVE_HIGH>;
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	pca9534: gpio@20 {
+		compatible = "nxp,pca9534";
+		reg = <0x20>;
+		gpio-controller;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pca9534>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+		#gpio-cells = <2>;
+		wakeup-source;
+
+		/* USB 3.0 OTG (usbotg1) / SATA port switch, set to USB 3.0 */
+		usb3-sata-sel-hog {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "usb3_sata_sel";
+		};
+
+		som-vselect-hog {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "som_vselect";
+		};
+
+		enet-sel-hog {
+			gpio-hog;
+			gpios = <7 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "enet_sel";
+		};
+	};
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	/* Capacitive touch controller */
+	ft5x06_ts: touchscreen@38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_captouch>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <4 GPIO_ACTIVE_HIGH>;
+
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
+
+	rtc@68 {
+		compatible = "dallas,ds1337";
+		reg = <0x68>;
+		wakeup-source;
+	};
+};
+
+/* Header */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+/* Header */
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+&usbotg1 {
+	disable-over-current;
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	vbus-supply = <&reg_usb_otg2_vbus>;
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	disable-over-current;
+	/delete-property/ usb-role-switch;
+	/*
+	 * FIXME: having USB2 enabled hangs the boot just after:
+	 * [    1.943365] ci_hdrc ci_hdrc.1: EHCI Host Controller
+	 * [    1.948287] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 1
+	 * [    1.971006] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
+	 * [    1.977203] hub 1-0:1.0: USB hub found
+	 * [    1.980987] hub 1-0:1.0: 1 port detected
+	 */
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+
+	pinctrl_captouch: captouchgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_RX_GPIO5_IO4		0x16
+		>;
+	};
+
+	pinctrl_gpio_led: gpioledgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16	0x19
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
+			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_pca9534: pca9534grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7	0x16
+		>;
+	};
+
+	pinctrl_reg_usb_otg2_vbus: regusbotg2vbusgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI3_TXD_GPIO5_IO1		0x16
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX	0x140
+			MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX	0x140
+			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX	0x140
+		>;
+	};
+};
-- 
2.17.1

