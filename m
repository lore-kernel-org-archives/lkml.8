Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7564C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3037C22D00
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596739036;
	bh=mPsC61lMZKmtzeLxo601e47DlSg2SAAoFQgjc4SYv8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f1qy03Z40WVEY4Ir7jWRVr24t3Xl0DMCC0nz0yufFIR5Y0Lw6oERbcJmAjNdX4ndm
	 ck5A6DMj+eB01QOqGfw3Oz1/5SO/hEladluu4SJfygKcL5xZyLzNnmjn4o+p5ZtC55
	 cts4QHJOM7RUld1pZRl8VvTKIobnndfvn4gKvbS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgHFShO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729277AbgHFSf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:35:59 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F5F822DA7;
        Thu,  6 Aug 2020 18:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738201;
        bh=mPsC61lMZKmtzeLxo601e47DlSg2SAAoFQgjc4SYv8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o3fhH0niDfjMM09Vzx/0teVjpyo+Nhlg9HvKFFa582tyrB5jzqOMQZGtqYlYakm/u
         Un2t3ZKkAd3r4V59qdigc4NxmGn6gi7TgSQeyxY3CjyXCDLa8PRM4MYwDFrZ9P17pj
         xoB+z2V0hITRznxzE5WRaKXmEb6fwq4bdCmo5pTQ=
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
Subject: [PATCH v2 26/41] ASoC: samsung: rx1950: turn into platform driver
Date:   Thu,  6 Aug 2020 20:20:43 +0200
Message-Id: <20200806182059.2431-26-krzk@kernel.org>
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
 arch/arm/mach-s3c24xx/mach-rx1950.c | 16 +++++++
 sound/soc/samsung/rx1950_uda1380.c  | 72 +++++++++--------------------
 2 files changed, 39 insertions(+), 49 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index 65440c39500e..a5461b2227bd 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -727,6 +727,20 @@ static struct i2c_board_info rx1950_i2c_devices[] = {
 	},
 };
 
+static struct gpiod_lookup_table rx1950_audio_gpio_table = {
+	.dev_id = "rx1950-audio",
+	.table = {
+		GPIO_LOOKUP("GPIOG", 12, "hp-gpio", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("GPIOA", 1, "speaker-power", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
+static struct platform_device rx1950_audio = {
+	.name = "rx1950-audio",
+	.id = -1,
+};
+
 static struct platform_device *rx1950_devices[] __initdata = {
 	&s3c2410_device_dclk,
 	&s3c_device_lcd,
@@ -745,6 +759,7 @@ static struct platform_device *rx1950_devices[] __initdata = {
 	&power_supply,
 	&rx1950_battery,
 	&rx1950_leds,
+	&rx1950_audio,
 };
 
 static void __init rx1950_map_io(void)
@@ -812,6 +827,7 @@ static void __init rx1950_init_machine(void)
 	gpio_direction_output(S3C2410_GPJ(6), 0);
 
 	pwm_add_table(rx1950_pwm_lookup, ARRAY_SIZE(rx1950_pwm_lookup));
+	gpiod_add_lookup_table(&rx1950_audio_gpio_table);
 	platform_add_devices(rx1950_devices, ARRAY_SIZE(rx1950_devices));
 
 	i2c_register_board_info(0, rx1950_i2c_devices,
diff --git a/sound/soc/samsung/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
index 08f7c82aedb6..400a7f77c711 100644
--- a/sound/soc/samsung/rx1950_uda1380.c
+++ b/sound/soc/samsung/rx1950_uda1380.c
@@ -12,16 +12,13 @@
 //          Vasily Khoruzhick <anarsoul@gmail.com>
 
 #include <linux/types.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 
 #include <sound/soc.h>
 #include <sound/jack.h>
 
-#include <mach/gpio-samsung.h>
 #include "regs-iis.h"
-#include <asm/mach-types.h>
-
 #include "s3c24xx-i2s.h"
 
 static int rx1950_uda1380_init(struct snd_soc_pcm_runtime *rtd);
@@ -58,7 +55,6 @@ static struct snd_soc_jack_pin hp_jack_pins[] = {
 
 static struct snd_soc_jack_gpio hp_jack_gpios[] = {
 	[0] = {
-		.gpio			= S3C2410_GPG(12),
 		.name			= "hp-gpio",
 		.report			= SND_JACK_HEADPHONE,
 		.invert			= 1,
@@ -123,8 +119,6 @@ static struct snd_soc_card rx1950_asoc = {
 	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
-static struct platform_device *s3c24xx_snd_device;
-
 static int rx1950_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -134,13 +128,15 @@ static int rx1950_startup(struct snd_pcm_substream *substream)
 					&hw_rates);
 }
 
+struct gpio_desc *gpiod_speaker_power;
+
 static int rx1950_spk_power(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *kcontrol, int event)
 {
 	if (SND_SOC_DAPM_EVENT_ON(event))
-		gpio_set_value(S3C2410_GPA(1), 1);
+		gpiod_set_value(gpiod_speaker_power, 1);
 	else
-		gpio_set_value(S3C2410_GPA(1), 0);
+		gpiod_set_value(gpiod_speaker_power, 0);
 
 	return 0;
 }
@@ -214,57 +210,35 @@ static int rx1950_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int __init rx1950_init(void)
+static int rx1950_probe(struct platform_device *pdev)
 {
-	int ret;
-
-	if (!machine_is_rx1950())
-		return -ENODEV;
+	struct device *dev = &pdev->dev;
 
 	/* configure some gpios */
-	ret = gpio_request(S3C2410_GPA(1), "speaker-power");
-	if (ret)
-		goto err_gpio;
-
-	ret = gpio_direction_output(S3C2410_GPA(1), 0);
-	if (ret)
-		goto err_gpio_conf;
-
-	s3c24xx_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!s3c24xx_snd_device) {
-		ret = -ENOMEM;
-		goto err_plat_alloc;
-	}
-
-	platform_set_drvdata(s3c24xx_snd_device, &rx1950_asoc);
-	ret = platform_device_add(s3c24xx_snd_device);
-
-	if (ret) {
-		platform_device_put(s3c24xx_snd_device);
-		goto err_plat_add;
+	gpiod_speaker_power = devm_gpiod_get(dev, "speaker-power", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_speaker_power)) {
+		dev_err(dev, "cannot get gpio\n");
+		return PTR_ERR(gpiod_speaker_power);
 	}
 
-	return 0;
-
-err_plat_add:
-err_plat_alloc:
-err_gpio_conf:
-	gpio_free(S3C2410_GPA(1));
+	hp_jack_gpios[0].gpiod_dev = dev;
+	rx1950_asoc.dev = dev;
 
-err_gpio:
-	return ret;
+	return devm_snd_soc_register_card(dev, &rx1950_asoc);
 }
 
-static void __exit rx1950_exit(void)
-{
-	platform_device_unregister(s3c24xx_snd_device);
-	gpio_free(S3C2410_GPA(1));
-}
+struct platform_driver rx1950_audio = {
+	.driver = {
+		.name = "rx1950-audio",
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = rx1950_probe,
+};
 
-module_init(rx1950_init);
-module_exit(rx1950_exit);
+module_platform_driver(rx1950_audio);
 
 /* Module information */
 MODULE_AUTHOR("Vasily Khoruzhick");
 MODULE_DESCRIPTION("ALSA SoC RX1950");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:rx1950-audio");
-- 
2.17.1

