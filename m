Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B45C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CFA0208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgGQJFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:05:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:64984 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbgGQJFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:05:01 -0400
IronPort-SDR: gVUJtUd8jac+/mn9uJSei/6bgK8kwdrs26rEhtgCY6RDsH0GrpdiaTu11fGSzKCurIq1OHXhxp
 iDL90/kRXgeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="148719511"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="148719511"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 02:04:57 -0700
IronPort-SDR: sohHCUeut7T+YLv63+wTkNjTNoT+IVRbkwxHZ8tZc1gG9bBw5FMYDgOvuAq6etWYj0tlIzkj+E
 yUHXD/J0R3Qw==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="460786195"
Received: from enaessen-mobl1.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.251.86.9])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 02:04:53 -0700
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
List-Id: <soc.lore.kernel.org>
To:     linux-arm-kernel@lists.infradead.org, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        "Paul J. Murphy" <paul.j.murphy@linux.intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH v4 5/5] arm64: dts: keembay: Add device tree for Keem Bay EVM board
Date:   Fri, 17 Jul 2020 10:04:14 +0100
Message-Id: <20200717090414.313530-6-daniele.alessandrelli@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717090414.313530-1-daniele.alessandrelli@linux.intel.com>
References: <20200717090414.313530-1-daniele.alessandrelli@linux.intel.com>
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
 arch/arm64/boot/dts/intel/keembay-evm.dts | 37 +++++++++++++++++++++++
 3 files changed, 39 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/keembay-evm.dts

diff --git a/MAINTAINERS b/MAINTAINERS
index 82ca9748fb70..aa86a74ea5d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1959,6 +1959,7 @@ M:	Paul J. Murphy <paul.j.murphy@intel.com>
 M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/intel,keembay.yaml
+F:	arch/arm64/boot/dts/intel/keembay-evm.dts
 F:	arch/arm64/boot/dts/intel/keembay-soc.dtsi
 
 ARM/INTEL RESEARCH IMOTE/STARGATE 2 MACHINE SUPPORT
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
index 000000000000..466c85363a29
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/keembay-evm.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Copyright (C) 2020, Intel Corporation
+ *
+ * Device tree describing Keem Bay EVM board.
+ */
+
+/dts-v1/;
+
+#include "keembay-soc.dtsi"
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

