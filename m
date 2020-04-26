Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437F6C5519A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F90821841
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgDZSgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:36:48 -0400
Received: from mail-dm6nam11olkn2023.outbound.protection.outlook.com ([40.92.19.23]:1837
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726381AbgDZSgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:36:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4fC5Ac7/V+U+RZK9imc24vNhp08YvQB4LwSzhaUlbWwfrz5ahdF3awGGjk3sdbLsNrncRV9T/6fZdomx4v2YiwtCjfDiFFzK76MbgMdWWi9LQWbGnJAPSuhA4Id9riD0vvH9JLfMEqcm705pEv9V0HZj9AKhXuheuQpW4ajJQREifcMSSxUk/Ey9R61bY2Xl1z4cBp2bxykjjzvag2dF4cIKVMoQ2UgCVgnzzOVMffjo14PsfCMM+pu+UiWpYW8AaUEPlVtppSKCO/dk42Dw3dmDMovLkSdrbq5A7bA6m3LfwjqDvZbsqM7AtuTUwB8Vq0Z7+tjrSf/SfClkvIAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsW9msPJL61V0nWgPMShnXHiI/pvlRfU86mHVsX04Oo=;
 b=LYBMqNZbx9lKgKIKaeV5H7RKL8IdvShUCogiEu+/6Bx/3nHe+3h8nFl6pM/EoBA8l46qBklGoO0kQSDZRNdktmB7E0OMwDLsOkr+t9gGNVMNymrEHCaaYvV8/dSl1yx0VjnXnRcItwj79Y831NJIR6C4ZHdZplrCXDygW2PJ6F+68E9soOqgET1SDIhm8gWSjPP2g3kWeuecZPeZn3cCnZnRDwiOI2ZNbkyNiXIfBXcIzGa9VJDhDkDlhWdToPv5okK0lnktcxzcMfgQe8ibpf415AZi14g0snZGvg04MnRJFOXWMsTh+47mIVtHHHw/T+7+mZkXLIbw/yobUSUzFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:3861::52) by
 CO1NAM11HT054.eop-nam11.prod.protection.outlook.com (2a01:111:e400:3861::423)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Sun, 26 Apr
 2020 18:36:37 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:3861::41) by CO1NAM11FT036.mail.protection.outlook.com
 (2a01:111:e400:3861::124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15 via Frontend
 Transport; Sun, 26 Apr 2020 18:36:37 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:1D86AFA2DCD9F034353BDD66797499E89229BC6E9D144E36BD6C289AAF0BDB7D;UpperCasedChecksum:4140130A85EC5687E01257D1D188A987D41634AC3581AFAADEE4FD260B449966;SizeAsReceived:9070;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 18:36:37 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 06/13] arm: dts: s5pv210: aries: Add support for more devices
Date:   Sun, 26 Apr 2020 11:35:57 -0700
Message-ID: <BN6PR04MB0660563639D091548BFCCFF2A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426183604.28494-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CO2PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:104:1::22) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200426183604.28494-7-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb67:7300:9f89:4b96:de0b:cd14) by CO2PR05CA0096.namprd05.prod.outlook.com (2603:10b6:104:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.7 via Frontend Transport; Sun, 26 Apr 2020 18:36:36 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200426183604.28494-7-xc-racer2@live.ca>
X-TMN:  [IKZ7JgC7PISdM0tkjG25aVKSsnl8a/SSp2ft3T4lLsOuSo/LEZsxVtLqaeRRn9cW]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 1445a294-c634-45b1-0b5c-08d7ea10c0df
X-MS-TrafficTypeDiagnostic: CO1NAM11HT054:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XApl3ClZMiCgvl7PT9o3zqQRL2goOpTPbRCs40/4MPCCF7g09SsH3/CRBOwLSLTFRx+u1fklv/O/UTjFwpulH2xXb5nOhYRsxwkMT+Q1TCSFop5YppKimo728ymOBLlxbRpIKdxdHskr8Ce82Zo7zvileWR+E9mncvn5Y+NK3GpYzxG0JyyVoF1v6Z4RHUFKlZJZiDTUbH0TtTf+O7vnzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: jkOIfkHw9h/nIIQEqqyIy+2FZJDZpv6IiqQIHF5y9D+ua4OVRWAd6mHolh1/qAasqqNXqKH2D3XLt68hEMUTK6T5Bt9KnjP1vpRE07TsDLikXThdqFjhrm+BLAL7wLlwc25hU+WHaQsz7Z/SU2+MVDnznndiCNnABh4uFsv78mbVRj7UsbrgO0yUM+N/F8/GfNGmRAOiyMiQJG3HY/cLLA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1445a294-c634-45b1-0b5c-08d7ea10c0df
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 18:36:37.5682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1NAM11HT054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for following devices:
  - touchkeys connected over i2c-gpio
  - s6e63m0 panel connected over spi-gpio
  - fsa9480 microusb switch over i2c-gpio
  - wm8994 over i2c-gpio (no machine driver yet)
  - all common i2c-gpio devices

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi      | 282 ++++++++++++++++++++--
 arch/arm/boot/dts/s5pv210-fascinate4g.dts |   6 +
 2 files changed, 270 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index f83df426f2b6..ef966d13d83d 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -12,8 +12,14 @@
 	compatible = "samsung,aries", "samsung,s5pv210";
 
 	aliases {
+		i2c4 = &i2c_sound;
+		i2c5 = &i2c_accel;
 		i2c6 = &i2c_pmic;
+		i2c7 = &i2c_musb;
 		i2c9 = &i2c_fuel;
+		i2c10 = &i2c_touchkey;
+		i2c11 = &i2c_prox;
+		i2c12 = &i2c_magnetometer;
 	};
 
 	memory@30000000 {
@@ -48,6 +54,18 @@
 		gpio = <&gpj1 1 GPIO_ACTIVE_HIGH>;
 	};
 
+	touchkey_vdd: regulator-fixed-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "VTOUCH_3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&gpj3 2 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchkey_vdd_ena>;
+	};
+
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&gpg1 2 GPIO_ACTIVE_LOW>;
@@ -57,7 +75,69 @@
 		power-off-delay-us = <500>;
 	};
 
-	i2c_pmic: i2c-gpio-0 {
+	i2c_sound: i2c-gpio-0 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&mp05 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&mp05 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&sound_i2c_pins>;
+
+		wm8994: wm8994@1a {
+			compatible = "wlf,wm8994";
+			reg = <0x1a>;
+
+			#sound-dai-cells = <0>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			clocks = <&clocks MOUT_CLKOUT>;
+			clock-names = "MCLK1";
+
+			AVDD2-supply = <&buck3_reg>;
+			DBVDD-supply = <&buck3_reg>;
+			CPVDD-supply = <&buck3_reg>;
+			SPKVDD1-supply = <&buck3_reg>;
+			SPKVDD2-supply = <&buck3_reg>;
+
+			wlf,gpio-cfg = <0xa101 0x8100 0x0100 0x0100 0x8100
+					0xa101 0x0100 0x8100 0x0100 0x0100
+					0x0100>;
+
+			wlf,ldo1ena = <&gpf3 4 GPIO_ACTIVE_HIGH>;
+			wlf,ldo2ena = <&gpf3 4 GPIO_ACTIVE_HIGH>;
+
+			wlf,lineout1-se;
+			wlf,lineout2-se;
+
+			assigned-clocks = <&clocks MOUT_CLKOUT>;
+			assigned-clock-rates = <0>;
+			assigned-clock-parents = <&xusbxti>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&codec_ldo>;
+		};
+	};
+
+	i2c_accel: i2c-gpio-1 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpj3 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpj3 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&accel_i2c_pins>;
+
+		/* bma023 accelerometer, no mainline binding */
+	};
+
+	i2c_pmic: i2c-gpio-2 {
 		compatible = "i2c-gpio";
 		sda-gpios = <&gpj4 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 		scl-gpios = <&gpj4 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
@@ -137,8 +217,6 @@
 					regulator-name = "VLCD_1.8V";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
-					/* Till we get panel driver */
-					regulator-always-on;
 
 					regulator-state-mem {
 						regulator-off-in-suspend;
@@ -237,8 +315,6 @@
 					regulator-name = "VCC_3.0V_LCD";
 					regulator-min-microvolt = <3000000>;
 					regulator-max-microvolt = <3000000>;
-					/* Till we get panel driver */
-					regulator-always-on;
 
 					regulator-state-mem {
 						regulator-off-in-suspend;
@@ -309,7 +385,26 @@
 		};
 	};
 
-	i2c_fuel: i2c-gpio-1 {
+	i2c_musb: i2c-gpio-3 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpj3 4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpj3 5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&musb_i2c_pins>;
+
+		fsa9480: musb@25 {
+			compatible = "fcs,fsa9480";
+			reg = <0x25>;
+			interrupt-parent = <&gph2>;
+			interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+		};
+	};
+
+	i2c_fuel: i2c-gpio-4 {
 		compatible = "i2c-gpio";
 		sda-gpios = <&mp05 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 		scl-gpios = <&mp05 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
@@ -328,6 +423,60 @@
 		};
 	};
 
+	i2c_touchkey: i2c-gpio-5 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpj3 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpj3 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchkey_i2c_pins>;
+
+		touchkey@20 {
+			compatible = "cypress,aries-touchkey";
+			reg = <0x20>;
+			vdd-supply = <&touchkey_vdd>;
+			vcc-supply = <&buck3_reg>;
+			linux,keycodes = <KEY_MENU KEY_BACK
+					  KEY_HOMEPAGE KEY_SEARCH>;
+			interrupt-parent = <&gpj4>;
+			interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&touchkey_irq>;
+		};
+	};
+
+	i2c_prox: i2c-gpio-6 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpg2 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpg0 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&prox_i2c_pins>;
+
+		/* Sharp gp2a prox/light sensor, incomplete mainline binding */
+	};
+
+	i2c_magnetometer: i2c-gpio-7 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpj0 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpj0 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&magnetometer_i2c_pins>;
+
+		/* Yamaha yas529 magnetometer, no mainline binding */
+	};
+
 	vibrator: pwm-vibrator {
 		compatible = "pwm-vibrator";
 		pwms = <&pwm 1 44642 0>;
@@ -343,6 +492,39 @@
 		offset = <0x681c>; /* PS_HOLD_CONTROL */
 		value = <0x5200>;
 	};
+
+	spi_lcd: spi-gpio-0 {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sck-gpios = <&mp04 1 GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&mp04 3 GPIO_ACTIVE_HIGH>;
+		cs-gpios = <&mp01 1 GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_spi_pins>;
+
+		panel@0 {
+			compatible = "samsung,s6e63m0";
+			reg = <0>;
+			reset-gpios = <&mp05 5 GPIO_ACTIVE_LOW>;
+			vdd3-supply = <&ldo7_reg>;
+			vci-supply = <&ldo17_reg>;
+			spi-cs-high;
+			spi-max-frequency = <1200000>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&panel_rst>;
+
+			port {
+				lcd_ep: endpoint {
+					remote-endpoint = <&fimd_ep>;
+				};
+			};
+		};
+	};
 };
 
 &fimd {
@@ -353,18 +535,13 @@
 	samsung,invert-vden;
 	samsung,invert-vclk;
 
-	display-timings {
-		timing-0 {
-			/* 480x800@60Hz */
-			clock-frequency = <25628040>;
-			hactive = <480>;
-			vactive = <800>;
-			hfront-porch = <16>;
-			hback-porch = <16>;
-			hsync-len = <2>;
-			vfront-porch = <28>;
-			vback-porch = <1>;
-			vsync-len = <2>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	port@3 {
+		reg = <3>;
+		fimd_ep: endpoint {
+			remote-endpoint = <&lcd_ep>;
 		};
 	};
 };
@@ -405,6 +582,19 @@
 		samsung,pin-val = <1>;
 	};
 
+	codec_ldo: codec-ldo {
+		samsung,pins = "gpf3-4";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+	};
+
+	prox_i2c_pins: gp2a-i2c-pins {
+		samsung,pins = "gpg0-2", "gpg2-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
 	wlan_gpio_rst: wlan-gpio-rst {
 		samsung,pins = "gpg1-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
@@ -438,6 +628,13 @@
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
+	magnetometer_i2c_pins: yas529-i2c-pins {
+		samsung,pins = "gpj0-0", "gpj0-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
 	ts_irq: ts-irq {
 		samsung,pins = "gpj0-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
@@ -445,17 +642,66 @@
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
+	touchkey_i2c_pins: touchkey-i2c-pins {
+		samsung,pins = "gpj3-0", "gpj3-1";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	touchkey_vdd_ena: touchkey-vdd-ena {
+		samsung,pins = "gpj3-2";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	musb_i2c_pins: musb-i2c-pins {
+		samsung,pins = "gpj3-4", "gpj3-5";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	accel_i2c_pins: accel-i2c-pins {
+		samsung,pins = "gpj3-6", "gpj3-7";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
 	pmic_i2c_pins: pmic-i2c-pins {
 		samsung,pins = "gpj4-0", "gpj4-3";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
+	touchkey_irq: touchkey-irq {
+		samsung,pins = "gpj4-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	lcd_spi_pins: spi-lcd-pins {
+		samsung,pins = "mp01-1", "mp04-1", "mp04-3";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
 	fg_i2c_pins: fg-i2c-pins {
 		samsung,pins = "mp05-0", "mp05-1";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
+
+	sound_i2c_pins: sound-i2c-pins {
+		samsung,pins = "mp05-2", "mp05-3";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	panel_rst: panel-rst {
+		samsung,pins = "mp05-5";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
 };
 
 &pwm {
diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
index 94dcb9b64b9a..42e6e2de197d 100644
--- a/arch/arm/boot/dts/s5pv210-fascinate4g.dts
+++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
@@ -278,3 +278,9 @@
 		PIN_SLP(mp07-7, INPUT, DOWN);
 	};
 };
+
+&wm8994 {
+	/* GPIO3 (BCLK2) and GPIO4 (LRCLK2) as outputs */
+	wlf,gpio-cfg = <0xa101 0x8100 0x8100 0x8100 0x8100 0xa101
+		0x0100 0x8100 0x0100 0x0100 0x0100>;
+};
-- 
2.20.1

