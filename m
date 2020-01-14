Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BABC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078AA2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579018160;
	bh=NFFHSNv1DlWGNVCrdRN2Z/J+vG6rhp5TLj2SjfZ2eM4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=VgGfcEVj8YZ6dCoFC/VLKGvdHiZf5Hy9ySK+9prgCKMQQuHwo2XKLwySvZvnMZBPB
	 LBpzYfSB/1T/G7SovJuT4raNw4QOEBhEpNTYAsYBs92M9XVNMMb0YpK+7h+VMyd5P+
	 CnbD2GV2ubIGd9L2teKDRLHBGcFkKRVxG231rwu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgANQJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:09:19 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37278 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgANQJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=PL4q4saA2/5hcYaIEYDv2N6RnvzTXQ5f0CStk5GfbSE=; b=RnX0cGelf9IM
        WbVdpWTjBKuRSzT2EwQ7UDfXnqbUmt1XoIyRW08vWg3vQQVUuqWOzWgVTTLPJs3tIMSecZDbC4R+1
        EWA/a3p5oIhMSBiQfzaQtsBrOXtSzOPLNIyBmVvIsO4O6xbXdKpgh9mx4Y8LPW4kzctZQw0Wx8bxl
        6LIGg=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1irOkd-0001V2-QD; Tue, 14 Jan 2020 16:09:07 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 80462D02C7C; Tue, 14 Jan 2020 16:09:07 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        Rob Herring <robh+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>
Subject: Applied "dt-bindings: sound: Convert jz47*-codec doc to YAML" to the asoc tree
In-Reply-To: <20191224002708.1207884-1-paul@crapouillou.net>
Message-Id: <applied-20191224002708.1207884-1-paul@crapouillou.net>
X-Patchwork-Hint: ignore
Date:   Tue, 14 Jan 2020 16:09:07 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: sound: Convert jz47*-codec doc to YAML

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

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

From 30bcb1f264bfdd49561cc7a974b67c4d712b3668 Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Tue, 24 Dec 2019 01:27:07 +0100
Subject: [PATCH] dt-bindings: sound: Convert jz47*-codec doc to YAML

Convert ingenic,jz4740-codec.txt and ingenic,jz4725b-codec.txt to one
single ingenic,codec.yaml file, since they share the same binding.

Add the ingenic,jz4770-codec compatible string in the process.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20191224002708.1207884-1-paul@crapouillou.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/ingenic,codec.yaml         | 55 +++++++++++++++++++
 .../bindings/sound/ingenic,jz4725b-codec.txt  | 20 -------
 .../bindings/sound/ingenic,jz4740-codec.txt   | 20 -------
 3 files changed, 55 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/ingenic,codec.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4725b-codec.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4740-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/ingenic,codec.yaml b/Documentation/devicetree/bindings/sound/ingenic,codec.yaml
new file mode 100644
index 000000000000..eb4be86464bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ingenic,codec.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ingenic,codec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic JZ47xx internal codec DT bindings
+
+maintainers:
+  - Paul Cercueil <paul@crapouillou.net>
+
+properties:
+  $nodename:
+    pattern: '^audio-codec@.*'
+
+  compatible:
+    oneOf:
+      - const: ingenic,jz4770-codec
+      - const: ingenic,jz4725b-codec
+      - const: ingenic,jz4740-codec
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: aic
+
+  '#sound-dai-cells':
+    const: 0
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#sound-dai-cells'
+
+examples:
+  - |
+    #include <dt-bindings/clock/jz4740-cgu.h>
+    codec: audio-codec@10020080 {
+      compatible = "ingenic,jz4740-codec";
+      reg = <0x10020080 0x8>;
+      #sound-dai-cells = <0>;
+      clocks = <&cgu JZ4740_CLK_AIC>;
+      clock-names = "aic";
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/sound/ingenic,jz4725b-codec.txt b/Documentation/devicetree/bindings/sound/ingenic,jz4725b-codec.txt
deleted file mode 100644
index 05adc0d47b13..000000000000
--- a/Documentation/devicetree/bindings/sound/ingenic,jz4725b-codec.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Ingenic JZ4725B codec controller
-
-Required properties:
-- compatible : "ingenic,jz4725b-codec"
-- reg : codec registers location and length
-- clocks : phandle to the AIC clock.
-- clock-names: must be set to "aic".
-- #sound-dai-cells: Must be set to 0.
-
-Example:
-
-codec: audio-codec@100200a4 {
-	compatible = "ingenic,jz4725b-codec";
-	reg = <0x100200a4 0x8>;
-
-	#sound-dai-cells = <0>;
-
-	clocks = <&cgu JZ4725B_CLK_AIC>;
-	clock-names = "aic";
-};
diff --git a/Documentation/devicetree/bindings/sound/ingenic,jz4740-codec.txt b/Documentation/devicetree/bindings/sound/ingenic,jz4740-codec.txt
deleted file mode 100644
index 1ffcade87e7b..000000000000
--- a/Documentation/devicetree/bindings/sound/ingenic,jz4740-codec.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Ingenic JZ4740 codec controller
-
-Required properties:
-- compatible : "ingenic,jz4740-codec"
-- reg : codec registers location and length
-- clocks : phandle to the AIC clock.
-- clock-names: must be set to "aic".
-- #sound-dai-cells: Must be set to 0.
-
-Example:
-
-codec: audio-codec@10020080 {
-	compatible = "ingenic,jz4740-codec";
-	reg = <0x10020080 0x8>;
-
-	#sound-dai-cells = <0>;
-
-	clocks = <&cgu JZ4740_CLK_AIC>;
-	clock-names = "aic";
-};
-- 
2.20.1

