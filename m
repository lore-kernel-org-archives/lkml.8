Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165E8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0370120885
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgHJRvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 13:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgHJRvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 13:51:10 -0400
X-Greylist: delayed 1763 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Aug 2020 10:51:09 PDT
Received: from mxout012.mail.hostpoint.ch (mxout012.mail.hostpoint.ch [IPv6:2a00:d70:0:e::312])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD2AC061756;
        Mon, 10 Aug 2020 10:51:09 -0700 (PDT)
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1k5BUJ-0008Az-SP; Mon, 10 Aug 2020 19:21:31 +0200
Received: from [2a02:168:6182:1:b8b7:9388:88c1:b332] (helo=ryzen2700.dss.husqvarnagroup.com)
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1k5BUJ-000DaV-PN; Mon, 10 Aug 2020 19:21:31 +0200
X-Authenticated-Sender-Id: reto-schneider@reto-schneider.ch
From:   Reto Schneider <code@reto-schneider.ch>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Stefan Roese <sr@denx.de>,
        Michael Zimmermann <michael.zimmermann@grandcentrix.net>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: at91: Add GARDENA smart Gateway AT91SAM board
Date:   Mon, 10 Aug 2020 19:19:19 +0200
Message-Id: <20200810171921.8679-1-code@reto-schneider.ch>
X-Mailer: git-send-email 2.27.0
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
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/at91sam9g25-gardena-smart-gateway.dts | 186 ++++++++++++++++++
 2 files changed, 187 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4572db3fa5ae..d38d256f59fa 100644
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
index 000000000000..19b0f67a7af6
--- /dev/null
+++ b/arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Device Tree file for the GARDENA smart Gateway (AT91SAM)
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
+	model = "GARDENA smart Gateway (AT91SAM)";
+	compatible = "gardena,smart-gateway-at91sam", "atmel,at91sam9g25", "atmel,at91sam9x5", "atmel,at91sam9";
+
+	aliases {
+		serial1 = &usart3;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		reg = <0x20000000 0x8000000>;
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
+&dbgu {
+	status = "okay";
+};
+
+&macb0 {
+	phy-mode = "rmii";
+	status = "okay";
+};
+
+&nand_controller {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	num-ports = <3>;
+};
+
+&usb1 {
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
+&dbgu {
+	status = "okay";
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

