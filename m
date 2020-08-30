Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9ADC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 18:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B1CF20757
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 18:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q/eIRZ5p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IcjQmbQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgH3SEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 14:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgH3SED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 14:04:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13323C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 11:04:02 -0700 (PDT)
Date:   Sun, 30 Aug 2020 18:03:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598810641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=94NT7/rse/Juf2wKp/zwKTM1ExELmsTLuDAmnUh2VVI=;
        b=q/eIRZ5pTQ8mCRfaPxeMiS9Z6AiNuab3G+RuZ9uzsXWV9o4D5zbRVyxrPhWonikZITTuBZ
        tm3tZGD8b26hscHBFCzMSv4VSsZ2hii/opl9gDABsPAz0adJhvJWQW4KUcdpgblYZ6/VEr
        ABrrIb8fL8laPoILnT+Pp/Vr0QYDSYXpXMB2JCrYEgnGu/v0aIdhrAviGD9gFf+IpezWZA
        ArtDuyuDzZ1Ru8ggJ/hpxY/PqIv/W3Xa/COYpRijJVFv9PV5qk3/T0DvO+cYrYo9RVTHhl
        Y2eG7Y2WeWEopZwBSpuFmHh12L7LrYe/QX6Dp9iKtYe/Wzy/ibrbzT7gs9i6jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598810641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=94NT7/rse/Juf2wKp/zwKTM1ExELmsTLuDAmnUh2VVI=;
        b=IcjQmbQg+mmVm/SP7X/nJeMAOoUmVej7M1u+T9fYxj+iSVFnmwDKVpBzL4RYTAaiBzLki4
        EXFjzZU18pyN9lAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v5.9-rc2
Message-ID: <159881061564.27993.11909051048930389391.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-08-30

up to:  ceb2465c5119: Merge tag 'irqchip-fixes-5.9-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

A set of fixes for interrupt chip drivers:

 - Revert the platform driver conversion of interrupt chip drivers as it
   turned out to create more problems than it solves.

 - Fix a trivial typo in the new module helpers which made probing reliably
   fail.

 - Small fixes in the STM32 and MIPS Ingenic drivers

 - The TI firmware rework which had badly managed dependencies and had to
   wait post rc1.

Thanks,

	tglx

------------------>
Lokesh Vutla (13):
      firmware: ti_sci: Drop the device id to resource type translation
      firmware: ti_sci: Drop unused structure ti_sci_rm_type_map
      firmware: ti_sci: Add support for getting resource with subtype
      dt-bindings: irqchip: ti, sci-intr: Update bindings to drop the usage of gic as parent
      dt-bindings: irqchip: Convert ti, sci-intr bindings to yaml
      irqchip/ti-sci-intr: Add support for INTR being a parent to INTR
      dt-bindings: irqchip: ti, sci-inta: Update docs to support different parent.
      dt-bindings: irqchip: Convert ti, sci-inta bindings to yaml
      irqchip/ti-sci-inta: Do not store TISCI device id in platform device id field
      irqchip/ti-sci-inta: Add support for INTA directly connecting to GIC
      arm64: dts: k3-j721e: ti-sci-inta/intr: Update to latest bindings
      arm64: dts: k3-am65: ti-sci-inta/intr: Update to latest bindings
      arm64: dts: k3-am65: Update the RM resource types

Marc Zyngier (2):
      irqchip: Fix probing deferal when using IRQCHIP_PLATFORM_DRIVER helpers
      irqchip: Revert modular support for drivers using IRQCHIP_PLATFORM_DRIVER helperse

Paul Cercueil (1):
      irqchip/ingenic: Leave parent IRQ unmasked on suspend

qiuguorui1 (1):
      irqchip/stm32-exti: Avoid losing interrupts due to clearing pending bits by mistake


 .../bindings/interrupt-controller/ti,sci-inta.txt  |  66 ---------
 .../bindings/interrupt-controller/ti,sci-inta.yaml |  98 +++++++++++++
 .../bindings/interrupt-controller/ti,sci-intr.txt  |  82 -----------
 .../bindings/interrupt-controller/ti,sci-intr.yaml | 102 ++++++++++++++
 MAINTAINERS                                        |   4 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |  36 +++--
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            |  12 +-
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi         |   8 +-
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     |   4 +-
 .../boot/dts/ti/k3-j721e-common-proc-board.dts     |  10 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |  43 +++---
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi    |  12 +-
 drivers/firmware/ti_sci.c                          | 155 +++++++++------------
 drivers/irqchip/Kconfig                            |   2 +-
 drivers/irqchip/irq-ingenic.c                      |   2 +-
 drivers/irqchip/irq-mtk-cirq.c                     |   4 +-
 drivers/irqchip/irq-mtk-sysirq.c                   |   4 +-
 drivers/irqchip/irq-stm32-exti.c                   |  14 +-
 drivers/irqchip/irq-ti-sci-inta.c                  |  95 ++++++++++---
 drivers/irqchip/irq-ti-sci-intr.c                  | 152 ++++++++++++--------
 drivers/irqchip/irqchip.c                          |   2 +-
 drivers/irqchip/qcom-pdc.c                         |   8 +-
 include/linux/soc/ti/ti_sci_protocol.h             |  13 ++
 23 files changed, 534 insertions(+), 394 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
deleted file mode 100644
index 7841cb099e13..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-Texas Instruments K3 Interrupt Aggregator
-=========================================
-
-The Interrupt Aggregator (INTA) provides a centralized machine
-which handles the termination of system events to that they can
-be coherently processed by the host(s) in the system. A maximum
-of 64 events can be mapped to a single interrupt.
-
-
-                              Interrupt Aggregator
-                     +-----------------------------------------+
-                     |      Intmap            VINT             |
-                     | +--------------+  +------------+        |
-            m ------>| | vint  | bit  |  | 0 |.....|63| vint0  |
-               .     | +--------------+  +------------+        |       +------+
-               .     |         .               .               |       | HOST |
-Globalevents  ------>|         .               .               |------>| IRQ  |
-               .     |         .               .               |       | CTRL |
-               .     |         .               .               |       +------+
-            n ------>| +--------------+  +------------+        |
-                     | | vint  | bit  |  | 0 |.....|63| vintx  |
-                     | +--------------+  +------------+        |
-                     |                                         |
-                     +-----------------------------------------+
-
-Configuration of these Intmap registers that maps global events to vint is done
-by a system controller (like the Device Memory and Security Controller on K3
-AM654 SoC). Driver should request the system controller to get the range
-of global events and vints assigned to the requesting host. Management
-of these requested resources should be handled by driver and requests
-system controller to map specific global event to vint, bit pair.
-
-Communication between the host processor running an OS and the system
-controller happens through a protocol called TI System Control Interface
-(TISCI protocol). For more details refer:
-Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
-
-TISCI Interrupt Aggregator Node:
--------------------------------
-- compatible:		Must be "ti,sci-inta".
-- reg:			Should contain registers location and length.
-- interrupt-controller:	Identifies the node as an interrupt controller
-- msi-controller:	Identifies the node as an MSI controller.
-- interrupt-parent:	phandle of irq parent.
-- ti,sci:		Phandle to TI-SCI compatible System controller node.
-- ti,sci-dev-id:	TISCI device ID of the Interrupt Aggregator.
-- ti,sci-rm-range-vint:	Array of TISCI subtype ids representing vints(inta
-			outputs) range within this INTA, assigned to the
-			requesting host context.
-- ti,sci-rm-range-global-event:	Array of TISCI subtype ids representing the
-			global events range reaching this IA and are assigned
-			to the requesting host context.
-
-Example:
---------
-main_udmass_inta: interrupt-controller@33d00000 {
-	compatible = "ti,sci-inta";
-	reg = <0x0 0x33d00000 0x0 0x100000>;
-	interrupt-controller;
-	msi-controller;
-	interrupt-parent = <&main_navss_intr>;
-	ti,sci = <&dmsc>;
-	ti,sci-dev-id = <179>;
-	ti,sci-rm-range-vint = <0x0>;
-	ti,sci-rm-range-global-event = <0x1>;
-};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
new file mode 100644
index 000000000000..c7cd05656a3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/ti,sci-inta.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments K3 Interrupt Aggregator
+
+maintainers:
+  - Lokesh Vutla <lokeshvutla@ti.com>
+
+allOf:
+  - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
+
+description: |
+  The Interrupt Aggregator (INTA) provides a centralized machine
+  which handles the termination of system events to that they can
+  be coherently processed by the host(s) in the system. A maximum
+  of 64 events can be mapped to a single interrupt.
+
+                                Interrupt Aggregator
+                       +-----------------------------------------+
+                       |      Intmap            VINT             |
+                       | +--------------+  +------------+        |
+              m ------>| | vint  | bit  |  | 0 |.....|63| vint0  |
+                 .     | +--------------+  +------------+        |      +------+
+                 .     |         .               .               |      | HOST |
+  Globalevents  ------>|         .               .               |----->| IRQ  |
+                 .     |         .               .               |      | CTRL |
+                 .     |         .               .               |      +------+
+              n ------>| +--------------+  +------------+        |
+                       | | vint  | bit  |  | 0 |.....|63| vintx  |
+                       | +--------------+  +------------+        |
+                       |                                         |
+                       +-----------------------------------------+
+
+  Configuration of these Intmap registers that maps global events to vint is
+  done by a system controller (like the Device Memory and Security Controller
+  on AM654 SoC). Driver should request the system controller to get the range
+  of global events and vints assigned to the requesting host. Management
+  of these requested resources should be handled by driver and requests
+  system controller to map specific global event to vint, bit pair.
+
+  Communication between the host processor running an OS and the system
+  controller happens through a protocol called TI System Control Interface
+  (TISCI protocol).
+
+properties:
+  compatible:
+    const: ti,sci-inta
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  msi-controller: true
+
+  ti,interrupt-ranges:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description: |
+      Interrupt ranges that converts the INTA output hw irq numbers
+      to parents's input interrupt numbers.
+    items:
+      items:
+        - description: |
+            "output_irq" specifies the base for inta output irq
+        - description: |
+            "parent's input irq" specifies the base for parent irq
+        - description: |
+            "limit" specifies the limit for translation
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - msi-controller
+  - ti,sci
+  - ti,sci-dev-id
+  - ti,interrupt-ranges
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        main_udmass_inta: msi-controller@33d00000 {
+            compatible = "ti,sci-inta";
+            reg = <0x0 0x33d00000 0x0 0x100000>;
+            interrupt-controller;
+            msi-controller;
+            interrupt-parent = <&main_navss_intr>;
+            ti,sci = <&dmsc>;
+            ti,sci-dev-id = <179>;
+            ti,interrupt-ranges = <0 0 256>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
deleted file mode 100644
index 178fca08278f..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
+++ /dev/null
@@ -1,82 +0,0 @@
-Texas Instruments K3 Interrupt Router
-=====================================
-
-The Interrupt Router (INTR) module provides a mechanism to mux M
-interrupt inputs to N interrupt outputs, where all M inputs are selectable
-to be driven per N output. An Interrupt Router can either handle edge triggered
-or level triggered interrupts and that is fixed in hardware.
-
-                                 Interrupt Router
-                             +----------------------+
-                             |  Inputs     Outputs  |
-        +-------+            | +------+    +-----+  |
-        | GPIO  |----------->| | irq0 |    |  0  |  |       Host IRQ
-        +-------+            | +------+    +-----+  |      controller
-                             |    .           .     |      +-------+
-        +-------+            |    .           .     |----->|  IRQ  |
-        | INTA  |----------->|    .           .     |      +-------+
-        +-------+            |    .        +-----+  |
-                             | +------+    |  N  |  |
-                             | | irqM |    +-----+  |
-                             | +------+             |
-                             |                      |
-                             +----------------------+
-
-There is one register per output (MUXCNTL_N) that controls the selection.
-Configuration of these MUXCNTL_N registers is done by a system controller
-(like the Device Memory and Security Controller on K3 AM654 SoC). System
-controller will keep track of the used and unused registers within the Router.
-Driver should request the system controller to get the range of GIC IRQs
-assigned to the requesting hosts. It is the drivers responsibility to keep
-track of Host IRQs.
-
-Communication between the host processor running an OS and the system
-controller happens through a protocol called TI System Control Interface
-(TISCI protocol). For more details refer:
-Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
-
-TISCI Interrupt Router Node:
-----------------------------
-Required Properties:
-- compatible:		Must be "ti,sci-intr".
-- ti,intr-trigger-type:	Should be one of the following:
-			1: If intr supports edge triggered interrupts.
-			4: If intr supports level triggered interrupts.
-- interrupt-controller:	Identifies the node as an interrupt controller
-- #interrupt-cells:	Specifies the number of cells needed to encode an
-			interrupt source. The value should be 2.
-			First cell should contain the TISCI device ID of source
-			Second cell should contain the interrupt source offset
-			within the device.
-- ti,sci:		Phandle to TI-SCI compatible System controller node.
-- ti,sci-dst-id:	TISCI device ID of the destination IRQ controller.
-- ti,sci-rm-range-girq:	Array of TISCI subtype ids representing the host irqs
-			assigned to this interrupt router. Each subtype id
-			corresponds to a range of host irqs.
-
-For more details on TISCI IRQ resource management refer:
-https://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/rm/rm_irq.html
-
-Example:
---------
-The following example demonstrates both interrupt router node and the consumer
-node(main gpio) on the AM654 SoC:
-
-main_intr: interrupt-controller0 {
-	compatible = "ti,sci-intr";
-	ti,intr-trigger-type = <1>;
-	interrupt-controller;
-	interrupt-parent = <&gic500>;
-	#interrupt-cells = <2>;
-	ti,sci = <&dmsc>;
-	ti,sci-dst-id = <56>;
-	ti,sci-rm-range-girq = <0x1>;
-};
-
-main_gpio0: gpio@600000 {
-	...
-	interrupt-parent = <&main_intr>;
-	interrupts = <57 256>, <57 257>, <57 258>,
-		     <57 259>, <57 260>, <57 261>;
-	...
-};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
new file mode 100644
index 000000000000..cff6a956afb4
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/ti,sci-intr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments K3 Interrupt Router
+
+maintainers:
+  - Lokesh Vutla <lokeshvutla@ti.com>
+
+allOf:
+  - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
+
+description: |
+  The Interrupt Router (INTR) module provides a mechanism to mux M
+  interrupt inputs to N interrupt outputs, where all M inputs are selectable
+  to be driven per N output. An Interrupt Router can either handle edge
+  triggered or level triggered interrupts and that is fixed in hardware.
+
+                                   Interrupt Router
+                               +----------------------+
+                               |  Inputs     Outputs  |
+          +-------+            | +------+    +-----+  |
+          | GPIO  |----------->| | irq0 |    |  0  |  |       Host IRQ
+          +-------+            | +------+    +-----+  |      controller
+                               |    .           .     |      +-------+
+          +-------+            |    .           .     |----->|  IRQ  |
+          | INTA  |----------->|    .           .     |      +-------+
+          +-------+            |    .        +-----+  |
+                               | +------+    |  N  |  |
+                               | | irqM |    +-----+  |
+                               | +------+             |
+                               |                      |
+                               +----------------------+
+
+  There is one register per output (MUXCNTL_N) that controls the selection.
+  Configuration of these MUXCNTL_N registers is done by a system controller
+  (like the Device Memory and Security Controller on K3 AM654 SoC). System
+  controller will keep track of the used and unused registers within the Router.
+  Driver should request the system controller to get the range of GIC IRQs
+  assigned to the requesting hosts. It is the drivers responsibility to keep
+  track of Host IRQs.
+
+  Communication between the host processor running an OS and the system
+  controller happens through a protocol called TI System Control Interface
+  (TISCI protocol).
+
+properties:
+  compatible:
+    const: ti,sci-intr
+
+  ti,intr-trigger-type:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 4]
+    description: |
+      Should be one of the following.
+        1 = If intr supports edge triggered interrupts.
+        4 = If intr supports level triggered interrupts.
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 1
+    description: |
+      The 1st cell should contain interrupt router input hw number.
+
+  ti,interrupt-ranges:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description: |
+      Interrupt ranges that converts the INTR output hw irq numbers
+      to parents's input interrupt numbers.
+    items:
+      items:
+        - description: |
+            "output_irq" specifies the base for intr output irq
+        - description: |
+            "parent's input irq" specifies the base for parent irq
+        - description: |
+            "limit" specifies the limit for translation
+
+required:
+  - compatible
+  - ti,intr-trigger-type
+  - interrupt-controller
+  - '#interrupt-cells'
+  - ti,sci
+  - ti,sci-dev-id
+  - ti,interrupt-ranges
+
+examples:
+  - |
+    main_gpio_intr: interrupt-controller0 {
+        compatible = "ti,sci-intr";
+        ti,intr-trigger-type = <1>;
+        interrupt-controller;
+        interrupt-parent = <&gic500>;
+        #interrupt-cells = <1>;
+        ti,sci = <&dmsc>;
+        ti,sci-dev-id = <131>;
+        ti,interrupt-ranges = <0 360 32>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..e3f1cdb69c84 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17116,8 +17116,8 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml
 F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
 F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
-F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
-F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
 F:	Documentation/devicetree/bindings/reset/ti,sci-reset.txt
 F:	Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 F:	drivers/clk/keystone/sci-clk.c
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 9edfae5944f7..24ef18fe77df 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -417,10 +417,10 @@
 		ti,intr-trigger-type = <1>;
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
-		#interrupt-cells = <2>;
+		#interrupt-cells = <1>;
 		ti,sci = <&dmsc>;
-		ti,sci-dst-id = <56>;
-		ti,sci-rm-range-girq = <0x1>;
+		ti,sci-dev-id = <100>;
+		ti,interrupt-ranges = <0 392 32>;
 	};
 
 	main_navss {
@@ -438,10 +438,11 @@
 			ti,intr-trigger-type = <4>;
 			interrupt-controller;
 			interrupt-parent = <&gic500>;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <1>;
 			ti,sci = <&dmsc>;
-			ti,sci-dst-id = <56>;
-			ti,sci-rm-range-girq = <0x0>, <0x2>;
+			ti,sci-dev-id = <182>;
+			ti,interrupt-ranges = <0 64 64>,
+					      <64 448 64>;
 		};
 
 		inta_main_udmass: interrupt-controller@33d00000 {
@@ -452,8 +453,7 @@
 			msi-controller;
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <179>;
-			ti,sci-rm-range-vint = <0x0>;
-			ti,sci-rm-range-global-event = <0x1>;
+			ti,interrupt-ranges = <0 0 256>;
 		};
 
 		secure_proxy_main: mailbox@32c00000 {
@@ -589,7 +589,7 @@
 				<0x0 0x33000000 0x0 0x40000>;
 			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
 			ti,num-rings = <818>;
-			ti,sci-rm-range-gp-rings = <0x2>; /* GP ring range */
+			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
 			ti,dma-ring-reset-quirk;
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <187>;
@@ -609,11 +609,11 @@
 			ti,sci-dev-id = <188>;
 			ti,ringacc = <&ringacc>;
 
-			ti,sci-rm-range-tchan = <0x1>, /* TX_HCHAN */
-						<0x2>; /* TX_CHAN */
-			ti,sci-rm-range-rchan = <0x4>, /* RX_HCHAN */
-						<0x5>; /* RX_CHAN */
-			ti,sci-rm-range-rflow = <0x6>; /* GP RFLOW */
+			ti,sci-rm-range-tchan = <0xf>, /* TX_HCHAN */
+						<0xd>; /* TX_CHAN */
+			ti,sci-rm-range-rchan = <0xb>, /* RX_HCHAN */
+						<0xa>; /* RX_CHAN */
+			ti,sci-rm-range-rflow = <0x0>; /* GP RFLOW */
 		};
 
 		cpts@310d0000 {
@@ -622,7 +622,7 @@
 			reg-names = "cpts";
 			clocks = <&main_cpts_mux>;
 			clock-names = "cpts";
-			interrupts-extended = <&intr_main_navss 163 0>;
+			interrupts-extended = <&intr_main_navss 391>;
 			interrupt-names = "cpts";
 			ti,cpts-periodic-outputs = <6>;
 			ti,cpts-ext-ts-inputs = <8>;
@@ -645,8 +645,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&intr_main_gpio>;
-		interrupts = <57 256>, <57 257>, <57 258>, <57 259>, <57 260>,
-				<57 261>;
+		interrupts = <192>, <193>, <194>, <195>, <196>, <197>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <96>;
@@ -661,8 +660,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&intr_main_gpio>;
-		interrupts = <58 256>, <58 257>, <58 258>, <58 259>, <58 260>,
-				<58 261>;
+		interrupts = <200>, <201>, <202>, <203>, <204>, <205>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <90>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 8c1abcfe0860..51ca4b4d4c21 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -134,7 +134,7 @@
 				<0x0 0x2a500000 0x0 0x40000>;
 			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
 			ti,num-rings = <286>;
-			ti,sci-rm-range-gp-rings = <0x2>; /* GP ring range */
+			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
 			ti,dma-ring-reset-quirk;
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <195>;
@@ -154,11 +154,11 @@
 			ti,sci-dev-id = <194>;
 			ti,ringacc = <&mcu_ringacc>;
 
-			ti,sci-rm-range-tchan = <0x1>, /* TX_HCHAN */
-						<0x2>; /* TX_CHAN */
-			ti,sci-rm-range-rchan = <0x3>, /* RX_HCHAN */
-						<0x4>; /* RX_CHAN */
-			ti,sci-rm-range-rflow = <0x5>; /* GP RFLOW */
+			ti,sci-rm-range-tchan = <0xf>, /* TX_HCHAN */
+						<0xd>; /* TX_CHAN */
+			ti,sci-rm-range-rchan = <0xb>, /* RX_HCHAN */
+						<0xa>; /* RX_CHAN */
+			ti,sci-rm-range-rflow = <0x0>; /* GP RFLOW */
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index 5f55b9e82cf1..a1ffe88d9664 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -74,10 +74,10 @@
 		ti,intr-trigger-type = <1>;
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
-		#interrupt-cells = <2>;
+		#interrupt-cells = <1>;
 		ti,sci = <&dmsc>;
-		ti,sci-dst-id = <56>;
-		ti,sci-rm-range-girq = <0x4>;
+		ti,sci-dev-id = <156>;
+		ti,interrupt-ranges = <0 712 16>;
 	};
 
 	wkup_gpio0: wkup_gpio0@42110000 {
@@ -86,7 +86,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&intr_wkup_gpio>;
-		interrupts = <59 128>, <59 129>, <59 130>, <59 131>;
+		interrupts = <60>, <61>, <62>, <63>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <56>;
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 611e66207010..b8a8a0fcb8af 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -384,7 +384,7 @@
 };
 
 &mailbox0_cluster0 {
-	interrupts = <164 0>;
+	interrupts = <436>;
 
 	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
 		ti,mbox-tx = <1 0 0>;
@@ -393,7 +393,7 @@
 };
 
 &mailbox0_cluster1 {
-	interrupts = <165 0>;
+	interrupts = <432>;
 
 	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
 		ti,mbox-tx = <1 0 0>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 8bc1e6ecc50e..e8fc01d97ada 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -287,7 +287,7 @@
 };
 
 &mailbox0_cluster0 {
-	interrupts = <214 0>;
+	interrupts = <436>;
 
 	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
 		ti,mbox-rx = <0 0 0>;
@@ -301,7 +301,7 @@
 };
 
 &mailbox0_cluster1 {
-	interrupts = <215 0>;
+	interrupts = <432>;
 
 	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
 		ti,mbox-rx = <0 0 0>;
@@ -315,7 +315,7 @@
 };
 
 &mailbox0_cluster2 {
-	interrupts = <216 0>;
+	interrupts = <428>;
 
 	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
 		ti,mbox-rx = <0 0 0>;
@@ -329,7 +329,7 @@
 };
 
 &mailbox0_cluster3 {
-	interrupts = <217 0>;
+	interrupts = <424>;
 
 	mbox_c66_0: mbox-c66-0 {
 		ti,mbox-rx = <0 0 0>;
@@ -343,7 +343,7 @@
 };
 
 &mailbox0_cluster4 {
-	interrupts = <218 0>;
+	interrupts = <420>;
 
 	mbox_c71_0: mbox-c71-0 {
 		ti,mbox-rx = <0 0 0>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index d14060207f00..12ceea9b3c9a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -80,10 +80,10 @@
 		ti,intr-trigger-type = <1>;
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
-		#interrupt-cells = <2>;
+		#interrupt-cells = <1>;
 		ti,sci = <&dmsc>;
-		ti,sci-dst-id = <14>;
-		ti,sci-rm-range-girq = <0x1>;
+		ti,sci-dev-id = <131>;
+		ti,interrupt-ranges = <8 392 56>;
 	};
 
 	main_navss {
@@ -101,10 +101,12 @@
 			ti,intr-trigger-type = <4>;
 			interrupt-controller;
 			interrupt-parent = <&gic500>;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <1>;
 			ti,sci = <&dmsc>;
-			ti,sci-dst-id = <14>;
-			ti,sci-rm-range-girq = <0>, <2>;
+			ti,sci-dev-id = <213>;
+			ti,interrupt-ranges = <0 64 64>,
+					      <64 448 64>,
+					      <128 672 64>;
 		};
 
 		main_udmass_inta: interrupt-controller@33d00000 {
@@ -115,8 +117,7 @@
 			msi-controller;
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <209>;
-			ti,sci-rm-range-vint = <0xa>;
-			ti,sci-rm-range-global-event = <0xd>;
+			ti,interrupt-ranges = <0 0 256>;
 		};
 
 		secure_proxy_main: mailbox@32c00000 {
@@ -296,7 +297,7 @@
 			reg-names = "cpts";
 			clocks = <&k3_clks 201 1>;
 			clock-names = "cpts";
-			interrupts-extended = <&main_navss_intr 201 0>;
+			interrupts-extended = <&main_navss_intr 391>;
 			interrupt-names = "cpts";
 			ti,cpts-periodic-outputs = <6>;
 			ti,cpts-ext-ts-inputs = <8>;
@@ -688,8 +689,8 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&main_gpio_intr>;
-		interrupts = <105 0>, <105 1>, <105 2>, <105 3>,
-			     <105 4>, <105 5>, <105 6>, <105 7>;
+		interrupts = <256>, <257>, <258>, <259>,
+			     <260>, <261>, <262>, <263>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <128>;
@@ -705,7 +706,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&main_gpio_intr>;
-		interrupts = <106 0>, <106 1>, <106 2>;
+		interrupts = <288>, <289>, <290>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <36>;
@@ -721,8 +722,8 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&main_gpio_intr>;
-		interrupts = <107 0>, <107 1>, <107 2>, <107 3>,
-			     <107 4>, <107 5>, <107 6>, <107 7>;
+		interrupts = <264>, <265>, <266>, <267>,
+			     <268>, <269>, <270>, <271>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <128>;
@@ -738,7 +739,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&main_gpio_intr>;
-		interrupts = <108 0>, <108 1>, <108 2>;
+		interrupts = <292>, <293>, <294>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <36>;
@@ -754,8 +755,8 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&main_gpio_intr>;
-		interrupts = <109 0>, <109 1>, <109 2>, <109 3>,
-			     <109 4>, <109 5>, <109 6>, <109 7>;
+		interrupts = <272>, <273>, <274>, <275>,
+			     <276>, <277>, <278>, <279>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <128>;
@@ -771,7 +772,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&main_gpio_intr>;
-		interrupts = <110 0>, <110 1>, <110 2>;
+		interrupts = <296>, <297>, <298>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <36>;
@@ -787,8 +788,8 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&main_gpio_intr>;
-		interrupts = <111 0>, <111 1>, <111 2>, <111 3>,
-			     <111 4>, <111 5>, <111 6>, <111 7>;
+		interrupts = <280>, <281>, <282>, <283>,
+			     <284>, <285>, <286>, <287>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <128>;
@@ -804,7 +805,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&main_gpio_intr>;
-		interrupts = <112 0>, <112 1>, <112 2>;
+		interrupts = <300>, <301>, <302>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <36>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 30a735bcd0c8..c4a48e8d420a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -101,10 +101,10 @@
 		ti,intr-trigger-type = <1>;
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
-		#interrupt-cells = <2>;
+		#interrupt-cells = <1>;
 		ti,sci = <&dmsc>;
-		ti,sci-dst-id = <14>;
-		ti,sci-rm-range-girq = <0x5>;
+		ti,sci-dev-id = <137>;
+		ti,interrupt-ranges = <16 960 16>;
 	};
 
 	wkup_gpio0: gpio@42110000 {
@@ -113,8 +113,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&wkup_gpio_intr>;
-		interrupts = <113 0>, <113 1>, <113 2>,
-			     <113 3>, <113 4>, <113 5>;
+		interrupts = <103>, <104>, <105>, <106>, <107>, <108>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <84>;
@@ -130,8 +129,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&wkup_gpio_intr>;
-		interrupts = <114 0>, <114 1>, <114 2>,
-			     <114 3>, <114 4>, <114 5>;
+		interrupts = <112>, <113>, <114>, <115>, <116>, <117>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <84>;
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 53cee17d0115..722af9ee53d6 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -64,22 +64,6 @@ struct ti_sci_xfers_info {
 	spinlock_t xfer_lock;
 };
 
-/**
- * struct ti_sci_rm_type_map - Structure representing TISCI Resource
- *				management representation of dev_ids.
- * @dev_id:	TISCI device ID
- * @type:	Corresponding id as identified by TISCI RM.
- *
- * Note: This is used only as a work around for using RM range apis
- *	for AM654 SoC. For future SoCs dev_id will be used as type
- *	for RM range APIs. In order to maintain ABI backward compatibility
- *	type is not being changed for AM654 SoC.
- */
-struct ti_sci_rm_type_map {
-	u32 dev_id;
-	u16 type;
-};
-
 /**
  * struct ti_sci_desc - Description of SoC integration
  * @default_host_id:	Host identifier representing the compute entity
@@ -87,14 +71,12 @@ struct ti_sci_rm_type_map {
  * @max_msgs: Maximum number of messages that can be pending
  *		  simultaneously in the system
  * @max_msg_size: Maximum size of data per message that can be handled.
- * @rm_type_map: RM resource type mapping structure.
  */
 struct ti_sci_desc {
 	u8 default_host_id;
 	int max_rx_timeout_ms;
 	int max_msgs;
 	int max_msg_size;
-	struct ti_sci_rm_type_map *rm_type_map;
 };
 
 /**
@@ -1710,33 +1692,6 @@ static int ti_sci_cmd_core_reboot(const struct ti_sci_handle *handle)
 	return ret;
 }
 
-static int ti_sci_get_resource_type(struct ti_sci_info *info, u16 dev_id,
-				    u16 *type)
-{
-	struct ti_sci_rm_type_map *rm_type_map = info->desc->rm_type_map;
-	bool found = false;
-	int i;
-
-	/* If map is not provided then assume dev_id is used as type */
-	if (!rm_type_map) {
-		*type = dev_id;
-		return 0;
-	}
-
-	for (i = 0; rm_type_map[i].dev_id; i++) {
-		if (rm_type_map[i].dev_id == dev_id) {
-			*type = rm_type_map[i].type;
-			found = true;
-			break;
-		}
-	}
-
-	if (!found)
-		return -EINVAL;
-
-	return 0;
-}
-
 /**
  * ti_sci_get_resource_range - Helper to get a range of resources assigned
  *			       to a host. Resource is uniquely identified by
@@ -1760,7 +1715,6 @@ static int ti_sci_get_resource_range(const struct ti_sci_handle *handle,
 	struct ti_sci_xfer *xfer;
 	struct ti_sci_info *info;
 	struct device *dev;
-	u16 type;
 	int ret = 0;
 
 	if (IS_ERR(handle))
@@ -1780,15 +1734,9 @@ static int ti_sci_get_resource_range(const struct ti_sci_handle *handle,
 		return ret;
 	}
 
-	ret = ti_sci_get_resource_type(info, dev_id, &type);
-	if (ret) {
-		dev_err(dev, "rm type lookup failed for %u\n", dev_id);
-		goto fail;
-	}
-
 	req = (struct ti_sci_msg_req_get_resource_range *)xfer->xfer_buf;
 	req->secondary_host = s_host;
-	req->type = type & MSG_RM_RESOURCE_TYPE_MASK;
+	req->type = dev_id & MSG_RM_RESOURCE_TYPE_MASK;
 	req->subtype = subtype & MSG_RM_RESOURCE_SUBTYPE_MASK;
 
 	ret = ti_sci_do_xfer(info, xfer);
@@ -3260,61 +3208,50 @@ u32 ti_sci_get_num_resources(struct ti_sci_resource *res)
 EXPORT_SYMBOL_GPL(ti_sci_get_num_resources);
 
 /**
- * devm_ti_sci_get_of_resource() - Get a TISCI resource assigned to a device
+ * devm_ti_sci_get_resource_sets() - Get a TISCI resources assigned to a device
  * @handle:	TISCI handle
  * @dev:	Device pointer to which the resource is assigned
  * @dev_id:	TISCI device id to which the resource is assigned
- * @of_prop:	property name by which the resource are represented
+ * @sub_types:	Array of sub_types assigned corresponding to device
+ * @sets:	Number of sub_types
  *
  * Return: Pointer to ti_sci_resource if all went well else appropriate
  *	   error pointer.
  */
-struct ti_sci_resource *
-devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
-			    struct device *dev, u32 dev_id, char *of_prop)
+static struct ti_sci_resource *
+devm_ti_sci_get_resource_sets(const struct ti_sci_handle *handle,
+			      struct device *dev, u32 dev_id, u32 *sub_types,
+			      u32 sets)
 {
 	struct ti_sci_resource *res;
 	bool valid_set = false;
-	u32 resource_subtype;
 	int i, ret;
 
 	res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
 	if (!res)
 		return ERR_PTR(-ENOMEM);
 
-	ret = of_property_count_elems_of_size(dev_of_node(dev), of_prop,
-					      sizeof(u32));
-	if (ret < 0) {
-		dev_err(dev, "%s resource type ids not available\n", of_prop);
-		return ERR_PTR(ret);
-	}
-	res->sets = ret;
-
+	res->sets = sets;
 	res->desc = devm_kcalloc(dev, res->sets, sizeof(*res->desc),
 				 GFP_KERNEL);
 	if (!res->desc)
 		return ERR_PTR(-ENOMEM);
 
 	for (i = 0; i < res->sets; i++) {
-		ret = of_property_read_u32_index(dev_of_node(dev), of_prop, i,
-						 &resource_subtype);
-		if (ret)
-			return ERR_PTR(-EINVAL);
-
 		ret = handle->ops.rm_core_ops.get_range(handle, dev_id,
-							resource_subtype,
+							sub_types[i],
 							&res->desc[i].start,
 							&res->desc[i].num);
 		if (ret) {
 			dev_dbg(dev, "dev = %d subtype %d not allocated for this host\n",
-				dev_id, resource_subtype);
+				dev_id, sub_types[i]);
 			res->desc[i].start = 0;
 			res->desc[i].num = 0;
 			continue;
 		}
 
 		dev_dbg(dev, "dev = %d, subtype = %d, start = %d, num = %d\n",
-			dev_id, resource_subtype, res->desc[i].start,
+			dev_id, sub_types[i], res->desc[i].start,
 			res->desc[i].num);
 
 		valid_set = true;
@@ -3332,6 +3269,62 @@ devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
 	return ERR_PTR(-EINVAL);
 }
 
+/**
+ * devm_ti_sci_get_of_resource() - Get a TISCI resource assigned to a device
+ * @handle:	TISCI handle
+ * @dev:	Device pointer to which the resource is assigned
+ * @dev_id:	TISCI device id to which the resource is assigned
+ * @of_prop:	property name by which the resource are represented
+ *
+ * Return: Pointer to ti_sci_resource if all went well else appropriate
+ *	   error pointer.
+ */
+struct ti_sci_resource *
+devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
+			    struct device *dev, u32 dev_id, char *of_prop)
+{
+	struct ti_sci_resource *res;
+	u32 *sub_types;
+	int sets;
+
+	sets = of_property_count_elems_of_size(dev_of_node(dev), of_prop,
+					       sizeof(u32));
+	if (sets < 0) {
+		dev_err(dev, "%s resource type ids not available\n", of_prop);
+		return ERR_PTR(sets);
+	}
+
+	sub_types = kcalloc(sets, sizeof(*sub_types), GFP_KERNEL);
+	if (!sub_types)
+		return ERR_PTR(-ENOMEM);
+
+	of_property_read_u32_array(dev_of_node(dev), of_prop, sub_types, sets);
+	res = devm_ti_sci_get_resource_sets(handle, dev, dev_id, sub_types,
+					    sets);
+
+	kfree(sub_types);
+	return res;
+}
+EXPORT_SYMBOL_GPL(devm_ti_sci_get_of_resource);
+
+/**
+ * devm_ti_sci_get_resource() - Get a resource range assigned to the device
+ * @handle:	TISCI handle
+ * @dev:	Device pointer to which the resource is assigned
+ * @dev_id:	TISCI device id to which the resource is assigned
+ * @suub_type:	TISCI resource subytpe representing the resource.
+ *
+ * Return: Pointer to ti_sci_resource if all went well else appropriate
+ *	   error pointer.
+ */
+struct ti_sci_resource *
+devm_ti_sci_get_resource(const struct ti_sci_handle *handle, struct device *dev,
+			 u32 dev_id, u32 sub_type)
+{
+	return devm_ti_sci_get_resource_sets(handle, dev, dev_id, &sub_type, 1);
+}
+EXPORT_SYMBOL_GPL(devm_ti_sci_get_resource);
+
 static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
 				void *cmd)
 {
@@ -3352,17 +3345,6 @@ static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	/* Limited by MBOX_TX_QUEUE_LEN. K2G can handle upto 128 messages! */
 	.max_msgs = 20,
 	.max_msg_size = 64,
-	.rm_type_map = NULL,
-};
-
-static struct ti_sci_rm_type_map ti_sci_am654_rm_type_map[] = {
-	{.dev_id = 56, .type = 0x00b}, /* GIC_IRQ */
-	{.dev_id = 179, .type = 0x000}, /* MAIN_NAV_UDMASS_IA0 */
-	{.dev_id = 187, .type = 0x009}, /* MAIN_NAV_RA */
-	{.dev_id = 188, .type = 0x006}, /* MAIN_NAV_UDMAP */
-	{.dev_id = 194, .type = 0x007}, /* MCU_NAV_UDMAP */
-	{.dev_id = 195, .type = 0x00a}, /* MCU_NAV_RA */
-	{.dev_id = 0, .type = 0x000}, /* end of table */
 };
 
 /* Description for AM654 */
@@ -3373,7 +3355,6 @@ static const struct ti_sci_desc ti_sci_pmmc_am654_desc = {
 	/* Limited by MBOX_TX_QUEUE_LEN. K2G can handle upto 128 messages! */
 	.max_msgs = 20,
 	.max_msg_size = 60,
-	.rm_type_map = ti_sci_am654_rm_type_map,
 };
 
 static const struct of_device_id ti_sci_of_match[] = {
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index bb70b7177f94..bfc9719dbcdc 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -425,7 +425,7 @@ config GOLDFISH_PIC
          for Goldfish based virtual platforms.
 
 config QCOM_PDC
-	tristate "QCOM PDC"
+	bool "QCOM PDC"
 	depends on ARCH_QCOM
 	select IRQ_DOMAIN_HIERARCHY
 	help
diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index 9f3da4260ca6..b61a8901ef72 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -125,7 +125,7 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 		irq_reg_writel(gc, IRQ_MSK(32), JZ_REG_INTC_SET_MASK);
 	}
 
-	if (request_irq(parent_irq, intc_cascade, 0,
+	if (request_irq(parent_irq, intc_cascade, IRQF_NO_SUSPEND,
 			"SoC intc cascade interrupt", NULL))
 		pr_err("Failed to register SoC intc cascade interrupt\n");
 	return 0;
diff --git a/drivers/irqchip/irq-mtk-cirq.c b/drivers/irqchip/irq-mtk-cirq.c
index 62a61275aaa3..69ba8ce3c178 100644
--- a/drivers/irqchip/irq-mtk-cirq.c
+++ b/drivers/irqchip/irq-mtk-cirq.c
@@ -295,6 +295,4 @@ static int __init mtk_cirq_of_init(struct device_node *node,
 	return ret;
 }
 
-IRQCHIP_PLATFORM_DRIVER_BEGIN(mtk_cirq)
-IRQCHIP_MATCH("mediatek,mtk-cirq", mtk_cirq_of_init)
-IRQCHIP_PLATFORM_DRIVER_END(mtk_cirq)
+IRQCHIP_DECLARE(mtk_cirq, "mediatek,mtk-cirq", mtk_cirq_of_init);
diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
index 7299c5ab4d10..6ff98b87e5c0 100644
--- a/drivers/irqchip/irq-mtk-sysirq.c
+++ b/drivers/irqchip/irq-mtk-sysirq.c
@@ -231,6 +231,4 @@ static int __init mtk_sysirq_of_init(struct device_node *node,
 	kfree(chip_data);
 	return ret;
 }
-IRQCHIP_PLATFORM_DRIVER_BEGIN(mtk_sysirq)
-IRQCHIP_MATCH("mediatek,mt6577-sysirq", mtk_sysirq_of_init)
-IRQCHIP_PLATFORM_DRIVER_END(mtk_sysirq)
+IRQCHIP_DECLARE(mtk_sysirq, "mediatek,mt6577-sysirq", mtk_sysirq_of_init);
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 03a36be757d8..0c2c61db26b4 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -416,6 +416,16 @@ static void stm32_irq_ack(struct irq_data *d)
 	irq_gc_unlock(gc);
 }
 
+/* directly set the target bit without reading first. */
+static inline void stm32_exti_write_bit(struct irq_data *d, u32 reg)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	void __iomem *base = chip_data->host_data->base;
+	u32 val = BIT(d->hwirq % IRQS_PER_BANK);
+
+	writel_relaxed(val, base + reg);
+}
+
 static inline u32 stm32_exti_set_bit(struct irq_data *d, u32 reg)
 {
 	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
@@ -449,9 +459,9 @@ static void stm32_exti_h_eoi(struct irq_data *d)
 
 	raw_spin_lock(&chip_data->rlock);
 
-	stm32_exti_set_bit(d, stm32_bank->rpr_ofst);
+	stm32_exti_write_bit(d, stm32_bank->rpr_ofst);
 	if (stm32_bank->fpr_ofst != UNDEF_REG)
-		stm32_exti_set_bit(d, stm32_bank->fpr_ofst);
+		stm32_exti_write_bit(d, stm32_bank->fpr_ofst);
 
 	raw_spin_unlock(&chip_data->rlock);
 
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index b7cc5d6580d8..d4e97605456b 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -8,6 +8,7 @@
 
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/interrupt.h>
@@ -83,6 +84,7 @@ struct ti_sci_inta_vint_desc {
  * @vint_mutex:		Mutex to protect vint_list
  * @base:		Base address of the memory mapped IO registers
  * @pdev:		Pointer to platform device.
+ * @ti_sci_id:		TI-SCI device identifier
  */
 struct ti_sci_inta_irq_domain {
 	const struct ti_sci_handle *sci;
@@ -93,6 +95,7 @@ struct ti_sci_inta_irq_domain {
 	struct mutex vint_mutex;
 	void __iomem *base;
 	struct platform_device *pdev;
+	u32 ti_sci_id;
 };
 
 #define to_vint_desc(e, i) container_of(e, struct ti_sci_inta_vint_desc, \
@@ -128,6 +131,37 @@ static void ti_sci_inta_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(irq_desc_get_chip(desc), desc);
 }
 
+/**
+ * ti_sci_inta_xlate_irq() - Translate hwirq to parent's hwirq.
+ * @inta:	IRQ domain corresponding to Interrupt Aggregator
+ * @irq:	Hardware irq corresponding to the above irq domain
+ *
+ * Return parent irq number if translation is available else -ENOENT.
+ */
+static int ti_sci_inta_xlate_irq(struct ti_sci_inta_irq_domain *inta,
+				 u16 vint_id)
+{
+	struct device_node *np = dev_of_node(&inta->pdev->dev);
+	u32 base, parent_base, size;
+	const __be32 *range;
+	int len;
+
+	range = of_get_property(np, "ti,interrupt-ranges", &len);
+	if (!range)
+		return vint_id;
+
+	for (len /= sizeof(*range); len >= 3; len -= 3) {
+		base = be32_to_cpu(*range++);
+		parent_base = be32_to_cpu(*range++);
+		size = be32_to_cpu(*range++);
+
+		if (base <= vint_id && vint_id < base + size)
+			return vint_id - base + parent_base;
+	}
+
+	return -ENOENT;
+}
+
 /**
  * ti_sci_inta_alloc_parent_irq() - Allocate parent irq to Interrupt aggregator
  * @domain:	IRQ domain corresponding to Interrupt Aggregator
@@ -139,30 +173,52 @@ static struct ti_sci_inta_vint_desc *ti_sci_inta_alloc_parent_irq(struct irq_dom
 	struct ti_sci_inta_irq_domain *inta = domain->host_data;
 	struct ti_sci_inta_vint_desc *vint_desc;
 	struct irq_fwspec parent_fwspec;
+	struct device_node *parent_node;
 	unsigned int parent_virq;
-	u16 vint_id;
+	u16 vint_id, p_hwirq;
+	int ret;
 
 	vint_id = ti_sci_get_free_resource(inta->vint);
 	if (vint_id == TI_SCI_RESOURCE_NULL)
 		return ERR_PTR(-EINVAL);
 
+	p_hwirq = ti_sci_inta_xlate_irq(inta, vint_id);
+	if (p_hwirq < 0) {
+		ret = p_hwirq;
+		goto free_vint;
+	}
+
 	vint_desc = kzalloc(sizeof(*vint_desc), GFP_KERNEL);
-	if (!vint_desc)
-		return ERR_PTR(-ENOMEM);
+	if (!vint_desc) {
+		ret = -ENOMEM;
+		goto free_vint;
+	}
 
 	vint_desc->domain = domain;
 	vint_desc->vint_id = vint_id;
 	INIT_LIST_HEAD(&vint_desc->list);
 
-	parent_fwspec.fwnode = of_node_to_fwnode(of_irq_find_parent(dev_of_node(&inta->pdev->dev)));
-	parent_fwspec.param_count = 2;
-	parent_fwspec.param[0] = inta->pdev->id;
-	parent_fwspec.param[1] = vint_desc->vint_id;
+	parent_node = of_irq_find_parent(dev_of_node(&inta->pdev->dev));
+	parent_fwspec.fwnode = of_node_to_fwnode(parent_node);
+
+	if (of_device_is_compatible(parent_node, "arm,gic-v3")) {
+		/* Parent is GIC */
+		parent_fwspec.param_count = 3;
+		parent_fwspec.param[0] = 0;
+		parent_fwspec.param[1] = p_hwirq - 32;
+		parent_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
+	} else {
+		/* Parent is Interrupt Router */
+		parent_fwspec.param_count = 1;
+		parent_fwspec.param[0] = p_hwirq;
+	}
 
 	parent_virq = irq_create_fwspec_mapping(&parent_fwspec);
 	if (parent_virq == 0) {
-		kfree(vint_desc);
-		return ERR_PTR(-EINVAL);
+		dev_err(&inta->pdev->dev, "Parent IRQ allocation failed\n");
+		ret = -EINVAL;
+		goto free_vint_desc;
+
 	}
 	vint_desc->parent_virq = parent_virq;
 
@@ -171,6 +227,11 @@ static struct ti_sci_inta_vint_desc *ti_sci_inta_alloc_parent_irq(struct irq_dom
 					 ti_sci_inta_irq_handler, vint_desc);
 
 	return vint_desc;
+free_vint_desc:
+	kfree(vint_desc);
+free_vint:
+	ti_sci_release_resource(inta->vint, vint_id);
+	return ERR_PTR(ret);
 }
 
 /**
@@ -202,7 +263,7 @@ static struct ti_sci_inta_event_desc *ti_sci_inta_alloc_event(struct ti_sci_inta
 
 	err = inta->sci->ops.rm_irq_ops.set_event_map(inta->sci,
 						      dev_id, dev_index,
-						      inta->pdev->id,
+						      inta->ti_sci_id,
 						      vint_desc->vint_id,
 						      event_desc->global_event,
 						      free_bit);
@@ -299,7 +360,7 @@ static void ti_sci_inta_free_irq(struct ti_sci_inta_event_desc *event_desc,
 	inta->sci->ops.rm_irq_ops.free_event_map(inta->sci,
 						 HWIRQ_TO_DEVID(hwirq),
 						 HWIRQ_TO_IRQID(hwirq),
-						 inta->pdev->id,
+						 inta->ti_sci_id,
 						 vint_desc->vint_id,
 						 event_desc->global_event,
 						 event_desc->vint_bit);
@@ -547,21 +608,21 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = of_property_read_u32(dev->of_node, "ti,sci-dev-id", &pdev->id);
+	ret = of_property_read_u32(dev->of_node, "ti,sci-dev-id", &inta->ti_sci_id);
 	if (ret) {
 		dev_err(dev, "missing 'ti,sci-dev-id' property\n");
 		return -EINVAL;
 	}
 
-	inta->vint = devm_ti_sci_get_of_resource(inta->sci, dev, pdev->id,
-						 "ti,sci-rm-range-vint");
+	inta->vint = devm_ti_sci_get_resource(inta->sci, dev, inta->ti_sci_id,
+					      TI_SCI_RESASG_SUBTYPE_IA_VINT);
 	if (IS_ERR(inta->vint)) {
 		dev_err(dev, "VINT resource allocation failed\n");
 		return PTR_ERR(inta->vint);
 	}
 
-	inta->global_event = devm_ti_sci_get_of_resource(inta->sci, dev, pdev->id,
-						"ti,sci-rm-range-global-event");
+	inta->global_event = devm_ti_sci_get_resource(inta->sci, dev, inta->ti_sci_id,
+						      TI_SCI_RESASG_SUBTYPE_GLOBAL_EVENT_SEVT);
 	if (IS_ERR(inta->global_event)) {
 		dev_err(dev, "Global event resource allocation failed\n");
 		return PTR_ERR(inta->global_event);
@@ -592,6 +653,8 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&inta->vint_list);
 	mutex_init(&inta->vint_mutex);
 
+	dev_info(dev, "Interrupt Aggregator domain %d created\n", pdev->id);
+
 	return 0;
 }
 
diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
index 5ea148faf2ab..cbc1758228d9 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -17,29 +17,20 @@
 #include <linux/of_irq.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 
-#define TI_SCI_DEV_ID_MASK	0xffff
-#define TI_SCI_DEV_ID_SHIFT	16
-#define TI_SCI_IRQ_ID_MASK	0xffff
-#define TI_SCI_IRQ_ID_SHIFT	0
-#define HWIRQ_TO_DEVID(hwirq)	(((hwirq) >> (TI_SCI_DEV_ID_SHIFT)) & \
-				 (TI_SCI_DEV_ID_MASK))
-#define HWIRQ_TO_IRQID(hwirq)	((hwirq) & (TI_SCI_IRQ_ID_MASK))
-#define TO_HWIRQ(dev, index)	((((dev) & TI_SCI_DEV_ID_MASK) << \
-				 TI_SCI_DEV_ID_SHIFT) | \
-				((index) & TI_SCI_IRQ_ID_MASK))
-
 /**
  * struct ti_sci_intr_irq_domain - Structure representing a TISCI based
  *				   Interrupt Router IRQ domain.
  * @sci:	Pointer to TISCI handle
- * @dst_irq:	TISCI resource pointer representing GIC irq controller.
- * @dst_id:	TISCI device ID of the GIC irq controller.
+ * @out_irqs:	TISCI resource pointer representing INTR irqs.
+ * @dev:	Struct device pointer.
+ * @ti_sci_id:	TI-SCI device identifier
  * @type:	Specifies the trigger type supported by this Interrupt Router
  */
 struct ti_sci_intr_irq_domain {
 	const struct ti_sci_handle *sci;
-	struct ti_sci_resource *dst_irq;
-	u32 dst_id;
+	struct ti_sci_resource *out_irqs;
+	struct device *dev;
+	u32 ti_sci_id;
 	u32 type;
 };
 
@@ -70,15 +61,44 @@ static int ti_sci_intr_irq_domain_translate(struct irq_domain *domain,
 {
 	struct ti_sci_intr_irq_domain *intr = domain->host_data;
 
-	if (fwspec->param_count != 2)
+	if (fwspec->param_count != 1)
 		return -EINVAL;
 
-	*hwirq = TO_HWIRQ(fwspec->param[0], fwspec->param[1]);
+	*hwirq = fwspec->param[0];
 	*type = intr->type;
 
 	return 0;
 }
 
+/**
+ * ti_sci_intr_xlate_irq() - Translate hwirq to parent's hwirq.
+ * @intr:	IRQ domain corresponding to Interrupt Router
+ * @irq:	Hardware irq corresponding to the above irq domain
+ *
+ * Return parent irq number if translation is available else -ENOENT.
+ */
+static int ti_sci_intr_xlate_irq(struct ti_sci_intr_irq_domain *intr, u32 irq)
+{
+	struct device_node *np = dev_of_node(intr->dev);
+	u32 base, pbase, size, len;
+	const __be32 *range;
+
+	range = of_get_property(np, "ti,interrupt-ranges", &len);
+	if (!range)
+		return irq;
+
+	for (len /= sizeof(*range); len >= 3; len -= 3) {
+		base = be32_to_cpu(*range++);
+		pbase = be32_to_cpu(*range++);
+		size = be32_to_cpu(*range++);
+
+		if (base <= irq && irq < base + size)
+			return irq - base + pbase;
+	}
+
+	return -ENOENT;
+}
+
 /**
  * ti_sci_intr_irq_domain_free() - Free the specified IRQs from the domain.
  * @domain:	Domain to which the irqs belong
@@ -89,66 +109,76 @@ static void ti_sci_intr_irq_domain_free(struct irq_domain *domain,
 					unsigned int virq, unsigned int nr_irqs)
 {
 	struct ti_sci_intr_irq_domain *intr = domain->host_data;
-	struct irq_data *data, *parent_data;
-	u16 dev_id, irq_index;
+	struct irq_data *data;
+	int out_irq;
 
-	parent_data = irq_domain_get_irq_data(domain->parent, virq);
 	data = irq_domain_get_irq_data(domain, virq);
-	irq_index = HWIRQ_TO_IRQID(data->hwirq);
-	dev_id = HWIRQ_TO_DEVID(data->hwirq);
+	out_irq = (uintptr_t)data->chip_data;
 
-	intr->sci->ops.rm_irq_ops.free_irq(intr->sci, dev_id, irq_index,
-					   intr->dst_id, parent_data->hwirq);
-	ti_sci_release_resource(intr->dst_irq, parent_data->hwirq);
+	intr->sci->ops.rm_irq_ops.free_irq(intr->sci,
+					   intr->ti_sci_id, data->hwirq,
+					   intr->ti_sci_id, out_irq);
+	ti_sci_release_resource(intr->out_irqs, out_irq);
 	irq_domain_free_irqs_parent(domain, virq, 1);
 	irq_domain_reset_irq_data(data);
 }
 
 /**
- * ti_sci_intr_alloc_gic_irq() - Allocate GIC specific IRQ
+ * ti_sci_intr_alloc_parent_irq() - Allocate parent IRQ
  * @domain:	Pointer to the interrupt router IRQ domain
  * @virq:	Corresponding Linux virtual IRQ number
  * @hwirq:	Corresponding hwirq for the IRQ within this IRQ domain
  *
- * Returns 0 if all went well else appropriate error pointer.
+ * Returns parent irq if all went well else appropriate error pointer.
  */
-static int ti_sci_intr_alloc_gic_irq(struct irq_domain *domain,
-				     unsigned int virq, u32 hwirq)
+static int ti_sci_intr_alloc_parent_irq(struct irq_domain *domain,
+					unsigned int virq, u32 hwirq)
 {
 	struct ti_sci_intr_irq_domain *intr = domain->host_data;
+	struct device_node *parent_node;
 	struct irq_fwspec fwspec;
-	u16 dev_id, irq_index;
-	u16 dst_irq;
-	int err;
-
-	dev_id = HWIRQ_TO_DEVID(hwirq);
-	irq_index = HWIRQ_TO_IRQID(hwirq);
+	u16 out_irq, p_hwirq;
+	int err = 0;
 
-	dst_irq = ti_sci_get_free_resource(intr->dst_irq);
-	if (dst_irq == TI_SCI_RESOURCE_NULL)
+	out_irq = ti_sci_get_free_resource(intr->out_irqs);
+	if (out_irq == TI_SCI_RESOURCE_NULL)
 		return -EINVAL;
 
-	fwspec.fwnode = domain->parent->fwnode;
-	fwspec.param_count = 3;
-	fwspec.param[0] = 0;	/* SPI */
-	fwspec.param[1] = dst_irq - 32; /* SPI offset */
-	fwspec.param[2] = intr->type;
+	p_hwirq = ti_sci_intr_xlate_irq(intr, out_irq);
+	if (p_hwirq < 0)
+		goto err_irqs;
+
+	parent_node = of_irq_find_parent(dev_of_node(intr->dev));
+	fwspec.fwnode = of_node_to_fwnode(parent_node);
+
+	if (of_device_is_compatible(parent_node, "arm,gic-v3")) {
+		/* Parent is GIC */
+		fwspec.param_count = 3;
+		fwspec.param[0] = 0;	/* SPI */
+		fwspec.param[1] = p_hwirq - 32; /* SPI offset */
+		fwspec.param[2] = intr->type;
+	} else {
+		/* Parent is Interrupt Router */
+		fwspec.param_count = 1;
+		fwspec.param[0] = p_hwirq;
+	}
 
 	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
 	if (err)
 		goto err_irqs;
 
-	err = intr->sci->ops.rm_irq_ops.set_irq(intr->sci, dev_id, irq_index,
-						intr->dst_id, dst_irq);
+	err = intr->sci->ops.rm_irq_ops.set_irq(intr->sci,
+						intr->ti_sci_id, hwirq,
+						intr->ti_sci_id, out_irq);
 	if (err)
 		goto err_msg;
 
-	return 0;
+	return p_hwirq;
 
 err_msg:
 	irq_domain_free_irqs_parent(domain, virq, 1);
 err_irqs:
-	ti_sci_release_resource(intr->dst_irq, dst_irq);
+	ti_sci_release_resource(intr->out_irqs, out_irq);
 	return err;
 }
 
@@ -168,18 +198,19 @@ static int ti_sci_intr_irq_domain_alloc(struct irq_domain *domain,
 	struct irq_fwspec *fwspec = data;
 	unsigned long hwirq;
 	unsigned int flags;
-	int err;
+	int err, p_hwirq;
 
 	err = ti_sci_intr_irq_domain_translate(domain, fwspec, &hwirq, &flags);
 	if (err)
 		return err;
 
-	err = ti_sci_intr_alloc_gic_irq(domain, virq, hwirq);
-	if (err)
-		return err;
+	p_hwirq = ti_sci_intr_alloc_parent_irq(domain, virq, hwirq);
+	if (p_hwirq < 0)
+		return p_hwirq;
 
 	irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
-				      &ti_sci_intr_irq_chip, NULL);
+				      &ti_sci_intr_irq_chip,
+				      (void *)(uintptr_t)p_hwirq);
 
 	return 0;
 }
@@ -214,6 +245,7 @@ static int ti_sci_intr_irq_domain_probe(struct platform_device *pdev)
 	if (!intr)
 		return -ENOMEM;
 
+	intr->dev = dev;
 	ret = of_property_read_u32(dev_of_node(dev), "ti,intr-trigger-type",
 				   &intr->type);
 	if (ret) {
@@ -230,19 +262,19 @@ static int ti_sci_intr_irq_domain_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = of_property_read_u32(dev_of_node(dev), "ti,sci-dst-id",
-				   &intr->dst_id);
+	ret = of_property_read_u32(dev_of_node(dev), "ti,sci-dev-id",
+				   &intr->ti_sci_id);
 	if (ret) {
-		dev_err(dev, "missing 'ti,sci-dst-id' property\n");
+		dev_err(dev, "missing 'ti,sci-dev-id' property\n");
 		return -EINVAL;
 	}
 
-	intr->dst_irq = devm_ti_sci_get_of_resource(intr->sci, dev,
-						    intr->dst_id,
-						    "ti,sci-rm-range-girq");
-	if (IS_ERR(intr->dst_irq)) {
+	intr->out_irqs = devm_ti_sci_get_resource(intr->sci, dev,
+						  intr->ti_sci_id,
+						  TI_SCI_RESASG_SUBTYPE_IR_OUTPUT);
+	if (IS_ERR(intr->out_irqs)) {
 		dev_err(dev, "Destination irq resource allocation failed\n");
-		return PTR_ERR(intr->dst_irq);
+		return PTR_ERR(intr->out_irqs);
 	}
 
 	domain = irq_domain_add_hierarchy(parent_domain, 0, 0, dev_of_node(dev),
@@ -252,6 +284,8 @@ static int ti_sci_intr_irq_domain_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	dev_info(dev, "Interrupt Router %d domain created\n", intr->ti_sci_id);
+
 	return 0;
 }
 
diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 1bb0e36c2bf3..d2341153e181 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -52,7 +52,7 @@ int platform_irqchip_probe(struct platform_device *pdev)
 	 * interrupt controller. The actual initialization callback of this
 	 * interrupt controller can check for specific domains as necessary.
 	 */
-	if (par_np && !irq_find_matching_host(np, DOMAIN_BUS_ANY))
+	if (par_np && !irq_find_matching_host(par_np, DOMAIN_BUS_ANY))
 		return -EPROBE_DEFER;
 
 	return irq_init_cb(np, par_np);
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index c1c5dfad57cc..6ae9e1f0819d 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -11,11 +11,9 @@
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/soc/qcom/irq.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -432,8 +430,4 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 	return ret;
 }
 
-IRQCHIP_PLATFORM_DRIVER_BEGIN(qcom_pdc)
-IRQCHIP_MATCH("qcom,pdc", qcom_pdc_init)
-IRQCHIP_PLATFORM_DRIVER_END(qcom_pdc)
-MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Power Domain Controller");
-MODULE_LICENSE("GPL v2");
+IRQCHIP_DECLARE(qcom_pdc, "qcom,pdc", qcom_pdc_init);
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 49c5d29cd33c..cf27b080e148 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -220,6 +220,9 @@ struct ti_sci_rm_core_ops {
 				    u16 *range_start, u16 *range_num);
 };
 
+#define TI_SCI_RESASG_SUBTYPE_IR_OUTPUT		0
+#define TI_SCI_RESASG_SUBTYPE_IA_VINT		0xa
+#define TI_SCI_RESASG_SUBTYPE_GLOBAL_EVENT_SEVT	0xd
 /**
  * struct ti_sci_rm_irq_ops: IRQ management operations
  * @set_irq:		Set an IRQ route between the requested source
@@ -556,6 +559,9 @@ u32 ti_sci_get_num_resources(struct ti_sci_resource *res);
 struct ti_sci_resource *
 devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
 			    struct device *dev, u32 dev_id, char *of_prop);
+struct ti_sci_resource *
+devm_ti_sci_get_resource(const struct ti_sci_handle *handle, struct device *dev,
+			 u32 dev_id, u32 sub_type);
 
 #else	/* CONFIG_TI_SCI_PROTOCOL */
 
@@ -609,6 +615,13 @@ devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
 {
 	return ERR_PTR(-EINVAL);
 }
+
+static inline struct ti_sci_resource *
+devm_ti_sci_get_resource(const struct ti_sci_handle *handle, struct device *dev,
+			 u32 dev_id, u32 sub_type);
+{
+	return ERR_PTR(-EINVAL);
+}
 #endif	/* CONFIG_TI_SCI_PROTOCOL */
 
 #endif	/* __TISCI_PROTOCOL_H */

