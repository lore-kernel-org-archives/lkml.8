Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3009C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A1852051A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgD1GfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 02:35:06 -0400
Received: from mx.socionext.com ([202.248.49.38]:22330 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgD1GfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:35:04 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 28 Apr 2020 15:35:02 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id D7E00180105;
        Tue, 28 Apr 2020 15:35:02 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 28 Apr 2020 15:35:02 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id A5FC01A01BB;
        Tue, 28 Apr 2020 15:35:02 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 2/3] dt-bindings: phy: Convert UniPhier USB2-PHY controller to json-schema
Date:   Tue, 28 Apr 2020 15:34:49 +0900
Message-Id: <1588055690-13200-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588055690-13200-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1588055690-13200-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the UniPhier USB2-PHY conroller to DT schema format.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/phy/socionext,uniphier-usb2-phy.yaml  | 85 ++++++++++++++++++++++
 .../devicetree/bindings/phy/uniphier-usb2-phy.txt  | 45 ------------
 2 files changed, 85 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-usb2-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb2-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb2-phy.yaml
new file mode 100644
index 0000000..479b203
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb2-phy.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/socionext,uniphier-usb2-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier USB2 PHY
+
+description: |
+  This describes the devicetree bindings for PHY interface built into
+  USB2 controller implemented on Socionext UniPhier SoCs.
+  Pro4 SoC has both USB2 and USB3 host controllers, however, this USB3
+  controller doesn't include its own High-Speed PHY. This needs to specify
+  USB2 PHY instead of USB3 HS-PHY.
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+properties:
+  compatible:
+    enum:
+      - socionext,uniphier-pro4-usb2-phy
+      - socionext,uniphier-ld11-usb2-phy
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^phy@[0-9]+$":
+    type: object
+    additionalProperties: false
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 3
+        description:
+          The ID number for the PHY
+
+      "#phy-cells":
+        const: 0
+
+    required:
+      - reg
+      - "#phy-cells"
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    // The UniPhier usb2-phy should be a subnode of a "syscon" compatible node.
+
+    soc-glue@5f800000 {
+        compatible = "socionext,uniphier-ld11-soc-glue", "simple-mfd", "syscon";
+        reg = <0x5f800000 0x2000>;
+
+        usb-controller {
+            compatible = "socionext,uniphier-ld11-usb2-phy";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            usb_phy0: phy@0 {
+                reg = <0>;
+                #phy-cells = <0>;
+            };
+
+            usb_phy1: phy@1 {
+                reg = <1>;
+                #phy-cells = <0>;
+            };
+
+            usb_phy2: phy@2 {
+                reg = <2>;
+                #phy-cells = <0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/phy/uniphier-usb2-phy.txt b/Documentation/devicetree/bindings/phy/uniphier-usb2-phy.txt
deleted file mode 100644
index b43b282..0000000
--- a/Documentation/devicetree/bindings/phy/uniphier-usb2-phy.txt
+++ /dev/null
@@ -1,45 +0,0 @@
-Socionext UniPhier USB2 PHY
-
-This describes the devicetree bindings for PHY interface built into
-USB2 controller implemented on Socionext UniPhier SoCs.
-
-Pro4 SoC has both USB2 and USB3 host controllers, however, this USB3
-controller doesn't include its own High-Speed PHY. This needs to specify
-USB2 PHY instead of USB3 HS-PHY.
-
-Required properties:
-- compatible: Should contain one of the following:
-    "socionext,uniphier-pro4-usb2-phy" - for Pro4 SoC
-    "socionext,uniphier-ld11-usb2-phy" - for LD11 SoC
-
-Sub-nodes:
-Each PHY should be represented as a sub-node.
-
-Sub-nodes required properties:
-- #phy-cells: Should be 0.
-- reg: The number of the PHY.
-
-Sub-nodes optional properties:
-- vbus-supply: A phandle to the regulator for USB VBUS.
-
-Refer to phy/phy-bindings.txt for the generic PHY binding properties.
-
-Example:
-	soc-glue@5f800000 {
-		...
-		usb-phy {
-			compatible = "socionext,uniphier-ld11-usb2-phy";
-			usb_phy0: phy@0 {
-				reg = <0>;
-				#phy-cells = <0>;
-			};
-			...
-		};
-	};
-
-	usb@5a800100 {
-		compatible = "socionext,uniphier-ehci", "generic-ehci";
-		...
-		phy-names = "usb";
-		phys = <&usb_phy0>;
-	};
-- 
2.7.4

