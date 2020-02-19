Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25067C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB48624656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="oqsXyujO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgBSNBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 08:01:05 -0500
Received: from mail-vi1eur05on2134.outbound.protection.outlook.com ([40.107.21.134]:38304
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbgBSNBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 08:01:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxtMGpsEq0qHZBNWzfW2C5XN0HKNYsO5NQMCKjETXYyrk7YSyYBzjfxUD6p0OEZVGoPLyhsElybnXkYW+vmz/5QtuXOsoU4qX9Oj0gQ3LlmcTV1Rs2Of80c4s4REm+qA+pWoDPh/vtWQEbHWHthQLwkP0832hZ80D/jOY4GHt0YWDC427LS/zSc4hsxPQT9XW1ckwBQ41rJ8GIC0NuOMXWU4hCZ3x3RnVIsDpDNtKsLv/aX8Ql60pWQ1dk+xN2cHblG9jFgyBd6SM9Ju8+rAEaHHaRx0Zd1BA3MgJCL1pX5iYyzujjTUAkMbapjkq1Yi3ZSUa/c2PakXUxUWpoaVLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emyBCdf2XMtKx87oO7YSwmAGdSXXUP1v8zJJyL6rR3k=;
 b=iiOK3sE0bH3Llf5TjfMOOy+A5JVSom94dGxFHmhbOviPCG1SdJzhJuaOTt/lvb6kN9eDkejV7bbd2pBDAALEKCM8/uGOwxfMWJo7Nc9aL3Y+Q9bxKwBOOISRu5zCEmu/3azFjKrQQ4kegg/OhoAZZq4D0ym/KDatPn/LtGFyzu+HrWvjUNR5ao12JObejDs3P2T7fDNAsRiyITKcZxASSApLdzOp5Jsl1slhkc3rRUht1h8iGuByEz17inv3WoNkNb1Q5yQrX/6b33W9vdAAu36VFg4OaRKhvb0eipsDHBgzSMziIY4H6iAqSZJkxOGKJRHuXYtoNDFyZBRR0LKxmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emyBCdf2XMtKx87oO7YSwmAGdSXXUP1v8zJJyL6rR3k=;
 b=oqsXyujO4EnLd06MKIhWLxxla710y0rBIlgpb2UcYbEVDUBUktvLGZT4VKXHzCMtLoJKoug5Y2G92Ut/wPzeu0LU+VxDjn96P4mNb4iUAeQ0rd7ie8WXbTGzllXUxk7ZyzYxbQzZG6/k/dWTLNeEign07VniEB3OXq3R7//6Clo=
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB6495.eurprd05.prod.outlook.com (20.179.24.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Wed, 19 Feb 2020 13:00:54 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 13:00:54 +0000
Received: from localhost (194.105.145.90) by PR0P264CA0138.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1a::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Wed, 19 Feb 2020 13:00:54 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] ARM: dts: imx7-colibri: add support for Toradex Aster
 carrier board
Thread-Topic: [PATCH v2 3/3] ARM: dts: imx7-colibri: add support for Toradex
 Aster carrier board
Thread-Index: AQHV5ySerGaVubMTdkmTE+/ZcfIzrg==
Date:   Wed, 19 Feb 2020 13:00:54 +0000
Message-ID: <20200219130043.3563238-4-oleksandr.suvorov@toradex.com>
References: <20200219130043.3563238-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20200219130043.3563238-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0138.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::30) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.24.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5ffecc8-4ab5-429e-01a9-08d7b53bc129
x-ms-traffictypediagnostic: VI1PR05MB6495:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB6495D21599985B1A95D60447F9100@VI1PR05MB6495.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(346002)(366004)(136003)(376002)(396003)(189003)(199004)(16526019)(52116002)(26005)(71200400001)(8936002)(186003)(8676002)(81166006)(6496006)(81156014)(7416002)(44832011)(6916009)(6486002)(1076003)(4326008)(86362001)(956004)(5660300002)(64756008)(66446008)(66556008)(2906002)(478600001)(2616005)(316002)(66476007)(36756003)(66946007)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB6495;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RI3DGDEYwzoLrJ7XiRYgF1r5NQPt1BnUUOPrjj8dUoKtawy7sKJk0Y7pDvt77IV683nrDGiffi0ogr6m194sGvYX3anCylM7e/GGkNQGmJpIF8t1MNSEIk6dDxm1A0R679NCuD/tUjhHzHwd74vBMIq2BrsBHLwFsFI0nMTdluasnaJ2zl6qjUzbZvgjBzoIzRoJJ00C0+ZBCXhEEuBCQ20AGvGuA7AOfFn/f/GXhlsHaBlw9IUTq5OT4YNm0yJgesTPVMvIM0nR+wChaq3rxPuwDKakEtAoPENn2zL1n/2B4dxGLA2Z775lb6LcSpf+R6HBBxAEMI5gtTvGPyU8A3C6wNUO7zvfFosXZMt1tWpGBcRnXrxsPkAh5T6cLBGNKq5bvkRYhKJY/PYsDVA7ldO2NdhoGEHYWndQbYE5gcZEjo0tbVLpDJMW+543rIl1
x-ms-exchange-antispam-messagedata: fwESge9aVzlQ5bci5XlblGoUJNJRTqM5dQRIFoECklawpzT50t1Mqly92zC3RGqc9n0vGyzoRAvxP48axOynVDvMBwcgTUas8bAu3GpdN5dT/2jJfYJasYNuEC2ynUU+dfnrSpT3sijXgNcon/rC8A==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ffecc8-4ab5-429e-01a9-08d7b53bc129
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 13:00:54.5831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CNFwQwVQXDGi/ft64GlcrJeIEsAKjOP9C86VHjrOyiGBYVK2HBN/xjsgsY0vNbyG7ikCpHZObZ5S6iQJ5bY08nr8bwT0H7ngqFpaWt/WhAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6495
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Toradex Aster carrier board.

Follow the usual hierarchic include model, maintaining shared
configuration imx7-colibri-aster.dtsi.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

Changes in v2:
- Change X11 license to MIT
- Sort nodes alphabetically
- Document compatibles for an Aster board in the separate commit of
  the series
- Drop the undocumented device (spidev-around work will be sent in
  the separate patchset)

 arch/arm/boot/dts/Makefile                    |   3 +
 arch/arm/boot/dts/imx7-colibri-aster.dtsi     | 169 ++++++++++++++++++
 arch/arm/boot/dts/imx7-colibri.dtsi           |   2 -
 arch/arm/boot/dts/imx7d-colibri-aster.dts     |  20 +++
 .../arm/boot/dts/imx7d-colibri-emmc-aster.dts |  20 +++
 arch/arm/boot/dts/imx7s-colibri-aster.dts     |  15 ++
 6 files changed, 227 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx7-colibri-aster.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-aster.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
 create mode 100644 arch/arm/boot/dts/imx7s-colibri-aster.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 732933318a61..bceeafccf1cf 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -610,6 +610,8 @@ dtb-$(CONFIG_SOC_IMX6UL) +=3D \
 	imx6ulz-14x14-evk.dtb
 dtb-$(CONFIG_SOC_IMX7D) +=3D \
 	imx7d-cl-som-imx7.dtb \
+	imx7d-colibri-aster.dtb \
+	imx7d-colibri-emmc-aster.dtb \
 	imx7d-colibri-emmc-eval-v3.dtb \
 	imx7d-colibri-eval-v3.dtb \
 	imx7d-mba7.dtb \
@@ -623,6 +625,7 @@ dtb-$(CONFIG_SOC_IMX7D) +=3D \
 	imx7d-sdb-sht11.dtb \
 	imx7d-zii-rmu2.dtb \
 	imx7d-zii-rpu2.dtb \
+	imx7s-colibri-aster.dtb \
 	imx7s-colibri-eval-v3.dtb \
 	imx7s-mba7.dtb \
 	imx7s-warp.dtb
diff --git a/arch/arm/boot/dts/imx7-colibri-aster.dtsi b/arch/arm/boot/dts/=
imx7-colibri-aster.dtsi
new file mode 100644
index 000000000000..9fa701bec2ec
--- /dev/null
+++ b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
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
+		stdout-path =3D "serial0:115200n8";
+	};
+
+	gpio-keys {
+		compatible =3D "gpio-keys";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_gpiokeys>;
+
+		power {
+			label =3D "Wake-Up";
+			gpios =3D <&gpio1 1 GPIO_ACTIVE_HIGH>;
+			linux,code =3D <KEY_WAKEUP>;
+			debounce-interval =3D <10>;
+			wakeup-source;
+		};
+	};
+
+	panel: panel {
+		compatible =3D "edt,et057090dhu";
+		backlight =3D <&bl>;
+		power-supply =3D <&reg_3v3>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint =3D <&lcdif_out>;
+			};
+		};
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "3.3V";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+	};
+
+	reg_5v0: regulator-5v0 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "5V";
+		regulator-min-microvolt =3D <5000000>;
+		regulator-max-microvolt =3D <5000000>;
+	};
+
+	reg_usbh_vbus: regulator-usbh-vbus {
+		compatible =3D "regulator-fixed";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_usbh_reg>;
+		regulator-name =3D "VCC_USB[1-4]";
+		regulator-min-microvolt =3D <5000000>;
+		regulator-max-microvolt =3D <5000000>;
+		gpio =3D <&gpio4 7 GPIO_ACTIVE_LOW>;
+		vin-supply =3D <&reg_5v0>;
+	};
+};
+
+&adc1 {
+	status =3D "okay";
+};
+
+/*
+ * ADC2 is not available on the Aster board and
+ * conflicts with AD7879 resistive touchscreen.
+ */
+&adc2 {
+	status =3D "disabled";
+};
+
+&bl {
+	brightness-levels =3D <0 4 8 16 32 64 128 255>;
+	default-brightness-level =3D <6>;
+	power-supply =3D <&reg_3v3>;
+	status =3D "okay";
+};
+
+&fec1 {
+	status =3D "okay";
+};
+
+&i2c4 {
+	status =3D "okay";
+
+	/* Microchip/Atmel maxtouch controller */
+	touchscreen@4a {
+		compatible =3D "atmel,maxtouch";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_gpiotouch>;
+		reg =3D <0x4a>;
+		interrupt-parent =3D <&gpio2>;
+		interrupts =3D <15 IRQ_TYPE_EDGE_FALLING>;	/* SODIMM 107 */
+		reset-gpios =3D <&gpio2 28 GPIO_ACTIVE_HIGH>;	/* SODIMM 106 */
+	};
+
+	/* M41T0M6 real time clock on carrier board */
+	rtc: m41t0m6@68 {
+		compatible =3D "st,m41t0";
+		reg =3D <0x68>;
+	};
+};
+
+&iomuxc {
+	pinctrl_gpiotouch: touchgpios {
+		fsl,pins =3D <
+			MX7D_PAD_EPDC_DATA15__GPIO2_IO15        0x74
+			MX7D_PAD_EPDC_BDR0__GPIO2_IO28          0x14
+		>;
+	};
+};
+
+&lcdif {
+	status =3D "okay";
+
+	port {
+		lcdif_out: endpoint {
+			remote-endpoint =3D <&panel_in>;
+		};
+	};
+};
+
+&pwm1 {
+	status =3D "okay";
+};
+
+&pwm2 {
+	status =3D "okay";
+};
+
+&pwm3 {
+	status =3D "okay";
+};
+
+&pwm4 {
+	status =3D "okay";
+};
+
+&uart1 {
+	status =3D "okay";
+};
+
+&uart2 {
+	status =3D "okay";
+};
+
+&uart3 {
+	status =3D "okay";
+};
+
+&usbotg1 {
+	status =3D "okay";
+};
+
+&usdhc1 {
+	keep-power-in-suspend;
+	no-1-8-v;
+	wakeup-source;
+	vmmc-supply =3D <&reg_3v3>;
+	status =3D "okay";
+};
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-c=
olibri.dtsi
index e078487a1347..973fe5715e96 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -499,7 +499,6 @@ MX7D_PAD_LCD_RESET__GPIO3_IO4		0x14 /* SODIMM 93 */
 			MX7D_PAD_EPDC_DATA13__GPIO2_IO13	0x14 /* SODIMM 95 */
 			MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11	0x14 /* SODIMM 99 */
 			MX7D_PAD_EPDC_DATA10__GPIO2_IO10	0x74 /* SODIMM 105 */
-			MX7D_PAD_EPDC_DATA15__GPIO2_IO15	0x74 /* SODIMM 107 */
 			MX7D_PAD_EPDC_DATA00__GPIO2_IO0		0x14 /* SODIMM 111 */
 			MX7D_PAD_EPDC_DATA01__GPIO2_IO1		0x14 /* SODIMM 113 */
 			MX7D_PAD_EPDC_DATA02__GPIO2_IO2		0x14 /* SODIMM 115 */
@@ -516,7 +515,6 @@ MX7D_PAD_SAI1_RX_BCLK__GPIO6_IO17	0x14 /* SODIMM 24 */
 			MX7D_PAD_SD2_DATA2__GPIO5_IO16		0x14 /* SODIMM 100 */
 			MX7D_PAD_SD2_DATA3__GPIO5_IO17		0x14 /* SODIMM 102 */
 			MX7D_PAD_EPDC_GDSP__GPIO2_IO27		0x14 /* SODIMM 104 */
-			MX7D_PAD_EPDC_BDR0__GPIO2_IO28		0x74 /* SODIMM 106 */
 			MX7D_PAD_EPDC_BDR1__GPIO2_IO29		0x14 /* SODIMM 110 */
 			MX7D_PAD_EPDC_PWR_COM__GPIO2_IO30	0x14 /* SODIMM 112 */
 			MX7D_PAD_EPDC_SDCLK__GPIO2_IO16		0x14 /* SODIMM 114 */
diff --git a/arch/arm/boot/dts/imx7d-colibri-aster.dts b/arch/arm/boot/dts/=
imx7d-colibri-aster.dts
new file mode 100644
index 000000000000..f3f0537d5a37
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-colibri-aster.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
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
+	model =3D "Toradex Colibri iMX7D on Aster Carrier Board";
+	compatible =3D "toradex,colibri-imx7d-aster", "toradex,colibri-imx7d",
+		     "fsl,imx7d";
+};
+
+&usbotg2 {
+	vbus-supply =3D <&reg_usbh_vbus>;
+	status =3D "okay";
+};
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts b/arch/arm/boot=
/dts/imx7d-colibri-emmc-aster.dts
new file mode 100644
index 000000000000..20480276cb0e
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
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
+	model =3D "Toradex Colibri iMX7D 1GB (eMMC) on Aster Carrier Board";
+	compatible =3D "toradex,colibri-imx7d-emmc-aster",
+		     "toradex,colibri-imx7d-emmc", "fsl,imx7d";
+};
+
+&usbotg2 {
+	vbus-supply =3D <&reg_usbh_vbus>;
+	status =3D "okay";
+};
diff --git a/arch/arm/boot/dts/imx7s-colibri-aster.dts b/arch/arm/boot/dts/=
imx7s-colibri-aster.dts
new file mode 100644
index 000000000000..fca4e0a95c1b
--- /dev/null
+++ b/arch/arm/boot/dts/imx7s-colibri-aster.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
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
+	model =3D "Toradex Colibri iMX7S on Aster Carrier Board";
+	compatible =3D "toradex,colibri-imx7s-aster", "toradex,colibri-imx7s",
+		     "fsl,imx7s";
+};
--=20
2.24.1

