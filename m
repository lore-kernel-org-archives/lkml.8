Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA4CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FAA8206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHRBLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 21:11:30 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34800 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbgHRBL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 21:11:29 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B09DD1A0F74;
        Tue, 18 Aug 2020 03:11:27 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 22E201A0F2A;
        Tue, 18 Aug 2020 03:11:24 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9C4DD402BE;
        Tue, 18 Aug 2020 03:11:19 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        shengjiu.wang@nxp.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] dt-bindings: sound: Convert NXP spdif to json-schema
Date:   Tue, 18 Aug 2020 09:06:11 +0800
Message-Id: <1597712771-32433-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the NXP SPDIF binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
changes since V1:
	- add "additionalProperties: false".
---
 .../devicetree/bindings/sound/fsl,spdif.txt        |  68 -------------
 .../devicetree/bindings/sound/fsl,spdif.yaml       | 110 +++++++++++++++++++++
 2 files changed, 110 insertions(+), 68 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl,spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,spdif.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.txt b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
deleted file mode 100644
index e1365b0..0000000
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.txt
+++ /dev/null
@@ -1,68 +0,0 @@
-Freescale Sony/Philips Digital Interface Format (S/PDIF) Controller
-
-The Freescale S/PDIF audio block is a stereo transceiver that allows the
-processor to receive and transmit digital audio via an coaxial cable or
-a fibre cable.
-
-Required properties:
-
-  - compatible		: Compatible list, should contain one of the following
-			  compatibles:
-			  "fsl,imx35-spdif",
-			  "fsl,vf610-spdif",
-			  "fsl,imx6sx-spdif",
-
-  - reg			: Offset and length of the register set for the device.
-
-  - interrupts		: Contains the spdif interrupt.
-
-  - dmas		: Generic dma devicetree binding as described in
-			  Documentation/devicetree/bindings/dma/dma.txt.
-
-  - dma-names		: Two dmas have to be defined, "tx" and "rx".
-
-  - clocks		: Contains an entry for each entry in clock-names.
-
-  - clock-names		: Includes the following entries:
-	"core"		  The core clock of spdif controller.
-	"rxtx<0-7>"	  Clock source list for tx and rx clock.
-			  This clock list should be identical to the source
-			  list connecting to the spdif clock mux in "SPDIF
-			  Transceiver Clock Diagram" of SoC reference manual.
-			  It can also be referred to TxClk_Source bit of
-			  register SPDIF_STC.
-	"spba"		  The spba clock is required when SPDIF is placed as a
-			  bus slave of the Shared Peripheral Bus and when two
-			  or more bus masters (CPU, DMA or DSP) try to access
-			  it. This property is optional depending on the SoC
-			  design.
-
-Optional properties:
-
-   - big-endian		: If this property is absent, the native endian mode
-			  will be in use as default, or the big endian mode
-			  will be in use for all the device registers.
-
-Example:
-
-spdif: spdif@2004000 {
-	compatible = "fsl,imx35-spdif";
-	reg = <0x02004000 0x4000>;
-	interrupts = <0 52 0x04>;
-	dmas = <&sdma 14 18 0>,
-	       <&sdma 15 18 0>;
-	dma-names = "rx", "tx";
-
-	clocks = <&clks 197>, <&clks 3>,
-	       <&clks 197>, <&clks 107>,
-	       <&clks 0>, <&clks 118>,
-	       <&clks 62>, <&clks 139>,
-	       <&clks 0>;
-	clock-names = "core", "rxtx0",
-		"rxtx1", "rxtx2",
-		"rxtx3", "rxtx4",
-		"rxtx5", "rxtx6",
-		"rxtx7";
-
-	big-endian;
-};
diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
new file mode 100644
index 0000000..2ac671f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,spdif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Sony/Philips Digital Interface Format (S/PDIF) Controller
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+
+description: |
+  The Freescale S/PDIF audio block is a stereo transceiver that allows the
+  processor to receive and transmit digital audio via an coaxial cable or
+  a fibre cable.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx35-spdif
+      - fsl,vf610-spdif
+      - fsl,imx6sx-spdif
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  dmas:
+    items:
+      - description: DMA controller phandle and request line for RX
+      - description: DMA controller phandle and request line for TX
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+  clocks:
+    items:
+      - description: The core clock of spdif controller.
+      - description: Clock for tx0 and rx0.
+      - description: Clock for tx1 and rx1.
+      - description: Clock for tx2 and rx2.
+      - description: Clock for tx3 and rx3.
+      - description: Clock for tx4 and rx4.
+      - description: Clock for tx5 and rx5.
+      - description: Clock for tx6 and rx6.
+      - description: Clock for tx7 and rx7.
+      - description: The spba clock is required when SPDIF is placed as a bus
+          slave of the Shared Peripheral Bus and when two or more bus masters
+          (CPU, DMA or DSP) try to access it. This property is optional depending
+          on the SoC design.
+    minItems: 9
+
+  clock-names:
+    items:
+      - const: core
+      - const: rxtx0
+      - const: rxtx1
+      - const: rxtx2
+      - const: rxtx3
+      - const: rxtx4
+      - const: rxtx5
+      - const: rxtx6
+      - const: rxtx7
+      - const: spba
+    minItems: 9
+
+  big-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      If this property is absent, the native endian mode will be in use
+      as default, or the big endian mode will be in use for all the device
+      registers. Set this flag for HCDs with big endian descriptors and big
+      endian registers.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - dmas
+  - dma-names
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    spdif@2004000 {
+        compatible = "fsl,imx35-spdif";
+        reg = <0x02004000 0x4000>;
+        interrupts = <0 52 0x04>;
+        dmas = <&sdma 14 18 0>,
+               <&sdma 15 18 0>;
+        dma-names = "rx", "tx";
+        clocks = <&clks 197>, <&clks 3>,
+                 <&clks 197>, <&clks 107>,
+                 <&clks 0>, <&clks 118>,
+                 <&clks 62>, <&clks 139>,
+                 <&clks 0>;
+        clock-names = "core", "rxtx0",
+                      "rxtx1", "rxtx2",
+                      "rxtx3", "rxtx4",
+                      "rxtx5", "rxtx6",
+                      "rxtx7";
+        big-endian;
+    };
-- 
2.7.4

