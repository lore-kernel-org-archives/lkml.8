Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7D1C83009
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71BF52186A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgD3IdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 04:33:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38539 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgD3IdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 04:33:23 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jU4d5-0002xY-Dn; Thu, 30 Apr 2020 08:33:12 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Tomas Espeleta <tomas.espeleta@gmail.com>,
        Thomas Hebb <tommyhebb@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] ALSA: hda/realtek - Add LED class support for micmute LED
Date:   Thu, 30 Apr 2020 16:32:53 +0800
Message-Id: <20200430083255.5093-3-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430083255.5093-1-kai.heng.feng@canonical.com>
References: <20200430083255.5093-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently DMIC controls micmute LED via "audio mute LED trigger".

However, unlike Dell and Lenovo platforms, HP platforms don't provide a
way to control micmute LED via ACPI, it's controlled by HDA codec
instead.

So let's register an LED class for micmute so other subsystems like DMIC
can facilitate the codec-controlled LED.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6f164ccddde3..82eb7624bbba 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -17,6 +17,7 @@
 #include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/input.h>
+#include <linux/leds.h>
 #include <sound/core.h>
 #include <sound/jack.h>
 #include <sound/hda_codec.h>
@@ -4103,6 +4104,24 @@ static void alc_gpio_micmute_update(struct hda_codec *codec)
 			    spec->gen.micmute_led.led_value);
 }
 
+static int micmute_led_set(struct led_classdev *led_cdev,
+			   enum led_brightness brightness)
+{
+	struct hda_codec *codec = dev_to_hda_codec(led_cdev->dev->parent);
+	struct alc_spec *spec = codec->spec;
+
+	alc_update_gpio_led(codec, spec->gpio_mic_led_mask,
+			    spec->micmute_led_polarity, !!brightness);
+	return 0;
+}
+
+static struct led_classdev micmute_led_cdev = {
+	.name = "hda::micmute",
+	.max_brightness = 1,
+	.brightness_set_blocking = micmute_led_set,
+	.default_trigger = "audio-micmute",
+};
+
 /* setup mute and mic-mute GPIO bits, add hooks appropriately */
 static void alc_fixup_hp_gpio_led(struct hda_codec *codec,
 				  int action,
@@ -4110,6 +4129,7 @@ static void alc_fixup_hp_gpio_led(struct hda_codec *codec,
 				  unsigned int micmute_mask)
 {
 	struct alc_spec *spec = codec->spec;
+	int err;
 
 	alc_fixup_gpio(codec, action, mute_mask | micmute_mask);
 
@@ -4122,6 +4142,11 @@ static void alc_fixup_hp_gpio_led(struct hda_codec *codec,
 	if (micmute_mask) {
 		spec->gpio_mic_led_mask = micmute_mask;
 		snd_hda_gen_add_micmute_led(codec, alc_gpio_micmute_update);
+
+		micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
+		err = devm_led_classdev_register(&codec->core.dev, &micmute_led_cdev);
+		if (err)
+			codec_warn(codec, "failed to register micmute LED\n");
 	}
 }
 
-- 
2.17.1

