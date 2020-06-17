Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18047C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 04:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A422082F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 04:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgFQE6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 00:58:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49158 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgFQE6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 00:58:47 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jlQ9g-0006w0-U0; Wed, 17 Jun 2020 04:58:33 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Hui Wang <hui.wang@canonical.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Wenwen Wang <wenwen@cs.uga.edu>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Kailang Yang <kailang@realtek.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Tomas Espeleta <tomas.espeleta@gmail.com>,
        Thomas Hebb <tommyhebb@gmail.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] ALSA: hda/realtek: Add COEF controlled micmute LED support
Date:   Wed, 17 Jun 2020 12:58:24 +0800
Message-Id: <20200617045828.3735-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, HDA codec LED class can only used by by GPIO controlled LED.
However, there are some new systems that control LED via COEF instead of
GPIO.

In order to support those systems, create a new helper that can be
facilitated by both COEF controlled and GPIO controlled LED, and use
generic call_micmute_led_update() to control both case.

In addition to that, add LED_CORE_SUSPENDRESUME flag since some systems
don't restore the LED properly after suspend.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Prevent platforms like Dell, Lenovoe and Huawei create double LED
   class devices.

 sound/pci/hda/hda_generic.c   |  3 ++-
 sound/pci/hda/hda_generic.h   |  1 +
 sound/pci/hda/patch_realtek.c | 29 ++++++++++++++++-------------
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index f4e9d9445e18..9c3f1990c621 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3897,7 +3897,7 @@ enum {
 	MICMUTE_LED_FOLLOW_MUTE,
 };
 
-static void call_micmute_led_update(struct hda_codec *codec)
+void call_micmute_led_update(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	unsigned int val;
@@ -3924,6 +3924,7 @@ static void call_micmute_led_update(struct hda_codec *codec)
 	if (spec->micmute_led.update)
 		spec->micmute_led.update(codec);
 }
+EXPORT_SYMBOL_GPL(call_micmute_led_update);
 
 static void update_micmute_led(struct hda_codec *codec,
 			       struct snd_kcontrol *kcontrol,
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index fb9f1a90238b..9f08a9ee9112 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -353,6 +353,7 @@ unsigned int snd_hda_gen_path_power_filter(struct hda_codec *codec,
 void snd_hda_gen_stream_pm(struct hda_codec *codec, hda_nid_t nid, bool on);
 int snd_hda_gen_fix_pin_power(struct hda_codec *codec, hda_nid_t pin);
 
+void call_micmute_led_update(struct hda_codec *codec);
 int snd_hda_gen_add_micmute_led(struct hda_codec *codec,
 				void (*hook)(struct hda_codec *));
 void snd_hda_gen_fixup_micmute_led(struct hda_codec *codec,
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6d73f8beadb6..9691af8241cf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4114,10 +4114,10 @@ static int micmute_led_set(struct led_classdev *led_cdev,
 			   enum led_brightness brightness)
 {
 	struct hda_codec *codec = dev_to_hda_codec(led_cdev->dev->parent);
-	struct alc_spec *spec = codec->spec;
+	struct hda_gen_spec *spec = codec->spec;
 
-	alc_update_gpio_led(codec, spec->gpio_mic_led_mask,
-			    spec->micmute_led_polarity, !!brightness);
+	spec->micmute_led.led_mode = !brightness;
+	call_micmute_led_update(codec);
 	return 0;
 }
 
@@ -4126,7 +4126,17 @@ static struct led_classdev micmute_led_cdev = {
 	.max_brightness = 1,
 	.brightness_set_blocking = micmute_led_set,
 	.default_trigger = "audio-micmute",
+	.flags = LED_CORE_SUSPENDRESUME,
 };
+
+static void alc_register_micmute_led(struct hda_codec *codec)
+{
+		micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
+		if (devm_led_classdev_register(&codec->core.dev, &micmute_led_cdev))
+			codec_warn(codec, "failed to register micmute LED\n");
+}
+#else
+static inline void alc_register_micmute_led(struct hda_codec *codec) {}
 #endif
 
 /* setup mute and mic-mute GPIO bits, add hooks appropriately */
@@ -4136,9 +4146,6 @@ static void alc_fixup_hp_gpio_led(struct hda_codec *codec,
 				  unsigned int micmute_mask)
 {
 	struct alc_spec *spec = codec->spec;
-#if IS_REACHABLE(CONFIG_LEDS_TRIGGER_AUDIO)
-	int err;
-#endif
 
 	alc_fixup_gpio(codec, action, mute_mask | micmute_mask);
 
@@ -4151,13 +4158,7 @@ static void alc_fixup_hp_gpio_led(struct hda_codec *codec,
 	if (micmute_mask) {
 		spec->gpio_mic_led_mask = micmute_mask;
 		snd_hda_gen_add_micmute_led(codec, alc_gpio_micmute_update);
-
-#if IS_REACHABLE(CONFIG_LEDS_TRIGGER_AUDIO)
-		micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
-		err = devm_led_classdev_register(&codec->core.dev, &micmute_led_cdev);
-		if (err)
-			codec_warn(codec, "failed to register micmute LED\n");
-#endif
+		alc_register_micmute_led(codec);
 	}
 }
 
@@ -4305,6 +4306,7 @@ static void alc285_fixup_hp_coef_micmute_led(struct hda_codec *codec,
 		spec->mic_led_coefbit_on = 1<<13;
 		spec->mic_led_coefbit_off = 0;
 		snd_hda_gen_add_micmute_led(codec, alc_hp_cap_micmute_update);
+		alc_register_micmute_led(codec);
 	}
 }
 
@@ -4319,6 +4321,7 @@ static void alc236_fixup_hp_coef_micmute_led(struct hda_codec *codec,
 		spec->mic_led_coefbit_on = 2<<2;
 		spec->mic_led_coefbit_off = 1<<2;
 		snd_hda_gen_add_micmute_led(codec, alc_hp_cap_micmute_update);
+		alc_register_micmute_led(codec);
 	}
 }
 
-- 
2.17.1

