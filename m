Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ADDC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFB820716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgA2Jkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 04:40:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:50856 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgA2Jkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 04:40:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B60A5ACF0;
        Wed, 29 Jan 2020 09:40:44 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Schneider <asn@cryptomilk.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.4.y] ALSA: pcm: Add missing copy ops check before clearing buffer
Date:   Wed, 29 Jan 2020 10:40:41 +0100
Message-Id: <20200129094041.12272-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ this is a fix specific to 4.4.y and 4.9.y stable trees;
  4.14.y and older already contain the right fix ]

The stable 4.4.y and 4.9.y backports of the upstream commit
add9d56d7b37 ("ALSA: pcm: Avoid possible info leaks from PCM stream
buffers") dropped the check of substream->ops->copy_user as copy_user
is a new member that isn't present in the older kernels.
Although upstream drivers should work without this NULL check, it may
cause a regression with a downstream driver that sets some
inaccessible address to runtime->dma_area, leading to a crash at
worst.

Since such drivers must have ops->copy member on older kernels instead
of ops->copy_user, this patch adds the missing check of ops->copy for
fixing the regression.

Reported-and-tested-by: Andreas Schneider <asn@cryptomilk.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index b9bfbf394959..59423576b1cc 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -588,7 +588,7 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 		runtime->boundary *= 2;
 
 	/* clear the buffer for avoiding possible kernel info leaks */
-	if (runtime->dma_area)
+	if (runtime->dma_area && !substream->ops->copy)
 		memset(runtime->dma_area, 0, runtime->dma_bytes);
 
 	snd_pcm_timer_resolution_change(substream);
-- 
2.16.4

