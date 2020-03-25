Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2F7C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD5E2074D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d+RZYVj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgCYUS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:18:57 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38438 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgCYUS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 16:18:57 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02PKIj6j085839;
        Wed, 25 Mar 2020 15:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585167525;
        bh=YWnbA9p3RGUrjpZGEuExQ7ejQ8cGZmK3O4zvWi+b1+8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=d+RZYVj0RwSPPge/qLJk4R6+yDy3WaPygHYxDbfzOGyWaEidrnA2sSZImU8CRS1I4
         agwEpd5MguGvf8ARG05JShVCLXYZrCjEHIdTcsn+Q/ZCginBvn/h+h2WfT5q57z0mq
         4bn8Vz6HrmGCbkx/3Lr1iJpsSOjzLyMTN6zLKY3g=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02PKIjJN019777;
        Wed, 25 Mar 2020 15:18:45 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 25
 Mar 2020 15:18:45 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 25 Mar 2020 15:18:45 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02PKIjws098090;
        Wed, 25 Mar 2020 15:18:45 -0500
Received: from localhost ([10.250.35.147])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 02PKIjHl090856;
        Wed, 25 Mar 2020 15:18:45 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/3] dt-bindings: remoteproc: Add bindings for C66x DSPs on TI K3 SoCs
Date:   Wed, 25 Mar 2020 15:18:37 -0500
Message-ID: <20200325201839.15896-2-s-anna@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200325201839.15896-1-s-anna@ti.com>
References: <20200325201839.15896-1-s-anna@ti.com>
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
---
 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 180 ++++++++++++++++++
 1 file changed, 180 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
new file mode 100644
index 000000000000..416e3abe7937
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
@@ -0,0 +1,180 @@
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
+properties:
+  compatible:
+    const: ti,j721e-c66-dsp
+    description:
+      Use "ti,j721e-c66-dsp" for C66x DSPs on K3 J721E SoCs
+
+  reg:
+    description: |
+      Should contain an entry for each value in 'reg-names'.
+      Each entry should have the memory region's start address
+      and the size of the region, the representation matching
+      the parent node's '#address-cells' and '#size-cells' values.
+    minItems: 3
+    maxItems: 3
+
+  reg-names:
+    description: |
+      Should contain strings with the names of the specific internal
+      internal memory regions, and should be defined in this order
+    maxItems: 3
+    items:
+      - const: l2sram
+      - const: l1pram
+      - const: l1dram
+
+  ti,sci:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Should be a phandle to the TI-SCI System Controller node
+
+  ti,sci-dev-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Should contain the TI-SCI device id corresponding to the DSP core.
+      Please refer to the corresponding System Controller documentation
+      for valid values for the DSP cores.
+
+  ti,sci-proc-ids:
+    description: Should contain a single tuple of <proc_id host_id>.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-matrix
+      - maxItems: 1
+        items:
+          items:
+            - description: TI-SCI processor id for the DSP core device
+            - description: TI-SCI host id to which processor control
+                           ownership should be transferred to
+
+  resets:
+    description: |
+      Should contain the phandle to the reset controller node
+      managing the resets for this device, and a reset
+      specifier. Please refer to the following reset bindings
+      for the reset argument specifier,
+      Documentation/devicetree/bindings/reset/ti,sci-reset.txt
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
+      with the sub-mailbox node used in the firmware image. The specifier
+      format is as per the bindings,
+      Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
+
+  memory-region:
+    minItems: 2
+    description: |
+      phandle to the reserved memory nodes to be associated with the remoteproc
+      device. There should be atleast two reserved memory nodes defined - the
+      first one would be used for dynamic DMA allocations like vrings and vring
+      buffers, and the remaining ones used for the firmware image sections. The
+      reserved memory nodes should be carveout nodes, and should be defined as
+      per the bindings in
+      Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+
+# Optional properties:
+# --------------------
+
+  sram:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    description: |
+      pHandles to one or more reserved on-chip SRAM regions. The regions
+      should be defined as child nodes of the respective SRAM node, and
+      should be defined as per the generic bindings in,
+      Documentation/devicetree/bindings/sram/sram.yaml
+
+required:
+ - compatible
+ - reg
+ - reg-names
+ - ti,sci
+ - ti,sci-dev-id
+ - ti,sci-proc-ids
+ - resets
+ - firmware-name
+ - mboxes
+ - memory-region
+
+additionalProperties: false
+
+examples:
+  - |
+
+    //Example: J721E SoC
+    /* DSP Carveout reserved memory nodes */
+    reserved-memory {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ranges;
+
+        c66_0_dma_memory_region: c66-dma-memory@a6000000 {
+            compatible = "shared-dma-pool";
+            reg = <0x00 0xa6000000 0x00 0x100000>;
+            no-map;
+        };
+
+        c66_0_memory_region: c66-memory@a6100000 {
+            compatible = "shared-dma-pool";
+            reg = <0x00 0xa6100000 0x00 0xf00000>;
+            no-map;
+        };
+    };
+
+    cbass_main: interconnect@100000 {
+        compatible = "simple-bus";
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ranges = <0x4d 0x80800000 0x4d 0x80800000 0x00 0x00800000>, /* C66_0 */
+                 <0x4d 0x81800000 0x4d 0x81800000 0x00 0x00800000>; /* C66_1 */
+
+        /* J721E C66_0 DSP node */
+        c66_0: dsp@4d80800000 {
+            compatible = "ti,j721e-c66-dsp";
+            reg = <0x4d 0x80800000 0x00 0x00048000>,
+                  <0x4d 0x80e00000 0x00 0x00008000>,
+                  <0x4d 0x80f00000 0x00 0x00008000>;
+            reg-names = "l2sram", "l1pram", "l1dram";
+            ti,sci = <&dmsc>;
+            ti,sci-dev-id = <142>;
+            ti,sci-proc-ids = <0x03 0xFF>;
+            resets = <&k3_reset 142 1>;
+            firmware-name = "j7-c66_0-fw";
+            memory-region = <&c66_0_dma_memory_region>,
+                            <&c66_0_memory_region>;
+            mboxes = <&mailbox0_cluster3 &mbox_c66_0>;
+        };
+    };
-- 
2.23.0

