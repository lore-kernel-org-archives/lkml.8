Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F06C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7727E20890
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="SEMIrKjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgGBOeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:34:46 -0400
Received: from mail-eopbgr140091.outbound.protection.outlook.com ([40.107.14.91]:28678
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726500AbgGBOep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:34:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfSpHgioPYwABCrfjeDycK0tlMKvezjcxz1gzSpWyN7stXAD1qvvaI6W6g84mK1HUubKX3RduidXGvhN+09iYl6hwcUrB7DRxSs1Yt5bOQIjF6+gE/+QW56wVpw+RSiK6R2cbTC1M0ir/7qY1vFxH1VxaUXlzUhiOz1ssrn3ERk+UM9PqCe8x8GfUzVWfVL1nr+ho3CuJ0pRXrXTS6g6l1M9b5a0wi+zarKUlvC7VPBhwr0sKQwntNT2xPDBv+dfxl6OIbk98axYcztiY14eCrKaJtcXiDaoYewnUwWiPdX6UoOiaqfQth7o23m9d+4SArDVygbtg11zSMW5AwyWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gwcyAhRjwaB3dDTbeRpHsvnKDYtBqgJ8p5LdYn8Iao=;
 b=XCCc78mvhwEjbxoNkIZXq0Wm9nLEpdT+zfMmD8JBYBHmWLIUi1qgdcOgll3GQb855UFK1XpnWf7EfY3ajRnSGPr9Yu4gIeDyHr7oFvAuj01hKhEtABgJs21+QMa5/ri6Qee9aMQXfjKf/nyaiYWvRRtMDTpkQOrPhDc3PqUmUxvREgYhg9HHEHcQ+z/cg4DrqqMwniTdIBTsPuIiv8sR62It0/4/mWhzBetyhHKpNgf3TZev7RBisDAKg28mIkL1GAEptaAmoxfh5sKx7oxpxX+/7Tu7+IjZ/ZwOR4XNhoY3wZyj91QIM3ec3q/B+K9hv1y3vuYK0NDoRzgJXkK0tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gwcyAhRjwaB3dDTbeRpHsvnKDYtBqgJ8p5LdYn8Iao=;
 b=SEMIrKjc7dEm9B8WVCKSPZL+TifTlQkWOaNP82W9gg8lovmgleSfXTzC91sAnhJSIJf4Fel3LyFbpZYKbTZ7LMjMa9eSXFEoa3D3s2lcJG84PpMhIxa/dH5JgFhh5D1zjuxzu1aAYUPUcJzE0gBKJN276j94eWA53bc6U0kZBpw=
Authentication-Results: kemnade.info; dkim=none (message not signed)
 header.d=none;kemnade.info; dmarc=none action=none header.from=kontron.de;
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB8PR10MB2842.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Thu, 2 Jul
 2020 14:34:39 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3%4]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 14:34:39 +0000
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Andreas Kemnade <andreas@kemnade.info>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Li Yang <leoyang.li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] arm64: dts: Add the Kontron i.MX8M-Mini SoMs and baseboards
Date:   Thu,  2 Jul 2020 16:33:06 +0200
Message-Id: <20200702143337.8590-2-frieder.schrempf@kontron.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702143337.8590-1-frieder.schrempf@kontron.de>
References: <20200702143337.8590-1-frieder.schrempf@kontron.de>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:50::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fs-work.localdomain (46.142.79.231) by FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.8 via Frontend Transport; Thu, 2 Jul 2020 14:34:37 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.142.79.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab403c65-3f58-43d9-0a1c-08d81e950cdd
X-MS-TrafficTypeDiagnostic: DB8PR10MB2842:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR10MB28423882946102E01BE46209E96D0@DB8PR10MB2842.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:270;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: efSzb/jtjbbO6ykgYc0aWlAB4+pKBYNALgA6/v09yhylBomHPgeDGf45aSdyt8cU8EWWH3tt2pcYY1uD+CDHLy8X7pr4kRDF/Of3oYDDNKQU0q16K8dXSQtnodJ9Rln6uuEeUsxNONpH4Fg18S3uNfFaudrR6fqmxw9fdv3k7JJAMjSQXJ9d3AldA3bebg+sgj2JKPQEZRDWMgtDyPfYph9PZh5xuXsi6RxOFDehP3WB2+g0kRqvvfRtfu0Byixtq/9BW1iacZsAT9k9Bc+Z3LPkzHBxm0chTasaX5APSr0q5w8T3EqXadi32EBE5UcRksLisnO49ObdfDEon2Duj55nedpfnuRY2bZmMMf0Wd7O7lHQTgWr66Y74hNgHk2F+AGju3OZTMJXBZ+qB6RiKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(6029001)(4636009)(136003)(396003)(366004)(39850400004)(376002)(346002)(66476007)(66556008)(110136005)(316002)(2906002)(30864003)(8676002)(66946007)(956004)(186003)(2616005)(6666004)(5660300002)(16526019)(26005)(1076003)(36756003)(8936002)(86362001)(6506007)(52116002)(7416002)(4326008)(6486002)(83380400001)(478600001)(6512007)(921003)(473944003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: NWXXameraG4qDyF1KBtpjinEDsI7GdOk8xkXMxeoOYXmCWfmVRvkCOLDfi7fWSGsXdcEWpzNxGqDgn+JXszjgT6ZZ5yBHWCkthOfqmuMl6rUdPciJOO2c8+uxW3N1WCLOADUhu7C5w9e8lVEvd1htgHYSXqSqe6ejF2/DEzf9RVMHDiShVad78OuM/lifgnbd8ad9mRF1ZVhSkWD9LCIcg7TYIXATLC6A5XlXNDzxluZVn1rGQ2rRJ8fScWFqXo0LDTBZsI8N0E6D9ddHVyNpa9JKgD3fhn7FJeTXXekdOMjeQJL71m2XRV9K46xSXx29yjMsvDU/qBzFXrLW83Xe3ZXyDaffp11oJFMIgQEepheJpIfSQeymEYF1cqw9hoS++xnYkV3h/fj6WEIRPyHijcjIFfCemLtKxR2YDalVJ0oRvoI0VGZzzPuhZrNgu+cMI+OFLqmj+YLK2E1aOXc6zc9PjD6ZUiTnFK5hvy3YOA=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ab403c65-3f58-43d9-0a1c-08d81e950cdd
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 14:34:38.9956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpplqywN+tFPBjvHDnyTwRYxMSJk44B140b8iLzZWf3DRUWesbwV17Z36h4ucQmyU6dIwWa2NjWASaQvgIJxt/LZ0NJyR+3Q6iPyrKr5/Jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2842
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Kontron Electronics GmbH offers small and powerful SoMs based on the
i.MX8MM including PMIC, LPDDR4-RAM, eMMC and SPI NOR.

The matching baseboards have the same form factor and similar interfaces
as the other boards from the Kontron "Board-Line" family, including
SD card, 1G Ethernet, 100M Ethernet, USB Host/OTG, digital IOs, RS232,
RS485, CAN, LVDS or HDMI, RTC and much more.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 .../dts/freescale/imx8mm-kontron-n8010-s.dts  |  15 +
 .../freescale/imx8mm-kontron-n8010-som.dtsi   |  16 +
 .../dts/freescale/imx8mm-kontron-n8011-s.dts  |  15 +
 .../freescale/imx8mm-kontron-n8011-som.dtsi   |  16 +
 .../dts/freescale/imx8mm-kontron-n801x-s.dtsi | 326 ++++++++++++++++++
 .../freescale/imx8mm-kontron-n801x-som.dtsi   | 281 +++++++++++++++
 6 files changed, 669 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n8010-s.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n8010-som.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n8011-s.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n8011-som.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8010-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8010-s.dts
new file mode 100644
index 000000000000..0911f2d0555b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8010-s.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Kontron Electronics GmbH
+ */
+
+/dts-v1/;
+
+#include "imx8mm-kontron-n8010-som.dtsi"
+#include "imx8mm-kontron-n801x-s.dtsi"
+
+/ {
+	model = "Kontron i.MX8MM N8010 S";
+	compatible = "kontron,imx8mm-n8010-s", "kontron,imx8mm-n8010-som",
+		     "fsl,imx8mm";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8010-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8010-som.dtsi
new file mode 100644
index 000000000000..5b178ce4ce1b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8010-som.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Kontron Electronics GmbH
+ */
+
+#include "imx8mm-kontron-n801x-som.dtsi"
+
+/ {
+	model = "Kontron i.MX8MM N8010 SoM";
+	compatible = "kontron,imx8mm-n8010-som", "fsl,imx8mm";
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0 0x80000000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8011-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8011-s.dts
new file mode 100644
index 000000000000..5c44bd77ed32
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8011-s.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Kontron Electronics GmbH
+ */
+
+/dts-v1/;
+
+#include "imx8mm-kontron-n8011-som.dtsi"
+#include "imx8mm-kontron-n801x-s.dtsi"
+
+/ {
+	model = "Kontron i.MX8MM N8011 S";
+	compatible = "kontron,imx8mm-n8011-s", "kontron,imx8mm-n8011-som",
+		     "fsl,imx8mm";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8011-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8011-som.dtsi
new file mode 100644
index 000000000000..303594867b8f
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8011-som.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Kontron Electronics GmbH
+ */
+
+#include "imx8mm-kontron-n801x-som.dtsi"
+
+/ {
+	model = "Kontron i.MX8MM N8011 SoM";
+	compatible = "kontron,imx8mm-n8011-som", "fsl,imx8mm";
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0 0xC0000000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtsi
new file mode 100644
index 000000000000..d825e52e0beb
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtsi
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Kontron Electronics GmbH
+ */
+
+/ {
+	aliases {
+		ethernet1 = &usbnet;
+	};
+
+	/* fixed crystal dedicated to mcp2515 */
+	clk16m: clk16m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <16000000>;
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
+	vdd_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_5v";
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
+		clocks = <&clk16m>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
+		spi-max-frequency = <100000>;
+		vdd-supply = <&vdd_3v3>;
+		xceiver-supply = <&vdd_5v>;
+		status = "okay";
+	};
+};
+
+&ecspi3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	userspi: userspi@0 {
+		compatible = "kontron,user-spi";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+		status = "okay";
+	};
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
+	vmmc-supply = <&vdd_3v3>;
+	vqmmc-supply = <&nvcc_sd>;
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
index 000000000000..207be37522e5
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Kontron Electronics GmbH
+ */
+
+#include "imx8mm.dtsi"
+
+/ {
+	chosen {
+		stdout-path = &uart3;
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&A53_1 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&A53_2 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&A53_3 {
+	cpu-supply = <&vdd_arm>;
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
+			vdd_soc: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			vdd_arm: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <950000>;
+				regulator-boot-on;
+				regulator-ramp-delay = <3125>;
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <850000>;
+			};
+
+			vdd_dram: BUCK3 {
+				regulator-name = "BUCK3";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vdd_3v3: BUCK4 {
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vdd_1v8: BUCK5 {
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			nvcc_dram: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			nvcc_snvs: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vdd_snvs: LDO2 {
+				regulator-compatible = "ldo2";
+				regulator-name = "LDO2";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vdda: LDO3 {
+				regulator-name = "LDO3";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vdd_phy: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			nvcc_sd: LDO5 {
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
+	vmmc-supply = <&vdd_3v3>;
+	vqmmc-supply = <&vdd_1v8>;
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

