Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4130C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB4C7206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgD1GfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 02:35:04 -0400
Received: from mx.socionext.com ([202.248.49.38]:22326 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgD1GfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:35:03 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 28 Apr 2020 15:35:01 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id C2875180105;
        Tue, 28 Apr 2020 15:35:01 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 28 Apr 2020 15:35:01 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 808AA1A01BB;
        Tue, 28 Apr 2020 15:35:01 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/3] dt-bindings: phy: Convert UniPhier PCIe-PHY controller to json-schema
Date:   Tue, 28 Apr 2020 15:34:48 +0900
Message-Id: <1588055690-13200-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the UniPhier PCIe-PHY controller to DT schema format.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/phy/socionext,uniphier-pcie-phy.yaml  | 77 ++++++++++++++++++++++
 .../devicetree/bindings/phy/uniphier-pcie-phy.txt  | 36 ----------
 2 files changed, 77 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml
new file mode 100644
index 0000000..86f4909
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/socionext,uniphier-pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier PCIe PHY
+
+description: |
+  This describes the devicetree bindings for PHY interface built into
+  PCIe controller implemented on Socionext UniPhier SoCs.
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+properties:
+  compatible:
+    enum:
+      - socionext,uniphier-pro5-pcie-phy
+      - socionext,uniphier-ld20-pcie-phy
+      - socionext,uniphier-pxs3-pcie-phy
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
+      - items:            # for Pro5
+        - const: gio
+        - const: link
+      - const: link       # for others
+
+  resets:
+    minItems: 1
+    maxItems: 2
+
+  reset-names:
+    oneOf:
+      - items:            # for Pro5
+        - const: gio
+        - const: link
+      - const: link       # for others
+
+  socionext,syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: A phandle to system control to set configurations for phy
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
+    pcie_phy: phy@66038000 {
+        compatible = "socionext,uniphier-ld20-pcie-phy";
+        reg = <0x66038000 0x4000>;
+        #phy-cells = <0>;
+        clock-names = "link";
+        clocks = <&sys_clk 24>;
+        reset-names = "link";
+        resets = <&sys_rst 24>;
+        socionext,syscon = <&soc_glue>;
+    };
diff --git a/Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt b/Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt
deleted file mode 100644
index 3cee372..0000000
--- a/Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Socionext UniPhier PCIe PHY bindings
-
-This describes the devicetree bindings for PHY interface built into
-PCIe controller implemented on Socionext UniPhier SoCs.
-
-Required properties:
-- compatible: Should contain one of the following:
-    "socionext,uniphier-pro5-pcie-phy" - for Pro5 PHY
-    "socionext,uniphier-ld20-pcie-phy" - for LD20 PHY
-    "socionext,uniphier-pxs3-pcie-phy" - for PXs3 PHY
-- reg: Specifies offset and length of the register set for the device.
-- #phy-cells: Must be zero.
-- clocks: A list of phandles to the clock gate for PCIe glue layer
-	including this phy.
-- clock-names: For Pro5 only, should contain the following:
-    "gio", "link" - for Pro5 SoC
-- resets: A list of phandles to the reset line for PCIe glue layer
-	including this phy.
-- reset-names: For Pro5 only, should contain the following:
-    "gio", "link" - for Pro5 SoC
-
-Optional properties:
-- socionext,syscon: A phandle to system control to set configurations
-	for phy.
-
-Refer to phy/phy-bindings.txt for the generic PHY binding properties.
-
-Example:
-	pcie_phy: phy@66038000 {
-		compatible = "socionext,uniphier-ld20-pcie-phy";
-		reg = <0x66038000 0x4000>;
-		#phy-cells = <0>;
-		clocks = <&sys_clk 24>;
-		resets = <&sys_rst 24>;
-		socionext,syscon = <&soc_glue>;
-	};
-- 
2.7.4

