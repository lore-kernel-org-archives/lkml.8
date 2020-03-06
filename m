Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099D8C3F2D6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6A320705
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="RDe8VCo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCFW3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:29:38 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:47892 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCFW3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1583533776; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=PT8uQQYAH9Vv0YxKJ/O7JQHklj40PoE+07mqPq5SYKc=;
        b=RDe8VCo4xT2xqbQ98ApgiBGDS5cys8epCCCFPALNLlGTQQoy5agzhAGZJwBgL56w1QQDU/
        DAu1d3st8bbFkIGC8vAYliIHdQvzG4JoGY2rlLv5Amu00BBMgSKHQK02gTV03BWi7YLTpJ
        yr8FBpszZekRncJf2SCqtn2xHSDWUbs=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/6] dt-bindings: sound: Convert jz4740-i2s doc to YAML
Date:   Fri,  6 Mar 2020 23:29:26 +0100
Message-Id: <20200306222931.39664-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the textual binding documentation for the AIC (AC97/I2S
Controller) of Ingenic SoCs to a YAML schema, and add the new compatible
strings in the process.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../bindings/sound/ingenic,aic.yaml           | 92 +++++++++++++++++++
 .../bindings/sound/ingenic,jz4740-i2s.txt     | 23 -----
 2 files changed, 92 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/ingenic,aic.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4740-i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/ingenic,aic.yaml b/Documentation/devicetree/bindings/sound/ingenic,aic.yaml
new file mode 100644
index 000000000000..44f49bebb267
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ingenic,aic.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ingenic,aic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic SoCs AC97 / I2S Controller (AIC) DT bindings
+
+maintainers:
+  - Paul Cercueil <paul@crapouillou.net>
+
+properties:
+  $nodename:
+    pattern: '^audio-controller@'
+
+  compatible:
+    oneOf:
+      - enum:
+        - ingenic,jz4740-i2s
+        - ingenic,jz4760-i2s
+        - ingenic,jz4770-i2s
+        - ingenic,jz4780-i2s
+      - items:
+        - const: ingenic,jz4725b-i2s
+        - const: ingenic,jz4740-i2s
+
+  '#sound-dai-cells':
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: AIC clock
+      - description: I2S clock
+      - description: EXT clock
+      - description: PLL/2 clock
+
+  clock-names:
+    items:
+      - const: aic
+      - const: i2s
+      - const: ext
+      - const: pll half
+
+  dmas:
+    items:
+      - description: DMA controller phandle and request line for I2S RX
+      - description: DMA controller phandle and request line for I2S TX
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+  - '#sound-dai-cells'
+
+examples:
+  - |
+    #include <dt-bindings/clock/jz4740-cgu.h>
+    aic: audio-controller@10020000 {
+      compatible = "ingenic,jz4740-i2s";
+      reg = <0x10020000 0x38>;
+
+      #sound-dai-cells = <0>;
+
+      interrupt-parent = <&intc>;
+      interrupts = <18>;
+
+      clocks = <&cgu JZ4740_CLK_AIC>,
+               <&cgu JZ4740_CLK_I2S>,
+               <&cgu JZ4740_CLK_EXT>,
+               <&cgu JZ4740_CLK_PLL_HALF>;
+      clock-names = "aic", "i2s", "ext", "pll half";
+
+      dmas = <&dmac 25 0xffffffff>, <&dmac 24 0xffffffff>;
+      dma-names = "rx", "tx";
+    };
diff --git a/Documentation/devicetree/bindings/sound/ingenic,jz4740-i2s.txt b/Documentation/devicetree/bindings/sound/ingenic,jz4740-i2s.txt
deleted file mode 100644
index b623d50004fb..000000000000
--- a/Documentation/devicetree/bindings/sound/ingenic,jz4740-i2s.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Ingenic JZ4740 I2S controller
-
-Required properties:
-- compatible : "ingenic,jz4740-i2s" or "ingenic,jz4780-i2s"
-- reg : I2S registers location and length
-- clocks : AIC and I2S PLL clock specifiers.
-- clock-names: "aic" and "i2s"
-- dmas: DMA controller phandle and DMA request line for I2S Tx and Rx channels
-- dma-names: Must be "tx" and "rx"
-
-Example:
-
-i2s: i2s@10020000 {
-	compatible = "ingenic,jz4740-i2s";
-	reg = <0x10020000 0x94>;
-
-	clocks = <&cgu JZ4740_CLK_AIC>, <&cgu JZ4740_CLK_I2SPLL>;
-	clock-names = "aic", "i2s";
-
-	dmas = <&dma 2>, <&dma 3>;
-	dma-names = "tx", "rx";
-
-};
-- 
2.25.1

