Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA38C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43EF2206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgGHRvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:51:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:31336 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgGHRvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:51:02 -0400
IronPort-SDR: J8/mDWqOxbWMFJuVzUozd+5AGSvgKfP9hRBYoF8QQdv77VK2P4jqCAWpzeuQXDdK61cIrq0d79
 CyLBrAgSZwsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="232753577"
X-IronPort-AV: E=Sophos;i="5.75,328,1589266800"; 
   d="scan'208";a="232753577"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 10:51:01 -0700
IronPort-SDR: QGueSo69Rneunb1hXeQgL4SMrjBiL8w+qWm/2W2VPReUojcNXFAh+Z+5zPFA+DNfeZDI5BbBuT
 56f1rJwTG5vQ==
X-IronPort-AV: E=Sophos;i="5.75,328,1589266800"; 
   d="scan'208";a="457592062"
Received: from sgyanama-mobl1.gar.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.252.5.67])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 10:50:57 -0700
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
List-Id: <soc.lore.kernel.org>
To:     linux-arm-kernel@lists.infradead.org, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Paul Murphy <paul.j.murphy@intel.com>,
        Will Deacon <will@kernel.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Subject: [PATCH v2 5/5] arm64: dts: keembay: Add device tree for Keem Bay EVM board
Date:   Wed,  8 Jul 2020 18:50:20 +0100
Message-Id: <20200708175020.194436-6-daniele.alessandrelli@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708175020.194436-1-daniele.alessandrelli@linux.intel.com>
References: <20200708175020.194436-1-daniele.alessandrelli@linux.intel.com>
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
 arch/arm64/boot/dts/intel/keembay-evm.dts | 39 +++++++++++++++++++++++
 3 files changed, 41 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/keembay-evm.dts

diff --git a/MAINTAINERS b/MAINTAINERS
index 53d2f8d0976a..d7dcb3a86201 100644
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
index 000000000000..92a7500efc61
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/keembay-evm.dts
@@ -0,0 +1,39 @@
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
+	compatible = "intel,keembay-evm", "intel,keembay";
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
+};
+
+&uart3 {
+	status = "okay";
+};
-- 
2.26.2

