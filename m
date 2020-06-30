Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F41CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251B22071A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ybVhGWJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgF3Ctm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 22:49:42 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53368 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbgF3Cth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 22:49:37 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05U2nROc069929;
        Mon, 29 Jun 2020 21:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593485367;
        bh=Kvx/TSoX1EIJW4nPPw6EZWnrOMo0sGA9WQcmutXR1HQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ybVhGWJ55MjKuMECrL76LRXoncAVL1N9lOjVXY192Afko4ut1rLQ/XVrDj4HPBcnt
         tf2nW4LvgbGmsw11DfSWN1csHWYV0n1PQ4ttCS3oYiLiXvyemc6txeZyYC63H4kMX4
         aj02LMmsKESsRODBu9kXxMKAhKdJG6mE/FCFWcT8=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05U2nRZs085761;
        Mon, 29 Jun 2020 21:49:27 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 29
 Jun 2020 21:49:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 29 Jun 2020 21:49:26 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05U2nQsA075199;
        Mon, 29 Jun 2020 21:49:26 -0500
Received: from localhost ([10.250.48.148])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 05U2nQPx029147;
        Mon, 29 Jun 2020 21:49:26 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 1/4] dt-bindings: remoteproc: Add bindings for R5F subsystem on TI K3 SoCs
Date:   Mon, 29 Jun 2020 21:49:19 -0500
Message-ID: <20200630024922.32491-2-s-anna@ti.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200630024922.32491-1-s-anna@ti.com>
References: <20200630024922.32491-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Texas Instruments K3 family of SoCs have one or more dual-core
Arm Cortex R5F processor subsystems/clusters (R5FSS). The clusters
can be split between multiple voltage domains as well. Add the device
tree bindings document for these R5F subsystem devices. These R5F
processors do not have an MMU, and so require fixed memory carveout
regions matching the firmware image addresses. The nodes require more
than one memory region, with the first memory region used for DMA
allocations at runtime. The remaining memory regions are reserved
and are used for the loading and running of the R5F remote processors.
The R5F processors can also optionally use any internal on-chip SRAM
memories either for executing code or using it as fast-access data.

The added example illustrates the DT nodes for the single R5FSS device
present on K3 AM65x family of SoCs.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
v2:
 - Renamed "lockstep-mode" property to "ti,cluster-mode"
 - Added 2 additional paragraphs to the R5F child node descriptions
 - Leverage the common ti,k3-sci-proc.yaml binding for "ti,sci", 
   "ti,sci-dev-id" and "ti,sci-proc-ids" properties
 - Added ti, vendor prefix to "atcm-enable", "btcm-enable" and "loczrama"
   properties. Revised the descriptions slightly for these properties
 - Dropped the general description and maxItems against reg and reg-names
 - Added items list under reg
 - Added maxItems to resets, mboxes, memory-region, sram properties
 - Revised the memory-region description and listed the mandatory items
 - Removed the other binding references from the description for "resets",
   "power-domains" and "mboxes"
 - Updated the example to drop reserved-memory nodes and MCU SRAM node, use
   new property names.
 - Updated the example to include a root-node to fix the bot errors around
   ranges from v1
 - Cleaned up some commented out text
v1: https://patchwork.kernel.org/patch/11456381/

 .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  | 278 ++++++++++++++++++
 1 file changed, 278 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
new file mode 100644
index 000000000000..f4af0329f243
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
@@ -0,0 +1,278 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/ti,k3-r5f-rproc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI K3 R5F processor subsystems
+
+maintainers:
+  - Suman Anna <s-anna@ti.com>
+
+description: |
+  The TI K3 family of SoCs usually have one or more dual-core Arm Cortex R5F
+  processor subsystems/clusters (R5FSS). The dual core cluster can be used
+  either in a LockStep mode providing safety/fault tolerance features or in a
+  Split mode providing two individual compute cores for doubling the compute
+  capacity. These are used together with other processors present on the SoC
+  to achieve various system level goals.
+
+  Each Dual-Core R5F sub-system is represented as a single DTS node
+  representing the cluster, with a pair of child DT nodes representing
+  the individual R5F cores. Each node has a number of required or optional
+  properties that enable the OS running on the host processor to perform
+  the device management of the remote processor and to communicate with the
+  remote processor.
+
+properties:
+  $nodename:
+    pattern: "^r5fss(@.*)?"
+
+  compatible:
+    enum:
+      - ti,am654-r5fss
+      - ti,j721e-r5fss
+
+  power-domains:
+    description: |
+      Should contain a phandle to a PM domain provider node and an args
+      specifier containing the R5FSS device id value.
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges:
+    description: |
+      Standard ranges definition providing address translations for
+      local R5F TCM address spaces to bus addresses.
+
+# Optional properties:
+# --------------------
+
+  ti,cluster-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description: |
+      Configuration Mode for the Dual R5F cores within the R5F cluster.
+      Should be either a value of 1 (LockStep mode) or 0 (Split mode),
+      default is LockStep mode if omitted.
+
+# R5F Processor Child Nodes:
+# ==========================
+
+patternProperties:
+  "^r5f@[a-f0-9]+$":
+    type: object
+    description: |
+      The R5F Sub-System device node should define two R5F child nodes, each
+      node representing a TI instantiation of the Arm Cortex R5F core. There
+      are some specific integration differences for the IP like the usage of
+      a Region Address Translator (RAT) for translating the larger SoC bus
+      addresses into a 32-bit address space for the processor.
+
+      Each R5F core has an associated 64 KB of Tightly-Coupled Memory (TCM)
+      internal memories split between two banks - TCMA and TCMB (further
+      interleaved into two banks TCMB0 and TCMB1). These memories (also called
+      ATCM and BTCM) provide read/write performance on par with the core's L1
+      caches. Each of the TCMs can be enabled or disabled independently and
+      either of them can be configured to appear at that R5F's address 0x0.
+
+      The cores do not use an MMU, but has a Region Address Translater
+      (RAT) module that is accessible only from the R5Fs for providing
+      translations between 32-bit CPU addresses into larger system bus
+      addresses. Cache and memory access settings are provided through a
+      Memory Protection Unit (MPU), programmable only from the R5Fs.
+
+    allOf:
+      - $ref: "ti,k3-sci-proc.yaml#"
+
+    properties:
+      compatible:
+        enum:
+          - ti,am654-r5f
+          - ti,j721e-r5f
+
+      reg:
+        items:
+          - description: Address and Size of the ATCM internal memory region
+          - description: Address and Size of the BTCM internal memory region
+
+      reg-names:
+        items:
+          - const: atcm
+          - const: btcm
+
+      resets:
+        description: |
+          Should contain the phandle to the reset controller node managing the
+          local resets for this device, and a reset specifier.
+        maxItems: 1
+
+      firmware-name:
+        description: |
+          Should contain the name of the default firmware image
+          file located on the firmware search path
+
+# The following properties are mandatory for R5F Core0 in both LockStep and Split
+# modes, and are mandatory for R5F Core1 _only_ in Split mode. They are unused for
+# R5F Core1 in LockStep mode:
+
+      mboxes:
+        description: |
+          OMAP Mailbox specifier denoting the sub-mailbox, to be used for
+          communication with the remote processor. This property should match
+          with the sub-mailbox node used in the firmware image.
+        maxItems: 1
+
+      memory-region:
+        description: |
+          phandle to the reserved memory nodes to be associated with the
+          remoteproc device. There should be at least two reserved memory nodes
+          defined. The reserved memory nodes should be carveout nodes, and
+          should be defined with a "no-map" property as per the bindings in
+          Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+        minItems: 2
+        maxItems: 8
+        items:
+          - description: region used for dynamic DMA allocations like vrings and
+                         vring buffers
+          - description: region reserved for firmware image sections
+        additionalItems: true
+
+
+# Optional properties:
+# --------------------
+# The following properties are optional properties for each of the R5F cores:
+
+      ti,atcm-enable:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1]
+        description: |
+          R5F core configuration mode dictating if ATCM should be enabled. The
+          R5F address of ATCM is dictated by ti,loczrama property. Should be
+          either a value of 1 (enabled) or 0 (disabled), default is disabled
+          if omitted. Recommended to enable it for maximizing TCMs.
+
+      ti,btcm-enable:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1]
+        description: |
+          R5F core configuration mode dictating if BTCM should be enabled. The
+          R5F address of BTCM is dictated by ti,loczrama property. Should be
+          either a value of 1 (enabled) or 0 (disabled), default is enabled if
+          omitted.
+
+      ti,loczrama:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1]
+        description: |
+          R5F core configuration mode dictating which TCM should appear at
+          address 0 (from core's view). Should be either a value of 1 (ATCM
+          at 0x0) or 0 (BTCM at 0x0), default value is 1 if omitted.
+
+      sram:
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        minItems: 1
+        maxItems: 4
+        description: |
+          phandles to one or more reserved on-chip SRAM regions. The regions
+          should be defined as child nodes of the respective SRAM node, and
+          should be defined as per the generic bindings in,
+          Documentation/devicetree/bindings/sram/sram.yaml
+
+    required:
+     - compatible
+     - reg
+     - reg-names
+     - resets
+     - firmware-name
+
+    unevaluatedProperties: false
+
+required:
+ - compatible
+ - power-domains
+ - "#address-cells"
+ - "#size-cells"
+ - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    / {
+        model = "Texas Instruments K3 AM654 SoC";
+        compatible = "ti,am654";
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        bus@100000 {
+            compatible = "simple-bus";
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
+                     <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>,
+                     <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>,
+                     <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00080000>;
+
+            bus@28380000 {
+                compatible = "simple-bus";
+                #address-cells = <2>;
+                #size-cells = <2>;
+                ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>, /* MCU NAVSS */
+                         <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>, /* MCU R5F Core0 */
+                         <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>, /* MCU R5F Core1 */
+                         <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00080000>; /* MCU SRAM */
+
+                /* AM65x MCU R5FSS node */
+                mcu_r5fss0: r5fss@41000000 {
+                    compatible = "ti,am654-r5fss";
+                    power-domains = <&k3_pds 129>;
+                    ti,cluster-mode = <1>;
+                    #address-cells = <1>;
+                    #size-cells = <1>;
+                    ranges = <0x41000000 0x00 0x41000000 0x20000>,
+                             <0x41400000 0x00 0x41400000 0x20000>;
+
+                    mcu_r5f0: r5f@41000000 {
+                        compatible = "ti,am654-r5f";
+                        reg = <0x41000000 0x00008000>,
+                              <0x41010000 0x00008000>;
+                        reg-names = "atcm", "btcm";
+                        ti,sci = <&dmsc>;
+                        ti,sci-dev-id = <159>;
+                        ti,sci-proc-ids = <0x01 0xFF>;
+                        resets = <&k3_reset 159 1>;
+                        firmware-name = "am65x-mcu-r5f0_0-fw";
+                        ti,atcm-enable = <1>;
+                        ti,btcm-enable = <1>;
+                        ti,loczrama = <1>;
+                        mboxes = <&mailbox0 &mbox_mcu_r5fss0_core0>;
+                        memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
+                                        <&mcu_r5fss0_core0_memory_region>;
+                        sram = <&mcu_r5fss0_core0_sram>;
+                    };
+
+                    mcu_r5f1: r5f@41400000 {
+                        compatible = "ti,am654-r5f";
+                        reg = <0x41400000 0x00008000>,
+                              <0x41410000 0x00008000>;
+                        reg-names = "atcm", "btcm";
+                        ti,sci = <&dmsc>;
+                        ti,sci-dev-id = <245>;
+                        ti,sci-proc-ids = <0x02 0xFF>;
+                        resets = <&k3_reset 245 1>;
+                        firmware-name = "am65x-mcu-r5f0_1-fw";
+                        ti,atcm-enable = <1>;
+                        ti,btcm-enable = <1>;
+                        ti,loczrama = <1>;
+                        mboxes = <&mailbox1 &mbox_mcu_r5fss0_core1>;
+                    };
+                };
+            };
+        };
+    };
-- 
2.26.0

