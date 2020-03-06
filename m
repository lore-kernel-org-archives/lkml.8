Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC73FC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF11324671
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgCFNHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:07:35 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:36316 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCFNHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:07:34 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 7E27C8030705;
        Fri,  6 Mar 2020 13:07:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XUMLQxRvb2VS; Fri,  6 Mar 2020 16:07:31 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
List-Id: <soc.lore.kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] dt-bindings: Add Baikal-T1 AXI-bus EHB dts bindings file
Date:   Fri, 6 Mar 2020 16:07:16 +0300
In-Reply-To: <20200306130721.10347-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306130721.10347-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306130732.7E27C8030705@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

This is a specific block embedded into the Baikal-T1 SoC, which is
dedicated to detect AXI-bus protocol errors. So the dts node just
needs to have the "be,bt1-axi-ehb" compatible string, MMIO registers
and interrupts properties declared.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: soc@kernel.org
---
 .../soc/baikal-t1/be,bt1-axi-ehb.yaml         | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-axi-ehb.yaml

diff --git a/Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-axi-ehb.yaml b/Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-axi-ehb.yaml
new file mode 100644
index 000000000000..f0deeb8f261c
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-axi-ehb.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2019 - 2020 BAIKAL ELECTRONICS, JSC
+#
+# Baikal-T1 AXI-bus Errors Handler Block Device Tree Bindings.
+#
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/baikal-t1/be,bt1-axi-ehb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Baikal-T1 AXI-bus Errors Handler Block
+
+maintainers:
+  - Serge Semin <fancer.lancer@gmail.com>
+
+description: |
+  AXI3-bus is the main communication bus connecting all high-speed peripheral
+  IP-cores with RAM controller and with MIPS P5600 cores. Traffic arbitration
+  is done by means of Main Interconnect routing IO request from one block to
+  another. In case of any protocol error, device not responding an IRQ is
+  raised and a faulty situation is reported to the AXI EHB described by this
+  bindings.
+
+properties:
+  compatible:
+    const: be,bt1-axi-ehb
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/mips-gic.h>
+
+    axi_ehb: ehb@1F04D110 {
+      compatible = "be,bt1-axi-ehb";
+      reg = <0x1F04D110 0x008>;
+
+      interrupts = <GIC_SHARED 127 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
-- 
2.25.1

