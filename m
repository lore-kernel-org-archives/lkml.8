Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088E7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 04:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E11DE207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 04:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgFPErt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 00:47:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34816 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgFPErt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 00:47:49 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jl3V4-0004Qd-59; Tue, 16 Jun 2020 04:47:06 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Wenwen Wang <wenwen@cs.uga.edu>,
        Hui Wang <hui.wang@canonical.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kailang Yang <kailang@realtek.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Tomas Espeleta <tomas.espeleta@gmail.com>,
        Thomas Hebb <tommyhebb@gmail.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] ALSA: hda: Make codec controlled LED support more generic
Date:   Tue, 16 Jun 2020 12:46:58 +0800
Message-Id: <20200616044702.17570-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only HDA codec GPIO controlled LED class is supported, and
only via platform specific quirk.

There are systems that control LED via COEF instead of GPIO, and to
support those systems, move the LED class registration to
snd_hda_gen_add_micmute_led(), so all systems can facilitate the same
interface.

In addition to that, add LED_CORE_SUSPENDRESUME flag since some systems
don't restore the LED properly after suspend.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/hda_generic.c   | 28 ++++++++++++++++++++++++++++
 sound/pci/hda/patch_realtek.c | 30 ------------------------------
 2 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index f4e9d9445e18..4242407734c0 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -4006,6 +4006,28 @@ static const struct snd_kcontrol_new micmute_led_mode_ctl = {
  *
  * Returns 0 if the hook is established or a negative error code.
  */
+
+#if IS_REACHABLE(CONFIG_LEDS_TRIGGER_AUDIO)
+static int micmute_led_set(struct led_classdev *led_cdev,
+			   enum led_brightness brightness)
+{
+	struct hda_codec *codec = dev_to_hda_codec(led_cdev->dev->parent);
+	struct hda_gen_spec *spec = codec->spec;
+
+	spec->micmute_led.led_mode = !brightness;
+	call_micmute_led_update(codec);
+	return 0;
+}
+
+static struct led_classdev micmute_led_cdev = {
+	.name = "hda::micmute",
+	.max_brightness = 1,
+	.brightness_set_blocking = micmute_led_set,
+	.default_trigger = "audio-micmute",
+	.flags = LED_CORE_SUSPENDRESUME,
+};
+#endif
+
 int snd_hda_gen_add_micmute_led(struct hda_codec *codec,
 				void (*hook)(struct hda_codec *))
 {
@@ -4019,6 +4041,12 @@ int snd_hda_gen_add_micmute_led(struct hda_codec *codec,
 	spec->cap_sync_hook = update_micmute_led;
 	if (!snd_hda_gen_add_kctl(spec, NULL, &micmute_led_mode_ctl))
 		return -ENOMEM;
+
+#if IS_REACHABLE(CONFIG_LEDS_TRIGGER_AUDIO)
+	micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
+	if (devm_led_classdev_register(&codec->core.dev, &micmute_led_cdev))
+		codec_warn(codec, "failed to register micmute LED\n");
+#endif
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_hda_gen_add_micmute_led);
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6d73f8beadb6..cead44a6c6cd 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4109,26 +4109,6 @@ static void alc_gpio_micmute_update(struct hda_codec *codec)
 			    spec->gen.micmute_led.led_value);
 }
 
-#if IS_REACHABLE(CONFIG_LEDS_TRIGGER_AUDIO)
-static int micmute_led_set(struct led_classdev *led_cdev,
-			   enum led_brightness brightness)
-{
-	struct hda_codec *codec = dev_to_hda_codec(led_cdev->dev->parent);
-	struct alc_spec *spec = codec->spec;
-
-	alc_update_gpio_led(codec, spec->gpio_mic_led_mask,
-			    spec->micmute_led_polarity, !!brightness);
-	return 0;
-}
-
-static struct led_classdev micmute_led_cdev = {
-	.name = "hda::micmute",
-	.max_brightness = 1,
-	.brightness_set_blocking = micmute_led_set,
-	.default_trigger = "audio-micmute",
-};
-#endif
-
 /* setup mute and mic-mute GPIO bits, add hooks appropriately */
 static void alc_fixup_hp_gpio_led(struct hda_codec *codec,
 				  int action,
@@ -4136,9 +4116,6 @@ static void alc_fixup_hp_gpio_led(struct hda_codec *codec,
 				  unsigned int micmute_mask)
 {
 	struct alc_spec *spec = codec->spec;
-#if IS_REACHABLE(CONFIG_LEDS_TRIGGER_AUDIO)
-	int err;
-#endif
 
 	alc_fixup_gpio(codec, action, mute_mask | micmute_mask);
 
@@ -4151,13 +4128,6 @@ static void alc_fixup_hp_gpio_led(struct hda_codec *codec,
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
 	}
 }
 
-- 
2.17.1

