Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543F3C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 12:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F8C72071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 12:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="nfJBLKFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbgEWMzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 08:55:19 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:41722 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgEWMzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 08:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1590238514; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=4H5s0QFOM5/H2soQZqt1IUyUDqpcpHgzFYC6TqO7StY=;
        b=nfJBLKFeNz7AabXPcYV/iLwDNAeQUj/6xCxsDCCRKt3OSHSMIUupJDDSQlBbUS+U1DjbLZ
        tB8K6KJJx62eRqHW88tCAyP3Uujqhvc2pieS9RjRUbTeCKOu9stEHYCl0/gQi1WfobKKyx
        V9rmQNUwJR45bjLUZm0MK9TFHbpRZUc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     od@zcrc.me, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] ASoC: ingenic: Unconditionally depend on devicetree
Date:   Sat, 23 May 2020 14:54:55 +0200
Message-Id: <20200523125455.12392-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All boards with Ingenic SoCs probe with devicetree already, we have no
use for a non-devicetree path.

This solves some compilation warnings that were caused by unused
variables in the case where CONFIG_OF was disabled.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reported-by: kbuild test robot <lkp@intel.com>
---
 sound/soc/codecs/Kconfig      | 3 +++
 sound/soc/codecs/jz4725b.c    | 4 +---
 sound/soc/codecs/jz4740.c     | 4 +---
 sound/soc/codecs/jz4770.c     | 2 +-
 sound/soc/jz4740/Kconfig      | 2 +-
 sound/soc/jz4740/jz4740-i2s.c | 4 +---
 6 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index e60e0b6a689c..3a0a6824e278 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -681,6 +681,7 @@ config SND_SOC_CX2072X
 
 config SND_SOC_JZ4740_CODEC
 	depends on MIPS || COMPILE_TEST
+	depends on OF
 	select REGMAP_MMIO
 	tristate "Ingenic JZ4740 internal CODEC"
 	help
@@ -692,6 +693,7 @@ config SND_SOC_JZ4740_CODEC
 
 config SND_SOC_JZ4725B_CODEC
 	depends on MIPS || COMPILE_TEST
+	depends on OF
 	select REGMAP
 	tristate "Ingenic JZ4725B internal CODEC"
 	help
@@ -703,6 +705,7 @@ config SND_SOC_JZ4725B_CODEC
 
 config SND_SOC_JZ4770_CODEC
 	depends on MIPS || COMPILE_TEST
+	depends on OF
 	select REGMAP
 	tristate "Ingenic JZ4770 internal CODEC"
 	help
diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index 2567a5d15b55..e49374c72e70 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -574,19 +574,17 @@ static int jz4725b_codec_probe(struct platform_device *pdev)
 	return ret;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id jz4725b_codec_of_matches[] = {
 	{ .compatible = "ingenic,jz4725b-codec", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, jz4725b_codec_of_matches);
-#endif
 
 static struct platform_driver jz4725b_codec_driver = {
 	.probe = jz4725b_codec_probe,
 	.driver = {
 		.name = "jz4725b-codec",
-		.of_match_table = of_match_ptr(jz4725b_codec_of_matches),
+		.of_match_table = jz4725b_codec_of_matches,
 	},
 };
 module_platform_driver(jz4725b_codec_driver);
diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 460aa1fd1efe..c9900d1cd5c2 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -344,19 +344,17 @@ static int jz4740_codec_probe(struct platform_device *pdev)
 	return ret;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id jz4740_codec_of_matches[] = {
 	{ .compatible = "ingenic,jz4740-codec", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, jz4740_codec_of_matches);
-#endif
 
 static struct platform_driver jz4740_codec_driver = {
 	.probe = jz4740_codec_probe,
 	.driver = {
 		.name = "jz4740-codec",
-		.of_match_table = of_match_ptr(jz4740_codec_of_matches),
+		.of_match_table = jz4740_codec_of_matches,
 	},
 };
 
diff --git a/sound/soc/codecs/jz4770.c b/sound/soc/codecs/jz4770.c
index e7cf2c107607..34775aa62402 100644
--- a/sound/soc/codecs/jz4770.c
+++ b/sound/soc/codecs/jz4770.c
@@ -937,7 +937,7 @@ static struct platform_driver jz4770_codec_driver = {
 	.probe			= jz4770_codec_probe,
 	.driver			= {
 		.name		= "jz4770-codec",
-		.of_match_table = of_match_ptr(jz4770_codec_of_matches),
+		.of_match_table = jz4770_codec_of_matches,
 	},
 };
 module_platform_driver(jz4770_codec_driver);
diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
index e72f826062e9..29144720cb62 100644
--- a/sound/soc/jz4740/Kconfig
+++ b/sound/soc/jz4740/Kconfig
@@ -2,7 +2,7 @@
 config SND_JZ4740_SOC_I2S
 	tristate "SoC Audio (I2S protocol) for Ingenic JZ4740 SoC"
 	depends on MIPS || COMPILE_TEST
-	depends on HAS_IOMEM
+	depends on OF && HAS_IOMEM
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y if you want to use I2S protocol and I2S codec on Ingenic JZ4740
diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 6f6f8dad0356..52460adf6ca1 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -504,7 +504,6 @@ static const struct snd_soc_component_driver jz4740_i2s_component = {
 	.resume		= jz4740_i2s_resume,
 };
 
-#ifdef CONFIG_OF
 static const struct of_device_id jz4740_of_matches[] = {
 	{ .compatible = "ingenic,jz4740-i2s", .data = &jz4740_i2s_soc_info },
 	{ .compatible = "ingenic,jz4760-i2s", .data = &jz4760_i2s_soc_info },
@@ -513,7 +512,6 @@ static const struct of_device_id jz4740_of_matches[] = {
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, jz4740_of_matches);
-#endif
 
 static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 {
@@ -558,7 +556,7 @@ static struct platform_driver jz4740_i2s_driver = {
 	.probe = jz4740_i2s_dev_probe,
 	.driver = {
 		.name = "jz4740-i2s",
-		.of_match_table = of_match_ptr(jz4740_of_matches)
+		.of_match_table = jz4740_of_matches,
 	},
 };
 
-- 
2.26.2

