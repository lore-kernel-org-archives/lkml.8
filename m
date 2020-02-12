Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E5FC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A0720714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgBLO45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:56:57 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:38052 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgBLO45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:56:57 -0500
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id 1qwu2200e5USYZQ01qwuw1; Wed, 12 Feb 2020 15:56:55 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1tRe-0004yr-Nr; Wed, 12 Feb 2020 15:56:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1tRe-0001DZ-Mm; Wed, 12 Feb 2020 15:56:54 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/3] ASoC: Fix SND_SOC_ALL_CODECS imply I2C fallout
Date:   Wed, 12 Feb 2020 15:56:49 +0100
Message-Id: <20200212145650.4602-3-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212145650.4602-1-geert@linux-m68k.org>
References: <20200212145650.4602-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes for CONFIG_I2C=n:

    WARNING: unmet direct dependencies detected for REGMAP_I2C
      Depends on [n]: I2C [=n]
      Selected by [m]:
      - SND_SOC_ADAU1781_I2C [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m]
      - SND_SOC_ADAU1977_I2C [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m]
      - SND_SOC_RT5677 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m]

    sound/soc/codecs/...: error: type defaults to ‘int’ in declaration of ‘module_i2c_driver’ [-Werror=implicit-int]

    drivers/base/regmap/regmap-i2c.c: In function ‘regmap_smbus_byte_reg_read’:
    drivers/base/regmap/regmap-i2c.c:25:8: error: implicit declaration of function ‘i2c_smbus_read_byte_data’; did you mean ‘i2c_set_adapdata’? [-Werror=implicit-function-declaration]

Fixes: ea00d95200d02ece ("ASoC: Use imply for SND_SOC_ALL_CODECS")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 sound/soc/codecs/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c2fb985de8c4e02a..3ef804d07deea41d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -339,6 +339,7 @@ config SND_SOC_AD193X_SPI
 
 config SND_SOC_AD193X_I2C
 	tristate
+	depends on I2C
 	select SND_SOC_AD193X
 
 config SND_SOC_AD1980
@@ -353,6 +354,7 @@ config SND_SOC_ADAU_UTILS
 
 config SND_SOC_ADAU1373
 	tristate
+	depends on I2C
 	select SND_SOC_ADAU_UTILS
 
 config SND_SOC_ADAU1701
@@ -387,6 +389,7 @@ config SND_SOC_ADAU1781
 
 config SND_SOC_ADAU1781_I2C
 	tristate
+	depends on I2C
 	select SND_SOC_ADAU1781
 	select REGMAP_I2C
 
@@ -407,6 +410,7 @@ config SND_SOC_ADAU1977_SPI
 
 config SND_SOC_ADAU1977_I2C
 	tristate
+	depends on I2C
 	select SND_SOC_ADAU1977
 	select REGMAP_I2C
 
@@ -450,6 +454,7 @@ config SND_SOC_ADAV801
 
 config SND_SOC_ADAV803
 	tristate
+	depends on I2C
 	select SND_SOC_ADAV80X
 
 config SND_SOC_ADS117X
@@ -471,6 +476,7 @@ config SND_SOC_AK4458
 
 config SND_SOC_AK4535
 	tristate
+	depends on I2C
 
 config SND_SOC_AK4554
 	tristate "AKM AK4554 CODEC"
@@ -481,6 +487,7 @@ config SND_SOC_AK4613
 
 config SND_SOC_AK4641
 	tristate
+	depends on I2C
 
 config SND_SOC_AK4642
 	tristate "AKM AK4642 CODEC"
@@ -488,6 +495,7 @@ config SND_SOC_AK4642
 
 config SND_SOC_AK4671
 	tristate
+	depends on I2C
 
 config SND_SOC_AK5386
 	tristate "AKM AK5638 CODEC"
@@ -1112,6 +1120,7 @@ config SND_SOC_RT5670
 
 config SND_SOC_RT5677
 	tristate
+	depends on I2C
 	select REGMAP_I2C
 	select REGMAP_IRQ
 
-- 
2.17.1

