Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93A0C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 15:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CEE22072D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 15:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgHVPLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 11:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgHVPLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 11:11:17 -0400
Received: from mxout017.mail.hostpoint.ch (mxout017.mail.hostpoint.ch [IPv6:2a00:d70:0:e::317])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C21DC061574;
        Sat, 22 Aug 2020 08:11:16 -0700 (PDT)
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtp (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1k9VAd-000An6-Gt; Sat, 22 Aug 2020 17:11:03 +0200
Received: from [2a02:168:6182:1:880e:adee:9ae9:610] (helo=ryzen2700.dss.husqvarnagroup.com)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1k9VAd-000K4J-AF; Sat, 22 Aug 2020 17:11:03 +0200
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
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/2] ARM: at91: Add GARDENA smart Gateway (Art. 19000) support
Date:   Sat, 22 Aug 2020 17:10:21 +0200
Message-Id: <20200822151023.31629-2-code@reto-schneider.ch>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200822151023.31629-1-code@reto-schneider.ch>
References: <20200810171921.8679-1-code@reto-schneider.ch>
 <20200822151023.31629-1-code@reto-schneider.ch>
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
Changes in v3:
- Fix DT binding schema violation, put it in separate commit
- Fix line length violation
- Sort new dtb entry in Makefile

Changes in v2:
- Remove duplicated DT entries
- Improve model name
- Add device to relevant DT binding schema
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/at91sam9g25-gardena-smart-gateway.dts | 158 ++++++++++++++++++
 2 files changed, 159 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e6a1cac0bfc7..6cd1cfcd5316 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -43,6 +43,7 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
 	at91-smartkiz.dtb \
 	at91-wb45n.dtb \
 	at91sam9g15ek.dtb \
+	at91sam9g25-gardena-smart-gateway.dtb \
 	at91sam9g25ek.dtb \
 	at91sam9g35ek.dtb \
 	at91sam9x25ek.dtb \
diff --git a/arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts b/arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts
new file mode 100644
index 000000000000..7da70aeeb528
--- /dev/null
+++ b/arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts
@@ -0,0 +1,158 @@
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
+	compatible = "gardena,smart-gateway-at91sam", "atmel,at91sam9g25", "atmel,at91sam9x5",
+		"atmel,at91sam9";
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

