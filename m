Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98522C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5582166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="b8ExbrOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgBDLM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:12:29 -0500
Received: from mail-am6eur05hn2233.outbound.protection.outlook.com ([52.101.152.233]:26047
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727119AbgBDLM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:12:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/7cdgJLN3S7oFBgFkfY5WJn2qkHWzXm3YDfokBP1B66JHUEgGqE4qMH0oaWSf+kRPTbz94QZ0uB6VnZk8VYrS+Ro+yp1ARrGnuanM5G8QVZ4WuwgA8Jsnc1/FS+Jk16NL7YYpzIGbLNUHJYjSe/RsKzFI+OmJuwemeWsZN0JM541z0XqVB0hOV9VizGbI0cU/5hyre1G1HpIqVcEWtWpaJbM139p5rFq+uispwGkjY9uJwAb6rJDoqIXciS9EnBH/RINBtLY81QM5Y8ghqoB1Dg3dG/CrglnnDlHGgL7mooTXv7ZMbnt1Zo25tcoCY9oq6Y6uJuYJc1af4wfh8aSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ2P9pMANJ7iMowc+ybhEOMYu9e3FNKQ4FlvGs3ONwY=;
 b=BEv8nbX89emCGHIljzvp9CLIGEbI47+Y4X/s4XC465hrqOQtpO2e3Aq2AUHAcI5k7j/c/KFL/MPARiREvgCRVr9egfTuQOyJOpRabIuGmPCx/5W1VN7n6FCmxS8hXZCTHvKE+s64VDC0bsKkXC4BdgcDAq/K2IQuM/txp1NmjtAlnRnDBjqkBuyP1DGbzE47QAUVSxj0al66JSdOlpuOxOtpOCbWntvGo/BtAeLe+FAKfmF8v5YvmqL7h58DYteZkyYm7h12LbeST1XjfCy7tSeHOKz2ECQcPxqmRUKXC1qtEBjsP4G+1Wq6PA4CHY/VJ06Ud6K50Nx2llkzOOPS6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ2P9pMANJ7iMowc+ybhEOMYu9e3FNKQ4FlvGs3ONwY=;
 b=b8ExbrORMmYW66Tn0XMBKbDTORmx76/6A7jKY574yPlnu6lrQZ6xltmrJRW6nWTg7vhFvBSVkVww5duJnr9lHZ8PLqRTjDvK+ifEUD4Ra5RijONVY4lQMSgf6GwThOVEdmTRteO8q14p4cp0JQ5N8v9b6Yvctfj+ERkZUd8+tlU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB5632.eurprd05.prod.outlook.com (20.178.120.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Tue, 4 Feb 2020 11:12:09 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 11:12:09 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     devicetree@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] ARM: dts: imx7-colibri: add support for Toradex Aster carrier board
Date:   Tue,  4 Feb 2020 13:11:51 +0200
Message-Id: <20200204111151.3426090-7-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204111151.3426090-1-oleksandr.suvorov@toradex.com>
References: <20200204111151.3426090-1-oleksandr.suvorov@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR2P264CA0005.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::17)
 To VI1PR05MB3279.eurprd05.prod.outlook.com (2603:10a6:802:1c::24)
MIME-Version: 1.0
Received: from localhost (194.105.145.90) by PR2P264CA0005.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29 via Frontend Transport; Tue, 4 Feb 2020 11:12:09 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [194.105.145.90]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8750c744-59dd-4286-c023-08d7a96313d8
X-MS-TrafficTypeDiagnostic: VI1PR05MB5632:|VI1PR05MB5632:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB563251F4EAFEACE1477CD948F9030@VI1PR05MB5632.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(4636009)(39840400004)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(1076003)(86362001)(36756003)(5660300002)(4326008)(6666004)(44832011)(316002)(6486002)(52116002)(6496006)(54906003)(16526019)(186003)(26005)(956004)(2616005)(478600001)(66556008)(66476007)(6916009)(7416002)(66946007)(2906002)(8936002)(81156014)(8676002)(81166006)(23200700001);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR05MB5632;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;CAT:OSPM;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eM4ohELyUD4wut/2edV9Ra1n/emT3t8B7TfrOKyHbYju5fnys/YPjnwNNhxD8Ta2TIhBbZfKzfGuOCEKKxiTIA6sxp88P/lafRwfRrIzkr09APQ2TDjYpFs1XbtBnZDwloeAYGtEXdEQehwmi/MVAioBDOwH4JizHfIgZKXyQfGcbuBpiIfIVImz/wUxYtRlg7BH+g54OQcsc1p2WkInuo1RXmaf6aTOwNtl1l3EZwRDH78p/S60LM0Hl/gcnjLnqt7JzmTGsjSV0PH+b8uAXMjZY1sTfoG5OiIYCLC9gVSxBr6Goyrd2HF6gAGsTx25s81w0yodrxS1imoNol9f3/i3lVj/ZnbkV411MZeWWy+eVsk6JAFzrKnQCeaiRyh21TqKuRA9rpKI/q1rK9krSB1iapUIHvxGOB3lxCod4QvLZhZQM7SP9bdejMFxzmPuMaHKgac8bvi84lYMHSTTc98GlKomTYhRxzhjftcoBVemjgyE/hyXQ9NTx4u2K08rV0l52eYPHTux4AYEfNdt89dxmXpM7qrbQ4oFtcz6UkQFMWKXx0SQmp2CWN5agrUON+91LAhhp0GhLiyN9RAkwicN5Q+TZ4VfyRx3Ejlv5Ymo4NlClwt76+o2n2eUfGXe54iY+RPpmlCrFI0EsPwXo9E5OZg6To9qaCuBqtJFHdnG+E6W5rXKqC2YRF7NGoe9nnZzmD5nN/7tMhx/xju+gn68+I3MQ0PQz4lYlXGTnUUE2/G0lYnKRooylM2XfR2p/iNQUneF/3Wkq1CZJ0G9pA==
X-MS-Exchange-AntiSpam-MessageData: IgEjFdLRseY0CQLcFrcL9Q0jA5TjI+wIhs5HU1xQAyqdNqvrkBvIY2M1dEPFt/DwHnWZAEPTegdDM385mc7lAPr++kIjiQvMLTH/Q01TFiWbRLkJENCpqj80APJgJUaJ4Px0tVySE0280i/9S/zTMA==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8750c744-59dd-4286-c023-08d7a96313d8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 11:12:09.7542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmLk+kRJfHU1IAvi4BTR4/BqgYKASNkirVFDMawuBG6uO6yjO2lEQTfUiaMXn6/hXBxKtVMYutauRL7CJWBDJyNYlGOpTJZ1Qn72UNjBAB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5632
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Toradex Aster carrier board.

Follow the usual hierarchic include model, maintaining shared
configuration imx7-colibri-aster.dtsi.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 arch/arm/boot/dts/Makefile                    |   3 +
 arch/arm/boot/dts/imx7-colibri-aster.dtsi     | 191 ++++++++++++++++++
 arch/arm/boot/dts/imx7-colibri.dtsi           |   2 -
 arch/arm/boot/dts/imx7d-colibri-aster.dts     |  20 ++
 .../arm/boot/dts/imx7d-colibri-emmc-aster.dts |  20 ++
 arch/arm/boot/dts/imx7s-colibri-aster.dts     |  15 ++
 6 files changed, 249 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx7-colibri-aster.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-aster.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
 create mode 100644 arch/arm/boot/dts/imx7s-colibri-aster.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e006fef77499..6165d5d3a008 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -610,6 +610,8 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ulz-14x14-evk.dtb
 dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-cl-som-imx7.dtb \
+	imx7d-colibri-aster.dtb \
+	imx7d-colibri-emmc-aster.dtb \
 	imx7d-colibri-emmc-eval-v3.dtb \
 	imx7d-colibri-eval-v3.dtb \
 	imx7d-mba7.dtb \
@@ -623,6 +625,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-sdb-sht11.dtb \
 	imx7d-zii-rmu2.dtb \
 	imx7d-zii-rpu2.dtb \
+	imx7s-colibri-aster.dtb \
 	imx7s-colibri-eval-v3.dtb \
 	imx7s-mba7.dtb \
 	imx7s-warp.dtb
diff --git a/arch/arm/boot/dts/imx7-colibri-aster.dtsi b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
new file mode 100644
index 000000000000..776dacdbbe30
--- /dev/null
+++ b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: (GPL-2.0 OR X11)
+/*
+ * Copyright 2017-2020 Toradex AG
+ *
+ */
+
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/pwm/pwm.h>
+
+/ {
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpiokeys>;
+
+		power {
+			label = "Wake-Up";
+			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_WAKEUP>;
+			debounce-interval = <10>;
+			wakeup-source;
+		};
+	};
+
+	panel: panel {
+		compatible = "edt,et057090dhu";
+		backlight = <&bl>;
+		power-supply = <&reg_3v3>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lcdif_out>;
+			};
+		};
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_5v0: regulator-5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_usbh_vbus: regulator-usbh-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbh_reg>;
+		regulator-name = "VCC_USB[1-4]";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio4 7 GPIO_ACTIVE_LOW>;
+		vin-supply = <&reg_5v0>;
+	};
+};
+
+&bl {
+	brightness-levels = <0 4 8 16 32 64 128 255>;
+	default-brightness-level = <6>;
+	power-supply = <&reg_3v3>;
+
+	status = "okay";
+};
+
+&adc1 {
+	status = "okay";
+};
+
+/*
+ * ADC2 is not available on the Aster board and
+ * conflicts with AD7879 resistive touchscreen.
+ */
+&adc2 {
+	status = "disabled";
+};
+
+&ecspi3 {
+	cs-gpios = <
+		&gpio4 11 GPIO_ACTIVE_HIGH
+		&gpio4 23 GPIO_ACTIVE_HIGH
+	>;
+	status = "okay";
+
+	spidev0: spidev@0 {
+		compatible = "toradex,evalspi";
+		reg = <0>;
+		spi-max-frequency = <23000000>;
+	};
+
+	spidev1: spidev@1 {
+		compatible = "toradex,evalspi";
+		reg = <1>;
+		spi-max-frequency = <23000000>;
+	};
+};
+
+&fec1 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+
+	/* Microchip/Atmel maxtouch controller */
+	touchscreen@4a {
+		compatible = "atmel,maxtouch";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpiotouch>;
+		reg = <0x4a>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;	/* SODIMM 107 */
+		reset-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>;	/* SODIMM 106 */
+		status = "okay";
+	};
+
+	/* M41T0M6 real time clock on carrier board */
+	rtc: m41t0m6@68 {
+		compatible = "st,m41t0";
+		reg = <0x68>;
+	};
+};
+
+&lcdif {
+	status = "okay";
+
+	port {
+		lcdif_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
+
+&pwm4 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&usbotg1 {
+	status = "okay";
+};
+
+&usdhc1 {
+	keep-power-in-suspend;
+	no-1-8-v;
+	wakeup-source;
+	vmmc-supply = <&reg_3v3>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_gpiotouch: touchgpios {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA15__GPIO2_IO15        0x74
+			MX7D_PAD_EPDC_BDR0__GPIO2_IO28          0x14
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 7b4e81412381..fc075f2465eb 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -321,7 +321,6 @@ MX7D_PAD_LCD_RESET__GPIO3_IO4		0x14 /* SODIMM 93 */
 			MX7D_PAD_EPDC_DATA13__GPIO2_IO13	0x14 /* SODIMM 95 */
 			MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11	0x14 /* SODIMM 99 */
 			MX7D_PAD_EPDC_DATA10__GPIO2_IO10	0x74 /* SODIMM 105 */
-			MX7D_PAD_EPDC_DATA15__GPIO2_IO15	0x74 /* SODIMM 107 */
 			MX7D_PAD_EPDC_DATA00__GPIO2_IO0		0x14 /* SODIMM 111 */
 			MX7D_PAD_EPDC_DATA01__GPIO2_IO1		0x14 /* SODIMM 113 */
 			MX7D_PAD_EPDC_DATA02__GPIO2_IO2		0x14 /* SODIMM 115 */
@@ -338,7 +337,6 @@ MX7D_PAD_SAI1_RX_BCLK__GPIO6_IO17	0x14 /* SODIMM 24 */
 			MX7D_PAD_SD2_DATA2__GPIO5_IO16		0x14 /* SODIMM 100 */
 			MX7D_PAD_SD2_DATA3__GPIO5_IO17		0x14 /* SODIMM 102 */
 			MX7D_PAD_EPDC_GDSP__GPIO2_IO27		0x14 /* SODIMM 104 */
-			MX7D_PAD_EPDC_BDR0__GPIO2_IO28		0x74 /* SODIMM 106 */
 			MX7D_PAD_EPDC_BDR1__GPIO2_IO29		0x14 /* SODIMM 110 */
 			MX7D_PAD_EPDC_PWR_COM__GPIO2_IO30	0x14 /* SODIMM 112 */
 			MX7D_PAD_EPDC_SDCLK__GPIO2_IO16		0x14 /* SODIMM 114 */
diff --git a/arch/arm/boot/dts/imx7d-colibri-aster.dts b/arch/arm/boot/dts/imx7d-colibri-aster.dts
new file mode 100644
index 000000000000..1e84e47a00fc
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-colibri-aster.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0 OR X11)
+/*
+ * Copyright 2017-2020 Toradex AG
+ *
+ */
+
+/dts-v1/;
+#include "imx7d-colibri.dtsi"
+#include "imx7-colibri-aster.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX7D on Colibri Aster Board";
+	compatible = "toradex,colibri-imx7d-aster", "toradex,colibri-imx7d",
+		     "fsl,imx7d";
+};
+
+&usbotg2 {
+	vbus-supply = <&reg_usbh_vbus>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts b/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
new file mode 100644
index 000000000000..9caaac6ecf5c
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0 OR X11
+/*
+ * Copyright 2017-2020 Toradex AG
+ *
+ */
+
+/dts-v1/;
+#include "imx7d-colibri-emmc.dtsi"
+#include "imx7-colibri-aster.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX7D 1GB (eMMC) on Colibri Aster Board";
+	compatible = "toradex,colibri-imx7d-emmc-aster",
+		     "toradex,colibri-imx7d-emmc", "fsl,imx7d";
+};
+
+&usbotg2 {
+	vbus-supply = <&reg_usbh_vbus>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx7s-colibri-aster.dts b/arch/arm/boot/dts/imx7s-colibri-aster.dts
new file mode 100644
index 000000000000..6fb981f3f801
--- /dev/null
+++ b/arch/arm/boot/dts/imx7s-colibri-aster.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0 OR X11)
+/*
+ * Copyright 2017-2020 Toradex AG
+ *
+ */
+
+/dts-v1/;
+#include "imx7s-colibri.dtsi"
+#include "imx7-colibri-aster.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX7S on Colibri Aster Board";
+	compatible = "toradex,colibri-imx7s-aster", "toradex,colibri-imx7s",
+		     "fsl,imx7s";
+};
-- 
2.24.1

