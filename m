Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20734C8300C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0CCF214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJXFpw15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgD3Jna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726453AbgD3Jn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:43:29 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB639C035494;
        Thu, 30 Apr 2020 02:43:29 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d3so2506906pgj.6;
        Thu, 30 Apr 2020 02:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dEmSKhNrz+xLqMEEc+aybE6UoVCXvC7isyJ9mYoLpu8=;
        b=dJXFpw15yFFHc7J7j2nuHoGE6sOC2fcJOHSNwv9W5tL817cZ+sK0b022FyQKDBjCce
         iUxUGPZQt7kgnlGBx7/mOvF7EC/qyPl8GwtxXbcB9QjIY2kUgyz/Hz8KBXetbr94i0UE
         W7IyuXpEBlNZFEQjqSjeAnKon04QLYl2X4WmIQNYxv3iNeEnzf92/RxtpGiwsYZwXFOQ
         979J5kmQEoj4/zVRxexlj2OsPL7T4MBQy4ooL/Q80roIQfKrVH3Vh4H2DTGLdc7H7D0C
         ObLvKH4ZrKWspqbyP+sU53WuLzGMw8O8p88Mi6W71i8mCFPCegDNztCnL1pWfA14Z2Vd
         aP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dEmSKhNrz+xLqMEEc+aybE6UoVCXvC7isyJ9mYoLpu8=;
        b=cIDCLY5WaM94GhzHn30o3Pt717em/cKXQoav4tVtjKldDYZBsjf7TNgswmCzkLf5jV
         6wi2coWswPCSuPhQUWyC+OYrM42oDscN0C5CR0SAGsvU3PHgvVai/yypsAP3RA6jy+aE
         bmJ/oqq4PQRIwPNPeMLFgi29UteBYsIjED1Y46LB8RmbnUUC7E+/paZXiJUCm7fpGhAc
         1mdxNqZ9p0ICiLMOXDQHMnFv78OOnP+8qFpejFMaGKGR4r7Wj1McioKdhM5v/1grNuuX
         W5IRuvDsHsyQG54FvcGXW8pmYGlQxZNI2GdsIGWuRxGJpfRAOndlcRt0QPEtdT4wYf/0
         sbew==
X-Gm-Message-State: AGi0PuYW9yd8vpqdiTBE3pE36AEcGGhEKl9r8R5yO7HhzZXMifyhJQmI
        /OgB+lPEcjVZfotr4IQanX8=
X-Google-Smtp-Source: APiQypJXCnBiLUebLi6863cY1x03UAwbjjNtYuzJU86ZeOK4PHVujDuU5yJHQ4KTs53jFshUNf4Wsg==
X-Received: by 2002:a63:b649:: with SMTP id v9mr2200218pgt.402.1588239809178;
        Thu, 30 Apr 2020 02:43:29 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.101.138])
        by smtp.gmail.com with ESMTPSA id p10sm3024966pff.210.2020.04.30.02.43.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2020 02:43:28 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     alexandre.torgue@st.com
Cc:     sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcoquelin.stm32@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, thierry.reding@gmail.com,
        dillon.minfei@gmail.com
Subject: [PATCH 1/4] add dts node for drm panel driver ili9341 add dts i2c3 for stmpe touch add dts spi5 for gyro & ili9341
Date:   Thu, 30 Apr 2020 17:43:22 +0800
Message-Id: <1588239802-11442-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 .../bindings/display/panel/ilitek,ili9341.txt      | 42 +++++++++++
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi             | 79 +++++++++++++++++++
 arch/arm/boot/dts/stm32f429-disco.dts              | 88 ++++++++++++++++++++++
 arch/arm/boot/dts/stm32f429.dtsi                   | 12 +++
 4 files changed, 221 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.txt

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.txt b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.txt
new file mode 100644
index 0000000..f5a4e55
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.txt
@@ -0,0 +1,42 @@
+Ilitek ILI9341 TFT panel driver with SPI control bus
+
+This is a driver for 240x320 TFT panels, accepting a rgb input
+streams that get adapted and scaled to the panel.
+
+Required properties:
+  - compatible: "stm32f429-disco,ltdc-panel", "ilitek,ili9341"
+    (full system-specific compatible is always required to look up configuration)
+  - reg: address of the panel on the SPI bus
+
+Optional properties:
+  - reset-gpios: a GPIO spec for the reset pin, see gpio/gpio.txt
+  - dc-gpios: a GPIO spec for the dc pin, see gpio/gpio.txt
+
+  The following optional properties only apply to RGB input mode:
+
+  - pixelclk-active: see display/panel/display-timing.txt
+  - de-active: see display/panel/display-timing.txt
+  - hsync-active: see display/panel/display-timing.txt
+  - vsync-active: see display/panel/display-timing.txt
+
+The panel must obey the rules for a SPI slave device as specified in
+spi/spi-bus.txt
+
+The device node can contain one 'port' child node with one child
+'endpoint' node, according to the bindings defined in
+media/video-interfaces.txt. This node should describe panel's video bus.
+
+Example:
+
+panel: display@0 {
+	compatible = "stm32f429-disco,ltdc-panel", "ilitek,ili9341";
+	reg = <0>;
+	spi-3wire;
+	spi-max-frequency = <10000000>;
+	dc-gpios = <&gpiod 13 0>;
+	port {
+		panel_in: endpoint {
+			remote-endpoint = <&display_out>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
index 392fa14..45b68f4 100644
--- a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
@@ -316,6 +316,85 @@
 				};
 			};
 
+			ltdc_pins_f429_disco: ltdc-1 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 6,  AF14)>,
+						/* LCD_HSYNC */
+						 <STM32_PINMUX('A', 4,  AF14)>,
+						 /* LCD_VSYNC */
+						 <STM32_PINMUX('G', 7,  AF14)>,
+						 /* LCD_CLK */
+						 <STM32_PINMUX('C', 10, AF14)>,
+						 /* LCD_R2 */
+						 <STM32_PINMUX('B', 0,  AF9)>,
+						 /* LCD_R3 */
+						 <STM32_PINMUX('A', 11, AF14)>,
+						 /* LCD_R4 */
+						 <STM32_PINMUX('A', 12, AF14)>,
+						 /* LCD_R5 */
+						 <STM32_PINMUX('B', 1,  AF9)>,
+						 /* LCD_R6*/
+						 <STM32_PINMUX('G', 6,  AF14)>,
+						 /* LCD_R7 */
+						 <STM32_PINMUX('A', 6,  AF14)>,
+						 /* LCD_G2 */
+						 <STM32_PINMUX('G', 10, AF9)>,
+						 /* LCD_G3 */
+						 <STM32_PINMUX('B', 10, AF14)>,
+						 /* LCD_G4 */
+						 <STM32_PINMUX('D', 6,  AF14)>,
+						 /* LCD_B2 */
+						 <STM32_PINMUX('G', 11, AF14)>,
+						 /* LCD_B3*/
+						 <STM32_PINMUX('B', 11, AF14)>,
+						 /* LCD_G5 */
+						 <STM32_PINMUX('C', 7,  AF14)>,
+						 /* LCD_G6 */
+						 <STM32_PINMUX('D', 3,  AF14)>,
+						 /* LCD_G7 */
+						 <STM32_PINMUX('G', 12, AF9)>,
+						 /* LCD_B4 */
+						 <STM32_PINMUX('A', 3,  AF14)>,
+						 /* LCD_B5 */
+						 <STM32_PINMUX('B', 8,  AF14)>,
+						 /* LCD_B6 */
+						 <STM32_PINMUX('B', 9,  AF14)>,
+						 /* LCD_B7 */
+						 <STM32_PINMUX('F', 10, AF14)>;
+						 /* LCD_DE */
+					slew-rate = <2>;
+				};
+			};
+
+			i2c3_pins: i2c3-0 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 9, AF4)>,
+						/* I2C3_SDA */
+						 <STM32_PINMUX('A', 8, AF4)>;
+						/* I2C3_SCL */
+					bias-disable;
+					drive-open-drain;
+					slew-rate = <3>;
+				};
+			};
+
+			spi5_pins: spi5-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('F', 7, AF5)>,
+						/* SPI5_CLK */
+						 <STM32_PINMUX('F', 9, AF5)>;
+						/* SPI5_MOSI */
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('F', 8, AF5)>;
+						/* SPI5_MISO */
+					bias-disable;
+				};
+			};
+
 			dcmi_pins: dcmi-0 {
 				pins {
 					pinmux = <STM32_PINMUX('A', 4, AF13)>, /* DCMI_HSYNC */
diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 30c0f67..55eed05 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -49,6 +49,8 @@
 #include "stm32f429.dtsi"
 #include "stm32f429-pinctrl.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "STMicroelectronics STM32F429i-DISCO board";
@@ -98,6 +100,14 @@
 		regulator-name = "vcc5_host1";
 		regulator-always-on;
 	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 };
 
 &clk_hse {
@@ -127,3 +137,81 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&ltdc {
+	status = "okay";
+	pinctrl-0 = <&ltdc_pins_f429_disco>;
+	pinctrl-names = "default";
+
+	port {
+		ltdc_out_rgb: endpoint {
+			remote-endpoint = <&panel_in_rgb>;
+		};
+	};
+};
+
+&spi5 {
+	status = "okay";
+	pinctrl-0 = <&spi5_pins>;
+	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cs-gpios = <&gpioc 1 GPIO_ACTIVE_LOW>,<&gpioc 2 GPIO_ACTIVE_LOW>;
+	dmas = <&dma2 3 2 0x400 0x0>,
+	       <&dma2 4 2 0x400 0x0>;
+	dma-names = "rx", "tx";
+	l3gd20: l3gd20@0 {
+		compatible = "st,l3gd20-gyro";
+		spi-max-frequency = <10000000>;
+		st,drdy-int-pin = <2>;
+		interrupt-parent = <&gpioa>;
+		interrupts = <1 IRQ_TYPE_EDGE_RISING>,
+				<2 IRQ_TYPE_EDGE_RISING>;
+		reg = <0>;
+		vddio = <&reg_3p3v>;
+		vdd = <&reg_3p3v>;
+		status = "okay";
+	};
+	display: display@1{
+		/* Connect panel-ilitek-9341 to ltdc */
+		compatible = "stm32f429-disco,ltdc-panel", "ilitek,ili9341";
+		reg = <1>;
+		spi-3wire;
+		spi-max-frequency = <10000000>;
+		dc-gpios = <&gpiod 13 0>;
+		port {
+			panel_in_rgb: endpoint {
+			remote-endpoint = <&ltdc_out_rgb>;
+			};
+		};
+	};
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+	status = "okay";
+
+	touch: stmpe811@41 {
+		compatible = "st,stmpe811";
+		reg = <0x41>;
+		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&gpioa>;
+		vio = <&reg_3p3v>;
+		vcc = <&reg_3p3v>;
+		status = "okay";
+
+		stmpe_touchscreen {
+			compatible = "st,stmpe-ts";
+			st,sample-time = <4>;
+			st,mod-12b = <1>;
+			st,ref-sel = <0>;
+			st,adc-freq = <1>;
+			st,ave-ctrl = <1>;
+			st,touch-det-delay = <2>;
+			st,settling = <2>;
+			st,fraction-z = <7>;
+			st,i-drive = <1>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index d777069..257b843 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -402,6 +402,18 @@
 			status = "disabled";
 		};
 
+		i2c3: i2c@40005c00 {
+			compatible = "st,stm32f4-i2c";
+			reg = <0x40005c00 0x400>;
+			interrupts = <72>,
+				     <73>;
+			resets = <&rcc STM32F4_APB1_RESET(I2C3)>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(I2C3)>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		dac: dac@40007400 {
 			compatible = "st,stm32f4-dac-core";
 			reg = <0x40007400 0x400>;
-- 
2.7.4

