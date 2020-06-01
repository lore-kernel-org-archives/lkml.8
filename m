Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262EBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 10:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06C6C20772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 10:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgFAKsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 06:48:10 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45672 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgFAKsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 06:48:09 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5EA832006EC;
        Mon,  1 Jun 2020 12:48:06 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 612AC2006E5;
        Mon,  1 Jun 2020 12:48:02 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4198340280;
        Mon,  1 Jun 2020 18:47:57 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, linux@rempel-privat.de, peng.fan@nxp.com,
        jaswinder.singh@linaro.org, hongxing.zhu@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] dt-bindings: mailbox: Convert imx mu to json-schema
Date:   Mon,  1 Jun 2020 18:37:44 +0800
Message-Id: <1591007864-30267-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX MU binding to DT schema format using json-schema

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/mailbox/fsl,mu.txt         | 58 --------------
 .../devicetree/bindings/mailbox/fsl,mu.yaml        | 89 ++++++++++++++++++++++
 2 files changed, 89 insertions(+), 58 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mailbox/fsl,mu.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
deleted file mode 100644
index 26b7a88..0000000
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-NXP i.MX Messaging Unit (MU)
---------------------------------------------------------------------
-
-The Messaging Unit module enables two processors within the SoC to
-communicate and coordinate by passing messages (e.g. data, status
-and control) through the MU interface. The MU also provides the ability
-for one processor to signal the other processor using interrupts.
-
-Because the MU manages the messaging between processors, the MU uses
-different clocks (from each side of the different peripheral buses).
-Therefore, the MU must synchronize the accesses from one side to the
-other. The MU accomplishes synchronization using two sets of matching
-registers (Processor A-facing, Processor B-facing).
-
-Messaging Unit Device Node:
-=============================
-
-Required properties:
--------------------
-- compatible :	should be "fsl,<chip>-mu", the supported chips include
-		imx6sx, imx7s, imx8qxp, imx8qm.
-		The "fsl,imx6sx-mu" compatible is seen as generic and should
-		be included together with SoC specific compatible.
-		There is a version 1.0 MU on imx7ulp, use "fsl,imx7ulp-mu"
-		compatible to support it.
-		To communicate with i.MX8 SCU, "fsl,imx8-mu-scu" could be
-		used for fast IPC
-- reg :		Should contain the registers location and length
-- interrupts :	Interrupt number. The interrupt specifier format depends
-		on the interrupt controller parent.
-- #mbox-cells:  Must be 2.
-			  <&phandle type channel>
-			    phandle   : Label name of controller
-			    type      : Channel type
-			    channel   : Channel number
-
-		This MU support 4 type of unidirectional channels, each type
-		has 4 channels. A total of 16 channels. Following types are
-		supported:
-		0 - TX channel with 32bit transmit register and IRQ transmit
-		acknowledgment support.
-		1 - RX channel with 32bit receive register and IRQ support
-		2 - TX doorbell channel. Without own register and no ACK support.
-		3 - RX doorbell channel.
-
-Optional properties:
--------------------
-- clocks :	phandle to the input clock.
-- fsl,mu-side-b : Should be set for side B MU.
-
-Examples:
---------
-lsio_mu0: mailbox@5d1b0000 {
-	compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
-	reg = <0x0 0x5d1b0000 0x0 0x10000>;
-	interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
-	#mbox-cells = <2>;
-};
diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
new file mode 100644
index 0000000..93db996
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/fsl,mu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX Messaging Unit (MU)
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: |
+  The Messaging Unit module enables two processors within the SoC to
+  communicate and coordinate by passing messages (e.g. data, status
+  and control) through the MU interface. The MU also provides the ability
+  for one processor to signal the other processor using interrupts.
+
+  Because the MU manages the messaging between processors, the MU uses
+  different clocks (from each side of the different peripheral buses).
+  Therefore, the MU must synchronize the accesses from one side to the
+  other. The MU accomplishes synchronization using two sets of matching
+  registers (Processor A-facing, Processor B-facing).
+
+properties:
+  compatible:
+    oneOf:
+      - const: fsl,imx6sx-mu
+      - const: fsl,imx7ulp-mu
+      - const: fsl,imx8-mu-scu
+      - items:
+          - enum:
+            - fsl,imx7s-mu
+            - fsl,imx8mq-mu
+            - fsl,imx8mm-mu
+            - fsl,imx8mn-mu
+            - fsl,imx8mp-mu
+            - fsl,imx8qxp-mu
+          - const: fsl,imx6sx-mu
+      - description: To communicate with i.MX8 SCU with fast IPC
+        items:
+          - const: fsl,imx8qxp-mu
+          - const: fsl,imx8-mu-scu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#mbox-cells":
+    description: |
+      <&phandle type channel>
+      phandle   : Label name of controller
+      type      : Channel type
+      channel   : Channel number
+
+      This MU support 4 type of unidirectional channels, each type
+      has 4 channels. A total of 16 channels. Following types are
+      supported:
+      0 - TX channel with 32bit transmit register and IRQ transmit
+          acknowledgment support.
+      1 - RX channel with 32bit receive register and IRQ support
+      2 - TX doorbell channel. Without own register and no ACK support.
+      3 - RX doorbell channel.
+    const: 2
+
+  clocks:
+    maxItems: 1
+
+  fsl,mu-side-b:
+    description: boolean, if present, means it is for side B MU.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#mbox-cells"
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mailbox@5d1b0000 {
+        compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+        reg = <0x0 0x5d1b0000 0x0 0x10000>;
+        interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+        #mbox-cells = <2>;
+    };
-- 
2.7.4

