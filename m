Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA629C54E49
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB831208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSwcXsCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgEJMlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 08:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728360AbgEJMlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 08:41:44 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711A7C061A0C;
        Sun, 10 May 2020 05:41:44 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id l19so6468710lje.10;
        Sun, 10 May 2020 05:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NAU0BK+VVegmur9qw286jHjw2JuJhlP5IclMrk1t5Fc=;
        b=LSwcXsCXLUbmLEmiAoiY7Sc91AKsxo1qaLqtbW+OyVlysutWwkoKTk9DLVx+3XhQw+
         g1zrwvZ3Uv9NcD6FuZZqutd186rpIJjQzmMiMOSHAkA1jznx5tYQx4bqhtD0cidTFRlM
         YDxqTu7pByJje6EJLTWKVM4n5imLwczIPB38Qzfg8cJybUY6G0ySqle0WIA8pwf+RKNV
         gFPklHCzrtnZT24cyLtbZUxm0wYBWUjht+20HsFdllSC3afFnNHbExLuUV5mC+XyRwvF
         EhSYBZSBl4WF3OX4royuQqZeIzdE3aUOnDzSw8r1oFRR7+FNT5EAkaEoDnihR+PfO/q4
         w7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NAU0BK+VVegmur9qw286jHjw2JuJhlP5IclMrk1t5Fc=;
        b=cgTZC4BfrPJkqkpEMoUPMT+c9axGeW5tmz19Yd2aklDx2yr+EDtRukIUQH9aj6pZ5Y
         faxn5Uh7j/InwucAd0604Ddso+7nOUuEtsnYGFomJEnI8u7/4QtRlV9eHi5BylEbBAiU
         OMmIm+ECdqtOBN5WApAaRh5wwRFL99A8gxa6h2UG+IOtLp8Cu+OuxgQnUVx4TtpNNJPD
         cJUUEvpV+pKgnqVwukzhdJpcq52lAeUim+pJrqQSUTzIDSJWW5SSy+o+vyjorlCAEM73
         VI61asCiKfLWdsPqjqFYnsbcf4gpgbnlvVBqtXpxtt0hFhqXEAE0vr/u0QF5m9qH4JhD
         V0Yg==
X-Gm-Message-State: AOAM530BEMr/mwA82Cd2AXvkiL+WjS8av0geeLm1tzadZAvcml149E8q
        9y4+dlLp56q3Zv5BzQ4XxaoIscBx
X-Google-Smtp-Source: ABdhPJxqYQXvLDdFvpl/hPS6GiSgWb9asphcJPLfMewADBnX1GCD9/pMZuHoMO8sjg2/4kXlE8bNAw==
X-Received: by 2002:a2e:3208:: with SMTP id y8mr7245503ljy.282.1589114502953;
        Sun, 10 May 2020 05:41:42 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m11sm7136611lfo.55.2020.05.10.05.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 05:41:42 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v8 3/3] arm64: dts: meson: add support for the Smartlabs SML-5442TW
Date:   Sun, 10 May 2020 12:41:29 +0000
Message-Id: <20200510124129.31575-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200510124129.31575-1-christianshewitt@gmail.com>
References: <20200510124129.31575-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Smartlabs SML-5442TW is based on the Amlogic P231 reference design
but with the following differences:

- The Yellow and Blue LEDs are available but disabled
- The Red and Green LEDs are used to signal off/on status
- uart_AO can be accessed after opening the case; soldered pins exist
- QCA9377 instead of the usual Ampak/Broadcom module

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../dts/amlogic/meson-gxl-s905d-sml5442tw.dts | 80 +++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index eef0045320f2..6cf8c4ac0390 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -27,6 +27,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-phicomm-n1.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-sml5442tw.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s805x-p241.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-p281.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-tx3-mini.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts
new file mode 100644
index 000000000000..0b95e9ecbef0
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-gxl-s905d.dtsi"
+#include "meson-gx-p23x-q20x.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible = "smartlabs,sml5442tw", "amlogic,s905d", "amlogic,meson-gxl";
+	model = "SmartLabs SML-5442TW";
+
+	leds {
+		compatible = "gpio-leds";
+
+		yellow {
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio_ao GPIOAO_6 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		blue {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio GPIODV_28 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		green {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		red {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio GPIODV_27 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+};
+
+&ethmac {
+	status = "okay";
+	phy-mode = "rmii";
+	phy-handle = <&internal_phy>;
+};
+
+&i2c_A {
+	status = "okay";
+	pinctrl-0 = <&i2c_a_pins>;
+	pinctrl-names = "default";
+};
+
+&internal_phy {
+	pinctrl-0 = <&eth_link_led_pins>, <&eth_act_led_pins>;
+	pinctrl-names = "default";
+};
+
+/* This is connected to the Bluetooth module: */
+&uart_A {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+
+	bluetooth {
+		compatible = "qcom,qca9377-bt";
+		enable-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
+		clocks = <&wifi32k>;
+		clock-names = "lpo";
+	};
+};
-- 
2.17.1

