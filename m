Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4BDC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060FE246A6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbgB0SYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:24:25 -0500
Received: from foss.arm.com ([217.140.110.172]:56752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730894AbgB0SWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:22:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 290B530E;
        Thu, 27 Feb 2020 10:22:43 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EA273F73B;
        Thu, 27 Feb 2020 10:22:41 -0800 (PST)
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
Subject: [PATCH v2 12/13] dt-bindings: arm: Add Calxeda system registers json-schema binding
Date:   Thu, 27 Feb 2020 18:22:09 +0000
Message-Id: <20200227182210.89512-13-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200227182210.89512-1-andre.przywara@arm.com>
References: <20200227182210.89512-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Calxeda system registers are a collection of MMIO register
controlling several more general aspects of the SoC.
Beside for some power management tasks this node is also somewhat
abused as the container for the clock nodes.

Add a binding in DT schema format using json-schema.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../bindings/arm/calxeda/hb-sregs.yaml        | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/calxeda/hb-sregs.yaml

diff --git a/Documentation/devicetree/bindings/arm/calxeda/hb-sregs.yaml b/Documentation/devicetree/bindings/arm/calxeda/hb-sregs.yaml
new file mode 100644
index 000000000000..4753e8dc5873
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/calxeda/hb-sregs.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/calxeda/hb-sregs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Calxeda Highbank system registers
+
+description: |
+  The Calxeda Highbank system has a block of MMIO registers controlling
+  several generic system aspects. Those can be used to control some power
+  management, they also contain some gate and PLL clocks.
+
+maintainers:
+  - Andre Przywara <andre.przywara@arm.com>
+
+properties:
+  compatible:
+    const: calxeda,hb-sregs
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    type: object
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    sregs@fff3c000 {
+        compatible = "calxeda,hb-sregs";
+        reg = <0xfff3c000 0x1000>;
+
+        clocks {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            osc: oscillator {
+                #clock-cells = <0>;
+                compatible = "fixed-clock";
+                clock-frequency = <33333000>;
+            };
+        };
+    };
-- 
2.17.1

