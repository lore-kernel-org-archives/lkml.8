Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39A0C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E7320767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aaJfJ0Zl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgIBOcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:32:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43740 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgIBObu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:31:50 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 082DZoZm028430;
        Wed, 2 Sep 2020 08:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599053750;
        bh=x3r2gTj8CyI+Zc8dr6rfCAoHWCQlvOesBeP8eivIgl4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=aaJfJ0Zl2YItpVlHR/NrFJ1UoWWwdsg1iriJocJWlB7K3D+9Vqrke0cWijlG+EWc6
         zxSIfFvfrLzQUnV4SiCKSoC72Y6PR26X+lblXojSxkM51yqS9pd69o8/y3TQFUxN0f
         buzCRFNgT9QduAjtypcCulXRGbYFvumaA5DD95qM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 082DZoNa056958
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Sep 2020 08:35:50 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 2 Sep
 2020 08:35:49 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 2 Sep 2020 08:35:49 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 082DZiGA065816;
        Wed, 2 Sep 2020 08:35:47 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>
CC:     <pawell@cadence.com>, <kurahul@cadence.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 1/3] dt-bindings: usb: Convert cdns-usb3.txt to YAML schema
Date:   Wed, 2 Sep 2020 16:35:41 +0300
Message-ID: <20200902133543.17222-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902133543.17222-1-rogerq@ti.com>
References: <20200902133543.17222-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts cdns-usb3.txt to YAML schema cdns,usb3.yaml

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../devicetree/bindings/usb/cdns,usb3.yaml    | 89 +++++++++++++++++++
 .../devicetree/bindings/usb/cdns-usb3.txt     | 45 ----------
 2 files changed, 89 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns,usb3.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt

diff --git a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
new file mode 100644
index 000000000000..7bc0263accee
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/cdns,usb3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence USBSS-DRD controller bindings
+
+maintainers:
+  - Pawel Laszczak <pawell@cadence.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: cdns,usb3
+
+  reg:
+    items:
+      - description: OTG controller registers
+      - description: XHCI Host controller registers
+      - description: DEVICE controller registers
+
+  reg-names:
+    items:
+      - const: otg
+      - const: xhci
+      - const: dev
+
+  interrupts:
+    items:
+      - description: OTG/DRD controller interrupt
+      - description: XHCI host controller interrupt
+      - description: Device controller interrupt
+
+  interrupt-names:
+    items:
+      - const: host
+      - const: peripheral
+      - const: otg
+
+  dr_mode:
+    enum: [host, otg, peripheral]
+
+  maximum-speed:
+    enum: [super-speed, high-speed, full-speed]
+
+  phys:
+   minItems: 1
+   maxItems: 2
+
+  phy-names:
+    minItems: 1
+    maxItems: 2
+
+  cdns,on-chip-buff-size:
+    description:
+      size of memory intended as internal memory for endpoints
+      buffers expressed in KB
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        usb@6000000 {
+            compatible = "cdns,usb3";
+            reg = <0x00 0x6000000 0x00 0x10000>,
+                  <0x00 0x6010000 0x00 0x10000>,
+                  <0x00 0x6020000 0x00 0x10000>;
+            reg-names = "otg", "xhci", "dev";
+            interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "host", "peripheral", "otg";
+            maximum-speed = "super-speed";
+            dr_mode = "otg";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/usb/cdns-usb3.txt b/Documentation/devicetree/bindings/usb/cdns-usb3.txt
deleted file mode 100644
index b7dc606d37b5..000000000000
--- a/Documentation/devicetree/bindings/usb/cdns-usb3.txt
+++ /dev/null
@@ -1,45 +0,0 @@
-Binding for the Cadence USBSS-DRD controller
-
-Required properties:
- - reg: Physical base address and size of the controller's register areas.
-	 Controller has 3 different regions:
-	 - HOST registers area
-	 - DEVICE registers area
-	 - OTG/DRD registers area
- - reg-names - register memory area names:
-	"xhci" - for HOST registers space
-	"dev" - for DEVICE registers space
-	"otg" - for OTG/DRD registers space
- - compatible: Should contain: "cdns,usb3"
- - interrupts: Interrupts used by cdns3 controller:
-	"host" - interrupt used by XHCI driver.
-	"peripheral" - interrupt used by device driver
-	"otg" - interrupt used by DRD/OTG  part of driver
-
-Optional properties:
- - maximum-speed : valid arguments are "super-speed", "high-speed" and
-                   "full-speed"; refer to usb/generic.txt
- - dr_mode: Should be one of "host", "peripheral" or "otg".
- - phys: reference to the USB PHY
- - phy-names: from the *Generic PHY* bindings;
-	Supported names are:
-	- cdns3,usb2-phy
-	- cdns3,usb3-phy
-
- - cdns,on-chip-buff-size : size of memory intended as internal memory for endpoints
-	buffers expressed in KB
-
-Example:
-	usb@f3000000 {
-		compatible = "cdns,usb3";
-		interrupts = <GIC_USB_IRQ 7 IRQ_TYPE_LEVEL_HIGH>,
-				<GIC_USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>,
-				<GIC_USB_IRQ  8 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "host", "peripheral", "otg";
-		reg = <0xf3000000 0x10000>,	/* memory area for HOST registers */
-			<0xf3010000 0x10000>,	/* memory area for DEVICE registers */
-			<0xf3020000 0x10000>;	/* memory area for OTG/DRD registers */
-		reg-names = "xhci", "dev", "otg";
-		phys = <&usb2_phy>, <&usb3_phy>;
-		phy-names = "cdns3,usb2-phy", "cnds3,usb3-phy";
-	};
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

