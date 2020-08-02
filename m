Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95198C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 20:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 800B02072A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 20:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="broiPk0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgHBU3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 16:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgHBU3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 16:29:30 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E5CC06174A;
        Sun,  2 Aug 2020 13:29:30 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a14so8838446edx.7;
        Sun, 02 Aug 2020 13:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3J37uxaE+JC2NHgQ9X6Djh4nwsDEJFu6G317WySC1bg=;
        b=broiPk0PLe4t5SEOb1FZw6YPVEHQNZo8VTOrF/K1nrirkum0BVWSt5Y7GF4I7zOGP6
         PLnN7toCa4e+4wv6DDccsza42XCE5E0nQvkMW/U4H73tGSFWYE+XI/npsf3ZGQjx+qV7
         UcwysbFJhSYMTgOEhY6odzo+h00KioAv90zyU3lYz9+3ZfLltS4xVJDCztMyuRPl9LWN
         +WBGpSkUyqodvA2eYU88feICBmHSZeqVscQ04CUc05VxAzLA0Up3yaJB25nvBOvF+pqY
         5Z8JCkIFi7DjbKRgifvDCMjjGqS1v1reTOGytkL0MpHvcPFI1R5QgnpCo7XoOFyZQ1Z1
         2BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3J37uxaE+JC2NHgQ9X6Djh4nwsDEJFu6G317WySC1bg=;
        b=dPwITS3CuEJOiBX8xzxHWSs0E6bGJ1AFNSo5fkVxPc5PaPvvKoFCT5Hn5UopKJadLp
         rB1vZpAjl+sPCweA4ikdP2q4RCGKQqNhOTFtRwkThwaUmf5wdrlmRICvv6fymOkE+ESN
         h0ZpGYM045VrCtFFQWuV901r3a0LqhQqI7WGGD/atv2LM0UqSC4M/mervcdm5T5yXvSK
         ZzEN2AkgLZhaIA7cN87L9XU4RlHJDh19B1/M7zxGwJamSmpMa6xTP+mFFJ68vIybACWe
         LKneEXdYMV0+A1uoQWSwgye/zI+pvgsqMoCb/a5kMD2+pX9ewBiwgcB49eTjT35vcyEW
         +vsg==
X-Gm-Message-State: AOAM531wnA4wurQCrFS/yBusNvE2GwSHaPO+Cd+3AWBs5cbZX3R95MHE
        9uh7e1pZ0WKcbwVbadMjZtn6zeYJDaWgMA==
X-Google-Smtp-Source: ABdhPJybPMfke3pwRn41/RYWqF37HhqFC1CZFcBszUBJd+h40h/LPCD7oONJHqwuVykRDQTwLO+bqA==
X-Received: by 2002:a05:6402:2379:: with SMTP id a25mr12669941eda.180.1596400169306;
        Sun, 02 Aug 2020 13:29:29 -0700 (PDT)
Received: from localhost.localdomain ([31.177.242.137])
        by smtp.gmail.com with ESMTPSA id c7sm14122011ejr.77.2020.08.02.13.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 13:29:28 -0700 (PDT)
From:   stulluk@gmail.com
To:     mripard@kernel.org
Cc:     robh+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, Sertac TULLUK <stulluk@gmail.com>
Subject: arm: dts: allwinner: a20: Add Drejo DS167 initial support
Date:   Sun,  2 Aug 2020 23:29:24 +0300
Message-Id: <20200802202924.5166-1-stulluk@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sertac TULLUK <stulluk@gmail.com>

Drejo DS167 is an Allwinner A20 based IoT device, which support 

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
- builtin KNX Transceiver
- 3x Dry Contact Input
- 3x Relay output
- IR
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
 .../boot/dts/sun7i-a20-drejo-ds167-emmc.dts   |  69 ++++
 arch/arm/boot/dts/sun7i-a20-drejo-ds167.dts   | 361 ++++++++++++++++++
 3 files changed, 432 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-drejo-ds167-emmc.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-drejo-ds167.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3823090d0..574305522 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1115,6 +1115,8 @@ dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-olinuxino-lime2-emmc.dtb \
 	sun7i-a20-olinuxino-micro.dtb \
 	sun7i-a20-olinuxino-micro-emmc.dtb \
+	sun7i-a20-drejo-ds167.dtb \
+	sun7i-a20-drejo-ds167-emmc.dtb \
 	sun7i-a20-orangepi.dtb \
 	sun7i-a20-orangepi-mini.dtb \
 	sun7i-a20-pcduino3.dtb \
diff --git a/arch/arm/boot/dts/sun7i-a20-drejo-ds167-emmc.dts b/arch/arm/boot/dts/sun7i-a20-drejo-ds167-emmc.dts
new file mode 100644
index 000000000..b6147eb01
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
index 000000000..1103a6082
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-drejo-ds167.dts
@@ -0,0 +1,361 @@
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
+        backlight: backlight {
+                compatible = "pwm-backlight";
+
+                brightness-levels = <0 1 2 4 8 16 32 64 128 255>;
+                default-brightness-level = <9>;
+        };
+
+        panel {
+                compatible = "drejo,ds167-10inch-panel", "panel-lvds";
+                backlight = <&backlight>;
+
+                width-mm = <220>;
+                height-mm = <132>;
+                data-mapping = "vesa-24";
+
+                panel-timing {
+                        /* 1280x800 @60Hz */
+                        clock-frequency = <69000000>;
+                        hactive = <1280>;
+                        vactive = <800>;
+                        hsync-len = <1>; /* hs */
+                        hfront-porch = <118>; /* ri */
+                        hback-porch = <19>; /* le */
+                        vfront-porch = <6>; /* lo */
+                        vback-porch = <9>; /* up */
+                        vsync-len = <1>; /* vs */
+                };
+
+                port {
+                        panel_input: endpoint {
+                                remote-endpoint = <&tcon0_out_lcd>;
+                        };
+                };
+        };
+	
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
+			gpios = <&pio 8 9 GPIO_ACTIVE_LOW>;  /* PI9 STATUS LED NEAR A20 */
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
+&mali {
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
+&i2c1 {
+	status = "okay";
+};
+
+
+&i2c2 {
+	status = "okay";
+
+   	clock-frequency = <400000>;
+        polytouch: edt-ft5x06@38 {
+              compatible = "edt,edt-ft5406", "edt,edt-ft5x06";
+              reg = <0x38>;
+	      interrupt-parent = <&pio>;
+	      interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>; /* PH21 */
+	      wake-gpios = <&pio 1 13 GPIO_ACTIVE_HIGH>; /* PB13 */
+              touchscreen-size-x = <1200>;
+              touchscreen-size-y = <800>;
+       };
+};
+
+&i2c3 {
+	status = "okay";
+};
+
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
+&tcon0 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&lcd_lvds0_pins>;
+};
+
+&tcon0_out {
+        tcon0_out_lcd: endpoint {
+                remote-endpoint = <&panel_input>;
+        };
+};
+
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

