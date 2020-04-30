Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3473BC47254
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C82A2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgD3VL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:11:28 -0400
Received: from foss.arm.com ([217.140.110.172]:33628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbgD3VLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:11:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EDB2106F;
        Thu, 30 Apr 2020 14:11:14 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75CE93F68F;
        Thu, 30 Apr 2020 14:11:13 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [PATCH v3 7/8] dt-bindings: ipmi: Convert IPMI-SMIC bindings to json-schema
Date:   Thu, 30 Apr 2020 22:10:53 +0100
Message-Id: <20200430211054.30466-8-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430211054.30466-1-andre.przywara@arm.com>
References: <20200430211054.30466-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the generic IPMI controller bindings to DT schema format
using json-schema.

The device_type property is deprecated for most node per the DT spec,
but at least the Linux driver matches on it, so I keep it in.

The Linux driver parses for some additional and optional properties,
but there are no in-tree users. Let's allow extra properties to cover
any other users.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/ipmi/ipmi-smic.txt    | 25 --------
 .../devicetree/bindings/ipmi/ipmi-smic.yaml   | 63 +++++++++++++++++++
 2 files changed, 63 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ipmi/ipmi-smic.txt
 create mode 100644 Documentation/devicetree/bindings/ipmi/ipmi-smic.yaml

diff --git a/Documentation/devicetree/bindings/ipmi/ipmi-smic.txt b/Documentation/devicetree/bindings/ipmi/ipmi-smic.txt
deleted file mode 100644
index d5f1a877ed3e..000000000000
--- a/Documentation/devicetree/bindings/ipmi/ipmi-smic.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-IPMI device
-
-Required properties:
-- compatible: should be one of ipmi-kcs, ipmi-smic, or ipmi-bt
-- device_type: should be ipmi
-- reg: Address and length of the register set for the device
-
-Optional properties:
-- interrupts: The interrupt for the device.  Without this the interface
-	is polled.
-- reg-size - The size of the register.  Defaults to 1
-- reg-spacing - The number of bytes between register starts.  Defaults to 1
-- reg-shift - The amount to shift the registers to the right to get the data
-	into bit zero.
-
-Example:
-
-smic@fff3a000 {
-	compatible = "ipmi-smic";
-	device_type = "ipmi";
-	reg = <0xfff3a000 0x1000>;
-	interrupts = <0 24 4>;
-	reg-size = <4>;
-	reg-spacing = <4>;
-};
diff --git a/Documentation/devicetree/bindings/ipmi/ipmi-smic.yaml b/Documentation/devicetree/bindings/ipmi/ipmi-smic.yaml
new file mode 100644
index 000000000000..f0bb157e9417
--- /dev/null
+++ b/Documentation/devicetree/bindings/ipmi/ipmi-smic.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ipmi/ipmi-smic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IPMI device bindings
+
+description: IPMI device bindings
+
+maintainers:
+  - Corey Minyard <cminyard@mvista.com>
+
+properties:
+  compatible:
+    enum:
+      - ipmi-kcs
+      - ipmi-smic
+      - ipmi-bt
+
+  device_type:
+    items:
+      - const: "ipmi"
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: Interface is polled if this property is omitted.
+    maxItems: 1
+
+  reg-size:
+    description: The access width of the register in bytes. Defaults to 1.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [1, 2, 4, 8]
+
+  reg-spacing:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The number of bytes between register starts. Defaults to 1.
+
+  reg-shift:
+    description: |
+      The amount of bits to shift the register content to the right to get
+      the data into bit zero.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - maximum: 56
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    smic@fff3a000 {
+        compatible = "ipmi-smic";
+        device_type = "ipmi";
+        reg = <0xfff3a000 0x1000>;
+        interrupts = <0 24 4>;
+        reg-size = <4>;
+        reg-spacing = <4>;
+    };
-- 
2.17.1

