Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF21C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B529122CA0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pXogweQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgHETyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgHEQsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:48:39 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B03C061A30;
        Wed,  5 Aug 2020 04:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description;
        bh=UjISJhBEPgrV0Fxw74kEJZInCuGudJbxaVpku3rSs64=; b=pXogweQim/21UamZUyeuREzcDg
        Ryuy2ZqH0byn3Cf7kw26BGOxXIB60kf50wue30Wy7ek7GMLKxjsKp7HKdomie+rMUWOKmAAcQNJy8
        2FrtIkssxdQa/jpiA0R9c+JeLFKRSbN/BhFnUnslKSobDa2e3EVNCsGoxmzWpYfRAUC2l0itmd+/b
        IjQssTLLTxwRcQOjP96Ly3Q6ztYv3zqeK5KkPnjC234vPs8XmJEfOCiookrLjEwLAuUTS2KTzqAJa
        H2yx9pvu50wrFJCGKcMdITp9jaVpfKRv0dp6SIE3Jsk6ysKWY1sNKWcVxnE12is2S5/HZ++qjN6F+
        x+80eIEw==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3Hcc-0002bG-Ps; Wed, 05 Aug 2020 11:30:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat Linux))
        id 1k3Hcb-00Bavc-Oo; Wed, 05 Aug 2020 12:30:13 +0100
From:   David Woodhouse <dwmw2@infradead.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        chunhui dai <chunhui.dai@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        CK Hu <ck.hu@mediatek.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] arm: dts: mt7623: add support for UniElec U7623 eMMC
Date:   Wed,  5 Aug 2020 12:30:13 +0100
Message-Id: <20200805113013.2763510-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200805113013.2763510-1-dwmw2@infradead.org>
References: <8ef96e4d02ef82e171409945ee6cc0348c4fe594.camel@infradead.org>
 <20200805113013.2763510-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by merlin.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

Based on a patch in OpenWrt from Kristian Evensen <kristian.evensen@gmail.com>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/mt7623a-unielec-u7623-emmc.dts   | 347 ++++++++++++++++++
 2 files changed, 348 insertions(+)
 create mode 100644 arch/arm/boot/dts/mt7623a-unielec-u7623-emmc.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4572db3fa5ae..52f3954b600c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1347,6 +1347,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt6580-evbp1.dtb \
 	mt6589-aquaris5.dtb \
 	mt6592-evb.dtb \
+	mt7623a-unielec-u7623-emmc.dtb \
 	mt7623a-rfb-emmc.dtb \
 	mt7623a-rfb-nand.dtb \
 	mt7623n-rfb-emmc.dtb \
diff --git a/arch/arm/boot/dts/mt7623a-unielec-u7623-emmc.dts b/arch/arm/boot/dts/mt7623a-unielec-u7623-emmc.dts
new file mode 100644
index 000000000000..6205a32159ce
--- /dev/null
+++ b/arch/arm/boot/dts/mt7623a-unielec-u7623-emmc.dts
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright © 2018 Kristian Evensen <kristian.evensen@gmail.com>
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include "mt7623a.dtsi"
+#include "mt6323.dtsi"
+
+/ {
+	model = "UniElec U7623 eMMC";
+	compatible = "unielec,u7623-emmc", "mediatek,mt7623";
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0 0x80000000 0 0x20000000>;
+	};
+
+	aliases {
+		serial2 = &uart2;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	cpus {
+		cpu@0 {
+			proc-supply = <&mt6323_vproc_reg>;
+		};
+
+		cpu@1 {
+			proc-supply = <&mt6323_vproc_reg>;
+		};
+
+		cpu@2 {
+			proc-supply = <&mt6323_vproc_reg>;
+		};
+
+		cpu@3 {
+			proc-supply = <&mt6323_vproc_reg>;
+		};
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&key_pins_a>;
+
+		factory {
+			label = "factory";
+			linux,code = <KEY_RESTART>;
+			gpios = <&pio 256 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_unielec>;
+
+		led3 {
+			label = "u7623-01:green:led3";
+			gpios = <&pio 14 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led4 {
+			label = "u7623-01:green:led4";
+			gpios = <&pio 15 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+	};
+};
+
+&crypto {
+	status = "okay";
+};
+
+&eth {
+	status = "okay";
+
+	gmac0: mac@0 {
+		compatible = "mediatek,eth-mac";
+		reg = <0>;
+		phy-mode = "trgmii";
+
+		fixed-link {
+			speed = <1000>;
+			full-duplex;
+			pause;
+		};
+	};
+
+	mdio: mdio-bus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mt7530: switch@0 {
+			compatible = "mediatek,mt7530";
+		};
+	};
+};
+
+&mt7530 {
+	compatible = "mediatek,mt7530";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0>;
+	pinctrl-names = "default";
+	mediatek,mcm;
+	resets = <&ethsys 2>;
+	reset-names = "mcm";
+	core-supply = <&mt6323_vpa_reg>;
+	io-supply = <&mt6323_vemc3v3_reg>;
+
+	dsa,mii-bus = <&mdio>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0>;
+
+		port@0 {
+			reg = <0>;
+			label = "lan0";
+			cpu = <&cpu_port0>;
+		};
+
+		port@1 {
+			reg = <1>;
+			label = "lan1";
+			cpu = <&cpu_port0>;
+		};
+
+		port@2 {
+			reg = <2>;
+			label = "lan2";
+			cpu = <&cpu_port0>;
+		};
+
+		port@3 {
+			reg = <3>;
+			label = "lan3";
+			cpu = <&cpu_port0>;
+		};
+
+		port@4 {
+			reg = <4>;
+			label = "wan";
+			cpu = <&cpu_port0>;
+		};
+
+		cpu_port0: port@6 {
+			reg = <6>;
+			label = "cpu";
+			ethernet = <&gmac0>;
+			phy-mode = "trgmii";
+
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+	};
+};
+
+&mmc0 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	status = "okay";
+	bus-width = <8>;
+	max-frequency = <50000000>;
+	cap-mmc-highspeed;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	non-removable;
+};
+
+&pio {
+	key_pins_a: keys-alt {
+		pins-keys {
+			pinmux = <MT7623_PIN_256_GPIO256_FUNC_GPIO256>,
+				 <MT7623_PIN_257_GPIO257_FUNC_GPIO257>;
+			input-enable;
+		};
+	};
+
+	led_pins_unielec: leds-unielec {
+		pins-leds {
+			pinmux = <MT7623_PIN_14_GPIO14_FUNC_GPIO14>,
+				 <MT7623_PIN_15_GPIO15_FUNC_GPIO15>;
+		};
+	};
+
+	mmc0_pins_default: mmc0default {
+		pins_cmd_dat {
+			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_MSDC0_DAT7>,
+				 <MT7623_PIN_112_MSDC0_DAT6_FUNC_MSDC0_DAT6>,
+				 <MT7623_PIN_113_MSDC0_DAT5_FUNC_MSDC0_DAT5>,
+				 <MT7623_PIN_114_MSDC0_DAT4_FUNC_MSDC0_DAT4>,
+				 <MT7623_PIN_118_MSDC0_DAT3_FUNC_MSDC0_DAT3>,
+				 <MT7623_PIN_119_MSDC0_DAT2_FUNC_MSDC0_DAT2>,
+				 <MT7623_PIN_120_MSDC0_DAT1_FUNC_MSDC0_DAT1>,
+				 <MT7623_PIN_121_MSDC0_DAT0_FUNC_MSDC0_DAT0>,
+				 <MT7623_PIN_116_MSDC0_CMD_FUNC_MSDC0_CMD>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins_clk {
+			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_MSDC0_CLK>;
+			bias-pull-down;
+		};
+
+		pins_rst {
+			pinmux = <MT7623_PIN_115_MSDC0_RSTB_FUNC_MSDC0_RSTB>;
+			bias-pull-up;
+		};
+	};
+
+	mmc0_pins_uhs: mmc0 {
+		pins_cmd_dat {
+			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_MSDC0_DAT7>,
+				 <MT7623_PIN_112_MSDC0_DAT6_FUNC_MSDC0_DAT6>,
+				 <MT7623_PIN_113_MSDC0_DAT5_FUNC_MSDC0_DAT5>,
+				 <MT7623_PIN_114_MSDC0_DAT4_FUNC_MSDC0_DAT4>,
+				 <MT7623_PIN_118_MSDC0_DAT3_FUNC_MSDC0_DAT3>,
+				 <MT7623_PIN_119_MSDC0_DAT2_FUNC_MSDC0_DAT2>,
+				 <MT7623_PIN_120_MSDC0_DAT1_FUNC_MSDC0_DAT1>,
+				 <MT7623_PIN_121_MSDC0_DAT0_FUNC_MSDC0_DAT0>,
+				 <MT7623_PIN_116_MSDC0_CMD_FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_2mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins_clk {
+			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_2mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins_rst {
+			pinmux = <MT7623_PIN_115_MSDC0_RSTB_FUNC_MSDC0_RSTB>;
+			bias-pull-up;
+		};
+	};
+
+	pcie_default: pcie_pin_default {
+		pins_cmd_dat {
+			pinmux = <MT7623_PIN_208_AUD_EXT_CK1_FUNC_PCIE0_PERST_N>,
+				 <MT7623_PIN_209_AUD_EXT_CK2_FUNC_PCIE1_PERST_N>;
+			bias-disable;
+		};
+	};
+};
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_pins_a>;
+	status = "okay";
+};
+
+&pwrap {
+	mt6323 {
+		mt6323led: led {
+			compatible = "mediatek,mt6323-led";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				label = "led0";
+				default-state = "off";
+			};
+		};
+	};
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins_b>;
+	status = "okay";
+};
+
+&usb1 {
+	vusb33-supply = <&reg_3p3v>;
+	vbus-supply = <&reg_3p3v>;
+	status = "okay";
+};
+
+&u3phy1 {
+	status = "okay";
+};
+
+&u3phy2 {
+	status = "okay";
+	mediatek,phy-switch = <&hifsys>;
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_default>;
+	status = "okay";
+
+	pcie@1,0 {
+		status = "okay";
+	};
+
+	pcie@2,0 {
+		status = "okay";
+	};
+};
+
+&pcie1_phy {
+	status = "okay";
+};
-- 
2.26.2

