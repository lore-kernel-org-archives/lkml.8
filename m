Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085ABC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5EB4206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgEKMHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 08:07:09 -0400
Received: from inva021.nxp.com ([92.121.34.21]:52294 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728531AbgEKMHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:07:09 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A8132200BA6;
        Mon, 11 May 2020 14:07:06 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F004F20025F;
        Mon, 11 May 2020 14:07:01 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 195BF402A7;
        Mon, 11 May 2020 20:06:56 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        andrew.smirnov@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] dt-bindings: reset: Convert i.MX7 reset to json-schema
Date:   Mon, 11 May 2020 19:57:42 +0800
Message-Id: <1589198262-21372-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX7 reset binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- Improve description;
	- Remove i.MX8MM and i.MX8MN compatible, they use i.MX8MQ's compatible;
	- Keep original author as maintainer;
	- Remove unnecessary "..." at the end of file.
---
 .../devicetree/bindings/reset/fsl,imx7-src.txt     | 56 ---------------------
 .../devicetree/bindings/reset/fsl,imx7-src.yaml    | 58 ++++++++++++++++++++++
 2 files changed, 58 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
 create mode 100644 Documentation/devicetree/bindings/reset/fsl,imx7-src.yaml

diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
deleted file mode 100644
index e10502d..0000000
--- a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Freescale i.MX7 System Reset Controller
-======================================
-
-Please also refer to reset.txt in this directory for common reset
-controller binding usage.
-
-Required properties:
-- compatible:
-	- For i.MX7 SoCs should be "fsl,imx7d-src", "syscon"
-	- For i.MX8MQ SoCs should be "fsl,imx8mq-src", "syscon"
-	- For i.MX8MM SoCs should be "fsl,imx8mm-src", "fsl,imx8mq-src", "syscon"
-	- For i.MX8MN SoCs should be "fsl,imx8mn-src", "fsl,imx8mq-src", "syscon"
-	- For i.MX8MP SoCs should be "fsl,imx8mp-src", "syscon"
-- reg: should be register base and length as documented in the
-  datasheet
-- interrupts: Should contain SRC interrupt
-- #reset-cells: 1, see below
-
-example:
-
-src: reset-controller@30390000 {
-     compatible = "fsl,imx7d-src", "syscon";
-     reg = <0x30390000 0x2000>;
-     interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
-     #reset-cells = <1>;
-};
-
-
-Specifying reset lines connected to IP modules
-==============================================
-
-The system reset controller can be used to reset various set of
-peripherals. Device nodes that need access to reset lines should
-specify them as a reset phandle in their corresponding node as
-specified in reset.txt.
-
-Example:
-
-	pcie: pcie@33800000 {
-
-		...
-
-		resets = <&src IMX7_RESET_PCIEPHY>,
-			 <&src IMX7_RESET_PCIE_CTRL_APPS_EN>;
-		reset-names = "pciephy", "apps";
-
-		...
-        };
-
-
-For list of all valid reset indices see
-<dt-bindings/reset/imx7-reset.h> for i.MX7,
-<dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ and
-<dt-bindings/reset/imx8mq-reset.h> for i.MX8MM and
-<dt-bindings/reset/imx8mq-reset.h> for i.MX8MN and
-<dt-bindings/reset/imx8mp-reset.h> for i.MX8MP
diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.yaml b/Documentation/devicetree/bindings/reset/fsl,imx7-src.yaml
new file mode 100644
index 0000000..b1a71c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/fsl,imx7-src.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX7 System Reset Controller
+
+maintainers:
+  - Andrey Smirnov <andrew.smirnov@gmail.com>
+
+description: |
+  The system reset controller can be used to reset various set of
+  peripherals. Device nodes that need access to reset lines should
+  specify them as a reset phandle in their corresponding node as
+  specified in reset.txt.
+
+  For list of all valid reset indices see
+    <dt-bindings/reset/imx7-reset.h> for i.MX7,
+    <dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ, i.MX8MM and i.MX8MN,
+    <dt-bindings/reset/imx8mp-reset.h> for i.MX8MP.
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - fsl,imx7d-src
+        - fsl,imx8mq-src
+        - fsl,imx8mp-src
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    reset-controller@30390000 {
+        compatible = "fsl,imx7d-src", "syscon";
+        reg = <0x30390000 0x2000>;
+        interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+        #reset-cells = <1>;
+    };
-- 
2.7.4

