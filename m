Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ED9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC65120658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbgGOLz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:55:57 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:56047 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbgGOLz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:55:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.40782-0.00738642-0.584793;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03267;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.I294862_1594814139;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.I294862_1594814139)
          by smtp.aliyun-inc.com(10.147.41.187);
          Wed, 15 Jul 2020 19:55:43 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        tiny.windzz@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH 3/3] arm64: dts: allwinner: Use GPIO bank name macro to describe GPIO
Date:   Wed, 15 Jul 2020 19:55:29 +0800
Message-Id: <20200715115529.2769-1-frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Convert gpio.h to sunxi-gpio.h, and convert to use gpio bank name macro.
This is done using the following command.

sed -i 's/r_pio 0/r_pio PL/g' arch/arm64/boot/dts/allwinner/*
sed -i 's/r_pio 1/r_pio PM/g' arch/arm64/boot/dts/allwinner/*

sed -i 's/\&pio 0/\&pio PA/g' arch/arm64/boot/dts/allwinner/*
sed -i 's/\&pio 2/\&pio PC/g' arch/arm64/boot/dts/allwinner/*
sed -i 's/\&pio 3/\&pio PD/g' arch/arm64/boot/dts/allwinner/*
sed -i 's/\&pio 4/\&pio PE/g' arch/arm64/boot/dts/allwinner/*
sed -i 's/\&pio 5/\&pio PF/g' arch/arm64/boot/dts/allwinner/*
sed -i 's/\&pio 6/\&pio PG/g' arch/arm64/boot/dts/allwinner/*
sed -i 's/\&pio 7/\&pio PH/g' arch/arm64/boot/dts/allwinner/*

sed -i 's/dt-bindings\/gpio\/gpio.h/dt-bindings\/gpio\/sunxi-gpio.h/g' \
	arch/arm64/boot/dts/allwinner/*

Signed-off-by: Yangtao Li <frank@allwinnertech.com>

---
 .../allwinner/sun50i-a64-amarula-relic.dts    | 18 ++++++------
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 20 ++++++-------
 .../dts/allwinner/sun50i-a64-nanopi-a64.dts   |  8 +++---
 .../sun50i-a64-oceanic-5205-5inmfd.dts        |  4 +--
 .../dts/allwinner/sun50i-a64-olinuxino.dts    | 12 ++++----
 .../dts/allwinner/sun50i-a64-orangepi-win.dts | 20 ++++++-------
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  |  4 +--
 .../dts/allwinner/sun50i-a64-pinebook.dts     | 16 +++++------
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 14 +++++-----
 .../boot/dts/allwinner/sun50i-a64-pinetab.dts | 28 +++++++++----------
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi |  4 +--
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts | 20 ++++++-------
 .../sun50i-h5-emlid-neutis-n5-devboard.dts    |  2 +-
 .../sun50i-h5-libretech-all-h5-cc.dts         |  2 +-
 .../allwinner/sun50i-h5-nanopi-neo-plus2.dts  | 14 +++++-----
 .../dts/allwinner/sun50i-h5-nanopi-neo2.dts   | 14 +++++-----
 .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 16 +++++------
 .../allwinner/sun50i-h5-orangepi-prime.dts    | 18 ++++++------
 .../sun50i-h5-orangepi-zero-plus.dts          | 13 +++++----
 .../sun50i-h5-orangepi-zero-plus2.dts         |  6 ++--
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  8 +++---
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 20 ++++++-------
 .../allwinner/sun50i-h6-orangepi-lite2.dts    |  8 +++---
 .../allwinner/sun50i-h6-orangepi-one-plus.dts |  2 +-
 .../dts/allwinner/sun50i-h6-orangepi.dtsi     | 12 ++++----
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 16 +++++------
 .../dts/allwinner/sun50i-h6-tanix-tx6.dts     |  6 ++--
 27 files changed, 163 insertions(+), 162 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index c7bd73f35ed8..92f8caecf939 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -7,7 +7,7 @@
 #include "sun50i-a64.dtsi"
 #include "sun50i-a64-cpu-opp.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 
 / {
 	model = "Amarula A64-Relic";
@@ -23,8 +23,8 @@ chosen {
 
 	i2c {
 		compatible = "i2c-gpio";
-		sda-gpios = <&pio 4 13 GPIO_ACTIVE_HIGH>;
-		scl-gpios = <&pio 4 12 GPIO_ACTIVE_HIGH>;
+		sda-gpios = <&pio PE 13 GPIO_ACTIVE_HIGH>;
+		scl-gpios = <&pio PE 12 GPIO_ACTIVE_HIGH>;
 		i2c-gpio,delay-us = <5>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -40,8 +40,8 @@ ov5640: camera@3c {
 			AVDD-supply = <&reg_aldo1>;
 			DOVDD-supply = <&reg_dldo3>;
 			DVDD-supply = <&reg_eldo3>;
-			reset-gpios = <&pio 4 14 GPIO_ACTIVE_LOW>; /* CSI-RST-R: PE14 */
-			powerdown-gpios = <&pio 4 15 GPIO_ACTIVE_HIGH>; /* CSI-STBY-R: PE15 */
+			reset-gpios = <&pio PE 14 GPIO_ACTIVE_LOW>; /* CSI-RST-R: PE14 */
+			powerdown-gpios = <&pio PE 15 GPIO_ACTIVE_HIGH>; /* CSI-STBY-R: PE15 */
 
 			port {
 				ov5640_ep: endpoint {
@@ -60,7 +60,7 @@ wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&rtc 1>;
 		clock-names = "ext_clock";
-		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* WL-PMU-EN: PL2 */
+		reset-gpios = <&r_pio PL 2 GPIO_ACTIVE_LOW>; /* WL-PMU-EN: PL2 */
 	};
 };
 
@@ -121,8 +121,8 @@ touchscreen@5d {
 		AVDD28-supply = <&reg_ldo_io0>;			/* VCC-CTP: GPIO0-LDO */
 		interrupt-parent = <&pio>;
 		interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
-		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
-		reset-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH8 */
+		irq-gpios = <&pio PH 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
+		reset-gpios = <&pio PH 8 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH8 */
 		touchscreen-inverted-x;
 		touchscreen-inverted-y;
 	};
@@ -314,7 +314,7 @@ &usb_otg {
 };
 
 &usbphy {
-	usb0_id_det-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
+	usb0_id_det-gpios = <&pio PH 9 GPIO_ACTIVE_HIGH>; /* PH9 */
 	usb0_vbus-supply = <&reg_drivevbus>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 883f217efb81..0c5a3b044535 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -6,7 +6,7 @@
 #include "sun50i-a64.dtsi"
 #include "sun50i-a64-cpu-opp.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 
 / {
 	model = "BananaPi-M64";
@@ -38,24 +38,24 @@ leds {
 
 		pwr-led {
 			label = "bananapi-m64:red:pwr";
-			gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
+			gpios = <&pio PD 24 GPIO_ACTIVE_HIGH>; /* PD24 */
 			default-state = "on";
 		};
 
 		green {
 			label = "bananapi-m64:green:user";
-			gpios = <&pio 4 14 GPIO_ACTIVE_HIGH>; /* PE14 */
+			gpios = <&pio PE 14 GPIO_ACTIVE_HIGH>; /* PE14 */
 		};
 
 		blue {
 			label = "bananapi-m64:blue:user";
-			gpios = <&pio 4 15 GPIO_ACTIVE_HIGH>; /* PE15 */
+			gpios = <&pio PE 15 GPIO_ACTIVE_HIGH>; /* PE15 */
 		};
 	};
 
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
+		reset-gpios = <&r_pio PL 2 GPIO_ACTIVE_LOW>; /* PL2 */
 		clocks = <&rtc 1>;
 		clock-names = "ext_clock";
 	};
@@ -141,7 +141,7 @@ &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&pio PF 6 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	bus-width = <4>;
 	status = "okay";
@@ -359,9 +359,9 @@ bluetooth {
 		clock-names = "lpo";
 		vbat-supply = <&reg_dldo2>;
 		vddio-supply = <&reg_dldo4>;
-		device-wakeup-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
-		host-wakeup-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
-		shutdown-gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+		device-wakeup-gpios = <&r_pio PL 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+		host-wakeup-gpios = <&r_pio PL 5 GPIO_ACTIVE_HIGH>; /* PL5 */
+		shutdown-gpios = <&r_pio PL 4 GPIO_ACTIVE_HIGH>; /* PL4 */
 	};
 };
 
@@ -375,7 +375,7 @@ &usb_power_supply {
 };
 
 &usbphy {
-	usb0_id_det-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
+	usb0_id_det-gpios = <&pio PH 9 GPIO_ACTIVE_HIGH>; /* PH9 */
 	usb0_vbus_power-supply = <&usb_power_supply>;
 	usb0_vbus-supply = <&reg_drivevbus>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
index e58db8a6cab6..1cdf6baa86bc 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
@@ -6,7 +6,7 @@
 #include "sun50i-a64.dtsi"
 #include "sun50i-a64-cpu-opp.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 
 / {
 	model = "FriendlyARM NanoPi A64";
@@ -37,7 +37,7 @@ leds {
 
 		blue {
 			label = "nanopi-a64:blue:status";
-			gpios = <&pio 3 24 GPIO_ACTIVE_LOW>; /* PD24 */
+			gpios = <&pio PD 24 GPIO_ACTIVE_LOW>; /* PD24 */
 		};
 	};
 
@@ -45,7 +45,7 @@ wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&rtc 1>;
 		clock-names = "ext_clock";
-		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
+		reset-gpios = <&r_pio PL 2 GPIO_ACTIVE_LOW>; /* PL2 */
 	};
 };
 
@@ -113,7 +113,7 @@ &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&pio PF 6 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	bus-width = <4>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
index 577f9e1d08a1..8692e885ca7f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
@@ -44,8 +44,8 @@ touchscreen@5d {
 		AVDD28-supply = <&reg_ldo_io0>;			/* VDD_CTP: GPIO0-LDO */
 		interrupt-parent = <&pio>;
 		interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
-		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
-		reset-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH11 */
+		irq-gpios = <&pio PH 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
+		reset-gpios = <&pio PH 11 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH11 */
 		touchscreen-inverted-x;
 		touchscreen-inverted-y;
 	};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index f3f8e177ab61..41e7870ea5e4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -6,7 +6,7 @@
 #include "sun50i-a64.dtsi"
 #include "sun50i-a64-cpu-opp.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 
 / {
 	model = "Olimex A64-Olinuxino";
@@ -37,7 +37,7 @@ leds {
 
 		led-0 {
 			label = "a64-olinuxino:red:user";
-			gpios = <&pio 4 17 GPIO_ACTIVE_HIGH>; /* PE17 */
+			gpios = <&pio PE 17 GPIO_ACTIVE_HIGH>; /* PE17 */
 		};
 	};
 
@@ -48,13 +48,13 @@ reg_usb1_vbus: usb1-vbus {
 		regulator-max-microvolt = <5000000>;
 		regulator-boot-on;
 		enable-active-high;
-		gpio = <&pio 6 9 GPIO_ACTIVE_HIGH>; /* PG9 */
+		gpio = <&pio PG 9 GPIO_ACTIVE_HIGH>; /* PG9 */
 		status = "okay";
 	};
 
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
+		reset-gpios = <&r_pio PL 2 GPIO_ACTIVE_LOW>; /* PL2 */
 	};
 };
 
@@ -118,7 +118,7 @@ &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&pio PF 6 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	bus-width = <4>;
 	status = "okay";
@@ -341,7 +341,7 @@ &usb_otg {
 
 &usbphy {
 	status = "okay";
-	usb0_id_det-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
+	usb0_id_det-gpios = <&pio PH 9 GPIO_ACTIVE_HIGH>; /* PH9 */
 	usb0_vbus-supply = <&reg_drivevbus>;
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index fde9c7a99b17..fed087227c02 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -7,7 +7,7 @@
 #include "sun50i-a64.dtsi"
 #include "sun50i-a64-cpu-opp.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 
 / {
 	model = "OrangePi Win/Win Plus";
@@ -42,7 +42,7 @@ leds {
 
 		status {
 			label = "orangepi:green:status";
-			gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
+			gpios = <&pio PH 11 GPIO_ACTIVE_HIGH>; /* PH11 */
 		};
 	};
 
@@ -53,7 +53,7 @@ reg_gmac_3v3: gmac-3v3 {
 		regulator-max-microvolt = <3300000>;
 		regulator-boot-on;
 		enable-active-high;
-		gpio = <&pio 3 14 GPIO_ACTIVE_HIGH>; /* PD14 */
+		gpio = <&pio PD 14 GPIO_ACTIVE_HIGH>; /* PD14 */
 		status = "okay";
 	};
 
@@ -64,13 +64,13 @@ reg_usb1_vbus: usb1-vbus {
 		regulator-max-microvolt = <5000000>;
 		regulator-boot-on;
 		enable-active-high;
-		gpio = <&pio 3 7 GPIO_ACTIVE_HIGH>; /* PD7 */
+		gpio = <&pio PD 7 GPIO_ACTIVE_HIGH>; /* PD7 */
 		status = "okay";
 	};
 
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 */
+		reset-gpios = <&r_pio PL 8 GPIO_ACTIVE_LOW>; /* PL8 */
 		clocks = <&rtc 1>;
 		clock-names = "ext_clock";
 	};
@@ -148,7 +148,7 @@ &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	cd-gpios = <&pio PF 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	disable-wp;
 	bus-width = <4>;
 	status = "okay";
@@ -373,9 +373,9 @@ bluetooth {
 		clock-names = "lpo";
 		vbat-supply = <&reg_dldo2>;
 		vddio-supply = <&reg_dldo4>;
-		device-wakeup-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
-		host-wakeup-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
-		shutdown-gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+		device-wakeup-gpios = <&r_pio PL 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+		host-wakeup-gpios = <&r_pio PL 5 GPIO_ACTIVE_HIGH>; /* PL5 */
+		shutdown-gpios = <&r_pio PL 4 GPIO_ACTIVE_HIGH>; /* PL4 */
 	};
 };
 
@@ -406,7 +406,7 @@ &usb_otg {
 };
 
 &usbphy {
-	usb0_id_det-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
+	usb0_id_det-gpios = <&pio PH 9 GPIO_ACTIVE_HIGH>; /* PH9 */
 	usb0_vbus-supply = <&reg_drivevbus>;
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 2165f238af13..a48297098416 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -6,7 +6,7 @@
 #include "sun50i-a64.dtsi"
 #include "sun50i-a64-cpu-opp.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 
 / {
 	model = "Pine64";
@@ -118,7 +118,7 @@ &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&pio PF 6 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	bus-width = <4>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 64b1c54f87c0..0a665813df6c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -7,7 +7,7 @@
 #include "sun50i-a64.dtsi"
 #include "sun50i-a64-cpu-opp.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pwm/pwm.h>
@@ -26,7 +26,7 @@ backlight: backlight {
 		pwms = <&pwm 0 50000 0>;
 		brightness-levels = <0 5 10 15 20 30 40 55 70 85 100>;
 		default-brightness-level = <2>;
-		enable-gpios = <&pio 3 23 GPIO_ACTIVE_HIGH>; /* PD23 */
+		enable-gpios = <&pio PD 23 GPIO_ACTIVE_HIGH>; /* PD23 */
 		power-supply = <&reg_vbklt>;
 	};
 
@@ -39,7 +39,7 @@ gpio_keys {
 
 		lid_switch {
 			label = "Lid Switch";
-			gpios = <&r_pio 0 12 GPIO_ACTIVE_LOW>; /* PL12 */
+			gpios = <&r_pio PL 12 GPIO_ACTIVE_LOW>; /* PL12 */
 			linux,input-type = <EV_SW>;
 			linux,code = <SW_LID>;
 			linux,can-disable;
@@ -65,7 +65,7 @@ reg_vbklt: vbklt {
 		regulator-name = "vbklt";
 		regulator-min-microvolt = <18000000>;
 		regulator-max-microvolt = <18000000>;
-		gpio = <&pio 7 6 GPIO_ACTIVE_HIGH>; /* PH6 */
+		gpio = <&pio PH 6 GPIO_ACTIVE_HIGH>; /* PH6 */
 		enable-active-high;
 	};
 
@@ -80,13 +80,13 @@ reg_vcc5v0: vcc5v0 {
 
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
+		reset-gpios = <&r_pio PL 2 GPIO_ACTIVE_LOW>; /* PL2 */
 	};
 
 	speaker_amp: audio-amplifier {
 		compatible = "simple-audio-amplifier";
 		VCC-supply = <&reg_vcc5v0>;
-		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
+		enable-gpios = <&pio PH 7 GPIO_ACTIVE_HIGH>; /* PH7 */
 		sound-name-prefix = "Speaker Amp";
 	};
 
@@ -143,7 +143,7 @@ &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	cd-gpios = <&pio PF 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	disable-wp;
 	bus-width = <4>;
 	status = "okay";
@@ -206,7 +206,7 @@ &r_i2c {
 	anx6345: anx6345@38 {
 		compatible = "analogix,anx6345";
 		reg = <0x38>;
-		reset-gpios = <&pio 3 24 GPIO_ACTIVE_LOW>; /* PD24 */
+		reset-gpios = <&pio PD 24 GPIO_ACTIVE_LOW>; /* PD24 */
 		dvdd25-supply = <&reg_dldo2>;
 		dvdd12-supply = <&reg_fldo1>;
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index cefda145c3c9..e2ebda1509b6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -6,7 +6,7 @@
 #include "sun50i-a64.dtsi"
 #include "sun50i-a64-cpu-opp.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pwm/pwm.h>
@@ -26,31 +26,31 @@ leds {
 		blue {
 			function = LED_FUNCTION_INDICATOR;
 			color = <LED_COLOR_ID_BLUE>;
-			gpios = <&pio 3 20 GPIO_ACTIVE_HIGH>; /* PD20 */
+			gpios = <&pio PD 20 GPIO_ACTIVE_HIGH>; /* PD20 */
 		};
 
 		green {
 			function = LED_FUNCTION_INDICATOR;
 			color = <LED_COLOR_ID_GREEN>;
-			gpios = <&pio 3 18 GPIO_ACTIVE_HIGH>; /* PD18 */
+			gpios = <&pio PD 18 GPIO_ACTIVE_HIGH>; /* PD18 */
 		};
 
 		red {
 			function = LED_FUNCTION_INDICATOR;
 			color = <LED_COLOR_ID_RED>;
-			gpios = <&pio 3 19 GPIO_ACTIVE_HIGH>; /* PD19 */
+			gpios = <&pio PD 19 GPIO_ACTIVE_HIGH>; /* PD19 */
 		};
 	};
 
 	speaker_amp: audio-amplifier {
 		compatible = "simple-audio-amplifier";
-		enable-gpios = <&pio 2 7 GPIO_ACTIVE_HIGH>; /* PC7 */
+		enable-gpios = <&pio PC 7 GPIO_ACTIVE_HIGH>; /* PC7 */
 		sound-name-prefix = "Speaker Amp";
 	};
 
 	vibrator {
 		compatible = "gpio-vibrator";
-		enable-gpios = <&pio 3 2 GPIO_ACTIVE_HIGH>; /* PD2 */
+		enable-gpios = <&pio PD 2 GPIO_ACTIVE_HIGH>; /* PD2 */
 		vcc-supply = <&reg_dcdc1>;
 	};
 };
@@ -143,7 +143,7 @@ &mmc0 {
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	vqmmc-supply = <&reg_dcdc1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	cd-gpios = <&pio PF 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	disable-wp;
 	bus-width = <4>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
index dc4ab6b434f9..add0bac28e31 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
@@ -9,7 +9,7 @@
 #include "sun50i-a64.dtsi"
 #include "sun50i-a64-cpu-opp.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pwm/pwm.h>
 
@@ -27,7 +27,7 @@ backlight: backlight {
 		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
 		brightness-levels = <0 16 18 20 22 24 26 29 32 35 38 42 46 51 56 62 68 75 83 91 100>;
 		default-brightness-level = <15>;
-		enable-gpios = <&pio 3 23 GPIO_ACTIVE_HIGH>; /* PD23 */
+		enable-gpios = <&pio PD 23 GPIO_ACTIVE_HIGH>; /* PD23 */
 		power-supply = <&vdd_bl>;
 	};
 
@@ -37,8 +37,8 @@ chosen {
 
 	i2c-csi {
 		compatible = "i2c-gpio";
-		sda-gpios = <&pio 4 13 GPIO_ACTIVE_HIGH>; /* PE13 */
-		scl-gpios = <&pio 4 12 GPIO_ACTIVE_HIGH>; /* PE12 */
+		sda-gpios = <&pio PE 13 GPIO_ACTIVE_HIGH>; /* PE13 */
+		scl-gpios = <&pio PE 12 GPIO_ACTIVE_HIGH>; /* PE12 */
 		i2c-gpio,delay-us = <5>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -55,8 +55,8 @@ ov5640: camera@3c {
 			AVDD-supply = <&reg_dldo3>;
 			DOVDD-supply = <&reg_aldo1>;
 			DVDD-supply = <&reg_eldo3>;
-			reset-gpios = <&pio 4 14 GPIO_ACTIVE_LOW>; /* PE14 */
-			powerdown-gpios = <&pio 4 15 GPIO_ACTIVE_HIGH>; /* PE15 */
+			reset-gpios = <&pio PE 14 GPIO_ACTIVE_LOW>; /* PE14 */
+			powerdown-gpios = <&pio PE 15 GPIO_ACTIVE_HIGH>; /* PE15 */
 
 			port {
 				ov5640_ep: endpoint {
@@ -73,7 +73,7 @@ ov5640_ep: endpoint {
 
 	speaker_amp: audio-amplifier {
 		compatible = "simple-audio-amplifier";
-		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
+		enable-gpios = <&pio PH 7 GPIO_ACTIVE_HIGH>; /* PH7 */
 		sound-name-prefix = "Speaker Amp";
 	};
 
@@ -82,13 +82,13 @@ vdd_bl: regulator@0 {
 		regulator-name = "bl-3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		gpio = <&pio 7 6 GPIO_ACTIVE_HIGH>; /* PH6 */
+		gpio = <&pio PH 6 GPIO_ACTIVE_HIGH>; /* PH6 */
 		enable-active-high;
 	};
 
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
+		reset-gpios = <&r_pio PL 2 GPIO_ACTIVE_LOW>; /* PL2 */
 		post-power-on-delay-ms = <200>;
 	};
 };
@@ -158,7 +158,7 @@ panel@0 {
 		avdd-supply = <&reg_dc1sw>;
 		dvdd-supply = <&reg_dc1sw>;
 		cvdd-supply = <&reg_ldo_io1>;
-		reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
+		reset-gpios = <&pio PD 24 GPIO_ACTIVE_HIGH>; /* PD24 */
 		backlight = <&backlight>;
 	};
 };
@@ -179,8 +179,8 @@ touchscreen@5d {
 		reg = <0x5d>;
 		interrupt-parent = <&pio>;
 		interrupts = <7 4 IRQ_TYPE_LEVEL_HIGH>; /* PH4 */
-		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
-		reset-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
+		irq-gpios = <&pio PH 4 GPIO_ACTIVE_HIGH>; /* PH4 */
+		reset-gpios = <&pio PH 8 GPIO_ACTIVE_HIGH>; /* PH8 */
 		AVDD28-supply = <&reg_ldo_io1>;
 	};
 };
@@ -222,7 +222,7 @@ &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&pio PF 6 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	bus-width = <4>;
 	status = "okay";
@@ -452,7 +452,7 @@ &usb_power_supply {
 };
 
 &usbphy {
-	usb0_id_det-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
+	usb0_id_det-gpios = <&pio PH 9 GPIO_ACTIVE_HIGH>; /* PH9 */
 	usb0_vbus_power-supply = <&usb_power_supply>;
 	usb0_vbus-supply = <&reg_drivevbus>;
 	usb1_vbus-supply = <&reg_ldo_io0>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
index c48692b06e1f..14aef9acd2bf 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
@@ -6,7 +6,7 @@
 #include "sun50i-a64.dtsi"
 #include "sun50i-a64-cpu-opp.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 
 &codec_analog {
 	cpvdd-supply = <&reg_eldo1>;
@@ -35,7 +35,7 @@ &mmc0 {
 	non-removable;
 	disable-wp;
 	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	cd-gpios = <&pio PF 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index f5df5f705b72..6c78bb02ad4f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -7,7 +7,7 @@
 #include "sun50i-a64.dtsi"
 #include "sun50i-a64-cpu-opp.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pwm/pwm.h>
 
@@ -25,7 +25,7 @@ backlight: backlight {
 		power-supply = <&reg_dcdc1>;
 		brightness-levels = <0 5 7 10 14 20 28 40 56 80 112>;
 		default-brightness-level = <5>;
-		enable-gpios = <&pio 3 23 GPIO_ACTIVE_HIGH>; /* PD23 */
+		enable-gpios = <&pio PD 23 GPIO_ACTIVE_HIGH>; /* PD23 */
 	};
 
 	chosen {
@@ -42,7 +42,7 @@ gpio-keys {
 
 		lid-switch {
 			label = "Lid Switch";
-			gpios = <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 */
+			gpios = <&r_pio PL 8 GPIO_ACTIVE_LOW>; /* PL8 */
 			linux,input-type = <EV_SW>;
 			linux,code = <SW_LID>;
 			wakeup-source;
@@ -54,12 +54,12 @@ leds {
 
 		capslock {
 			label = "teres-i:green:capslock";
-			gpios = <&pio 2 7 GPIO_ACTIVE_HIGH>; /* PC7 */
+			gpios = <&pio PC 7 GPIO_ACTIVE_HIGH>; /* PC7 */
 		};
 
 		numlock {
 			label = "teres-i:green:numlock";
-			gpios = <&pio 2 4 GPIO_ACTIVE_HIGH>; /* PC4 */
+			gpios = <&pio PC 4 GPIO_ACTIVE_HIGH>; /* PC4 */
 		};
 	};
 
@@ -69,18 +69,18 @@ reg_usb1_vbus: usb1-vbus {
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
-		gpio = <&r_pio 0 7 GPIO_ACTIVE_HIGH>; /* PL7 */
+		gpio = <&r_pio PL 7 GPIO_ACTIVE_HIGH>; /* PL7 */
 		status = "okay";
 	};
 
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
+		reset-gpios = <&r_pio PL 2 GPIO_ACTIVE_LOW>; /* PL2 */
 	};
 
 	speaker_amp: audio-amplifier {
 		compatible = "simple-audio-amplifier";
-		enable-gpios = <&r_pio 0 12 GPIO_ACTIVE_HIGH>; /* PL12 */
+		enable-gpios = <&r_pio PL 12 GPIO_ACTIVE_HIGH>; /* PL12 */
 		sound-name-prefix = "Speaker Amp";
 	};
 };
@@ -130,7 +130,7 @@ &i2c0 {
 	anx6345: anx6345@38 {
 		compatible = "analogix,anx6345";
 		reg = <0x38>;
-		reset-gpios = <&pio 3 24 GPIO_ACTIVE_LOW>; /* PD24 */
+		reset-gpios = <&pio PD 24 GPIO_ACTIVE_LOW>; /* PD24 */
 		dvdd25-supply = <&reg_dldo2>;
 		dvdd12-supply = <&reg_dldo3>;
 
@@ -155,7 +155,7 @@ &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&pio PF 6 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	bus-width = <4>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
index 076a0b983101..5d0746c59713 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
@@ -35,7 +35,7 @@ vdd_cpux: gpio-regulator {
 		regulator-min-microvolt = <1100000>;
 		regulator-max-microvolt = <1300000>;
 		regulator-ramp-delay = <50>; /* 4ms */
-		gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+		gpios = <&r_pio PL 6 GPIO_ACTIVE_HIGH>; /* PL6 */
 		gpios-states = <0x1>;
 		states = <1100000 0>, <1300000 1>;
 	};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h5-cc.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h5-cc.dts
index df1b9263ad0e..39f6e905e172 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h5-cc.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h5-cc.dts
@@ -18,7 +18,7 @@ reg_gmac_3v3: gmac-3v3 {
 		regulator-max-microvolt = <3300000>;
 		startup-delay-us = <5000>;
 		enable-active-high;
-		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
+		gpio = <&pio PD 6 GPIO_ACTIVE_HIGH>;
 		vin-supply = <&reg_vcc5v0>;
 	};
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index 4f9ba53ffaae..da6988c8db7d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -5,7 +5,7 @@
 /dts-v1/;
 #include "sun50i-h5.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
@@ -27,13 +27,13 @@ leds {
 
 		pwr {
 			label = "nanopi:green:pwr";
-			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
+			gpios = <&r_pio PL 10 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 
 		status {
 			label = "nanopi:red:status";
-			gpios = <&pio 0 20 GPIO_ACTIVE_HIGH>;
+			gpios = <&pio PA 20 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -44,7 +44,7 @@ reg_gmac_3v3: gmac-3v3 {
 		regulator-max-microvolt = <3300000>;
 		startup-delay-us = <100000>;
 		enable-active-high;
-		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
+		gpio = <&pio PD 6 GPIO_ACTIVE_HIGH>;
 	};
 
 	reg_vcc3v3: vcc3v3 {
@@ -63,14 +63,14 @@ vdd_cpux: gpio-regulator {
 		regulator-min-microvolt = <1100000>;
 		regulator-max-microvolt = <1300000>;
 		regulator-ramp-delay = <50>; /* 4ms */
-		gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>;
+		gpios = <&r_pio PL 6 GPIO_ACTIVE_HIGH>;
 		gpios-states = <0x1>;
 		states = <1100000 0>, <1300000 1>;
 	};
 
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
+		reset-gpios = <&r_pio PL 7 GPIO_ACTIVE_LOW>; /* PL7 */
 		post-power-on-delay-ms = <200>;
 	};
 };
@@ -110,7 +110,7 @@ ext_rgmii_phy: ethernet-phy@7 {
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	cd-gpios = <&pio PF 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
index b059e20813bd..3e8ec5632c3f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
@@ -4,7 +4,7 @@
 /dts-v1/;
 #include "sun50i-h5.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 
 / {
 	model = "FriendlyARM NanoPi NEO 2";
@@ -24,13 +24,13 @@ leds {
 
 		pwr {
 			label = "nanopi:green:pwr";
-			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
+			gpios = <&r_pio PL 10 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 
 		status {
 			label = "nanopi:blue:status";
-			gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>;
+			gpios = <&pio PA 10 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -41,7 +41,7 @@ reg_gmac_3v3: gmac-3v3 {
 		regulator-max-microvolt = <3300000>;
 		startup-delay-us = <100000>;
 		enable-active-high;
-		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
+		gpio = <&pio PD 6 GPIO_ACTIVE_HIGH>;
 	};
 
 	reg_vcc3v3: vcc3v3 {
@@ -57,7 +57,7 @@ reg_usb0_vbus: usb0-vbus {
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
-		gpio = <&r_pio 0 2 GPIO_ACTIVE_HIGH>; /* PL2 */
+		gpio = <&r_pio PL 2 GPIO_ACTIVE_HIGH>; /* PL2 */
 		status = "okay";
 	};
 };
@@ -89,7 +89,7 @@ ext_rgmii_phy: ethernet-phy@7 {
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	cd-gpios = <&pio PF 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
 };
 
@@ -114,7 +114,7 @@ &usb_otg {
 
 &usbphy {
 	/* USB Type-A port's VBUS is always on */
-	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
+	usb0_id_det-gpios = <&pio PG 12 GPIO_ACTIVE_HIGH>; /* PG12 */
 	usb0_vbus-supply = <&reg_usb0_vbus>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index 7d7aad18f078..f5e53bace07b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
@@ -4,7 +4,7 @@
 /dts-v1/;
 #include "sun50i-h5.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
@@ -44,13 +44,13 @@ leds {
 
 		pwr {
 			label = "orangepi:green:pwr";
-			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
+			gpios = <&r_pio PL 10 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 
 		status {
 			label = "orangepi:red:status";
-			gpios = <&pio 0 20 GPIO_ACTIVE_HIGH>;
+			gpios = <&pio PA 20 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -60,7 +60,7 @@ r-gpio-keys {
 		sw4 {
 			label = "sw4";
 			linux,code = <BTN_0>;
-			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
+			gpios = <&r_pio PL 3 GPIO_ACTIVE_LOW>;
 			wakeup-source;
 		};
 	};
@@ -72,7 +72,7 @@ reg_gmac_3v3: gmac-3v3 {
 		regulator-max-microvolt = <3300000>;
 		startup-delay-us = <100000>;
 		enable-active-high;
-		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
+		gpio = <&pio PD 6 GPIO_ACTIVE_HIGH>;
 	};
 
 	reg_usb0_vbus: usb0-vbus {
@@ -81,7 +81,7 @@ reg_usb0_vbus: usb0-vbus {
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
-		gpio = <&r_pio 0 2 GPIO_ACTIVE_HIGH>; /* PL2 */
+		gpio = <&r_pio PL 2 GPIO_ACTIVE_HIGH>; /* PL2 */
 		status = "okay";
 	};
 };
@@ -153,7 +153,7 @@ &ir {
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	cd-gpios = <&pio PF 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
 };
 
@@ -226,7 +226,7 @@ &usb_otg {
 
 &usbphy {
 	/* USB Type-A ports' VBUS is always on */
-	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
+	usb0_id_det-gpios = <&pio PG 12 GPIO_ACTIVE_HIGH>; /* PG12 */
 	usb0_vbus-supply = <&reg_usb0_vbus>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
index cb44bfa5981f..33419f18c657 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
@@ -6,7 +6,7 @@
 /dts-v1/;
 #include "sun50i-h5.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 #include <dt-bindings/input/input.h>
 
 / {
@@ -38,13 +38,13 @@ leds {
 
 		pwr {
 			label = "orangepi:green:pwr";
-			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
+			gpios = <&r_pio PL 10 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 
 		status {
 			label = "orangepi:red:status";
-			gpios = <&pio 0 20 GPIO_ACTIVE_HIGH>;
+			gpios = <&pio PA 20 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -54,7 +54,7 @@ r-gpio-keys {
 		sw4 {
 			label = "sw4";
 			linux,code = <BTN_0>;
-			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
+			gpios = <&r_pio PL 3 GPIO_ACTIVE_LOW>;
 		};
 	};
 
@@ -65,7 +65,7 @@ reg_gmac_3v3: gmac-3v3 {
 		regulator-max-microvolt = <3300000>;
 		startup-delay-us = <100000>;
 		enable-active-high;
-		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
+		gpio = <&pio PD 6 GPIO_ACTIVE_HIGH>;
 	};
 
 	reg_vcc3v3: vcc3v3 {
@@ -81,13 +81,13 @@ reg_usb0_vbus: usb0-vbus {
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
-		gpio = <&r_pio 0 2 GPIO_ACTIVE_HIGH>; /* PL2 */
+		gpio = <&r_pio PL 2 GPIO_ACTIVE_HIGH>; /* PL2 */
 		status = "okay";
 	};
 
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&pio 2 14 GPIO_ACTIVE_LOW>; /* PC14 */
+		reset-gpios = <&pio PC 14 GPIO_ACTIVE_LOW>; /* PC14 */
 	};
 };
 
@@ -154,7 +154,7 @@ &ir {
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	cd-gpios = <&pio PF 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
 };
 
@@ -207,7 +207,7 @@ &usb_otg {
 
 &usbphy {
 	/* USB Type-A ports' VBUS is always on */
-	usb0_id_det-gpios = <&pio 0 21 GPIO_ACTIVE_HIGH>; /* PA21 */
+	usb0_id_det-gpios = <&pio PA 21 GPIO_ACTIVE_HIGH>; /* PA21 */
 	usb0_vbus-supply = <&reg_usb0_vbus>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
index ef5ca6444220..9c9c80180673 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
@@ -5,7 +5,7 @@
 /dts-v1/;
 #include "sun50i-h5.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
@@ -35,13 +35,14 @@ leds {
 
 		pwr {
 			label = "orangepi:green:pwr";
-			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PA10 */
+			/* FIXME: PA10 or PL10 ? */
+			gpios = <&r_pio PL 10 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 
 		status {
 			label = "orangepi:red:status";
-			gpios = <&pio 0 17 GPIO_ACTIVE_HIGH>; /* PA17 */
+			gpios = <&pio PA 17 GPIO_ACTIVE_HIGH>; /* PA17 */
 		};
 	};
 
@@ -52,7 +53,7 @@ reg_gmac_3v3: gmac-3v3 {
 		regulator-max-microvolt = <3300000>;
 		startup-delay-us = <100000>;
 		enable-active-high;
-		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
+		gpio = <&pio PD 6 GPIO_ACTIVE_HIGH>; /* PD6 */
 	};
 };
 
@@ -83,7 +84,7 @@ ext_rgmii_phy: ethernet-phy@1 {
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	cd-gpios = <&pio PF 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
 };
 
@@ -135,6 +136,6 @@ &usb_otg {
 
 &usbphy {
 	/* USB Type-A ports' VBUS is always on */
-	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
+	usb0_id_det-gpios = <&pio PG 12 GPIO_ACTIVE_HIGH>; /* PG12 */
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
index c95a68541309..aea3f00aaec2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
@@ -5,7 +5,7 @@
 
 #include "sun50i-h5.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 
 / {
 	model = "OrangePi Zero Plus2";
@@ -39,7 +39,7 @@ reg_vcc3v3: vcc3v3 {
 
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&pio 0 9 GPIO_ACTIVE_LOW>; /* PA9 */
+		reset-gpios = <&pio PA 9 GPIO_ACTIVE_LOW>; /* PA9 */
 		post-power-on-delay-ms = <200>;
 	};
 };
@@ -61,7 +61,7 @@ hdmi_out_con: endpoint {
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&pio PF 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 3f7ceeb1a767..a763e4d1bdad 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -6,7 +6,7 @@
 #include "sun50i-h6.dtsi"
 #include "sun50i-h6-cpu-opp.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 
 / {
 	model = "Beelink GS1";
@@ -24,7 +24,7 @@ chosen {
 	connector {
 		compatible = "hdmi-connector";
 		type = "a";
-		ddc-en-gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
+		ddc-en-gpios = <&pio PH 2 GPIO_ACTIVE_HIGH>; /* PH2 */
 
 		port {
 			hdmi_con_in: endpoint {
@@ -45,7 +45,7 @@ leds {
 
 		power {
 			label = "beelink:white:power";
-			gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+			gpios = <&r_pio PL 4 GPIO_ACTIVE_HIGH>; /* PL4 */
 			default-state = "on";
 		};
 	};
@@ -127,7 +127,7 @@ ext_rgmii_phy: ethernet-phy@1 {
 
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&pio PF 6 GPIO_ACTIVE_LOW>;
 	bus-width = <4>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 15c9dd8c4479..2ceae2c0025f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -6,7 +6,7 @@
 #include "sun50i-h6.dtsi"
 #include "sun50i-h6-cpu-opp.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 
 / {
 	model = "OrangePi 3";
@@ -23,7 +23,7 @@ chosen {
 
 	connector {
 		compatible = "hdmi-connector";
-		ddc-en-gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
+		ddc-en-gpios = <&pio PH 2 GPIO_ACTIVE_HIGH>; /* PH2 */
 		type = "a";
 
 		port {
@@ -45,13 +45,13 @@ leds {
 
 		power {
 			label = "orangepi:red:power";
-			gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+			gpios = <&r_pio PL 4 GPIO_ACTIVE_HIGH>; /* PL4 */
 			default-state = "on";
 		};
 
 		status {
 			label = "orangepi:green:status";
-			gpios = <&r_pio 0 7 GPIO_ACTIVE_HIGH>; /* PL7 */
+			gpios = <&r_pio PL 7 GPIO_ACTIVE_HIGH>; /* PL7 */
 		};
 	};
 
@@ -88,7 +88,7 @@ wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&rtc 1>;
 		clock-names = "ext_clock";
-		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
+		reset-gpios = <&r_pio PM 3 GPIO_ACTIVE_LOW>; /* PM3 */
 		post-power-on-delay-ms = <200>;
 	};
 };
@@ -130,7 +130,7 @@ hdmi_out_con: endpoint {
 
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	cd-gpios = <&pio PF 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	bus-width = <4>;
 	status = "okay";
 };
@@ -316,9 +316,9 @@ bluetooth {
 		compatible = "brcm,bcm4345c5";
 		clocks = <&rtc 1>;
 		clock-names = "lpo";
-		device-wakeup-gpios = <&r_pio 1 2 GPIO_ACTIVE_HIGH>; /* PM2 */
-		host-wakeup-gpios = <&r_pio 1 1 GPIO_ACTIVE_HIGH>; /* PM1 */
-		shutdown-gpios = <&r_pio 1 4 GPIO_ACTIVE_HIGH>; /* PM4 */
+		device-wakeup-gpios = <&r_pio PM 2 GPIO_ACTIVE_HIGH>; /* PM2 */
+		host-wakeup-gpios = <&r_pio PM 1 GPIO_ACTIVE_HIGH>; /* PM1 */
+		shutdown-gpios = <&r_pio PM 4 GPIO_ACTIVE_HIGH>; /* PM4 */
 		max-speed = <1500000>;
 	};
 };
@@ -334,7 +334,7 @@ &usb2otg {
 };
 
 &usb2phy {
-	usb0_id_det-gpios = <&pio 2 15 GPIO_ACTIVE_HIGH>; /* PC15 */
+	usb0_id_det-gpios = <&pio PC 15 GPIO_ACTIVE_HIGH>; /* PC15 */
 	usb0_vbus-supply = <&reg_vcc5v>;
 	usb3_vbus-supply = <&reg_vcc5v>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
index e8770858b5d0..b78ed393d954 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
@@ -15,7 +15,7 @@ wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&rtc 1>;
 		clock-names = "ext_clock";
-		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
+		reset-gpios = <&r_pio PM 3 GPIO_ACTIVE_LOW>; /* PM3 */
 		post-power-on-delay-ms = <200>;
 	};
 };
@@ -66,9 +66,9 @@ bluetooth {
 		compatible = "brcm,bcm4345c5";
 		clocks = <&rtc 1>;
 		clock-names = "lpo";
-		device-wakeup-gpios = <&r_pio 1 2 GPIO_ACTIVE_HIGH>; /* PM2 */
-		host-wakeup-gpios = <&r_pio 1 1 GPIO_ACTIVE_HIGH>; /* PM1 */
-		shutdown-gpios = <&r_pio 1 4 GPIO_ACTIVE_HIGH>; /* PM4 */
+		device-wakeup-gpios = <&r_pio PM 2 GPIO_ACTIVE_HIGH>; /* PM2 */
+		host-wakeup-gpios = <&r_pio PM 1 GPIO_ACTIVE_HIGH>; /* PM1 */
+		shutdown-gpios = <&r_pio PM 4 GPIO_ACTIVE_HIGH>; /* PM4 */
 		max-speed = <1500000>;
 	};
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
index fceb298bfd53..e4f2ff19327b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
@@ -19,7 +19,7 @@ reg_gmac_3v3: gmac-3v3 {
 		regulator-max-microvolt = <3300000>;
 		startup-delay-us = <100000>;
 		enable-active-high;
-		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
+		gpio = <&pio PD 6 GPIO_ACTIVE_HIGH>; /* PD6 */
 		vin-supply = <&reg_aldo2>;
 	};
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index ebc120a9232f..47e6f4203c15 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -6,7 +6,7 @@
 
 #include "sun50i-h6.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 
 / {
 	model = "OrangePi One Plus";
@@ -23,7 +23,7 @@ chosen {
 	connector {
 		compatible = "hdmi-connector";
 		type = "a";
-		ddc-en-gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
+		ddc-en-gpios = <&pio PH 2 GPIO_ACTIVE_HIGH>; /* PH2 */
 
 		port {
 			hdmi_con_in: endpoint {
@@ -44,13 +44,13 @@ leds {
 
 		power {
 			label = "orangepi:red:power";
-			gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+			gpios = <&r_pio PL 4 GPIO_ACTIVE_HIGH>; /* PL4 */
 			default-state = "on";
 		};
 
 		status {
 			label = "orangepi:green:status";
-			gpios = <&r_pio 0 7 GPIO_ACTIVE_HIGH>; /* PL7 */
+			gpios = <&r_pio PL 7 GPIO_ACTIVE_HIGH>; /* PL7 */
 		};
 	};
 
@@ -93,7 +93,7 @@ hdmi_out_con: endpoint {
 
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&pio PF 6 GPIO_ACTIVE_LOW>;
 	bus-width = <4>;
 	status = "okay";
 };
@@ -261,7 +261,7 @@ &usb2otg {
 };
 
 &usb2phy {
-	usb0_id_det-gpios = <&pio 2 6 GPIO_ACTIVE_HIGH>; /* PC6 */
+	usb0_id_det-gpios = <&pio PC 6 GPIO_ACTIVE_HIGH>; /* PC6 */
 	usb0_vbus-supply = <&reg_vcc5v>;
 	usb3_vbus-supply = <&reg_vcc5v>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index af85b2074867..642ed19d168b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -6,7 +6,7 @@
 #include "sun50i-h6.dtsi"
 #include "sun50i-h6-cpu-opp.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 
 / {
 	model = "Pine H64 model A";
@@ -32,7 +32,7 @@ ext_osc32k: ext_osc32k_clk {
 	hdmi_connector: connector {
 		compatible = "hdmi-connector";
 		type = "a";
-		ddc-en-gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
+		ddc-en-gpios = <&pio PH 2 GPIO_ACTIVE_HIGH>; /* PH2 */
 
 		port {
 			hdmi_con_in: endpoint {
@@ -46,17 +46,17 @@ leds {
 
 		heartbeat {
 			label = "pine-h64:green:heartbeat";
-			gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+			gpios = <&r_pio PL 4 GPIO_ACTIVE_HIGH>; /* PL4 */
 		};
 
 		link {
 			label = "pine-h64:white:link";
-			gpios = <&r_pio 0 3 GPIO_ACTIVE_HIGH>; /* PL3 */
+			gpios = <&r_pio PL 3 GPIO_ACTIVE_HIGH>; /* PL3 */
 		};
 
 		status {
 			label = "pine-h64:blue:status";
-			gpios = <&r_pio 0 7 GPIO_ACTIVE_HIGH>; /* PL7 */
+			gpios = <&r_pio PL 7 GPIO_ACTIVE_HIGH>; /* PL7 */
 		};
 	};
 
@@ -66,7 +66,7 @@ reg_gmac_3v3: gmac-3v3 {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		startup-delay-us = <100000>;
-		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>;
+		gpio = <&pio PC 16 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 
@@ -76,7 +76,7 @@ reg_usb_vbus: vbus {
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		startup-delay-us = <100000>;
-		gpio = <&r_pio 0 5 GPIO_ACTIVE_HIGH>;
+		gpio = <&r_pio PL 5 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 };
@@ -132,7 +132,7 @@ ext_rgmii_phy: ethernet-phy@1 {
 
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&pio PF 6 GPIO_ACTIVE_LOW>;
 	bus-width = <4>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index be81330db14f..95144ec0ac5a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -6,7 +6,7 @@
 #include "sun50i-h6.dtsi"
 #include "sun50i-h6-cpu-opp.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 
 / {
 	model = "Tanix TX6";
@@ -22,7 +22,7 @@ chosen {
 
 	connector {
 		compatible = "hdmi-connector";
-		ddc-en-gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
+		ddc-en-gpios = <&pio PH 2 GPIO_ACTIVE_HIGH>; /* PH2 */
 		type = "a";
 
 		port {
@@ -86,7 +86,7 @@ &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&pio PF 6 GPIO_ACTIVE_LOW>;
 	bus-width = <4>;
 	status = "okay";
 };
-- 
2.24.0

