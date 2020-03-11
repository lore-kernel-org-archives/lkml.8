Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36DDC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE0622527
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583932451;
	bh=nvA6BQl6PI2KP1cqD+maPlYuL84hxcsQenGC1RViT6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=oi5RTmbAsmVifzGGKmzpPpEz25r1blVlkFTCyEd+yhFJDfR0vdZOuf0P/y45x8o6+
	 e4PmaXT8SfT8aMF79YhU6p5dqzyvZ4GmlbEh1lSOwSVWmhavXC2ckYyWH5cpnphcEm
	 I/7LRoKugWN6a8+nznL0hlpMDqHEgBFmaEY5AEKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgCKNOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:14:10 -0400
Received: from foss.arm.com ([217.140.110.172]:49664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729331AbgCKNOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:14:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95FC731B;
        Wed, 11 Mar 2020 06:14:09 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AA4C3F67D;
        Wed, 11 Mar 2020 06:14:08 -0700 (PDT)
Date:   Wed, 11 Mar 2020 13:14:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        olivier.moysan@st.com, robh+dt@kernel.org
Subject: Applied "ASoC: Convert cirrus,cs42l51 to json-schema" to the asoc tree
In-Reply-To: <20200228152706.29749-1-benjamin.gaignard@st.com>
Message-Id: <applied-20200228152706.29749-1-benjamin.gaignard@st.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Convert cirrus,cs42l51 to json-schema

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

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

From 97249a89c17e8f1288fed1ebc617ea2e9e88d501 Mon Sep 17 00:00:00 2001
From: Benjamin Gaignard <benjamin.gaignard@st.com>
Date: Fri, 28 Feb 2020 16:27:06 +0100
Subject: [PATCH] ASoC: Convert cirrus,cs42l51 to json-schema

Convert cirrus,cs42l51 to yaml format.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20200228152706.29749-1-benjamin.gaignard@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/cirrus,cs42l51.yaml        | 69 +++++++++++++++++++
 .../devicetree/bindings/sound/cs42l51.txt     | 33 ---------
 2 files changed, 69 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs42l51.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/cs42l51.txt

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs42l51.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs42l51.yaml
new file mode 100644
index 000000000000..efce847a3408
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs42l51.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/cirrus,cs42l51.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CS42L51 audio codec DT bindings
+
+maintainers:
+  - Olivier Moysan <olivier.moysan@st.com>
+
+properties:
+  compatible:
+      const: cirrus,cs42l51
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: MCLK
+
+  reset-gpios:
+    maxItems: 1
+
+  VL-supply:
+    description: phandle to voltage regulator of digital interface section
+
+  VD-supply:
+    description: phandle to voltage regulator of digital internal section
+
+  VA-supply:
+    description: phandle to voltage regulator of analog internal section
+
+  VAHP-supply:
+    description: phandle to voltage regulator of headphone
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c@0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      cs42l51@4a {
+        compatible = "cirrus,cs42l51";
+        reg = <0x4a>;
+        #sound-dai-cells = <0>;
+        clocks = <&mclk_prov>;
+        clock-names = "MCLK";
+        VL-supply = <&reg_audio>;
+        VD-supply = <&reg_audio>;
+        VA-supply = <&reg_audio>;
+        VAHP-supply = <&reg_audio>;
+        reset-gpios = <&gpiog 9 GPIO_ACTIVE_LOW>;
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/sound/cs42l51.txt b/Documentation/devicetree/bindings/sound/cs42l51.txt
deleted file mode 100644
index acbd68ddd2cb..000000000000
--- a/Documentation/devicetree/bindings/sound/cs42l51.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-CS42L51 audio CODEC
-
-Required properties:
-
-  - compatible : "cirrus,cs42l51"
-
-  - reg : the I2C address of the device for I2C.
-
-Optional properties:
-  - VL-supply, VD-supply, VA-supply, VAHP-supply: power supplies for the device,
-    as covered in Documentation/devicetree/bindings/regulator/regulator.txt.
-
-  - reset-gpios : GPIO specification for the reset pin. If specified, it will be
-    deasserted before starting the communication with the codec.
-
-  - clocks : a list of phandles + clock-specifiers, one for each entry in
-    clock-names
-
-  - clock-names : must contain "MCLK"
-
-Example:
-
-cs42l51: cs42l51@4a {
-	compatible = "cirrus,cs42l51";
-	reg = <0x4a>;
-	clocks = <&mclk_prov>;
-	clock-names = "MCLK";
-	VL-supply = <&reg_audio>;
-	VD-supply = <&reg_audio>;
-	VA-supply = <&reg_audio>;
-	VAHP-supply = <&reg_audio>;
-	reset-gpios = <&gpiog 9 GPIO_ACTIVE_LOW>;
-};
-- 
2.20.1

