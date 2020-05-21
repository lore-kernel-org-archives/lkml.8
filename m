Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A441C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5749220748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iRP6+LyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbgEUPQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:16:49 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47968 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbgEUPQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:16:47 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04LFGe34107365;
        Thu, 21 May 2020 10:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590074200;
        bh=LLXDK/X4fW4hsCWDc/19skeMLPMtI4byaWU8XJQ91EQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iRP6+LyWbZyTgJ9g0f8YLWf+6+uE+3nrSDKMkU5slICeGxw6PmjptuUZWApqaMS6w
         VALOmKnr+e0dCkEp5ADDggUT7flC1IRZt2afmVoNyKHXaaplSIEn3QkmVoLuGIwN9X
         v0YyxzSzz++M19xfogq9dfnwvk7sZED89845hORU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LFGehm035521;
        Thu, 21 May 2020 10:16:40 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 10:16:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 10:16:40 -0500
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LFGeur028962;
        Thu, 21 May 2020 10:16:40 -0500
Received: from localhost ([10.250.48.148])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 04LFGehK076178;
        Thu, 21 May 2020 10:16:40 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: remoteproc: k3-dsp: Update bindings for C71x DSPs
Date:   Thu, 21 May 2020 10:16:35 -0500
Message-ID: <20200521151636.28260-2-s-anna@ti.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200521151636.28260-1-s-anna@ti.com>
References: <20200521151636.28260-1-s-anna@ti.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
v2: 
 - Rebased patch, no changes to binding properties
 - Example additions indented one level to right as part of rebase and
   changes done in updated C66x bindings patch
 - Added Rob's Reviewed-by
v1: https://patchwork.kernel.org/patch/11458601/

 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 76 +++++++++++++++++--
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
index cdf649655838..47642015c884 100644
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
       memory regions, and should be defined in this order
-    maxItems: 3
-    items:
-      - const: l2sram
-      - const: l1pram
-      - const: l1dram
 
   ti,sci:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -121,6 +117,41 @@ properties:
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
@@ -160,6 +191,18 @@ examples:
                 reg = <0x00 0xa6100000 0x00 0xf00000>;
                 no-map;
             };
+
+            c71_0_dma_memory_region: c71-dma-memory@a8000000 {
+                compatible = "shared-dma-pool";
+                reg = <0x00 0xa8000000 0x00 0x100000>;
+                no-map;
+            };
+
+            c71_0_memory_region: c71-memory@a8100000 {
+                compatible = "shared-dma-pool";
+                reg = <0x00 0xa8100000 0x00 0xf00000>;
+                no-map;
+            };
         };
 
         cbass_main: bus@100000 {
@@ -167,6 +210,7 @@ examples:
             #address-cells = <2>;
             #size-cells = <2>;
             ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
+                     <0x00 0x64800000 0x00 0x64800000 0x00 0x00800000>, /* C71_0 */
                      <0x4d 0x80800000 0x4d 0x80800000 0x00 0x00800000>, /* C66_0 */
                      <0x4d 0x81800000 0x4d 0x81800000 0x00 0x00800000>; /* C66_1 */
 
@@ -186,5 +230,21 @@ examples:
                                 <&c66_0_memory_region>;
                 mboxes = <&mailbox0_cluster3 &mbox_c66_0>;
             };
+
+            /* J721E C71_0 DSP node */
+            c71_0: dsp@64800000 {
+                compatible = "ti,j721e-c71-dsp";
+                reg = <0x00 0x64800000 0x00 0x00080000>,
+                      <0x00 0x64e00000 0x00 0x0000c000>;
+                reg-names = "l2sram", "l1dram";
+                ti,sci = <&dmsc>;
+                ti,sci-dev-id = <15>;
+                ti,sci-proc-ids = <0x30 0xFF>;
+                resets = <&k3_reset 15 1>;
+                firmware-name = "j7-c71_0-fw";
+                memory-region = <&c71_0_dma_memory_region>,
+                                <&c71_0_memory_region>;
+                mboxes = <&mailbox0_cluster4 &mbox_c71_0>;
+            };
         };
     };
-- 
2.26.0

