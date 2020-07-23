Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E965DC433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C0A20709
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QUnGvZx4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7+aLKRxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgGWTJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:09:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60504 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbgGWTJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:09:50 -0400
Date:   Thu, 23 Jul 2020 19:09:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595531387;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QwU4vXoPimkfCGJ/tULJY9PczcvLGkj2BGbca0p16TA=;
        b=QUnGvZx4x+huc0MfCq+b9BvHIRiAi78xL5V+w2ZynVKXvAVMK8RDxN8G+0Mfgkgt/V6xkm
        FG0Xjrudvr73jOzeWUJWvgrnwfgDqOVzAm6dG2+a3nttR+r+u+7ygvqHl/f4BGbdEDY8XF
        Sv8BFPrUjii494HaF32KlPdwV2V7g2PrPo1vqFiKRsIiMxbkMvG/9o5L7nNEPv8dosRHLS
        9fUVNXiNSx/JQIqROB/g+OnXFO0WKTJirx9tt/CX/4B9PipDbYjyeJzfCfzONPihiCBkiL
        PeSLAusbGNmVZ/iF+w37EOm5ucDHUIOJXF0RX5I4pdjlH7bWgiyvN36mCCg3XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595531387;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QwU4vXoPimkfCGJ/tULJY9PczcvLGkj2BGbca0p16TA=;
        b=7+aLKRxGzJPz677G5N1KldNhIlUMcmr6Q04oqDeq/tVEGLkEmcZxdwmvoBO68BL2FdjgRy
        lOfvD0VGdxgplhBQ==
From:   "tip-bot2 for Alexandre Belloni" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: atmel-tcb: convert bindings to json-schema
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200710230813.1005150-2-alexandre.belloni@bootlin.com>
References: <20200710230813.1005150-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Message-ID: <159553138717.4006.17315732968766226240.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8be8e7de604f8e51cf5d02afdcd28e1e49d3646b
Gitweb:        https://git.kernel.org/tip/8be8e7de604f8e51cf5d02afdcd28e1e49d3646b
Author:        Alexandre Belloni <alexandre.belloni@bootlin.com>
AuthorDate:    Sat, 11 Jul 2020 01:08:05 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 11 Jul 2020 18:57:02 +02:00

dt-bindings: atmel-tcb: convert bindings to json-schema

Convert Atmel Timer Counter Blocks bindings to DT schema format using
json-schema.

Also move it out of mfd as it is not and has never been related to mfd.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200710230813.1005150-2-alexandre.belloni@bootlin.com
---
 Documentation/devicetree/bindings/mfd/atmel-tcb.txt                       |  56 +------------------------------
 Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml | 131 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 131 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt
 create mode 100644 Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml

diff --git a/Documentation/devicetree/bindings/mfd/atmel-tcb.txt b/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
deleted file mode 100644
index c4a83e3..0000000
--- a/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-* Device tree bindings for Atmel Timer Counter Blocks
-- compatible: Should be "atmel,<chip>-tcb", "simple-mfd", "syscon".
-  <chip> can be "at91rm9200" or "at91sam9x5"
-- reg: Should contain registers location and length
-- #address-cells: has to be 1
-- #size-cells: has to be 0
-- interrupts: Should contain all interrupts for the TC block
-  Note that you can specify several interrupt cells if the TC
-  block has one interrupt per channel.
-- clock-names: tuple listing input clock names.
-	Required elements: "t0_clk", "slow_clk"
-	Optional elements: "t1_clk", "t2_clk"
-- clocks: phandles to input clocks.
-
-The TCB can expose multiple subdevices:
- * a timer
-   - compatible: Should be "atmel,tcb-timer"
-   - reg: Should contain the TCB channels to be used. If the
-     counter width is 16 bits (at91rm9200-tcb), two consecutive
-     channels are needed. Else, only one channel will be used.
-
-Examples:
-
-One interrupt per TC block:
-	tcb0: timer@fff7c000 {
-		compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0xfff7c000 0x100>;
-		interrupts = <18 4>;
-		clocks = <&tcb0_clk>, <&clk32k>;
-		clock-names = "t0_clk", "slow_clk";
-
-		timer@0 {
-			compatible = "atmel,tcb-timer";
-			reg = <0>, <1>;
-		};
-
-		timer@2 {
-			compatible = "atmel,tcb-timer";
-			reg = <2>;
-		};
-	};
-
-One interrupt per TC channel in a TC block:
-	tcb1: timer@fffdc000 {
-		compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0xfffdc000 0x100>;
-		interrupts = <26 4>, <27 4>, <28 4>;
-		clocks = <&tcb1_clk>, <&clk32k>;
-		clock-names = "t0_clk", "slow_clk";
-	};
-
-
diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
new file mode 100644
index 0000000..9d680e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/microchip/atmel,at91rm9200-tcb.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Atmel Timer Counter Block
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+
+description: |
+  The Atmel (now Microchip) SoCs have timers named Timer Counter Block. Each
+  timer has three channels with two counters each.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - atmel,at91rm9200-tcb
+          - atmel,at91sam9x5-tcb
+      - const: simple-mfd
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      List of interrupts. One interrupt per TCB channel if available or one
+      interrupt for the TC block
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    description:
+      List of clock names. Always includes t0_clk and slow clk. Also includes
+      t1_clk and t2_clk if a clock per channel is available.
+    oneOf:
+      - items:
+        - const: t0_clk
+        - const: slow_clk
+      - items:
+        - const: t0_clk
+        - const: t1_clk
+        - const: t2_clk
+        - const: slow_clk
+    minItems: 2
+    maxItems: 4
+
+  clocks:
+    minItems: 2
+    maxItems: 4
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^timer@[0-2]$":
+    description: The timer block channels that are used as timers.
+    type: object
+    properties:
+      compatible:
+        const: atmel,tcb-timer
+      reg:
+        description:
+          List of channels to use for this particular timer.
+        minItems: 1
+        maxItems: 3
+
+    required:
+      - compatible
+      - reg
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    /* One interrupt per TC block: */
+        tcb0: timer@fff7c000 {
+                compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0xfff7c000 0x100>;
+                interrupts = <18 4>;
+                clocks = <&tcb0_clk>, <&clk32k>;
+                clock-names = "t0_clk", "slow_clk";
+
+                timer@0 {
+                        compatible = "atmel,tcb-timer";
+                        reg = <0>, <1>;
+                };
+
+                timer@2 {
+                        compatible = "atmel,tcb-timer";
+                        reg = <2>;
+                };
+        };
+
+    /* One interrupt per TC channel in a TC block: */
+        tcb1: timer@fffdc000 {
+                compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0xfffdc000 0x100>;
+                interrupts = <26 4>, <27 4>, <28 4>;
+                clocks = <&tcb1_clk>, <&clk32k>;
+                clock-names = "t0_clk", "slow_clk";
+
+                timer@0 {
+                        compatible = "atmel,tcb-timer";
+                        reg = <0>;
+                };
+
+                timer@1 {
+                        compatible = "atmel,tcb-timer";
+                        reg = <1>;
+                };
+        };
