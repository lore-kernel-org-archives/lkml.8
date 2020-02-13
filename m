Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D5AC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BA420848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581627484;
	bh=1rohtle2XUE15vdG7sm3HU7YRCh0g8BdG1xKX/LVL20=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=FUhvLiMZYCcIkmQOsbuO512ybTROuHhcOqZG3bndtTziIFADBKBK9jF8LDFvsozAv
	 +NE/V89n/KjPs0hAuBccpGHwxrpJ0JplwUEew4g3qp1OFBnncVhdDSmkCbmPcDHNcm
	 564Rg+tWP23elbrkqUaRfjbly4m6camxwnZoqzjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgBMU6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:58:03 -0500
Received: from foss.arm.com ([217.140.110.172]:53518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbgBMU6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:58:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 734591FB;
        Thu, 13 Feb 2020 12:58:02 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB18D3F6CF;
        Thu, 13 Feb 2020 12:58:01 -0800 (PST)
Date:   Thu, 13 Feb 2020 20:58:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: gx: add sound card dt-binding documentation" to the asoc tree
In-Reply-To:  <20200213155159.3235792-9-jbrunet@baylibre.com>
Message-Id:  <applied-20200213155159.3235792-9-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: gx: add sound card dt-binding documentation

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

From fd00366b8e4125d29e32d49053a702ddf77430f6 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 13 Feb 2020 16:51:58 +0100
Subject: [PATCH] ASoC: meson: gx: add sound card dt-binding documentation

Add the dt-binding documentation of sound card supporting the amlogic
GX SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20200213155159.3235792-9-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/amlogic,gx-sound-card.yaml | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml

diff --git a/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml b/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
new file mode 100644
index 000000000000..fb374c659be1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,gx-sound-card.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic GX sound card
+
+maintainers:
+  - Jerome Brunet <jbrunet@baylibre.com>
+
+properties:
+  compatible:
+    items:
+      - const: amlogic,gx-sound-card
+
+  audio-aux-devs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: list of auxiliary devices
+
+  audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    minItems: 2
+    description: |-
+      A list of the connections between audio components. Each entry is a
+      pair of strings, the first being the connection's sink, the second
+      being the connection's source.
+
+  audio-widgets:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    minItems: 2
+    description: |-
+      A list off component DAPM widget. Each entry is a pair of strings,
+      the first being the widget type, the second being the widget name
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User specified audio sound card name
+
+patternProperties:
+  "^dai-link-[0-9]+$":
+    type: object
+    description: |-
+      dai-link child nodes:
+        Container for dai-link level properties and the CODEC sub-nodes.
+        There should be at least one (and probably more) subnode of this type
+
+    properties:
+      dai-format:
+        $ref: /schemas/types.yaml#/definitions/string
+        enum: [ i2s, left-j, dsp_a ]
+
+      mclk-fs:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |-
+          Multiplication factor between the frame rate and master clock
+          rate
+
+      sound-dai:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle of the CPU DAI
+
+    patternProperties:
+      "^codec-[0-9]+$":
+        type: object
+        description: |-
+          Codecs:
+          dai-link representing backend links should have at least one subnode.
+          One subnode for each codec of the dai-link. dai-link representing
+          frontend links have no codec, therefore have no subnodes
+
+        properties:
+          sound-dai:
+            $ref: /schemas/types.yaml#/definitions/phandle
+            description: phandle of the codec DAI
+
+        required:
+          - sound-dai
+
+    required:
+      - sound-dai
+
+required:
+  - model
+  - dai-link-0
+
+examples:
+  - |
+    sound {
+        compatible = "amlogic,gx-sound-card";
+        model = "GXL-ACME-S905X-FOO";
+        audio-aux-devs = <&amp>;
+        audio-routing = "I2S ENCODER I2S IN", "I2S FIFO Playback";
+
+        dai-link-0 {
+               sound-dai = <&i2s_fifo>;
+        };
+
+        dai-link-1 {
+                sound-dai = <&i2s_encoder>;
+                dai-format = "i2s";
+                mclk-fs = <256>;
+
+                codec-0 {
+                        sound-dai = <&codec0>;
+                };
+
+                codec-1 {
+                        sound-dai = <&codec1>;
+                };
+        };
+    };
+
-- 
2.20.1

