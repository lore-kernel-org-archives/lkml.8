Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5EFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78D3F207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733194AbgFPP4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:56:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:36641 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733183AbgFPP4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:56:50 -0400
IronPort-SDR: gL9c6r7VpBrBR2Rhz4BL/VXVnDf3ip/sBw2ohGnmBGVDfqD8IkVt25wDj2OwZi7My6R72nDliM
 N0icwwXLaJCA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 08:56:49 -0700
IronPort-SDR: aqdBPz1alytmC5uJAhIOFCRO1WA9H/qdXQeskpOvCOHmLMBcGqgMk/hig45cAJ90neUJB2nZXX
 D8wny2avyf0g==
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="449888162"
Received: from pperycz-mobl.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.213.235.69])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 08:56:46 -0700
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
Subject: [PATCH 7/7] arm64: dts: keembay: Add device tree for Keem Bay EVM board
Date:   Tue, 16 Jun 2020 16:56:13 +0100
Message-Id: <20200616155613.121242-8-daniele.alessandrelli@linux.intel.com>
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

Add initial device tree for Keem Bay EVM board. With this minimal device
tree the board boots fine using an initramfs image.

Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
---
 MAINTAINERS                               |  1 +
 arch/arm64/boot/dts/intel/Makefile        |  1 +
 arch/arm64/boot/dts/intel/keembay-evm.dts | 55 +++++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/keembay-evm.dts

diff --git a/MAINTAINERS b/MAINTAINERS
index 610907bf391b..d714762e805c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1959,6 +1959,7 @@ M:	Paul J. Murphy <paul.j.murphy@intel.com>
 M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/keembay.yaml
+F:	arch/arm64/boot/dts/intel/keembay-evm.dts
 F:	arch/arm64/boot/dts/intel/keembay-soc.dtsi
 F:	include/dt-bindings/clock/keembay-clocks.h
 F:	include/dt-bindings/power/keembay-power.h
diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index 40cb16e8c814..296eceec4276 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 dtb-$(CONFIG_ARCH_AGILEX) += socfpga_agilex_socdk.dtb \
 			     socfpga_agilex_socdk_nand.dtb
+dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
diff --git a/arch/arm64/boot/dts/intel/keembay-evm.dts b/arch/arm64/boot/dts/intel/keembay-evm.dts
new file mode 100644
index 000000000000..46859763cb03
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/keembay-evm.dts
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020, Intel Corporation
+ *
+ * Device tree describing Keem Bay EVM board.
+ */
+
+/dts-v1/;
+
+#include "keembay-soc.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Keem Bay EVM";
+	compatible = "intel,keembay-evm";
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart3;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* 2GB of DDR memory. */
+		reg = <0x0 0x80000000 0x0 0x80000000>;
+	};
+
+	sysmem@84000000 {
+		compatible = "mmio-sram";
+		reg = <0x0 0x84000000 0x0 0x800000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0 0x0 0x0 0x84000000 0x0 0x800000>;
+		/*
+		 * Allocate 1MB at fixed location for shared memory between
+		 * non-secure world and BL31 to be used for SCMI.
+		 */
+		scmi_sec_shmem: scmi_sec_shmem@0 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0x0 0x0 0x100000>;
+			pool;
+		};
+	};
+};
+
+&uart3 {
+	status = "okay";
+};
-- 
2.26.2

