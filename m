Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C3AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 01:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A8E5207D5
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 01:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgFDBno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 21:43:44 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50062 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgFDBno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 21:43:44 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DC0AB1A10D4;
        Thu,  4 Jun 2020 03:43:39 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4A6211A0188;
        Thu,  4 Jun 2020 03:43:34 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7677940299;
        Thu,  4 Jun 2020 09:43:27 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] dt-bindings: clock: Convert imx7ulp clock to json-schema
Date:   Thu,  4 Jun 2020 09:33:07 +0800
Message-Id: <1591234387-15059-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX7ULP clock binding to DT schema format using json-schema,
the original binding doc is actually for two clock modules(SCG and PCC),
so split it to two binding docs, and the MPLL(mipi PLL) is NOT supposed
to be in clock module, so remove it from binding doc as well.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- add "additionalProperties: false".
---
 .../devicetree/bindings/clock/imx7ulp-clock.txt    | 103 ------------------
 .../bindings/clock/imx7ulp-pcc-clock.yaml          | 121 +++++++++++++++++++++
 .../bindings/clock/imx7ulp-scg-clock.yaml          |  99 +++++++++++++++++
 3 files changed, 220 insertions(+), 103 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-pcc-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-scg-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
deleted file mode 100644
index 93d89ad..0000000
--- a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
+++ /dev/null
@@ -1,103 +0,0 @@
-* Clock bindings for Freescale i.MX7ULP
-
-i.MX7ULP Clock functions are under joint control of the System
-Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
-modules, and Core Mode Controller (CMC)1 blocks
-
-The clocking scheme provides clear separation between M4 domain
-and A7 domain. Except for a few clock sources shared between two
-domains, such as the System Oscillator clock, the Slow IRC (SIRC),
-and and the Fast IRC clock (FIRCLK), clock sources and clock
-management are separated and contained within each domain.
-
-M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
-A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
-
-Note: this binding doc is only for A7 clock domain.
-
-System Clock Generation (SCG) modules:
----------------------------------------------------------------------
-The System Clock Generation (SCG) is responsible for clock generation
-and distribution across this device. Functions performed by the SCG
-include: clock reference selection, generation of clock used to derive
-processor, system, peripheral bus and external memory interface clocks,
-source selection for peripheral clocks and control of power saving
-clock gating mode.
-
-Required properties:
-
-- compatible:	Should be "fsl,imx7ulp-scg1".
-- reg : 	Should contain registers location and length.
-- #clock-cells:	Should be <1>.
-- clocks:	Should contain the fixed input clocks.
-- clock-names:  Should contain the following clock names:
-		"rosc", "sosc", "sirc", "firc", "upll", "mpll".
-
-Peripheral Clock Control (PCC) modules:
----------------------------------------------------------------------
-The Peripheral Clock Control (PCC) is responsible for clock selection,
-optional division and clock gating mode for peripherals in their
-respected power domain
-
-Required properties:
-- compatible:	Should be one of:
-		  "fsl,imx7ulp-pcc2",
-		  "fsl,imx7ulp-pcc3".
-- reg : 	Should contain registers location and length.
-- #clock-cells:	Should be <1>.
-- clocks:	Should contain the fixed input clocks.
-- clock-names:  Should contain the following clock names:
-		"nic1_bus_clk", "nic1_clk", "ddr_clk", "apll_pfd2",
-		"apll_pfd1", "apll_pfd0", "upll", "sosc_bus_clk",
-		"mpll", "firc_bus_clk", "rosc", "spll_bus_clk";
-
-The clock consumer should specify the desired clock by having the clock
-ID in its "clocks" phandle cell.
-See include/dt-bindings/clock/imx7ulp-clock.h
-for the full list of i.MX7ULP clock IDs of each module.
-
-Examples:
-
-#include <dt-bindings/clock/imx7ulp-clock.h>
-
-scg1: scg1@403e0000 {
-	compatible = "fsl,imx7ulp-scg1;
-	reg = <0x403e0000 0x10000>;
-	clocks = <&rosc>, <&sosc>, <&sirc>,
-		 <&firc>, <&upll>, <&mpll>;
-	clock-names = "rosc", "sosc", "sirc",
-		      "firc", "upll", "mpll";
-	#clock-cells = <1>;
-};
-
-pcc2: pcc2@403f0000 {
-	compatible = "fsl,imx7ulp-pcc2";
-	reg = <0x403f0000 0x10000>;
-	#clock-cells = <1>;
-	clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
-		 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
-		 <&scg1 IMX7ULP_CLK_DDR_DIV>,
-		 <&scg1 IMX7ULP_CLK_APLL_PFD2>,
-		 <&scg1 IMX7ULP_CLK_APLL_PFD1>,
-		 <&scg1 IMX7ULP_CLK_APLL_PFD0>,
-		 <&scg1 IMX7ULP_CLK_UPLL>,
-		 <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>,
-		 <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>,
-		 <&scg1 IMX7ULP_CLK_ROSC>,
-		 <&scg1 IMX7ULP_CLK_SPLL_BUS_CLK>;
-	clock-names = "nic1_bus_clk", "nic1_clk", "ddr_clk",
-		      "apll_pfd2", "apll_pfd1", "apll_pfd0",
-		      "upll", "sosc_bus_clk", "mpll",
-		      "firc_bus_clk", "rosc", "spll_bus_clk";
-};
-
-usdhc1: usdhc@40380000 {
-	compatible = "fsl,imx7ulp-usdhc";
-	reg = <0x40380000 0x10000>;
-	interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
-		 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
-		 <&pcc2 IMX7ULP_CLK_USDHC1>;
-	clock-names ="ipg", "ahb", "per";
-	bus-width = <4>;
-};
diff --git a/Documentation/devicetree/bindings/clock/imx7ulp-pcc-clock.yaml b/Documentation/devicetree/bindings/clock/imx7ulp-pcc-clock.yaml
new file mode 100644
index 0000000..7caf5ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx7ulp-pcc-clock.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx7ulp-pcc-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock bindings for Freescale i.MX7ULP Peripheral Clock Control (PCC) modules
+
+maintainers:
+  - A.s. Dong <aisheng.dong@nxp.com>
+
+description: |
+  i.MX7ULP Clock functions are under joint control of the System
+  Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
+  modules, and Core Mode Controller (CMC)1 blocks
+
+  The clocking scheme provides clear separation between M4 domain
+  and A7 domain. Except for a few clock sources shared between two
+  domains, such as the System Oscillator clock, the Slow IRC (SIRC),
+  and and the Fast IRC clock (FIRCLK), clock sources and clock
+  management are separated and contained within each domain.
+
+  M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
+  A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
+
+  Note: this binding doc is only for A7 clock domain.
+
+  The Peripheral Clock Control (PCC) is responsible for clock selection,
+  optional division and clock gating mode for peripherals in their
+  respected power domain.
+
+  The clock consumer should specify the desired clock by having the clock
+  ID in its "clocks" phandle cell.
+  See include/dt-bindings/clock/imx7ulp-clock.h for the full list of
+  i.MX7ULP clock IDs of each module.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx7ulp-pcc2
+      - fsl,imx7ulp-pcc3
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  clocks:
+    items:
+      - description: nic1 bus clock
+      - description: nic1 clock
+      - description: ddr clock
+      - description: apll pfd2
+      - description: apll pfd1
+      - description: apll pfd0
+      - description: usb pll
+      - description: system osc bus clock
+      - description: fast internal reference clock bus
+      - description: rtc osc
+      - description: system pll bus clock
+
+  clock-names:
+    items:
+      - const: nic1_bus_clk
+      - const: nic1_clk
+      - const: ddr_clk
+      - const: apll_pfd2
+      - const: apll_pfd1
+      - const: apll_pfd0
+      - const: upll
+      - const: sosc_bus_clk
+      - const: firc_bus_clk
+      - const: rosc
+      - const: spll_bus_clk
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx7ulp-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    clock-controller@403f0000 {
+        compatible = "fsl,imx7ulp-pcc2";
+        reg = <0x403f0000 0x10000>;
+        #clock-cells = <1>;
+        clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
+                 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
+                 <&scg1 IMX7ULP_CLK_DDR_DIV>,
+                 <&scg1 IMX7ULP_CLK_APLL_PFD2>,
+                 <&scg1 IMX7ULP_CLK_APLL_PFD1>,
+                 <&scg1 IMX7ULP_CLK_APLL_PFD0>,
+                 <&scg1 IMX7ULP_CLK_UPLL>,
+                 <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>,
+                 <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>,
+                 <&scg1 IMX7ULP_CLK_ROSC>,
+                 <&scg1 IMX7ULP_CLK_SPLL_BUS_CLK>;
+         clock-names = "nic1_bus_clk", "nic1_clk", "ddr_clk",
+                       "apll_pfd2", "apll_pfd1", "apll_pfd0",
+                       "upll", "sosc_bus_clk", "firc_bus_clk",
+                       "rosc", "spll_bus_clk";
+    };
+
+    mmc@40380000 {
+        compatible = "fsl,imx7ulp-usdhc";
+        reg = <0x40380000 0x10000>;
+        interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
+                 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
+                 <&pcc2 IMX7ULP_CLK_USDHC1>;
+        clock-names ="ipg", "ahb", "per";
+        bus-width = <4>;
+    };
diff --git a/Documentation/devicetree/bindings/clock/imx7ulp-scg-clock.yaml b/Documentation/devicetree/bindings/clock/imx7ulp-scg-clock.yaml
new file mode 100644
index 0000000..ee8efb4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx7ulp-scg-clock.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx7ulp-scg-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock bindings for Freescale i.MX7ULP System Clock Generation (SCG) modules
+
+maintainers:
+  - A.s. Dong <aisheng.dong@nxp.com>
+
+description: |
+  i.MX7ULP Clock functions are under joint control of the System
+  Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
+  modules, and Core Mode Controller (CMC)1 blocks
+
+  The clocking scheme provides clear separation between M4 domain
+  and A7 domain. Except for a few clock sources shared between two
+  domains, such as the System Oscillator clock, the Slow IRC (SIRC),
+  and and the Fast IRC clock (FIRCLK), clock sources and clock
+  management are separated and contained within each domain.
+
+  M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
+  A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
+
+  Note: this binding doc is only for A7 clock domain.
+
+  The System Clock Generation (SCG) is responsible for clock generation
+  and distribution across this device. Functions performed by the SCG
+  include: clock reference selection, generation of clock used to derive
+  processor, system, peripheral bus and external memory interface clocks,
+  source selection for peripheral clocks and control of power saving
+  clock gating mode.
+
+  The clock consumer should specify the desired clock by having the clock
+  ID in its "clocks" phandle cell.
+  See include/dt-bindings/clock/imx7ulp-clock.h for the full list of
+  i.MX7ULP clock IDs of each module.
+
+properties:
+  compatible:
+    const: fsl,imx7ulp-scg1
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  clocks:
+    items:
+      - description: rtc osc
+      - description: system osc
+      - description: slow internal reference clock
+      - description: fast internal reference clock
+      - description: usb PLL
+
+  clock-names:
+    items:
+      - const: rosc
+      - const: sosc
+      - const: sirc
+      - const: firc
+      - const: upll
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx7ulp-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    clock-controller@403e0000 {
+        compatible = "fsl,imx7ulp-scg1";
+        reg = <0x403e0000 0x10000>;
+        clocks = <&rosc>, <&sosc>, <&sirc>,
+                 <&firc>, <&upll>;
+        clock-names = "rosc", "sosc", "sirc",
+                      "firc", "upll";
+        #clock-cells = <1>;
+    };
+
+    mmc@40380000 {
+        compatible = "fsl,imx7ulp-usdhc";
+        reg = <0x40380000 0x10000>;
+        interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
+                 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
+                 <&pcc2 IMX7ULP_CLK_USDHC1>;
+        clock-names ="ipg", "ahb", "per";
+        bus-width = <4>;
+    };
-- 
2.7.4

