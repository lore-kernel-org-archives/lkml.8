Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B335C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA86206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgD1V1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:27:50 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:59475 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgD1V1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:27:50 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MbRbr-1isGzy40yX-00bpfL; Tue, 28 Apr 2020 23:27:24 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.wolfsonmicro.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: codecs: wm97xx: fix ac97 dependency
Date:   Tue, 28 Apr 2020 23:26:59 +0200
Message-Id: <20200428212721.2877627-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:plHfexjdZVApeeYxLAvg4KGlWurVjoh6zwIn/tqrNJ5GenZjv/D
 SOu3gT/FHq9H3n8SpVLPKq+EbuaBFtJ6QBzwtP6ZjS34IK/AT9+Nxt9nJ8oSR56KSiHo0Hm
 L3qi0f1qKGLoRsZs3njFLrEyXHxyK1WXGUJ/mouBSnUypfoDwLbq/cuJXm+54CE29n3hy3k
 aXUa6i6o9nMgvGCs0mdjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6spdvlTUeP4=:ezGBOGOkfKs5xXi84nOUKK
 vc3TdvTCvmW/yAb4yr55mTZWG61nWuvHBGmNSE7CLJJFF/bTyOYxtG1DzMLl1ktUM9FqVTJ95
 Yv38MCHBZn83CLUHzOiHeOVZdK+pWyKru8uuiC16WZdePnXK8FOl+T0/PHnJs+c6YIt53NqD+
 7aNZdUE6iAeew1k3KkzXQsN353depZcnaOiK+Ku2zR0G+3mlydcu7rW2DHWxm6k1loTLe9HpT
 txsQuAK70neviPr8jDhirqEzFVd+2/uoBEL5PmXTuCWi2MSIg7zd+AvB3x4WUsY1de2iSm99P
 UCiXK7vWUd7qEYpUSEvNpYlMdmegyyDIWjKi5B0a6254+RkPRfeAbXq4KwRrZwMo8EJwpY4W8
 DiUMe6nync6UcUUzbQE+AvmpC3rCC+r+xmirsyW3ciC3giX2mRqrxWHWsUSyDfzZPTvShpoQr
 Q/HCe+t74s6/Bv13UOe0+jA1jBYE1J5RnZqnAF1Qh4p83r4zg54CrEe7Ufy3m7N61V/UbzGZr
 1wsnXXbvXXHRriyf1XqHm3/i7PuzEQ8k3uGxSDUpZXLP0yhhtx2WdILaOeg4QOMDjYnnvDdvm
 1wQjrg+mNgP8a+xEQNjDhPjMDRRqT3s1Qr5ohJ0YYOjAP29xx329V06msEP3uFCQyOxA6qQDg
 K2W3Skq5pfVW8IYlZelxnZso1AOcKN9gEDKmKnwktHpxZCaxxM5AAZVg6PDMda2FyErn5VOS0
 6cbcHJrJyAqhOdHd6/9QyFumRW2ZXftFKhRWkdOv9LMJVJ6Q8aSUfUe/AA0SPPbjVnIphCjcU
 33eo6blx+kl/RxzQncsMrBgV/cScD5B+roxASW84z8Vd/UBO3w=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent build fix got the dependency slightly wrong, breaking
builds with CONFIG_AC97_BUS_NEW:

WARNING: unmet direct dependencies detected for SND_SOC_WM9713
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AC97_BUS [=n]
  Selected by [m]:
  - SND_SOC_ZYLONITE [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_PXA2XX_SOC [=m] && MACH_ZYLONITE [=y] && AC97_BUS [=n]=n

WARNING: unmet direct dependencies detected for SND_SOC_WM9712
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AC97_BUS [=n]
  Selected by [m]:
  - SND_PXA2XX_SOC_EM_X270 [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_PXA2XX_SOC [=m] && (MACH_EM_X270 [=n] || MACH_EXEDA [=n] || MACH_CM_X300 [=y]) && AC97_BUS [=n]=n

Change the dependency to allow either version of the AC97 library
code.

Fixes: 5a309875787d ("ASoC: Fix SND_SOC_ALL_CODECS imply ac97 fallout")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 1de97680858f..d911956c591d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1626,19 +1626,19 @@ config SND_SOC_WM9090
 
 config SND_SOC_WM9705
 	tristate
-	depends on SND_SOC_AC97_BUS
+	depends on SND_SOC_AC97_BUS || AC97_BUS_NEW
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
 config SND_SOC_WM9712
 	tristate
-	depends on SND_SOC_AC97_BUS
+	depends on SND_SOC_AC97_BUS || AC97_BUS_NEW
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
 config SND_SOC_WM9713
 	tristate
-	depends on SND_SOC_AC97_BUS
+	depends on SND_SOC_AC97_BUS || AC97_BUS_NEW
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
-- 
2.26.0

