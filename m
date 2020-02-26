Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BCFC4BA20
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A27D2467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgBZSJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:09:25 -0500
Received: from foss.arm.com ([217.140.110.172]:40486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbgBZSJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:09:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6E9630E;
        Wed, 26 Feb 2020 10:09:21 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E469D3F881;
        Wed, 26 Feb 2020 10:09:19 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Richter <rric@kernel.org>, soc@kernel.org,
        Jon Loeliger <jdl@jdl.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH 05/13] dt-bindings: clock: Convert Calxeda clock bindings to json-schema
Date:   Wed, 26 Feb 2020 18:08:53 +0000
Message-Id: <20200226180901.89940-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226180901.89940-1-andre.przywara@arm.com>
References: <20200226180901.89940-1-andre.przywara@arm.com>
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
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org

---
 .../devicetree/bindings/clock/calxeda.txt     | 17 ----
 .../devicetree/bindings/clock/calxeda.yaml    | 83 +++++++++++++++++++
 2 files changed, 83 insertions(+), 17 deletions(-)
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
index 000000000000..0ad66af0eb0c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/calxeda.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0
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
+    $ref: /schemas/types.yaml#/definitions/phandle-array
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
+            ddrpll: ddrpll {
+                #clock-cells = <0>;
+                compatible = "calxeda,hb-pll-clock";
+                clocks = <&osc>;
+                reg = <0x108>;
+            };
+
+            a9pll: a9pll {
+                #clock-cells = <0>;
+                compatible = "calxeda,hb-pll-clock";
+                clocks = <&osc>;
+                reg = <0x100>;
+            };
+
+            a9periphclk: a9periphclk {
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

