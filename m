Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26ECC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 952A4206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EffVA766"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgFVLuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:50:05 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:31734 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgFVLuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:50:03 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 05MBmUTK027768;
        Mon, 22 Jun 2020 20:48:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 05MBmUTK027768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592826510;
        bh=f3EMttsKXE8wNghn4PUIkbuq9XEwF9UBbOhFXf+0tEM=;
        h=From:To:Cc:Subject:Date:From;
        b=EffVA766bsXs0n9u8OkWf4xQynGfSdkWMT4HeX/Km0vF0bsfBxzerDUwLDSnEC1K8
         DOSLb+82bW93i/JmF0RdINFHFT7drAheGrR2iQ+k7sJO3R2Vpvp1qXgryZspiIdB3A
         LSMFteQi1niRGNhrmmqnIu50IQboMyi8drVd0Kw3/+0veJ3H/mxWVCLNMIJ+ZqhrIi
         FImWJnKxi1IMh6rB30oqeAFDS396u5SxfXGJlvmZ56TA3AKlkcOe1g5/suiCYEeE5+
         onpOHeqRfQn1cXpq0UHAIKvP1SAZYewvxkAq86qMc7dzeaJAwGFjrZxwWv3rDSQZlE
         X0kztVDqz+Zmw==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: reset: Convert UniPhier reset to json-schema
Date:   Mon, 22 Jun 2020 20:48:26 +0900
Message-Id: <20200622114826.450442-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the UniPhier reset controller binding to DT schema format.
I excluded the glue resets because their bindings are too different.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../reset/socionext,uniphier-reset.yaml       | 112 ++++++++++++++++
 .../bindings/reset/uniphier-reset.txt         | 121 +-----------------
 2 files changed, 113 insertions(+), 120 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml b/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml
new file mode 100644
index 000000000000..4c9b0ebf6869
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/socionext,uniphier-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UniPhier reset controller
+
+maintainers:
+  - Masahiro Yamada <yamada.masahiro@socionext.com>
+
+properties:
+  compatible:
+    oneOf:
+      - description: System reset
+        enum:
+          - socionext,uniphier-ld4-reset
+          - socionext,uniphier-pro4-reset
+          - socionext,uniphier-sld8-reset
+          - socionext,uniphier-pro5-reset
+          - socionext,uniphier-pxs2-reset
+          - socionext,uniphier-ld6b-reset
+          - socionext,uniphier-ld11-reset
+          - socionext,uniphier-ld20-reset
+          - socionext,uniphier-pxs3-reset
+      - description: Media I/O (MIO) reset, SD reset
+        enum:
+          - socionext,uniphier-ld4-mio-reset
+          - socionext,uniphier-pro4-mio-reset
+          - socionext,uniphier-sld8-mio-reset
+          - socionext,uniphier-pro5-sd-reset
+          - socionext,uniphier-pxs2-sd-reset
+          - socionext,uniphier-ld11-mio-reset
+          - socionext,uniphier-ld11-sd-reset
+          - socionext,uniphier-ld20-sd-reset
+          - socionext,uniphier-pxs3-sd-reset
+      - description: Peripheral reset
+        enum:
+          - socionext,uniphier-ld4-peri-reset
+          - socionext,uniphier-pro4-peri-reset
+          - socionext,uniphier-sld8-peri-reset
+          - socionext,uniphier-pro5-peri-reset
+          - socionext,uniphier-pxs2-peri-reset
+          - socionext,uniphier-ld11-peri-reset
+          - socionext,uniphier-ld20-peri-reset
+          - socionext,uniphier-pxs3-peri-reset
+      - description: Analog signal amplifier reset
+        enum:
+          - socionext,uniphier-ld11-adamv-reset
+          - socionext,uniphier-ld20-adamv-reset
+
+  "#reset-cells":
+    const: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - "#reset-cells"
+
+examples:
+  - |
+    sysctrl@61840000 {
+        compatible = "socionext,uniphier-sysctrl", "simple-mfd", "syscon";
+        reg = <0x61840000 0x4000>;
+
+        reset {
+            compatible = "socionext,uniphier-ld11-reset";
+            #reset-cells = <1>;
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
+        reset {
+            compatible = "socionext,uniphier-ld11-mio-reset";
+            #reset-cells = <1>;
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
+        reset {
+            compatible = "socionext,uniphier-ld11-peri-reset";
+            #reset-cells = <1>;
+        };
+
+        // other nodes ...
+    };
+
+  - |
+    adamv@57920000 {
+        compatible = "socionext,uniphier-ld11-adamv", "simple-mfd", "syscon";
+        reg = <0x57920000 0x1000>;
+
+        reset {
+            compatible = "socionext,uniphier-ld11-adamv-reset";
+            #reset-cells = <1>;
+        };
+
+        // other nodes ...
+    };
diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
index e320a8cc9e4d..88e06e5e8d23 100644
--- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
+++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
@@ -1,123 +1,4 @@
-UniPhier reset controller
-
-
-System reset
-------------
-
-Required properties:
-- compatible: should be one of the following:
-    "socionext,uniphier-ld4-reset"  - for LD4 SoC
-    "socionext,uniphier-pro4-reset" - for Pro4 SoC
-    "socionext,uniphier-sld8-reset" - for sLD8 SoC
-    "socionext,uniphier-pro5-reset" - for Pro5 SoC
-    "socionext,uniphier-pxs2-reset" - for PXs2/LD6b SoC
-    "socionext,uniphier-ld11-reset" - for LD11 SoC
-    "socionext,uniphier-ld20-reset" - for LD20 SoC
-    "socionext,uniphier-pxs3-reset" - for PXs3 SoC
-- #reset-cells: should be 1.
-
-Example:
-
-	sysctrl@61840000 {
-		compatible = "socionext,uniphier-ld11-sysctrl",
-			     "simple-mfd", "syscon";
-		reg = <0x61840000 0x4000>;
-
-		reset {
-			compatible = "socionext,uniphier-ld11-reset";
-			#reset-cells = <1>;
-		};
-
-		other nodes ...
-	};
-
-
-Media I/O (MIO) reset, SD reset
--------------------------------
-
-Required properties:
-- compatible: should be one of the following:
-    "socionext,uniphier-ld4-mio-reset"  - for LD4 SoC
-    "socionext,uniphier-pro4-mio-reset" - for Pro4 SoC
-    "socionext,uniphier-sld8-mio-reset" - for sLD8 SoC
-    "socionext,uniphier-pro5-sd-reset"  - for Pro5 SoC
-    "socionext,uniphier-pxs2-sd-reset"  - for PXs2/LD6b SoC
-    "socionext,uniphier-ld11-mio-reset" - for LD11 SoC (MIO)
-    "socionext,uniphier-ld11-sd-reset"  - for LD11 SoC (SD)
-    "socionext,uniphier-ld20-sd-reset"  - for LD20 SoC
-    "socionext,uniphier-pxs3-sd-reset"  - for PXs3 SoC
-- #reset-cells: should be 1.
-
-Example:
-
-	mioctrl@59810000 {
-		compatible = "socionext,uniphier-ld11-mioctrl",
-			     "simple-mfd", "syscon";
-		reg = <0x59810000 0x800>;
-
-		reset {
-			compatible = "socionext,uniphier-ld11-mio-reset";
-			#reset-cells = <1>;
-		};
-
-		other nodes ...
-	};
-
-
-Peripheral reset
-----------------
-
-Required properties:
-- compatible: should be one of the following:
-    "socionext,uniphier-ld4-peri-reset"  - for LD4 SoC
-    "socionext,uniphier-pro4-peri-reset" - for Pro4 SoC
-    "socionext,uniphier-sld8-peri-reset" - for sLD8 SoC
-    "socionext,uniphier-pro5-peri-reset" - for Pro5 SoC
-    "socionext,uniphier-pxs2-peri-reset" - for PXs2/LD6b SoC
-    "socionext,uniphier-ld11-peri-reset" - for LD11 SoC
-    "socionext,uniphier-ld20-peri-reset" - for LD20 SoC
-    "socionext,uniphier-pxs3-peri-reset" - for PXs3 SoC
-- #reset-cells: should be 1.
-
-Example:
-
-	perictrl@59820000 {
-		compatible = "socionext,uniphier-ld11-perictrl",
-			     "simple-mfd", "syscon";
-		reg = <0x59820000 0x200>;
-
-		reset {
-			compatible = "socionext,uniphier-ld11-peri-reset";
-			#reset-cells = <1>;
-		};
-
-		other nodes ...
-	};
-
-
-Analog signal amplifier reset
------------------------------
-
-Required properties:
-- compatible: should be one of the following:
-    "socionext,uniphier-ld11-adamv-reset" - for LD11 SoC
-    "socionext,uniphier-ld20-adamv-reset" - for LD20 SoC
-- #reset-cells: should be 1.
-
-Example:
-
-	adamv@57920000 {
-		compatible = "socionext,uniphier-ld11-adamv",
-			     "simple-mfd", "syscon";
-		reg = <0x57920000 0x1000>;
-
-		adamv_rst: reset {
-			compatible = "socionext,uniphier-ld11-adamv-reset";
-			#reset-cells = <1>;
-		};
-
-		other nodes ...
-	};
+UniPhier glue reset controller
 
 
 Peripheral core reset in glue layer
-- 
2.25.1

