Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA4CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB1720679
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A/Y2Naud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFBMlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:41:06 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44030 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBMlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:41:05 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 052Cf3RM120100;
        Tue, 2 Jun 2020 07:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591101663;
        bh=wRmRkSXnt3fLQN56wOzLfHTAJ2PNWfgj+9sS12W0rio=;
        h=From:To:CC:Subject:Date;
        b=A/Y2NaudgDJa6Otq13YP9xh08d4OzBgxMQLCjhbboRulPbR0F7pYNXEtUzRmXobVv
         lHVTrP6+7p8VE58Vr6Cd9EGYU/cWWLbR1K9nuLsZwnMWJfPejNAGDwp0KBntem1gFh
         ++oH5rF5x1FrxUnhyA0Ezn1mpIpdpj0i4fHuh3tY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 052Cf3H2010020
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Jun 2020 07:41:03 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 2 Jun
 2020 07:41:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 2 Jun 2020 07:41:03 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 052Cf0v7045240;
        Tue, 2 Jun 2020 07:41:01 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH] dt-bindings: usb: ti,keystone-dwc3.yaml: Improve schema
Date:   Tue, 2 Jun 2020 15:40:55 +0300
Message-ID: <20200602124055.1680-1-rogerq@ti.com>
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
 .../bindings/usb/ti,keystone-dwc3.yaml        | 47 ++++++++++++++-----
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml b/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
index f127535feb0b..017c5883184b 100644
--- a/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
@@ -11,30 +11,44 @@ maintainers:
 
 properties:
   compatible:
-    oneOf:
-      - const: "ti,keystone-dwc3"
-      - const: "ti,am654-dwc3"
+    items:
+      - enum:
+        - "ti,keystone-dwc3"
+        - "ti,am654-dwc3"
 
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
+    $ref: /schemas/types.yaml#definitions/phandle-array
     description: Clock ID for USB functional clock.
 
+  assigned-clocks:
+    $ref: /schemas/types.yaml#definitions/phandle-array
+
+  assigned-clock-parents:
+    $ref: /schemas/types.yaml#definitions/phandle-array
+
   power-domains:
+    $ref: /schemas/types.yaml#definitions/phandle-array
     description: Should contain a phandle to a PM domain provider node
       and an args specifier containing the USB device id
       value. This property is as per the binding,
       Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 
   phys:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
     description:
       PHY specifier for the USB3.0 PHY. Some SoCs need the USB3.0 PHY
       to be turned on before the controller.
@@ -44,31 +58,40 @@ properties:
     items:
       - const: "usb3-phy"
 
-  dwc3:
+  dma-coherent: true
+
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

