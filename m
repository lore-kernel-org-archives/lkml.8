Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EF8C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 748BD20768
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tv2tlwxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgGQXsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:48:17 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50520 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbgGQXsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:48:14 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06HNm9pl014576;
        Fri, 17 Jul 2020 18:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595029689;
        bh=9KwCpesWJC8b9T9niJbSKws+xrNpUnloOyOKSNepTfw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tv2tlwxxLc8YjtSW0iNq2bvigjGgLiF3/NAQD+tBNTpuzAHAR4J4/Ax7uWF+ehMLL
         wCE+3aTdRuKpbq+VANXwtYgdn+YUNh45Y5KQ7Q9GWIQB7zIIALUOZhtL8bFgGXGb0E
         qOMjatzFbK8p2zSJY8JygGatOB0yKhohpT0TiBYQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HNm9D0029922;
        Fri, 17 Jul 2020 18:48:09 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 18:48:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 18:48:08 -0500
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HNm8aX037476;
        Fri, 17 Jul 2020 18:48:08 -0500
Received: from localhost ([10.250.34.57])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 06HNm89T108280;
        Fri, 17 Jul 2020 18:48:08 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v4 3/6] dt-bindings: remoteproc: Add common TI SCI rproc bindings
Date:   Fri, 17 Jul 2020 18:47:57 -0500
Message-ID: <20200717234800.9423-4-s-anna@ti.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200717234800.9423-1-s-anna@ti.com>
References: <20200717234800.9423-1-s-anna@ti.com>
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
v4: Addressed both of Rob's review comments on ti,sci-proc-ids property
v3: https://patchwork.kernel.org/patch/11602317/

 .../bindings/remoteproc/ti,k3-sci-proc.yaml   | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml
new file mode 100644
index 000000000000..0dca2ffdbc48
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml
@@ -0,0 +1,48 @@
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
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: TI-SCI processor id for the remote processor device
+      - description: TI-SCI host id to which processor control ownership
+                     should be transferred to
+
+required:
+  - ti,sci
+  - ti,sci-dev-id
+  - ti,sci-proc-ids
-- 
2.26.0

