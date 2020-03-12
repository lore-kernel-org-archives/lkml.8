Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAFEC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0112067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584034739;
	bh=x7j4e2lX4FBuJXa9tKzNF5KUj7yNomg3+sgejuK/t58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=BEqMpmY0QInUGhbZmCBATngVuc52HqCTD6HnzN0JKMB/icnbZzxJiUiDqA5bsDVyV
	 ekI8gVBEr31atKMvtK+r8tvgKq5Uxnkl9k/C9/dqcRGm4O2e5iTU9azzq0UvzRX2+a
	 YpEP8Tx+55iTCOhD/2RNSAMP1AHH4MUB1Fq5Ja2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgCLRi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:38:58 -0400
Received: from foss.arm.com ([217.140.110.172]:38854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgCLRi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:38:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5BE830E;
        Thu, 12 Mar 2020 10:38:57 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B6153F6CF;
        Thu, 12 Mar 2020 10:38:57 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:38:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dt-bindings: amlogic, meson-gx-spicc: add Amlogic G12A compatible" to the spi tree
In-Reply-To:  <20200312133131.26430-9-narmstrong@baylibre.com>
Message-Id:  <applied-20200312133131.26430-9-narmstrong@baylibre.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: dt-bindings: amlogic, meson-gx-spicc: add Amlogic G12A compatible

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From 9ea7db818d9dcbbde581925b82bbe259e1926e20 Mon Sep 17 00:00:00 2001
From: Neil Armstrong <narmstrong@baylibre.com>
Date: Thu, 12 Mar 2020 14:31:30 +0100
Subject: [PATCH] spi: dt-bindings: amlogic, meson-gx-spicc: add Amlogic G12A
 compatible

The Amlogic G12A SPICC controllers uses a secondary clock used to feed the
baud rate generator and the delay control logic.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lore.kernel.org/r/20200312133131.26430-9-narmstrong@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/spi/amlogic,meson-gx-spicc.yaml  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
index 49b617c98ae7..9147df29022a 100644
--- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
+++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
@@ -22,6 +22,7 @@ properties:
     enum:
       - amlogic,meson-gx-spicc # SPICC controller on Amlogic GX and compatible SoCs
       - amlogic,meson-axg-spicc # SPICC controller on Amlogic AXG and compatible SoCs
+      - amlogic,meson-g12a-spicc # SPICC controller on Amlogic G12A and compatible SoCs
 
   interrupts:
     maxItems: 1
@@ -40,6 +41,27 @@ properties:
     items:
       - const: core
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - amlogic,meson-g12a-spicc
+
+then:
+  properties:
+    clocks:
+      contains:
+        items:
+          - description: controller register bus clock
+          - description: baud rate generator and delay control clock
+
+    clock-names:
+      minItems: 2
+      items:
+        - const: core
+        - const: pclk
+
 required:
   - compatible
   - reg
-- 
2.20.1

