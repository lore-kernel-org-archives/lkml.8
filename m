Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010F8C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D16DE20661
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588616089;
	bh=WOwYZ/09O3hRQvZRWnR5ibcSY9bduvtiBeCePotFWM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lZo7eKH/ClG3nRquKOgH8f8AOkMzuRweWwzEbUFskol904TJ+qbgzygHKUTmcEU0r
	 hdP2i8wpE6QNwdn1bg2foWUmb2s+OZFn7jpjBpLbi2kwFw1mQcwxUykNMiDD6cyt7l
	 yR5zPuihHTxX1UCAzgQC53+zPFnh3ebJgEvxNU2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbgEDSOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730951AbgEDSAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:00:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2E0920663;
        Mon,  4 May 2020 18:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615214;
        bh=WOwYZ/09O3hRQvZRWnR5ibcSY9bduvtiBeCePotFWM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w7oo9W4Gn2gAq2/CGEHHz4niSCn6c9eognfjl8LRRAc3V1aWnNmIlI/t31810qcsb
         Hxx3+AyJRYftQbQAl49l/duUxeu5EH5ksnmIr9hNXdNBRN486GlGm+GTeaqpAfWtYF
         rZvwng1N1pCpF3b2VoK5G52pISH9+tt4/tBQx7CU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 12/26] ALSA: pcm: oss: Place the plugin buffer overflow checks correctly
Date:   Mon,  4 May 2020 19:57:26 +0200
Message-Id: <20200504165445.473221017@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165442.494398840@linuxfoundation.org>
References: <20200504165442.494398840@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 4285de0725b1bf73608abbcd35ad7fd3ddc0b61e upstream.

The checks of the plugin buffer overflow in the previous fix by commit
  f2ecf903ef06 ("ALSA: pcm: oss: Avoid plugin buffer overflow")
are put in the wrong places mistakenly, which leads to the expected
(repeated) sound when the rate plugin is involved.  Fix in the right
places.

Also, at those right places, the zero check is needed for the
termination node, so added there as well, and let's get it done,
finally.

Fixes: f2ecf903ef06 ("ALSA: pcm: oss: Avoid plugin buffer overflow")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200424193350.19678-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/oss/pcm_plugin.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/sound/core/oss/pcm_plugin.c
+++ b/sound/core/oss/pcm_plugin.c
@@ -211,21 +211,23 @@ static snd_pcm_sframes_t plug_client_siz
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		plugin = snd_pcm_plug_last(plug);
 		while (plugin && drv_frames > 0) {
-			if (check_size && drv_frames > plugin->buf_frames)
-				drv_frames = plugin->buf_frames;
 			plugin_prev = plugin->prev;
 			if (plugin->src_frames)
 				drv_frames = plugin->src_frames(plugin, drv_frames);
+			if (check_size && plugin->buf_frames &&
+			    drv_frames > plugin->buf_frames)
+				drv_frames = plugin->buf_frames;
 			plugin = plugin_prev;
 		}
 	} else if (stream == SNDRV_PCM_STREAM_CAPTURE) {
 		plugin = snd_pcm_plug_first(plug);
 		while (plugin && drv_frames > 0) {
 			plugin_next = plugin->next;
+			if (check_size && plugin->buf_frames &&
+			    drv_frames > plugin->buf_frames)
+				drv_frames = plugin->buf_frames;
 			if (plugin->dst_frames)
 				drv_frames = plugin->dst_frames(plugin, drv_frames);
-			if (check_size && drv_frames > plugin->buf_frames)
-				drv_frames = plugin->buf_frames;
 			plugin = plugin_next;
 		}
 	} else
@@ -251,26 +253,28 @@ static snd_pcm_sframes_t plug_slave_size
 		plugin = snd_pcm_plug_first(plug);
 		while (plugin && frames > 0) {
 			plugin_next = plugin->next;
+			if (check_size && plugin->buf_frames &&
+			    frames > plugin->buf_frames)
+				frames = plugin->buf_frames;
 			if (plugin->dst_frames) {
 				frames = plugin->dst_frames(plugin, frames);
 				if (frames < 0)
 					return frames;
 			}
-			if (check_size && frames > plugin->buf_frames)
-				frames = plugin->buf_frames;
 			plugin = plugin_next;
 		}
 	} else if (stream == SNDRV_PCM_STREAM_CAPTURE) {
 		plugin = snd_pcm_plug_last(plug);
 		while (plugin) {
-			if (check_size && frames > plugin->buf_frames)
-				frames = plugin->buf_frames;
 			plugin_prev = plugin->prev;
 			if (plugin->src_frames) {
 				frames = plugin->src_frames(plugin, frames);
 				if (frames < 0)
 					return frames;
 			}
+			if (check_size && plugin->buf_frames &&
+			    frames > plugin->buf_frames)
+				frames = plugin->buf_frames;
 			plugin = plugin_prev;
 		}
 	} else


