Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECE2C2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C52920771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgDHS5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:57:05 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42077 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgDHS5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 14:57:05 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MmlfM-1iuNB72mjG-00jo1r; Wed, 08 Apr 2020 20:56:11 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kevin Li <kevin-ke.li@broadcom.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: brcm: fix dma_addr_t cast to pointer
Date:   Wed,  8 Apr 2020 20:55:51 +0200
Message-Id: <20200408185609.332999-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eqXjrTR0pH8tvM3YvyxdWJ7p7tY9GX5onuK1UkDKdf2MzUDRbiz
 epzr0xGSysLzCOxlE5VU0aEdCbkvkEO8Awx5xgNCOip2k4eZD1UaVdLaEOmaMSybFOsEXVk
 RViu3Rhl6uCrecckiU+LAHV96tMrXY8o2zphNQ7s8HWV89T1zaHXdVgexKqwKMLJOHBD44/
 p5uNTReKbixxKkUU3CqrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:saTkIRKQg4o=:LN1fq396PcgVuX7m3vbfBg
 aDfALxrHeoscEQHOKC6NXAXbhEj1fgdMXKYZdKX2z8hEZEIdxSm2xt41heOkgrWwhsojCTqvT
 bYkiyD8aAeAtlIMwpwYA4r5cqXIgOPioY8koW92UYAPyyMlbXMmYhb6zB1jYqU1C8TXNj0y0O
 ZQaiH0IeFSDiLXzMu0i+op4118Mw0wovZ1q1W10kNc9wTrAmLjx+7FySwaEVdcX/dEZorjwYd
 9N+wi/6jgWYUTgqvIWRk6EjxB4vYT1LrnfI44gnROCj2gGKSAVLQukFBGWk2lMmh9aoMjtf1X
 zcGE5No2kx25MimmQrHN6bQNn6T4bCwub/VK+EJhWUM9MaR6C6ioYwfz85QDRAI7fVOyTFH9U
 GQzsUXSIqqMWC4yoPjG0sEfr7M5tg2lj6hoXLle3rAp7gbobPtRcS1rcI8NyOoq7VBvMOjO3K
 O6eihDKGCLnswjyztnM9nqXIoqMb4eUYI+afyZQTGeDlYkNinFOfCwRZvMgUYkS/QG3HZLxLR
 hTmQF48jvx7i+0Pf+0rleBCBwGiAUq57SH4s4MCcP3RK1Ma18iGbmn+m5zGIz97B43qXNpNIO
 erxwU/p0AAJGKZbF0yHgScVtAu3si5tca5wQtxP4t8hjrG6D8kTkknAoaBw2IzMUAuET/ubzX
 mkXb/gsDcMCFJkW9LaFXPfVdqfr5TMBn7xwncQ8vj6dUwTJTofaIl6/gw/zh1V7W14YbDnxvN
 apiP1XsPBKk+/gMCHeNh9qO0nab8DSY8q8FGu4+UoylYOC+KlKa3O/+cej0eK2KNwJg1Mi1Cn
 DiIs4ZDTy4/kN+FO6Sz3P473BE/j8Oo+NZcvATWsVRKyytN7oE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A dma_addr_t is not a pointer and a cast causes a warning when
the sizes are different:

sound/soc/bcm/bcm63xx-pcm-whistler.c: In function 'bcm63xx_pcm_pointer':
sound/soc/bcm/bcm63xx-pcm-whistler.c:184:6: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  184 |  if ((void *)prtd->dma_addr_next == NULL)

Change the comparison to NULL to an equivalent if() check that
does not warn.

Fixes: 88eb404ccc3e ("ASoC: brcm: Add DSL/PON SoC audio driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/bcm/bcm63xx-pcm-whistler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/bcm/bcm63xx-pcm-whistler.c b/sound/soc/bcm/bcm63xx-pcm-whistler.c
index e46c390683e7..b7a1efc7406e 100644
--- a/sound/soc/bcm/bcm63xx-pcm-whistler.c
+++ b/sound/soc/bcm/bcm63xx-pcm-whistler.c
@@ -181,7 +181,7 @@ bcm63xx_pcm_pointer(struct snd_soc_component *component,
 	snd_pcm_uframes_t x;
 	struct bcm63xx_runtime_data *prtd = substream->runtime->private_data;
 
-	if ((void *)prtd->dma_addr_next == NULL)
+	if (!prtd->dma_addr_next)
 		prtd->dma_addr_next = substream->runtime->dma_addr;
 
 	x = bytes_to_frames(substream->runtime,
-- 
2.26.0

