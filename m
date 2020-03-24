Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F01FC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34B12076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585070175;
	bh=QhTIGDa3tJ3ccy06nrYXCwIgGIP0Ua9f+Bp+XPWiYWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=jpU8JfPDJlEX01SIzK5beFrICeYfZ8hSsLgHd7w4ZSEoam9ShEKirlU7qDStso6h/
	 ZerZp78uunB4ey0YiXRNvd/3ZrUQAqwPszVUUc5Ga3C9Ftyi/L7zqavLfaJOKfU2Qc
	 NzrZIVLFXqkB3nA9D4shs5NMkrbFJOG99dX118V4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgCXRQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:16:14 -0400
Received: from foss.arm.com ([217.140.110.172]:38458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbgCXRQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:16:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AD4C1FB;
        Tue, 24 Mar 2020 10:16:13 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80CE53F71F;
        Tue, 24 Mar 2020 10:16:12 -0700 (PDT)
Date:   Tue, 24 Mar 2020 17:16:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>
Subject: Applied "ASoC: Convert jz4740-i2s doc to YAML" to the asoc tree
In-Reply-To:  <20200306222931.39664-1-paul@crapouillou.net>
Message-Id:  <applied-20200306222931.39664-1-paul@crapouillou.net>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Convert jz4740-i2s doc to YAML

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 129a5d4824d5fc4a8c155d4349492caaf1a4ea28 Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Fri, 6 Mar 2020 23:29:26 +0100
Subject: [PATCH] ASoC: Convert jz4740-i2s doc to YAML

Convert the textual binding documentation for the AIC (AC97/I2S
Controller) of Ingenic SoCs to a YAML schema, and add the new compatible
strings in the process.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20200306222931.39664-1-paul@crapouillou.net
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1

