Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F12C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C502078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dskhWfK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgGJLdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:33:44 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49756 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGJLdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:33:43 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06ABXe8D097451;
        Fri, 10 Jul 2020 06:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594380821;
        bh=FxhfaLSX2SCVsKQvwGQevHvm0zAMmt0Sg5LDxf2xheM=;
        h=From:To:CC:Subject:Date;
        b=dskhWfK3vL5WhYCpJSkw8cWdGGe1t7n29p5Ycxcpv2v2TkXbvY0WFmZEBvs0mig+F
         6mej2CW/JyaQPgxmMh5DkB7QjVtTCX5JbLS6vfijmwCCQVByRxQ3ffkIPc5PU5MXPM
         20SrfuaRrKd70YihJStLroI5IiJWdXpaIb+jNhQA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06ABXeFX067124
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jul 2020 06:33:40 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 10
 Jul 2020 06:33:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 10 Jul 2020 06:33:40 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06ABXc8g094805;
        Fri, 10 Jul 2020 06:33:39 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2] dt-bindings: usb: ti,keystone-dwc3.yaml: Improve schema
Date:   Fri, 10 Jul 2020 14:33:37 +0300
Message-ID: <20200710113337.15954-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were some review comments after the patch was integrated.
Address those.

Fixes: 1883a934e156 ("dt-bindings: usb: convert keystone-usb.txt to YAML")
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../bindings/usb/ti,keystone-dwc3.yaml        | 51 ++++++++++++++-----
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml b/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
index f127535feb0b..804b9b4f6654 100644
--- a/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
@@ -11,22 +11,36 @@ maintainers:
 
 properties:
   compatible:
-    oneOf:
-      - const: "ti,keystone-dwc3"
-      - const: "ti,am654-dwc3"
+    items:
+      - enum:
+        - ti,keystone-dwc3
+        - ti,am654-dwc3
 
   reg:
     maxItems: 1
-    description: Address and length of the register set for the USB subsystem on
-      the SOC.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
 
   interrupts:
     maxItems: 1
-    description: The irq number of this device that is used to interrupt the MPU.
-
 
   clocks:
-    description: Clock ID for USB functional clock.
+    minItems: 1
+    maxItems: 2
+
+  assigned-clocks:
+    minItems: 1
+    maxItems: 2
+
+  assigned-clock-parents:
+    minItems: 1
+    maxItems: 2
 
   power-domains:
     description: Should contain a phandle to a PM domain provider node
@@ -42,33 +56,42 @@ properties:
 
   phy-names:
     items:
-      - const: "usb3-phy"
+      - const: usb3-phy
+
+  dma-coherent: true
 
-  dwc3:
+  dma-ranges: true
+
+patternProperties:
+  "usb@[a-f0-9]+$":
+    type: object
     description: This is the node representing the DWC3 controller instance
       Documentation/devicetree/bindings/usb/dwc3.txt
 
 required:
   - compatible
   - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
   - interrupts
-  - clocks
+
+additionalProperties: false
 
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-    usb: usb@2680000 {
+    dwc3@2680000 {
       compatible = "ti,keystone-dwc3";
       #address-cells = <1>;
       #size-cells = <1>;
       reg = <0x2680000 0x10000>;
       clocks = <&clkusb>;
-      clock-names = "usb";
       interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
       ranges;
 
-      dwc3@2690000 {
+      usb@2690000 {
         compatible = "synopsys,dwc3";
         reg = <0x2690000 0x70000>;
         interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

