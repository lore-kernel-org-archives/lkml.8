Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9523C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BA72082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgBLO5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:57:05 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:51952 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgBLO5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:57:04 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id 1qwu2200V5USYZQ01qwuij; Wed, 12 Feb 2020 15:57:02 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1tRe-0004yt-OW; Wed, 12 Feb 2020 15:56:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1tRe-0001Dk-NQ; Wed, 12 Feb 2020 15:56:54 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/3] ASoC: Fix SND_SOC_ALL_CODECS imply misc fallout
Date:   Wed, 12 Feb 2020 15:56:50 +0100
Message-Id: <20200212145650.4602-4-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212145650.4602-1-geert@linux-m68k.org>
References: <20200212145650.4602-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 sound/soc/codecs/Kconfig | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 3ef804d07deea41d..d957fd6980b10a92 100644
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
2.17.1

