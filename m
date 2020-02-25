Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D6EC35DEE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 01:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36EC2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 01:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="J3kDjF/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgBYBEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 20:04:23 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:20545 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgBYBEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 20:04:23 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 01P13V5u029378;
        Tue, 25 Feb 2020 10:03:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 01P13V5u029378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582592612;
        bh=sbdW+j1dev5cR9lqtU/QyEWRKr6L0JmtzRCOHfnmTZ8=;
        h=From:To:Cc:Subject:Date:From;
        b=J3kDjF/84X2/geC8FZQq5+BPzrjHT4tGAK6Q7w3gFY5XKmE74KPF/MrjVAtkZTP0q
         Ovf+rXxc5EAqT1ClAR2MJ+qYOvt4V6yxak1KbNvFn83DmEzmrx23bXWYeWK13TmL3I
         B3/kVHrdt1BwSUFThNMtVhqLDrCOcfL+SteAca58jaF88So0BbhpCzcueiUr/WLaCe
         nGwIdbE0J8vakVeKGya1qO/NFIeAvxvMdvk0UD0FSMd4ZwuANV/1CbzmH7sMADFODW
         hOvhiwcsSgB/NihpN0MMpFU13TtIezvqT3HKL3GJNUo8lpM/D+8Ijp2/h41938BxAm
         b5iBgQQ46eypw==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: Convert UniPhier clock to json-schema
Date:   Tue, 25 Feb 2020 10:03:28 +0900
Message-Id: <20200225010328.5638-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the UniPhier clock controller binding to DT schema format.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../clock/socionext,uniphier-clock.yaml       |  94 +++++++++++++
 .../bindings/clock/uniphier-clock.txt         | 132 ------------------
 2 files changed, 94 insertions(+), 132 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/uniphier-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
new file mode 100644
index 000000000000..c3930edc410f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/socionext,uniphier-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UniPhier clock controller
+
+maintainers:
+  - Masahiro Yamada <yamada.masahiro@socionext.com>
+
+properties:
+  compatible:
+    oneOf:
+      - description: System clock
+        enum:
+          - socionext,uniphier-ld4-clock
+          - socionext,uniphier-pro4-clock
+          - socionext,uniphier-sld8-clock
+          - socionext,uniphier-pro5-clock
+          - socionext,uniphier-pxs2-clock
+          - socionext,uniphier-ld6b-clock
+          - socionext,uniphier-ld11-clock
+          - socionext,uniphier-ld20-clock
+          - socionext,uniphier-pxs3-clock
+      - description: Media I/O (MIO) clock, SD clock
+        enum:
+          - socionext,uniphier-ld4-mio-clock
+          - socionext,uniphier-pro4-mio-clock
+          - socionext,uniphier-sld8-mio-clock
+          - socionext,uniphier-pro5-sd-clock
+          - socionext,uniphier-pxs2-sd-clock
+          - socionext,uniphier-ld11-mio-clock
+          - socionext,uniphier-ld20-sd-clock
+          - socionext,uniphier-pxs3-sd-clock
+      - description: Peripheral clock
+        enum:
+          - socionext,uniphier-ld4-peri-clock
+          - socionext,uniphier-pro4-peri-clock
+          - socionext,uniphier-sld8-peri-clock
+          - socionext,uniphier-pro5-peri-clock
+          - socionext,uniphier-pxs2-peri-clock
+          - socionext,uniphier-ld11-peri-clock
+          - socionext,uniphier-ld20-peri-clock
+          - socionext,uniphier-pxs3-peri-clock
+
+  "#clock-cells":
+    const: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - "#clock-cells"
+
+examples:
+  - |
+    sysctrl@61840000 {
+        compatible = "socionext,uniphier-sysctrl", "simple-mfd", "syscon";
+        reg = <0x61840000 0x4000>;
+
+        clock {
+            compatible = "socionext,uniphier-ld11-clock";
+            #clock-cells = <1>;
+        };
+
+        // other nodes ...
+    };
+
+  - |
+    mioctrl@59810000 {
+        compatible = "socionext,uniphier-mioctrl", "simple-mfd", "syscon";
+        reg = <0x59810000 0x800>;
+
+        clock {
+            compatible = "socionext,uniphier-ld11-mio-clock";
+            #clock-cells = <1>;
+        };
+
+        // other nodes ...
+    };
+
+  - |
+    perictrl@59820000 {
+        compatible = "socionext,uniphier-perictrl", "simple-mfd", "syscon";
+        reg = <0x59820000 0x200>;
+
+        clock {
+            compatible = "socionext,uniphier-ld11-peri-clock";
+            #clock-cells = <1>;
+        };
+
+        // other nodes ...
+    };
diff --git a/Documentation/devicetree/bindings/clock/uniphier-clock.txt b/Documentation/devicetree/bindings/clock/uniphier-clock.txt
deleted file mode 100644
index 7b5f602765fe..000000000000
--- a/Documentation/devicetree/bindings/clock/uniphier-clock.txt
+++ /dev/null
@@ -1,132 +0,0 @@
-UniPhier clock controller
-
-
-System clock
-------------
-
-Required properties:
-- compatible: should be one of the following:
-    "socionext,uniphier-ld4-clock"  - for LD4 SoC.
-    "socionext,uniphier-pro4-clock" - for Pro4 SoC.
-    "socionext,uniphier-sld8-clock" - for sLD8 SoC.
-    "socionext,uniphier-pro5-clock" - for Pro5 SoC.
-    "socionext,uniphier-pxs2-clock" - for PXs2/LD6b SoC.
-    "socionext,uniphier-ld11-clock" - for LD11 SoC.
-    "socionext,uniphier-ld20-clock" - for LD20 SoC.
-    "socionext,uniphier-pxs3-clock" - for PXs3 SoC
-- #clock-cells: should be 1.
-
-Example:
-
-	sysctrl@61840000 {
-		compatible = "socionext,uniphier-sysctrl",
-			     "simple-mfd", "syscon";
-		reg = <0x61840000 0x4000>;
-
-		clock {
-			compatible = "socionext,uniphier-ld11-clock";
-			#clock-cells = <1>;
-		};
-
-		other nodes ...
-	};
-
-Provided clocks:
-
- 8: ST DMAC
-12: GIO (Giga bit stream I/O)
-14: USB3 ch0 host
-15: USB3 ch1 host
-16: USB3 ch0 PHY0
-17: USB3 ch0 PHY1
-20: USB3 ch1 PHY0
-21: USB3 ch1 PHY1
-
-
-Media I/O (MIO) clock, SD clock
--------------------------------
-
-Required properties:
-- compatible: should be one of the following:
-    "socionext,uniphier-ld4-mio-clock"  - for LD4 SoC.
-    "socionext,uniphier-pro4-mio-clock" - for Pro4 SoC.
-    "socionext,uniphier-sld8-mio-clock" - for sLD8 SoC.
-    "socionext,uniphier-pro5-sd-clock"  - for Pro5 SoC.
-    "socionext,uniphier-pxs2-sd-clock"  - for PXs2/LD6b SoC.
-    "socionext,uniphier-ld11-mio-clock" - for LD11 SoC.
-    "socionext,uniphier-ld20-sd-clock"  - for LD20 SoC.
-    "socionext,uniphier-pxs3-sd-clock"  - for PXs3 SoC
-- #clock-cells: should be 1.
-
-Example:
-
-	mioctrl@59810000 {
-		compatible = "socionext,uniphier-mioctrl",
-			     "simple-mfd", "syscon";
-		reg = <0x59810000 0x800>;
-
-		clock {
-			compatible = "socionext,uniphier-ld11-mio-clock";
-			#clock-cells = <1>;
-		};
-
-		other nodes ...
-	};
-
-Provided clocks:
-
- 0: SD ch0 host
- 1: eMMC host
- 2: SD ch1 host
- 7: MIO DMAC
- 8: USB2 ch0 host
- 9: USB2 ch1 host
-10: USB2 ch2 host
-12: USB2 ch0 PHY
-13: USB2 ch1 PHY
-14: USB2 ch2 PHY
-
-
-Peripheral clock
-----------------
-
-Required properties:
-- compatible: should be one of the following:
-    "socionext,uniphier-ld4-peri-clock"  - for LD4 SoC.
-    "socionext,uniphier-pro4-peri-clock" - for Pro4 SoC.
-    "socionext,uniphier-sld8-peri-clock" - for sLD8 SoC.
-    "socionext,uniphier-pro5-peri-clock" - for Pro5 SoC.
-    "socionext,uniphier-pxs2-peri-clock" - for PXs2/LD6b SoC.
-    "socionext,uniphier-ld11-peri-clock" - for LD11 SoC.
-    "socionext,uniphier-ld20-peri-clock" - for LD20 SoC.
-    "socionext,uniphier-pxs3-peri-clock" - for PXs3 SoC
-- #clock-cells: should be 1.
-
-Example:
-
-	perictrl@59820000 {
-		compatible = "socionext,uniphier-perictrl",
-			     "simple-mfd", "syscon";
-		reg = <0x59820000 0x200>;
-
-		clock {
-			compatible = "socionext,uniphier-ld11-peri-clock";
-			#clock-cells = <1>;
-		};
-
-		other nodes ...
-	};
-
-Provided clocks:
-
- 0: UART ch0
- 1: UART ch1
- 2: UART ch2
- 3: UART ch3
- 4: I2C ch0
- 5: I2C ch1
- 6: I2C ch2
- 7: I2C ch3
- 8: I2C ch4
- 9: I2C ch5
-10: I2C ch6
-- 
2.17.1

