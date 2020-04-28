Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E7CC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9EC92072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgD1VxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:53:21 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:52425 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgD1VxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:53:20 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MNbtD-1joGmV3G95-00P4Gf; Tue, 28 Apr 2020 23:46:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild test robot <lkp@intel.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Fitzgerald <rf@opensource.wolfsonmicro.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rt5682: fix I2C/Soundwire dependencies
Date:   Tue, 28 Apr 2020 23:46:14 +0200
Message-Id: <20200428214642.3925004-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LjpCd0o0srZhlkXmKTYqi2kzkFjj8wOMi3UgGvZfhHwihrM2ZVK
 po+jmWaIRXwaEFPAix4bogG21pyYWTA+mjs+9fJP7UQkVRxcH099TCrSRRrDi2zbSW3q6fH
 aBP1db4kBRs2/IQtjmZPXOXXW9bJN+qqAuialfeXrl4bYwkfWYhxGD6X5GE7NBtKxHJhoNw
 YBnj+zR/OD1wyM18k0xUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HYoyrD0Ue6w=:BXj4wZR0Lv+12HKpBsqM17
 np4UgAR2bidZI702Fck5rWtV6f30t+cY2Z1h1Mdp+pK/u2oU7VY2mIAGENzf0X8pWAkE9HkB4
 ldiYe6sgTeOmULgYtTA/02n+BW9cMik3hhkNUIBz+HXbv/s9wZfFafAmVj8a54X7ooMw7/7UN
 ek3qXmLzVjY+daiUpZa4h7scwPxmyozfe6NTil/tG+2/BFFojwQOdFf2NPZ0sRt0sTgnzohwf
 5OmAabCtDjl4u3WBwDHfL0dzMKNlSSOtN0jJf3nSPEfZ9teWREUOcdHoVmeQPSqUdTNkhFmHo
 HTUN2FuRpzZRFmiMbk1FBoIbzB/NwT0F3g6BZKlDY9CwDfLrIwtLJbYnWKL1tEyJ9UDZAMxeg
 tt3xddjus2dUsFbRcfK/OdXBuERHinRovIxU6eQtBw7iiPXBad734hDr2Nn7HKU5y7/s4K4iT
 o7CAT8oo1SVtkOL6gOIeGcqQcKClDdY3kdmFrCGW7Z6fIwBxpSUROTzT4rtschARW0FweaJ9D
 70loHcBinHpDL1hqW3ttSHxgGZrcJ2RWjs5UTTMobsWaR2OJSzQF9LWf/vrRcUPn84Azh8bAK
 33boGdmdv1reOFemwApMxY+uqBkOiBf1uKG0EAq3qp291pJWGbkhHqLpljwuiA4tlIcUzaWMi
 FFloM5xVecN5uhQu0NnplgCdyuBUt5WTADQGIDePXhOlLN6mA6qHoPnq1oLfQbgZ3/YjNzwG1
 KOwzOmayjyUJyRYo7SM8gpE0x05V7am5Io6uDZLu8+2tE50j9OHtDZODoixjFf9N6tNYYNItB
 wnuq+nglwCGDY633oQyCC072krANYMM7kLjuMB7WJ6RA+8L8BA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If one of the two is a loadable module, the combined driver must
not be built-in:

aarch64-linux-ld: sound/soc/codecs/rt5682.o: in function `rt5682_sdw_hw_free':
rt5682.c:(.text+0xb34): undefined reference to `sdw_stream_remove_slave'
aarch64-linux-ld: sound/soc/codecs/rt5682.o: in function `rt5682_sdw_hw_params':
rt5682.c:(.text+0xe78): undefined reference to `sdw_stream_add_slave'

In particular, the soundwire driver must not be built-in if
CONFIG_I2C=m.

Fixes: 5549ea647997 ("ASoC: rt5682: fix unmet dependencies")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 1ce76f04c154..d911956c591d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1137,10 +1137,13 @@ config SND_SOC_RT5677_SPI
 config SND_SOC_RT5682
 	tristate
 	depends on I2C || SOUNDWIRE
+	depends on SOUNDWIRE || !SOUNDWIRE
+	depends on I2C || !I2C
 
 config SND_SOC_RT5682_SDW
 	tristate "Realtek RT5682 Codec - SDW"
 	depends on SOUNDWIRE
+	depends on I2C || !I2C
 	select SND_SOC_RT5682
 	select REGMAP_SOUNDWIRE
 
-- 
2.26.0

