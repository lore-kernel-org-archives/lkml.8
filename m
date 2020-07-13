Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D27C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D22C20674
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMoXLTCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgGMFqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGMFqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:46:52 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF1BC061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 22:46:52 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so5558570pgc.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 22:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9kV5eC0cfq+MjIEnWUDIKxJV7K4FUREjkw+lgvlD4Uw=;
        b=jMoXLTCythtx3HGF5GZ6oId4eAVXVdttTQYfkJaWTJDlVkSSBNxBSvG4Er0bX5LwpD
         KzMi23WGsq0qfeI2W/Spv/YglgHox7rikA2RmrJxcHlr33b7pmi84ldrLdO/X6LXo78A
         09rrNrEICOQbTMjLeJz8b8/clw58r7zvN+6Nmkj9Nbta2KKYgwy3LjPoXrT3nBpZnPLZ
         HPQg2V8vCM9ZYMRakkPOeZbGaLkmdb2Mgd+oP5FKjkQqZw3aWE0Ub9Jwq5klkWZ8kojC
         uXGJ1VuK6RKjwcBX6Ovn0HGSnQ3dUfedAarQgsXStIu9AUPS+SHfn8SKgKYN8scag5ph
         8TeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9kV5eC0cfq+MjIEnWUDIKxJV7K4FUREjkw+lgvlD4Uw=;
        b=N/67VS02CQ80aF6aHqY02fdxChuPlK8JphetiNpFX26DRZ2jkPGjRGgvkgz9ptQA9h
         y73mz+1KArgMUpMjuUmWSVFlQ1vwRKZRkvEDKLc24/Xb6mxviCf24dLwd+pUL76Cc4DT
         7vdKexJOjfPDFxdR3NDFnpgwU6Om5H+JPRKYe3k0jDJYxoIWNRmm+nnJYG1HUQmamKX/
         7HTCbR5HPE/woa9QDoJCTBZaWPb9gZQvqCGN3+scoEoNnff2ZGQU6VwxxTTDAKJKu21w
         wivNK/1/EWOhHXeOaxomd8SBE77D0EDIVPgaVWOSyLsx9yGcS4Fc48uc+s5fMVRpVSOJ
         K/2A==
X-Gm-Message-State: AOAM533Cl89o5NvNAvcE1GgQY5CKihgxp5fBUHxTfpyH4/kC2uV9nyaG
        4wgtZpDusQxM0gdipI9ReTg=
X-Google-Smtp-Source: ABdhPJwoIbfopc4mkXHGHOYIDdIWyAPBWA8Uk2RkGjNFMKQaPHzh/t4GTCT+If0xasw8S6pXhdIoOA==
X-Received: by 2002:a62:be04:: with SMTP id l4mr31692348pff.323.1594619211592;
        Sun, 12 Jul 2020 22:46:51 -0700 (PDT)
Received: from anarsoul-xps15.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id b18sm13041357pju.10.2020.07.12.22.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 22:46:51 -0700 (PDT)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pavel Machek <pavel@denx.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v3] ALSA: line6: add hw monitor volume control for POD HD500
Date:   Sun, 12 Jul 2020 22:46:35 -0700
Message-Id: <20200713054635.58534-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.27.0
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
v3: - use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL
    - use GFP_KERNEL instead of GFP_ATOMIC for allocating a message
    - use lower case for float lookup table
v2: clamp volume value to [0, ARRAY_SIZE() -1] in
    podhd_set_monitor_level()

 sound/usb/line6/driver.c |   3 +-
 sound/usb/line6/driver.h |   4 ++
 sound/usb/line6/podhd.c  | 124 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 7629116f570e..3e07251b80e3 100644
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
+EXPORT_SYMBOL_GPL(line6_send_raw_message);
 
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
index e39dc85c355a..0410d256aa50 100644
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
+0x00000000, 0x3c23d70a, 0x3ca3d70a, 0x3cf5c28f, 0x3d23d70a, 0x3d4ccccd,
+0x3d75c28f, 0x3d8f5c29, 0x3da3d70a, 0x3db851ec, 0x3dcccccd, 0x3de147ae,
+0x3df5c28f, 0x3e051eb8, 0x3e0f5c29, 0x3e19999a, 0x3e23d70a, 0x3e2e147b,
+0x3e3851ec, 0x3e428f5c, 0x3e4ccccd, 0x3e570a3d, 0x3e6147ae, 0x3e6b851f,
+0x3e75c28f, 0x3e800000, 0x3e851eb8, 0x3e8a3d71, 0x3e8f5c29, 0x3e947ae1,
+0x3e99999a, 0x3e9eb852, 0x3ea3d70a, 0x3ea8f5c3, 0x3eae147b, 0x3eb33333,
+0x3eb851ec, 0x3ebd70a4, 0x3ec28f5c, 0x3ec7ae14, 0x3ecccccd, 0x3ed1eb85,
+0x3ed70a3d, 0x3edc28f6, 0x3ee147ae, 0x3ee66666, 0x3eeb851f, 0x3ef0a3d7,
+0x3ef5c28f, 0x3efae148, 0x3f000000, 0x3f028f5c, 0x3f051eb8, 0x3f07ae14,
+0x3f0a3d71, 0x3f0ccccd, 0x3f0f5c29, 0x3f11eb85, 0x3f147ae1, 0x3f170a3d,
+0x3f19999a, 0x3f1c28f6, 0x3f1eb852, 0x3f2147ae, 0x3f23d70a, 0x3f266666,
+0x3f28f5c3, 0x3f2b851f, 0x3f2e147b, 0x3f30a3d7, 0x3f333333, 0x3f35c28f,
+0x3f3851ec, 0x3f3ae148, 0x3f3d70a4, 0x3f400000, 0x3f428f5c, 0x3f451eb8,
+0x3f47ae14, 0x3f4a3d71, 0x3f4ccccd, 0x3f4f5c29, 0x3f51eb85, 0x3f547ae1,
+0x3f570a3d, 0x3f59999a, 0x3f5c28f6, 0x3f5eb852, 0x3f6147ae, 0x3f63d70a,
+0x3f666666, 0x3f68f5c3, 0x3f6b851f, 0x3f6e147b, 0x3f70a3d7, 0x3f733333,
+0x3f75c28f, 0x3f7851ec, 0x3f7ae148, 0x3f7d70a4, 0x3f800000
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
+	buf = kmalloc(sizeof(msg), GFP_KERNEL);
+	memcpy(buf, msg, sizeof(msg));
+
+	if (value < 0)
+		value = 0;
+
+	if (value >= ARRAY_SIZE(float_zero_to_one_lookup))
+		value = ARRAY_SIZE(float_zero_to_one_lookup) - 1;
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
2.27.0

