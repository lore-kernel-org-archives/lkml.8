Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFE9C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C61A720717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ndmgo8xU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgGQXsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:48:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57122 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgGQXsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:48:17 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06HNmAqb074558;
        Fri, 17 Jul 2020 18:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595029690;
        bh=OdkjPeIdiBa8i+tjj3235y24tKPnNEZ0MO18ofpr6f4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ndmgo8xUUpKRCUqy1KPXFff2umWZTxkNltnlYD7TYKj7hiJoszR25dtsEkC0ptbXK
         gwISxs/DGOufeOq42iGNx5qSnvB8TCvqSeoGNFJJfvhBUA9KgMvXuH60dIhNMOvyFb
         qU2zuoGXQ/00eebm9XsBslsS9LL/G9a4yy7AL8CM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06HNmAoa042736
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 18:48:10 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 18:48:09 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 18:48:09 -0500
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HNm9EM016608;
        Fri, 17 Jul 2020 18:48:09 -0500
Received: from localhost ([10.250.34.57])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 06HNm9f3108295;
        Fri, 17 Jul 2020 18:48:09 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 4/6] dt-bindings: remoteproc: Add bindings for C66x DSPs on TI K3 SoCs
Date:   Fri, 17 Jul 2020 18:47:58 -0500
Message-ID: <20200717234800.9423-5-s-anna@ti.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200717234800.9423-1-s-anna@ti.com>
References: <20200717234800.9423-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Texas Instruments K3 family of SoCs have one of more Digital Signal
Processor (DSP) subsystems that are comprised of either a TMS320C66x
CorePac and/or a next-generation TMS320C71x CorePac processor subsystem.
Add the device tree bindings document for the C66x DSP devices on these
SoCs. The added example illustrates the DT nodes for the first C66x DSP
device present on the K3 J721E family of SoCs.

Signed-off-by: Suman Anna <s-anna@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v4: No changes, picked up Rob's Reviewed-by tag
v3: https://patchwork.kernel.org/patch/11602325/

 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 139 ++++++++++++++++++
 1 file changed, 139 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
new file mode 100644
index 000000000000..f03e88c42a6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
@@ -0,0 +1,139 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI K3 DSP devices
+
+maintainers:
+  - Suman Anna <s-anna@ti.com>
+
+description: |
+  The TI K3 family of SoCs usually have one or more TI DSP Core sub-systems
+  that are used to offload some of the processor-intensive tasks or algorithms,
+  for achieving various system level goals.
+
+  These processor sub-systems usually contain additional sub-modules like
+  L1 and/or L2 caches/SRAMs, an Interrupt Controller, an external memory
+  controller, a dedicated local power/sleep controller etc. The DSP processor
+  cores in the K3 SoCs are usually either a TMS320C66x CorePac processor or a
+  TMS320C71x CorePac processor.
+
+  Each DSP Core sub-system is represented as a single DT node. Each node has a
+  number of required or optional properties that enable the OS running on the
+  host processor (Arm CorePac) to perform the device management of the remote
+  processor and to communicate with the remote processor.
+
+allOf:
+  - $ref: "ti,k3-sci-proc.yaml#"
+
+properties:
+  compatible:
+    const: ti,j721e-c66-dsp
+    description:
+      Use "ti,j721e-c66-dsp" for C66x DSPs on K3 J721E SoCs
+
+  reg:
+    items:
+      - description: Address and Size of the L2 SRAM internal memory region
+      - description: Address and Size of the L1 PRAM internal memory region
+      - description: Address and Size of the L1 DRAM internal memory region
+
+  reg-names:
+    items:
+      - const: l2sram
+      - const: l1pram
+      - const: l1dram
+
+  resets:
+    description: |
+      Should contain the phandle to the reset controller node managing the
+      local resets for this device, and a reset specifier.
+    maxItems: 1
+
+  firmware-name:
+    description: |
+      Should contain the name of the default firmware image
+      file located on the firmware search path
+
+  mboxes:
+    description: |
+      OMAP Mailbox specifier denoting the sub-mailbox, to be used for
+      communication with the remote processor. This property should match
+      with the sub-mailbox node used in the firmware image.
+    maxItems: 1
+
+  memory-region:
+    minItems: 2
+    maxItems: 8
+    description: |
+      phandle to the reserved memory nodes to be associated with the remoteproc
+      device. There should be at least two reserved memory nodes defined. The
+      reserved memory nodes should be carveout nodes, and should be defined as
+      per the bindings in
+      Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+    items:
+      - description: region used for dynamic DMA allocations like vrings and
+                     vring buffers
+      - description: region reserved for firmware image sections
+    additionalItems: true
+
+# Optional properties:
+# --------------------
+
+  sram:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    maxItems: 4
+    description: |
+      phandles to one or more reserved on-chip SRAM regions. The regions
+      should be defined as child nodes of the respective SRAM node, and
+      should be defined as per the generic bindings in,
+      Documentation/devicetree/bindings/sram/sram.yaml
+
+required:
+ - compatible
+ - reg
+ - reg-names
+ - resets
+ - firmware-name
+ - mboxes
+ - memory-region
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    / {
+        model = "Texas Instruments K3 J721E SoC";
+        compatible = "ti,j721e";
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        bus@100000 {
+            compatible = "simple-bus";
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
+                     <0x4d 0x80800000 0x4d 0x80800000 0x00 0x00800000>, /* C66_0 */
+                     <0x4d 0x81800000 0x4d 0x81800000 0x00 0x00800000>; /* C66_1 */
+
+            /* J721E C66_0 DSP node */
+            dsp@4d80800000 {
+                compatible = "ti,j721e-c66-dsp";
+                reg = <0x4d 0x80800000 0x00 0x00048000>,
+                      <0x4d 0x80e00000 0x00 0x00008000>,
+                      <0x4d 0x80f00000 0x00 0x00008000>;
+                reg-names = "l2sram", "l1pram", "l1dram";
+                ti,sci = <&dmsc>;
+                ti,sci-dev-id = <142>;
+                ti,sci-proc-ids = <0x03 0xFF>;
+                resets = <&k3_reset 142 1>;
+                firmware-name = "j7-c66_0-fw";
+                memory-region = <&c66_0_dma_memory_region>,
+                                <&c66_0_memory_region>;
+                mboxes = <&mailbox0_cluster3 &mbox_c66_0>;
+            };
+        };
+    };
-- 
2.26.0

