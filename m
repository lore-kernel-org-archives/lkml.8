Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F06CC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 374D52070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgD3VLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:11:17 -0400
Received: from foss.arm.com ([217.140.110.172]:33628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbgD3VLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:11:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 436821045;
        Thu, 30 Apr 2020 14:11:13 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E3CB3F68F;
        Thu, 30 Apr 2020 14:11:12 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v3 6/8] dt-bindings: memory-controllers: Convert Calxeda DDR to json-schema
Date:   Thu, 30 Apr 2020 22:10:52 +0100
Message-Id: <20200430211054.30466-7-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430211054.30466-1-andre.przywara@arm.com>
References: <20200430211054.30466-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Calxeda DDR memory controller binding to DT schema format
using json-schema.
Although this technically covers the whole DRAM controller, the
intention to use it only for error reporting and mapping fault addresses
to DRAM chips.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../memory-controllers/calxeda-ddr-ctrlr.txt  | 16 -------
 .../memory-controllers/calxeda-ddr-ctrlr.yaml | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.txt b/Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.txt
deleted file mode 100644
index 049675944b78..000000000000
--- a/Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Calxeda DDR memory controller
-
-Properties:
-- compatible : Should be:
-  - "calxeda,hb-ddr-ctrl" for ECX-1000
-  - "calxeda,ecx-2000-ddr-ctrl" for ECX-2000
-- reg : Address and size for DDR controller registers.
-- interrupts : Interrupt for DDR controller.
-
-Example:
-
-	memory-controller@fff00000 {
-		compatible = "calxeda,hb-ddr-ctrl";
-		reg = <0xfff00000 0x1000>;
-		interrupts = <0 91 4>;
-	};
diff --git a/Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.yaml b/Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.yaml
new file mode 100644
index 000000000000..96d563fd61f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/calxeda-ddr-ctrlr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Calxeda DDR memory controller binding
+
+description: |
+  The Calxeda DDR memory controller is initialised and programmed by the
+  firmware, but an OS might want to read its registers for error reporting
+  purposes and to learn about the DRAM topology.
+
+maintainers:
+  - Andre Przywara <andre.przywara@arm.com>
+
+properties:
+  compatible:
+    enum:
+      - calxeda,hb-ddr-ctrl
+      - calxeda,ecx-2000-ddr-ctrl
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    memory-controller@fff00000 {
+        compatible = "calxeda,hb-ddr-ctrl";
+        reg = <0xfff00000 0x1000>;
+        interrupts = <0 91 4>;
+    };
-- 
2.17.1

