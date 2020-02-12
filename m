Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19416C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89B324672
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581551829;
	bh=04022Z+GhRss93ALaWrVLdBePoZNbpSZXrK1QnQKf10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=WnZfl9iYiI3FLOmBJp4A7cH19Bl+zBsOHuIH7mmplQaE5eWv4vZE9bmI+/XgGoTeq
	 hx7AV2L/Repoqf0H0aSgqi8koEWXa0rI5LtQmMHvhF8XHv6oTORwc1kbQAaXzxmGh+
	 HCOKEnJYc/nDkHXT/K9s9Osnl7bj/c3Vtbg6O6fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgBLX5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:57:09 -0500
Received: from foss.arm.com ([217.140.110.172]:39678 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgBLX5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:57:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2F4F328;
        Wed, 12 Feb 2020 15:57:07 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35CCE3F68E;
        Wed, 12 Feb 2020 15:57:07 -0800 (PST)
Date:   Wed, 12 Feb 2020 23:57:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: Fix SND_SOC_ALL_CODECS imply misc fallout" to the asoc tree
In-Reply-To: <20200212145650.4602-4-geert@linux-m68k.org>
Message-Id: <applied-20200212145650.4602-4-geert@linux-m68k.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Fix SND_SOC_ALL_CODECS imply misc fallout

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

From d8dd3f92a6ba11f9046df48765e6f12ad70a3946 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Feb 2020 15:56:50 +0100
Subject: [PATCH] ASoC: Fix SND_SOC_ALL_CODECS imply misc fallout

Fixes for missing miscellaneous support:

    ERROR: "abx500_get_register_interruptible" [...] undefined!
    ERROR: "abx500_set_register_interruptible" [...] undefined!
    ERROR: "arizona_free_irq" [...] undefined!
    ERROR: "arizona_request_irq" [...] undefined!
    ERROR: "arizona_set_irq_wake" [...] undefined!
    ERROR: "mc13xxx_reg_rmw" [...] undefined!
    ERROR: "mc13xxx_reg_write" [...] undefined!
    ERROR: "snd_soc_free_ac97_component" [...] undefined!
    ERROR: "snd_soc_new_ac97_component" [...] undefined!

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: ea00d95200d02ece ("ASoC: Use imply for SND_SOC_ALL_CODECS")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/r/20200212145650.4602-4-geert@linux-m68k.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 3ef804d07dee..d957fd6980b1 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -319,6 +319,7 @@ config SND_SOC_WM_ADSP
 
 config SND_SOC_AB8500_CODEC
 	tristate
+	depends on ABX500_CORE
 
 config SND_SOC_AC97_CODEC
 	tristate "Build generic ASoC AC97 CODEC driver"
@@ -343,8 +344,9 @@ config SND_SOC_AD193X_I2C
 	select SND_SOC_AD193X
 
 config SND_SOC_AD1980
-	select REGMAP_AC97
 	tristate
+	depends on SND_SOC_AC97_BUS
+	select REGMAP_AC97
 
 config SND_SOC_AD73311
 	tristate
@@ -646,6 +648,7 @@ config SND_SOC_CS47L15
 
 config SND_SOC_CS47L24
 	tristate
+	depends on MFD_CS47L24
 
 config SND_SOC_CS47L35
 	tristate
@@ -1234,6 +1237,7 @@ config SND_SOC_STA529
 
 config SND_SOC_STAC9766
 	tristate
+	depends on SND_SOC_AC97_BUS
 
 config SND_SOC_STI_SAS
 	tristate "codec Audio support for STI SAS codec"
@@ -1415,9 +1419,11 @@ config SND_SOC_WM5100
 
 config SND_SOC_WM5102
 	tristate
+	depends on MFD_WM5102
 
 config SND_SOC_WM5110
 	tristate
+	depends on MFD_WM5110
 
 config SND_SOC_WM8350
 	tristate
@@ -1579,9 +1585,11 @@ config SND_SOC_WM8996
 
 config SND_SOC_WM8997
 	tristate
+	depends on MFD_WM8997
 
 config SND_SOC_WM8998
 	tristate
+	depends on MFD_WM8998
 
 config SND_SOC_WM9081
 	tristate
@@ -1639,6 +1647,7 @@ config SND_SOC_MAX9877
 
 config SND_SOC_MC13783
 	tristate
+	depends on MFD_MC13XXX
 
 config SND_SOC_ML26124
 	tristate
-- 
2.20.1

