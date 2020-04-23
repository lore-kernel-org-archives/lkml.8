Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14845C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF6F20780
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgDWXOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:14:46 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49822 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728443AbgDWXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:06:48 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkvV-0004hq-CD; Fri, 24 Apr 2020 00:06:37 +0100
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkvR-00E6pF-CI; Fri, 24 Apr 2020 00:06:33 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Lionel Koenig" <lionel.koenig@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Takashi Iwai" <tiwai@suse.de>
Date:   Fri, 24 Apr 2020 00:05:54 +0100
Message-ID: <lsq.1587683028.443437380@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 127/245] ALSA: pcm: Avoid possible info leaks from
 PCM stream buffers
In-Reply-To: <lsq.1587683027.831233700@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.83-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit add9d56d7b3781532208afbff5509d7382fb6efe upstream.

The current PCM code doesn't initialize explicitly the buffers
allocated for PCM streams, hence it might leak some uninitialized
kernel data or previous stream contents by mmapping or reading the
buffer before actually starting the stream.

Since this is a common problem, this patch simply adds the clearance
of the buffer data at hw_params callback.  Although this does only
zero-clear no matter which format is used, which doesn't mean the
silence for some formats, but it should be OK because the intention is
just to clear the previous data on the buffer.

Reported-by: Lionel Koenig <lionel.koenig@gmail.com>
Link: https://lore.kernel.org/r/20191211155742.3213-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/pcm_native.c | 4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -459,6 +459,10 @@ static int snd_pcm_hw_params(struct snd_
 	while (runtime->boundary * 2 <= LONG_MAX - runtime->buffer_size)
 		runtime->boundary *= 2;
 
+	/* clear the buffer for avoiding possible kernel info leaks */
+	if (runtime->dma_area)
+		memset(runtime->dma_area, 0, runtime->dma_bytes);
+
 	snd_pcm_timer_resolution_change(substream);
 	snd_pcm_set_state(substream, SNDRV_PCM_STATE_SETUP);
 

