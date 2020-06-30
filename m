Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839BAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5680620774
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dNZsMCPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbgF3J1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:27:43 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:36016 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731958AbgF3J1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:27:37 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05U9RZxE101555;
        Tue, 30 Jun 2020 04:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593509255;
        bh=pvl+6jxJ10VHtJcOvzDKdRz7owlVjuvry8eZ4PbPrnE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dNZsMCPMx0SH6kM39AN+AGCidw746KQGm9hrsBbVWIvVwAiB2/y4lR8dXKmH1ro/o
         j07RQiUpBhRhIkgTojEK55aE+ojLl1u/M+LFh4kx6H9cSlPwn2FFm7xab8+EkMnNfA
         NGcP8duGPlxc7vluKGq47ip9o/yb+AV9FjrdjEwc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05U9RZ4l123422
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jun 2020 04:27:35 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 30
 Jun 2020 04:27:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 30 Jun 2020 04:27:34 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05U9RUU5003947;
        Tue, 30 Jun 2020 04:27:33 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <robh+dt@kernel.org>, <nsekhar@ti.com>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 1/3] dt-binding: phy: convert ti,omap-usb2 to YAML
Date:   Tue, 30 Jun 2020 12:27:27 +0300
Message-ID: <20200630092729.15346-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630092729.15346-1-rogerq@ti.com>
References: <20200630092729.15346-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ti,omap-usb2 to its own YAML schema.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/phy/ti,omap-usb2.yaml | 69 +++++++++++++++++++
 .../devicetree/bindings/phy/ti-phy.txt        | 37 ----------
 2 files changed, 69 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml

diff --git a/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml b/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
new file mode 100644
index 000000000000..8df74629dc55
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/ti,omap-usb2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OMAP USB2 PHY
+
+maintainers:
+ - Kishon Vijay Abraham I <kishon@ti.com>
+ - Roger Quadros <rogerq@ti.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - ti,dra7x-usb2
+        - ti,dra7x-usb2-phy2a
+        - ti,am654-usb2
+      - enum:
+        - ti,omap-usb2
+
+  reg:
+    maxItems: 1
+
+  '#phy-cells':
+    const: 0
+
+  clocks:
+    minItems: 1
+    items:
+      - description: wakeup clock
+      - description: reference clock
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: wkupclk
+      - const: refclk
+
+  syscon-phy-power:
+    $ref: /schemas/types.yaml#definitions/phandle-array
+    description:
+      phandle/offset pair. Phandle to the system control module and
+      register offset to power on/off the PHY.
+
+  ctrl-module:
+    $ref: /schemas/types.yaml#definitions/phandle
+    description:
+      (deprecated) phandle of the control module used by PHY driver
+      to power on the PHY. Use syscon-phy-power instead.
+
+required:
+  - compatible
+  - reg
+  - '#phy-cells'
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    usb0_phy: phy@4100000 {
+      compatible = "ti,am654-usb2", "ti,omap-usb2";
+      reg = <0x0 0x4100000 0x0 0x54>;
+      syscon-phy-power = <&scm_conf 0x4000>;
+      clocks = <&k3_clks 151 0>, <&k3_clks 151 1>;
+      clock-names = "wkupclk", "refclk";
+      #phy-cells = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
index 8f93c3b694a7..60c9d0ac75e6 100644
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -27,43 +27,6 @@ omap_control_usb: omap-control-usb@4a002300 {
         reg-names = "otghs_control";
 };
 
-OMAP USB2 PHY
-
-Required properties:
- - compatible: Should be "ti,omap-usb2"
-	       Should be "ti,dra7x-usb2" for the 1st instance of USB2 PHY on
-	       DRA7x
-	       Should be "ti,dra7x-usb2-phy2" for the 2nd instance of USB2 PHY
-	       in DRA7x
-	       Should be "ti,am654-usb2" for the USB2 PHYs on AM654.
- - reg : Address and length of the register set for the device.
- - #phy-cells: determine the number of cells that should be given in the
-   phandle while referencing this phy.
- - clocks: a list of phandles and clock-specifier pairs, one for each entry in
-   clock-names.
- - clock-names: should include:
-   * "wkupclk" - wakeup clock.
-   * "refclk" - reference clock (optional).
-
-Deprecated properties:
- - ctrl-module : phandle of the control module used by PHY driver to power on
-   the PHY.
-
-Recommended properies:
-- syscon-phy-power : phandle/offset pair. Phandle to the system control
-  module and the register offset to power on/off the PHY.
-
-This is usually a subnode of ocp2scp to which it is connected.
-
-usb2phy@4a0ad080 {
-	compatible = "ti,omap-usb2";
-	reg = <0x4a0ad080 0x58>;
-	ctrl-module = <&omap_control_usb>;
-	#phy-cells = <0>;
-	clocks = <&usb_phy_cm_clk32k>, <&usb_otg_ss_refclk960m>;
-	clock-names = "wkupclk", "refclk";
-};
-
 TI PIPE3 PHY
 
 Required properties:
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

