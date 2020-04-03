Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F620C2BA18
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0CD20787
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732846AbgDCFE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 01:04:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:10692 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgDCFEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 01:04:54 -0400
IronPort-SDR: 1+iHnxmtTph8z6hhmmlRItKaHOb2gWfo+7tg+s+u9NH8CnFJg0TTN2NjQct4aStKiae05YjRkk
 tku/fz8Tuljw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 22:04:54 -0700
IronPort-SDR: l7ntcZVx4T7WLfLb53XZhNJx6CbwUKj82ep0Ptk4ZgpuYCagHij1Ch8tzIxOW1o8q9eKxCkK26
 pVT1w5UnSZDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,338,1580803200"; 
   d="scan'208";a="329050127"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga001.jf.intel.com with ESMTP; 02 Apr 2020 22:04:51 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kishon@ti.com, robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v6 3/4] dt-bindings: phy: Add YAML schemas for Intel ComboPhy
Date:   Fri,  3 Apr 2020 13:04:10 +0800
Message-Id: <e8cc2038f8fe417ddf8c3298eebae722ee5d8fe2.1585889042.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1585889042.git.eswara.kota@linux.intel.com>
References: <cover.1585889042.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1585889042.git.eswara.kota@linux.intel.com>
References: <cover.1585889042.git.eswara.kota@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ComboPhy subsystem provides PHY support to various
controllers, viz. PCIe, SATA and EMAC.
Adding YAML schemas for the same.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes on v6:
  Add Reviewed-by: Rob Herring <robh@kernel.org>

Changes on v5:
 Add changes as per Rob Herring inputs:
  Use include/dt-bindings/phy/phy.h values to set intel,phy-mode.
  Move children node properties to parent node and remove children
   node completely.

Changes on v4:
  No Change.

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

 .../devicetree/bindings/phy/intel,combo-phy.yaml   | 101 +++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
new file mode 100644
index 000000000000..347d0cdfb80d
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
@@ -0,0 +1,101 @@
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
+    maxItems: 4
+
+  reset-names:
+    items:
+      - const: phy
+      - const: core
+      - const: iphy0
+      - const: iphy1
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
+      See dt-bindings/phy/phy.h for values.
+
+  "#phy-cells":
+    const: 1
+
+required:
+  - compatible
+  - clocks
+  - reg
+  - reg-names
+  - intel,syscfg
+  - intel,hsio
+  - intel,phy-mode
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/phy/phy.h>
+    combophy@d0a00000 {
+        compatible = "intel,combophy-lgm", "intel,combo-phy";
+        clocks = <&cgu0 1>;
+        #phy-cells = <1>;
+        reg = <0xd0a00000 0x40000>,
+              <0xd0a40000 0x1000>;
+        reg-names = "core", "app";
+        resets = <&rcu0 0x50 6>,
+                 <&rcu0 0x50 17>,
+                 <&rcu0 0x50 23>,
+                 <&rcu0 0x50 24>;
+        reset-names = "phy", "core", "iphy0", "iphy1";
+        intel,syscfg = <&sysconf 0>;
+        intel,hsio = <&hsiol 0>;
+        intel,phy-mode = <PHY_TYPE_PCIE>;
+        intel,aggregation;
+    };
-- 
2.11.0

