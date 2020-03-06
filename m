Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E298FC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B394E2084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgCFNBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:01:02 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:36028 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgCFNA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:00:59 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 7434E80307C4;
        Fri,  6 Mar 2020 13:00:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fRCP2EswWlAL; Fri,  6 Mar 2020 16:00:55 +0300 (MSK)
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
Subject: [PATCH 3/5] dt-bindings: clk: Add Baikal-T1 System Devices CCU bindings
Date:   Fri, 6 Mar 2020 16:00:46 +0300
In-Reply-To: <20200306130048.8868-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306130048.8868-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306130056.7434E80307C4@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Aside from providing an individual reference clocks for AXI-bus the
Baikal-T1 CCU dividers are used to alter the PLLs output signals for
the SoC peripheral devices. These dividers are represented by means
of the SYS CCU dts-node as an ordinary clock-provider with standard
set of properties supported. In the same way as AXI-bus CCU dividers
do they can be used to reset the APB and SATA clock domains, which
also makes the SYS CCU dts-node to be a reset-controller.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 .../bindings/clock/be,bt1-ccu-sys.yaml        | 169 ++++++++++++++++++
 include/dt-bindings/clock/bt1-ccu.h           |  24 +++
 include/dt-bindings/reset/bt1-ccu.h           |   4 +
 3 files changed, 197 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/be,bt1-ccu-sys.yaml

diff --git a/Documentation/devicetree/bindings/clock/be,bt1-ccu-sys.yaml b/Documentation/devicetree/bindings/clock/be,bt1-ccu-sys.yaml
new file mode 100644
index 000000000000..aea09fbafc89
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/be,bt1-ccu-sys.yaml
@@ -0,0 +1,169 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2019 - 2020 BAIKAL ELECTRONICS, JSC
+#
+# Baikal-T1 System Devices Clocks Control Unit Device Tree Bindings.
+#
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/be,bt1-ccu-sys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Baikal-T1 System Devices Clock Control Unit
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
+  into CCU PLLs and gateable/non-gateable dividers. APB-bus divider register
+  provides a specific flag to initiate the full APB clock domain reset, so
+  causing each sub-device reset. Baikal-T1 CCU is logically divided into the
+  next components:
+  1) External oscillator (normally XTAL's 25 MHz crystal oscillator, but
+     in general can provide any frequency supported by the CCU PLLs).
+  2) PLLs clocks generators (PLLs).
+  3) AXI-bus clock dividers (AXI).
+  4) System devices reference clock dividers (SYS) - described in this bindings
+     file.
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
+  output is primarily connected to a set of CCU PLLs. The PLLs CLKOUT is then
+  either directly connected with the corresponding clocks consumer (like P5600
+  cores or DDR controller) or passed over a CCU divider to create a signal
+  required for the clock domain. The dividers have the following structure
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
+  where CLKIN is the reference clock coming either from XTAL or from a CCU PLL,
+  SETCLK - a command to update the output clock in accordance with a set
+  divider, CLKDIV - clocks divider, LOCK - a signal of the output clock
+  stabilization, EN - enable/disable the divider block, RST/RSTOUT - reset
+  clocks domain signal. Depending on the consumer IP-core peculiarities the
+  dividers may lack of some functionality depicted on the figure above (like
+  EN, CLKDIV/LOCK/SETCLK or RST). In this case the corresponding clock provider
+  just doesn't expose either switching functions, or the rate configuration, or
+  both of them.
+
+  The clock dividers, which output clock is then consumed by the SoC individual
+  devices, are united into a single clocks provider called System Devices CCU.
+  The System Devices CCU dts-node uses the common clock bindings [1] with no
+  custom properties. The list of exported clocks and reset signals can be found
+  in the files: 'dt-bindings/clock/bt1-ccu.h' and
+  'dt-bindings/reset/bt1-ccu.h'.
+
+  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+allOf:
+  - $ref: /schemas/clock/clock.yaml#
+
+properties:
+  compatible:
+    const: be,bt1-ccu-sys
+
+  reg:
+    items:
+      - description: System Devices CCU sub-block base address.
+      - description: Watchdog clock divider register address in CCU.
+
+  "#clock-cells":
+    description: |
+      Clocks are referenced by the node phandle and an unique identifier
+      from 'dt-bindings/clock/bt1-ccu.h'.
+    const: 1
+
+  "#reset-cells":
+    description: |
+      CCU system devices sub-block provides a reset signal for APB and SATA
+      clock domains, which unique identifiers reside in
+      'dt-bindings/reset/bt1-ccu.h'.
+    const: 1
+
+  clocks:
+    items:
+      - description: CCU external reference clock.
+      - description: CCU SATA PLL output clock.
+      - description: CCU PCIe PLL output clock.
+      - description: CCU Ethernet PLL output clock.
+
+  clock-names:
+    items:
+      - const: ref_clk
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
+    ccu_sys: ccu_sys@1F04D060 {
+      compatible = "be,bt1-ccu-sys";
+      reg = <0x1F04D060 0x0A0>,
+            <0x1F04D150 0x004>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+
+      clocks = <&osc25>,
+               <&ccu_pll CCU_SATA_PLL>,
+               <&ccu_pll CCU_PCIE_PLL>,
+               <&ccu_pll CCU_ETH_PLL>;
+      clock-names = "ref_clk", "sata_clk", "pcie_clk",
+                    "eth_clk";
+
+      clock-output-names = "sys_sata_ref_clk", "sys_apb_clk",
+                           "sys_gmac0_csr_clk", "sys_gmac0_tx_clk",
+                           "sys_gmac0_ptp_clk", "sys_gmac1_csr_clk",
+                           "sys_gmac1_tx_clk", "sys_gmac1_ptp_clk",
+                           "sys_xgmac_ref_clk", "sys_xgmac_ptp_clk",
+                           "sys_usb_clk", "sys_pvt_clk",
+                           "sys_hwa_clk", "sys_uart_clk",
+                           "sys_spi_clk", "sys_i2c1_clk",
+                           "sys_i2c2_clk", "sys_gpio_clk",
+                           "sys_timer0_clk", "sys_timer1_clk",
+                           "sys_timer2_clk", "sys_wdt_clk";
+      };
+...
diff --git a/include/dt-bindings/clock/bt1-ccu.h b/include/dt-bindings/clock/bt1-ccu.h
index ebe723c6e0a8..4dcad1eb721f 100644
--- a/include/dt-bindings/clock/bt1-ccu.h
+++ b/include/dt-bindings/clock/bt1-ccu.h
@@ -27,4 +27,28 @@
 #define CCU_AXI_HWA_CLK			9
 #define CCU_AXI_SRAM_CLK		10
 
+/* Baikal-T1 System Devices CCU Clocks indeces. */
+#define CCU_SYS_SATA_REF_CLK		0
+#define CCU_SYS_APB_CLK			1
+#define CCU_SYS_GMAC0_CSR_CLK		2
+#define CCU_SYS_GMAC0_TX_CLK		3
+#define CCU_SYS_GMAC0_PTP_CLK		4
+#define CCU_SYS_GMAC1_CSR_CLK		5
+#define CCU_SYS_GMAC1_TX_CLK		6
+#define CCU_SYS_GMAC1_PTP_CLK		7
+#define CCU_SYS_XGMAC_REF_CLK		8
+#define CCU_SYS_XGMAC_PTP_CLK		9
+#define CCU_SYS_USB_CLK			10
+#define CCU_SYS_PVT_CLK			11
+#define CCU_SYS_HWA_CLK			12
+#define CCU_SYS_UART_CLK		13
+#define CCU_SYS_SPI_CLK			14
+#define CCU_SYS_I2C1_CLK		15
+#define CCU_SYS_I2C2_CLK		16
+#define CCU_SYS_GPIO_CLK		17
+#define CCU_SYS_TIMER0_CLK		18
+#define CCU_SYS_TIMER1_CLK		19
+#define CCU_SYS_TIMER2_CLK		20
+#define CCU_SYS_WDT_CLK			21
+
 #endif /* __DT_BINDINGS_CLOCK_BT1_CCU_H */
diff --git a/include/dt-bindings/reset/bt1-ccu.h b/include/dt-bindings/reset/bt1-ccu.h
index 4de5b6bcd433..0bd8fd0edb41 100644
--- a/include/dt-bindings/reset/bt1-ccu.h
+++ b/include/dt-bindings/reset/bt1-ccu.h
@@ -20,4 +20,8 @@
 #define CCU_AXI_HWA_RST			9
 #define CCU_AXI_SRAM_RST		10
 
+/* Baikal-T1 System Devices CCU Reset indeces. */
+#define CCU_SYS_SATA_REF_RST		0
+#define CCU_SYS_APB_RST			1
+
 #endif /* __DT_BINDINGS_RESET_BT1_CCU_H */
-- 
2.25.1

