Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8878C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4C62469C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbgB0SYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:24:44 -0500
Received: from foss.arm.com ([217.140.110.172]:56734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730861AbgB0SWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:22:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4ABD91FB;
        Thu, 27 Feb 2020 10:22:41 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B5D83F73B;
        Thu, 27 Feb 2020 10:22:39 -0800 (PST)
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [PATCH v2 11/13] dt-bindings: ipmi: Convert IPMI-SMIC bindings to json-schema
Date:   Thu, 27 Feb 2020 18:22:08 +0000
Message-Id: <20200227182210.89512-12-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200227182210.89512-1-andre.przywara@arm.com>
References: <20200227182210.89512-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the generic IPMI controller bindings to DT schema format
using json-schema.

I removed the formerly mandatory device-type property, since this
is deprecated in the DT spec, except for the legacy CPU and memory
nodes.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Cc: Corey Minyard <minyard@acm.org>
Cc: openipmi-developer@lists.sourceforge.net
---
 .../devicetree/bindings/ipmi/ipmi-smic.txt    | 25 ---------
 .../devicetree/bindings/ipmi/ipmi-smic.yaml   | 56 +++++++++++++++++++
 2 files changed, 56 insertions(+), 25 deletions(-)
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
index 000000000000..c859e0e959b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/ipmi/ipmi-smic.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
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
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The amount of bits to shift the register content to the right to get
+      the data into bit zero.
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    smic@fff3a000 {
+        compatible = "ipmi-smic";
+        reg = <0xfff3a000 0x1000>;
+        interrupts = <0 24 4>;
+        reg-size = <4>;
+        reg-spacing = <4>;
+    };
-- 
2.17.1

