Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4DCC35E15
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41FE246A6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbgB0SWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:22:34 -0500
Received: from foss.arm.com ([217.140.110.172]:56678 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730763AbgB0SWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:22:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B79DB30E;
        Thu, 27 Feb 2020 10:22:31 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F24703F73B;
        Thu, 27 Feb 2020 10:22:29 -0800 (PST)
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
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 06/13] dt-bindings: sata: Convert Calxeda SATA controller to json-schema
Date:   Thu, 27 Feb 2020 18:22:03 +0000
Message-Id: <20200227182210.89512-7-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200227182210.89512-1-andre.przywara@arm.com>
References: <20200227182210.89512-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Calxeda Highbank SATA controller binding to DT schema format
using json-schema.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 .../devicetree/bindings/ata/sata_highbank.txt | 44 ---------
 .../bindings/ata/sata_highbank.yaml           | 95 +++++++++++++++++++
 2 files changed, 95 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/sata_highbank.txt
 create mode 100644 Documentation/devicetree/bindings/ata/sata_highbank.yaml

diff --git a/Documentation/devicetree/bindings/ata/sata_highbank.txt b/Documentation/devicetree/bindings/ata/sata_highbank.txt
deleted file mode 100644
index aa83407cb7a4..000000000000
--- a/Documentation/devicetree/bindings/ata/sata_highbank.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-* Calxeda AHCI SATA Controller
-
-SATA nodes are defined to describe on-chip Serial ATA controllers.
-The Calxeda SATA controller mostly conforms to the AHCI interface
-with some special extensions to add functionality.
-Each SATA controller should have its own node.
-
-Required properties:
-- compatible        : compatible list, contains "calxeda,hb-ahci"
-- interrupts        : <interrupt mapping for SATA IRQ>
-- reg               : <registers mapping>
-
-Optional properties:
-- dma-coherent      : Present if dma operations are coherent
-- calxeda,port-phys : phandle-combophy and lane assignment, which maps each
-			SATA port to a combophy and a lane within that
-			combophy
-- calxeda,sgpio-gpio: phandle-gpio bank, bit offset, and default on or off,
-			which indicates that the driver supports SGPIO
-			indicator lights using the indicated GPIOs
-- calxeda,led-order : a u32 array that map port numbers to offsets within the
-			SGPIO bitstream.
-- calxeda,tx-atten  : a u32 array that contains TX attenuation override
-			codes, one per port. The upper 3 bytes are always
-			0 and thus ignored.
-- calxeda,pre-clocks : a u32 that indicates the number of additional clock
-			cycles to transmit before sending an SGPIO pattern
-- calxeda,post-clocks: a u32 that indicates the number of additional clock
-			cycles to transmit after sending an SGPIO pattern
-
-Example:
-        sata@ffe08000 {
-		compatible = "calxeda,hb-ahci";
-		reg = <0xffe08000 0x1000>;
-		interrupts = <115>;
-		dma-coherent;
-		calxeda,port-phys = <&combophy5 0 &combophy0 0 &combophy0 1
-					&combophy0 2 &combophy0 3>;
-		calxeda,sgpio-gpio =<&gpioh 5 1 &gpioh 6 1 &gpioh 7 1>;
-		calxeda,led-order = <4 0 1 2 3>;
-		calxeda,tx-atten = <0xff 22 0xff 0xff 23>;
-		calxeda,pre-clocks = <10>;
-		calxeda,post-clocks = <0>;
-        };
diff --git a/Documentation/devicetree/bindings/ata/sata_highbank.yaml b/Documentation/devicetree/bindings/ata/sata_highbank.yaml
new file mode 100644
index 000000000000..6dcf91e1bac0
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/sata_highbank.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/sata_highbank.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Calxeda AHCI SATA Controller
+
+description: |
+  The Calxeda SATA controller mostly conforms to the AHCI interface
+  with some special extensions to add functionality, to map GPIOs for
+  activity LEDs and for mapping the ComboPHYs.
+
+maintainers:
+  - Andre Przywara <andre.przywara@arm.com>
+
+properties:
+  compatible:
+    const: calxeda,hb-ahci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  dma-coherent: true
+
+  calxeda,pre-clocks:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Indicates the number of additional clock cycles to transmit before
+      sending an SGPIO pattern.
+
+  calxeda,post-clocks:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Indicates the number of additional clock cycles to transmit after
+      sending an SGPIO pattern.
+
+  calxeda,led-order:
+    description: Maps port numbers to offsets within the SGPIO bitstream.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - minItems: 1
+        maxItems: 8
+
+  calxeda,port-phys:
+    description: |
+      phandle-combophy and lane assignment, which maps each SATA port to a
+      combophy and a lane within that combophy
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle-array
+      - minItems: 1
+        maxItems: 8
+
+  calxeda,tx-atten:
+    description: |
+      Contains TX attenuation override codes, one per port.
+      The upper 24 bits of each entry are always 0 and thus ignored.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - minItems: 1
+        maxItems: 8
+
+  calxeda,sgpio-gpio:
+    description: |
+      phandle-gpio bank, bit offset, and default on or off, which indicates
+      that the driver supports SGPIO indicator lights using the indicated
+      GPIOs.
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
+    sata@ffe08000 {
+        compatible = "calxeda,hb-ahci";
+        reg = <0xffe08000 0x1000>;
+        interrupts = <115>;
+        dma-coherent;
+        calxeda,port-phys = <&combophy5 0 &combophy0 0 &combophy0 1
+                             &combophy0 2 &combophy0 3>;
+        calxeda,sgpio-gpio =<&gpioh 5 1 &gpioh 6 1 &gpioh 7 1>;
+        calxeda,led-order = <4 0 1 2 3>;
+        calxeda,tx-atten = <0xff 22 0xff 0xff 23>;
+        calxeda,pre-clocks = <10>;
+        calxeda,post-clocks = <0>;
+    };
+
+...
-- 
2.17.1

