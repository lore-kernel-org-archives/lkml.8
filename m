Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C84DC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABD2206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584116239;
	bh=MronHSxo0fS39DoROCWhQlbbol1jvXD0+EePLi6Q6RE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=pWJ4j38sMFUeabKX3jpn5nIEoXYV2MUijFroafgz0YRdvWIW2Go7U0Ac8/jxegv/a
	 R+5EAxB4kfEIxDQIqHD75uUqL456+tEG5Im1T+a9AZHKN5NHnWBIXPlJ68wsTw2kv/
	 WniK2s4mWOBxdnsivACiHCfaic9PK5pPoaFl13kY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgCMQRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:17:18 -0400
Received: from foss.arm.com ([217.140.110.172]:60424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgCMQRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:17:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E75EC31B;
        Fri, 13 Mar 2020 09:17:16 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B2433F6CF;
        Fri, 13 Mar 2020 09:17:16 -0700 (PDT)
Date:   Fri, 13 Mar 2020 16:17:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kevin Li <kevin-ke.li@broadcom.com>
Cc:     alsa-devel@alsa-project.org, bcm-kernel-feedback-list@broadcom.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: brcm: DSL/PON SoC device tree bindings of audio driver" to the asoc tree
In-Reply-To:  <20200312223242.2843-1-kevin-ke.li@broadcom.com>
Message-Id:  <applied-20200312223242.2843-1-kevin-ke.li@broadcom.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: brcm: DSL/PON SoC device tree bindings of audio driver

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

From 2834a736371eab06182fcdfb0c32d23d34068764 Mon Sep 17 00:00:00 2001
From: Kevin Li <kevin-ke.li@broadcom.com>
Date: Thu, 12 Mar 2020 15:32:40 -0700
Subject: [PATCH] ASoC: brcm: DSL/PON SoC device tree bindings of audio driver

Signed-off-by: Kevin Li <kevin-ke.li@broadcom.com>
Link: https://lore.kernel.org/r/20200312223242.2843-1-kevin-ke.li@broadcom.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/brcm,bcm63xx-audio.txt     | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/brcm,bcm63xx-audio.txt

diff --git a/Documentation/devicetree/bindings/sound/brcm,bcm63xx-audio.txt b/Documentation/devicetree/bindings/sound/brcm,bcm63xx-audio.txt
new file mode 100644
index 000000000000..007f524b4d15
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/brcm,bcm63xx-audio.txt
@@ -0,0 +1,29 @@
+Broadcom DSL/PON BCM63xx Audio I2S controller
+
+Required properties:
+- compatible:     Should be "brcm,bcm63xx-i2s".
+- #address-cells: 32bit valued, 1 cell.
+- #size-cells:    32bit valued, 0 cell.
+- reg:            Should contain audio registers location and length
+- interrupts:     Should contain the interrupt for the controller.
+- clocks:         Must contain an entry for each entry in clock-names.
+                  Please refer to clock-bindings.txt.
+- clock-names:    One of each entry matching the clocks phandles list:
+                  - "i2sclk" (generated clock) Required.
+                  - "i2sosc" (fixed 200MHz clock) Required.
+
+(1) : The generated clock is required only when any of TX and RX
+      works on Master Mode.
+(2) : The fixed 200MHz clock is from internal chip and always on
+
+Example:
+
+		i2s: bcm63xx-i2s {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm63xx-i2s";
+			reg = <0xFF802080 0xFF>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&i2sclk>, <&osc>;
+			clock-names = "i2sclk","i2sosc";
+		};
-- 
2.20.1

