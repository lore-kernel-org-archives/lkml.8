Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F98C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 05:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE902073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 05:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgGAFWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 01:22:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47253 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgGAFWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 01:22:30 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jqVBw-0001yp-1w; Wed, 01 Jul 2020 05:21:52 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     anthony.won@canonical.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Libin Yang <libin.yang@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Tomas Espeleta <tomas.espeleta@gmail.com>,
        Thomas Hebb <tommyhebb@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: hda/realtek: Serialize setting GPIO LED
Date:   Wed,  1 Jul 2020 13:21:35 +0800
Message-Id: <20200701052138.6378-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a system has two GPIO controlled LED, one for mute and another one
for micmute, and both of them are on before system suspend, sometimes
one of them won't be turned off by system suspend.

The codec doesn't seem to be able to control multiple GPIO LEDs at the
same time, so introduce a new mutex to serialize setting the LED, to
prevent the issue from happening.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 include/sound/hda_codec.h     | 1 +
 sound/pci/hda/hda_codec.c     | 1 +
 sound/pci/hda/patch_realtek.c | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index d16a4229209b..3a1792bbb7ac 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -206,6 +206,7 @@ struct hda_codec {
 
 	struct mutex spdif_mutex;
 	struct mutex control_mutex;
+	struct mutex led_mutex;
 	struct snd_array spdif_out;
 	unsigned int spdif_in_enable;	/* SPDIF input enable? */
 	const hda_nid_t *slave_dig_outs; /* optional digital out slave widgets */
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 7e3ae4534df9..ec477cd8afed 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -946,6 +946,7 @@ int snd_hda_codec_device_new(struct hda_bus *bus, struct snd_card *card,
 	codec->addr = codec_addr;
 	mutex_init(&codec->spdif_mutex);
 	mutex_init(&codec->control_mutex);
+	mutex_init(&codec->led_mutex);
 	snd_array_init(&codec->mixers, sizeof(struct hda_nid_item), 32);
 	snd_array_init(&codec->nids, sizeof(struct hda_nid_item), 32);
 	snd_array_init(&codec->init_pins, sizeof(struct hda_pincfg), 16);
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 53e0eef8b042..96dac365fbb8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4101,7 +4101,10 @@ static void alc_update_gpio_led(struct hda_codec *codec, unsigned int mask,
 {
 	if (polarity)
 		enabled = !enabled;
+
+	mutex_lock(&codec->led_mutex);
 	alc_update_gpio_data(codec, mask, !enabled); /* muted -> LED on */
+	mutex_unlock(&codec->led_mutex);
 }
 
 /* turn on/off mute LED via GPIO per vmaster hook */
-- 
2.17.1

