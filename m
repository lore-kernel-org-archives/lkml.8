Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1FEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 02:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D297620829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 02:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbgGaCKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 22:10:47 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51292 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731057AbgGaCKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 22:10:47 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D3C4A2013B1;
        Fri, 31 Jul 2020 04:10:43 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7103120034F;
        Fri, 31 Jul 2020 04:10:41 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 20AAF402C1;
        Fri, 31 Jul 2020 04:10:38 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     krzk@kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] dt-bindings: memory-controllers: Convert mmdc to json-schema
Date:   Fri, 31 Jul 2020 10:06:24 +0800
Message-Id: <1596161184-24266-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the MMDC memory controller binding to DT schema format using
json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../bindings/memory-controllers/fsl/mmdc.txt       | 35 ----------------
 .../bindings/memory-controllers/fsl/mmdc.yaml      | 49 ++++++++++++++++++++++
 2 files changed, 49 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.txt b/Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.txt
deleted file mode 100644
index bcc36c5..0000000
--- a/Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-Freescale Multi Mode DDR controller (MMDC)
-
-Required properties :
-- compatible : should be one of following:
-	for i.MX6Q/i.MX6DL:
-	- "fsl,imx6q-mmdc";
-	for i.MX6QP:
-	- "fsl,imx6qp-mmdc", "fsl,imx6q-mmdc";
-	for i.MX6SL:
-	- "fsl,imx6sl-mmdc", "fsl,imx6q-mmdc";
-	for i.MX6SLL:
-	- "fsl,imx6sll-mmdc", "fsl,imx6q-mmdc";
-	for i.MX6SX:
-	- "fsl,imx6sx-mmdc", "fsl,imx6q-mmdc";
-	for i.MX6UL/i.MX6ULL/i.MX6ULZ:
-	- "fsl,imx6ul-mmdc", "fsl,imx6q-mmdc";
-	for i.MX7ULP:
-	- "fsl,imx7ulp-mmdc", "fsl,imx6q-mmdc";
-- reg : address and size of MMDC DDR controller registers
-
-Optional properties :
-- clocks : the clock provided by the SoC to access the MMDC registers
-
-Example :
-	mmdc0: memory-controller@21b0000 { /* MMDC0 */
-		compatible = "fsl,imx6q-mmdc";
-		reg = <0x021b0000 0x4000>;
-		clocks = <&clks IMX6QDL_CLK_MMDC_P0_IPG>;
-	};
-
-	mmdc1: memory-controller@21b4000 { /* MMDC1 */
-		compatible = "fsl,imx6q-mmdc";
-		reg = <0x021b4000 0x4000>;
-		status = "disabled";
-	};
diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.yaml
new file mode 100644
index 0000000..dee5131
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/fsl/mmdc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Multi Mode DDR controller (MMDC)
+
+maintainers:
+  - Anson Huang <Anson.Huang@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: fsl,imx6q-mmdc
+      - items:
+          - enum:
+            - fsl,imx6qp-mmdc
+            - fsl,imx6sl-mmdc
+            - fsl,imx6sll-mmdc
+            - fsl,imx6sx-mmdc
+            - fsl,imx6ul-mmdc
+            - fsl,imx7ulp-mmdc
+          - const: fsl,imx6q-mmdc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx6qdl-clock.h>
+
+    memory-controller@21b0000 {
+        compatible = "fsl,imx6q-mmdc";
+        reg = <0x021b0000 0x4000>;
+        clocks = <&clks IMX6QDL_CLK_MMDC_P0_IPG>;
+    };
+
+    memory-controller@21b4000 {
+        compatible = "fsl,imx6q-mmdc";
+        reg = <0x021b4000 0x4000>;
+    };
-- 
2.7.4

