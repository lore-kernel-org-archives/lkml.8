Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264C5C47254
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB542173E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgD3VLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:11:14 -0400
Received: from foss.arm.com ([217.140.110.172]:33628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbgD3VLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:11:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13E851FB;
        Thu, 30 Apr 2020 14:11:11 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 300F93F68F;
        Thu, 30 Apr 2020 14:11:10 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v3 4/8] dt-bindings: phy: Convert Calxeda ComboPHY binding to json-schema
Date:   Thu, 30 Apr 2020 22:10:50 +0100
Message-Id: <20200430211054.30466-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430211054.30466-1-andre.przywara@arm.com>
References: <20200430211054.30466-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Calxeda ComboPHY binding to DT schema format using
json-schema.
There is no driver in the Linux kernel matching the compatible
string, but the nodes are parsed by the SATA driver, which links to them
using its port-phys property.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../bindings/phy/calxeda-combophy.txt         | 17 -------
 .../bindings/phy/calxeda-combophy.yaml        | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/calxeda-combophy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/calxeda-combophy.yaml

diff --git a/Documentation/devicetree/bindings/phy/calxeda-combophy.txt b/Documentation/devicetree/bindings/phy/calxeda-combophy.txt
deleted file mode 100644
index 6622bdb2e8bc..000000000000
--- a/Documentation/devicetree/bindings/phy/calxeda-combophy.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Calxeda Highbank Combination Phys for SATA
-
-Properties:
-- compatible : Should be "calxeda,hb-combophy"
-- #phy-cells: Should be 1.
-- reg : Address and size for Combination Phy registers.
-- phydev: device ID for programming the combophy.
-
-Example:
-
-	combophy5: combo-phy@fff5d000 {
-		compatible = "calxeda,hb-combophy";
-		#phy-cells = <1>;
-		reg = <0xfff5d000 0x1000>;
-		phydev = <31>;
-	};
-
diff --git a/Documentation/devicetree/bindings/phy/calxeda-combophy.yaml b/Documentation/devicetree/bindings/phy/calxeda-combophy.yaml
new file mode 100644
index 000000000000..16a8bd7644bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/calxeda-combophy.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/calxeda-combophy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Calxeda Highbank Combination PHYs binding for SATA
+
+description: |
+  The Calxeda Combination PHYs connect the SoC to the internal fabric
+  and to SATA connectors. The PHYs support multiple protocols (SATA,
+  SGMII, PCIe) and can be assigned to different devices (SATA or XGMAC
+  controller).
+  Programming the PHYs is typically handled by those device drivers,
+  not by a dedicated PHY driver.
+
+maintainers:
+  - Andre Przywara <andre.przywara@arm.com>
+
+properties:
+  compatible:
+    const: calxeda,hb-combophy
+
+  '#phy-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  phydev:
+    description: device ID for programming the ComboPHY.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - maximum: 31
+
+required:
+  - compatible
+  - reg
+  - phydev
+  - '#phy-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    combophy5: combo-phy@fff5d000 {
+                   compatible = "calxeda,hb-combophy";
+                   #phy-cells = <1>;
+                   reg = <0xfff5d000 0x1000>;
+                   phydev = <31>;
+               };
-- 
2.17.1

