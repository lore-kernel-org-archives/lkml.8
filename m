Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228DCC55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D8C20784
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i9IKOzUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgDWSGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:06:02 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53570 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729901AbgDWSGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:06:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03NI5nZU001508;
        Thu, 23 Apr 2020 13:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587665149;
        bh=Vh2zPhW1Qrp8akdwIMS1wgw3zeKMLQGJLfuKxWRmKm4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=i9IKOzUwB8wMbUpM3AnLiHrm89HIBGFiAg4BHQ/h5H36wKJMsZeJ1ziVVzLze1QRZ
         KoZ7lOOPX+hglvTJeIDQKUQviv0E0URE1WKJu7v13uG5+VhFCEboag25xAEcsh0pn+
         lZamNRZU+K7kEmVl703UZgPga2afqIgpOsMN5MFs=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03NI5nYf107003
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Apr 2020 13:05:49 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 23
 Apr 2020 13:05:49 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 23 Apr 2020 13:05:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03NI5lCM009015;
        Thu, 23 Apr 2020 13:05:48 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Dave Gerlach <d-gerlach@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 1/5] dt-bindings: soc: ti: add binding for k3 platforms chipid module
Date:   Thu, 23 Apr 2020 21:05:41 +0300
Message-ID: <20200423180545.13707-2-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200423180545.13707-1-grygorii.strashko@ti.com>
References: <20200423180545.13707-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding for Texas Instruments K3 Multicore SoC platforms chipid
module which is represented by CTRLMMR_xxx_JTAGID register and contains
information about SoC id and revision.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 .../bindings/soc/ti/k3-socinfo.yaml           | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml

diff --git a/Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml b/Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml
new file mode 100644
index 000000000000..a1a8423b2e2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/ti/k3-socinfo.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments K3 Multicore SoC platforms chipid module
+
+maintainers:
+  - Tero Kristo <t-kristo@ti.com>
+  - Nishanth Menon <nm@ti.com>
+
+description: |
+  Texas Instruments (ARM64) K3 Multicore SoC platforms chipid module is
+  represented by CTRLMMR_xxx_JTAGID register which contains information about
+  SoC id and revision.
+
+properties:
+  $nodename:
+    pattern: "^chipid@[0-9a-f]+$"
+
+  compatible:
+    items:
+      - const: ti,am654-chipid
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    chipid@43000014 {
+        compatible = "ti,am654-chipid";
+        reg = <0x43000014 0x4>;
+    };
-- 
2.17.1

