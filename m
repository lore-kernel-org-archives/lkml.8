Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C30C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3986D2051A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgD1GfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 02:35:10 -0400
Received: from mx.socionext.com ([202.248.49.38]:22330 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgD1GfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:35:08 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 28 Apr 2020 15:35:04 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 55141180105;
        Tue, 28 Apr 2020 15:35:04 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 28 Apr 2020 15:35:04 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id F1BCC1A01BB;
        Tue, 28 Apr 2020 15:35:03 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 3/3] dt-bindings: phy: Convert UniPhier USB3-PHY conroller to json-schema
Date:   Tue, 28 Apr 2020 15:34:50 +0900
Message-Id: <1588055690-13200-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588055690-13200-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1588055690-13200-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the UniPhier USB3-PHY controller for SS/HS to DT schema format.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../phy/socionext,uniphier-usb3hs-phy.yaml         | 104 +++++++++++++++++++++
 .../phy/socionext,uniphier-usb3ss-phy.yaml         |  97 +++++++++++++++++++
 .../bindings/phy/uniphier-usb3-hsphy.txt           |  69 --------------
 .../bindings/phy/uniphier-usb3-ssphy.txt           |  58 ------------
 4 files changed, 201 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt

diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
new file mode 100644
index 0000000..a92a034
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/socionext,uniphier-usb3hs-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier USB3 High-Speed (HS) PHY
+
+description: |
+  This describes the devicetree bindings for PHY interfaces built into
+  USB3 controller implemented on Socionext UniPhier SoCs.
+  Although the controller includes High-Speed PHY and Super-Speed PHY,
+  this describes about High-Speed PHY.
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+properties:
+  compatible:
+    enum:
+      - socionext,uniphier-pro5-usb3-hsphy
+      - socionext,uniphier-pxs2-usb3-hsphy
+      - socionext,uniphier-ld20-usb3-hsphy
+      - socionext,uniphier-pxs3-usb3-hsphy
+
+  reg:
+    description: PHY register region (offset and length)
+
+  "#phy-cells":
+    const: 0
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    oneOf:
+      - const: link          # for PXs2
+      - items:               # for PXs3
+        - const: link
+        - const: phy
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: link
+      - const: phy
+
+  vbus-supply:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: A phandle to the regulator for USB VBUS
+
+  nvmem-cells:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Phandles to nvmem cell that contains the trimming data.
+      Available only for HS-PHY implemented on LD20 and PXs3, and
+      if unspecified, default value is used.
+
+  nvmem-cell-names:
+    items:
+      - const: rterm
+      - const: sel_t
+      - const: hs_i
+    description:
+      Should be the following names, which correspond to each nvmem-cells.
+      All of the 3 parameters associated with the above names are
+      required for each port, if any one is omitted, the trimming data
+      of the port will not be set at all.
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    usb-glue@65b00000 {
+        compatible = "socionext,uniphier-ld20-dwc3-glue", "simple-mfd";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x65b00000 0x400>;
+
+        usb_hsphy0: hs-phy@200 {
+            compatible = "socionext,uniphier-ld20-usb3-hsphy";
+            reg = <0x200 0x10>;
+            #phy-cells = <0>;
+            clock-names = "link", "phy";
+            clocks = <&sys_clk 14>, <&sys_clk 16>;
+            reset-names = "link", "phy";
+            resets = <&sys_rst 14>, <&sys_rst 16>;
+            vbus-supply = <&usb_vbus0>;
+            nvmem-cell-names = "rterm", "sel_t", "hs_i";
+            nvmem-cells = <&usb_rterm0>, <&usb_sel_t0>, <&usb_hs_i0>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
new file mode 100644
index 0000000..ed67707
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/socionext,uniphier-usb3ss-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier USB3 Super-Speed (SS) PHY
+
+description: |
+  This describes the devicetree bindings for PHY interfaces built into
+  USB3 controller implemented on Socionext UniPhier SoCs.
+  Although the controller includes High-Speed PHY and Super-Speed PHY,
+  this describes about Super-Speed PHY.
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+properties:
+  compatible:
+    enum:
+      - socionext,uniphier-pro4-usb3-ssphy
+      - socionext,uniphier-pro5-usb3-ssphy
+      - socionext,uniphier-pxs2-usb3-ssphy
+      - socionext,uniphier-ld20-usb3-ssphy
+      - socionext,uniphier-pxs3-usb3-ssphy
+
+  reg:
+    description: PHY register region (offset and length)
+
+  "#phy-cells":
+    const: 0
+
+  clocks:
+    minItems: 2
+    maxItems: 3
+
+  clock-names:
+    oneOf:
+      - items:             # for Pro4, Pro5
+        - const: gio
+        - const: link
+      - items:             # for PXs3 with phy-ext
+        - const: link
+        - const: phy
+        - const: phy-ext
+      - items:             # for others
+        - const: link
+        - const: phy
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    oneOf:
+      - items:              # for Pro4,Pro5
+        - const: gio
+        - const: link
+      - items:              # for others
+        - const: link
+        - const: phy
+
+  vbus-supply:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: A phandle to the regulator for USB VBUS
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - vbus-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    usb-glue@65b00000 {
+        compatible = "socionext,uniphier-ld20-dwc3-glue",
+                     "simple-mfd";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x65b00000 0x400>;
+
+        usb_ssphy0: ss-phy@300 {
+            compatible = "socionext,uniphier-ld20-usb3-ssphy";
+            reg = <0x300 0x10>;
+            #phy-cells = <0>;
+            clock-names = "link", "phy";
+            clocks = <&sys_clk 14>, <&sys_clk 16>;
+            reset-names = "link", "phy";
+            resets = <&sys_rst 14>, <&sys_rst 16>;
+            vbus-supply = <&usb_vbus0>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt b/Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt
deleted file mode 100644
index 093d4f0..0000000
--- a/Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt
+++ /dev/null
@@ -1,69 +0,0 @@
-Socionext UniPhier USB3 High-Speed (HS) PHY
-
-This describes the devicetree bindings for PHY interfaces built into
-USB3 controller implemented on Socionext UniPhier SoCs.
-Although the controller includes High-Speed PHY and Super-Speed PHY,
-this describes about High-Speed PHY.
-
-Required properties:
-- compatible: Should contain one of the following:
-    "socionext,uniphier-pro5-usb3-hsphy" - for Pro5 SoC
-    "socionext,uniphier-pxs2-usb3-hsphy" - for PXs2 SoC
-    "socionext,uniphier-ld20-usb3-hsphy" - for LD20 SoC
-    "socionext,uniphier-pxs3-usb3-hsphy" - for PXs3 SoC
-- reg: Specifies offset and length of the register set for the device.
-- #phy-cells: Should be 0.
-- clocks: A list of phandles to the clock gate for USB3 glue layer.
-	According to the clock-names, appropriate clocks are required.
-- clock-names: Should contain the following:
-    "gio", "link" - for Pro5 SoC
-    "phy", "phy-ext", "link" - for PXs3 SoC, "phy-ext" is optional.
-    "phy", "link" - for others
-- resets: A list of phandles to the reset control for USB3 glue layer.
-	According to the reset-names, appropriate resets are required.
-- reset-names: Should contain the following:
-    "gio", "link" - for Pro5 SoC
-    "phy", "link" - for others
-
-Optional properties:
-- vbus-supply: A phandle to the regulator for USB VBUS.
-- nvmem-cells: Phandles to nvmem cell that contains the trimming data.
-	Available only for HS-PHY implemented on LD20 and PXs3, and
-	if unspecified, default value is used.
-- nvmem-cell-names: Should be the following names, which correspond to
-	each nvmem-cells.
-	All of the 3 parameters associated with the following names are
-	required for each port, if any one is omitted, the trimming data
-	of the port will not be set at all.
-    "rterm", "sel_t", "hs_i" - Each cell name for phy parameters
-
-Refer to phy/phy-bindings.txt for the generic PHY binding properties.
-
-Example:
-
-	usb-glue@65b00000 {
-		compatible = "socionext,uniphier-ld20-dwc3-glue",
-			     "simple-mfd";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0x65b00000 0x400>;
-
-		usb_vbus0: regulator {
-			...
-		};
-
-		usb_hsphy0: hs-phy@200 {
-			compatible = "socionext,uniphier-ld20-usb3-hsphy";
-			reg = <0x200 0x10>;
-			#phy-cells = <0>;
-			clock-names = "link", "phy";
-			clocks = <&sys_clk 14>, <&sys_clk 16>;
-			reset-names = "link", "phy";
-			resets = <&sys_rst 14>, <&sys_rst 16>;
-			vbus-supply = <&usb_vbus0>;
-			nvmem-cell-names = "rterm", "sel_t", "hs_i";
-			nvmem-cells = <&usb_rterm0>, <&usb_sel_t0>,
-				      <&usb_hs_i0>;
-		};
-		...
-	};
diff --git a/Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt b/Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt
deleted file mode 100644
index 9df2bc2..0000000
--- a/Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-Socionext UniPhier USB3 Super-Speed (SS) PHY
-
-This describes the devicetree bindings for PHY interfaces built into
-USB3 controller implemented on Socionext UniPhier SoCs.
-Although the controller includes High-Speed PHY and Super-Speed PHY,
-this describes about Super-Speed PHY.
-
-Required properties:
-- compatible: Should contain one of the following:
-    "socionext,uniphier-pro4-usb3-ssphy" - for Pro4 SoC
-    "socionext,uniphier-pro5-usb3-ssphy" - for Pro5 SoC
-    "socionext,uniphier-pxs2-usb3-ssphy" - for PXs2 SoC
-    "socionext,uniphier-ld20-usb3-ssphy" - for LD20 SoC
-    "socionext,uniphier-pxs3-usb3-ssphy" - for PXs3 SoC
-- reg: Specifies offset and length of the register set for the device.
-- #phy-cells: Should be 0.
-- clocks: A list of phandles to the clock gate for USB3 glue layer.
-	According to the clock-names, appropriate clocks are required.
-- clock-names:
-    "gio", "link" - for Pro4 and Pro5 SoC
-    "phy", "phy-ext", "link" - for PXs3 SoC, "phy-ext" is optional.
-    "phy", "link" - for others
-- resets: A list of phandles to the reset control for USB3 glue layer.
-	According to the reset-names, appropriate resets are required.
-- reset-names:
-    "gio", "link" - for Pro4 and Pro5 SoC
-    "phy", "link" - for others
-
-Optional properties:
-- vbus-supply: A phandle to the regulator for USB VBUS.
-
-Refer to phy/phy-bindings.txt for the generic PHY binding properties.
-
-Example:
-
-	usb-glue@65b00000 {
-		compatible = "socionext,uniphier-ld20-dwc3-glue",
-			     "simple-mfd";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0x65b00000 0x400>;
-
-		usb_vbus0: regulator {
-			...
-		};
-
-		usb_ssphy0: ss-phy@300 {
-			compatible = "socionext,uniphier-ld20-usb3-ssphy";
-			reg = <0x300 0x10>;
-			#phy-cells = <0>;
-			clock-names = "link", "phy";
-			clocks = <&sys_clk 14>, <&sys_clk 16>;
-			reset-names = "link", "phy";
-			resets = <&sys_rst 14>, <&sys_rst 16>;
-			vbus-supply = <&usb_vbus0>;
-		};
-		...
-	};
-- 
2.7.4

