Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF2DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A39DA206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgETPlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgETPle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:41:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB9BC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 08:41:34 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jbQqM-0008V2-GO; Wed, 20 May 2020 17:41:18 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jbQqL-0003iK-Gt; Wed, 20 May 2020 17:41:17 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v8 2/5] ARM: dts: add Protonic WD2 board
Date:   Wed, 20 May 2020 17:41:13 +0200
Message-Id: <20200520154116.12909-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520154116.12909-1-o.rempel@pengutronix.de>
References: <20200520154116.12909-1-o.rempel@pengutronix.de>
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/imx6q-prtwd2.dts | 188 +++++++++++++++++++++++++++++
 2 files changed, 189 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-prtwd2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 206a36a50575e..8ce744f1cbfc9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -539,6 +539,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-pico-pi.dtb \
 	imx6q-pistachio.dtb \
 	imx6q-prti6q.dtb \
+	imx6q-prtwd2.dtb \
 	imx6q-rex-pro.dtb \
 	imx6q-sabreauto.dtb \
 	imx6q-sabrelite.dtb \
diff --git a/arch/arm/boot/dts/imx6q-prtwd2.dts b/arch/arm/boot/dts/imx6q-prtwd2.dts
new file mode 100644
index 0000000000000..fd9f457a273e2
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-prtwd2.dts
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 Protonic Holland
+ */
+
+/dts-v1/;
+#include "imx6q.dtsi"
+#include "imx6qdl-prti6q.dtsi"
+#include <dt-bindings/leds/common.h>
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
+	usdhc2_wifi_pwrseq: usdhc2_wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wifi_npd>;
+		reset-gpios = <&gpio6 10 GPIO_ACTIVE_LOW>;
+	};
+
+	/* PRTWD2 rev 1 bitbang I2C for Ethernet Switch */
+	i2c@4 {
+		compatible = "i2c-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c4>;
+		sda-gpios = <&gpio1 22 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpio1 31 GPIO_ACTIVE_HIGH>;
+		i2c-gpio,delay-us = <20>;	/* ~10 kHz */
+		i2c-gpio,scl-output-only;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
+
+&can1 {
+	pinctrl-0 = <&pinctrl_can1 &pinctrl_can1phy>;
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
+	fixed-link {
+		speed = <100>;
+		pause;
+		full-duplex;
+	};
+};
+
+&i2c3 {
+	adc@49 {
+		compatible = "ti,ads1015";
+		reg = <0x49>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* V in */
+		channel@4 {
+			reg = <4>;
+			ti,gain = <1>;
+			ti,datarate = <3>;
+		};
+
+		/* I charge */
+		channel@5 {
+			reg = <5>;
+			ti,gain = <1>;
+			ti,datarate = <3>;
+		};
+
+		/* V bus  */
+		channel@6 {
+			reg = <6>;
+			ti,gain = <1>;
+			ti,datarate = <3>;
+		};
+
+		/* nc */
+		channel@7 {
+			reg = <7>;
+			ti,gain = <1>;
+			ti,datarate = <3>;
+		};
+	};
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	non-removable;
+	no-1-8-v;
+	non-removable;
+	mmc-pwrseq = <&usdhc2_wifi_pwrseq>;
+	pm-ignore-notify;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	wifi@1 {
+		compatible = "brcm,bcm4329-fmac";
+		reg = <1>;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_eth_chg>;
+
+	pinctrl_can1phy: can1phy {
+		fsl,pins = <
+			/* CAN1_SR */
+			MX6QDL_PAD_KEY_COL3__GPIO4_IO12	0x13070
+		>;
+	};
+
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			/* MX6QDL_ENET_PINGRP4 */
+			MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0	0x1b0b0
+			MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1	0x1b0b0
+			MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER	0x130b0
+			MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN	0x1b0b0
+			MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0	0x1b0b0
+			MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1	0x1b0b0
+			MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN	0x1b0b0
+
+			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x1b0b0
+			/* Phy reset */
+			MX6QDL_PAD_CSI0_DAT4__GPIO5_IO22	0x1b0b0
+			/* nINTRP */
+			MX6QDL_PAD_CSI0_DAT5__GPIO5_IO23	0x1b0b0
+
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x10030
+			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x10030
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_MDIO__GPIO1_IO22	0x1f8b0
+			MX6QDL_PAD_ENET_MDC__GPIO1_IO31		0x1f8b0
+		>;
+	};
+
+	pinctrl_usb_eth_chg: usbethchggrp {
+		fsl,pins = <
+			/* USB charging control */
+			MX6QDL_PAD_NANDF_CS0__GPIO6_IO11	0x130b0
+			MX6QDL_PAD_NANDF_CS1__GPIO6_IO14	0x130b0
+			MX6QDL_PAD_NANDF_CS2__GPIO6_IO15	0x130b0
+			MX6QDL_PAD_NANDF_CS3__GPIO6_IO16	0x130b0
+			>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x170b9
+			MX6QDL_PAD_SD2_CLK__SD2_CLK		0x100b9
+			MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x170b9
+			MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x170b9
+			MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x170b9
+			MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x170b9
+		>;
+	};
+
+	pinctrl_wifi_npd: wifinpd {
+		fsl,pins = <
+			/* WL_REG_ON */
+			MX6QDL_PAD_NANDF_RB0__GPIO6_IO10	0x13069
+		>;
+	};
+};
-- 
2.26.2

