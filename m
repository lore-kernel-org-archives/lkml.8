Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70271C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 513CE206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgFAIRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:17:12 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55084 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgFAIRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:17:11 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B15E1A0661;
        Mon,  1 Jun 2020 10:17:08 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B04B51A0675;
        Mon,  1 Jun 2020 10:17:02 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 72F1A40280;
        Mon,  1 Jun 2020 16:16:55 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, ulf.hansson@linaro.org,
        sboyd@kernel.org, krzk@kernel.org, p.zabel@pengutronix.de,
        andrew.smirnov@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] dt-bindings: power: Convert imx gpc to json-schema
Date:   Mon,  1 Jun 2020 16:06:42 +0800
Message-Id: <1590998803-29191-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX GPC binding to DT schema format using json-schema

From latest reference manual, there is actually ONLY 1 interrupt for
GPC, so the additional GPC interrupt is removed.

Consumer's example is also removed since it is NOT that useful.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/power/fsl,imx-gpc.txt      |  91 ---------------
 .../devicetree/bindings/power/fsl,imx-gpc.yaml     | 124 +++++++++++++++++++++
 2 files changed, 124 insertions(+), 91 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
deleted file mode 100644
index f0f5553..0000000
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
+++ /dev/null
@@ -1,91 +0,0 @@
-Freescale i.MX General Power Controller
-=======================================
-
-The i.MX6 General Power Control (GPC) block contains DVFS load tracking
-counters and Power Gating Control (PGC).
-
-Required properties:
-- compatible: Should be one of the following:
-  - fsl,imx6q-gpc
-  - fsl,imx6qp-gpc
-  - fsl,imx6sl-gpc
-  - fsl,imx6sx-gpc
-- reg: should be register base and length as documented in the
-  datasheet
-- interrupts: Should contain one interrupt specifier for the GPC interrupt
-- clocks: Must contain an entry for each entry in clock-names.
-  See Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
-- clock-names: Must include the following entries:
-  - ipg
-
-The power domains are generic power domain providers as documented in
-Documentation/devicetree/bindings/power/power-domain.yaml. They are described as
-subnodes of the power gating controller 'pgc' node of the GPC and should
-contain the following:
-
-Required properties:
-- reg: Must contain the DOMAIN_INDEX of this power domain
-  The following DOMAIN_INDEX values are valid for i.MX6Q:
-  ARM_DOMAIN     0
-  PU_DOMAIN      1
-  The following additional DOMAIN_INDEX value is valid for i.MX6SL:
-  DISPLAY_DOMAIN 2
-  The following additional DOMAIN_INDEX value is valid for i.MX6SX:
-  PCI_DOMAIN     3
-
-- #power-domain-cells: Should be 0
-
-Optional properties:
-- clocks: a number of phandles to clocks that need to be enabled during domain
-  power-up sequencing to ensure reset propagation into devices located inside
-  this power domain
-- power-supply: a phandle to the regulator powering this domain
-
-Example:
-
-	gpc: gpc@20dc000 {
-		compatible = "fsl,imx6q-gpc";
-		reg = <0x020dc000 0x4000>;
-		interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 90 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clks IMX6QDL_CLK_IPG>;
-		clock-names = "ipg";
-
-		pgc {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			power-domain@0 {
-				reg = <0>;
-				#power-domain-cells = <0>;
-			};
-
-			pd_pu: power-domain@1 {
-				reg = <1>;
-				#power-domain-cells = <0>;
-				power-supply = <&reg_pu>;
-				clocks = <&clks IMX6QDL_CLK_GPU3D_CORE>,
-				         <&clks IMX6QDL_CLK_GPU3D_SHADER>,
-				         <&clks IMX6QDL_CLK_GPU2D_CORE>,
-				         <&clks IMX6QDL_CLK_GPU2D_AXI>,
-				         <&clks IMX6QDL_CLK_OPENVG_AXI>,
-				         <&clks IMX6QDL_CLK_VPU_AXI>;
-			};
-		};
-	};
-
-
-Specifying power domain for IP modules
-======================================
-
-IP cores belonging to a power domain should contain a 'power-domains' property
-that is a phandle pointing to the power domain the device belongs to.
-
-Example of a device that is part of the PU power domain:
-
-	vpu: vpu@2040000 {
-		reg = <0x02040000 0x3c000>;
-		/* ... */
-		power-domains = <&pd_pu>;
-		/* ... */
-	};
diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml
new file mode 100644
index 0000000..a055b3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml
@@ -0,0 +1,124 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/fsl,imx-gpc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX General Power Controller
+
+maintainers:
+  - Philipp Zabel <p.zabel@pengutronix.de>
+
+description: |
+  The i.MX6 General Power Control (GPC) block contains DVFS load tracking
+  counters and Power Gating Control (PGC).
+
+  The power domains are generic power domain providers as documented in
+  Documentation/devicetree/bindings/power/power-domain.yaml. They are
+  described as subnodes of the power gating controller 'pgc' node of the GPC.
+
+  IP cores belonging to a power domain should contain a 'power-domains'
+  property that is a phandle pointing to the power domain the device belongs
+  to.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx6q-gpc
+      - fsl,imx6qp-gpc
+      - fsl,imx6sl-gpc
+      - fsl,imx6sx-gpc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: ipg
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
+              The following DOMAIN_INDEX values are valid for i.MX6Q:
+                ARM_DOMAIN     0
+                PU_DOMAIN      1
+              The following additional DOMAIN_INDEX value is valid for i.MX6SL:
+                DISPLAY_DOMAIN 2
+              The following additional DOMAIN_INDEX value is valid for i.MX6SX:
+                PCI_DOMAIN     3
+            maxItems: 1
+
+          clocks:
+            description: |
+              A number of phandles to clocks that need to be enabled during domain
+              power-up sequencing to ensure reset propagation into devices located
+              inside this power domain.
+            minItems: 1
+            maxItems: 7
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
+  - clocks
+  - clock-names
+  - pgc
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx6qdl-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gpc@20dc000 {
+        compatible = "fsl,imx6q-gpc";
+        reg = <0x020dc000 0x4000>;
+        interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks IMX6QDL_CLK_IPG>;
+        clock-names = "ipg";
+
+        pgc {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            power-domain@0 {
+                reg = <0>;
+                #power-domain-cells = <0>;
+            };
+
+            pd_pu: power-domain@1 {
+                reg = <1>;
+                #power-domain-cells = <0>;
+                power-supply = <&reg_pu>;
+                clocks = <&clks IMX6QDL_CLK_GPU3D_CORE>,
+                         <&clks IMX6QDL_CLK_GPU3D_SHADER>,
+                         <&clks IMX6QDL_CLK_GPU2D_CORE>,
+                         <&clks IMX6QDL_CLK_GPU2D_AXI>,
+                         <&clks IMX6QDL_CLK_OPENVG_AXI>,
+                         <&clks IMX6QDL_CLK_VPU_AXI>;
+            };
+        };
+    };
-- 
2.7.4

