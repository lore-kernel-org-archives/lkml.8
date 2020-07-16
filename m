Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B239C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 587222071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="aCzePTQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgGPQMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:12:55 -0400
Received: from mail-am6eur05on2106.outbound.protection.outlook.com ([40.107.22.106]:7407
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728837AbgGPQMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:12:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMWlSrvbqd+t2CTiOA23msH/NcZDr6S/OFg5PH8ZStcMAkhn57Olxt0OKDxqn3Z5KeToyxLqYbKEnW6vBenxpJPEA/hTovp8v+sT0KctO6c0wYKjxrfo4w4uQLdosD7+gBoD9ijyMMe6JzaG8XYyO/qqTkKtSV3uLEN8cbcMwnzbVyP66ZVfHJUH3tvkGr4xE/NL7Va0gFy7CJ/Fw+brrTnaBNCdV5n/lQmLygK0DZgP33tAtnXltvCIddssn7pjuvVlpmnNCKXWKJ836Wp6YoFbZqPVg9JmyASdmJapvD5Y1dCQ5HoF3BwAW8Pta/rWpsDVs1vhsWdr3h0P1bX/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqTaEjJTAVIgIbraSw2Ih0p5xz4jcbdqStnNVTa0nIA=;
 b=V2Hkhra5KaPjJd836uRBqLenxpDsvnT3zt8Jx3sZmis/iwArPDNjHM3WhWVqEhHnv+rC+/BvccX3D1ar8HdX95eVxPZDEo2gjDBGzcPX3V+jTwKvUn/scrv33eWrfwy6Gky4xXi2za1fVK3SwSOEPd3+cX7di2UFqom+4a5KzyXu0wkvfEk1GZtDudFNv2LyLEeIspKlXENVOzInE/98+V5LlM+H8BtoFPll6ExTsGbv1CMUYbgxPJaYahQw4bAfJHfX7Ky8EvJ/Zhhii7d8w04hJKdD9/JfKnGZ/PPeQD2MNiXIB+uceB9mQlHYYxRqDc+s0FFSKbS3phk74Ix1/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqTaEjJTAVIgIbraSw2Ih0p5xz4jcbdqStnNVTa0nIA=;
 b=aCzePTQ+CbpqaqyS8RDJJb6TB1fYLnudnYvswcxC4OhBDLNh9cQ5qk1op5sRUKCcTyKnS994xwxKjNG+1j6H+ts1+g85T0zYfxki3VfHoIjPbGJjXYFwvzOA41RMpotlpZVcv5q3IyFGeR9uU3hZyVzEn255ASoCZyKj0fJkJYA=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB8PR10MB3339.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:119::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Thu, 16 Jul
 2020 16:12:47 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3%4]) with mapi id 15.20.3174.027; Thu, 16 Jul 2020
 16:12:47 +0000
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Li Yang <leoyang.li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: Add the Kontron i.MX8M Mini SoMs and baseboards
Date:   Thu, 16 Jul 2020 18:11:58 +0200
Message-Id: <20200716161216.15461-2-frieder.schrempf@kontron.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716161216.15461-1-frieder.schrempf@kontron.de>
References: <20200716161216.15461-1-frieder.schrempf@kontron.de>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0092.eurprd05.prod.outlook.com
 (2603:10a6:208:136::32) To DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:50::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fs-work.localdomain (88.130.73.71) by AM0PR05CA0092.eurprd05.prod.outlook.com (2603:10a6:208:136::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 16:12:46 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [88.130.73.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 380f2c61-5175-4981-ed57-08d829a31481
X-MS-TrafficTypeDiagnostic: DB8PR10MB3339:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR10MB33396DD4C774D528963EB51AE97F0@DB8PR10MB3339.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +RnUfOuye1aSjGlOe0w3pDAK5Avlxii6wydeBXwn3feHjqqOnXR1TzYPK5QOkck7lbVA9bi8bruyLovVc1bt4KRTMk4k8kkWyH8HT7DZTQYE54dJe0EZONNllVXpuQR5HeUZ5md+p4r5UMN/Tp6BxEpSo7gr8wNLc99FXkVDqN0nZ+isBNQ6K+Zn1f9RFuFDb2rsvpRSXZcsX28UnBBHE6lCes930tiafb0KJ4rJ3/k1L565wakd+L/4jpvKsXxtWUpUG9M4J/PNBBYWgQrLttsiQHVi/ohvxLJpnMwgE/txA3v3A76jXjgr+IIYCcf3kDWFhaT7J2D6yxs6vpnQVAGkKABf9+qciM8q+zr6aLgbYBYVZGVGaR9lLctP+qFZm+5YN8GedFLSxIwXRuD4mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(6029001)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(52116002)(86362001)(6512007)(66946007)(956004)(4326008)(6506007)(110136005)(2616005)(8676002)(186003)(26005)(8936002)(16526019)(2906002)(6486002)(7416002)(83380400001)(36756003)(30864003)(5660300002)(1076003)(54906003)(66476007)(66556008)(316002)(6666004)(478600001)(921003)(473944003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 841or536+SlsaAgN44NQ3jE3fNoXH/XscvVVwjciyi33Bhor2mwpKLUr6R0bz6MpdpC95gvq7LXuvhlKeVRJ7EVPqcyCU4LyZExYoqrr+ynPSh4pd4Fvc+Yn2jhKVywG8wY54tIEFajtZgbmzX2KzC4AIvl+tqte5XKShWtU8FKLj4l7NUQCTr8mQwIhr6LYnLnF9ndWiKrQT9ycupQR8fKR4UHPp+YIr0CszPOPiWd2DqUnxcHmMZWh3hK82tiohJCD2BraCFcdJWstngYAC5VdqMxKINQwaidHEMQBnpEfIH2+/DZhJiGylmQohlDqzYXlETiiKDb6forEYGIjhX4/pe7F3lfH3PRi3Ljhz7DO7ZyCvNMAHZG8ldVxUv09vELtzyN1/3GMaFplAgPpc1HGPUO6V8cTs1n2e4fHKjez6P2PiJPucO2Usl2MLSZUbQYnJw2PKaNc6It9W5wm+SKYZa1viPgouqFAid2sjMw=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 380f2c61-5175-4981-ed57-08d829a31481
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 16:12:47.6880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laODv26Nowd3CC7/znpZz74EeyvsMWoiOsKmM388J3mW9gRJFh/JfNUSgTNH4sQkzx1TiYm/AUNbgoTaRviSx+zx4SS9DyprKQQJkgTxasY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Kontron Electronics GmbH offers small and powerful SoMs based on the
i.MX8M Mini SoC including PMIC, LPDDR4-RAM, eMMC and SPI NOR.

The matching baseboards have the same form factor and similar interfaces
as the other boards from the Kontron "Board-Line" family, including
SD card, 1G Ethernet, 100M Ethernet, USB Host/OTG, digital IOs, RS232,
RS485, CAN, LVDS or HDMI, RTC and much more.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
* Make the licensing less strict (GPL-2.0+ OR MIT)
* Merge the SoM and baseboard DTs for N8010 and N8011 into one as
  they only differ in DDR and eMMC size.
* Change compatibles and model strings to "n810x" and "N8010X".
* Only use a common memory node that will be updated by the
  bootloader reflecting the detected DDR size.
* Improve naming for 16MHz CAN fixed oscillator and set
  "clock-output-names".
* Consistently use "reg_" prefix for regulators.
* Remove "userspi" node.
* Slightly improve commit message.
---
 .../dts/freescale/imx8mm-kontron-n801x-s.dts  | 327 ++++++++++++++++++
 .../freescale/imx8mm-kontron-n801x-som.dtsi   | 294 ++++++++++++++++
 2 files changed, 621 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
new file mode 100644
index 000000000000..25b8ef569edd
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2019 Kontron Electronics GmbH
+ */
+
+/dts-v1/;
+
+#include "imx8mm-kontron-n801x-som.dtsi"
+
+/ {
+	model = "Kontron i.MX8MM N801X S";
+	compatible = "kontron,imx8mm-n801x-s", "kontron,imx8mm-n801x-som", "fsl,imx8mm";
+
+	aliases {
+		ethernet1 = &usbnet;
+	};
+
+	/* fixed crystal dedicated to mcp2515 */
+	osc_can: clock-osc-can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <16000000>;
+		clock-output-names = "osc-can";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_led>;
+
+		led1 {
+			label = "led1";
+			gpios = <&gpio4 17 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led2 {
+			label = "led2";
+			gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
+		};
+
+		led3 {
+			label = "led3";
+			gpios = <&gpio4 18 GPIO_ACTIVE_LOW>;
+		};
+
+		led4 {
+			label = "led4";
+			gpios = <&gpio4 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led5 {
+			label = "led5";
+			gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led6 {
+			label = "led6";
+			gpios = <&gpio4 7 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	pwm-beeper {
+		compatible = "pwm-beeper";
+		pwms = <&pwm2 0 5000 0>;
+	};
+
+	reg_rst_eth2: regulator-rst-eth2 {
+		compatible = "regulator-fixed";
+		regulator-name = "rst-usb-eth2";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb_eth2>;
+		gpio = <&gpio3 2 GPIO_ACTIVE_LOW>;
+		status = "okay";
+	};
+
+	reg_vdd_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		regulator-always-on;
+		status = "okay";
+	};
+};
+
+&ecspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	can0: can@0 {
+		compatible = "microchip,mcp2515";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_can>;
+		clocks = <&osc_can>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
+		spi-max-frequency = <100000>;
+		vdd-supply = <&reg_vdd_3v3>;
+		xceiver-supply = <&reg_vdd_5v>;
+		status = "okay";
+	};
+};
+
+&ecspi3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-mode = "rgmii";
+	phy-reset-gpios = <&gpio4 27 GPIO_ACTIVE_LOW>;
+	phy-reset-duration = <100>;
+	phy-reset-post-delay = <100>;
+	phy-handle = <&ethphy>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "okay";
+
+	rtc@32 {
+		compatible = "epson,rx8900";
+		reg = <0x32>;
+	};
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	linux,rs485-enabled-at-boot-time;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&usbotg1 {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	disable-over-current;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	usb1@1 {
+		compatible = "usb424,9514";
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbnet: usbether@1 {
+			compatible = "usb424,ec00";
+			reg = <1>;
+			mac-address = [ 00 00 00 00 00 00 ];
+		};
+	};
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	vmmc-supply = <&reg_vdd_3v3>;
+	vqmmc-supply = <&reg_nvcc_sd>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio>;
+
+	pinctrl_can: cangrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28		0x19
+		>;
+	};
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82
+			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82
+			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82
+			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x19
+		>;
+	};
+
+	pinctrl_ecspi3: ecspi3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART2_RXD_ECSPI3_MISO		0x82
+			MX8MM_IOMUXC_UART1_TXD_ECSPI3_MOSI		0x82
+			MX8MM_IOMUXC_UART1_RXD_ECSPI3_SCLK		0x82
+			MX8MM_IOMUXC_UART2_TXD_GPIO5_IO25		0x19
+		>;
+	};
+
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x3
+			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3
+			MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
+			MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
+			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
+			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
+			MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
+			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
+			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
+			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
+			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
+			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
+			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
+			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
+			MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19 /* PHY RST */
+			MX8MM_IOMUXC_SAI2_TXC_GPIO4_IO25		0x19 /* ETH IRQ */
+		>;
+	};
+
+	pinctrl_gpio_led: gpioledgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x19
+			MX8MM_IOMUXC_SAI1_RXD5_GPIO4_IO7		0x19
+			MX8MM_IOMUXC_SAI1_RXD6_GPIO4_IO8		0x19
+			MX8MM_IOMUXC_SAI1_RXD7_GPIO4_IO9		0x19
+			MX8MM_IOMUXC_SAI1_TXD5_GPIO4_IO17		0x19
+			MX8MM_IOMUXC_SAI1_TXD6_GPIO4_IO18		0x19
+			MX8MM_IOMUXC_SAI1_TXD7_GPIO4_IO19		0x19
+		>;
+	};
+
+	pinctrl_gpio: gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x19
+			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x19
+			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
+			MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x19
+			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19
+			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x19
+			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x19
+			MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c3
+			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x400001c3
+		>;
+	};
+
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT			0x19
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x140
+			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x140
+			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B		0x140
+			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B		0x140
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x140
+			MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x140
+			MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x140
+			MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x140
+		>;
+	};
+
+	pinctrl_usb_eth2: usbeth2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_CE1_B_GPIO3_IO2		0x19
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x190
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d0
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d0
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
new file mode 100644
index 000000000000..6ff06d1cb23a
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2019 Kontron Electronics GmbH
+ */
+
+#include "imx8mm.dtsi"
+
+/ {
+	model = "Kontron i.MX8MM N801X SoM";
+	compatible = "kontron,imx8mm-n801x-som", "fsl,imx8mm";
+
+	memory@40000000 {
+		device_type = "memory";
+		/*
+		 * There are multiple SoM flavors with different DDR sizes.
+		 * The smallest is 1GB. For larger sizes the bootloader will
+		 * update the reg property.
+		 */
+		reg = <0x0 0x40000000 0 0x80000000>;
+	};
+
+	chosen {
+		stdout-path = &uart3;
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&A53_1 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&A53_2 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&A53_3 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&ddrc {
+	operating-points-v2 = <&ddrc_opp_table>;
+
+	ddrc_opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp-25M {
+			opp-hz = /bits/ 64 <25000000>;
+		};
+
+		opp-100M {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+
+		opp-750M {
+			opp-hz = /bits/ 64 <750000000>;
+		};
+	};
+};
+
+&ecspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	cs-gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	spi-flash@0 {
+		compatible = "mxicy,mx25r1635f", "jedec,spi-nor";
+		spi-max-frequency = <80000000>;
+		reg = <0>;
+	};
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pmic: pca9450@25 {
+		compatible = "nxp,pca9450a";
+		reg = <0x25>;
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <0 GPIO_ACTIVE_LOW>;
+
+		regulators {
+			reg_vdd_soc: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			reg_vdd_arm: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <950000>;
+				regulator-boot-on;
+				regulator-ramp-delay = <3125>;
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <850000>;
+			};
+
+			reg_vdd_dram: BUCK3 {
+				regulator-name = "BUCK3";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_vdd_3v3: BUCK4 {
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_vdd_1v8: BUCK5 {
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_nvcc_dram: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_nvcc_snvs: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_vdd_snvs: LDO2 {
+				regulator-compatible = "ldo2";
+				regulator-name = "LDO2";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_vdda: LDO3 {
+				regulator-name = "LDO3";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_vdd_phy: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_nvcc_sd: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+	};
+};
+
+&uart3 { /* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	vmmc-supply = <&reg_vdd_3v3>;
+	vqmmc-supply = <&reg_vdd_1v8>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO		0x82
+			MX8MM_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI		0x82
+			MX8MM_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK		0x82
+			MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x19
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x400001c3
+			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x400001c3
+		>;
+	};
+
+	pinctrl_pmic: pmicgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x41
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX		0x140
+			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX		0x140
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK			0x190
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD			0x1d0
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d0
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d0
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d0
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d0
+			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d0
+			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d0
+			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d0
+			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d0
+			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0x019
+			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x190
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK			0x194
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD			0x1d4
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d4
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d4
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d4
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d4
+			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d4
+			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d4
+			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d4
+			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d4
+			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0x019
+			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x194
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK			0x196
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD			0x1d6
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d6
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d6
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d6
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d6
+			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d6
+			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d6
+			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d6
+			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d6
+			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0x019
+			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x196
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
+		>;
+	};
+};
-- 
2.17.1

