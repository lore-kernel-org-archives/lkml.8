Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C05C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8CD20787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgERIpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 04:45:40 -0400
Received: from inva021.nxp.com ([92.121.34.21]:35088 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgERIpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:45:39 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E359220099B;
        Mon, 18 May 2020 10:45:37 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4938520097C;
        Mon, 18 May 2020 10:45:34 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A85C6402A8;
        Mon, 18 May 2020 16:45:29 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        robh+dt@kernel.org, l.stach@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3] dt-bindings: interrupt-controller: Convert imx irqsteer to json-schema
Date:   Mon, 18 May 2020 16:35:57 +0800
Message-Id: <1589790957-7904-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX IRQSTEER binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
Changes since V2:
	- Improve the interrupt items description.
---
 .../bindings/interrupt-controller/fsl,irqsteer.txt | 35 ---------
 .../interrupt-controller/fsl,irqsteer.yaml         | 89 ++++++++++++++++++++++
 2 files changed, 89 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
deleted file mode 100644
index 582991c..0000000
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-Freescale IRQSTEER Interrupt multiplexer
-
-Required properties:
-
-- compatible: should be:
-	- "fsl,imx8m-irqsteer"
-	- "fsl,imx-irqsteer"
-- reg: Physical base address and size of registers.
-- interrupts: Should contain the up to 8 parent interrupt lines used to
-  multiplex the input interrupts. They should be specified sequentially
-  from output 0 to 7.
-- clocks: Should contain one clock for entry in clock-names
-  see Documentation/devicetree/bindings/clock/clock-bindings.txt
-- clock-names:
-   - "ipg": main logic clock
-- interrupt-controller: Identifies the node as an interrupt controller.
-- #interrupt-cells: Specifies the number of cells needed to encode an
-  interrupt source. The value must be 1.
-- fsl,channel: The output channel that all input IRQs should be steered into.
-- fsl,num-irqs: Number of input interrupts of this channel.
-  Should be multiple of 32 input interrupts and up to 512 interrupts.
-
-Example:
-
-	interrupt-controller@32e2d000 {
-		compatible = "fsl,imx8m-irqsteer", "fsl,imx-irqsteer";
-		reg = <0x32e2d000 0x1000>;
-		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
-		clock-names = "ipg";
-		fsl,channel = <0>;
-		fsl,num-irqs = <64>;
-		interrupt-controller;
-		#interrupt-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
new file mode 100644
index 0000000..360a575
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/fsl,irqsteer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale IRQSTEER Interrupt Multiplexer
+
+maintainers:
+  - Lucas Stach <l.stach@pengutronix.de>
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8m-irqsteer
+      - fsl,imx-irqsteer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: |
+      should contain the up to 8 parent interrupt lines used to multiplex
+      the input interrupts. They should be specified sequentially from
+      output 0 to 7.
+    items:
+      - description: output interrupt 0
+      - description: output interrupt 1
+      - description: output interrupt 2
+      - description: output interrupt 3
+      - description: output interrupt 4
+      - description: output interrupt 5
+      - description: output interrupt 6
+      - description: output interrupt 7
+    minItems: 1
+    maxItems: 8
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: ipg
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+  fsl,channel:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: |
+      u32 value representing the output channel that all input IRQs should be
+      steered into.
+
+  fsl,num-irqs:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: |
+      u32 value representing the number of input interrupts of this channel,
+      should be multiple of 32 input interrupts and up to 512 interrupts.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - interrupt-controller
+  - "#interrupt-cells"
+  - fsl,channel
+  - fsl,num-irqs
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mq-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    interrupt-controller@32e2d000 {
+        compatible = "fsl,imx-irqsteer";
+        reg = <0x32e2d000 0x1000>;
+        interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
+        clock-names = "ipg";
+        fsl,channel = <0>;
+        fsl,num-irqs = <64>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+    };
-- 
2.7.4

