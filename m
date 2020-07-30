Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BD6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6CA220829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgG3Mrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 08:47:49 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54286 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgG3Mrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:47:49 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A09FD1A0D32;
        Thu, 30 Jul 2020 14:47:46 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5F0681A03B3;
        Thu, 30 Jul 2020 14:47:42 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BF8EE402AA;
        Thu, 30 Jul 2020 14:47:36 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, han.xu@nxp.com, u.kleine-koenig@pengutronix.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] dt-bindings: mtd: Convert gpmi nand to json-schema
Date:   Thu, 30 Jul 2020 20:43:23 +0800
Message-Id: <1596113004-15548-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the gpmi nand controller binding to DT schema format
using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/mtd/gpmi-nand.txt          |  75 -------------
 .../devicetree/bindings/mtd/gpmi-nand.yaml         | 118 +++++++++++++++++++++
 2 files changed, 118 insertions(+), 75 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/gpmi-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/gpmi-nand.yaml

diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
deleted file mode 100644
index 3935883..0000000
--- a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
+++ /dev/null
@@ -1,75 +0,0 @@
-* Freescale General-Purpose Media Interface (GPMI)
-
-The GPMI nand controller provides an interface to control the
-NAND flash chips.
-
-Required properties:
-  - compatible : should be "fsl,<chip>-gpmi-nand", chip can be:
-    * imx23
-    * imx28
-    * imx6q
-    * imx6sx
-    * imx7d
-  - reg : should contain registers location and length for gpmi and bch.
-  - reg-names: Should contain the reg names "gpmi-nand" and "bch"
-  - interrupts : BCH interrupt number.
-  - interrupt-names : Should be "bch".
-  - dmas: DMA specifier, consisting of a phandle to DMA controller node
-    and GPMI DMA channel ID.
-    Refer to dma.txt and fsl-mxs-dma.txt for details.
-  - dma-names: Must be "rx-tx".
-  - clocks : clocks phandle and clock specifier corresponding to each clock
-    specified in clock-names.
-  - clock-names : The "gpmi_io" clock is always required. Which clocks are
-    exactly required depends on chip:
-    * imx23/imx28 : "gpmi_io"
-    * imx6q/sx : "gpmi_io", "gpmi_apb", "gpmi_bch", "gpmi_bch_apb", "per1_bch"
-    * imx7d : "gpmi_io", "gpmi_bch_apb"
-
-Optional properties:
-  - nand-on-flash-bbt: boolean to enable on flash bbt option if not
-                       present false
-  - fsl,use-minimum-ecc: Protect this NAND flash with the minimum ECC
-                       strength required. The required ECC strength is
-                       automatically discoverable for some flash
-                       (e.g., according to the ONFI standard).
-                       However, note that if this strength is not
-                       discoverable or this property is not enabled,
-                       the software may chooses an implementation-defined
-                       ECC scheme.
-  - fsl,no-blockmark-swap: Don't swap the bad block marker from the OOB
-                       area with the byte in the data area but rely on the
-                       flash based BBT for identifying bad blocks.
-                       NOTE: this is only valid in conjunction with
-                             'nand-on-flash-bbt'.
-                       WARNING: on i.MX28 blockmark swapping cannot be
-                       disabled for the BootROM in the FCB. Thus,
-                       partitions written from Linux with this feature
-                       turned on may not be accessible by the BootROM
-                       code.
-  - nand-ecc-strength: integer representing the number of bits to correct
-                       per ECC step. Needs to be a multiple of 2.
-  - nand-ecc-step-size: integer representing the number of data bytes
-                       that are covered by a single ECC step. The driver
-                       supports 512 and 1024.
-
-The device tree may optionally contain sub-nodes describing partitions of the
-address space. See partition.txt for more detail.
-
-Examples:
-
-gpmi-nand@8000c000 {
-	compatible = "fsl,imx28-gpmi-nand";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	reg = <0x8000c000 2000>, <0x8000a000 2000>;
-	reg-names = "gpmi-nand", "bch";
-	interrupts = <41>;
-	interrupt-names = "bch";
-	dmas = <&dma_apbh 4>;
-	dma-names = "rx-tx";
-
-	partition@0 {
-	...
-	};
-};
diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
new file mode 100644
index 0000000..354cb63
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/gpmi-nand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:  Freescale General-Purpose Media Interface (GPMI) binding
+
+maintainers:
+  - Han Xu <han.xu@nxp.com>
+
+allOf:
+  - $ref: "nand-controller.yaml"
+
+description: |
+  The GPMI nand controller provides an interface to control the NAND
+  flash chips. The device tree may optionally contain sub-nodes
+  describing partitions of the address space. See partition.txt for
+  more detail.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx23-gpmi-nand
+      - fsl,imx28-gpmi-nand
+      - fsl,imx6q-gpmi-nand
+      - fsl,imx6sx-gpmi-nand
+      - fsl,imx7d-gpmi-nand
+
+  reg:
+    items:
+      - description: Address and length of gpmi block.
+      - description: Address and length of bch block.
+
+  reg-names:
+    items:
+      - const: gpmi-nand
+      - const: bch
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: bch
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rx-tx
+
+  clocks:
+    minItems: 1
+    maxItems: 5
+    items:
+      - description: SoC gpmi io clock
+      - description: SoC gpmi apb clock
+      - description: SoC gpmi bch clock
+      - description: SoC gpmi bch apb clock
+      - description: SoC per1 bch clock
+
+  clock-names:
+    minItems: 1
+    maxItems: 5
+    items:
+      - const: gpmi_io
+      - const: gpmi_apb
+      - const: gpmi_bch
+      - const: gpmi_bch_apb
+      - const: per1_bch
+
+  fsl,use-minimum-ecc:
+    type: boolean
+    description: |
+      Protect this NAND flash with the minimum ECC strength required.
+      The required ECC strength is automatically discoverable for some
+      flash (e.g., according to the ONFI standard). However, note that
+      if this strength is not discoverable or this property is not enabled,
+      the software may chooses an implementation-defined ECC scheme.
+
+  fsl,no-blockmark-swap:
+    type: boolean
+    description: |
+      Don't swap the bad block marker from the OOB area with the byte in
+      the data area but rely on the flash based BBT for identifying bad blocks.
+      NOTE: this is only valid in conjunction with 'nand-on-flash-bbt'.
+      WARNING: on i.MX28 blockmark swapping cannot be disabled for the BootROM
+      in the FCB. Thus, partitions written from Linux with this feature turned
+      on may not be accessible by the BootROM code.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    nand-controller@8000c000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "fsl,imx28-gpmi-nand";
+        reg = <0x8000c000 0x2000>, <0x8000a000 0x2000>;
+        reg-names = "gpmi-nand", "bch";
+        interrupts = <41>;
+        interrupt-names = "bch";
+        clocks = <&clks 50>;
+        clock-names = "gpmi_io";
+        dmas = <&dma_apbh 4>;
+        dma-names = "rx-tx";
+    };
-- 
2.7.4

