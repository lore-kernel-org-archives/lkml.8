Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EDEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2AD62071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgHZQ1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:27:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:5867 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbgHZQ1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:27:31 -0400
IronPort-SDR: AW+jIvmWP5utOI8MQaYg/oSSjuXnxXnRd3HmEuXAniHE7kWsIKt2Cek4UoazwUUHZZsG3pl0Re
 TOllZgmlXMOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="174377629"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="174377629"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 09:27:29 -0700
IronPort-SDR: 7bjxR9Jgktn3/wOYcQ1l9OjNDDMP5i8+iUjMGtm4MeE/VOtbpvazw/HE7lG3FrCannBjIGUQbk
 h+i8asYOSZgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="312938559"
Received: from marshy.an.intel.com ([10.122.105.159])
  by orsmga002.jf.intel.com with ESMTP; 26 Aug 2020 09:27:26 -0700
From:   richard.gong@linux.intel.com
To:     catalin.marinas@arm.com, will@kernel.org, dinguyen@kernel.org,
        robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCH] arm64: dts: diamonmesa: add device tree for Intel Diamond Mesa
Date:   Wed, 26 Aug 2020 11:46:50 -0500
Message-Id: <1598460410-21880-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add the device tree files for Intel Diamond Mesa SoC

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 arch/arm64/Kconfig.platforms                       |   5 +
 arch/arm64/boot/dts/intel/Makefile                 |   1 +
 arch/arm64/boot/dts/intel/socfpga_diamondmesa.dts  |  41 ++
 arch/arm64/boot/dts/intel/socfpga_diamondmesa.dtsi | 466 +++++++++++++++++++++
 4 files changed, 513 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_diamondmesa.dts
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_diamondmesa.dtsi

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d235b27..ffae871 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -13,6 +13,11 @@ config ARCH_AGILEX
 	help
 	  This enables support for Intel's Agilex SoCFPGA Family.
 
+config ARCH_DIAMONDMESA
+	bool "Intel's Diamond Mesa SoCFPGA Family"
+	help
+	  This enables support for Intel's Diamond Mesa SoCFPGA Family.
+
 config ARCH_SUNXI
 	bool "Allwinner sunxi 64-bit SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index 296ecee..f725c60 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 dtb-$(CONFIG_ARCH_AGILEX) += socfpga_agilex_socdk.dtb \
 			     socfpga_agilex_socdk_nand.dtb
+dtb-$(CONFIG_ARCH_DIAMONDMESA) += socfpga_diamondmesa.dtb
 dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
diff --git a/arch/arm64/boot/dts/intel/socfpga_diamondmesa.dts b/arch/arm64/boot/dts/intel/socfpga_diamondmesa.dts
new file mode 100644
index 00000000..6ba7166
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_diamondmesa.dts
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2020 Intel Corporation
+ */
+#include "socfpga_diamondmesa.dtsi"
+
+/ {
+	model = "SoCFPGA Diamond Mesa Simics";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		bootargs = "earlycon";
+		stdout-path = "serial0:4800n8";
+	};
+
+	memory {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0x4000000>;
+	};
+};
+
+&uart0 {
+	clock-frequency = <76800>;
+	status = "okay";
+};
+
+&mmc {
+	clock-frequency = <50000000>;
+	cap-sd-highspeed;
+	broken-cd;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&watchdog0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/intel/socfpga_diamondmesa.dtsi b/arch/arm64/boot/dts/intel/socfpga_diamondmesa.dtsi
new file mode 100644
index 00000000..d2fa1a5
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_diamondmesa.dtsi
@@ -0,0 +1,466 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2020 Intel Corporation
+ */
+
+/dts-v1/;
+#include <dt-bindings/reset/altr,rst-mgr-s10.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/agilex-clock.h>
+
+/ {
+	compatible = "intel,socfpga-agilex";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		service_reserved: svcbuffer@0 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x0 0x0 0x2000000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <0x0>;
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <0x1>;
+		};
+
+		cpu2: cpu@2 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <0x2>;
+		};
+
+		cpu3: cpu@3 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <0x3>;
+		};
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <0 170 4>,
+			     <0 171 4>,
+			     <0 172 4>,
+			     <0 173 4>;
+		interrupt-affinity = <&cpu0>,
+				     <&cpu1>,
+				     <&cpu2>,
+				     <&cpu3>;
+		interrupt-parent = <&intc>;
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	intc: intc@fffc1000 {
+		compatible = "arm,gic-400", "arm,cortex-a15-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x0 0xfffc1000 0x0 0x1000>,
+		      <0x0 0xfffc2000 0x0 0x2000>,
+		      <0x0 0xfffc4000 0x0 0x2000>,
+		      <0x0 0xfffc6000 0x0 0x2000>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		device_type = "soc";
+		interrupt-parent = <&intc>;
+		ranges = <0 0 0 0xffffffff>;
+
+		/* Use fixed frequency clocks for now */
+		clocks {
+			wdt_clk: wdt-clk {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+				clock-frequency = <100000000>;
+			};
+		};
+
+		gmac0: ethernet@ff800000 {
+			compatible = "altr,socfpga-stmmac-a10-s10", "snps,dwmac-3.74a", "snps,dwmac";
+			reg = <0xff800000 0x2000>;
+			interrupts = <0 90 4>;
+			interrupt-names = "macirq";
+			mac-address = [00 00 00 00 00 00];
+			resets = <&rst EMAC0_RESET>, <&rst EMAC0_OCP_RESET>;
+			reset-names = "stmmaceth", "stmmaceth-ocp";
+			tx-fifo-depth = <16384>;
+			rx-fifo-depth = <16384>;
+			snps,multicast-filter-bins = <256>;
+			iommus = <&smmu 1>;
+			altr,sysmgr-syscon = <&sysmgr 0x44 0>;
+			clock-frequency = <250000000>;
+			status = "disabled";
+		};
+
+		gmac1: ethernet@ff802000 {
+			compatible = "altr,socfpga-stmmac-a10-s10", "snps,dwmac-3.74a", "snps,dwmac";
+			reg = <0xff802000 0x2000>;
+			interrupts = <0 91 4>;
+			interrupt-names = "macirq";
+			mac-address = [00 00 00 00 00 00];
+			resets = <&rst EMAC1_RESET>, <&rst EMAC1_OCP_RESET>;
+			reset-names = "stmmaceth", "stmmaceth-ocp";
+			tx-fifo-depth = <16384>;
+			rx-fifo-depth = <16384>;
+			snps,multicast-filter-bins = <256>;
+			iommus = <&smmu 2>;
+			altr,sysmgr-syscon = <&sysmgr 0x48 8>;
+			clock-frequency = <250000000>;
+			status = "disabled";
+		};
+
+		gmac2: ethernet@ff804000 {
+			compatible = "altr,socfpga-stmmac-a10-s10", "snps,dwmac-3.74a", "snps,dwmac";
+			reg = <0xff804000 0x2000>;
+			interrupts = <0 92 4>;
+			interrupt-names = "macirq";
+			mac-address = [00 00 00 00 00 00];
+			resets = <&rst EMAC2_RESET>, <&rst EMAC2_OCP_RESET>;
+			reset-names = "stmmaceth", "stmmaceth-ocp";
+			tx-fifo-depth = <16384>;
+			rx-fifo-depth = <16384>;
+			snps,multicast-filter-bins = <256>;
+			iommus = <&smmu 3>;
+			altr,sysmgr-syscon = <&sysmgr 0x4c 16>;
+			clock-frequency = <250000000>;
+			status = "disabled";
+		};
+
+		gpio0: gpio@ffc03200 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xffc03200 0x100>;
+			resets = <&rst GPIO0_RESET>;
+			clock-frequency = <100000000>;
+			status = "disabled";
+
+			porta: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <24>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 110 4>;
+			};
+		};
+
+		gpio1: gpio@ffc03300 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xffc03300 0x100>;
+			resets = <&rst GPIO1_RESET>;
+			clock-frequency = <100000000>;
+			status = "disabled";
+
+			portb: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <24>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 111 4>;
+			};
+		};
+
+		i2c0: i2c@ffc02800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc02800 0x100>;
+			interrupts = <0 103 4>;
+			resets = <&rst I2C0_RESET>;
+			clock-frequency = <100000000>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@ffc02900 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc02900 0x100>;
+			interrupts = <0 104 4>;
+			resets = <&rst I2C1_RESET>;
+			clock-frequency = <100000000>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@ffc02a00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc02a00 0x100>;
+			interrupts = <0 105 4>;
+			resets = <&rst I2C2_RESET>;
+			clock-frequency = <100000000>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@ffc02b00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc02b00 0x100>;
+			interrupts = <0 106 4>;
+			resets = <&rst I2C3_RESET>;
+			clock-frequency = <100000000>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@ffc02c00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc02c00 0x100>;
+			interrupts = <0 107 4>;
+			resets = <&rst I2C4_RESET>;
+			clock-frequency = <100000000>;
+			status = "disabled";
+		};
+
+		mmc: dwmmc0@ff808000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "altr,socfpga-dw-mshc";
+			reg = <0xff808000 0x1000>;
+			interrupts = <0 96 4>;
+			fifo-depth = <0x400>;
+			resets = <&rst SDMMC_RESET>;
+			reset-names = "reset";
+			iommus = <&smmu 5>;
+			clock-frequency = <100000000>;
+			status = "disabled";
+		};
+
+		ocram: sram@ffe00000 {
+			compatible = "mmio-sram";
+			reg = <0xffe00000 0x40000>;
+			status = "disabled";
+		};
+
+		pdma: pdma@ffda0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0xffda0000 0x1000>;
+			interrupts = <0 81 4>,
+				     <0 82 4>,
+				     <0 83 4>,
+				     <0 84 4>,
+				     <0 85 4>,
+				     <0 86 4>,
+				     <0 87 4>,
+				     <0 88 4>,
+				     <0 89 4>;
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+			resets = <&rst DMA_RESET>, <&rst DMA_OCP_RESET>;
+			reset-names = "dma", "dma-ocp";
+			clock-frequency = <100000000>;
+			status = "disabled";
+		};
+
+		rst: rstmgr@ffd11000 {
+			#reset-cells = <1>;
+			compatible = "altr,stratix10-rst-mgr";
+			reg = <0xffd11000 0x100>;
+		};
+
+		smmu: iommu@fa000000 {
+			compatible = "arm,mmu-500", "arm,smmu-v2";
+			reg = <0xfa000000 0x40000>;
+			#global-interrupts = <2>;
+			#iommu-cells = <1>;
+			interrupt-parent = <&intc>;
+			interrupts = <0 128 4>,	/* Global Secure Fault */
+				<0 129 4>, /* Global Non-secure Fault */
+				/* Non-secure Context Interrupts (32) */
+				<0 138 4>, <0 139 4>, <0 140 4>, <0 141 4>,
+				<0 142 4>, <0 143 4>, <0 144 4>, <0 145 4>,
+				<0 146 4>, <0 147 4>, <0 148 4>, <0 149 4>,
+				<0 150 4>, <0 151 4>, <0 152 4>, <0 153 4>,
+				<0 154 4>, <0 155 4>, <0 156 4>, <0 157 4>,
+				<0 158 4>, <0 159 4>, <0 160 4>, <0 161 4>,
+				<0 162 4>, <0 163 4>, <0 164 4>, <0 165 4>,
+				<0 166 4>, <0 167 4>, <0 168 4>, <0 169 4>;
+			stream-match-mask = <0x7ff0>;
+			status = "disabled";
+		};
+
+		spi0: spi@ffda4000 {
+			compatible = "snps,dw-apb-ssi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xffda4000 0x1000>;
+			interrupts = <0 99 4>;
+			resets = <&rst SPIM0_RESET>;
+			reg-io-width = <4>;
+			num-cs = <4>;
+			clock-frequency = <100000000>;
+			status = "disabled";
+		};
+
+		spi1: spi@ffda5000 {
+			compatible = "snps,dw-apb-ssi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xffda5000 0x1000>;
+			interrupts = <0 100 4>;
+			resets = <&rst SPIM1_RESET>;
+			reg-io-width = <4>;
+			num-cs = <4>;
+			clock-frequency = <100000000>;
+			status = "disabled";
+		};
+		sysmgr: sysmgr@ffd12000 {
+			compatible = "altr,sys-mgr-s10","altr,sys-mgr";
+			reg = <0xffd12000 0x500>;
+			status = "disabled";
+		};
+
+		/* Local timer */
+		timer {
+			compatible = "arm,armv8-timer";
+			interrupts = <1 13 0xf08>,
+				     <1 14 0xf08>,
+				     <1 11 0xf08>,
+				     <1 10 0xf08>;
+			clock-frequency = <200000000>;
+		};
+
+		timer0: timer0@ffc03000 {
+			compatible = "snps,dw-apb-timer";
+			interrupts = <0 113 4>;
+			reg = <0xffc03000 0x100>;
+			clock-frequency = <100000000>;
+			clock-names = "timer";
+			status = "disabled";
+		};
+
+		timer1: timer1@ffc03100 {
+			compatible = "snps,dw-apb-timer";
+			interrupts = <0 114 4>;
+			reg = <0xffc03100 0x100>;
+			clock-frequency = <100000000>;
+			clock-names = "timer";
+			status = "disabled";
+		};
+
+		timer2: timer2@ffd00000 {
+			compatible = "snps,dw-apb-timer";
+			interrupts = <0 115 4>;
+			reg = <0xffd00000 0x100>;
+			clock-frequency = <100000000>;
+			clock-names = "timer";
+			status = "disabled";
+		};
+
+		timer3: timer3@ffd00100 {
+			compatible = "snps,dw-apb-timer";
+			interrupts = <0 116 4>;
+			reg = <0xffd00100 0x100>;
+			clock-frequency = <100000000>;
+			clock-names = "timer";
+			status = "disabled";
+		};
+
+		uart0: serial0@ffc02000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0xffc02000 0x100>;
+			interrupts = <0 108 4>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			resets = <&rst UART0_RESET>;
+			clock-frequency = <100000000>;
+			status = "disabled";
+		};
+
+		uart1: serial1@ffc02100 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0xffc02100 0x100>;
+			interrupts = <0 109 4>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			resets = <&rst UART1_RESET>;
+			clock-frequency = <100000000>;
+			status = "disabled";
+		};
+
+		watchdog0: watchdog@ffd00200 {
+			compatible = "snps,dw-wdt";
+			reg = <0xffd00200 0x100>;
+			interrupts = <0 117 4>;
+			resets = <&rst WATCHDOG0_RESET>;
+			clock-frequency = <&wdt_clk>;
+			status = "disabled";
+		};
+
+		watchdog1: watchdog@ffd00300 {
+			compatible = "snps,dw-wdt";
+			reg = <0xffd00300 0x100>;
+			interrupts = <0 118 4>;
+			resets = <&rst WATCHDOG1_RESET>;
+			clock-frequency = <&wdt_clk>;
+			status = "disabled";
+		};
+
+		watchdog2: watchdog@ffd00400 {
+			compatible = "snps,dw-wdt";
+			reg = <0xffd00400 0x100>;
+			interrupts = <0 125 4>;
+			resets = <&rst WATCHDOG2_RESET>;
+			clock-frequency = <&wdt_clk>;
+			status = "disabled";
+		};
+
+		watchdog3: watchdog@ffd00500 {
+			compatible = "snps,dw-wdt";
+			reg = <0xffd00500 0x100>;
+			interrupts = <0 126 4>;
+			resets = <&rst WATCHDOG3_RESET>;
+			clock-frequency = <&wdt_clk>;
+			status = "disabled";
+		};
+
+		firmware {
+			svc {
+				compatible = "intel,agilex-svc";
+				method = "smc";
+				memory-region = <&service_reserved>;
+			};
+		};
+	};
+};
-- 
2.7.4

