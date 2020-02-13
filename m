Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52998C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCD620848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581627509;
	bh=6+qboQGaijQR50Zjoli0qF/Sl+KgqWO7iQVh8wlKtlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=L1ogLfQp91j1voXKaDt/Y+UyQ2i3C9t9AtzBk6XncaXSZ9MFzcSWrN8P4maqWI6m9
	 PXQzGsl5WwOaD8tv/LSUqV0zu/z2sSFYKAyyyl0qE7DBaTb5fLbY4HMWVdmWOc0xJc
	 uYzaeQujh+6wPMG9J2y4kS5ULl8sWXSb0gxH4poU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgBMU62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:58:28 -0500
Received: from foss.arm.com ([217.140.110.172]:53598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727940AbgBMU61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:58:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5D701045;
        Thu, 13 Feb 2020 12:58:26 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2904B3F6CF;
        Thu, 13 Feb 2020 12:58:26 -0800 (PST)
Date:   Thu, 13 Feb 2020 20:58:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: aiu: add audio output dt-bindings" to the asoc tree
In-Reply-To:  <20200213155159.3235792-4-jbrunet@baylibre.com>
Message-Id:  <applied-20200213155159.3235792-4-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: aiu: add audio output dt-bindings

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

From 06b72824386795bf6f0a6ac0f0cfef6b7f0165c1 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 13 Feb 2020 16:51:53 +0100
Subject: [PATCH] ASoC: meson: aiu: add audio output dt-bindings

Add the dt-bindings and documentation of the AIU audio controller.
This component provides most of the audio outputs found on the Amlogic
Gx SoC family.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20200213155159.3235792-4-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/amlogic,aiu.yaml           | 111 ++++++++++++++++++
 include/dt-bindings/sound/meson-aiu.h         |  18 +++
 2 files changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
 create mode 100644 include/dt-bindings/sound/meson-aiu.h

diff --git a/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml b/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
new file mode 100644
index 000000000000..3ef7632dcb59
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,aiu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic AIU audio output controller
+
+maintainers:
+  - Jerome Brunet <jbrunet@baylibre.com>
+
+properties:
+  $nodename:
+    pattern: "^audio-controller@.*"
+
+  "#sound-dai-cells":
+    const: 2
+
+  compatible:
+    items:
+      - enum:
+        - amlogic,aiu-gxbb
+        - amlogic,aiu-gxl
+      - const:
+          amlogic,aiu
+
+  clocks:
+    items:
+      - description: AIU peripheral clock
+      - description: I2S peripheral clock
+      - description: I2S output clock
+      - description: I2S master clock
+      - description: I2S mixer clock
+      - description: SPDIF peripheral clock
+      - description: SPDIF output clock
+      - description: SPDIF master clock
+      - description: SPDIF master clock multiplexer
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: i2s_pclk
+      - const: i2s_aoclk
+      - const: i2s_mclk
+      - const: i2s_mixer
+      - const: spdif_pclk
+      - const: spdif_aoclk
+      - const: spdif_mclk
+      - const: spdif_mclk_sel
+
+  interrupts:
+    items:
+      - description: I2S interrupt line
+      - description: SPDIF interrupt line
+
+  interrupt-names:
+    items:
+      - const: i2s
+      - const: spdif
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - reg
+  - resets
+
+examples:
+  - |
+    #include <dt-bindings/clock/gxbb-clkc.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/amlogic,meson-gxbb-reset.h>
+
+    aiu: audio-controller@5400 {
+        compatible = "amlogic,aiu-gxl", "amlogic,aiu";
+        #sound-dai-cells = <2>;
+        reg = <0x0 0x5400 0x0 0x2ac>;
+        interrupts = <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "i2s", "spdif";
+        clocks = <&clkc CLKID_AIU_GLUE>,
+                 <&clkc CLKID_I2S_OUT>,
+                 <&clkc CLKID_AOCLK_GATE>,
+                 <&clkc CLKID_CTS_AMCLK>,
+                 <&clkc CLKID_MIXER_IFACE>,
+                 <&clkc CLKID_IEC958>,
+                 <&clkc CLKID_IEC958_GATE>,
+                 <&clkc CLKID_CTS_MCLK_I958>,
+                 <&clkc CLKID_CTS_I958>;
+        clock-names = "pclk",
+                      "i2s_pclk",
+                      "i2s_aoclk",
+                      "i2s_mclk",
+                      "i2s_mixer",
+                      "spdif_pclk",
+                      "spdif_aoclk",
+                      "spdif_mclk",
+                      "spdif_mclk_sel";
+        resets = <&reset RESET_AIU>;
+    };
+
diff --git a/include/dt-bindings/sound/meson-aiu.h b/include/dt-bindings/sound/meson-aiu.h
new file mode 100644
index 000000000000..1051b8af298b
--- /dev/null
+++ b/include/dt-bindings/sound/meson-aiu.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_MESON_AIU_H
+#define __DT_MESON_AIU_H
+
+#define AIU_CPU			0
+#define AIU_HDMI		1
+#define AIU_ACODEC		2
+
+#define CPU_I2S_FIFO		0
+#define CPU_SPDIF_FIFO		1
+#define CPU_I2S_ENCODER		2
+#define CPU_SPDIF_ENCODER	3
+
+#define CTRL_I2S		0
+#define CTRL_PCM		1
+#define CTRL_OUT		2
+
+#endif /* __DT_MESON_AIU_H */
-- 
2.20.1

