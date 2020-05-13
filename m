Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EE5C2D0FD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49BD6206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nKZEzBBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733159AbgEMNHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:07:19 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38514 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgEMNHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:07:18 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04DD7GTd114155;
        Wed, 13 May 2020 08:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589375236;
        bh=f4nG1Z0UcuxYUN06zcx+hh4NnFLdEFqFG1jkKWOQn60=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nKZEzBBgxwTvSaPxjwoPYlYmcvcMqTEx8zF7x/apNyhpFMbGU13FCJRfDVuaDRKRT
         fkXpmWM0GfsST6JAT2MvPMQrtsNt2eXXhfWNZxwBNkGwiwQABEqvaCkgnVHRAgRYxQ
         jR58l/ZHz/fxHKFP8fJKa6vRsYlJQ7GaaOG41zsE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04DD7GDt123458
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 08:07:16 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 May 2020 08:07:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 May 2020 08:07:16 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04DD7B2R074071;
        Wed, 13 May 2020 08:07:14 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>
CC:     <robh+dt@kernel.org>, <vigneshr@ti.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/3] dt-bindings: usb: convert keystone-usb.txt to YAML
Date:   Wed, 13 May 2020 16:07:07 +0300
Message-ID: <20200513130709.10239-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513130709.10239-1-rogerq@ti.com>
References: <20200513130709.10239-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert keystone-usb documentation to YAML format.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../devicetree/bindings/usb/keystone-usb.txt  | 56 ----------------
 .../bindings/usb/ti,keystone-dwc3.yaml        | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/keystone-usb.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml

diff --git a/Documentation/devicetree/bindings/usb/keystone-usb.txt b/Documentation/devicetree/bindings/usb/keystone-usb.txt
deleted file mode 100644
index 77df82e36138..000000000000
--- a/Documentation/devicetree/bindings/usb/keystone-usb.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-TI Keystone Soc USB Controller
-
-DWC3 GLUE
-
-Required properties:
- - compatible: should be
-		"ti,keystone-dwc3" for Keystone 2 SoCs
-		"ti,am654-dwc3" for AM654 SoC
- - #address-cells, #size-cells : should be '1' if the device has sub-nodes
-   with 'reg' property.
- - reg : Address and length of the register set for the USB subsystem on
-   the SOC.
- - interrupts : The irq number of this device that is used to interrupt the
-   MPU.
- - ranges: allows valid 1:1 translation between child's address space and
-   parent's address space.
-
-SoC-specific Required Properties:
-The following are mandatory properties for Keystone 2 66AK2HK, 66AK2L and 66AK2E
-SoCs only:
-
-- clocks:		Clock ID for USB functional clock.
-- clock-names:		Must be "usb".
-
-
-The following are mandatory properties for 66AK2G and AM654:
-
-- power-domains:	Should contain a phandle to a PM domain provider node
-			and an args specifier containing the USB device id
-			value. This property is as per the binding,
-			Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
-
-Sub-nodes:
-The dwc3 core should be added as subnode to Keystone DWC3 glue.
-- dwc3 :
-   The binding details of dwc3 can be found in:
-   Documentation/devicetree/bindings/usb/dwc3.txt
-
-Example:
-	usb: usb@2680000 {
-		compatible = "ti,keystone-dwc3";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0x2680000 0x10000>;
-		clocks = <&clkusb>;
-		clock-names = "usb";
-		interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
-		ranges;
-
-		dwc3@2690000 {
-			compatible = "synopsys,dwc3";
-			reg = <0x2690000 0x70000>;
-			interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
-			usb-phy = <&usb_phy>, <&usb_phy>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml b/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
new file mode 100644
index 000000000000..14d2fe329b93
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ti,keystone-dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI Keystone Soc USB Controller
+
+maintainers:
+  - Roger Quadros <rogerq@ti.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: "ti,keystone-dwc3"
+      - const: "ti,am654-dwc3"
+
+  reg:
+    maxItems: 1
+    description: Address and length of the register set for the USB subsystem on
+      the SOC.
+
+  interrupts:
+    maxItems: 1
+    description: The irq number of this device that is used to interrupt the MPU.
+
+
+  clocks:
+    description: Clock ID for USB functional clock.
+
+  power-domains:
+    description: Should contain a phandle to a PM domain provider node
+      and an args specifier containing the USB device id
+      value. This property is as per the binding,
+      Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
+
+  dwc3:
+    description: This is the node representing the DWC3 controller instance
+      Documentation/devicetree/bindings/usb/dwc3.txt
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    usb: usb@2680000 {
+      compatible = "ti,keystone-dwc3";
+      #address-cells = <1>;
+      #size-cells = <1>;
+      reg = <0x2680000 0x10000>;
+      clocks = <&clkusb>;
+      clock-names = "usb";
+      interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
+      ranges;
+
+      dwc3@2690000 {
+        compatible = "synopsys,dwc3";
+        reg = <0x2690000 0x70000>;
+        interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
+        usb-phy = <&usb_phy>, <&usb_phy>;
+      };
+    };
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

