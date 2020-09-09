Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68DBC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 777D5208FE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599671437;
	bh=2WwRmmt7f866/A9JCegXVqfznAsO3D/tNIxgCSClshU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P0TdLjUEXfY3iOpanDIX4eMFvwRlsF0jcQdegXSXPVTPZNWyB0pAeBnvs2XQ+Wa8e
	 Zh/bfIFaleE343sgOrrn8vVR+ElxYQZg/F+qf/oIKpiUKSdxgCoODgOvF+HerKnyU7
	 XUHEmSGRaD+DvOwcgFLV5qOiFR7FoxrtULL7K8eo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbgIIRKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730329AbgIIPgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:01 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69EF0222B8;
        Wed,  9 Sep 2020 15:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599665099;
        bh=2WwRmmt7f866/A9JCegXVqfznAsO3D/tNIxgCSClshU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDxVyFwFg4UjF+lS46wf96EusNfPsZzRSTZRCXqjaTRsQ4ws4JJidnZYjSvsmxSBb
         sQv2OjJH6JOgNs0kMqvh+OApNWxDgNn/CkPq2brplgX41L75JRhGhB1lJYNjNhcY8J
         JXnm7PqgquM+hy2nprC1x8+5BdVpPl69/z2nJaAw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/3] arm64: dts: imx8mn-var-som-symphony: Add Variscite Symphony board with VAR-SOM-MX8MN
Date:   Wed,  9 Sep 2020 17:24:34 +0200
Message-Id: <20200909152434.18643-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200909152434.18643-1-krzk@kernel.org>
References: <20200909152434.18643-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a basic DTS for Variscite Symphony evaluation kit with VAR-SOM-MX8MN
(i.MX 8M Nano) System on Module.  This brings up the board with basic
functionalities although still few issues remain (e.g. I2C3 and USB OTG
port, although it might not be the problem of DTS).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mn-var-som-symphony.dts | 240 ++++++++++++++++++
 2 files changed, 241 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 6b3494b6aa99..28904ebd92cf 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -33,6 +33,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mn-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-hummingboard-pulse.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
new file mode 100644
index 000000000000..1faa90e2d215
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2020 Krzysztof Kozlowski <krzk@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "imx8mn-var-som.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-MX8MN Symphony evaluation board";
+	compatible = "variscite,var-som-mx8mn-symphony", "variscite,var-som-mx8mn", "fsl,imx8mn";
+
+	reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio4 22 GPIO_ACTIVE_HIGH>;
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
+		led {
+			label = "Heartbeat";
+			gpios = <&pca9534 0 GPIO_ACTIVE_LOW>;
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
+
+	extcon_usbotg1: typec@3d {
+		compatible = "nxp,ptn5150";
+		reg = <0x3d>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ptn5150>;
+		status = "okay";
+	};
+};
+
+&i2c3 {
+	/* Capacitive touch controller */
+	ft5x06_ts: touchscreen@38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_captouch>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
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
+	extcon = <&extcon_usbotg1>, <&extcon_usbotg1>;
+};
+
+&pinctrl_fec1 {
+	fsl,pins = <
+		MX8MN_IOMUXC_ENET_MDC_ENET1_MDC			0x3
+		MX8MN_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3
+		MX8MN_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
+		MX8MN_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
+		MX8MN_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
+		MX8MN_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
+		MX8MN_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
+		MX8MN_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
+		MX8MN_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
+		MX8MN_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
+		MX8MN_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
+		MX8MN_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
+		MX8MN_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
+		MX8MN_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
+		/* Remove the MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9 as not used */
+	>;
+};
+
+&pinctrl_fec1_sleep {
+	fsl,pins = <
+		MX8MN_IOMUXC_ENET_MDC_GPIO1_IO16		0x120
+		MX8MN_IOMUXC_ENET_MDIO_GPIO1_IO17		0x120
+		MX8MN_IOMUXC_ENET_TD3_GPIO1_IO18		0x120
+		MX8MN_IOMUXC_ENET_TD2_GPIO1_IO19		0x120
+		MX8MN_IOMUXC_ENET_TD1_GPIO1_IO20		0x120
+		MX8MN_IOMUXC_ENET_TD0_GPIO1_IO21		0x120
+		MX8MN_IOMUXC_ENET_RD3_GPIO1_IO29		0x120
+		MX8MN_IOMUXC_ENET_RD2_GPIO1_IO28		0x120
+		MX8MN_IOMUXC_ENET_RD1_GPIO1_IO27		0x120
+		MX8MN_IOMUXC_ENET_RD0_GPIO1_IO26		0x120
+		MX8MN_IOMUXC_ENET_TXC_GPIO1_IO23		0x120
+		MX8MN_IOMUXC_ENET_RXC_GPIO1_IO25		0x120
+		MX8MN_IOMUXC_ENET_RX_CTL_GPIO1_IO24		0x120
+		MX8MN_IOMUXC_ENET_TX_CTL_GPIO1_IO22		0x120
+		/* Remove the MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9 as not used */
+	>;
+};
+
+&iomuxc {
+	pinctrl_captouch: captouchgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SPDIF_RX_GPIO5_IO4		0x16
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
+			MX8MN_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_pca9534: pca9534grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO07_GPIO1_IO7	0x16
+		>;
+	};
+
+	pinctrl_ptn5150: ptn5150grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO11_GPIO1_IO11	0x16
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SAI2_RXC_GPIO4_IO22	0x41
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_UART1_RXD_UART1_DCE_RX	0x140
+			MX8MN_IOMUXC_UART1_TXD_UART1_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_UART3_RXD_UART3_DCE_RX	0x140
+			MX8MN_IOMUXC_UART3_TXD_UART3_DCE_TX	0x140
+		>;
+	};
+};
-- 
2.17.1

