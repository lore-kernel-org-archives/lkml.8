Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73806C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4943F206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eEYnah6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgELMfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:35:17 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42008 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELMfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:35:14 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04CCZ4U3081645;
        Tue, 12 May 2020 07:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589286904;
        bh=RIUkpt4DL+5cJti/bMPN0PAJfAChu+0yumIxupm7myA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eEYnah6pSmcmipsxK3iN5E3J+s2vw7KOw92C33dqRuvt3GILMe5FxP5l6LQP9j9Cw
         uQ/oM+HRAC7fC+/H6zo8Z+t6jwUHLO5fI6XYXd/VWwvVyayM94JUujpoz6lWkU0Oti
         /TizjAElPzXEUz/oWDuv00O58S2DkZKwuUsUwue4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04CCZ4Oo024814
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 07:35:04 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 May 2020 07:35:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 May 2020 07:35:04 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04CCZ3to006128;
        Tue, 12 May 2020 07:35:03 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     Dave Gerlach <d-gerlach@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v4 1/2] dt-bindings: soc: ti: add binding for k3 platforms chipid module
Date:   Tue, 12 May 2020 15:34:48 +0300
Message-ID: <20200512123449.16517-2-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512123449.16517-1-grygorii.strashko@ti.com>
References: <20200512123449.16517-1-grygorii.strashko@ti.com>
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
Reviewed-by: Tero Kristo <t-kristo@ti.com>
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

