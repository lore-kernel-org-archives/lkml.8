Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A4BC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48472084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgBDNTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:19:02 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:45196 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgBDNTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:19:01 -0500
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id ydJy210175USYZQ06dJzbo; Tue, 04 Feb 2020 14:18:59 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iyy6U-0005H5-SS; Tue, 04 Feb 2020 14:18:58 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iyy6U-0001zr-P5; Tue, 04 Feb 2020 14:18:58 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] ASoC: wcd934x: Add missing COMMON_CLK dependency to SND_SOC_ALL_CODECS
Date:   Tue,  4 Feb 2020 14:18:57 +0100
Message-Id: <20200204131857.7634-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just adding a dependency on COMMON_CLK to SND_SOC_WCD934X is not
sufficient, as enabling SND_SOC_ALL_CODECS will still select it,
breaking the build later:

    WARNING: unmet direct dependencies detected for SND_SOC_WCD934X
      Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && COMMON_CLK [=n] && MFD_WCD934X [=m]
      Selected by [m]:
      - SND_SOC_ALL_CODECS [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && COMPILE_TEST [=y] && MFD_WCD934X [=m]
    ...
    ERROR: "of_clk_add_provider" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!
    ERROR: "of_clk_src_simple_get" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!
    ERROR: "clk_hw_register" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!
    ERROR: "__clk_get_name" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!

Fix this by adding the missing dependency to SND_SOC_ALL_CODECS

Fixes: 42b716359beca106 ("ASoC: wcd934x: Add missing COMMON_CLK dependency")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Seen with e.g. m68k/allmodconfig.
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 2865148659600346..7e90f5d830971309 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -214,7 +214,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_UDA134X
 	select SND_SOC_UDA1380 if I2C
 	select SND_SOC_WCD9335 if SLIMBUS
-	select SND_SOC_WCD934X if MFD_WCD934X
+	select SND_SOC_WCD934X if MFD_WCD934X && COMMON_CLK
 	select SND_SOC_WL1273 if MFD_WL1273_CORE
 	select SND_SOC_WM0010 if SPI_MASTER
 	select SND_SOC_WM1250_EV1 if I2C
-- 
2.17.1

