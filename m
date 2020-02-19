Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F1EC3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAA224658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgBSDbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 22:31:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:8520 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgBSDbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:31:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 19:31:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,459,1574150400"; 
   d="scan'208";a="382667731"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga004.jf.intel.com with ESMTP; 18 Feb 2020 19:31:36 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kishon@ti.com, robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v2 1/2] dt-bindings: phy: Add YAML schemas for Intel Combophy
Date:   Wed, 19 Feb 2020 11:31:29 +0800
Message-Id: <208fcb9660abd560aeab077442d158d84a3dddee.1582021248.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combophy subsystem provides PHY support to various
controllers, viz. PCIe, SATA and EMAC.
Adding YAML schemas for the same.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
Changes on v2:

 Add custom 'select'
 Pass hardware instance entries with phandles and
   remove cell-index and bid entries
 Clock, register address space, are same for the children.
   So move them to parent node.
 Two PHY instances cannot run in different modes,
   so move the phy-mode entry to parent node.
 Add second child entry in the DT example.

 .../devicetree/bindings/phy/intel,combo-phy.yaml   | 138 +++++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
new file mode 100644
index 000000000000..8e65a2a71e7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/intel,combo-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Combophy Subsystem
+
+maintainers:
+  - Dilip Kota <eswara.kota@linux.intel.com>
+
+description: |
+  Intel Combophy subsystem supports PHYs for PCIe, EMAC and SATA
+  controllers. A single Combophy provides two PHY instances.
+
+# We need a select here so we don't match all nodes with 'simple-bus'
+select:
+  properties:
+    compatible:
+      contains:
+        const: intel,combo-phy
+  required:
+    - compatible
+
+properties:
+  $nodename:
+    pattern: "^combophy@[0-9]+$"
+
+  compatible:
+    items:
+      - const: intel,combo-phy
+      - const: simple-bus
+
+  clocks:
+    description: |
+      List of phandle and clock specifier pairs as listed
+      in clock-names property. Configure the clocks according
+      to the PHY mode.
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
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Chip configuration registers handle and ComboPhy instance id
+
+  intel,hsio:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: HSIO registers handle and ComboPhy instance id on NOC
+
+  intel,aggregation:
+    description: |
+      Specify the flag to confiure ComboPHY in dual lane mode.
+    type: boolean
+
+  intel,phy-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 2
+    description: |
+      Configure the mode of the PHY.
+        0 - PCIe
+        1 - xpcs
+        2 - sata
+
+patternProperties:
+  "^cb[0-9]phy@[0-9]+$":
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
+    combophy@0 {
+        compatible = "intel,combo-phy", "simple-bus";
+        clocks = <&cgu0 1>;
+        reg = <0xd0a00000 0x40000>,
+              <0xd0a40000 0x1000>;
+        reg-names = "core", "app";
+        resets = <&rcu0 0x50 6>,
+        	 <&rcu0 0x50 17>;
+        reset-names = "phy", "core";
+        intel,syscfg = <&sysconf 0>;
+        intel,hsio = <&hsiol 0>;
+        intel,phy-mode = <0>;
+
+        cb0phy0:cb0phy@0 {
+            compatible = "intel,phydev";
+            #phy-cells = <0>;
+            resets = <&rcu0 0x50 23>;
+        };
+
+        cb0phy1:cb0phy@1 {
+            compatible = "intel,phydev";
+            #phy-cells = <0>;
+            resets = <&rcu0 0x50 24>;
+        };
+    };
-- 
2.11.0

