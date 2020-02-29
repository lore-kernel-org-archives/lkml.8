Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C765C3F2D3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 17:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63178222C4
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 17:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dnI56PQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgB2RER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 12:04:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35141 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbgB2RER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 12:04:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id r7so7206981wro.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 09:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LjnPFAuYRx1+e9Nusu+GLt62/h8wv1vBF+D3fWY8HaY=;
        b=dnI56PQbf3ak5OriYGgZjFWVU9FHoAWf6obRSPHL6mp0DlrvKtft7qmVQW+coi0PCW
         t40GyfgyQOKWUVUewc1ZeWk3qqc06L7Wa8qbS18q42BSOGTzGxHwIeibWD0qQIhqwq1B
         tT+UOqA6P8k398WsQzLrY6IPZT+hR9qHx4taAylliaQl4ZvUdlZXs7awiAqjjVyZ9b0j
         X7mS4G1USzmTQqDDlbAtLMv1cI7xSxExnBmagwb9UWZB9nnUwZjbHrG1xJbnXkzdyy9m
         NhE3EJSNbyFlPvX/P5BgnuCQdTF8jmA4BXGjc0T7z+YBLh5cnn2b9+KWs4z0zHLFUOFh
         /U9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LjnPFAuYRx1+e9Nusu+GLt62/h8wv1vBF+D3fWY8HaY=;
        b=IoppkH1bFDnrU335X2RxVnfkpijkmjuOhsauebr19Iye1GFgB7/MsItHJSZ6xCRHfY
         XRSlwIp586ZhTbgUDMTZHUYACchgShyibSHIGn2WyaQrO7x0EBdoTiSEBA3VGTooREUo
         yFndI33gQxtTMbtMMtLpfTdFbvmykBQafiMUYU+FAxmrShZ9TcQI6RIsi5QxfgUiUoT7
         Q+C5h7hmLS+KFl2a5/0/knHsa9Z6jQY8zLS/o7j2+f7X493A+cY6KOcfzW2gw9tBuBSI
         +2Xlc/Npdb09jrfyKz/w+qN1bQapLY+ufAU+33d6KiinxrnkrvpTpye2sy6Oxj3H9qX5
         2G3g==
X-Gm-Message-State: APjAAAUM0glehR72Z0YQNh53kHZrmH1OtngfMNptlg+UpzHUUxjq+vYw
        thu5TgY0a+S2ZhdSwucd0rfagw==
X-Google-Smtp-Source: APXvYqx12uM+Pz8xkprft5U521IRBIh4vG5dGTbiwnDmbiUL0IQ8HifC7xzmHOfqf8uaKpfL8t+5qw==
X-Received: by 2002:a5d:638b:: with SMTP id p11mr11597986wru.338.1582995853137;
        Sat, 29 Feb 2020 09:04:13 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ecba:5540:6f5c:582a:cc84:32f5])
        by smtp.gmail.com with ESMTPSA id 18sm7178304wmf.1.2020.02.29.09.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 09:04:12 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v3 2/2] arm64: dts: mediatek: add pumpkin board dts
Date:   Sat, 29 Feb 2020 18:04:01 +0100
Message-Id: <20200229170401.1287324-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200229170401.1287324-1-fparent@baylibre.com>
References: <20200229170401.1287324-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pumpkin board is  made by Gossamer Engineering and is using
a MediaTek SoC. The board currently comes in two available version:
MT8516 SoC and MT8167 SoC.
The board provides the following IOs: eMMC, NAND, SD card, USB type-A,
Ethernet, Wi-Fi, Bluetooth, Audio (jack out, 2 PDM port, 1 analog in),
serial over USB, and an expansion header.

Additionally there is a HDMI port, DSI port, and camera port only
on the MT8167 version of the board.

The board can be powered by battery and/or via a USB Type-C port and
is using a PMIC MT6392.

The eMMC and NAND are sharing pins and cannot be used together.

This commit is adding the basic boot support for the Pumpkin MT8516
board on the eMMC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

V3:
	* Fix warnings from dtbs_check and checkpatch.pl
	* Add FW optee nodes
	* Add usb0 and usb0_phy nodes

V2:
	* Remove dependency on PMIC MT6392 to make it easier to merge the DTS
	until the PMIC code is merged.
	* Rename a bunch of label to make them more straighforward
	* Use names for keycode instead of magic values
	* Add chosen for serial port

---
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../boot/dts/mediatek/mt8516-pumpkin.dts      |  20 ++
 .../boot/dts/mediatek/pumpkin-common.dtsi     | 221 ++++++++++++++++++
 3 files changed, 242 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 458bbc422a94..2f8967cb8717 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -8,3 +8,4 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
new file mode 100644
index 000000000000..cce642c53812
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Fabien Parent <fparent@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include "mt8516.dtsi"
+#include "pumpkin-common.dtsi"
+
+/ {
+	model = "Pumpkin MT8516";
+	compatible = "mediatek,mt8516";
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x40000000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
new file mode 100644
index 000000000000..a31093d7142b
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Fabien Parent <fparent@baylibre.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:921600n8";
+	};
+
+	firmware {
+		optee: optee@4fd00000 {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		input-name = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys_default>;
+
+		volume-up {
+			gpios = <&pio 42 GPIO_ACTIVE_LOW>;
+			label = "volume_up";
+			linux,code = <115>;
+			wakeup-source;
+			debounce-interval = <15>;
+		};
+
+		volume-down {
+			gpios = <&pio 43 GPIO_ACTIVE_LOW>;
+			label = "volume_down";
+			linux,code = <114>;
+			wakeup-source;
+			debounce-interval = <15>;
+		};
+	};
+};
+
+&i2c0 {
+	clock-div = <2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+
+	tca6416: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		rst-gpio = <&pio 65 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tca6416_pins>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		eint20_mux_sel0 {
+			gpio-hog;
+			gpios = <0 0>;
+			input;
+			line-name = "eint20_mux_sel0";
+		};
+
+		expcon_mux_sel1 {
+			gpio-hog;
+			gpios = <1 0>;
+			input;
+			line-name = "expcon_mux_sel1";
+		};
+
+		mrg_di_mux_sel2 {
+			gpio-hog;
+			gpios = <2 0>;
+			input;
+			line-name = "mrg_di_mux_sel2";
+		};
+
+		sd_sdio_mux_sel3 {
+			gpio-hog;
+			gpios = <3 0>;
+			input;
+			line-name = "sd_sdio_mux_sel3";
+		};
+
+		sd_sdio_mux_ctrl7 {
+			gpio-hog;
+			gpios = <7 0>;
+			output-low;
+			line-name = "sd_sdio_mux_ctrl7";
+		};
+
+		hw_id0 {
+			gpio-hog;
+			gpios = <8 0>;
+			input;
+			line-name = "hw_id0";
+		};
+
+		hw_id1 {
+			gpio-hog;
+			gpios = <9 0>;
+			input;
+			line-name = "hw_id1";
+		};
+
+		hw_id2 {
+			gpio-hog;
+			gpios = <10 0>;
+			input;
+			line-name = "hw_id2";
+		};
+
+		fg_int_n {
+			gpio-hog;
+			gpios = <11 0>;
+			input;
+			line-name = "fg_int_n";
+		};
+
+		usba_pwr_en {
+			gpio-hog;
+			gpios = <12 0>;
+			output-high;
+			line-name = "usba_pwr_en";
+		};
+
+		wifi_3v3_pg {
+			gpio-hog;
+			gpios = <13 0>;
+			input;
+			line-name = "wifi_3v3_pg";
+		};
+
+		cam_rst {
+			gpio-hog;
+			gpios = <14 0>;
+			output-low;
+			line-name = "cam_rst";
+		};
+
+		cam_pwdn {
+			gpio-hog;
+			gpios = <15 0>;
+			output-low;
+			line-name = "cam_pwdn";
+		};
+	};
+};
+
+&i2c2 {
+	clock-div = <2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "peripheral";
+
+	usb_con: connector {
+		compatible = "usb-c-connector";
+		label = "USB-C";
+	};
+};
+
+&usb0_phy {
+	status = "okay";
+};
+
+&pio {
+	gpio_keys_default: gpiodefault {
+		pins_cmd_dat {
+			pinmux = <MT8516_PIN_42_KPCOL0__FUNC_GPIO42>,
+				 <MT8516_PIN_43_KPCOL1__FUNC_GPIO43>;
+			bias-pull-up;
+			input-enable;
+		};
+	};
+
+	i2c0_pins_a: i2c0@0 {
+		pins1 {
+			pinmux = <MT8516_PIN_58_SDA0__FUNC_SDA0_0>,
+				 <MT8516_PIN_59_SCL0__FUNC_SCL0_0>;
+			bias-disable;
+		};
+	};
+
+	i2c2_pins_a: i2c2@0 {
+		pins1 {
+			pinmux = <MT8516_PIN_60_SDA2__FUNC_SDA2_0>,
+				 <MT8516_PIN_61_SCL2__FUNC_SCL2_0>;
+			bias-disable;
+		};
+	};
+
+	tca6416_pins: pinmux_tca6416_pins {
+		gpio_mux_rst_n_pin {
+			pinmux = <MT8516_PIN_65_UTXD1__FUNC_GPIO65>;
+			output-high;
+		};
+
+		gpio_mux_int_n_pin {
+			pinmux = <MT8516_PIN_64_URXD1__FUNC_GPIO64>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
+};
-- 
2.25.0

