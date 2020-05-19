Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4603C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B829207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgESGUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 02:20:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:11141 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgESGUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 02:20:44 -0400
IronPort-SDR: 3k+tHIcGEcVM2c5F2dVbNwtHL1UcywdRhbHNMX7I8sL53pqaBrL6PgqNoz3KMlDdCZA/qIKZhY
 E/h1hnTqhdcQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 23:20:43 -0700
IronPort-SDR: vQGdH5FWN0Ski88GdXkr2CswAWxOwU93HZ4pnP+OEcCOH5PWKPcwy5jWa76PPw5YY0AEurRahM
 9M6gShe67XEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; 
   d="scan'208";a="253147615"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga007.jf.intel.com with ESMTP; 18 May 2020 23:20:40 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v9 2/3] dt-bindings: phy: Add YAML schemas for Intel ComboPhy
Date:   Tue, 19 May 2020 14:19:20 +0800
Message-Id: <e8cc2038f8fe417ddf8c3298eebae722ee5d8fe2.1589868358.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1589868358.git.eswara.kota@linux.intel.com>
References: <cover.1589868358.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1589868358.git.eswara.kota@linux.intel.com>
References: <cover.1589868358.git.eswara.kota@linux.intel.com>
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
Changes on v9:
  No Change

Changes on v8:
  No Change.

Changes on v7:
  No Change.

Changes on v6:
  Add Reviewed-by: Rob Herring <robh@kernel.org>

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

