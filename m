Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06559C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0AEC20679
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRbNmxsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388152AbgEWRj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 13:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387515AbgEWRj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 13:39:28 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24715C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 10:39:27 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 5so6423811pjd.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 10:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pf6Ugn99es2SlmyB0AGFZh8SoF73A0fGWtO9ESLW5e0=;
        b=bRbNmxszfYMnCYRjwizdd0HeFOcouozdSx2Wf1APoyo/4Y8wO1f5p7jr2AgKB7IDg7
         iBGnBragMuIj0T7DKPFh8FAYFfvGimWWEW1le30L2fbMYSC1O5K0uZZWCg4hP+xtH7Kj
         e/kGqVD2xR30jANPA6etuaczAt/oWX+OWBRr56nI+aWjlEs66mYdb6mFAMgGHlMF2NsO
         VrdXSsnR2sLJWqMfibkyOTncmZ7JucGlK0JKYHzP9O0VOW2zithVy70pQbhlH+Ul9B+q
         Q9O3NbFN0LzNafl/nNnJHJzNuIotK2n3D7yfo7BbUupLLr+ozs0+oWdqOoTyjb30G3sU
         oQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pf6Ugn99es2SlmyB0AGFZh8SoF73A0fGWtO9ESLW5e0=;
        b=hLIoiyzKAF/pTrmA8MkCwEbqLluJRI6w5449hCCY6s1dG6z1CMkz2X6xeE5S7G2C/b
         dzm6t+JjhExueai0puY5sP09wECuG9KwDXy1IMYFVmP7LxejCKzvVZYMcorc2ZUjrC1I
         Y1pOPm5mjqPvoCxR0C9I9a9Hly89BVZIa0qgszToybqsPpdITFJWo0EjKF1iqmrzitoB
         p1z25QIfsah7zjR706z5+OMDle53kDfYaR2Hc6oVhH7nL2AzpqIyRss1Xv5Ghd2gHy6C
         M+HawrNhs1gc7Qn0M94tLWawGXH0utq/eJRhmjtIQkvNlYkqwFlTLW/c8Y3MxMB5cnVX
         /2bg==
X-Gm-Message-State: AOAM532O9p5FyydSi/heGN7itV2Qa0G60djZAcl1aAthBodUwugG/5bf
        n4nhgGeht1+EMJEreyIVsw4=
X-Google-Smtp-Source: ABdhPJx/1pJNxzdRaiXn/UpjbE0w0k+lcmbZsHc2nwu/BGZY0WaYGL1vkQP63oTa3X2l+RDBHucIFA==
X-Received: by 2002:a17:90a:264c:: with SMTP id l70mr11733707pje.18.1590255566631;
        Sat, 23 May 2020 10:39:26 -0700 (PDT)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id m4sm9840866pje.47.2020.05.23.10.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 10:39:25 -0700 (PDT)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Allison Randal <allison@lohutok.net>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] ALSA: line6: add hw monitor volume control for POD HD500
Date:   Sat, 23 May 2020 10:39:03 -0700
Message-Id: <20200523173903.5136-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hw monitor volume control for POD HD500. The same change may
work for HD500X but I don't have it to test.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/usb/line6/driver.c |   3 +-
 sound/usb/line6/driver.h |   4 ++
 sound/usb/line6/podhd.c  | 124 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 7629116f570e..597a36c0a51d 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -97,7 +97,7 @@ static void line6_stop_listen(struct usb_line6 *line6)
 /*
 	Send raw message in pieces of wMaxPacketSize bytes.
 */
-static int line6_send_raw_message(struct usb_line6 *line6, const char *buffer,
+int line6_send_raw_message(struct usb_line6 *line6, const char *buffer,
 				  int size)
 {
 	int i, done = 0;
@@ -132,6 +132,7 @@ static int line6_send_raw_message(struct usb_line6 *line6, const char *buffer,
 
 	return done;
 }
+EXPORT_SYMBOL(line6_send_raw_message);
 
 /*
 	Notification of completion of asynchronous request transmission.
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index 1a4e3700c80c..62c686bed0ca 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -108,6 +108,8 @@ enum {
 	LINE6_CAP_CONTROL_MIDI = 1 << 4,
 	/* device provides low-level information */
 	LINE6_CAP_CONTROL_INFO = 1 << 5,
+	/* device provides hardware monitoring volume control */
+	LINE6_CAP_HWMON_CTL =	1 << 6,
 };
 
 /*
@@ -185,6 +187,8 @@ extern int line6_read_data(struct usb_line6 *line6, unsigned address,
 			   void *data, unsigned datalen);
 extern int line6_read_serial_number(struct usb_line6 *line6,
 				    u32 *serial_number);
+extern int line6_send_raw_message(struct usb_line6 *line6,
+					const char *buffer, int size);
 extern int line6_send_raw_message_async(struct usb_line6 *line6,
 					const char *buffer, int size);
 extern int line6_send_sysex_message(struct usb_line6 *line6,
diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index e39dc85c355a..a40115625c01 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <sound/core.h>
+#include <sound/control.h>
 #include <sound/pcm.h>
 
 #include "driver.h"
@@ -37,6 +38,9 @@ struct usb_line6_podhd {
 
 	/* Firmware version */
 	int firmware_version;
+
+	/* Monitor level */
+	int monitor_level;
 };
 
 #define line6_to_podhd(x)	container_of(x, struct usb_line6_podhd, line6)
@@ -250,6 +254,115 @@ static void podhd_disconnect(struct usb_line6 *line6)
 	}
 }
 
+static const unsigned int float_zero_to_one_lookup[] = {
+0x00000000, 0x3C23D70A, 0x3CA3D70A, 0x3CF5C28F, 0x3D23D70A, 0x3D4CCCCD,
+0x3D75C28F, 0x3D8F5C29, 0x3DA3D70A, 0x3DB851EC, 0x3DCCCCCD, 0x3DE147AE,
+0x3DF5C28F, 0x3E051EB8, 0x3E0F5C29, 0x3E19999A, 0x3E23D70A, 0x3E2E147B,
+0x3E3851EC, 0x3E428F5C, 0x3E4CCCCD, 0x3E570A3D, 0x3E6147AE, 0x3E6B851F,
+0x3E75C28F, 0x3E800000, 0x3E851EB8, 0x3E8A3D71, 0x3E8F5C29, 0x3E947AE1,
+0x3E99999A, 0x3E9EB852, 0x3EA3D70A, 0x3EA8F5C3, 0x3EAE147B, 0x3EB33333,
+0x3EB851EC, 0x3EBD70A4, 0x3EC28F5C, 0x3EC7AE14, 0x3ECCCCCD, 0x3ED1EB85,
+0x3ED70A3D, 0x3EDC28F6, 0x3EE147AE, 0x3EE66666, 0x3EEB851F, 0x3EF0A3D7,
+0x3EF5C28F, 0x3EFAE148, 0x3F000000, 0x3F028F5C, 0x3F051EB8, 0x3F07AE14,
+0x3F0A3D71, 0x3F0CCCCD, 0x3F0F5C29, 0x3F11EB85, 0x3F147AE1, 0x3F170A3D,
+0x3F19999A, 0x3F1C28F6, 0x3F1EB852, 0x3F2147AE, 0x3F23D70A, 0x3F266666,
+0x3F28F5C3, 0x3F2B851F, 0x3F2E147B, 0x3F30A3D7, 0x3F333333, 0x3F35C28F,
+0x3F3851EC, 0x3F3AE148, 0x3F3D70A4, 0x3F400000, 0x3F428F5C, 0x3F451EB8,
+0x3F47AE14, 0x3F4A3D71, 0x3F4CCCCD, 0x3F4F5C29, 0x3F51EB85, 0x3F547AE1,
+0x3F570A3D, 0x3F59999A, 0x3F5C28F6, 0x3F5EB852, 0x3F6147AE, 0x3F63D70A,
+0x3F666666, 0x3F68F5C3, 0x3F6B851F, 0x3F6E147B, 0x3F70A3D7, 0x3F733333,
+0x3F75C28F, 0x3F7851EC, 0x3F7AE148, 0x3F7D70A4, 0x3F800000
+};
+
+static void podhd_set_monitor_level(struct usb_line6_podhd *podhd, int value)
+{
+	unsigned int fl;
+	static const unsigned char msg[16] = {
+		/* Chunk is 0xc bytes (without first word) */
+		0x0c, 0x00,
+		/* First chunk in the message */
+		0x01, 0x00,
+		/* Message size is 2 4-byte words */
+		0x02, 0x00,
+		/* Unknown */
+		0x04, 0x41,
+		/* Unknown */
+		0x04, 0x00, 0x13, 0x00,
+		/* Volume, LE float32, 0.0 - 1.0 */
+		0x00, 0x00, 0x00, 0x00
+	};
+	unsigned char *buf;
+
+	buf = kmalloc(sizeof(msg), GFP_ATOMIC);
+	memcpy(buf, msg, sizeof(msg));
+
+	if (value < 0)
+		value = 0;
+
+	if (value > ARRAY_SIZE(float_zero_to_one_lookup))
+		value = ARRAY_SIZE(float_zero_to_one_lookup);
+
+	fl = float_zero_to_one_lookup[value];
+
+	buf[12] = (fl >> 0) & 0xff;
+	buf[13] = (fl >> 8) & 0xff;
+	buf[14] = (fl >> 16) & 0xff;
+	buf[15] = (fl >> 24) & 0xff;
+
+	line6_send_raw_message(&podhd->line6, buf, sizeof(msg));
+	kfree(buf);
+
+	podhd->monitor_level = value;
+}
+
+/* control info callback */
+static int snd_podhd_control_monitor_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 100;
+	uinfo->value.integer.step = 1;
+	return 0;
+}
+
+/* control get callback */
+static int snd_podhd_control_monitor_get(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_line6_pcm *line6pcm = snd_kcontrol_chip(kcontrol);
+	struct usb_line6_podhd *podhd = line6_to_podhd(line6pcm->line6);
+
+	ucontrol->value.integer.value[0] = podhd->monitor_level;
+	return 0;
+}
+
+/* control put callback */
+static int snd_podhd_control_monitor_put(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_line6_pcm *line6pcm = snd_kcontrol_chip(kcontrol);
+	struct usb_line6_podhd *podhd = line6_to_podhd(line6pcm->line6);
+
+	if (ucontrol->value.integer.value[0] == podhd->monitor_level)
+		return 0;
+
+	podhd_set_monitor_level(podhd, ucontrol->value.integer.value[0]);
+	return 1;
+}
+
+/* control definition */
+static const struct snd_kcontrol_new podhd_control_monitor = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Monitor Playback Volume",
+	.index = 0,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = snd_podhd_control_monitor_info,
+	.get = snd_podhd_control_monitor_get,
+	.put = snd_podhd_control_monitor_put
+};
+
 /*
 	Try to init POD HD device.
 */
@@ -298,6 +411,15 @@ static int podhd_init(struct usb_line6 *line6,
 			return err;
 	}
 
+	if (pod->line6.properties->capabilities & LINE6_CAP_HWMON_CTL) {
+		podhd_set_monitor_level(pod, 100);
+		err = snd_ctl_add(line6->card,
+				  snd_ctl_new1(&podhd_control_monitor,
+					       line6->line6pcm));
+		if (err < 0)
+			return err;
+	}
+
 	if (!(pod->line6.properties->capabilities & LINE6_CAP_CONTROL_INFO)) {
 		/* register USB audio system directly */
 		return snd_card_register(line6->card);
@@ -354,7 +476,7 @@ static const struct line6_properties podhd_properties_table[] = {
 		.id = "PODHD500",
 		.name = "POD HD500",
 		.capabilities	= LINE6_CAP_PCM | LINE6_CAP_CONTROL
-				| LINE6_CAP_HWMON,
+				| LINE6_CAP_HWMON | LINE6_CAP_HWMON_CTL,
 		.altsetting = 1,
 		.ctrl_if = 1,
 		.ep_ctrl_r = 0x81,
-- 
2.26.2

