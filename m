Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20080C18E5F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF75A20828
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgCHQdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 12:33:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:44954 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgCHQcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 12:32:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0B50EB166;
        Sun,  8 Mar 2020 16:32:49 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Wells=20Lu=20=E5=91=82=E8=8A=B3=E9=A8=B0?= 
        <wells.lu@sunplus.com>, Dvorkin Dmitry <dvorkin@tibbo.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [RFC 07/11] ARM: dts: Add Sunplus Plus1 SP7021 and Banana Pi F2S
Date:   Sun,  8 Mar 2020 17:32:25 +0100
Message-Id: <20200308163230.4002-8-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200308163230.4002-1-afaerber@suse.de>
References: <20200308163230.4002-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare Device Trees for Sunplus Plus1 (aka Pentagram) SP7021's
CPU-Chip aka A-Chip (Cortex-A7) as well as the Banana Pi BPI-F2S SBC.

Cc: Wells Lu 呂芳騰 <wells.lu@sunplus.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/arm/boot/dts/Makefile                     |  2 +
 arch/arm/boot/dts/pentagram-sp7021-bpi-f2s.dts | 22 ++++++++
 arch/arm/boot/dts/pentagram-sp7021-cpu.dtsi    | 75 ++++++++++++++++++++++++++
 arch/arm/boot/dts/pentagram-sp7021.dtsi        | 61 +++++++++++++++++++++
 4 files changed, 160 insertions(+)
 create mode 100644 arch/arm/boot/dts/pentagram-sp7021-bpi-f2s.dts
 create mode 100644 arch/arm/boot/dts/pentagram-sp7021-cpu.dtsi
 create mode 100644 arch/arm/boot/dts/pentagram-sp7021.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 566c6d1cfc46..b514ead139f3 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -846,6 +846,8 @@ dtb-$(CONFIG_ARCH_ACTIONS) += \
 	owl-s500-cubieboard6.dtb \
 	owl-s500-guitar-bb-rev-b.dtb \
 	owl-s500-sparky.dtb
+dtb-$(CONFIG_ARCH_SUNPLUS) += \
+	pentagram-sp7021-bpi-f2s.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += \
 	prima2-evb.dtb
 dtb-$(CONFIG_ARCH_PXA) += \
diff --git a/arch/arm/boot/dts/pentagram-sp7021-bpi-f2s.dts b/arch/arm/boot/dts/pentagram-sp7021-bpi-f2s.dts
new file mode 100644
index 000000000000..3c25b6e79fe2
--- /dev/null
+++ b/arch/arm/boot/dts/pentagram-sp7021-bpi-f2s.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
+
+/dts-v1/;
+
+#include "pentagram-sp7021-cpu.dtsi"
+
+/ {
+	compatible = "bananapi,bpi-f2s", "sunplus,sp7021";
+	model = "Banana Pi BPI-F2S";
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
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/pentagram-sp7021-cpu.dtsi b/arch/arm/boot/dts/pentagram-sp7021-cpu.dtsi
new file mode 100644
index 000000000000..ae58bf5ffadf
--- /dev/null
+++ b/arch/arm/boot/dts/pentagram-sp7021-cpu.dtsi
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
+/*
+ * SunPlus Plus1 (Pentagram) SP7021 CPU-Chip a.k.a. A-Chip (CA7)
+ *
+ * Copyright (c) 2020 Andreas Färber
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#include "pentagram-sp7021.dtsi"
+
+/ {
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0>;
+		};
+
+		cpu1: cpu@1{
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <1>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <2>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <3>;
+		};
+	};
+
+	arm-pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
+	timer: timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <27000000>;
+		arm,cpu-registers-not-fw-configured;
+	};
+
+	soc {
+		gic: interrupt-controller@9f101000 {
+			compatible = "arm,cortex-a7-gic";
+			reg = <0x9f101000 0x1000>,
+			      <0x9f102000 0x2000>,
+			      <0x9f104000 0x2000>,
+			      <0x9f106000 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/pentagram-sp7021.dtsi b/arch/arm/boot/dts/pentagram-sp7021.dtsi
new file mode 100644
index 000000000000..7dd44901cf4a
--- /dev/null
+++ b/arch/arm/boot/dts/pentagram-sp7021.dtsi
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
+/*
+ * Copyright (c) 2020 Andreas Färber
+ */
+
+/ {
+	compatible = "sunplus,sp7021";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x20000000 0x20000000 0xe0000000>;
+
+		rgst: bus@9c000000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x9c000000 0x00100000>;
+
+			uart2: serial@800 {
+				compatible = "sunplus,sp7021-uart";
+				reg = <0x800 0x80>;
+				status = "disabled";
+			};
+
+			uart3: serial@880 {
+				compatible = "sunplus,sp7021-uart";
+				reg = <0x880 0x80>;
+				status = "disabled";
+			};
+
+			uart0: serial@900 {
+				compatible = "sunplus,sp7021-uart";
+				reg = <0x900 0x80>;
+				status = "disabled";
+			};
+
+			uart1: serial@980 {
+				compatible = "sunplus,sp7021-uart";
+				reg = <0x980 0x80>;
+				status = "disabled";
+			};
+
+			uart4: serial@8780 {
+				compatible = "sunplus,sp7021-uart";
+				reg = <0x8780 0x80>;
+				status = "disabled";
+			};
+		};
+
+		amba: bus@9c100000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x9c100000 0x01ef0000>;
+		};
+	};
+};
-- 
2.16.4

