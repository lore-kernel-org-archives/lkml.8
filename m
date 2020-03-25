Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7437AC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B79B206F8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qwO8aTCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgCYUr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:47:28 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40914 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYUr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 16:47:27 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02PKl6n0060227;
        Wed, 25 Mar 2020 15:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585169226;
        bh=GEKRmSESoMDG0lbS4ZyyT2Q80xiJh4SlP+/NplyuYdg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qwO8aTCjipPXRzfKqo0sUFVKAQ8sXcGXu/NgFXTKZxmX4wBjDc5uERdWtCSGTs6OF
         FzPC9e+TzR2GP03KFIFATEypLfSA7dbofZg6xYFPNOkesM7xdqKB+89rwoe5Ta8vBj
         iVMoCrqEoKYBmE7rSe4k2CUu0TJFYF8E0+5KQhF0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02PKl6Bh102565
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Mar 2020 15:47:06 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 25
 Mar 2020 15:47:05 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 25 Mar 2020 15:47:05 -0500
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02PKl5fA018619;
        Wed, 25 Mar 2020 15:47:05 -0500
Received: from localhost ([10.250.35.147])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 02PKl557063372;
        Wed, 25 Mar 2020 15:47:05 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Clement Leger <cleger@kalray.eu>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/4] dt-bindings: remoteproc: k3-dsp: Update bindings for C71x DSPs
Date:   Wed, 25 Mar 2020 15:46:58 -0500
Message-ID: <20200325204701.16862-2-s-anna@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200325204701.16862-1-s-anna@ti.com>
References: <20200325204701.16862-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Texas Instruments K3 family of SoCs have one of more newer
generation TMS320C71x CorePac processor subsystem in addition to
the existing TMS320C66x CorePac processor subsystems. Update the
device tree bindings document for the C71x DSP devices.

The example is also updated to show the single C71 DSP present
on J721E SoCs.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 78 ++++++++++++++++---
 1 file changed, 69 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
index 416e3abe7937..6b1536509c39 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
@@ -27,9 +27,12 @@ description: |
 
 properties:
   compatible:
-    const: ti,j721e-c66-dsp
+    enum:
+      - ti,j721e-c66-dsp
+      - ti,j721e-c71-dsp
     description:
       Use "ti,j721e-c66-dsp" for C66x DSPs on K3 J721E SoCs
+      Use "ti,j721e-c71-dsp" for C71x DSPs on K3 J721E SoCs
 
   reg:
     description: |
@@ -37,18 +40,11 @@ properties:
       Each entry should have the memory region's start address
       and the size of the region, the representation matching
       the parent node's '#address-cells' and '#size-cells' values.
-    minItems: 3
-    maxItems: 3
 
   reg-names:
     description: |
       Should contain strings with the names of the specific internal
       internal memory regions, and should be defined in this order
-    maxItems: 3
-    items:
-      - const: l2sram
-      - const: l1pram
-      - const: l1dram
 
   ti,sci:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -117,6 +113,41 @@ properties:
       should be defined as per the generic bindings in,
       Documentation/devicetree/bindings/sram/sram.yaml
 
+if:
+  properties:
+    compatible:
+      enum:
+        - ti,j721e-c66-dsp
+then:
+  properties:
+    reg:
+      minItems: 3
+      maxItems: 3
+    reg-names:
+      minItems: 3
+      maxItems: 3
+      items:
+        - const: l2sram
+        - const: l1pram
+        - const: l1dram
+else:
+  if:
+    properties:
+      compatible:
+        enum:
+          - ti,j721e-c71-dsp
+  then:
+    properties:
+      reg:
+        minItems: 2
+        maxItems: 2
+      reg-names:
+        minItems: 2
+        maxItems: 2
+        items:
+          - const: l2sram
+          - const: l1dram
+
 required:
  - compatible
  - reg
@@ -152,13 +183,26 @@ examples:
             reg = <0x00 0xa6100000 0x00 0xf00000>;
             no-map;
         };
+
+        c71_0_dma_memory_region: c71-dma-memory@a8000000 {
+            compatible = "shared-dma-pool";
+            reg = <0x00 0xa8000000 0x00 0x100000>;
+            no-map;
+        };
+
+        c71_0_memory_region: c71-memory@a8100000 {
+            compatible = "shared-dma-pool";
+            reg = <0x00 0xa8100000 0x00 0xf00000>;
+            no-map;
+        };
     };
 
     cbass_main: interconnect@100000 {
         compatible = "simple-bus";
         #address-cells = <2>;
         #size-cells = <2>;
-        ranges = <0x4d 0x80800000 0x4d 0x80800000 0x00 0x00800000>, /* C66_0 */
+        ranges = <0x00 0x64800000 0x00 0x64800000 0x00 0x00800000>, /* C71_0 */
+                 <0x4d 0x80800000 0x4d 0x80800000 0x00 0x00800000>, /* C66_0 */
                  <0x4d 0x81800000 0x4d 0x81800000 0x00 0x00800000>; /* C66_1 */
 
         /* J721E C66_0 DSP node */
@@ -177,4 +221,20 @@ examples:
                             <&c66_0_memory_region>;
             mboxes = <&mailbox0_cluster3 &mbox_c66_0>;
         };
+
+        /* J721E C71_0 DSP node */
+        c71_0: dsp@64800000 {
+            compatible = "ti,j721e-c71-dsp";
+            reg = <0x00 0x64800000 0x00 0x00080000>,
+                  <0x00 0x64e00000 0x00 0x0000c000>;
+            reg-names = "l2sram", "l1dram";
+            ti,sci = <&dmsc>;
+            ti,sci-dev-id = <15>;
+            ti,sci-proc-ids = <0x30 0xFF>;
+            resets = <&k3_reset 15 1>;
+            firmware-name = "j7-c71_0-fw";
+            memory-region = <&c71_0_dma_memory_region>,
+                            <&c71_0_memory_region>;
+            mboxes = <&mailbox0_cluster4 &mbox_c71_0>;
+        };
     };
-- 
2.23.0

