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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB6DC433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B0C62073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X3luzB2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbgGUWge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 18:36:34 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40918 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgGUWgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 18:36:32 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06LMaMnb125597;
        Tue, 21 Jul 2020 17:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595370982;
        bh=OEsAttWzprHsc6R94CAL0mEmhDef5DxQVhrGxVmSMeI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=X3luzB2u8JYkDIX8cQh6bE+MHHUVXCX7PhB+hWvBjqcAO2siqHyN9/yyAn+AZ8k4N
         eksvAdfl4XRYkyF+9yyxqcOZi775LVuGVvOn23SapDfzpcbIMsEr+HFwFAyCq34FlA
         j8ybie4ZC7ErWOO4RJnEDLdy+S65XF39SX8Gd/eM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LMaMro023681;
        Tue, 21 Jul 2020 17:36:22 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 21
 Jul 2020 17:36:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 21 Jul 2020 17:36:22 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LMaM4i028179;
        Tue, 21 Jul 2020 17:36:22 -0500
Received: from localhost ([10.250.34.248])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 06LMaMn0080798;
        Tue, 21 Jul 2020 17:36:22 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v5 1/6] dt-bindings: arm: keystone: Add common TI SCI bindings
Date:   Tue, 21 Jul 2020 17:36:12 -0500
Message-ID: <20200721223617.20312-2-s-anna@ti.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200721223617.20312-1-s-anna@ti.com>
References: <20200721223617.20312-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a bindings document that defines the common TI SCI properties
used by various K3 device management nodes such as clock controllers,
interrupt controllers, reset controllers or remoteproc devices.

The required properties for each device management node shall be
specified in the respective binding document.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
v5:
 - New patch refactored out for usage by remoteproc and other TI SCI
   interrupt controller bindings
 - Patch based on remoteproc ti,k3-sci-proc.yaml binding (v4 patch 3)
   with revised overall description and ti,sci-dev-id and no required
   properties
v4: https://patchwork.kernel.org/patch/11671455/
 - Addressed both of Rob's review comments on ti,sci-proc-ids property
v3: https://patchwork.kernel.org/patch/11602317/

 .../arm/keystone/ti,k3-sci-common.yaml        | 44 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml
new file mode 100644
index 000000000000..7597bc93a55f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/keystone/ti,k3-sci-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common K3 TI-SCI bindings
+
+maintainers:
+  - Nishanth Menon <nm@ti.com>
+
+description: |
+  The TI K3 family of SoCs usually have a central System Controller Processor
+  that is responsible for managing various SoC-level resources like clocks,
+  resets, interrupts etc. The communication with that processor is performed
+  through the TI-SCI protocol.
+
+  Each specific device management node like a clock controller node, a reset
+  controller node or an interrupt-controller node should define a common set
+  of properties that enables them to implement the corresponding functionality
+  over the TI-SCI protocol. The following are some of the common properties
+  needed by such individual nodes. The required properties for each device
+  management node is defined in the respective binding.
+
+properties:
+  ti,sci:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Should be a phandle to the TI-SCI System Controller node
+
+  ti,sci-dev-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Should contain the TI-SCI device id corresponding to the device. Please
+      refer to the corresponding System Controller documentation for valid
+      values for the desired device.
+
+  ti,sci-proc-ids:
+    description: Should contain a single tuple of <proc_id host_id>.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: TI-SCI processor id for the remote processor device
+      - description: TI-SCI host id to which processor control ownership
+                     should be transferred to
diff --git a/MAINTAINERS b/MAINTAINERS
index d53db30d1365..61ab0b7ed54d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16902,6 +16902,7 @@ M:	Tero Kristo <t-kristo@ti.com>
 M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml
 F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
 F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
-- 
2.26.0

