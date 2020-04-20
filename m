Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97924C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71C8120782
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587403926;
	bh=uWNiGByJKk3ntpqr+nIyoYe+iYdSnhAXy65p/6Bw8qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F/zzWayGghx+31Bd9JXMrkHHyqceCEzt6isNZL08aGWhBCTk5t5kxnLR8ncwhIMzn
	 jQkSaJwriRA3Zjl6cd8yWMxdM3iQrfaj8nf6/D/zebMb96bR+lqkK/LpM0UR/PPPZi
	 tkZ3uVBSLa1tmicqcqU2TD6zHQsexN8245sjBlmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgDTRcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:32:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgDTRcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:32:05 -0400
Received: from localhost.localdomain (unknown [157.46.94.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F4CA20782;
        Mon, 20 Apr 2020 17:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587403923;
        bh=uWNiGByJKk3ntpqr+nIyoYe+iYdSnhAXy65p/6Bw8qU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ID2hruZeMX1+o+yilcqgC4EGOyhyvgx9NrTCBcGCeUAkCXzQQQtnVabGaq0D6PMxc
         ryjr8u9a4mWfwJ/NLtOyCL1BeCJISmIqo4yiOlbYnWYz4Zpo4xI7iUe5EJfl7G6HhP
         5VSbWVpQJ8a+m/C9tDZZ362Yyx6iad13JAwqw5OM=
From:   mani@kernel.org
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 4/6] ARM: dts: stm32mp1: Add Stinger96 board support
Date:   Mon, 20 Apr 2020 23:01:22 +0530
Message-Id: <20200420173124.27416-5-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420173124.27416-1-mani@kernel.org>
References: <20200420173124.27416-1-mani@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

Stinger96 is a 96Boards IoT Extended edition board designed and
manufactured by Shiratech solutions based on STM32MP1 SoC. Following
are the features of this board:

* 256MB DDR
* 125MB NAND Flash
* Onboard BG96 modem
* 1x uSD
* 2x USB (1 available as external connector and another connected to BG96)
* 1x SPI
* 1x PCM
* 2x UART (apart from serial console)
* 2x I2C (apart from one connected to PMIC)

Following peripherals are tested and known to work:

* BG96 modem
* 1x I2C (LS-I2C0)
* 1x SPI
* 1x UART (LS-UART0)
* USB (Only Gadget mode)
* uSD

More information about this board can be found in Shiratech website:
https://www.shiratech-solutions.com/products/stinger96/

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 arch/arm/boot/dts/Makefile                   |   1 +
 arch/arm/boot/dts/stm32mp157a-stinger96.dts  |  12 +
 arch/arm/boot/dts/stm32mp157a-stinger96.dtsi | 342 +++++++++++++++++++
 3 files changed, 355 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp157a-stinger96.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157a-stinger96.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f43467b02bcd..966b81dfffd6 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1030,6 +1030,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
 	stm32h743i-disco.dtb \
 	stm32mp157a-avenger96.dtb \
 	stm32mp157a-dk1.dtb \
+	stm32mp157a-stinger96.dtb \
 	stm32mp157c-dhcom-pdk2.dtb \
 	stm32mp157c-dk2.dtb \
 	stm32mp157c-ed1.dtb \
diff --git a/arch/arm/boot/dts/stm32mp157a-stinger96.dts b/arch/arm/boot/dts/stm32mp157a-stinger96.dts
new file mode 100644
index 000000000000..249a53877512
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp157a-stinger96.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2020 Manivannan Sadhasivam
+ */
+
+/dts-v1/;
+#include "stm32mp157a-stinger96.dtsi"
+
+/ {
+	model = "Shiratech STM32MP157A Stinger96 board";
+	compatible = "shiratech,stm32mp157a-stinger96", "st,stm32mp157";
+};
diff --git a/arch/arm/boot/dts/stm32mp157a-stinger96.dtsi b/arch/arm/boot/dts/stm32mp157a-stinger96.dtsi
new file mode 100644
index 000000000000..58275bcf9e26
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp157a-stinger96.dtsi
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2020 Manivannan Sadhasivam
+ */
+
+/dts-v1/;
+
+#include "stm32mp157.dtsi"
+#include "stm32mp15-pinctrl.dtsi"
+#include "stm32mp15xxac-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/mfd/st,stpmic1.h>
+
+/ {
+	aliases {
+		mmc0 = &sdmmc1;
+		serial0 = &uart4;
+		serial1 = &uart7;
+		serial2 = &usart2;
+		spi0 = &spi4;
+	};
+
+	chosen {
+		stdout-path = "serial1:115200n8";
+	};
+
+	memory@c0000000 {
+		device_type = "memory";
+		reg = <0xc0000000 0x10000000>;
+	};
+
+	led {
+		compatible = "gpio-leds";
+
+		led1 {
+			label = "green:user1";
+			gpios = <&gpioa 13 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+		};
+
+		led2 {
+			label = "green:user2";
+			gpios = <&gpioh 3 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc0";
+			default-state = "off";
+		};
+
+		led3 {
+			label = "green:user3";
+			gpios = <&gpioh 2 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc1";
+			default-state = "off";
+		};
+
+		led4 {
+			label = "green:user4";
+			gpios = <&gpiof 12 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "none";
+			default-state = "off";
+			panic-indicator;
+		};
+	};
+
+	sd_switch: regulator-sd_switch {
+		compatible = "regulator-gpio";
+		regulator-name = "sd_switch";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2900000>;
+		regulator-type = "voltage";
+		regulator-always-on;
+
+		gpios = <&gpioa 8 GPIO_ACTIVE_HIGH>;
+		gpios-states = <0>;
+		states = <1800000 0x1>,
+			 <2900000 0x0>;
+	};
+};
+
+/* Only headless mode is supported */
+&gpu {
+	status = "disabled";
+};
+
+/* LS-I2C0 */
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	i2c-scl-rising-time-ns = <1000>;
+	i2c-scl-falling-time-ns = <300>;
+	status = "okay";
+	/delete-property/dmas;
+	/delete-property/dma-names;
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins_a>;
+	i2c-scl-rising-time-ns = <185>;
+	i2c-scl-falling-time-ns = <20>;
+	status = "okay";
+	/delete-property/dmas;
+	/delete-property/dma-names;
+
+	pmic: stpmic@33 {
+		compatible = "st,stpmic1";
+		reg = <0x33>;
+		interrupts-extended = <&gpioa 0 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		status = "okay";
+
+		regulators {
+			compatible = "st,stpmic1-regulators";
+
+			ldo1-supply = <&v3v3>;
+			ldo2-supply = <&v3v3>;
+			ldo3-supply = <&vdd_ddr>;
+			ldo5-supply = <&v3v3>;
+			ldo6-supply = <&v3v3>;
+			pwr_sw1-supply = <&bst_out>;
+			pwr_sw2-supply = <&bst_out>;
+
+			vddcore: buck1 {
+				regulator-name = "vddcore";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-always-on;
+				regulator-initial-mode = <0>;
+				regulator-over-current-protection;
+			};
+
+			vdd_ddr: buck2 {
+				regulator-name = "vdd_ddr";
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-initial-mode = <0>;
+				regulator-over-current-protection;
+			};
+
+			vdd: buck3 {
+				regulator-name = "vdd";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				st,mask-reset;
+				regulator-initial-mode = <0>;
+				regulator-over-current-protection;
+			};
+
+			v3v3: buck4 {
+				regulator-name = "v3v3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-over-current-protection;
+				regulator-initial-mode = <0>;
+			};
+
+			vdda: ldo1 {
+				regulator-name = "vdda";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				interrupts = <IT_CURLIM_LDO1 0>;
+			};
+
+			v2v9: ldo2 {
+				regulator-name = "v2v9";
+				regulator-min-microvolt = <2900000>;
+				regulator-max-microvolt = <2900000>;
+				regulator-always-on;
+				interrupts = <IT_CURLIM_LDO2 0>;
+			};
+
+			vtt_ddr: ldo3 {
+				regulator-name = "vtt_ddr";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <750000>;
+				regulator-always-on;
+				regulator-over-current-protection;
+			};
+
+			vdd_usb: ldo4 {
+				regulator-name = "vdd_usb";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				interrupts = <IT_CURLIM_LDO4 0>;
+			};
+
+			vdd_sd: ldo5 {
+				regulator-name = "vdd_sd";
+				regulator-min-microvolt = <2900000>;
+				regulator-max-microvolt = <2900000>;
+				interrupts = <IT_CURLIM_LDO5 0>;
+				regulator-boot-on;
+			};
+
+			v1v8: ldo6 {
+				regulator-name = "v1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				interrupts = <IT_CURLIM_LDO6 0>;
+			};
+
+			vref_ddr: vref_ddr {
+				regulator-name = "vref_ddr";
+				regulator-always-on;
+				regulator-over-current-protection;
+			};
+
+			bst_out: boost {
+				regulator-name = "bst_out";
+				interrupts = <IT_OCP_BOOST 0>;
+			};
+
+			vbus_otg: pwr_sw1 {
+				regulator-name = "vbus_otg";
+				interrupts = <IT_OCP_OTG 0>;
+				regulator-active-discharge;
+			};
+
+			vbus_sw: pwr_sw2 {
+				regulator-name = "vbus_sw";
+				interrupts = <IT_OCP_SWOUT 0>;
+				regulator-active-discharge;
+			};
+		};
+
+		onkey {
+			compatible = "st,stpmic1-onkey";
+			interrupts = <IT_PONKEY_F 0>, <IT_PONKEY_R 1>;
+			interrupt-names = "onkey-falling", "onkey-rising";
+			status = "okay";
+		};
+
+		watchdog {
+			compatible = "st,stpmic1-wdt";
+			status = "disabled";
+		};
+	};
+};
+
+&iwdg2 {
+	timeout-sec = <32>;
+	status = "okay";
+};
+
+&pwr_regulators {
+	vdd-supply = <&vdd>;
+	vdd_3v3_usbfs-supply = <&vdd_usb>;
+};
+
+&rng1 {
+	status = "okay";
+};
+
+&rtc {
+	status = "okay";
+};
+
+&sdmmc1 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc1_b4_pins_a &sdmmc1_dir_pins_b>;
+	pinctrl-1 = <&sdmmc1_b4_od_pins_a &sdmmc1_dir_pins_b>;
+	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a &sdmmc1_dir_sleep_pins_b>;
+	broken-cd;
+	disable-wp;
+	st,sig-dir;
+	st,neg-edge;
+	st,use-ckin;
+	bus-width = <4>;
+	vmmc-supply = <&vdd_sd>;
+	vqmmc-supply = <&sd_switch>;
+	status = "okay";
+};
+
+/* LS-SPI0 */
+&spi4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi4_pins_a>;
+	cs-gpios = <&gpioe 11 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+/* BG96 */
+&usart2 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&usart2_pins_b>;
+	pinctrl-1 = <&usart2_sleep_pins_b>;
+	st,hw-flow-ctrl;
+	status = "okay";
+};
+
+/* LS-UART0 */
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart4_pins_c>;
+	st,hw-flow-ctrl;
+	status = "okay";
+};
+
+/* Debug console */
+&uart7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart7_pins_b>;
+	status = "okay";
+};
+
+&usbh_ehci {
+	phys = <&usbphyc_port0>;
+	phy-names = "usb";
+	status = "okay";
+};
+
+&usbotg_hs {
+	dr_mode = "peripheral";
+	pinctrl-0 = <&usbotg_hs_pins_a>;
+	pinctrl-names = "default";
+	phy-names = "usb2-phy";
+	phys = <&usbphyc_port1 0>;
+	vbus-supply = <&vbus_otg>;
+	status = "okay";
+};
+
+&usbphyc {
+	status = "okay";
+};
+
+&usbphyc_port0 {
+	phy-supply = <&vdd_usb>;
+	vdda1v1-supply = <&reg11>;
+	vdda1v8-supply = <&reg18>;
+};
+
+&usbphyc_port1 {
+	phy-supply = <&vdd_usb>;
+	vdda1v1-supply = <&reg11>;
+	vdda1v8-supply = <&reg18>;
+};
-- 
2.17.1

