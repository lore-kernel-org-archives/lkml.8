Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F11C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732DD24671
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgCFNGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:06:17 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:36250 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgCFNGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:06:15 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 7D8CE8030794;
        Fri,  6 Mar 2020 13:06:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id q7Z9OUC4E08t; Fri,  6 Mar 2020 16:06:12 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: mfd: Add Baikal-T1 Boot Controller bindings
Date:   Fri, 6 Mar 2020 16:05:27 +0300
In-Reply-To: <20200306130528.9973-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306130528.9973-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306130613.7D8CE8030794@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

From Linux point of view Baikal-T1 Boot Controller is a multi-function
memory-mapped device, which provides an access to three memory-mapped
ROMs and to an embedded DW APB SSI-based SPI controller. It's refelected
in the be,bt1-boot-ctl bindings file. So the device must be added to
the system dts-file as an ordinary memory-mapped device node with
a single clocks source phandle declared and with also memory-mapped
spi/mtd-rom sub-devices.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 .../bindings/mfd/be,bt1-boot-ctl.yaml         | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/be,bt1-boot-ctl.yaml

diff --git a/Documentation/devicetree/bindings/mfd/be,bt1-boot-ctl.yaml b/Documentation/devicetree/bindings/mfd/be,bt1-boot-ctl.yaml
new file mode 100644
index 000000000000..bb95a236d231
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/be,bt1-boot-ctl.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/be,bt1-boot-ctl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Baikal-T1 Boot Controller bindings
+
+description: |
+  Baikal-T1 SoC Boot Controller is a vendor-specific module responsible
+  for the CPU primary booting up. Mainly it is a special block, which
+  task is to properly start the SoC and then pass the control to the CPU
+  cores. It also provides a MMIO-based interface to a bootable memory
+  devices with an executable code pre-installed for the system to
+  start. The controller includes the next functions:
+  1) Pysically mapped ROMs to transparently access a SoC' internal firmware
+     and SPI Boot flash.
+  2) DW APB SSI-based embedded SPI controller.
+
+maintainers:
+  - Serge Semin <fancer.lancer@gmail.com>
+
+properties:
+  compatible:
+    const: be,bt1-boot-ctl
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: APB interface clock source.
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: pclk
+
+  "#address-cells": true
+
+  "#size-cells": true
+
+  ranges: true
+
+patternProperties:
+  "^(rom|spi)@[0-9a-fA-F]+$":
+    type: object
+
+    properties:
+      compatible:
+        anyOf:
+          - description: Memory mapped boot ROMs.
+            items:
+             - enum:
+               - be,bt1-int-rom
+               - be,bt1-ssi-rom
+               - be,bt1-boot-rom
+             - const: mtd-rom
+          - description: DW APB SSI-based boot SPI controller.
+            const: be,bt1-boot-ssi
+
+    required:
+      - compatible
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/bt1-ccu.h>
+
+    boot: boot@1F040000 {
+      compatible = "be,bt1-boot-ctl";
+      reg = <0x1F040000 0x100>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges;
+
+      clocks = <&ccu_sys CCU_SYS_APB_CLK>;
+      clock-names = "pclk";
+    };
+...
-- 
2.25.1

