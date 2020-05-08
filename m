Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED6DC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA85520870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MT+praZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgEHI3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:29:51 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49590 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgEHI3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:29:49 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0488Tl2n023283;
        Fri, 8 May 2020 03:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588926587;
        bh=G8AEr6yO/8wQ/72kKdriOSTyiW/u5Zm0KpMdh2r29ME=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MT+praZIYsz7gB41jWDMpUry0zi8239P4bj9hzsy5INL0bVCQCkcOhrfWWJuEsdwf
         mD/o3+YsqhkzrTk79AcNsjBuv4unqsRLkeJzFXYfgM1ITOfmjT70WKDIXOhsBpzGIw
         22a3FeWOeN2ULU0sx/rnFuTVBXOSe36HSxtK9Q7Q=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0488Tlnv118636
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 May 2020 03:29:47 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 May
 2020 03:29:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 May 2020 03:29:47 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0488TdnB073953;
        Fri, 8 May 2020 03:29:45 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>
CC:     <robh@kernel.org>, <kishon@ti.com>, <nm@ti.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 2/7] dt-bindings: mdf: ti,j721e-syscon.yaml: Add J721e system controller
Date:   Fri, 8 May 2020 11:29:32 +0300
Message-ID: <20200508082937.14171-3-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508082937.14171-1-rogerq@ti.com>
References: <20200508082937.14171-1-rogerq@ti.com>
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
 .../bindings/mfd/ti,j721e-syscon.yaml         | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,j721e-syscon.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-syscon.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-syscon.yaml
new file mode 100644
index 000000000000..e832fb43f884
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,j721e-syscon.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,j721e-syscon.yaml#
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
+allOf:
+  - $ref: "syscon.yaml#"
+
+properties:
+  compatible:
+    anyOf:
+      - items:
+        - enum:
+          - ti,j721e-system-controller
+
+        - const: syscon
+
+      - contains:
+          const: syscon
+        additionalItems: true
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

