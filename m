Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF1EC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E7F2084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgCFNA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:00:57 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:35982 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgCFNA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:00:56 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 8702F8030786;
        Fri,  6 Mar 2020 13:00:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Bz3LLyoJ0WXZ; Fri,  6 Mar 2020 16:00:53 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] dt-bindings: clk: Add Baikal-T1 CCU PLLs bindings
Date:   Fri, 6 Mar 2020 16:00:44 +0300
In-Reply-To: <20200306130048.8868-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306130048.8868-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306130054.8702F8030786@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Baikal-T1 Clocks Control Unit is responsible for transformation of a
signal coming from an external oscillator into clocks of various
frequencies to propagate them then to the corresponding clocks
consumers (either individual IP-blocks or clock domains). In order
to create a set of high-frequency clocks the external signal is
firstly handled by the embedded into CCU PLLs. So the corresponding
dts-node is just a normal clock-provider node with standard set of
properties.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 .../bindings/clock/be,bt1-ccu-pll.yaml        | 139 ++++++++++++++++++
 include/dt-bindings/clock/bt1-ccu.h           |  17 +++
 2 files changed, 156 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/be,bt1-ccu-pll.yaml
 create mode 100644 include/dt-bindings/clock/bt1-ccu.h

diff --git a/Documentation/devicetree/bindings/clock/be,bt1-ccu-pll.yaml b/Documentation/devicetree/bindings/clock/be,bt1-ccu-pll.yaml
new file mode 100644
index 000000000000..f2e397cc147b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/be,bt1-ccu-pll.yaml
@@ -0,0 +1,139 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2019 - 2020 BAIKAL ELECTRONICS, JSC
+#
+# Baikal-T1 Clocks Control Unit PLL Device Tree Bindings.
+#
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/be,bt1-ccu-pll.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Baikal-T1 Clock Control Unit PLLs
+
+maintainers:
+  - Serge Semin <fancer.lancer@gmail.com>
+
+description: |
+  Clocks Control Unit is the core of Baikal-T1 SoC responsible for the chip
+  subsystems clocking and resetting. The CCU is connected with an external
+  fixed rate oscillator, which signal is transformed into clocks of various
+  frequencies and then propagated to either individual IP-blocks or to groups
+  of blocks (clock domains). The transformation is done by means of PLLs and
+  gateable/non-gateable dividers embedded into the CCU. It's logically divided
+  into the next components:
+  1) External oscillator (normally XTAL's 25 MHz crystal oscillator, but
+     in general can provide any frequency supported by the CCU PLLs).
+  2) PLLs clocks generators (PLLs) - described in this bindings file.
+  3) AXI-bus clock dividers (AXI).
+  4) System devices reference clock dividers (SYS).
+  which are connected with each other as shown on the next figure:
+          +---------------+
+          | Baikal-T1 CCU |
+          |   +----+------|- MIPS P5600 cores
+          | +-|PLLs|------|- DDR controller
+          | | +----+      |
+  +----+  | |  |  |       |
+  |XTAL|--|-+  |  | +---+-|
+  +----+  | |  |  +-|AXI|-|- AXI-bus
+          | |  |    +---+-|
+          | |  |          |
+          | |  +----+---+-|- APB-bus
+          | +-------|SYS|-|- Low-speed Devices
+          |         +---+-|- High-speed Devices
+          +---------------+
+  Each CCU sub-block is represented as a separate dts-node and has an
+  individual driver to be bound with.
+
+  In order to create signals of wide range frequencies the external oscillator
+  output is primarily connected to a set of CCU PLLs. There are five PLLs
+  to create a clock for the MIPS P5600 cores, the embedded DDR controller,
+  SATA, Ethernet and PCIe domains. The last three domains though named by the
+  biggest system interfaces in fact include nearly all of the rest SoC
+  peripherals. Each of the PLLs is based on True Circuits TSMC CLN28HPM core
+  with an interface wrapper (so called safe PLL' clocks switcher) to simplify
+  the PLL configuration procedure. The PLLs work as depicted on the next
+  diagram:
+      +--------------------------+
+      |                          |
+      +-->+---+    +---+   +---+ |  +---+   0|\
+  CLKF--->|/NF|--->|PFD|...|VCO|-+->|/OD|--->| |
+          +---+ +->+---+   +---+ /->+---+    | |--->CLKOUT
+  CLKOD---------C----------------+          1| |
+       +--------C--------------------------->|/
+       |        |                             ^
+  Rclk-+->+---+ |                             |
+  CLKR--->|/NR|-+                             |
+          +---+                               |
+  BYPASS--------------------------------------+
+  BWADJ--->
+  where Rclk is the reference clock coming  from XTAL, NR - reference clock
+  divider, NF - PLL clock multiplier, OD - VCO output clock divider, CLKOUT -
+  output clock, BWADJ is the PLL bandwidth adjustment parameter. At this moment
+  the binding supports the PLL dividers configuration in accordance with a
+  requested rate, while bypassing and bandwidth adjustment settings can be
+  added in future if it gets to be necessary.
+
+  The PLLs CLKOUT is then either directly connected with the corresponding
+  clocks consumer (like P5600 cores or DDR controller) or passed over a CCU
+  divider to create a signal required for the clock domain.
+
+  The CCU PLL dts-node uses the common clock bindings [1] with no custom
+  parameters. The list of exported clocks can be found in
+  'dt-bindings/clock/bt1-ccu.h'.
+
+  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+allOf:
+  - $ref: /schemas/clock/clock.yaml#
+
+properties:
+  compatible:
+    const: be,bt1-ccu-pll
+
+  reg:
+    description: CCU PLLs sub-block base address.
+    maxItems: 1
+
+  "#clock-cells":
+    description: |
+      Clocks are referenced by the node phandle and an unique identifier
+      from 'dt-bindings/clock/bt1-ccu.h'.
+    const: 1
+
+  clocks:
+    description: Phandle of CCU External reference clock.
+    maxItems: 1
+
+  clock-names:
+    const: ref_clk
+
+  clock-output-names: true
+
+  assigned-clocks: true
+
+  assigned-clock-rates: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    ccu_pll: ccu_pll@1F04D000 {
+      compatible = "be,bt1-ccu-pll";
+      reg = <0x1F04D000 0x028>;
+      #clock-cells = <1>;
+
+      clocks = <&osc25>;
+      clock-names = "ref_clk";
+
+      clock-output-names = "cpu_pll", "sata_pll", "ddr_pll",
+                           "pcie_pll", "eth_pll";
+    };
+...
diff --git a/include/dt-bindings/clock/bt1-ccu.h b/include/dt-bindings/clock/bt1-ccu.h
new file mode 100644
index 000000000000..86e63162ade0
--- /dev/null
+++ b/include/dt-bindings/clock/bt1-ccu.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 BAIKAL ELECTRONICS, JSC
+ *
+ * Baikal-T1 CCU clock indeces.
+ */
+#ifndef __DT_BINDINGS_CLOCK_BT1_CCU_H
+#define __DT_BINDINGS_CLOCK_BT1_CCU_H
+
+/* Baikal-T1 CCU PLL indeces. */
+#define CCU_CPU_PLL			0
+#define CCU_SATA_PLL			1
+#define CCU_DDR_PLL			2
+#define CCU_PCIE_PLL			3
+#define CCU_ETH_PLL			4
+
+#endif /* __DT_BINDINGS_CLOCK_BT1_CCU_H */
-- 
2.25.1

