Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA40C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51CFF20734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgFAIRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:17:15 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55116 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgFAIRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:17:12 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AC1801A0675;
        Mon,  1 Jun 2020 10:17:09 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DFAD81A0695;
        Mon,  1 Jun 2020 10:17:03 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BB747402A7;
        Mon,  1 Jun 2020 16:16:56 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, ulf.hansson@linaro.org,
        sboyd@kernel.org, krzk@kernel.org, p.zabel@pengutronix.de,
        andrew.smirnov@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] dt-bindings: power: Convert imx gpcv2 to json-schema
Date:   Mon,  1 Jun 2020 16:06:43 +0800
Message-Id: <1590998803-29191-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590998803-29191-1-git-send-email-Anson.Huang@nxp.com>
References: <1590998803-29191-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX GPCv2 binding to DT schema format using json-schema

Example is updated based on latest DT file and consumer's example is
removed since it is NOT that useful.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/power/fsl,imx-gpcv2.txt    |  77 ---------------
 .../devicetree/bindings/power/fsl,imx-gpcv2.yaml   | 108 +++++++++++++++++++++
 2 files changed, 108 insertions(+), 77 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
deleted file mode 100644
index 6164920..0000000
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
+++ /dev/null
@@ -1,77 +0,0 @@
-Freescale i.MX General Power Controller v2
-==========================================
-
-The i.MX7S/D General Power Control (GPC) block contains Power Gating
-Control (PGC) for various power domains.
-
-Required properties:
-
-- compatible: Should be one of:
-	- "fsl,imx7d-gpc"
-	- "fsl,imx8mq-gpc"
-
-- reg: should be register base and length as documented in the
-  datasheet
-
-- interrupts: Should contain GPC interrupt request 1
-
-Power domains contained within GPC node are generic power domain
-providers, documented in
-Documentation/devicetree/bindings/power/power-domain.yaml, which are
-described as subnodes of the power gating controller 'pgc' node,
-which, in turn, is expected to contain the following:
-
-Required properties:
-
-- reg: Power domain index. Valid values are defined in
-  include/dt-bindings/power/imx7-power.h for fsl,imx7d-gpc and
-  include/dt-bindings/power/imx8m-power.h for fsl,imx8mq-gpc
-
-- #power-domain-cells: Should be 0
-
-Optional properties:
-
-- power-supply: Power supply used to power the domain
-- clocks: a number of phandles to clocks that need to be enabled during
-  domain power-up sequencing to ensure reset propagation into devices
-  located inside this power domain
-
-Example:
-
-	gpc: gpc@303a0000 {
-		compatible = "fsl,imx7d-gpc";
-		reg = <0x303a0000 0x1000>;
-		interrupt-controller;
-		interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
-		#interrupt-cells = <3>;
-		interrupt-parent = <&intc>;
-
-		pgc {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			pgc_pcie_phy: power-domain@1 {
-				#power-domain-cells = <0>;
-
-				reg = <1>;
-				power-supply = <&reg_1p0d>;
-			};
-		};
-	};
-
-
-Specifying power domain for IP modules
-======================================
-
-IP cores belonging to a power domain should contain a 'power-domains'
-property that is a phandle for PGC node representing the domain.
-
-Example of a device that is part of the PCIE_PHY power domain:
-
-	pcie: pcie@33800000 {
-	      reg = <0x33800000 0x4000>,
-	            <0x4ff00000 0x80000>;
-		/* ... */
-		power-domains = <&pgc_pcie_phy>;
-		/* ... */
-	};
diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
new file mode 100644
index 0000000..bde09a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/fsl,imx-gpcv2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX General Power Controller v2
+
+maintainers:
+  - Andrey Smirnov <andrew.smirnov@gmail.com>
+
+description: |
+  The i.MX7S/D General Power Control (GPC) block contains Power Gating
+  Control (PGC) for various power domains.
+
+  Power domains contained within GPC node are generic power domain
+  providers, documented in
+  Documentation/devicetree/bindings/power/power-domain.yaml, which are
+  described as subnodes of the power gating controller 'pgc' node.
+
+  IP cores belonging to a power domain should contain a 'power-domains'
+  property that is a phandle for PGC node representing the domain.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx7d-gpc
+      - fsl,imx8mq-gpc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  pgc:
+    type: object
+    description: list of power domains provided by this controller.
+
+    patternProperties:
+      "power-domain@[0-9]$":
+        type: object
+        properties:
+
+          '#power-domain-cells':
+            const: 0
+
+          reg:
+            description: |
+              Power domain index. Valid values are defined in
+              include/dt-bindings/power/imx7-power.h for fsl,imx7d-gpc and
+              include/dt-bindings/power/imx8m-power.h for fsl,imx8mq-gpc
+            maxItems: 1
+
+          clocks:
+            description: |
+              A number of phandles to clocks that need to be enabled during domain
+              power-up sequencing to ensure reset propagation into devices located
+              inside this power domain.
+            minItems: 1
+            maxItems: 5
+
+          power-supply: true
+
+        required:
+          - '#power-domain-cells'
+          - reg
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - pgc
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gpc@303a0000 {
+        compatible = "fsl,imx7d-gpc";
+        reg = <0x303a0000 0x1000>;
+        interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+
+        pgc {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            pgc_mipi_phy: power-domain@0 {
+                #power-domain-cells = <0>;
+                reg = <0>;
+                power-supply = <&reg_1p0d>;
+            };
+
+            pgc_pcie_phy: power-domain@1 {
+                #power-domain-cells = <0>;
+                reg = <1>;
+                power-supply = <&reg_1p0d>;
+            };
+
+            pgc_hsic_phy: power-domain@2 {
+                #power-domain-cells = <0>;
+                reg = <2>;
+                power-supply = <&reg_1p2>;
+            };
+        };
+    };
-- 
2.7.4

