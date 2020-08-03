Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10EDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D392620A8B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgHCO0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:26:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39572 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgHCO0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:26:50 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1k2bPs-0006OC-09; Mon, 03 Aug 2020 14:26:16 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Hui Peng <benquike@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Chris Boyle <chris@boyle.name>,
        Alexander Tsoy <alexander@tsoy.me>,
        Dmitry Panchenko <dmitry@d-systems.ee>,
        Gregor Pintar <grpintar@gmail.com>,
        Ard van Breemen <ard@kwaak.net>,
        Hector Martin <marcan@marcan.st>,
        =?UTF-8?q?Franti=C5=A1ek=20Ku=C4=8Dera?= <franta-linux@frantovo.cz>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: usb-audio: Add support for Lenovo ThinkStation P620
Date:   Mon,  3 Aug 2020 22:26:08 +0800
Message-Id: <20200803142612.17156-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lenovo ThinkStation P620 is like other TRX40 boards, is equipped with
two USB audio cards.

USB device (17aa:104d) provides functionality for Internal Speaker and
Front Headset. It's UAC v2, so it supports insertion control (jack
detection). However, when trying to get the connector status of the
speaker, an error occurs:
[    5.787405] usb 3-1: cannot get connectors status: req = 0x81, wValue = 0x200, wIndex = 0x1000, type = 0

Since the insertion control works perfectly for the headset, the error
for speaker is probably casued by connecting internally. So let's relax
the error for a bit if it's a speaker, and always reports it's connected.

USB device (17aa:1046) is for rear Line-in, Line-out and Microphone.
The insertion control works for all three jacks. However, there's an
Function Unit that doesn't work:
[    5.905415] usb 3-6: cannot get ctl value: req = 0x83, wValue = 0xc00, wIndex = 0x1300, type = 4
[    5.905418] usb 3-6: 19:0: cannot get min/max values for control 12 (id 19)

So turn off the FU to avoid the error.

Also, add specific card name for both devices, so userspace can easily
indentify both cards.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/usb/mixer.c        |  4 ++++
 sound/usb/mixer_maps.c   |  9 +++++++++
 sound/usb/quirks-table.h | 13 +++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index eab0fd4fd7c3..6b0f3a8469ef 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1463,6 +1463,10 @@ static int mixer_ctl_connector_get(struct snd_kcontrol *kcontrol,
 	snd_usb_unlock_shutdown(chip);
 
 	if (ret < 0) {
+		if (strstr(kcontrol->id.name, "Speaker")) {
+			ucontrol->value.integer.value[0] = 1;
+			return 0;
+		}
 error:
 		usb_audio_err(chip,
 			"cannot get connectors status: req = %#x, wValue = %#x, wIndex = %#x, type = %d\n",
diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 9af7aa93f6fa..08eb230e2bff 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -370,6 +370,11 @@ static const struct usbmix_name_map asus_rog_map[] = {
 	{}
 };
 
+static const struct usbmix_name_map lenovo_p620_rear_map[] = {
+	{ 19, NULL, 12 }, /* FU, Input Gain Pad */
+	{}
+};
+
 /* TRX40 mobos with Realtek ALC1220-VB */
 static const struct usbmix_name_map trx40_mobo_map[] = {
 	{ 18, NULL }, /* OT, IEC958 - broken response, disabled */
@@ -573,6 +578,10 @@ static const struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.map = trx40_mobo_map,
 		.connector_map = trx40_mobo_connector_map,
 	},
+	{	/* Lenovo ThinkStation P620 Rear */
+		.id = USB_ID(0x17aa, 0x1046),
+		.map = lenovo_p620_rear_map,
+	},
 	{ 0 } /* terminator */
 };
 
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 9092cc0aa807..09590f055a1d 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2794,6 +2794,19 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	QUIRK_RENAME_DEVICE("Rane", "SL-1")
 },
 
+/* Lenovo ThinkStation P620 Rear Line-in, Line-out and Microphone */
+{
+	USB_DEVICE(0x17aa, 0x1046),
+	QUIRK_DEVICE_PROFILE("Lenovo", "ThinkStation P620 Rear",
+			     "Lenovo-ThinkStation-P620-Rear"),
+},
+/* Lenovo ThinkStation P620 Internal Speaker + Front Headset */
+{
+	USB_DEVICE(0x17aa, 0x104d),
+	QUIRK_DEVICE_PROFILE("Lenovo", "ThinkStation P620 Main",
+			     "Lenovo-ThinkStation-P620-Main"),
+},
+
 /* Native Instruments MK2 series */
 {
 	/* Komplete Audio 6 */
-- 
2.17.1

