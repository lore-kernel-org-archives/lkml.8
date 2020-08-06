Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE0FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7CE522CB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596739031;
	bh=BBg/4qmHoJQtQA51Qyk1peSStt8JWZO2uvgyLBA4Goc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pLZleGZt946rdaXywDGZTVbF1J6fZzoTB2FGtxooVnmEfFaRsB2RlxOsNBuz8ybYl
	 NH77SrveHOUtcOSU43FJhBVuLt7aS9m7iveiXAmbNuAZIYqL4zn9wQvfxfzHxCKHGY
	 evtAZGx1FLfs+/1AkTQtYTiRSElc4EaBXnLvNIKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgHFShK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:37:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729250AbgHFSgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:36:01 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A2B522DBF;
        Thu,  6 Aug 2020 18:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738193;
        bh=BBg/4qmHoJQtQA51Qyk1peSStt8JWZO2uvgyLBA4Goc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GGWLccR+znsLClyv1ArFPV7Yzj9VljgipB1KYiUEdCBiO2I8qnpHXq21yoWVTlSH3
         3AQ/+CpVKta2K1SZXNlbBd5s3KPZAeFnQa4Ubst6lOoSZNntjNSLzXpE69mQ9ywYxr
         dutADTrPcIn7oGXhONatoO0GIu1Ot+3AjmSzIv/k=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: [PATCH v2 24/41] ASoC: samsung: h1940: turn into platform driver
Date:   Thu,  6 Aug 2020 20:20:41 +0200
Message-Id: <20200806182059.2431-24-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Avoid machine specific headers by using a gpio lookup table
combined with a platform_driver for this board.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/mach-h1940.c | 18 ++++++++
 sound/soc/samsung/h1940_uda1380.c  | 71 ++++++++++--------------------
 2 files changed, 41 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index 9c71472c939f..c7269cd26ba8 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -474,6 +474,22 @@ static struct gpiod_lookup_table h1940_mmc_gpio_table = {
 	},
 };
 
+static struct gpiod_lookup_table h1940_audio_gpio_table = {
+	.dev_id = "h1940-audio",
+	.table = {
+		GPIO_LOOKUP("H1940_LATCH",
+			    H1940_LATCH_AUDIO_POWER - H1940_LATCH_GPIO(0),
+			    "speaker-power", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("GPIOG", 4, "hp", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
+static struct platform_device h1940_audio = {
+	.name = "h1940-audio",
+	.id   = -1,
+};
+
 static struct pwm_lookup h1940_pwm_lookup[] = {
 	PWM_LOOKUP("samsung-pwm", 0, "pwm-backlight", NULL, 36296,
 		   PWM_POLARITY_NORMAL),
@@ -650,6 +666,7 @@ static struct platform_device *h1940_devices[] __initdata = {
 	&s3c_device_ts,
 	&power_supply,
 	&h1940_battery,
+	&h1940_audio,
 };
 
 static void __init h1940_map_io(void)
@@ -689,6 +706,7 @@ static void __init h1940_init(void)
 
 	s3c24xx_fb_set_platdata(&h1940_fb_info);
 	gpiod_add_lookup_table(&h1940_mmc_gpio_table);
+	gpiod_add_lookup_table(&h1940_audio_gpio_table);
 	s3c24xx_mci_set_platdata(&h1940_mmc_cfg);
  	s3c24xx_udc_set_platdata(&h1940_udc_cfg);
 	s3c24xx_ts_set_platdata(&h1940_ts_cfg);
diff --git a/sound/soc/samsung/h1940_uda1380.c b/sound/soc/samsung/h1940_uda1380.c
index b8f0057a0510..8aa78ff640f5 100644
--- a/sound/soc/samsung/h1940_uda1380.c
+++ b/sound/soc/samsung/h1940_uda1380.c
@@ -15,9 +15,6 @@
 #include <sound/jack.h>
 
 #include "regs-iis.h"
-#include <asm/mach-types.h>
-
-#include <mach/gpio-samsung.h>
 #include "s3c24xx-i2s.h"
 
 static const unsigned int rates[] = {
@@ -31,6 +28,8 @@ static const struct snd_pcm_hw_constraint_list hw_rates = {
 	.list = rates,
 };
 
+static struct gpio_desc *gpiod_speaker_power;
+
 static struct snd_soc_jack hp_jack;
 
 static struct snd_soc_jack_pin hp_jack_pins[] = {
@@ -47,7 +46,6 @@ static struct snd_soc_jack_pin hp_jack_pins[] = {
 
 static struct snd_soc_jack_gpio hp_jack_gpios[] = {
 	{
-		.gpio			= S3C2410_GPG(4),
 		.name			= "hp-gpio",
 		.report			= SND_JACK_HEADPHONE,
 		.invert			= 1,
@@ -123,9 +121,9 @@ static int h1940_spk_power(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *kcontrol, int event)
 {
 	if (SND_SOC_DAPM_EVENT_ON(event))
-		gpio_set_value(S3C_GPIO_END + 9, 1);
+		gpiod_set_value(gpiod_speaker_power, 1);
 	else
-		gpio_set_value(S3C_GPIO_END + 9, 0);
+		gpiod_set_value(gpiod_speaker_power, 0);
 
 	return 0;
 }
@@ -151,8 +149,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"VINM", NULL, "Mic Jack"},
 };
 
-static struct platform_device *s3c24xx_snd_device;
-
 static int h1940_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 {
 	snd_soc_card_jack_new(rtd->card, "Headphone Jack", SND_JACK_HEADPHONE,
@@ -194,55 +190,34 @@ static struct snd_soc_card h1940_asoc = {
 	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
-static int __init h1940_init(void)
+static int h1940_probe(struct platform_device *pdev)
 {
-	int ret;
+	struct device *dev = &pdev->dev;
 
-	if (!machine_is_h1940())
-		return -ENODEV;
+	h1940_asoc.dev = dev;
+	hp_jack_gpios[0].gpiod_dev = dev;
+	gpiod_speaker_power = devm_gpiod_get(&pdev->dev, "speaker-power",
+					     GPIOD_OUT_LOW);
 
-	/* configure some gpios */
-	ret = gpio_request(S3C_GPIO_END + 9, "speaker-power");
-	if (ret)
-		goto err_out;
-
-	ret = gpio_direction_output(S3C_GPIO_END + 9, 0);
-	if (ret)
-		goto err_gpio;
-
-	s3c24xx_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!s3c24xx_snd_device) {
-		ret = -ENOMEM;
-		goto err_gpio;
+	if (IS_ERR(gpiod_speaker_power)) {
+		dev_err(dev, "Could not get gpio\n");
+		return PTR_ERR(gpiod_speaker_power);
 	}
 
-	platform_set_drvdata(s3c24xx_snd_device, &h1940_asoc);
-	ret = platform_device_add(s3c24xx_snd_device);
-
-	if (ret)
-		goto err_plat;
-
-	return 0;
-
-err_plat:
-	platform_device_put(s3c24xx_snd_device);
-err_gpio:
-	gpio_free(S3C_GPIO_END + 9);
-
-err_out:
-	return ret;
-}
-
-static void __exit h1940_exit(void)
-{
-	platform_device_unregister(s3c24xx_snd_device);
-	gpio_free(S3C_GPIO_END + 9);
+	return devm_snd_soc_register_card(dev, &h1940_asoc);
 }
 
-module_init(h1940_init);
-module_exit(h1940_exit);
+static struct platform_driver h1940_audio_driver = {
+	.driver = {
+		.name = "h1940-audio",
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = h1940_probe,
+};
+module_platform_driver(h1940_audio_driver);
 
 /* Module information */
 MODULE_AUTHOR("Arnaud Patard, Vasily Khoruzhick");
 MODULE_DESCRIPTION("ALSA SoC H1940");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:h1940-audio");
-- 
2.17.1

