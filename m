Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A09C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 11:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9277F20707
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 11:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/ToMwfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgEaLFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 07:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEaLFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 07:05:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582DFC061A0E;
        Sun, 31 May 2020 04:05:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u13so8072974wml.1;
        Sun, 31 May 2020 04:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AT9WTEfAtuwvVvVIeu3P0meYTYTzMG8OyoNuq6VEJOw=;
        b=C/ToMwfXHjuwpJpQO5MkzY/Zaqw6TQ8bIGKsO0A56E494Ed0excPbneyZr3/bU7CPs
         HH/AHwu+DXncEKM68dE1r3MEcrsxl+H9lC0ndX9dOqUtLMY/ucXuO3ti6mjlbApfvhhn
         eOLVgr+14CClpVCnq1Z1Jf+dO7ODM1F3lQccLMC8lFIE7ZxlO4gafkeJJGbMd6v7BChX
         G45i11KLMfnP8aMwBotN1CrmYM9OF/Rz9dkhGzogM0vhA8MP+JksIhPA9A+umznC+Gzu
         QnA7tSbAZsvdeEcJF0a47uurj5ljjriiG/m3+auXT7Lb3etKjWvyt2ak8cE8dRivlHYT
         8eOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AT9WTEfAtuwvVvVIeu3P0meYTYTzMG8OyoNuq6VEJOw=;
        b=APNptjDH/KcUS7kO5PSk2T+1fsqnXGCUl49RK96A6VOMrN5lA2xpqB8kJgaVfNGNAX
         1/D+KJ0a6yvfN8pFmP8gOG7Q9CIGEMMNO2pO1m3dc0PJIpHuVMpVS7/kLYYb2HpuRu6u
         LSx5QWQ3Tfj4/j0QDq0sw4Dv81iRVSiLPgN/1q+yApRyfSdSj2jwi0XZMt7hr+E8uy+K
         dsCj5xUgvzn51Tct3tHgOZlzqspjd5hYupaLTxNWTkmX3dkMhDoA8cXR/hrtWh6Fp3cX
         CYeFC2mscI4C78Ft2Cab7E7gnOqZ6JO9irWZBjG+AP0yZsa+Jh6S62r1WshzO7Ydo0vN
         LVFA==
X-Gm-Message-State: AOAM530XT6/SVAKjBVp1Mz+jPzqz48Behh2FuhoTkVCYdHUUoOymDuk4
        Zzo5nXxqiVoeWi8+LEoQc4A=
X-Google-Smtp-Source: ABdhPJyrq6WjhuNKoq4rPeqNjintcSAiZXH551FP021aQYUgwYP2N2vEVHE8O1nmCPxxmEN/O6JQiw==
X-Received: by 2002:a1c:7917:: with SMTP id l23mr7351563wme.117.1590923143821;
        Sun, 31 May 2020 04:05:43 -0700 (PDT)
Received: from localhost.localdomain ([31.177.242.137])
        by smtp.gmail.com with ESMTPSA id p16sm16886674wru.27.2020.05.31.04.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 04:05:42 -0700 (PDT)
From:   stulluk@gmail.com
To:     mripard@kernel.org
Cc:     robh+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Sertac TULLUK <stulluk@gmail.com>
Subject: [PATCH] arm: allwinner: a20: Add Drejo DS167 initial support
Date:   Sun, 31 May 2020 14:05:38 +0300
Message-Id: <20200531110538.30153-1-stulluk@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sertac TULLUK <stulluk@gmail.com>

Drejo DS167 is an Allwinner A20 based IoT device,
which support
- Allwinner A20 Cortex-A7
- Mali-400MP2 GPU
- AXP209 PMIC
- 1GB DDR3 RAM
- 8GB eMMC
- 10/100M Ethernet
- SATA
- HDMI
- 10.1inch and 7.0inch LVDS LCD and Touch screens
- CSI: OV5640 sensor
- USB OTG
- 2x USB2.0
- built-in KNX Transceiver
- 3x Dry Contact Input
- 3x Relay output
- IR RX/TX
- UART3
- SPI1
- RTC Battery
- 8x GPIO
- Analogue + Digital Microphone
- PAM8620 speaker Amplifier
- 12V DC power supply
- 3.7V Battery Operable

Signed-off-by: Sertac TULLUK <stulluk@gmail.com>
---
 arch/arm/boot/dts/Makefile                    |   2 +
 .../boot/dts/sun7i-a20-drejo-ds167-emmc.dts   |  69 +++++
 arch/arm/boot/dts/sun7i-a20-drejo-ds167.dts   | 288 ++++++++++++++++++
 3 files changed, 359 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-drejo-ds167-emmc.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-drejo-ds167.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3823090d07e7..d81e685dee38 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1097,6 +1097,8 @@ dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-bananapro.dtb \
 	sun7i-a20-cubieboard2.dtb \
 	sun7i-a20-cubietruck.dtb \
+	sun7i-a20-drejo-ds167.dtb \
+        sun7i-a20-drejo-ds167-emmc.dtb \
 	sun7i-a20-hummingbird.dtb \
 	sun7i-a20-itead-ibox.dtb \
 	sun7i-a20-i12-tvbox.dtb \
diff --git a/arch/arm/boot/dts/sun7i-a20-drejo-ds167-emmc.dts b/arch/arm/boot/dts/sun7i-a20-drejo-ds167-emmc.dts
new file mode 100644
index 000000000000..b6147eb013b0
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-drejo-ds167-emmc.dts
@@ -0,0 +1,69 @@
+/*
+ * Copyright 2020 Sertac TULLUK
+ *
+ * Sertac TULLUK <stulluk@gmail.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "sun7i-a20-drejo-ds167.dts"
+
+/ {
+	model = "drejo DS167-eMMC";
+	compatible = "drejo,sun7i-a20-drejo-ds167-emmc", "allwinner,sun7i-a20";
+
+	mmc2_pwrseq: pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&pio 2 24 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&mmc2 {
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	non-removable;
+	mmc-pwrseq = <&mmc2_pwrseq>;
+	status = "okay";
+
+	emmc: emmc@0 {
+		reg = <0>;
+		compatible = "mmc-card";
+		broken-hpi;
+	};
+};
diff --git a/arch/arm/boot/dts/sun7i-a20-drejo-ds167.dts b/arch/arm/boot/dts/sun7i-a20-drejo-ds167.dts
new file mode 100644
index 000000000000..79db92f88251
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-drejo-ds167.dts
@@ -0,0 +1,288 @@
+/*
+ * Copyright 2020 Sertac TULLUK
+ *
+ * Sertac TULLUK <stulluk@gmail.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "sun7i-a20.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	model = "drejo DS167";
+	compatible = "drejo,sun7i-a20-drejo-ds167", "allwinner,sun7i-a20";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart3;
+
+		spi0 = &spi1;
+		spi1 = &spi2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_ds167>;
+
+		red {
+			label = "ds167-status";
+			gpios = <&pio 8 9 GPIO_ACTIVE_LOW>;  /* PI9 STATUS LED NEAR A20 SERTAC */
+			default-state = "on";
+		};
+	};
+};
+
+&ahci {
+	target-supply = <&reg_ahci_5v>;
+	status = "okay";
+};
+
+&codec {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&de {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_mii_pins>, <&gmac_txerr>;
+	phy-handle = <&phy1>;
+	phy-mode = "mii";
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	axp209: pmic@34 {
+		reg = <0x34>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&lradc {
+	vref-supply = <&reg_vcc3v0>;
+	status = "okay";
+};
+
+&gmac_mdio {
+	phy1: ethernet-phy@1 {
+		reg = <1>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&otg_sram {
+	status = "okay";
+};
+
+&pio {
+	gmac_txerr: gmac-txerr-pin {
+		pins = "PA17";
+		function = "gmac";
+	};
+
+	led_pins_ds167: led-pins {  
+		pins = "PI9";   /* Status led, on schematic, this is LED_EN */
+		function = "gpio_out";
+		drive-strength = <20>;
+	};
+};
+
+&pwm {
+      pinctrl-names = "default";
+      pinctrl-0 = <&pwm0_pin>, <&pwm1_pin>;
+      status = "okay";
+};
+
+#include "axp209.dtsi"
+
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-int-dll";
+};
+
+&reg_ldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
+&reg_ahci_5v {
+	status = "okay";
+};
+
+&reg_usb0_vbus {
+	status = "okay";
+};
+
+&reg_usb1_vbus {
+	status = "okay";
+};
+
+&reg_usb2_vbus {
+	status = "okay";
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pi_pins>,
+		    <&spi1_cs0_pi_pin>;
+	status = "okay";
+};
+
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_pc_pins>,
+		    <&spi2_cs0_pc_pin>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pg_pins>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb_power_supply {
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 7 4 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH4 */
+	usb0_vbus_det-gpios = <&pio 7 5 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>; /* PH5 */
+	usb0_vbus-supply = <&reg_usb0_vbus>;
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb2_vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
+};
-- 
2.17.1

