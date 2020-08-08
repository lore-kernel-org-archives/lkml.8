Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2374FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 16:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6802072D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 16:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWKTZDBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgHHQGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 12:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgHHQGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 12:06:30 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C91C061756;
        Sat,  8 Aug 2020 09:06:30 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l4so5123935ejd.13;
        Sat, 08 Aug 2020 09:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aorpoSjkhxy2nLAA3S8Z8aMD4wB8R9xzJVPZcOHI3xM=;
        b=tWKTZDBweU0B4ICBc1yHMDNP4LFHlZ+7RQCkiT+LYxny34aXQFj4D4xbbo5m6fjsdV
         EuTHpOkIOn3iRmK4f3EVVr3v5Q1sJ1j4oQsZ/KQRTMu/BQDYogP+VWZB2dtgABE+6VBE
         55vF16OpmbBsSg3Ka2wFfNBEKWKq4vx6K7w6rn+hmQjEwoLW8C0pcSIVxa/xq5Ncijs3
         3DlZpiKVlrS33VUNvGLiwZA+FTU6n5rCaCjzEd573nJ6OVF4XFKH/VUaD9cR/gV2+sLU
         ia8Q+P4HXYWnT8AZEY8LbqZAcaXfLKwwOKaUsoxpyCHWqxRw2EKOuKrjd9TqETJVaq3P
         dp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aorpoSjkhxy2nLAA3S8Z8aMD4wB8R9xzJVPZcOHI3xM=;
        b=izkwYOREracefxfyT/nejgA5FdrOchWTk21QV6eY2+Ozt0fawlu29vX+28qoCs5+Qa
         hoqaJQpZ1N4fnnInctmmQOyZQw8ALmL9SZ52A0DZvhEKC8RqexFSf8pwnetD7QtXBKq9
         /5cRP6vzCEqj7tArtTJyw1SMnwmy1MCJQIrrMH7NqjASqUucYn+N3wybdSQ0Jc9Df2Jq
         zxmN5HwcpKazh6xNc+48qNkTLkyR4YBRRVKYZMnXztxOi+9bTxH152Bixr+/dneEgLF7
         u8wWB5XoJe7evb3U2Qi7jOnhV74NnGSeCkVnDdS72YZ6evsn3CZOT3hg5p9unbXcWqtP
         TbdQ==
X-Gm-Message-State: AOAM530MiHYpn5+10z70r0fzniliDTGbo3joUfh0c8yWPy7C6FPmGClq
        a+IDC/mC/8NfxtR9R44S+Z8=
X-Google-Smtp-Source: ABdhPJwJPKR7jMUG42mppi6lrsTf4kDbSg5mv9i1l9SxzxgadN6ZwK7HXnsuZsMmR4ocP+0NDKg2+w==
X-Received: by 2002:a17:906:38da:: with SMTP id r26mr14117154ejd.120.1596902789166;
        Sat, 08 Aug 2020 09:06:29 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k24sm8404338ejz.102.2020.08.08.09.06.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Aug 2020 09:06:28 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: rockchip: add rk3318 A95X Z2 board
Date:   Sat,  8 Aug 2020 18:06:18 +0200
Message-Id: <20200808160618.15445-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200808160618.15445-1-jbx6244@gmail.com>
References: <20200808160618.15445-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3318 A95X Z2 boards are sold as TV box.
No further documentation is given, but from the dts files
extracted it seems that the rk3318 processor is simulair
to the rk3328. This dts file contains only the basic nodes
that have support in the mainline kernel.

Features:

CPU: RK3318 Quad-Core Cortex-A53
GPU: Mali-450
RAM: 2/4GB DDR3
ROM: EMMC 16/32/64GB
HDMI: HDMI 2.0a for 4k@60Hz
Ethernet: 10/100M standard RJ-45
WiFi: 2.4G+5G WIFI, 802.11 b/g/n
Bluetooth: 4.0
1 x USB 3.0
1 x USB 2.0
1 x Micro SD card slot
1 x SPDIF
1 x AV
1 x DC IN

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile           |   1 +
 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts | 374 ++++++++++++++++++++++++
 2 files changed, 375 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index b87b1f773..aa508bc4a 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -2,6 +2,7 @@
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-roc-cc.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3318-a95x-z2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-a1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
new file mode 100644
index 000000000..30c73ef25
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
@@ -0,0 +1,374 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include "rk3328.dtsi"
+
+/ {
+	model = "A95X Z2";
+	compatible = "zkmagic,a95x-z2", "rockchip,rk3318";
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+		poll-interval = <100>;
+
+		recovery {
+			label = "recovery";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <17000>;
+		};
+	};
+
+	ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&ir_int>;
+		pinctrl-names = "default";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&cyx_led_pin>;
+		pinctrl-names = "default";
+
+		cyx_led: led-0 {
+			default-state = "on";
+			gpios = <&gpio2 RK_PC7 GPIO_ACTIVE_LOW>;
+			label = "CYX_LED";
+		};
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-0 = <&wifi_enable_h>;
+		pinctrl-names = "default";
+		reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
+	};
+
+	spdif-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "SPDIF";
+
+		simple-audio-card,cpu {
+			sound-dai = <&spdif>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&spdif_out>;
+		};
+	};
+
+	spdif_out: spdif-out {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+	};
+
+	/* Power tree */
+	vccio_1v8: vccio-1v8-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vccio_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	vccio_3v3: vccio-3v3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vccio_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	vcc_otg_vbus: otg-vbus-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&otg_vbus_drv>;
+		pinctrl-names = "default";
+		regulator-name = "vcc_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+	};
+
+	vcc_sd: sdmmc-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&sdmmc0m1_pin>;
+		pinctrl-names = "default";
+		regulator-name = "vcc_sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vccio_3v3>;
+	};
+
+	vdd_arm: vdd-arm {
+		compatible = "pwm-regulator";
+		pwms = <&pwm0 0 5000 1>;
+		regulator-name = "vdd_arm";
+		regulator-min-microvolt = <950000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-settling-time-up-us = <250>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_log: vdd-log {
+		compatible = "pwm-regulator";
+		pwms = <&pwm1 0 5000 1>;
+		regulator-name = "vdd_log";
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-settling-time-up-us = <250>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&analog_sound {
+	status = "okay";
+};
+
+&codec {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu0_opp_table {
+	opp-1200000000 {
+		status = "disabled";
+	};
+
+	opp-1296000000 {
+		status = "disabled";
+	};
+};
+
+&emmc {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	non-removable;
+	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&gmac2phy {
+	assigned-clock-parents = <&cru SCLK_MAC2PHY_SRC>;
+	assigned-clock-rate = <50000000>;
+	assigned-clocks = <&cru SCLK_MAC2PHY>;
+	clock_in_out = "output";
+	status = "okay";
+};
+
+&gpu {
+	mali-supply = <&vdd_log>;
+};
+
+&hdmi {
+	ddc-i2c-scl-high-time-ns = <9625>;
+	ddc-i2c-scl-low-time-ns = <10000>;
+	status = "okay";
+};
+
+&hdmiphy {
+	status = "okay";
+};
+
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2s0 {
+	status = "okay";
+};
+
+&i2s1 {
+	status = "okay";
+};
+
+&io_domains {
+	pmuio-supply = <&vccio_3v3>;
+	vccio1-supply = <&vccio_3v3>;
+	vccio2-supply = <&vccio_1v8>;
+	vccio3-supply = <&vccio_3v3>;
+	vccio4-supply = <&vccio_1v8>;
+	vccio5-supply = <&vccio_3v3>;
+	vccio6-supply = <&vccio_3v3>;
+	status = "okay";
+};
+
+&pinctrl {
+	ir {
+		ir_int: ir-int {
+			rockchip,pins = <2 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	leds {
+		cyx_led_pin: cyx-led-pin {
+			rockchip,pins = <2 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pwm0 {
+		pwm0_pin_pull_up: pwm0-pin-pull-up {
+			rockchip,pins = <2 RK_PA4 1 &pcfg_pull_up>;
+		};
+	};
+
+	pwm1 {
+		pwm1_pin_pull_up: pwm1-pin-pull-up {
+			rockchip,pins = <2 RK_PA5 1 &pcfg_pull_up>;
+		};
+	};
+
+	sdio-pwrseq {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	sdmmc1 {
+		clk_32k_out: clk-32k-out {
+			rockchip,pins = <1 RK_PD4 1 &pcfg_pull_none>;
+		};
+	};
+
+	usb {
+		host_vbus_drv: host-vbus-drv {
+			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		otg_vbus_drv: otg-vbus-drv {
+			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pwm0 {
+	pinctrl-0 = <&pwm0_pin_pull_up>;
+	pinctrl-names = "active";
+	status = "okay";
+};
+
+&pwm1 {
+	pinctrl-0 = <&pwm1_pin_pull_up>;
+	pinctrl-names = "active";
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&vccio_1v8>;
+	status = "okay";
+};
+
+&sdio {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	keep-power-in-suspend;
+	max-frequency = <125000000>;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	pinctrl-0 = <&sdmmc1_bus4 &sdmmc1_cmd &sdmmc1_clk &clk_32k_out>;
+	pinctrl-names = "default";
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	pinctrl-0 = <&sdmmc0_clk &sdmmc0_cmd &sdmmc0_dectn &sdmmc0_bus4>;
+	pinctrl-names = "default";
+	vmmc-supply = <&vcc_sd>;
+	status = "okay";
+};
+
+&spdif {
+	pinctrl-0 = <&spdifm0_tx>;
+	status = "okay";
+};
+
+&soc_crit {
+	temperature = <115000>; /* millicelsius */
+};
+
+&target {
+	temperature = <105000>; /* millicelsius */
+};
+
+&threshold {
+	temperature = <90000>; /* millicelsius */
+};
+
+&tsadc {
+	rockchip,hw-tshut-temp = <120000>;
+	status = "okay";
+};
+
+&u2phy {
+	status = "okay";
+};
+
+&u2phy_host {
+	status = "okay";
+};
+
+&u2phy_otg {
+	phy-supply = <&vcc_otg_vbus>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0_xfer &uart0_cts>;
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usb20_otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&vop {
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
-- 
2.11.0

