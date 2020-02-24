Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8922DC35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685EE20732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgBXLZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:25:48 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:36400 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXLZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:25:47 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id 6bRe2200c5USYZQ01bReUi; Mon, 24 Feb 2020 12:25:45 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j6Brm-0003AP-QG; Mon, 24 Feb 2020 12:25:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j6Brm-0003mM-NM; Mon, 24 Feb 2020 12:25:38 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] ASoC: Fix SND_SOC_ALL_CODECS imply ac97 fallout
Date:   Mon, 24 Feb 2020 12:25:37 +0100
Message-Id: <20200224112537.14483-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i386 randconfig:

    sound/soc/codecs/wm9705.o: In function `wm9705_soc_resume':
    wm9705.c:(.text+0x128): undefined reference to `snd_ac97_reset'
    sound/soc/codecs/wm9712.o: In function `wm9712_soc_resume':
    wm9712.c:(.text+0x2d1): undefined reference to `snd_ac97_reset'
    sound/soc/codecs/wm9713.o: In function `wm9713_soc_resume':
    wm9713.c:(.text+0x820): undefined reference to `snd_ac97_reset'

Fix this by adding the missing dependencies on SND_SOC_AC97_BUS.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Before commit ea00d95200d02ece ("ASoC: Use imply for
SND_SOC_ALL_CODECS"), SND_SOC_ALL_CODECS used:

    select SND_SOC_WM9705 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
    select SND_SOC_WM9712 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
    select SND_SOC_WM9713 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)

but SND_SOC_AC97_BUS_NEW never existed in upstream.
Should there be another dependency>

See also "non-existent SND_SOC_AC97_BUS_NEW (was: Re: [PATCH v9] ASoC:
pxa: switch to new ac97 bus support)"
http://lore.kernel.org/r/CAMuHMdU3uxfBwKd8SkOtZSDV5Ai3CKc3CWRhDy0Cz94T1Hn0iA@mail.gmail.com
---
 sound/soc/codecs/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9e9d54e4576ce5ba..a7e89567edbe8b47 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1610,16 +1610,19 @@ config SND_SOC_WM9090
 
 config SND_SOC_WM9705
 	tristate
+	depends on SND_SOC_AC97_BUS
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
 config SND_SOC_WM9712
 	tristate
+	depends on SND_SOC_AC97_BUS
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
 config SND_SOC_WM9713
 	tristate
+	depends on SND_SOC_AC97_BUS
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
-- 
2.17.1

