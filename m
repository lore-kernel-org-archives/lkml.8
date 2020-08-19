Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7EBC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471CA206DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgHSL05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 07:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgHSL0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:26:42 -0400
Received: from mxout012.mail.hostpoint.ch (mxout012.mail.hostpoint.ch [IPv6:2a00:d70:0:e::312])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F30C061757;
        Wed, 19 Aug 2020 04:26:42 -0700 (PDT)
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1k8MEa-000Pg6-IN; Wed, 19 Aug 2020 13:26:24 +0200
Received: from [2a02:168:6182:1:2c96:ee1d:6a9a:1f33] (helo=ryzen2700.dss.husqvarnagroup.com)
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1k8MEa-000HJu-FM; Wed, 19 Aug 2020 13:26:24 +0200
X-Authenticated-Sender-Id: reto-schneider@reto-schneider.ch
From:   Reto Schneider <code@reto-schneider.ch>
To:     linux-arm-kernel@lists.infradead.org, alexandre.belloni@bootlin.com
Cc:     Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Stefan Roese <sr@denx.de>,
        Michael Zimmermann <michael.zimmermann@grandcentrix.net>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ARM: at91: Add GARDENA smart Gateway (Art. 19000) board
Date:   Wed, 19 Aug 2020 13:25:47 +0200
Message-Id: <20200819112550.16494-1-code@reto-schneider.ch>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200810171921.8679-1-code@reto-schneider.ch>
References: <20200810171921.8679-1-code@reto-schneider.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reto Schneider <reto.schneider@husqvarnagroup.com>

This patch adds support for the GARDENA smart Gateway, which is based on
the Atmel AT91SAM9G25. It is equipped with 128 MiB of DDR2 RAM and
256 MiB NAND storage.

Please note that this gateway is not actually based on a AT91SAM9x5 EK
board, but is close enough to allow its DT to be used.

Co-developed-by: Stefan Roese <sr@denx.de>
Signed-off-by: Stefan Roese <sr@denx.de>
Co-developed-by: Michael Zimmermann <michael.zimmermann@grandcentrix.net>
Signed-off-by: Michael Zimmermann <michael.zimmermann@grandcentrix.net>
Signed-off-by: Reto Schneider <reto.schneider@husqvarnagroup.com>
---
 .../devicetree/bindings/arm/atmel-at91.yaml   |   2 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/at91sam9g25-gardena-smart-gateway.dts | 157 ++++++++++++++++++
 3 files changed, 160 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 31b0c54fa2cf..b8da32f5d0a7 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -41,6 +41,8 @@ properties:
               - overkiz,kizboxmini-mb   # Overkiz kizbox Mini Mother Board
               - overkiz,kizboxmini-rd   # Overkiz kizbox Mini RailDIN
               - overkiz,smartkiz        # Overkiz SmartKiz Board
+              - gardena,smart-gateway-at91sam" # GARDENA smart Gateway (Article
+                                               # No. 19000)
           - const: atmel,at91sam9g25
           - const: atmel,at91sam9x5
           - const: atmel,at91sam9
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e6a1cac0bfc7..6368dac016dd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -44,6 +44,7 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
 	at91-wb45n.dtb \
 	at91sam9g15ek.dtb \
 	at91sam9g25ek.dtb \
+	at91sam9g25-gardena-smart-gateway.dtb \
 	at91sam9g35ek.dtb \
 	at91sam9x25ek.dtb \
 	at91sam9x35ek.dtb
diff --git a/arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts b/arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts
new file mode 100644
index 000000000000..6dc6e14b5f58
--- /dev/null
+++ b/arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Device Tree file for the GARDENA smart Gateway (Article No. 19000)
+ *
+ *  Copyright (C) 2020 GARDENA GmbH
+ */
+
+/dts-v1/;
+
+#include "at91sam9g25.dtsi"
+#include "at91sam9x5ek.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "GARDENA smart Gateway (Article No. 19000)";
+	compatible = "gardena,smart-gateway-at91sam", "atmel,at91sam9g25", "atmel,at91sam9x5", "atmel,at91sam9";
+
+	aliases {
+		serial1 = &usart3;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		user_btn1 {
+			label = "USER_BTN1";
+			gpios = <&pioA 24 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_PROG1>;
+		};
+	};
+
+	1wire_cm {
+		status = "disabled";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		power_blue {
+			label = "smartgw:power:blue";
+			gpios = <&pioC 21 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		power_green {
+			label = "smartgw:power:green";
+			gpios = <&pioC 20 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		power_red {
+			label = "smartgw:power:red";
+			gpios = <&pioC 19 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		radio_blue {
+			label = "smartgw:radio:blue";
+			gpios = <&pioC 18 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		radio_green {
+			label = "smartgw:radio:green";
+			gpios = <&pioC 17 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		radio_red {
+			label = "smartgw:radio:red";
+			gpios = <&pioC 16 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		internet_blue {
+			label = "smartgw:internet:blue";
+			gpios = <&pioC 15 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		internet_green {
+			label = "smartgw:internet:green";
+			gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		internet_red {
+			label = "smartgw:internet:red";
+			gpios = <&pioC 13 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		heartbeat {
+			label = "smartgw:heartbeat";
+			gpios = <&pioB 8 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		pb18 {
+			status = "disabled";
+		};
+
+		pd21 {
+			status = "disabled";
+		};
+	};
+};
+
+&macb0 {
+	phy-mode = "rmii";
+	status = "okay";
+};
+
+&usart0 {
+	status = "disabled";
+};
+
+&usart2 {
+	status = "disabled";
+};
+
+&usart3 {
+	status = "okay";
+
+	pinctrl-0 = <&pinctrl_usart3
+		     &pinctrl_usart3_rts
+		     &pinctrl_usart3_cts
+		    >;
+};
+
+&watchdog {
+	status = "okay";
+};
+
+&mmc0 {
+	status = "disabled";
+};
+
+&mmc1 {
+	status = "disabled";
+};
+
+&spi0 {
+	status = "disabled";
+};
+
+&i2c0 {
+	status = "disabled";
+};
+
+&adc0 {
+	status = "disabled";
+};
+
+&ssc0 {
+	status = "disabled";
+};
-- 
2.27.0

