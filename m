Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F344C352B6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 668742072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Bk3MJhsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbgDMP1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:27:34 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:39858 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730200AbgDMP1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1586791632; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i32sxK0/BQm5mO4QK4rQ7kGxMXUg7+J9OmBQIcOz+lE=;
        b=Bk3MJhsu4IBjfMi0xT9qLDMqPrfc9DX6euqXLtFJPQK1Bl8aa1d/RWk9teNLrFthNyUcAL
        CwPY2J4eVIquY9tjBsuOJY6O1mE51mTjEK0R7zxf9zjOtzz6lVaqk4xSKi5n/ugqQ/hlTA
        kMTFGTxnc77HcjgtlpX3YCQ4Nh06/Ak=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     od@zcrc.me,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 03/13] dt-bindings: dma: Convert jz4740-dma doc to YAML
Date:   Mon, 13 Apr 2020 17:26:23 +0200
Message-Id: <20200413152633.198301-3-paul@crapouillou.net>
In-Reply-To: <20200413152633.198301-1-paul@crapouillou.net>
References: <20200413152633.198301-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the textual documentation for the Ingenic SoCs DMA Controller
devicetree binding to YAML.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../devicetree/bindings/dma/ingenic,dma.yaml  | 80 +++++++++++++++++++
 .../devicetree/bindings/dma/jz4780-dma.txt    | 64 ---------------
 2 files changed, 80 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/ingenic,dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/jz4780-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
new file mode 100644
index 000000000000..92794c500589
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/ingenic,dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic SoCs DMA Controller DT bindings
+
+maintainers:
+  - Paul Cercueil <paul@crapouillou.net>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - ingenic,jz4740-dma
+      - ingenic,jz4725b-dma
+      - ingenic,jz4770-dma
+      - ingenic,jz4780-dma
+      - ingenic,x1000-dma
+      - ingenic,x1830-dma
+
+  reg:
+    items:
+      - description: Channel-specific registers
+      - description: System control registers
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#dma-cells":
+    const: 2
+    description: >
+      DMA clients must use the format described in dma.txt, giving a phandle
+      to the DMA controller plus the following 2 integer cells:
+
+      - Request type: The DMA request type for transfers to/from the
+        device on the allocated channel, as defined in the SoC documentation.
+
+      - Channel: If set to 0xffffffff, any available channel will be allocated
+        for the client. Otherwise, the exact channel specified will be used.
+        The channel should be reserved on the DMA controller using the
+        ingenic,reserved-channels property.
+
+  ingenic,reserved-channels:
+    $ref: /schemas/types.yaml#definitions/uint32
+    description: >
+      Bitmask of channels to reserve for devices that need a specific
+      channel. These channels will only be assigned when explicitely
+      requested by a client. The primary use for this is channels 0 and
+      1, which can be configured to have special behaviour for NAND/BCH
+      when using programmable firmware.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+examples:
+  - |
+    #include <dt-bindings/clock/jz4780-cgu.h>
+    dma: dma-controller@13420000 {
+      compatible = "ingenic,jz4780-dma";
+      reg = <0x13420000 0x400>, <0x13421000 0x40>;
+
+      interrupt-parent = <&intc>;
+      interrupts = <10>;
+
+      clocks = <&cgu JZ4780_CLK_PDMA>;
+
+      #dma-cells = <2>;
+
+      ingenic,reserved-channels = <0x3>;
+    };
diff --git a/Documentation/devicetree/bindings/dma/jz4780-dma.txt b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
deleted file mode 100644
index 3459e77be294..000000000000
--- a/Documentation/devicetree/bindings/dma/jz4780-dma.txt
+++ /dev/null
@@ -1,64 +0,0 @@
-* Ingenic XBurst DMA Controller
-
-Required properties:
-
-- compatible: Should be one of:
-  * ingenic,jz4740-dma
-  * ingenic,jz4725b-dma
-  * ingenic,jz4770-dma
-  * ingenic,jz4780-dma
-  * ingenic,x1000-dma
-  * ingenic,x1830-dma
-- reg: Should contain the DMA channel registers location and length, followed
-  by the DMA controller registers location and length.
-- interrupts: Should contain the interrupt specifier of the DMA controller.
-- clocks: Should contain a clock specifier for the JZ4780/X1000/X1830 PDMA
-  clock.
-- #dma-cells: Must be <2>. Number of integer cells in the dmas property of
-  DMA clients (see below).
-
-Optional properties:
-
-- ingenic,reserved-channels: Bitmask of channels to reserve for devices that
-  need a specific channel. These channels will only be assigned when explicitly
-  requested by a client. The primary use for this is channels 0 and 1, which
-  can be configured to have special behaviour for NAND/BCH when using
-  programmable firmware.
-
-Example:
-
-dma: dma-controller@13420000 {
-	compatible = "ingenic,jz4780-dma";
-	reg = <0x13420000 0x400
-	       0x13421000 0x40>;
-
-	interrupt-parent = <&intc>;
-	interrupts = <10>;
-
-	clocks = <&cgu JZ4780_CLK_PDMA>;
-
-	#dma-cells = <2>;
-
-	ingenic,reserved-channels = <0x3>;
-};
-
-DMA clients must use the format described in dma.txt, giving a phandle to the
-DMA controller plus the following 2 integer cells:
-
-1. Request type: The DMA request type for transfers to/from the device on
-   the allocated channel, as defined in the SoC documentation.
-
-2. Channel: If set to 0xffffffff, any available channel will be allocated for
-   the client. Otherwise, the exact channel specified will be used. The channel
-   should be reserved on the DMA controller using the ingenic,reserved-channels
-   property.
-
-Example:
-
-uart0: serial@10030000 {
-	...
-	dmas = <&dma 0x14 0xffffffff
-		&dma 0x15 0xffffffff>;
-	dma-names = "tx", "rx";
-	...
-};
-- 
2.25.1

