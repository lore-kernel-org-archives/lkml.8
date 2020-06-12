Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C0AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7777206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JNzY4WDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgFLWtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 18:49:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57696 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgFLWtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 18:49:36 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05CMnUbT121066;
        Fri, 12 Jun 2020 17:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592002170;
        bh=bNsry0vaH4LJP2i3TLuNDpE56+9ye4tE5chXV1/nxh0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JNzY4WDoBVWJQ7w6WsbuN70cg0DpIsHxWcnV9K7+pPicXuCzI6q16PEH3kDgqRt89
         oatV8csvpcgUV5N2B3gT2Gtf0pf4/1N7u35AQOTewe9sJToivT0ZJJ6hqo8DA4Dbex
         YnvhiilXphRrOjjSG05BLshAIix96NxgSGwT3xKo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05CMnUiW046039;
        Fri, 12 Jun 2020 17:49:30 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 12
 Jun 2020 17:49:29 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 12 Jun 2020 17:49:29 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05CMnTl2112276;
        Fri, 12 Jun 2020 17:49:29 -0500
Received: from localhost ([10.250.48.148])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 05CMnTMi062177;
        Fri, 12 Jun 2020 17:49:29 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v3 3/6] dt-bindings: remoteproc: Add common TI SCI rproc bindings
Date:   Fri, 12 Jun 2020 17:49:11 -0500
Message-ID: <20200612224914.7634-4-s-anna@ti.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200612224914.7634-1-s-anna@ti.com>
References: <20200612224914.7634-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a bindings document that lists the common TI SCI properties
used by the K3 R5F and DSP remoteproc devices.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
v3: New Patch refactoring out the common ti-sci-proc properties

 .../bindings/remoteproc/ti,k3-sci-proc.yaml   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml
new file mode 100644
index 000000000000..883b6e9b5282
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/ti,k3-sci-proc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common TI K3 remote processor device bindings
+
+maintainers:
+  - Suman Anna <s-anna@ti.com>
+
+description: |
+  The TI K3 family of SoCs usually have one or more remote processor sub-systems
+  like the dual-core R5F sub-system or a C66x or C71x DSP processor subsystem.
+  The device management of these remote processors is managed by a dedicated
+  System Processor, and the communication with that processor is managed through
+  the TI-SCI protocol.
+
+  Each remote processor device node should define a common set of properties
+  that allows the System Processor firmware to perform the device management
+  such as powering the IPs, asserting/deasserting the resets for each of these
+  processors.
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
+      Should contain the TI-SCI device id corresponding to the remote processor
+      core. Please refer to the corresponding System Controller documentation
+      for valid values.
+
+  ti,sci-proc-ids:
+    description: Should contain a single tuple of <proc_id host_id>.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - maxItems: 1
+        items:
+          items:
+            - description: TI-SCI processor id for the remote processor device
+            - description: TI-SCI host id to which processor control
+                           ownership should be transferred to
+
+required:
+  - ti,sci
+  - ti,sci-dev-id
+  - ti,sci-proc-ids
-- 
2.26.0

