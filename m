Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5EFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 241902070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgERKNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:13:16 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48832 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgERKNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:13:16 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D9583200060;
        Mon, 18 May 2020 12:13:14 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 759A6200781;
        Mon, 18 May 2020 12:13:10 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0D20A402A6;
        Mon, 18 May 2020 18:13:04 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] dt-bindings: reset: Convert i.MX reset to json-schema
Date:   Mon, 18 May 2020 18:03:32 +0800
Message-Id: <1589796212-9993-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX reset binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- add the compatible strings per SoC;
	- use "reset-controller" as node name instead of src;
	- add interrupt items description.
---
 .../devicetree/bindings/reset/fsl,imx-src.txt      | 49 -----------
 .../devicetree/bindings/reset/fsl,imx-src.yaml     | 98 ++++++++++++++++++++++
 2 files changed, 98 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/fsl,imx-src.txt
 create mode 100644 Documentation/devicetree/bindings/reset/fsl,imx-src.yaml

diff --git a/Documentation/devicetree/bindings/reset/fsl,imx-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx-src.txt
deleted file mode 100644
index 6ed79e6..0000000
--- a/Documentation/devicetree/bindings/reset/fsl,imx-src.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-Freescale i.MX System Reset Controller
-======================================
-
-Please also refer to reset.txt in this directory for common reset
-controller binding usage.
-
-Required properties:
-- compatible: Should be "fsl,<chip>-src"
-- reg: should be register base and length as documented in the
-  datasheet
-- interrupts: Should contain SRC interrupt and CPU WDOG interrupt,
-  in this order.
-- #reset-cells: 1, see below
-
-example:
-
-src: src@20d8000 {
-        compatible = "fsl,imx6q-src";
-        reg = <0x020d8000 0x4000>;
-        interrupts = <0 91 0x04 0 96 0x04>;
-        #reset-cells = <1>;
-};
-
-Specifying reset lines connected to IP modules
-==============================================
-
-The system reset controller can be used to reset the GPU, VPU,
-IPU, and OpenVG IP modules on i.MX5 and i.MX6 ICs. Those device
-nodes should specify the reset line on the SRC in their resets
-property, containing a phandle to the SRC device node and a
-RESET_INDEX specifying which module to reset, as described in
-reset.txt
-
-example:
-
-        ipu1: ipu@2400000 {
-                resets = <&src 2>;
-        };
-        ipu2: ipu@2800000 {
-                resets = <&src 4>;
-        };
-
-The following RESET_INDEX values are valid for i.MX5:
-GPU_RESET     0
-VPU_RESET     1
-IPU1_RESET    2
-OPEN_VG_RESET 3
-The following additional RESET_INDEX value is valid for i.MX6:
-IPU2_RESET    4
diff --git a/Documentation/devicetree/bindings/reset/fsl,imx-src.yaml b/Documentation/devicetree/bindings/reset/fsl,imx-src.yaml
new file mode 100644
index 0000000..7cd6095
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/fsl,imx-src.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/fsl,imx-src.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX System Reset Controller
+
+maintainers:
+  - Philipp Zabel <p.zabel@pengutronix.de>
+
+description: |
+  The system reset controller can be used to reset the GPU, VPU,
+  IPU, and OpenVG IP modules on i.MX5 and i.MX6 ICs. Those device
+  nodes should specify the reset line on the SRC in their resets
+  property, containing a phandle to the SRC device node and a
+  RESET_INDEX specifying which module to reset, as described in
+  reset.txt
+
+  The following RESET_INDEX values are valid for i.MX5:
+    GPU_RESET     0
+    VPU_RESET     1
+    IPU1_RESET    2
+    OPEN_VG_RESET 3
+  The following additional RESET_INDEX value is valid for i.MX6:
+    IPU2_RESET    4
+
+properties:
+  compatible:
+    oneOf:
+      - description: on i.MX51 the following compatible must be specified
+        items:
+          - const: "fsl,imx51-src"
+
+      - description: on i.MX50 the following compatibles must be specified
+        items:
+          - const: "fsl,imx50-src"
+          - const: "fsl,imx51-src"
+
+      - description: on i.MX53 the following compatibles must be specified
+        items:
+          - const: "fsl,imx53-src"
+          - const: "fsl,imx51-src"
+
+      - description: on i.MX6Q the following compatibles must be specified
+        items:
+          - const: "fsl,imx6q-src"
+          - const: "fsl,imx51-src"
+
+      - description: on i.MX6SX the following compatibles must be specified
+        items:
+          - const: "fsl,imx6sx-src"
+          - const: "fsl,imx51-src"
+
+      - description: on i.MX6SL the following compatibles must be specified
+        items:
+          - const: "fsl,imx6sl-src"
+          - const: "fsl,imx51-src"
+
+      - description: on i.MX6UL the following compatibles must be specified
+        items:
+          - const: "fsl,imx6ul-src"
+          - const: "fsl,imx51-src"
+
+      - description: on i.MX6SLL the following compatibles must be specified
+        items:
+          - const: "fsl,imx6sll-src"
+          - const: "fsl,imx51-src"
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: SRC interrupt
+      - description: CPU WDOG interrupts out of SRC
+    minItems: 1
+    maxItems: 2
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
+    reset-controller@73fd0000 {
+        compatible = "fsl,imx51-src";
+        reg = <0x73fd0000 0x4000>;
+        interrupts = <75>;
+        #reset-cells = <1>;
+    };
-- 
2.7.4

