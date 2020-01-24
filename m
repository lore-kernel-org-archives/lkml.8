Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D0BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EFA2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864816;
	bh=5gZIdXjDW6/+i/y36duw1EBwJYjZQ2+Kg5kHeNRuC+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G7SbmsUdOjI6HmBS2NkNtJCGxoFp1k+ZXrlGpYzdDjm5mHgX4uWH1MlmmyvEESiCb
	 aH5CGfVpRl9CHTJ7O9c2EkWvM0wrLuthfctI+45FeusMNMF32M410o4+CqRTbb+bTW
	 aG4Uf0tLcLcCkB6SrnqiCjkfM7R6AoXOn0Zs2peI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390896AbgAXLUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:20:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390646AbgAXLUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:20:12 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC0F12087E;
        Fri, 24 Jan 2020 11:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864811;
        bh=5gZIdXjDW6/+i/y36duw1EBwJYjZQ2+Kg5kHeNRuC+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MLSiWDpnDuMD3U8olZv3rw/H4Z1jeX6I1BovkzHO99zUPDX9p46bCWldFnvapHZga
         LEmwJeUaF03NSgn1BERfMrB0/NBC1e2nVVX0lEw21T/HJ0eux4+e/xXASaffo6nOST
         0BX7aj5diIfijAZP/Pp6mr3MwCnNGVZulFeHSnQw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 359/639] ALSA: aica: Fix a long-time build breakage
Date:   Fri, 24 Jan 2020 10:28:49 +0100
Message-Id: <20200124093132.070010240@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 534420c6ff87d3052540f1fd346e0adcff440819 ]

The build of aica sound driver has been broken since the timer API
conversion and some code rewrite.  This patch fixes the breakage by
using the common substream field, as well as a bit cleaning up wrt the
timer handling in the code.

Fixes: d522bb6a105f ("ALSA: sh: aica: Convert timers to use timer_setup()")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/sh/aica.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index 2b26311405a42..ad3f71358486a 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -303,7 +303,7 @@ static void aica_period_elapsed(struct timer_list *t)
 {
 	struct snd_card_aica *dreamcastcard = from_timer(dreamcastcard,
 							      t, timer);
-	struct snd_pcm_substream *substream = dreamcastcard->timer_substream;
+	struct snd_pcm_substream *substream = dreamcastcard->substream;
 	/*timer function - so cannot sleep */
 	int play_period;
 	struct snd_pcm_runtime *runtime;
@@ -335,13 +335,6 @@ static void spu_begin_dma(struct snd_pcm_substream *substream)
 	dreamcastcard = substream->pcm->private_data;
 	/*get the queue to do the work */
 	schedule_work(&(dreamcastcard->spu_dma_work));
-	/* Timer may already be running */
-	if (unlikely(dreamcastcard->timer_substream)) {
-		mod_timer(&dreamcastcard->timer, jiffies + 4);
-		return;
-	}
-	timer_setup(&dreamcastcard->timer, aica_period_elapsed, 0);
-	dreamcastcard->timer_substream = substream;
 	mod_timer(&dreamcastcard->timer, jiffies + 4);
 }
 
@@ -379,8 +372,8 @@ static int snd_aicapcm_pcm_close(struct snd_pcm_substream
 {
 	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
 	flush_work(&(dreamcastcard->spu_dma_work));
-	if (dreamcastcard->timer_substream)
-		del_timer(&dreamcastcard->timer);
+	del_timer(&dreamcastcard->timer);
+	dreamcastcard->substream = NULL;
 	kfree(dreamcastcard->channel);
 	spu_disable();
 	return 0;
@@ -615,6 +608,7 @@ static int snd_aica_probe(struct platform_device *devptr)
 	       "Yamaha AICA Super Intelligent Sound Processor for SEGA Dreamcast");
 	/* Prepare to use the queue */
 	INIT_WORK(&(dreamcastcard->spu_dma_work), run_spu_dma);
+	timer_setup(&dreamcastcard->timer, aica_period_elapsed, 0);
 	/* Load the PCM 'chip' */
 	err = snd_aicapcmchip(dreamcastcard, 0);
 	if (unlikely(err < 0))
-- 
2.20.1



