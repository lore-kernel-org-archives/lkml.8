Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B68EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A56D21D81
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BxIAXn9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgF2Sju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:39:50 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54506 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgF2Sjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:39:41 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05TCr25O015325;
        Mon, 29 Jun 2020 07:53:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593435182;
        bh=P0UG0v9WZr2hySBskVuVNfPW+YNPbGGZZJtra3qz4wQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BxIAXn9pA9SiL6e4p4eWsaoij0Hi+deiYTP2BN+gMGn9VYWWL8h+a8QtUv12ocBWT
         ia1rvJwuMw5xlXW+2Qcp23rIjoi6WqaI1lKFDDQTbRbkhwReU4auk/olLTRmX7wp79
         589Web2cMuwMWtPDEhaxXItGi5nSBXxPSNyiVRr0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05TCr2NU111046
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Jun 2020 07:53:02 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 29
 Jun 2020 07:53:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 29 Jun 2020 07:53:01 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05TCqugw015456;
        Mon, 29 Jun 2020 07:52:59 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>
CC:     <robh@kernel.org>, <kishon@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 1/6] dt-bindings: mfd: ti,j721e-system-controller.yaml: Add J721e system controller
Date:   Mon, 29 Jun 2020 15:52:49 +0300
Message-ID: <20200629125254.28754-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200629125254.28754-1-rogerq@ti.com>
References: <20200629125254.28754-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding schema for J721e system controller.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../mfd/ti,j721e-system-controller.yaml       | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
new file mode 100644
index 000000000000..03d0a232c75e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,j721e-system-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI J721e System Controller Registers R/W Device Tree Bindings
+
+description: |
+  This represents the Control Module registers (CTRL_MMR0) on the SoC.
+  System controller node represents a register region containing a set
+  of miscellaneous registers. The registers are not cohesive enough to
+  represent as any specific type of device. The typical use-case is
+  for some other node's driver, or platform-specific code, to acquire
+  a reference to the syscon node (e.g. by phandle, node path, or
+  search using a specific compatible value), interrogate the node (or
+  associated OS driver) to determine the location of the registers,
+  and access the registers directly.
+
+maintainers:
+  - Kishon Vijay Abraham I <kishon@ti.com>
+  - Roger Quadros <rogerq@ti.com
+
+properties:
+  compatible:
+    anyOf:
+      - items:
+        - enum:
+           - ti,j721e-system-controller
+        - const: syscon
+        - const: simple-mfd
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+# Optional children
+
+  "^serdes-ln-ctrl@[0-9a-f]+$":
+    type: object
+    description: |
+      This is the SERDES lane control mux. It should follow the bindings
+      specified in
+      Documentation/devicetree/bindings/mux/reg-mux.txt
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    scm_conf: scm-conf@100000 {
+        compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
+        reg = <0x00100000 0x1c000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        serdes_ln_ctrl: serdes-ln-ctrl@4080 {
+            compatible = "mmio-mux";
+            reg = <0x00004080 0x50>;
+        };
+    };
+...
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

