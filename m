Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D45C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A6192073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgGIICt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:02:49 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50387 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgGIICJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:02:09 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 09394E0003;
        Thu,  9 Jul 2020 08:02:04 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-i3c@lists.infradead.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Conor Culhane <conor.culhane@silvaco.com>,
        Rajeev Huralikoppi <rajeev.huralikoppi@silvaco.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 2/4] dt-bindings: i3c: Describe Silvaco master binding
Date:   Thu,  9 Jul 2020 10:01:57 +0200
Message-Id: <20200709080159.2178-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200709080159.2178-1-miquel.raynal@bootlin.com>
References: <20200709080159.2178-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silvaco provide a dual-role I3C master.

Description is rather simple: it needs a register mapping, three
clocks and an interrupt.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../bindings/i3c/svc,i3c-master.yaml          | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/svc,i3c-master.yaml

diff --git a/Documentation/devicetree/bindings/i3c/svc,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/svc,i3c-master.yaml
new file mode 100644
index 000000000000..11e670c6b76f
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/svc,i3c-master.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i3c/svc,i3c-master.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silvaco I3C master
+
+maintainers:
+  - Conor Culhane <conor.culhane@silvaco.com>
+
+properties:
+  compatible:
+    const: svc,i3c-master
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-names:
+    description: |
+      There are three clocks:
+        pclk:     System clock
+        fast_clk: Fast clock (for the bus)
+        slow_clk: Slow clock (for other events)
+
+    items:
+      - const: pclk
+      - const: fast_clk
+      - const: slow_clk
+
+  clocks:
+    minItems: 3
+    maxItems: 3
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-names
+  - clocks
+
+examples:
+  - |
+    i3c-master@a0000000 {
+        compatible = "svc,i3c-master";
+        clocks = <&zynqmp_clk 71>, <&fclk>, <&sclk>;
+        clock-names = "pclk", "fast_clk", "slow_clk";
+        interrupt-parent = <&gic>;
+        interrupts = <0 89 4>;
+        reg = <0x0 0xa0000000 0x0 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
-- 
2.20.1

