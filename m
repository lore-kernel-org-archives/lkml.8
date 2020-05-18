Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD67FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 941A02065F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgERPCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:02:22 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37808 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgERPCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:02:21 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6344A200941;
        Mon, 18 May 2020 17:02:19 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 290352009C2;
        Mon, 18 May 2020 17:02:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6D2F9402AF;
        Mon, 18 May 2020 23:02:07 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, Frank.Li@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] dt-bindings: clock: Convert i.MX7D clock to json-schema
Date:   Mon, 18 May 2020 22:52:34 +0800
Message-Id: <1589813554-20929-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX7D clock binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- Update maintainer's e-mail address.
---
 .../devicetree/bindings/clock/imx7d-clock.txt      | 13 -----
 .../devicetree/bindings/clock/imx7d-clock.yaml     | 64 ++++++++++++++++++++++
 2 files changed, 64 insertions(+), 13 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/imx7d-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx7d-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/imx7d-clock.txt b/Documentation/devicetree/bindings/clock/imx7d-clock.txt
deleted file mode 100644
index 9d3026d..0000000
--- a/Documentation/devicetree/bindings/clock/imx7d-clock.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-* Clock bindings for Freescale i.MX7 Dual
-
-Required properties:
-- compatible: Should be "fsl,imx7d-ccm"
-- reg: Address and length of the register set
-- #clock-cells: Should be <1>
-- clocks: list of clock specifiers, must contain an entry for each required
-  entry in clock-names
-- clock-names: should include entries "ckil", "osc"
-
-The clock consumer should specify the desired clock by having the clock
-ID in its "clocks" phandle cell.  See include/dt-bindings/clock/imx7d-clock.h
-for the full list of i.MX7 Dual clock IDs.
diff --git a/Documentation/devicetree/bindings/clock/imx7d-clock.yaml b/Documentation/devicetree/bindings/clock/imx7d-clock.yaml
new file mode 100644
index 0000000..8cd0573
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx7d-clock.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx7d-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock bindings for Freescale i.MX7 Dual
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+  - Anson Huang <Anson.Huang@nxp.com>
+
+description: |
+  The clock consumer should specify the desired clock by having the clock
+  ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx7d-clock.h
+  for the full list of i.MX7 Dual clock IDs.
+
+properties:
+  compatible:
+    const: fsl,imx7d-ccm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: CCM interrupt request 1
+      - description: CCM interrupt request 2
+    maxItems: 2
+
+  '#clock-cells':
+    const: 1
+
+  clocks:
+    items:
+      - description: 32k osc
+      - description: 24m osc
+
+  clock-names:
+    items:
+      - const: ckil
+      - const: osc
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    clock-controller@30380000 {
+        compatible = "fsl,imx7d-ccm";
+        reg = <0x30380000 0x10000>;
+        interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+        #clock-cells = <1>;
+        clocks = <&ckil>, <&osc>;
+        clock-names = "ckil", "osc";
+    };
-- 
2.7.4

