Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48880C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207BD20720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SFz2YKTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbgGUWww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 18:52:52 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42666 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGUWwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 18:52:51 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06LMqoin129242;
        Tue, 21 Jul 2020 17:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595371970;
        bh=W8/NLAP7AQ8ZoUh2X7uGYM9F/8jWUbu2kIHr9OgpfJQ=;
        h=From:To:CC:Subject:Date;
        b=SFz2YKTh5sVwtHGaXHR2Hi0sKBsFO7FKQ7i3CrZGwqRCMrUbrlpCZNA+FFnlnZ8CS
         Wa9vtL10+eQY0tL10yK27I58uvDFGmEkA5u5xlsGAYz83z4f7+QYN2EGg4VxCf3sAI
         k6VsJAFbeR7zryX1RRaIPPnPeJcmYC+3Be2o18oU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06LMqo2f112472
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jul 2020 17:52:50 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 21
 Jul 2020 17:52:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 21 Jul 2020 17:52:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LMqm3l057785;
        Tue, 21 Jul 2020 17:52:48 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] dt-bindings: phy: ti: phy-gmii-sel: convert bindings to json-schema
Date:   Wed, 22 Jul 2020 01:52:47 +0300
Message-ID: <20200721225247.31034-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the CPSW Port's Interface Mode Selection PHY bindings documentation
to json-schema.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 .../bindings/phy/ti,phy-gmii-sel.yaml         | 104 ++++++++++++++++++
 .../bindings/phy/ti-phy-gmii-sel.txt          |  69 ------------
 2 files changed, 104 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
new file mode 100644
index 000000000000..bcec422d7734
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/ti,phy-gmii-sel.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: CPSW Port's Interface Mode Selection PHY Tree Bindings
+
+maintainers:
+  - Kishon Vijay Abraham I <kishon@ti.com>
+
+description: |
+  TI am335x/am437x/dra7(am5)/dm814x CPSW3G Ethernet Subsystem supports
+  two 10/100/1000 Ethernet ports with selectable G/MII, RMII, and RGMII interfaces.
+  The interface mode is selected by configuring the MII mode selection register(s)
+  (GMII_SEL) in the System Control Module chapter (SCM). GMII_SEL register(s) and
+  bit fields placement in SCM are different between SoCs while fields meaning
+  is the same.
+                                               +--------------+
+        +-------------------------------+      |SCM           |
+        |                     CPSW      |      |  +---------+ |
+        |        +--------------------------------+gmii_sel | |
+        |        |                      |      |  +---------+ |
+        |   +----v---+     +--------+   |      +--------------+
+        |   |Port 1..<--+-->GMII/MII<------->
+        |   |        |  |  |        |   |
+        |   +--------+  |  +--------+   |
+        |               |               |
+        |               |  +--------+   |
+        |               |  | RMII   <------->
+        |               +-->        |   |
+        |               |  +--------+   |
+        |               |               |
+        |               |  +--------+   |
+        |               |  | RGMII  <------->
+        |               +-->        |   |
+        |                  +--------+   |
+        +-------------------------------+
+
+  CPSW Port's Interface Mode Selection PHY describes MII interface mode between
+  CPSW Port and Ethernet PHY which depends on Eth PHY and board configuration.
+  |
+  CPSW Port's Interface Mode Selection PHY device should defined as child device
+  of SCM node (scm_conf) and can be attached to each CPSW port node using standard
+  PHY bindings.
+
+properties:
+  compatible:
+    enum:
+      - ti,am3352-phy-gmii-sel
+      - ti,dra7xx-phy-gmii-sel
+      - ti,am43xx-phy-gmii-sel
+      - ti,dm814-phy-gmii-sel
+      - ti,am654-phy-gmii-sel
+
+  reg:
+    description: Address and length of the register set for the device
+
+  '#phy-cells': true
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,dra7xx-phy-gmii-sel
+              - ti,dm814-phy-gmii-sel
+              - ti,am654-phy-gmii-sel
+    then:
+      properties:
+        '#phy-cells':
+          const: 1
+          description: CPSW port number (starting from 1)
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,am3352-phy-gmii-sel
+              - ti,am43xx-phy-gmii-sel
+    then:
+      properties:
+        '#phy-cells':
+          const: 2
+          description: |
+            - CPSW port number (starting from 1)
+            - RMII refclk mode
+
+required:
+  - compatible
+  - reg
+  - '#phy-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    phy_gmii_sel: phy-gmii-sel@650 {
+        compatible = "ti,am3352-phy-gmii-sel";
+        reg = <0x650 0x4>;
+        #phy-cells = <2>;
+    };
diff --git a/Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt b/Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt
deleted file mode 100644
index 83b78c1c0644..000000000000
--- a/Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt
+++ /dev/null
@@ -1,69 +0,0 @@
-CPSW Port's Interface Mode Selection PHY Tree Bindings
------------------------------------------------
-
-TI am335x/am437x/dra7(am5)/dm814x CPSW3G Ethernet Subsystem supports
-two 10/100/1000 Ethernet ports with selectable G/MII, RMII, and RGMII interfaces.
-The interface mode is selected by configuring the MII mode selection register(s)
-(GMII_SEL) in the System Control Module chapter (SCM). GMII_SEL register(s) and
-bit fields placement in SCM are different between SoCs while fields meaning
-is the same.
-                                               +--------------+
-        +-------------------------------+      |SCM           |
-        |                     CPSW      |      |  +---------+ |
-        |        +--------------------------------+gmii_sel | |
-        |        |                      |      |  +---------+ |
-        |   +----v---+     +--------+   |      +--------------+
-        |   |Port 1..<--+-->GMII/MII<------->
-        |   |        |  |  |        |   |
-        |   +--------+  |  +--------+   |
-        |               |               |
-        |               |  +--------+   |
-        |               |  | RMII   <------->
-        |               +-->        |   |
-        |               |  +--------+   |
-        |               |               |
-        |               |  +--------+   |
-        |               |  | RGMII  <------->
-        |               +-->        |   |
-        |                  +--------+   |
-        +-------------------------------+
-
-CPSW Port's Interface Mode Selection PHY describes MII interface mode between
-CPSW Port and Ethernet PHY which depends on Eth PHY and board configuration.
-
-CPSW Port's Interface Mode Selection PHY device should defined as child device
-of SCM node (scm_conf) and can be attached to each CPSW port node using standard
-PHY bindings (See phy/phy-bindings.txt).
-
-Required properties:
-- compatible		: Should be "ti,am3352-phy-gmii-sel" for am335x platform
-			  "ti,dra7xx-phy-gmii-sel" for dra7xx/am57xx platform
-			  "ti,am43xx-phy-gmii-sel" for am43xx platform
-			  "ti,dm814-phy-gmii-sel" for dm814x platform
-			  "ti,am654-phy-gmii-sel" for AM654x/J721E platform
-- reg			: Address and length of the register set for the device
-- #phy-cells		: must be 2.
-			  cell 1 - CPSW port number (starting from 1)
-			  cell 2 - RMII refclk mode
-
-Examples:
-	phy_gmii_sel: phy-gmii-sel {
-		compatible = "ti,am3352-phy-gmii-sel";
-		reg = <0x650 0x4>;
-		#phy-cells = <2>;
-	};
-
-	mac: ethernet@4a100000 {
-		compatible = "ti,am335x-cpsw","ti,cpsw";
-		...
-
-		cpsw_emac0: slave@4a100200 {
-			...
-			phys = <&phy_gmii_sel 1 1>;
-		};
-
-		cpsw_emac1: slave@4a100300 {
-			...
-			phys = <&phy_gmii_sel 2 1>;
-		};
-	};
-- 
2.17.1

