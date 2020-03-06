Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B890FC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7596121739
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgCFNA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:00:59 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:36004 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgCFNA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:00:58 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 7F70E8030793;
        Fri,  6 Mar 2020 13:00:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AM2kRPbb_J9F; Fri,  6 Mar 2020 16:00:54 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] dt-bindings: clk: Add Baikal-T1 AXI-bus CCU bindings
Date:   Fri, 6 Mar 2020 16:00:45 +0300
In-Reply-To: <20200306130048.8868-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306130048.8868-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306130055.7F70E8030793@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

After being gained by the CCU PLLs the signals must be transformed to
be suitable for the clock-consumers. This is done by a set of dividers
embedded into the CCU. A first block of dividers is used to create
reference clocks for AXI-bus of high-speed peripheral IP-cores of the
chip. So the AXI-bus CCU dts-node is an ordinary clock-provider with
standard set of properties supported. But in addition to that each
AXI-bus clock divider provide a way to reset the corresponding clock
domain. This makes the AXI-bus CCU dts-node to be also a reset-provider.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 .../bindings/clock/be,bt1-ccu-axi.yaml        | 151 ++++++++++++++++++
 include/dt-bindings/clock/bt1-ccu.h           |  13 ++
 include/dt-bindings/reset/bt1-ccu.h           |  23 +++
 3 files changed, 187 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/be,bt1-ccu-axi.yaml
 create mode 100644 include/dt-bindings/reset/bt1-ccu.h

diff --git a/Documentation/devicetree/bindings/clock/be,bt1-ccu-axi.yaml b/Documentation/devicetree/bindings/clock/be,bt1-ccu-axi.yaml
new file mode 100644
index 000000000000..6b1eefdead27
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/be,bt1-ccu-axi.yaml
@@ -0,0 +1,151 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2019 - 2020 BAIKAL ELECTRONICS, JSC
+#
+# Baikal-T1 AXI-bus Clocks Control Unit Device Tree Bindings.
+#
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/be,bt1-ccu-axi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Baikal-T1 AXI-bus Clock Control Unit
+
+maintainers:
+  - Serge Semin <fancer.lancer@gmail.com>
+
+description: |
+  Clocks Control Unit is the core of Baikal-T1 SoC responsible for the chip
+  subsystems clocking and resetting. The CCU is connected with an external
+  fixed rate oscillator, which signal is transformed into clocks of various
+  frequencies and then propagated to either individual IP-blocks or to groups
+  of blocks (clock domains). The transformation is done by means of an embedded
+  into CCU PLLs and gateable/non-gateable dividers. Each clock domain can be
+  also individually reset by using the domain clocks divider configuration
+  registers. Baikal-T1 CCU is logically divided into the next components:
+  1) External oscillator (normally XTAL's 25 MHz crystal oscillator, but
+     in general can provide any frequency supported by the CCU PLLs).
+  2) PLLs clocks generators (PLLs).
+  3) AXI-bus clock dividers (AXI) - described in this bindings file.
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
+  Each sub-block is represented as a separate dts-node and has an individual
+  driver to be bound with.
+
+  In order to create signals of wide range frequencies the external oscillator
+  output is primarily connected to a set of CCU PLLs. Some of PLLs CLKOUT are
+  then passed over CCU dividers to create signals required for the target clock
+  domain (like AXI-bus consumers). The dividers have the following structure:
+          +--------------+
+  CLKIN --|->+----+ 1|\  |
+  SETCLK--|--|/DIV|->| | |
+  CLKDIV--|--|    |  | |-|->CLKLOUT
+  LOCK----|--+----+  | | |
+          |          |/  |
+          |           |  |
+  EN------|-----------+  |
+  RST-----|--------------|->RSTOUT
+          +--------------+
+  where CLKIN is the reference clock coming either from a CCU PLL, SETCLK - a
+  command to update the output clock in accordance with a set divider,
+  CLKDIV - clocks divider, LOCK - a signal of the output clock stabilization,
+  EN - enable/disable the divider block, RST/RSTOUT - reset clocks domain
+  signal. Depending on the consumer IP-core peculiarities the dividers may lack
+  of some functionality depicted on the figure above (like EN,
+  CLKDIV/LOCK/SETCLK). In this case the corresponding clock provider just
+  doesn't expose either switching functions, or the rate configuration, or
+  both of them.
+
+  The CCU AXI dts-node uses the common clock bindings [1] with no custom
+  properties. The list of exported clocks and reset signals can be found in
+  the files: 'dt-bindings/clock/bt1-ccu.h' and 'dt-bindings/reset/bt1-ccu.h'.
+
+  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+allOf:
+  - $ref: /schemas/clock/clock.yaml#
+
+properties:
+  compatible:
+    const: be,bt1-ccu-axi
+
+  reg:
+    description: AXI-bus CCU dividers sub-block base address.
+    maxItems: 1
+
+  "#clock-cells":
+    description: |
+      Clocks are referenced by the node phandle and an unique identifier
+      from 'dt-bindings/clock/bt1-ccu.h'.
+    const: 1
+
+  "#reset-cells":
+    description: |
+      AXI-bus CCU sub-block provides a reset signal for each clock domain,
+      which unique identifiers are in 'dt-bindings/reset/bt1-ccu.h'.
+    const: 1
+
+  clocks:
+    items:
+      - description: CCU SATA PLL output clock.
+      - description: CCU PCIe PLL output clock.
+      - description: CCU Ethernet PLL output clock.
+
+  clock-names:
+    items:
+      - const: sata_clk
+      - const: pcie_clk
+      - const: eth_clk
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
+    #include <dt-bindings/clock/bt1-ccu.h>
+
+    ccu_axi: ccu_axi@1F04D030 {
+      compatible = "be,bt1-ccu-axi";
+      reg = <0x1F04D030 0x030>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+
+      clocks = <&ccu_pll CCU_SATA_PLL>,
+               <&ccu_pll CCU_PCIE_PLL>,
+               <&ccu_pll CCU_ETH_PLL>;
+      clock-names = "sata_clk", "pcie_clk", "eth_clk";
+
+      clock-output-names = "axi_main_clk", "axi_ddr_clk",
+                           "axi_sata_clk", "axi_gmac0_clk",
+                           "axi_gmac1_clk", "axi_xgmac_clk",
+                           "axi_pcie_m_clk", "axi_pcie_s_clk",
+                           "axi_usb_clk", "axi_hwa_clk",
+                           "axi_sram_clk";
+    };
+...
diff --git a/include/dt-bindings/clock/bt1-ccu.h b/include/dt-bindings/clock/bt1-ccu.h
index 86e63162ade0..ebe723c6e0a8 100644
--- a/include/dt-bindings/clock/bt1-ccu.h
+++ b/include/dt-bindings/clock/bt1-ccu.h
@@ -14,4 +14,17 @@
 #define CCU_PCIE_PLL			3
 #define CCU_ETH_PLL			4
 
+/* Baikal-T1 AXI-bus CCU Clocks indeces. */
+#define CCU_AXI_MAIN_CLK		0
+#define CCU_AXI_DDR_CLK			1
+#define CCU_AXI_SATA_CLK		2
+#define CCU_AXI_GMAC0_CLK		3
+#define CCU_AXI_GMAC1_CLK		4
+#define CCU_AXI_XGMAC_CLK		5
+#define CCU_AXI_PCIE_M_CLK		6
+#define CCU_AXI_PCIE_S_CLK		7
+#define CCU_AXI_USB_CLK			8
+#define CCU_AXI_HWA_CLK			9
+#define CCU_AXI_SRAM_CLK		10
+
 #endif /* __DT_BINDINGS_CLOCK_BT1_CCU_H */
diff --git a/include/dt-bindings/reset/bt1-ccu.h b/include/dt-bindings/reset/bt1-ccu.h
new file mode 100644
index 000000000000..4de5b6bcd433
--- /dev/null
+++ b/include/dt-bindings/reset/bt1-ccu.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 BAIKAL ELECTRONICS, JSC
+ *
+ * Baikal-T1 CCU reset indeces.
+ */
+#ifndef __DT_BINDINGS_RESET_BT1_CCU_H
+#define __DT_BINDINGS_RESET_BT1_CCU_H
+
+/* Baikal-T1 AXI-bus CCU Reset indeces. */
+#define CCU_AXI_MAIN_RST		0
+#define CCU_AXI_DDR_RST			1
+#define CCU_AXI_SATA_RST		2
+#define CCU_AXI_GMAC0_RST		3
+#define CCU_AXI_GMAC1_RST		4
+#define CCU_AXI_XGMAC_RST		5
+#define CCU_AXI_PCIE_M_RST		6
+#define CCU_AXI_PCIE_S_RST		7
+#define CCU_AXI_USB_RST			8
+#define CCU_AXI_HWA_RST			9
+#define CCU_AXI_SRAM_RST		10
+
+#endif /* __DT_BINDINGS_RESET_BT1_CCU_H */
-- 
2.25.1

