Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E61C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 11:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D42292075B
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 11:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgHWLAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 07:00:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55477 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgHWK72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 06:59:28 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1k9niF-0003UF-C2; Sun, 23 Aug 2020 10:59:00 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Hector Martin <marcan@marcan.st>,
        Alexander Tsoy <alexander@tsoy.me>,
        Hui Wang <hui.wang@canonical.com>,
        Dmitry Panchenko <dmitry@d-systems.ee>,
        =?UTF-8?q?Franti=C5=A1ek=20Ku=C4=8Dera?= <franta-linux@frantovo.cz>,
        Gregor Pintar <grpintar@gmail.com>,
        Jussi Laako <jussi@sonarnerd.net>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Chris Wulff <crwulff@gmail.com>,
        Jesus Ramos <jesus-ramos@live.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: usb-audio: Disable autosuspend for Lenovo ThinkStation P620
Date:   Sun, 23 Aug 2020 18:58:50 +0800
Message-Id: <20200823105854.26950-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If USB autosuspend is enabled, both front and rear panel can no longer
detect jack insertion.

Enable USB remote wakeup, i.e. needs_remote_wakeup = 1, doesn't help
either.

So disable USB autosuspend to prevent missing jack detection event.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/usb/quirks-table.h | 18 ++++++++++++++----
 sound/usb/quirks.c       | 10 ++++++++++
 sound/usb/usbaudio.h     |  1 +
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index f4fb002e3ef4..416de71c6895 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2827,14 +2827,24 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* Lenovo ThinkStation P620 Rear Line-in, Line-out and Microphone */
 {
 	USB_DEVICE(0x17aa, 0x1046),
-	QUIRK_DEVICE_PROFILE("Lenovo", "ThinkStation P620 Rear",
-			     "Lenovo-ThinkStation-P620-Rear"),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.vendor_name = "Lenovo",
+		.product_name = "ThinkStation P620 Rear",
+		.profile_name = "Lenovo-ThinkStation-P620-Rear",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_SETUP_DISABLE_AUTOSUSPEND
+	}
 },
 /* Lenovo ThinkStation P620 Internal Speaker + Front Headset */
 {
 	USB_DEVICE(0x17aa, 0x104d),
-	QUIRK_DEVICE_PROFILE("Lenovo", "ThinkStation P620 Main",
-			     "Lenovo-ThinkStation-P620-Main"),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.vendor_name = "Lenovo",
+		.product_name = "ThinkStation P620 Main",
+		.profile_name = "Lenovo-ThinkStation-P620-Main",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_SETUP_DISABLE_AUTOSUSPEND
+	}
 },
 
 /* Native Instruments MK2 series */
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index abf99b814a0f..b800fd92106c 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -518,6 +518,15 @@ static int setup_fmt_after_resume_quirk(struct snd_usb_audio *chip,
 	return 1;	/* Continue with creating streams and mixer */
 }
 
+static int setup_disable_autosuspend(struct snd_usb_audio *chip,
+				       struct usb_interface *iface,
+				       struct usb_driver *driver,
+				       const struct snd_usb_audio_quirk *quirk)
+{
+	driver->supports_autosuspend = 0;
+	return 1;	/* Continue with creating streams and mixer */
+}
+
 /*
  * audio-interface quirks
  *
@@ -557,6 +566,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 		[QUIRK_AUDIO_ALIGN_TRANSFER] = create_align_transfer_quirk,
 		[QUIRK_AUDIO_STANDARD_MIXER] = create_standard_mixer_quirk,
 		[QUIRK_SETUP_FMT_AFTER_RESUME] = setup_fmt_after_resume_quirk,
+		[QUIRK_SETUP_DISABLE_AUTOSUSPEND] = setup_disable_autosuspend,
 	};
 
 	if (quirk->type < QUIRK_TYPE_COUNT) {
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index b91c4c0807ec..6839915a0128 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -102,6 +102,7 @@ enum quirk_type {
 	QUIRK_AUDIO_ALIGN_TRANSFER,
 	QUIRK_AUDIO_STANDARD_MIXER,
 	QUIRK_SETUP_FMT_AFTER_RESUME,
+	QUIRK_SETUP_DISABLE_AUTOSUSPEND,
 
 	QUIRK_TYPE_COUNT
 };
-- 
2.17.1

