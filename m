Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF8DC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1345620848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgCFN0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:26:23 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:36984 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgCFN0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:26:22 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 4ADCF8030702;
        Fri,  6 Mar 2020 13:26:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iCQgWhJFE1LY; Fri,  6 Mar 2020 16:26:19 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Maxim Kaurkin <maxim.kaurkin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: hwmon: Add Baikal-T1 PVT sensor bindings
Date:   Fri, 6 Mar 2020 16:26:03 +0300
In-Reply-To: <20200306132604.14312-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306132604.14312-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306132620.4ADCF8030702@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Baikal-T1 SoC is equipped with an embedded process, voltage and
temperature sensor to monitor the chip internal environment like
temperature, supply voltage and transistors performance.

This bindings describes the external Baikal-T1 PVT control interfaces
like MMIO registers space, interrupt request number and clocks source.
These are then used by the corresponding hwmon device driver to
implement the sysfs files-based access to the sensors functionality.

Signed-off-by: Maxim Kaurkin <maxim.kaurkin@baikalelectronics.ru>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 .../devicetree/bindings/hwmon/be,bt1-pvt.yaml | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/be,bt1-pvt.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/be,bt1-pvt.yaml b/Documentation/devicetree/bindings/hwmon/be,bt1-pvt.yaml
new file mode 100644
index 000000000000..d575d124d538
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/be,bt1-pvt.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2019 BAIKAL ELECTRONICS, JSC
+#
+# Baikal-T1 Process, Voltage, Temperature Sensor Device Tree Bindings.
+#
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/be,bt1-pvt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Baikal-T1 PVT Sensor Device Tree Bindings
+
+maintainers:
+  - Serge Semin <fancer.lancer@gmail.com>
+
+description: |
+  Baikal-T1 SoC provides an embedded process, voltage and temperature
+  sensor to monitor an internal SoC environment (chip temperature, supply
+  voltage and process monitor) and on time detect critical situations,
+  which may cause the system instability and even damages. The IP-block
+  is based on the Analog Bits PVT sensor, but is equipped with a dedicated
+  control wrapper, which provides a MMIO registers-based access to the
+  sensor core functionality (APB3-bus based) and exposes an additional
+  functions like thresholds/data ready interrupts, its status and masks,
+  measurements timeout. Its internal structure is depicted on the next
+  diagram:
+     Analog Bits core                     Bakal-T1 PVT control block
+  +--------------------+                  +------------------------+
+  | Temperature sensor |-+         +------| Sensors control        |
+  |--------------------| |<---En---|      |------------------------|
+  | Voltage sensor     |-|<--Mode--| +--->| Sampled data           |
+  |--------------------| |<--Trim--+ |    |------------------------|
+  | Low-Vt sensor      |-|           | +--| Thresholds comparator  |
+  |--------------------| |---Data----| |  |------------------------|
+  | High-Vt sensor     |-|           | +->| Interrupts status      |
+  |--------------------| |--Valid--+-+ |  |------------------------|
+  | Standard-Vt sensor |-+         +---+--| Interrupts mask        |
+  +--------------------+                  |------------------------|
+           ^                              | Interrupts timeout     |
+           |                              +------------------------+
+           |                                        ^  ^
+  Rclk-----+----------------------------------------+  |
+  APB3-------------------------------------------------+
+
+  This bindings describes the external Baikal-T1 PVT control interfaces
+  like MMIO registers space, interrupt request number and clocks source.
+  These are then used by the corresponding hwmon device driver to
+  implement the sysfs files-based access to the sensors functionality.
+
+properties:
+  compatible:
+    const: be,bt1-pvt
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: PVT reference clock.
+      - description: APB3 interface clock.
+
+  clock-names:
+    items:
+      - const: ref
+      - const: pclk
+
+  "#thermal-sensor-cells":
+      description: Baikal-T1 can be referenced as the CPU thermal-sensor.
+      const: 0
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/mips-gic.h>
+    #include <dt-bindings/clock/bt1-ccu.h>
+
+    pvt: pvt@1F200000 {
+      compatible = "be,bt1-pvt";
+      reg = <0x1F200000 0x1000>;
+      #thermal-sensor-cells = <0>;
+
+      interrupts = <GIC_SHARED 31 IRQ_TYPE_LEVEL_HIGH>;
+
+      clocks = <&ccu_sys CCU_SYS_PVT_CLK>,
+               <&ccu_sys CCU_SYS_APB_CLK>;
+      clock-names = "ref", "pclk";
+    };
+...
-- 
2.25.1

