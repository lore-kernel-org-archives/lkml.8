Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F5EC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76DEE2073A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBpcEW5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgEFG1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725882AbgEFG1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:27:12 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38EAC061A0F;
        Tue,  5 May 2020 23:27:11 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y25so502624pfn.5;
        Tue, 05 May 2020 23:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=r7GDOB4KUTMAbqLQjSRn2Yp8VhPGDy0fV6+iumq7awY=;
        b=jBpcEW5lr69j9so5i/oJ4oaQlk3dKCoXXc4idlY97rLzzTIBuu6I2lueaxazBcscmw
         uU5TBTArJH2JBLJUjne0pDUBnrOHBiVV4ybEaXaTvsuYwDK+KfX1z/H1KBnud0jM9qWG
         q7IUENdQXz2f8ADzBXN3nJq/dHGNAJwwYb5X6zJUe9KRj7NwtUn0Cq42W26PcHRpQzxp
         LWMIZO0BNiCsHKNW8qzocWLdkF04vvq7YqHCwG4rB5EbKZ1hRBCeSU1r7B03B2FTUXg3
         EtpO2mKOlZ2kj2//fxGhcw1tK6qd0vTMckQmLA7gzuN5Cw+VdKDDRm/K893UqpOvbNn0
         baWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r7GDOB4KUTMAbqLQjSRn2Yp8VhPGDy0fV6+iumq7awY=;
        b=UwVwCkcbWd5bYY5SZe5JV6EzJNJHzj1ZeT/eTGtl0In45EqBPEiQ/5HCiU9NNhp0Uk
         s3gR8c7grqZzGYp6sw6q/mGIniJJL+s4lUlAOTeCkMNdnXbbWrWhJUJhqUcBpjdVn3oE
         AW6Nrfjx7n0EdoNQSBH0rgY68Fve7w71/me3sjTnr0VTsuVS/T2ezCASZSKJUBtMK1gl
         /0n9p+Q/ATrXBSlgITmx0GC2AZjrKjdP2+ajiVuwBRz0HdUapsycDus1AZs9PRJ/tZea
         MTFovlihAlzxumUxvPbxVdxXoL1ZL9M+Y/cKJ6SeIwcVP/CQRV+vcpvhNhzJWo22NRLH
         1b5Q==
X-Gm-Message-State: AGi0PuYS2D1Ggbeoozw2nJ9MntbAdKKeopT0DR4BA86KQI4Uy34ikpQp
        l1PFf71uNqJWzrox4pfl270=
X-Google-Smtp-Source: APiQypLbjeASMuNkeJLplI8TjiKwaneBMu4BbXtAmciArzDMjGce99NPaKS94y0pdnFzRR5Qi7Z8yQ==
X-Received: by 2002:a63:7214:: with SMTP id n20mr5948835pgc.437.1588746431402;
        Tue, 05 May 2020 23:27:11 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id b140sm752399pfb.119.2020.05.05.23.27.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 23:27:11 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     alexandre.torgue@st.com, robh+dt@kernel.org,
        mcoquelin.stm32@gmail.com, sam@ravnborg.org
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH 1/4] ARM: dts: stm32: Add drm panel ili9341 support for stm32f429-disco board
Date:   Wed,  6 May 2020 14:27:06 +0800
Message-Id: <1588746426-30979-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

1, add stm32f429-disco ltdc pins mux config
2, add ltdc nodes pinned with ili9341
3, add spi5 node

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi | 67 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32f429-disco.dts  | 40 ++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
index 392fa14..0eb107f 100644
--- a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
@@ -316,6 +316,73 @@
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
index 30c0f67..3aadddb 100644
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
@@ -127,3 +129,41 @@
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
+	cs-gpios = <&gpioc 2 GPIO_ACTIVE_LOW>;
+	dmas = <&dma2 3 2 0x400 0x0>,
+	       <&dma2 4 2 0x400 0x0>;
+	dma-names = "rx", "tx";
+	display: display@0{
+		/* Connect panel-ilitek-9341 to ltdc */
+		compatible = "stm32f429-disco,ltdc-panel", "ilitek,ili9341";
+		reg = <0>;
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
-- 
2.7.4

