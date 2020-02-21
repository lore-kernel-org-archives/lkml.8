Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89DFC11D24
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E706207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TKEJiQp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgBUCZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 21:25:54 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:23423 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbgBUCZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 21:25:54 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 01L2P6P4019101;
        Fri, 21 Feb 2020 11:25:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 01L2P6P4019101
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582251907;
        bh=eqHny2FaqNErlaYN7wu9BhfmPoOAesBI8drGqqCcumU=;
        h=From:To:Cc:Subject:Date:From;
        b=TKEJiQp0Jz01Hs5YJIVJSHWi8i8mxGOblcOKkYhYWSMLGCXwut6zT2hr3jJ2Fp6i9
         MU9zGmCJfeoqjBdjtN29n5GrXRemKacIW/GjCDi208sSieuJfEcpm0/mh+2L71X2d0
         F/DJFWnQgoiG9CsZx9jxtEZA+T1XErp7mr/pv8dFwdC72xQSstOM0BUexWRuzeDa5W
         hyeBhDa1Jg1v7q3hr9g06GjNUHfCSlfMd69A3axQUlNYnQDkxAiS9Ge07c/XtG4U0n
         MiA3MkaFIeogPLpbEzVwDyhSHvMpd0RdyQJgomUdgG4Ie4hgzIb0MOiZrZnovFVxma
         x00o7hYBKyPrw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: Convert UniPhier MIO DMA controller to json-schema
Date:   Fri, 21 Feb 2020 11:25:04 +0900
Message-Id: <20200221022504.24104-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the UniPhier MIO (Media I/O) DMA controller binding to DT
schema format.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../dma/socionext,uniphier-mio-dmac.yaml      | 59 +++++++++++++++++++
 .../bindings/dma/uniphier-mio-dmac.txt        | 25 --------
 2 files changed, 59 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt

diff --git a/Documentation/devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml b/Documentation/devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml
new file mode 100644
index 000000000000..817e5aec3b31
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/socionext,uniphier-mio-dmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UniPhier Media IO DMA controller
+
+description: |
+  This works as an external DMA engine for SD/eMMC controllers etc.
+  found in UniPhier LD4, Pro4, sLD8 SoCs.
+
+maintainers:
+  - Masahiro Yamada <yamada.masahiro@socionext.com>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    const: socionext,uniphier-mio-dmac
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: |
+      A list of interrupt specifiers associated with the DMA channels.
+      The number of interrupt lines is SoC-dependent.
+
+  clocks:
+    maxItems: 1
+
+  '#dma-cells':
+    description: The single cell represents the channel index.
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - '#dma-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    // In the example below, "interrupts = <0 68 4>, <0 68 4>, ..." is not a
+    // typo. The first two channels share a single interrupt line.
+
+    dmac: dma-controller@5a000000 {
+        compatible = "socionext,uniphier-mio-dmac";
+        reg = <0x5a000000 0x1000>;
+        interrupts = <0 68 4>, <0 68 4>, <0 69 4>, <0 70 4>,
+                     <0 71 4>, <0 72 4>, <0 73 4>, <0 74 4>;
+        clocks = <&mio_clk 7>;
+        #dma-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt b/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
deleted file mode 100644
index b12388dc7eac..000000000000
--- a/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-UniPhier Media IO DMA controller
-
-This works as an external DMA engine for SD/eMMC controllers etc.
-found in UniPhier LD4, Pro4, sLD8 SoCs.
-
-Required properties:
-- compatible: should be "socionext,uniphier-mio-dmac".
-- reg: offset and length of the register set for the device.
-- interrupts: a list of interrupt specifiers associated with the DMA channels.
-- clocks: a single clock specifier.
-- #dma-cells: should be <1>. The single cell represents the channel index.
-
-Example:
-	dmac: dma-controller@5a000000 {
-		compatible = "socionext,uniphier-mio-dmac";
-		reg = <0x5a000000 0x1000>;
-		interrupts = <0 68 4>, <0 68 4>, <0 69 4>, <0 70 4>,
-			     <0 71 4>, <0 72 4>, <0 73 4>, <0 74 4>;
-		clocks = <&mio_clk 7>;
-		#dma-cells = <1>;
-	};
-
-Note:
-In the example above, "interrupts = <0 68 4>, <0 68 4>, ..." is not a typo.
-The first two channels share a single interrupt line.
-- 
2.17.1

