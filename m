Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B17BC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE632078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d631R2gw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgDTVkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726021AbgDTVkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:40:49 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAD8C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:40:48 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id t63so1226958wmt.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Gk/VYoQhPhQ7TbUJt9ppu0wX7IwMr6mSq4U87B4Pb4=;
        b=d631R2gwMehAjcbsqcBoh4S2uRZcvSYuoWemely5PVflzq3Ass3LCUsCfgkdWtgc9F
         TU/kozgTBVtlrpNUHjbEOMTrNAys+iW5pwg54cxSGmSkx/hQoOTACufZ8014modkhsZE
         SXC0MGzMeMwozpMkt0xhoyZg1FPP+/p8xWJpo6ypBnSUFdq3eOLAVzqFeHBi/RJetGwZ
         vCwyNvDg/FV4RHIrXnfaI06i5hbbyjuKfUKtND4vvWgvqIBd8sl4yQM1SC/T6rjpPUDn
         GCaa3YJg5naB5dXMMlfzIsuxz3oBLhV45iKht+np77NGxU/ZR1zIqJ1CdkwI8C4BgCCn
         M9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Gk/VYoQhPhQ7TbUJt9ppu0wX7IwMr6mSq4U87B4Pb4=;
        b=GNQZ3Ti+lKFewy5cWLDtOjzdeOZUdmMyHK1/jNvy4EfzY5vueQdEvaroz6YIOJ6USn
         SZUGSJq723XxACZYI44laOlp7ZC/oFOPB3qbQ4UMcBQ4Zvx1FJBHG3Ah6TR6yK2xYG8S
         +WVk9JNK45vVR3tB3dqzkstiNdz15S8nxOCQmc5UIibDWrnLg9+f5S68CUpPpS5g8dHD
         zlzu4x3i2uAH9gHDfECqeP4J7XFPcxHwbrMYUlPs7VDA5EPM8tT2i/3sb8dVRm1rj/YL
         JJcmURBpl91A1TPXlxPmVwDW9d33dhIfMAx8YNMJNZylYS2YLX8+Fo6HQaXBKA71Prqv
         rbag==
X-Gm-Message-State: AGi0PuZ8kHDwoLzEd63rW7z/dU5V1FiOqy+9jRqv1nHgOn5XH+mtKkwj
        Fd7kIvyRExzw2qhIJF83gd4=
X-Google-Smtp-Source: APiQypLvpyyDBqeAgz8buD5OJjsPdNQop2mMLHkzAHCjiqgN9PjtiPL4xXegCiReIbsQ8ECaZ/lF/A==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr1466022wmg.183.1587418847498;
        Mon, 20 Apr 2020 14:40:47 -0700 (PDT)
Received: from localhost.localdomain ([91.221.170.230])
        by smtp.googlemail.com with ESMTPSA id q17sm755380wmj.45.2020.04.20.14.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:40:46 -0700 (PDT)
From:   Gregor Pintar <grpintar@gmail.com>
To:     tiwai@suse.com, perex@perex.cz, alexander@tsoy.me
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        grpintar@gmail.com
Subject: [PATCH v2] ALSA: usb-audio: Add quirk for Focusrite Scarlett 2i2
Date:   Mon, 20 Apr 2020 23:40:30 +0200
Message-Id: <20200420214030.2361-1-grpintar@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1c4b8a362761421eba0ded60bb4f0e11b7e42f3b.camel@tsoy.me>
References: <1c4b8a362761421eba0ded60bb4f0e11b7e42f3b.camel@tsoy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force it to use asynchronous playback.

Same quirk has already been added for Focusrite Scarlett Solo (2nd gen)
with a commit 46f5710f0b88 ("ALSA: usb-audio: Add quirk for Focusrite
Scarlett Solo").

This also seems to prevent regular clicks when playing at 44100Hz
on Scarlett 2i2 (2nd gen). I did not notice any side effects.

Moved both quirks to snd_usb_audioformat_attributes_quirk() as suggested.

Signed-off-by: Gregor Pintar <grpintar@gmail.com>
---
 sound/usb/quirks-table.h | 84 ----------------------------------------
 sound/usb/quirks.c       | 13 +++++++
 2 files changed, 13 insertions(+), 84 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index e009d584e..7e06ab108 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2756,90 +2756,6 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		.type = QUIRK_MIDI_NOVATION
 	}
 },
-{
-	/*
-	 * Focusrite Scarlett Solo 2nd generation
-	 * Reports that playback should use Synch: Synchronous
-	 * while still providing a feedback endpoint. Synchronous causes
-	 * snapping on some sample rates.
-	 * Force it to use Synch: Asynchronous.
-	 */
-	USB_DEVICE(0x1235, 0x8205),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
-					.formats = SNDRV_PCM_FMTBIT_S32_LE,
-					.channels = 2,
-					.iface = 1,
-					.altsetting = 1,
-					.altset_idx = 1,
-					.attributes = 0,
-					.endpoint = 0x01,
-					.ep_attr = USB_ENDPOINT_XFER_ISOC |
-						   USB_ENDPOINT_SYNC_ASYNC,
-					.protocol = UAC_VERSION_2,
-					.rates = SNDRV_PCM_RATE_44100 |
-						 SNDRV_PCM_RATE_48000 |
-						 SNDRV_PCM_RATE_88200 |
-						 SNDRV_PCM_RATE_96000 |
-						 SNDRV_PCM_RATE_176400 |
-						 SNDRV_PCM_RATE_192000,
-					.rate_min = 44100,
-					.rate_max = 192000,
-					.nr_rates = 6,
-					.rate_table = (unsigned int[]) {
-						44100, 48000, 88200,
-						96000, 176400, 192000
-					},
-					.clock = 41
-				}
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
-					.formats = SNDRV_PCM_FMTBIT_S32_LE,
-					.channels = 2,
-					.iface = 2,
-					.altsetting = 1,
-					.altset_idx = 1,
-					.attributes = 0,
-					.endpoint = 0x82,
-					.ep_attr = USB_ENDPOINT_XFER_ISOC |
-						   USB_ENDPOINT_SYNC_ASYNC |
-						   USB_ENDPOINT_USAGE_IMPLICIT_FB,
-					.protocol = UAC_VERSION_2,
-					.rates = SNDRV_PCM_RATE_44100 |
-						 SNDRV_PCM_RATE_48000 |
-						 SNDRV_PCM_RATE_88200 |
-						 SNDRV_PCM_RATE_96000 |
-						 SNDRV_PCM_RATE_176400 |
-						 SNDRV_PCM_RATE_192000,
-					.rate_min = 44100,
-					.rate_max = 192000,
-					.nr_rates = 6,
-					.rate_table = (unsigned int[]) {
-						44100, 48000, 88200,
-						96000, 176400, 192000
-					},
-					.clock = 41
-				}
-			},
-			{
-				.ifnum = 3,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = -1
-			}
-		}
-	}
-},
 
 /* Access Music devices */
 {
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index a8ece1701..6c2dfd3bf 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1806,6 +1806,19 @@ void snd_usb_audioformat_attributes_quirk(struct snd_usb_audio *chip,
 		 */
 		fp->attributes &= ~UAC_EP_CS_ATTR_FILL_MAX;
 		break;
+	case USB_ID(0x1235, 0x8202):  /* Focusrite Scarlett 2i2 2nd gen */
+	case USB_ID(0x1235, 0x8205):  /* Focusrite Scarlett Solo 2nd gen */
+		/*
+		 * Reports that playback should use Synch: Synchronous
+		 * while still providing a feedback endpoint.
+		 * Synchronous causes snapping on some sample rates.
+		 * Force it to use Synch: Asynchronous.
+		 */
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			fp->ep_attr &= ~USB_ENDPOINT_SYNCTYPE;
+			fp->ep_attr |= USB_ENDPOINT_SYNC_ASYNC;
+		}
+		break;
 	}
 }
 
-- 
2.20.1

