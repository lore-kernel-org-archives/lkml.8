Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA023C47254
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B38942070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgD3VLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:11:09 -0400
Received: from foss.arm.com ([217.140.110.172]:33604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgD3VLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:11:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7EBB31B;
        Thu, 30 Apr 2020 14:11:07 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EBC03F68F;
        Thu, 30 Apr 2020 14:11:06 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: [PATCH v3 1/8] dt-bindings: clock: Convert Calxeda clock bindings to json-schema
Date:   Thu, 30 Apr 2020 22:10:47 +0100
Message-Id: <20200430211054.30466-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430211054.30466-1-andre.przywara@arm.com>
References: <20200430211054.30466-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Calxeda clock bindings to DT schema format using json-schema.

This just covers the actual PLL and divider clock nodes. In the actual
DTs they are somewhat unconnected (no ranges or bus compatible) children
of the sregs node, but for the actual clock bindings this is not
relevant.

One oddity is that the addresses are relative to the parent node,
without that being pronounced using a ranges property.
But this is too late to fix now.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 .../devicetree/bindings/clock/calxeda.txt     | 17 ----
 .../devicetree/bindings/clock/calxeda.yaml    | 82 +++++++++++++++++++
 2 files changed, 82 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/calxeda.txt
 create mode 100644 Documentation/devicetree/bindings/clock/calxeda.yaml

diff --git a/Documentation/devicetree/bindings/clock/calxeda.txt b/Documentation/devicetree/bindings/clock/calxeda.txt
deleted file mode 100644
index 0a6ac1bdcda1..000000000000
--- a/Documentation/devicetree/bindings/clock/calxeda.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Device Tree Clock bindings for Calxeda highbank platform
-
-This binding uses the common clock binding[1].
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Required properties:
-- compatible : shall be one of the following:
-	"calxeda,hb-pll-clock" - for a PLL clock
-	"calxeda,hb-a9periph-clock" - The A9 peripheral clock divided from the
-		A9 clock.
-	"calxeda,hb-a9bus-clock" - The A9 bus clock divided from the A9 clock.
-	"calxeda,hb-emmc-clock" - Divided clock for MMC/SD controller.
-- reg : shall be the control register offset from SYSREGs base for the clock.
-- clocks : shall be the input parent clock phandle for the clock. This is
-	either an oscillator or a pll output.
-- #clock-cells : from common clock binding; shall be set to 0.
diff --git a/Documentation/devicetree/bindings/clock/calxeda.yaml b/Documentation/devicetree/bindings/clock/calxeda.yaml
new file mode 100644
index 000000000000..a34cbf3c9aaf
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/calxeda.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/calxeda.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Device Tree Clock bindings for Calxeda highbank platform
+
+description: |
+  This binding covers the Calxeda SoC internal peripheral and bus clocks
+  as used by peripherals. The clocks live inside the "system register"
+  region of the SoC, so are typically presented as children of an
+  "hb-sregs" node.
+
+maintainers:
+  - Andre Przywara <andre.przywara@arm.com>
+
+properties:
+  "#clock-cells":
+    const: 0
+
+  compatible:
+    enum:
+      - calxeda,hb-pll-clock
+      - calxeda,hb-a9periph-clock
+      - calxeda,hb-a9bus-clock
+      - calxeda,hb-emmc-clock
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - "#clock-cells"
+  - compatible
+  - clocks
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    sregs@3fffc000 {
+        compatible = "calxeda,hb-sregs";
+        reg = <0x3fffc000 0x1000>;
+
+        clocks {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            osc: oscillator {
+                #clock-cells = <0>;
+                compatible = "fixed-clock";
+                clock-frequency = <33333000>;
+            };
+
+            ddrpll: ddrpll@108 {
+                #clock-cells = <0>;
+                compatible = "calxeda,hb-pll-clock";
+                clocks = <&osc>;
+                reg = <0x108>;
+            };
+
+            a9pll: a9pll@100 {
+                #clock-cells = <0>;
+                compatible = "calxeda,hb-pll-clock";
+                clocks = <&osc>;
+                reg = <0x100>;
+            };
+
+            a9periphclk: a9periphclk@104 {
+                #clock-cells = <0>;
+                compatible = "calxeda,hb-a9periph-clock";
+                clocks = <&a9pll>;
+                reg = <0x104>;
+            };
+        };
+    };
+
+...
-- 
2.17.1

