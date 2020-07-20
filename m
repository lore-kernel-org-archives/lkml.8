Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382F5C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 118FA22CBB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260788;
	bh=DDI2nDmvoR0X6aSmr35gKN4b4QhRAHSVx8YSHM9RKPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DCWFVUms5f4uLaEKmL72fvu12sx/WLZLQxmQ9F7DZNVRJVaImoItzPk1pgFcM/ybD
	 uQBQftQfxemL3UZgQHCknl+PcCX+kIYPQ8YIk2rk8O1u1Xb39hs+d2GY+gfZshEplX
	 WtOYJO8omw04YLP+6KUGb2ZvKVcEZK1WLp99xu+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbgGTP7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732223AbgGTP71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E20E7206E9;
        Mon, 20 Jul 2020 15:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260766;
        bh=DDI2nDmvoR0X6aSmr35gKN4b4QhRAHSVx8YSHM9RKPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q7udnnS05rFCIsl3aJY+2Ok8MDNkG9mZswa47d78s5h+zq19uEiPG8q/2zw+dgSBv
         ytLFFJE7MCft24KM6fN5MBU+0Tdw/Q5CXk7Omdy8xj5QQECQyOMYOXlQvy0ekMy3db
         WstFZBO+r4h+f39HQyFTidPz2zF+am+VAQHl9naE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gregor Pintar <grpintar@gmail.com>,
        Alexander Tsoy <alexander@tsoy.me>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 088/215] ALSA: usb-audio: Add quirk for Focusrite Scarlett 2i2
Date:   Mon, 20 Jul 2020 17:36:10 +0200
Message-Id: <20200720152824.389170890@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gregor Pintar <grpintar@gmail.com>

[ Upstream commit 6f4ea2074ddf689ac6f892afa58515032dabf2e4 ]

Force it to use asynchronous playback.

Same quirk has already been added for Focusrite Scarlett Solo (2nd gen)
with a commit 46f5710f0b88 ("ALSA: usb-audio: Add quirk for Focusrite
Scarlett Solo").

This also seems to prevent regular clicks when playing at 44100Hz
on Scarlett 2i2 (2nd gen). I did not notice any side effects.

Moved both quirks to snd_usb_audioformat_attributes_quirk() as suggested.

Signed-off-by: Gregor Pintar <grpintar@gmail.com>
Reviewed-by: Alexander Tsoy <alexander@tsoy.me>
Link: https://lore.kernel.org/r/20200420214030.2361-1-grpintar@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks-table.h | 84 ----------------------------------------
 sound/usb/quirks.c       | 13 +++++++
 2 files changed, 13 insertions(+), 84 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 5089f2de2f02d..562179492a338 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2776,90 +2776,6 @@ YAMAHA_DEVICE(0x7010, "UB99"),
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
index 5341d045e6a48..e2b0de0473103 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1780,6 +1780,19 @@ void snd_usb_audioformat_attributes_quirk(struct snd_usb_audio *chip,
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
2.25.1



