Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C55C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C6120721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390445AbgE1Nal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390383AbgE1Nah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:30:37 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4503C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 06:30:36 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:21:946d:6344:ccc1])
        by michel.telenet-ops.be with bizsmtp
        id kDWb2200255ue4H06DWbJy; Thu, 28 May 2020 15:30:35 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jeIcE-00089k-VH; Thu, 28 May 2020 15:30:34 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jeIcE-00016M-TZ; Thu, 28 May 2020 15:30:34 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: timer: renesas: mtu2: Convert to json-schema
Date:   Thu, 28 May 2020 15:30:33 +0200
Message-Id: <20200528133033.4191-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Renesas Multi-Function Timer Pulse Unit 2 (MTU2) Device Tree
binding documentation to json-schema.

Add missing properties.
Update the example to match reality.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../bindings/timer/renesas,mtu2.txt           | 42 ----------
 .../bindings/timer/renesas,mtu2.yaml          | 76 +++++++++++++++++++
 2 files changed, 76 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/renesas,mtu2.txt
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,mtu2.yaml

diff --git a/Documentation/devicetree/bindings/timer/renesas,mtu2.txt b/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
deleted file mode 100644
index ba0a34d97eb80261..0000000000000000
--- a/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-* Renesas Multi-Function Timer Pulse Unit 2 (MTU2)
-
-The MTU2 is a multi-purpose, multi-channel timer/counter with configurable
-clock inputs and programmable compare match.
-
-Channels share hardware resources but their counter and compare match value
-are independent. The MTU2 hardware supports five channels indexed from 0 to 4.
-
-Required Properties:
-
-  - compatible: must be one or more of the following:
-    - "renesas,mtu2-r7s72100" for the r7s72100 MTU2
-    - "renesas,mtu2" for any MTU2
-      This is a fallback for the above renesas,mtu2-* entries
-
-  - reg: base address and length of the registers block for the timer module.
-
-  - interrupts: interrupt specifiers for the timer, one for each entry in
-    interrupt-names.
-  - interrupt-names: must contain one entry named "tgi?a" for each enabled
-    channel, where "?" is the channel index expressed as one digit from "0" to
-    "4".
-
-  - clocks: a list of phandle + clock-specifier pairs, one for each entry
-    in clock-names.
-  - clock-names: must contain "fck" for the functional clock.
-
-
-Example: R7S72100 (RZ/A1H) MTU2 node
-
-	mtu2: timer@fcff0000 {
-		compatible = "renesas,mtu2-r7s72100", "renesas,mtu2";
-		reg = <0xfcff0000 0x400>;
-		interrupts = <0 139 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 146 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 150 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 154 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 159 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "tgi0a", "tgi1a", "tgi2a", "tgi3a", "tgi4a";
-		clocks = <&mstp3_clks R7S72100_CLK_MTU2>;
-		clock-names = "fck";
-	};
diff --git a/Documentation/devicetree/bindings/timer/renesas,mtu2.yaml b/Documentation/devicetree/bindings/timer/renesas,mtu2.yaml
new file mode 100644
index 0000000000000000..15d8dddf4ae9555b
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/renesas,mtu2.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/renesas,mtu2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas Multi-Function Timer Pulse Unit 2 (MTU2)
+
+maintainers:
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+  - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
+
+description:
+  The MTU2 is a multi-purpose, multi-channel timer/counter with configurable clock inputs
+  and programmable compare match.
+
+  Channels share hardware resources but their counter and compare match value are
+  independent. The MTU2 hardware supports five channels indexed from 0 to 4.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,mtu2-r7s72100 # RZ/A1H
+      - const: renesas,mtu2
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 5
+    description: One entry for each enabled channel.
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: tgi0a
+      - const: tgi1a
+      - const: tgi2a
+      - const: tgi3a
+      - const: tgi4a
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: fck
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r7s72100-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mtu2: timer@fcff0000 {
+            compatible = "renesas,mtu2-r7s72100", "renesas,mtu2";
+            reg = <0xfcff0000 0x400>;
+            interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "tgi0a";
+            clocks = <&mstp3_clks R7S72100_CLK_MTU2>;
+            clock-names = "fck";
+            power-domains = <&cpg_clocks>;
+    };
-- 
2.17.1

