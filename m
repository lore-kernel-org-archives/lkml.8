Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB42C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 221DB2065E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgGXHVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:21:51 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:50783 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726543AbgGXHVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:21:50 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07519391|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.664333-0.000360464-0.335307;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03268;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.I6q5URR_1595575301;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.I6q5URR_1595575301)
          by smtp.aliyun-inc.com(10.147.41.178);
          Fri, 24 Jul 2020 15:21:45 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tiny.windzz@gmail.com, huangshuosheng@allwinnertech.com,
        liyong@allwinnertech.com, Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH v5 16/16] arm64: allwinner: A100: add support for Allwinner Perf1 board
Date:   Fri, 24 Jul 2020 15:21:05 +0800
Message-Id: <30f4a3fc6ac84d05094e2c3b89d1dddc8ff6b7fc.1595572867.git.frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1595572867.git.frank@allwinnertech.com>
References: <cover.1595572867.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

A100 perf1 is an Allwinner A100-based SBC, with the following features:

- 1GiB DDR3 DRAM
- AXP803 PMIC
- 2 USB 2.0 ports
- MicroSD slot and on-board eMMC module
- on-board Nand flash
- ···

Adds initial support for it, including UART and PMU.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../allwinner/sun50i-a100-allwinner-perf1.dts | 180 ++++++++++++++++++
 2 files changed, 181 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index e4d3cd0ac5bb..ab780dbdd17b 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -14,6 +14,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinephone-1.1.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinetab.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a100-allwinner-perf1.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-bananapi-m2-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-bananapi-m2-plus-v1.2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-emlid-neutis-n5-devboard.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
new file mode 100644
index 000000000000..d34c2bb1079f
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (c) 2020 Yangtao Li <frank@allwinnertech.com>
+ */
+
+/dts-v1/;
+
+#include "sun50i-a100.dtsi"
+
+/{
+	model = "Allwinner A100 Perf1";
+	compatible = "allwinner,a100-perf1", "allwinner,sun50i-a100";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&pio {
+	vcc-pb-supply = <&reg_dcdc1>;
+	vcc-pc-supply = <&reg_eldo1>;
+	vcc-pd-supply = <&reg_dcdc1>;
+	vcc-pe-supply = <&reg_dldo2>;
+	vcc-pf-supply = <&reg_dcdc1>;
+	vcc-pg-supply = <&reg_dldo1>;
+	vcc-ph-supply = <&reg_dcdc1>;
+};
+
+&r_pio {
+	/*
+	 * FIXME: We can't add that supply for now since it would
+	 * create a circular dependency between pinctrl, the regulator
+	 * and the RSB Bus.
+	 *
+	 * vcc-pl-supply = <&reg_aldo3>;
+	 */
+};
+
+&r_i2c0 {
+	status = "okay";
+
+	axp803: pmic@34 {
+		compatible = "x-powers,axp803";
+		reg = <0x34>;
+		interrupt-parent = <&r_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		x-powers,drive-vbus-en; /* set N_VBUSEN as output pin */
+	};
+};
+
+#include "axp803.dtsi"
+
+&ac_power_supply {
+	status = "okay";
+};
+
+&reg_aldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vcc-pll-avcc";
+};
+
+&reg_aldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vcc-dram-1";
+};
+
+&reg_aldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-usb-pl";
+};
+
+&reg_dcdc1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-io-usb-pd-emmc-nand-card";
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	/*
+	 * FIXME: update min and max before support dvfs.
+	 */
+	regulator-min-microvolt = <500000>;
+	regulator-max-microvolt = <1300000>;
+	regulator-name = "vdd-cpux";
+};
+
+/* DCDC3 is polyphased with DCDC2 */
+
+&reg_dcdc4 {
+	regulator-always-on;
+	regulator-min-microvolt = <950000>;
+	regulator-max-microvolt = <950000>;
+	regulator-name = "vdd-sys-usb-dram";
+};
+
+&reg_dcdc5 {
+	regulator-always-on;
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1500000>;
+	regulator-name = "vcc-dram-2";
+};
+
+&reg_dldo1 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-pg-dcxo-wifi";
+};
+
+&reg_dldo2 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "vcc-pe-csi";
+};
+
+&reg_dldo3 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "ldo-avdd-csi";
+};
+
+&reg_dldo4 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "avcc-csi";
+};
+
+&reg_eldo1 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vcc-pc-lvds-csi-efuse-emmc-nand";
+};
+
+&reg_eldo2 {
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "dvdd-csi";
+};
+
+&reg_eldo3 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vcc-mipi-lcd";
+};
+
+&reg_fldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <900000>;
+	regulator-name = "vdd-cpus-usb";
+};
+
+&reg_ldo_io0 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-ctp";
+	status = "okay";
+};
+
+&reg_drivevbus {
+	regulator-name = "usb0-vbus";
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
-- 
2.24.0

