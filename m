Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE40C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 11:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2598F2071E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 11:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="tL77W5FH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgBVLFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 06:05:34 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:32951 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgBVLFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 06:05:33 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 01MB4alo020451;
        Sat, 22 Feb 2020 20:04:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 01MB4alo020451
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582369476;
        bh=QUtc/zt9J0Re8J3lue0pAvtGUOq+B5S2sXMyFuVNQpw=;
        h=From:To:Cc:Subject:Date:From;
        b=tL77W5FH0U9kZMw1COHxjPFCyr0/vNN3EXD2Hhli6b/WVxmfuVq4a2s+CnV9vbm9t
         B2H7i8eAw7IMRQtB8vWpV5/78B+XyR7WpiLsI4Lxp6S84yoNJSgSthZE9SKvrKHDf8
         bpFLa4XqcVVjnt3dLiWkWwAeU/SSCWdThIaMYTQk5DzNF8X7WSmMdW9UZsAaVZf5zc
         L4Q4+S5rWB/8CkahNwQwRfFizi2hOZQs22KeIjndcEFXlUqAds5F0jP/3ttRHlmteh
         WMeXaOhQCVI0LWjJOjwA0M9l12HEFcgDTcEvS8mMzjR2kW1+37T/lv5EfK/MRjxiJ+
         q/wBwDrQAx75g==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] dt-bindings: interrupt-controller: Convert UniPhier AIDET to json-schema
Date:   Sat, 22 Feb 2020 20:04:35 +0900
Message-Id: <20200222110435.18772-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the UniPhier AIDET (ARM Interrupt Detector) binding to DT
schema format.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Some qeustions:

I was wondering when 'additionalProperties: false' should be added.

If I add it to a bus controller device (e.g. I2C),
I see some schema warnings because various sub-nodes
are added depending on which device you connect.

On the other hand, the interrupt controller like this
does not have a subnode.
So, probably this is the case where we can add
'additionalProperties: false'.

Is this correct?

One more thing.

There are multiple ways to do a similar thing:

   compatible:
     enum:
        - socionext,uniphier-ld4-aidet
        - socionext,uniphier-pro4-aidet
        ...
vs

   compatible:
     oneOf:
        - const: socionext,uniphier-ld4-aidet
        - const: socionext,uniphier-pro4-aidet
        ...

I adopted the former because I can save 'const'.
If there is a preferred way, I will follow it.

END

---

Changes in v2:
  - fix the schema warning in the example

 .../socionext,uniphier-aidet.txt              | 32 ----------
 .../socionext,uniphier-aidet.yaml             | 61 +++++++++++++++++++
 2 files changed, 61 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.txt b/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.txt
deleted file mode 100644
index 48e71d3ac2ad..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-UniPhier AIDET
-
-UniPhier AIDET (ARM Interrupt Detector) is an add-on block for ARM GIC (Generic
-Interrupt Controller).  GIC itself can handle only high level and rising edge
-interrupts.  The AIDET provides logic inverter to support low level and falling
-edge interrupts.
-
-Required properties:
-- compatible: Should be one of the following:
-    "socionext,uniphier-ld4-aidet"  - for LD4 SoC
-    "socionext,uniphier-pro4-aidet" - for Pro4 SoC
-    "socionext,uniphier-sld8-aidet" - for sLD8 SoC
-    "socionext,uniphier-pro5-aidet" - for Pro5 SoC
-    "socionext,uniphier-pxs2-aidet" - for PXs2/LD6b SoC
-    "socionext,uniphier-ld11-aidet" - for LD11 SoC
-    "socionext,uniphier-ld20-aidet" - for LD20 SoC
-    "socionext,uniphier-pxs3-aidet" - for PXs3 SoC
-- reg: Specifies offset and length of the register set for the device.
-- interrupt-controller: Identifies the node as an interrupt controller
-- #interrupt-cells : Specifies the number of cells needed to encode an interrupt
-  source.  The value should be 2.  The first cell defines the interrupt number
-  (corresponds to the SPI interrupt number of GIC).  The second cell specifies
-  the trigger type as defined in interrupts.txt in this directory.
-
-Example:
-
-	aidet: aidet@5fc20000 {
-		compatible = "socionext,uniphier-pro4-aidet";
-		reg = <0x5fc20000 0x200>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.yaml b/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.yaml
new file mode 100644
index 000000000000..f89ebde76dab
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/socionext,uniphier-aidet.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UniPhier AIDET
+
+description: |
+  UniPhier AIDET (ARM Interrupt Detector) is an add-on block for ARM GIC
+  (Generic Interrupt Controller). GIC itself can handle only high level and
+  rising edge interrupts. The AIDET provides logic inverter to support low
+  level and falling edge interrupts.
+
+maintainers:
+  - Masahiro Yamada <yamada.masahiro@socionext.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - socionext,uniphier-ld4-aidet
+      - socionext,uniphier-pro4-aidet
+      - socionext,uniphier-sld8-aidet
+      - socionext,uniphier-pro5-aidet
+      - socionext,uniphier-pxs2-aidet
+      - socionext,uniphier-ld6b-aidet
+      - socionext,uniphier-ld11-aidet
+      - socionext,uniphier-ld20-aidet
+      - socionext,uniphier-pxs3-aidet
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    description: |
+      The first cell defines the interrupt number (corresponds to the SPI
+      interrupt number of GIC). The second cell specifies the trigger type as
+      defined in interrupts.txt in this directory.
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@5fc20000 {
+        compatible = "socionext,uniphier-pro4-aidet";
+        reg = <0x5fc20000 0x200>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+    };
-- 
2.17.1

