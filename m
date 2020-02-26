Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A636FC4BA1E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA5124650
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgBZSJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:09:30 -0500
Received: from foss.arm.com ([217.140.110.172]:40518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbgBZSJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:09:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7074A31B;
        Wed, 26 Feb 2020 10:09:25 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF2163F881;
        Wed, 26 Feb 2020 10:09:23 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Richter <rric@kernel.org>, soc@kernel.org,
        Jon Loeliger <jdl@jdl.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 07/13] dt-bindings: net: Convert Calxeda Ethernet binding to json-schema
Date:   Wed, 26 Feb 2020 18:08:55 +0000
Message-Id: <20200226180901.89940-8-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226180901.89940-1-andre.przywara@arm.com>
References: <20200226180901.89940-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Calxeda XGMAC Ethernet device binding to DT schema format
using json-schema.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/net/calxeda-xgmac.txt | 18 -------
 .../bindings/net/calxeda-xgmac.yaml           | 47 +++++++++++++++++++
 2 files changed, 47 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/calxeda-xgmac.txt
 create mode 100644 Documentation/devicetree/bindings/net/calxeda-xgmac.yaml

diff --git a/Documentation/devicetree/bindings/net/calxeda-xgmac.txt b/Documentation/devicetree/bindings/net/calxeda-xgmac.txt
deleted file mode 100644
index c8ae996bd8f2..000000000000
--- a/Documentation/devicetree/bindings/net/calxeda-xgmac.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-* Calxeda Highbank 10Gb XGMAC Ethernet
-
-Required properties:
-- compatible : Should be "calxeda,hb-xgmac"
-- reg : Address and length of the register set for the device
-- interrupts : Should contain 3 xgmac interrupts. The 1st is main interrupt.
-  The 2nd is pwr mgt interrupt. The 3rd is low power state interrupt.
-
-Optional properties:
-- dma-coherent      : Present if dma operations are coherent
-
-Example:
-
-ethernet@fff50000 {
-        compatible = "calxeda,hb-xgmac";
-        reg = <0xfff50000 0x1000>;
-        interrupts = <0 77 4  0 78 4  0 79 4>;
-};
diff --git a/Documentation/devicetree/bindings/net/calxeda-xgmac.yaml b/Documentation/devicetree/bindings/net/calxeda-xgmac.yaml
new file mode 100644
index 000000000000..77b8be9ebb20
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/calxeda-xgmac.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/calxeda-xgmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Calxeda Highbank 10Gb XGMAC Ethernet controller
+
+description: |
+  The Calxeda XGMAC Ethernet controllers are directly connected to the
+  internal machine "network fabric", which is set up, initialised and
+  managed by the firmware. So there are no PHY properties in this
+  binding. Switches in the fabric take care of routing and mapping the
+  traffic to external network ports.
+
+maintainers:
+  - Andre Przywara <andre.przywara@arm.com>
+
+properties:
+  compatible:
+    const: calxeda,hb-xgmac
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: |
+      Can point to at most 3 xgmac interrupts. The 1st one is the main
+      interrupt, the 2nd one is used for power management. The optional
+      3rd one is the low power state interrupt.
+    minItems: 2
+    maxItems: 3
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    ethernet@fff50000 {
+        compatible = "calxeda,hb-xgmac";
+        reg = <0xfff50000 0x1000>;
+        interrupts = <0 77 4>, <0 78 4>, <0 79 4>;
+    };
-- 
2.17.1

