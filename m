Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19978C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFF72072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgCFNHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:07:37 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:36368 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgCFNHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:07:37 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 194288030794;
        Fri,  6 Mar 2020 13:07:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pPKreXhWPNMw; Fri,  6 Mar 2020 16:07:33 +0300 (MSK)
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
Subject: [PATCH 3/6] dt-bindings: Add Baikal-T1 L2-cache Control Block dts bindings file
Date:   Fri, 6 Mar 2020 16:07:18 +0300
In-Reply-To: <20200306130721.10347-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306130721.10347-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306130734.194288030794@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

There is a single register provided by the SoC system controller,
which can be used to tune the L2-cache up. It only provides a way
to change the L2-RAM access latencies. So aside from the MMIO region
with that setting and "be,bt1-l2-ctl" compatible string the device
node can be optionally equipped with the properties of Tag/Data/WS
latencies.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: soc@kernel.org
---
 .../bindings/soc/baikal-t1/be,bt1-l2-ctl.yaml | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-l2-ctl.yaml

diff --git a/Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-l2-ctl.yaml b/Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-l2-ctl.yaml
new file mode 100644
index 000000000000..8769b3fa517c
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-l2-ctl.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2020 BAIKAL ELECTRONICS, JSC
+#
+# Baikal-T1 L2-cache Control Block Device Tree Bindings.
+#
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/baikal-t1/be,bt1-l2-ctl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Baikal-T1 L2-cache Control Block
+
+maintainers:
+  - Serge Semin <fancer.lancer@gmail.com>
+
+description: |
+  Baikal-T1 exposes a few settings to tune the MIPS P5600 CM2 L2-cache
+  performance up. In particular it's possible to change the Tag, Data and
+  Way-select RAM access latencies. This bindings file describes the system
+  controller block, which provides an interface to set the tuning up.
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: syscon
+    then:
+      $ref: ../../mfd/syscon.yaml#
+    else:
+      properties:
+        reg-io-width: false
+
+        little-endian: false
+
+properties:
+  compatible:
+    oneOf:
+      - description: P5600 CM2 L2-cache RAM external configuration block.
+        const: be,bt1-l2-ctl
+      - description: P5600 CM2 L2-cache RAM system controller block.
+        items:
+          - const: be,bt1-l2-ctl
+          - const: syscon
+
+  reg:
+    description: MMIO register with MIPS P5600 CM2 L2-cache RAM settings.
+    maxItems: 1
+
+  be,l2-ws-latency:
+    description: Cycles of latency for Way-select RAM accesses.
+    default: 0
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+        maximum: 3
+
+  be,l2-tag-latency:
+    description: Cycles of latency for Tag RAM accesses.
+    default: 0
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+        maximum: 3
+
+  be,l2-data-latency:
+    description: Cycles of latency for Data RAM accesses.
+    default: 1
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+        maximum: 3
+
+  reg-io-width:
+    const: 4
+
+  little-endian: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    l2_ctl1: l2@1F04D028 {
+      compatible = "be,bt1-l2-ctl";
+      reg = <0x1F04D028 0x004>;
+
+      be,l2-ws-latency = <0>;
+      be,l2-tag-latency = <0>;
+      be,l2-data-latency = <1>;
+    };
+  - |
+    l2_ctl2: l2@1F04D028 {
+      compatible = "be,bt1-l2-ctl", "syscon";
+      reg = <0x1F04D028 0x004>;
+
+      be,l2-ws-latency = <0>;
+      be,l2-tag-latency = <0>;
+      be,l2-data-latency = <1>;
+
+      little-endian;
+      reg-io-width = <4>;
+    };
+...
-- 
2.25.1

