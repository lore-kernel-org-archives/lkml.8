Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619D0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50BDD21534
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbgFPP46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:56:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:36618 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732993AbgFPP4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:56:47 -0400
IronPort-SDR: P2mXqQHNrxPgqe0B8160aaF1LH0ohgBf9q1ngWwVNHOrBWFpI0cf3Ta6vCqPuXFtQfhsAp8Gpe
 fovAFxu2v8+w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 08:56:46 -0700
IronPort-SDR: nzPcmt43wjvPio6T3fVA1CS4W5AduSmcR5lBh7PmeQXkiyKG7J8gtIFQ3pOL02RCHDOtKcS+Pp
 GNfpqOq8PrrA==
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="449888148"
Received: from pperycz-mobl.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.213.235.69])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 08:56:43 -0700
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Paul Murphy <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 6/7] arm64: dts: keembay: Add device tree for Keem Bay SoC
Date:   Tue, 16 Jun 2020 16:56:12 +0100
Message-Id: <20200616155613.121242-7-daniele.alessandrelli@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616155613.121242-1-daniele.alessandrelli@linux.intel.com>
References: <20200616155613.121242-1-daniele.alessandrelli@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>

Add initial device tree for Intel Movidius SoC code-named Keem Bay.

This initial DT includes nodes for Cortex-A53 cores, UARTs, timers, GIC,
PSCI, PMU, and Keem Bay SCMI mailbox.

Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
---
 MAINTAINERS                                |   1 +
 arch/arm64/boot/dts/intel/keembay-soc.dtsi | 172 +++++++++++++++++++++
 2 files changed, 173 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/keembay-soc.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b919aa8b1bd..610907bf391b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1959,6 +1959,7 @@ M:	Paul J. Murphy <paul.j.murphy@intel.com>
 M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/keembay.yaml
+F:	arch/arm64/boot/dts/intel/keembay-soc.dtsi
 F:	include/dt-bindings/clock/keembay-clocks.h
 F:	include/dt-bindings/power/keembay-power.h
 
diff --git a/arch/arm64/boot/dts/intel/keembay-soc.dtsi b/arch/arm64/boot/dts/intel/keembay-soc.dtsi
new file mode 100644
index 000000000000..bd0a48f24e09
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/keembay-soc.dtsi
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020, Intel Corporation.
+ *
+ * Device tree describing Keem Bay SoC.
+ */
+
+#include <dt-bindings/clock/keembay-clocks.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/keembay-power.h>
+
+/ {
+	compatible = "intel,keembay";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0>;
+			enable-method = "psci";
+			clocks = <&scmi_dvfs 0>;
+		};
+
+		cpu@1 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x1>;
+			enable-method = "psci";
+			clocks = <&scmi_dvfs 0>;
+		};
+
+		cpu@2 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x2>;
+			enable-method = "psci";
+			clocks = <&scmi_dvfs 0>;
+		};
+
+		cpu@3 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x3>;
+			enable-method = "psci";
+			clocks = <&scmi_dvfs 0>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	firmware: firmware {
+
+		scmi: scmi {
+			compatible = "arm,scmi";
+			mboxes = <&scmi_mailbox 0>;
+			shmem = <&scmi_sec_shmem>;
+			mbox-names = "tx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			scmi_devpd: protocol@11 {
+				reg = <0x11>;
+				#power-domain-cells = <1>;
+			};
+
+			scmi_dvfs: protocol@13 {
+				reg = <0x13>;
+				#clock-cells = <1>;
+			};
+
+			scmi_clk: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+		};
+	};
+
+	scmi_mailbox: scmi_mailbox {
+		compatible = "intel,keembay-scmi-mailbox";
+		#mbox-cells = <1>;
+		memory-region = <&scmi_sec_shmem>;
+		u-boot,dm-pre-reloc;
+	};
+
+	gic: interrupt-controller@20500000 {
+		compatible = "arm,gic-v3";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x0 0x20500000 0x0 0x20000>,	/* GICD */
+		      <0x0 0x20580000 0x0 0x80000>;	/* GICR */
+		/* VGIC maintenance interrupt */
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		/* Secure, non-secure, virtual, and hypervisor */
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 0x7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		uart0: serial@20150000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x20150000 0x0 0x100>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "baudclk", "apb_pclk";
+			clocks = <&scmi_clk KEEM_BAY_PSS_AUX_UART0>,
+				 <&scmi_clk KEEM_BAY_PSS_UART0>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart1: serial@20160000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x20160000 0x0 0x100>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "baudclk", "apb_pclk";
+			clocks = <&scmi_clk KEEM_BAY_PSS_AUX_UART1>,
+				 <&scmi_clk KEEM_BAY_PSS_UART1>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart2: serial@20170000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x20170000 0x0 0x100>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "baudclk", "apb_pclk";
+			clocks = <&scmi_clk KEEM_BAY_PSS_AUX_UART2>,
+				 <&scmi_clk KEEM_BAY_PSS_UART2>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart3: serial@20180000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x20180000 0x0 0x100>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "baudclk", "apb_pclk";
+			clocks = <&scmi_clk KEEM_BAY_PSS_AUX_UART3>,
+				 <&scmi_clk KEEM_BAY_PSS_UART3>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.26.2

