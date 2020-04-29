Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EEDC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 016702064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgD2TDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:03:01 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:58125 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2TDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:03:00 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MLRDv-1jlfhp0Uz5-00IWDA; Wed, 29 Apr 2020 21:02:18 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: opti9xx: shut up gcc-10 range warning
Date:   Wed, 29 Apr 2020 21:02:03 +0200
Message-Id: <20200429190216.85919-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+pDqwisosq8IRMVZs9c7qvMueRcXlRjdnVdd/4nRecwJrh6oDHT
 Hk2Bj3hLCzMNMvJv5ipHRa0YzqmfJVD5xHFL8KaWvVWN35+kdWmb2gpK+sePVacbkQrr5nQ
 azKLanUlr1s5veUtSELmvDYCpNSUPW+dn4tPimfRra0N/Z9W2M4XSn4ht86XufpMjpB89bo
 t3GO9kGViXWXGNMtR4J0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9cO2hF9lnlU=:/v7dR+GNPbFvFEJ1vkKpKS
 wxaE29IFQ8i4X/RNJk3qQBnKMPsfw/dBIykU/RpE94huZCjxIuEuI8mHvmuK2A64sS9lY7e+W
 Jxlo1vrWI930gBbR1qIPvdrYE8NiO8QadB+yGE4O2+JCydkw20/yYxaH11nx4uQjwMrjl3Rag
 39Lo/vbX9R97KI3FwOQWKsrAZBUZ60WUwBeGbEGdNU/SNOcazbQgMw0C3tWHX4yJoIJPgzACE
 GsoGOZl/n0aatAENgvTvMG+/FGzWW1m5c418qVK+SgMaFghvMW81tvdjb9BT57+OaKC1m604g
 q98VuycwUTnCuakAqKnq3vTLZ40xyyd9KIwinX6jPsh1nN1TTOG8Pz9EOCx4qK/Ur1oZOwSRf
 nuFBmgxE/HqGMKgysxqvmjXHGwReXx4TwVp32rjONRbu5Zk7L19npgclts1BK0AVdtJwVpV6Q
 u8QugluZn0yPwQKDdlp8mh75jl4ZTw63snCWBRbSPbWKdNwaJ+KHT08mUYHdrpkXaZNuLKyAi
 aimjTmHuxsAJ7iTfh7gFTdrH4+mTbYmFkdS6IcnGPxHmQe1/4K/RvtodHCMM57IoCiHhlfkll
 mqYO7OfuQQKH6ycavc4CG07pDLpDDnXNwYiEUkFIvPh8cKTjASTutzEyTW4bbE3pcNzVSqagg
 uww/RNxxMa1dMWT+WXiuGcE5SEr2UFNP4y8+d4Vlp01XdQ3AFUZVBOlJtXw3XQ62oIfhpy/m5
 ABbnFWBCQOqT/C6YwkzrKHSVxIvQfWYd3H7yHHg0RvvDdGEFLi2I2OYc7SQEN+y9134fL5KMW
 fxqRVo5+RVqiKAT4u/lJbm522qA9y/kzNsE3oAOHPuCMQnGOmg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-10 points out a few instances of suspicious integer arithmetic
leading to value truncation:

sound/isa/opti9xx/opti92x-ad1848.c: In function 'snd_opti9xx_configure':
sound/isa/opti9xx/opti92x-ad1848.c:322:43: error: overflow in conversion from 'int' to 'unsigned char' changes value from '(int)snd_opti9xx_read(chip, 3) & -256 | 240' to '240' [-Werror=overflow]
  322 |   (snd_opti9xx_read(chip, reg) & ~(mask)) | ((value) & (mask)))
      |   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
sound/isa/opti9xx/opti92x-ad1848.c:351:3: note: in expansion of macro 'snd_opti9xx_write_mask'
  351 |   snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(3), 0xf0, 0xff);
      |   ^~~~~~~~~~~~~~~~~~~~~~
sound/isa/opti9xx/miro.c: In function 'snd_miro_configure':
sound/isa/opti9xx/miro.c:873:40: error: overflow in conversion from 'int' to 'unsigned char' changes value from '(int)snd_miro_read(chip, 3) & -256 | 240' to '240' [-Werror=overflow]
  873 |   (snd_miro_read(chip, reg) & ~(mask)) | ((value) & (mask)))
      |   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
sound/isa/opti9xx/miro.c:1010:3: note: in expansion of macro 'snd_miro_write_mask'
 1010 |   snd_miro_write_mask(chip, OPTi9XX_MC_REG(3), 0xf0, 0xff);
      |   ^~~~~~~~~~~~~~~~~~~

These are all harmless here as only the low 8 bit are passed down
anyway. Change the macros to inline functions to make the code
more readable and also avoid the warning.

Strictly speaking those functions also need locking to make the
read/write pair atomic, but it seems unlikely that anyone would
still run into that issue.

Fixes: 1841f613fd2e ("[ALSA] Add snd-miro driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/isa/opti9xx/miro.c           | 9 ++++++---
 sound/isa/opti9xx/opti92x-ad1848.c | 9 ++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index e764816a8f7a..b039429e6871 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -867,10 +867,13 @@ static void snd_miro_write(struct snd_miro *chip, unsigned char reg,
 	spin_unlock_irqrestore(&chip->lock, flags);
 }
 
+static inline void snd_miro_write_mask(struct snd_miro *chip,
+		unsigned char reg, unsigned char value, unsigned char mask)
+{
+	unsigned char oldval = snd_miro_read(chip, reg);
 
-#define snd_miro_write_mask(chip, reg, value, mask)	\
-	snd_miro_write(chip, reg,			\
-		(snd_miro_read(chip, reg) & ~(mask)) | ((value) & (mask)))
+	snd_miro_write(chip, reg, (oldval & ~mask) | (value & mask));
+}
 
 /*
  *  Proc Interface
diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index d06b29693c85..0e6d20e49158 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -317,10 +317,13 @@ static void snd_opti9xx_write(struct snd_opti9xx *chip, unsigned char reg,
 }
 
 
-#define snd_opti9xx_write_mask(chip, reg, value, mask)	\
-	snd_opti9xx_write(chip, reg,			\
-		(snd_opti9xx_read(chip, reg) & ~(mask)) | ((value) & (mask)))
+static inline void snd_opti9xx_write_mask(struct snd_opti9xx *chip,
+		unsigned char reg, unsigned char value, unsigned char mask)
+{
+	unsigned char oldval = snd_opti9xx_read(chip, reg);
 
+	snd_opti9xx_write(chip, reg, (oldval & ~mask) | (value & mask));
+}
 
 static int snd_opti9xx_configure(struct snd_opti9xx *chip,
 					   long port,
-- 
2.26.0

