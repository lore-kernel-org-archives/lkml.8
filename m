Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E18C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45821246A6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbgB0SWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:22:39 -0500
Received: from foss.arm.com ([217.140.110.172]:56708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730824AbgB0SWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:22:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5816C1FB;
        Thu, 27 Feb 2020 10:22:37 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC6113F73B;
        Thu, 27 Feb 2020 10:22:35 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Robert Richter <rric@kernel.org>, soc@kernel.org,
        Jon Loeliger <jdl@jdl.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 09/13] dt-bindings: arm: Convert Calxeda L2 cache controller to json-schema
Date:   Thu, 27 Feb 2020 18:22:06 +0000
Message-Id: <20200227182210.89512-10-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200227182210.89512-1-andre.przywara@arm.com>
References: <20200227182210.89512-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the L2-ECC controller binding to DT schema format using
json-schema.
This is indented to be just used for error reporting.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/arm/calxeda/l2ecc.txt | 15 -------
 .../bindings/arm/calxeda/l2ecc.yaml           | 43 +++++++++++++++++++
 2 files changed, 43 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/calxeda/l2ecc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/calxeda/l2ecc.yaml

diff --git a/Documentation/devicetree/bindings/arm/calxeda/l2ecc.txt b/Documentation/devicetree/bindings/arm/calxeda/l2ecc.txt
deleted file mode 100644
index 94e642a33db0..000000000000
--- a/Documentation/devicetree/bindings/arm/calxeda/l2ecc.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Calxeda Highbank L2 cache ECC
-
-Properties:
-- compatible : Should be "calxeda,hb-sregs-l2-ecc"
-- reg : Address and size for ECC error interrupt clear registers.
-- interrupts : Should be single bit error interrupt, then double bit error
-	interrupt.
-
-Example:
-
-	sregs@fff3c200 {
-		compatible = "calxeda,hb-sregs-l2-ecc";
-		reg = <0xfff3c200 0x100>;
-		interrupts = <0 71 4  0 72 4>;
-	};
diff --git a/Documentation/devicetree/bindings/arm/calxeda/l2ecc.yaml b/Documentation/devicetree/bindings/arm/calxeda/l2ecc.yaml
new file mode 100644
index 000000000000..5481dd7216ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/calxeda/l2ecc.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/calxeda/l2ecc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Calxeda Highbank L2 cache ECC
+
+description: |
+  Binding for the Calxeda Highbank L2 cache controller ECC device.
+  This does not cover the actual L2 cache controller control registers,
+  but just the error reporting functionality.
+
+maintainers:
+  - Andre Przywara <andre.przywara@arm.com>
+
+properties:
+  compatible:
+    const: "calxeda,hb-sregs-l2-ecc"
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: |
+      Should be single bit error interrupt, then double bit error interrupt.
+    minItems: 2
+    maxItems: 2
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
+    sregs@fff3c200 {
+        compatible = "calxeda,hb-sregs-l2-ecc";
+        reg = <0xfff3c200 0x100>;
+        interrupts = <0 71 4>, <0 72 4>;
+    };
-- 
2.17.1

