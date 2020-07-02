Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF75C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B2321707
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgGBV3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:29:08 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:55688 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726048AbgGBV27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:28:59 -0400
Received: from [88.147.89.201] (port=34632 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jr6lK-000AXd-TL; Thu, 02 Jul 2020 23:28:54 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-clk@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH 3/5] dt-bindings: clk: versaclock5: convert to yaml
Date:   Thu,  2 Jul 2020 23:28:34 +0200
Message-Id: <20200702212837.10657-3-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702212837.10657-1-luca@lucaceresoli.net>
References: <20200702212837.10657-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to yaml the VersaClock bindings document. The mapping between
clock specifier and physical pins cannot be described formally in yaml
schema, then keep it verbatim in the description field.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 .../bindings/clock/idt,versaclock5.txt        |  92 --------------
 .../bindings/clock/idt,versaclock5.yaml       | 120 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 3 files changed, 121 insertions(+), 92 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/idt,versaclock5.txt
 create mode 100644 Documentation/devicetree/bindings/clock/idt,versaclock5.yaml

diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
deleted file mode 100644
index bcff681a4bd0..000000000000
--- a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
+++ /dev/null
@@ -1,92 +0,0 @@
-Binding for IDT VersaClock 5,6 programmable i2c clock generators.
-
-The IDT VersaClock 5 and VersaClock 6 are programmable i2c clock
-generators providing from 3 to 12 output clocks.
-
-==I2C device node==
-
-Required properties:
-- compatible:	shall be one of
-		"idt,5p49v5923"
-		"idt,5p49v5925"
-		"idt,5p49v5933"
-		"idt,5p49v5935"
-		"idt,5p49v6901"
-		"idt,5p49v6965"
-- reg:		i2c device address, shall be 0x68 or 0x6a.
-- #clock-cells:	from common clock binding; shall be set to 1.
-- clocks:	from common clock binding; list of parent clock handles,
-		- 5p49v5923 and
-		  5p49v5925 and
-		  5p49v6901: (required) either or both of XTAL or CLKIN
-					reference clock.
-		- 5p49v5933 and
-		- 5p49v5935: (optional) property not present (internal
-					Xtal used) or CLKIN reference
-					clock.
-- clock-names:	from common clock binding; clock input names, can be
-		- 5p49v5923 and
-		  5p49v5925 and
-		  5p49v6901: (required) either or both of "xin", "clkin".
-		- 5p49v5933 and
-		- 5p49v5935: (optional) property not present or "clkin".
-
-==Mapping between clock specifier and physical pins==
-
-When referencing the provided clock in the DT using phandle and
-clock specifier, the following mapping applies:
-
-5P49V5923:
-	0 -- OUT0_SEL_I2CB
-	1 -- OUT1
-	2 -- OUT2
-
-5P49V5933:
-	0 -- OUT0_SEL_I2CB
-	1 -- OUT1
-	2 -- OUT4
-
-5P49V5925 and
-5P49V5935:
-	0 -- OUT0_SEL_I2CB
-	1 -- OUT1
-	2 -- OUT2
-	3 -- OUT3
-	4 -- OUT4
-
-5P49V6901:
-	0 -- OUT0_SEL_I2CB
-	1 -- OUT1
-	2 -- OUT2
-	3 -- OUT3
-	4 -- OUT4
-
-==Example==
-
-/* 25MHz reference crystal */
-ref25: ref25m {
-	compatible = "fixed-clock";
-	#clock-cells = <0>;
-	clock-frequency = <25000000>;
-};
-
-i2c-master-node {
-
-	/* IDT 5P49V5923 i2c clock generator */
-	vc5: clock-generator@6a {
-		compatible = "idt,5p49v5923";
-		reg = <0x6a>;
-		#clock-cells = <1>;
-
-		/* Connect XIN input to 25MHz reference */
-		clocks = <&ref25m>;
-		clock-names = "xin";
-	};
-};
-
-/* Consumer referencing the 5P49V5923 pin OUT1 */
-consumer {
-	...
-	clocks = <&vc5 1>;
-	...
-}
diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
new file mode 100644
index 000000000000..d8b8e35f16d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/idt,versaclock5.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binding for IDT VersaClock 5 and 6 programmable I2C clock generators
+
+description: |
+  The IDT VersaClock 5 and VersaClock 6 are programmable I2C
+  clock generators providing from 3 to 12 output clocks.
+
+  When referencing the provided clock in the DT using phandle and clock
+  specifier, the following mapping applies:
+
+  - 5P49V5923:
+    0 -- OUT0_SEL_I2CB
+    1 -- OUT1
+    2 -- OUT2
+
+  - 5P49V5933:
+    0 -- OUT0_SEL_I2CB
+    1 -- OUT1
+    2 -- OUT4
+
+  - other parts:
+    0 -- OUT0_SEL_I2CB
+    1 -- OUT1
+    2 -- OUT2
+    3 -- OUT3
+    4 -- OUT4
+
+maintainers:
+  - Luca Ceresoli <luca@lucaceresoli.net>
+
+properties:
+  compatible:
+    enum:
+      - idt,5p49v5923
+      - idt,5p49v5925
+      - idt,5p49v5933
+      - idt,5p49v5935
+      - idt,5p49v6901
+      - idt,5p49v6965
+
+  reg:
+    maxItems: 1
+    description: I2C device address, shall be 0x68 or 0x6a.
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - idt,5p49v5933
+              - idt,5p49v5935
+    then:
+      # Devices with builtin crystal, optional external input
+      properties:
+        clock-names:
+          const: clkin
+        clocks:
+          maxItems: 1
+    else:
+      # Devices without builtin crystal
+      properties:
+        clock-names:
+          anyOf:
+            - required: [ xin ]
+            - required: [ clkin ]
+        clocks:
+          minItems: 1
+          maxItems: 2
+      required:
+        - clock-names
+        - clocks
+
+examples:
+  - |
+    /* 25MHz reference crystal */
+    ref25: ref25m {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <25000000>;
+    };
+
+    i2c@0 {
+        reg = <0x0 0x100>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* IDT 5P49V5923 I2C clock generator */
+        vc5: clock-generator@6a {
+            compatible = "idt,5p49v5923";
+            reg = <0x6a>;
+            #clock-cells = <1>;
+
+            /* Connect XIN input to 25MHz reference */
+            clocks = <&ref25m>;
+            clock-names = "xin";
+        };
+    };
+
+    /* Consumer referencing the 5P49V5923 pin OUT1 */
+    consumer {
+        /* ... */
+        clocks = <&vc5 1>;
+        /* ... */
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 079e19ed2ec9..e979f5026353 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8326,6 +8326,7 @@ F:	drivers/input/misc/ideapad_slidebar.c
 IDT VersaClock 5 CLOCK DRIVER
 M:	Luca Ceresoli <luca@lucaceresoli.net>
 S:	Maintained
+F:	Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
 F:	drivers/clk/clk-versaclock5.c
 
 IEEE 802.15.4 SUBSYSTEM
-- 
2.27.0

