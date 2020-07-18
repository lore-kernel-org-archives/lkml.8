Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33318C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 05:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10A252076A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 05:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2MHOb96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgGRFBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 01:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgGRFBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 01:01:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68101C0619D2;
        Fri, 17 Jul 2020 22:01:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z13so13117554wrw.5;
        Fri, 17 Jul 2020 22:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pdW+Mjjnec0fSYPYQpDNjTJP81EjQ4GG3syPqnLR7Sc=;
        b=T2MHOb96zwRInfSLZlWUZTvE51GWOTjRoEfY/e1F9wRGBHS7xuq7BpVecTZUTEUF1W
         n/zz0kXeHWfy5gWgr6M45vy3Bd8cWRXlj9YUMZVSAUNDjp1tO1wE3yEEJVR8WTAyTX/o
         t8jKPqv0RoK1WJow8GD155dFpuO+hbSH7rjJvhHTAq0mqfm00ZEEFPHtaUk73oDZcZ1m
         QBigDfwRfa9diYYtY3k6bz9p5hwvOGbxjl/uQs5YoSxb50ktVsQDgOa5LtldlXPx84RM
         qdsFTenMH212uwVF4PaJJmKp5aAZt/9UKAltbrdc7V9ypwy06/UavuAfp9wi2FCThowM
         DZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pdW+Mjjnec0fSYPYQpDNjTJP81EjQ4GG3syPqnLR7Sc=;
        b=Uwk0vhiJ0bf2YxkpEx3EL1mlE8m3HKUG9WbkQpTCQBGuVVMJ7ncCtREoit7cOx0O4r
         3dppFPRbZ0iMwJcFYG8g5iVJI4nuDQvTNTEfacLyPtYnAlbwyDwpxatWMdP77bazH0wX
         E2TdleUv7zJ/IG2mMgjtEAIATUVO87eOqiRul33RcK9MeJiWw0rGXuEM/reF8kW9ma05
         xiqFrSaFItcp11SDW13ARcK27hJp0JnUhtrpXxOxnoDzzw6zmmxhTi5X+Fazz2az3ZFu
         OEH1+/SKq9DqbgBiAUrz5rBApCJc5MKV4aJ1nsXRyP7eRDkA8K5swXi3HLubJVJqVxL0
         CXNQ==
X-Gm-Message-State: AOAM5332eEuKNffQy2WCv2ysMCSuonptdWBHOCv1D7qh9bmh/Tlg/dD7
        avd0FeDzuNLSwa3UfPaN2No=
X-Google-Smtp-Source: ABdhPJxHRWHgh67kxq9xkuW198zVtS8jYB21lXDt27XPbgKgq2mt1y4z1UjeejNofF1NYKxGFZ/d9w==
X-Received: by 2002:a5d:4b45:: with SMTP id w5mr12527495wrs.4.1595048462119;
        Fri, 17 Jul 2020 22:01:02 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 68sm18179815wmz.40.2020.07.17.22.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 22:01:01 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 2/2] arm64: dts: meson: add support for the WeTek Core 2
Date:   Sat, 18 Jul 2020 05:00:56 +0000
Message-Id: <20200718050056.1713-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200718050056.1713-1-christianshewitt@gmail.com>
References: <20200718050056.1713-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WeTek Core2 is a commercial device based on the Amlogic Q200 reference
design but with the following differences:

- 3GB RAM, 32GB eMMC
- Blue and Red LEDs used to signal on/off status
- uart_AO can be accessed after opening the case; soldering required
- USB OTG is not accessible (inside the case)
- Realtek RTL8152 Ethernet (internal USB connection)

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../dts/amlogic/meson-gxm-wetek-core2.dts     | 90 +++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 5cac4d1d487d..4e2239ffcaa5 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -41,6 +41,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q201.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-rbox-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-libretech-pc.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-vega-s96.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxm-wetek-core2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-c4.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dts
new file mode 100644
index 000000000000..44fc5ea38dc0
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dts
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-gxm.dtsi"
+#include "meson-gx-p23x-q20x.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible = "wetek,core2", "amlogic,s912", "amlogic,meson-gxm";
+	model = "WeTek Core 2";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>; /* 2 GiB or 3 GiB */
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		blue {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio GPIODV_24 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1710000>;
+
+		button-update {
+			label = "update";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <10000>;
+		};
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <100>;
+
+		button-power {
+			label = "power";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+/* This is disabled as Realtek RTL8152 USB provides Ethernet */
+&ethmac {
+	status = "disabled";
+	phy-mode = "rmii";
+	phy-handle = <&internal_phy>;
+};
+
+&internal_phy {
+	pinctrl-0 = <&eth_link_led_pins>, <&eth_act_led_pins>;
+	pinctrl-names = "default";
+};
+
+&ir {
+	linux,rc-map-name = "rc-wetek-play2";
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
+		compatible = "brcm,bcm43438-bt";
+		enable-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
+		clocks = <&wifi32k>;
+		clock-names = "lpo";
+	};
+};
-- 
2.17.1

