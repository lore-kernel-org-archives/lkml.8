Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8345DC433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62E4520BED
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgHaSgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:36:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:53041 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgHaSgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:36:32 -0400
IronPort-SDR: I2uRY27F7kLopoqYt62Ifp9xBW5JOhQgyHy4YzCOsXqSFUN4vr6VYSDPVrWrQdbz6N3z+IkOqb
 qlN/QyhXS0Zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="241853056"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="241853056"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 11:36:31 -0700
IronPort-SDR: 3Wbt34h2nl2+kUVhQX55Mbp6iMJfWQ68DYFndGnnetJCOomncp30+9Ft3X4pb7uJ56ZTyBgXdP
 UWUBJualG1/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="501938138"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga005.fm.intel.com with ESMTP; 31 Aug 2020 11:36:30 -0700
From:   richard.gong@linux.intel.com
To:     catalin.marinas@arm.com, will@kernel.org, dinguyen@kernel.org,
        robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCHv2] arm64: dts: diamonmesa: add device tree for Intel Diamond Mesa
Date:   Mon, 31 Aug 2020 13:55:24 -0500
Message-Id: <1598900124-23299-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add the device tree files for Intel Diamond Mesa SoC

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v2: use socfpga_agilex.dtsi rather than socfpga_diamondmesa.dtsi
---
 arch/arm64/Kconfig.platforms                      |  5 ++
 arch/arm64/boot/dts/intel/Makefile                |  1 +
 arch/arm64/boot/dts/intel/socfpga_diamondmesa.dts | 62 +++++++++++++++++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_diamondmesa.dts

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
index 00000000..eb1af5b
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_diamondmesa.dts
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2020 Intel Corporation
+ */
+#include "socfpga_agilex.dtsi"
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
+
+	soc {
+		clocks {
+			osc1 {
+				clock-frequency = <100000000>;
+			};
+
+			uart_clk: uart_clk {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+				clock-frequency = <76800>;
+			};
+
+			mmc_clk: mmc_clk {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+				clock-frequency = <50000000>;
+			};
+		};
+	};
+};
+
+&uart0 {
+	clocks = <&uart_clk>;
+	status = "okay";
+};
+
+&mmc {
+	clocks = <&mmc_clk>, <&mmc_clk>;
+	cap-sd-highspeed;
+	broken-cd;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&watchdog0 {
+	clocks = <&osc1>;
+	status = "okay";
+};
-- 
2.7.4

