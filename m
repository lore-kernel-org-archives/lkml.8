Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D1EC4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B08D20838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgBZKKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:10:15 -0500
Received: from mga04.intel.com ([192.55.52.120]:10953 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgBZKKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 05:10:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 02:10:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,487,1574150400"; 
   d="scan'208";a="284934091"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Feb 2020 02:10:09 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kishon@ti.com, robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v3 2/3] dt-bindings: phy: Add YAML schemas for Intel Combophy
Date:   Wed, 26 Feb 2020 18:09:52 +0800
Message-Id: <9f049a5fccd080bd5d8e9a697b96d4c40a413a0a.1582709320.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1582709320.git.eswara.kota@linux.intel.com>
References: <cover.1582709320.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1582709320.git.eswara.kota@linux.intel.com>
References: <cover.1582709320.git.eswara.kota@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combophy subsystem provides PHY support to various
controllers, viz. PCIe, SATA and EMAC.
Adding YAML schemas for the same.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
Changes on v3:

 Add include/dt-bindings/phy/phy-intel-combphy.h for phy modes.
 Add SoC specific compatible "intel,combophy-lgm".
 Correct the nodename pattern.
 clocks description removed and add maxItems entry.
 Remove "simple-bus" as it expects minimum one address
  cell and size cell in the children node. Call devm_of_platform_populate()
  in the driver to perform "simple-bus" functionality.

Changes on v2:

 Add custom 'select'
 Pass hardware instance entries with phandles and
   remove cell-index and bid entries
 Clock, register address space, are same for the children.
   So move them to parent node.
 Two PHY instances cannot run in different modes,
   so move the phy-mode entry to parent node.
 Add second child entry in the DT example.

 .../devicetree/bindings/phy/intel,combo-phy.yaml   | 123 +++++++++++++++++++++
 include/dt-bindings/phy/phy-intel-combophy.h       |  10 ++
 2 files changed, 133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
 create mode 100644 include/dt-bindings/phy/phy-intel-combophy.h

diff --git a/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
new file mode 100644
index 000000000000..f9bae37fab17
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/intel,combo-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel ComboPhy Subsystem
+
+maintainers:
+  - Dilip Kota <eswara.kota@linux.intel.com>
+
+description: |
+  Intel Combophy subsystem supports PHYs for PCIe, EMAC and SATA
+  controllers. A single Combophy provides two PHY instances.
+
+properties:
+  $nodename:
+    pattern: "combophy(@.*|-[0-9a-f])*$"
+
+  compatible:
+    items:
+      - const: intel,combophy-lgm
+      - const: intel,combo-phy
+
+  clocks:
+    maxItems: 1
+
+  reg:
+    items:
+      - description: ComboPhy core registers
+      - description: PCIe app core control registers
+
+  reg-names:
+    items:
+      - const: core
+      - const: app
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: phy
+      - const: core
+
+  intel,syscfg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: Chip configuration registers handle and ComboPhy instance id
+
+  intel,hsio:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: HSIO registers handle and ComboPhy instance id on NOC
+
+  intel,aggregation:
+    type: boolean
+    description: |
+      Specify the flag to configure ComboPHY in dual lane mode.
+
+  intel,phy-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Mode of the two phys in ComboPhy.
+      See dt-bindings/phy/phy-intel-combophy.h for values.
+
+patternProperties:
+  "^phy@[0-9]+$":
+    type: object
+
+    properties:
+      compatible:
+        const: intel,phydev
+
+      "#phy-cells":
+        const: 0
+
+      resets:
+        description: |
+          reset handle according to the PHY mode.
+          See ../reset/reset.txt for details.
+
+    required:
+      - compatible
+      - "#phy-cells"
+
+required:
+  - compatible
+  - clocks
+  - reg
+  - reg-names
+  - intel,syscfg
+  - intel,hsio
+  - intel,phy-mode
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/phy/phy-intel-combophy.h>
+    combophy@d0a00000 {
+        compatible = "intel,combophy-lgm", "intel,combo-phy";
+        clocks = <&cgu0 1>;
+        reg = <0xd0a00000 0x40000>,
+              <0xd0a40000 0x1000>;
+        reg-names = "core", "app";
+        resets = <&rcu0 0x50 6>,
+                 <&rcu0 0x50 17>;
+        reset-names = "phy", "core";
+        intel,syscfg = <&sysconf 0>;
+        intel,hsio = <&hsiol 0>;
+        intel,phy-mode = <COMBO_PHY_PCIE>;
+
+        phy@0 {
+            compatible = "intel,phydev";
+            #phy-cells = <0>;
+            resets = <&rcu0 0x50 23>;
+        };
+
+        phy@1 {
+            compatible = "intel,phydev";
+            #phy-cells = <0>;
+            resets = <&rcu0 0x50 24>;
+        };
+    };
diff --git a/include/dt-bindings/phy/phy-intel-combophy.h b/include/dt-bindings/phy/phy-intel-combophy.h
new file mode 100644
index 000000000000..bd7f6377f4ef
--- /dev/null
+++ b/include/dt-bindings/phy/phy-intel-combophy.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _DT_BINDINGS_INTEL_COMBOPHY
+#define _DT_BINDINGS_INTEL_COMBOPHY
+
+#define COMBO_PHY_PCIE	0
+#define COMBO_PHY_XPCS	1
+#define COMBO_PHY_SATA	2
+
+#endif /* _DT_BINDINGS_INTEL_COMBOPHY*/
-- 
2.11.0

