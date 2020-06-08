Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09222C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF4F206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="AND0CpYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgFHKGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 06:06:37 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:10618 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728745AbgFHKGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 06:06:34 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49gTRs19bxzY4;
        Mon,  8 Jun 2020 12:06:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1591610793; bh=CDrLC2kySs5OBNJvqoPu46VZEBqI3bBc1GI8m0d56kY=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=AND0CpYeEW677MDFgvTIx8zReIBMkD6olRKBzvkZOdeyRXBwmQTvOWiGG/iBeA7BS
         yX8DP+UguZnDbIuxjkyajal9FqWaBgxqph/knGrmulPBWffp38IYQXNa+8Eyrs2QOT
         NiAbq3Jsu+A9w3670L59ZP33sK2Y5CnpiPZoXyAvuu7GA6GsqC2v8qltNdO1cKlkzr
         bKsQ2v33ERBu5+zVjsyp6hZpSvWcgm4Y5pfZ3Z0EfC2ez9HSTQWz+dlBAfx0wsfHGb
         a401+jf5+fn4MHv3268WB6TYdDLlI5e07znuu+kblHpbo7wWoBxUFw9sPNHXyvC948
         w4BOzftnZDgNQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 08 Jun 2020 12:06:32 +0200
Message-Id: <37252c65941e58473b1219ca9fab03d48f47e3e3.1591610330.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1591610329.git.mirq-linux@rere.qmqm.pl>
References: <cover.1591610329.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/2] ALSA: pcm: fix snd_pcm_link() lockdep splat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and use snd_pcm_stream_lock_nested() in snd_pcm_link/unlink
implementation.  The code is fine, but generates a lockdep complaint:

============================================
WARNING: possible recursive locking detected
5.7.1mq+ #381 Tainted: G           O
--------------------------------------------
pulseaudio/4180 is trying to acquire lock:
ffff888402d6f508 (&group->lock){-...}-{2:2}, at: snd_pcm_common_ioctl+0xda8/0xee0 [snd_pcm]

but task is already holding lock:
ffff8883f7a8cf18 (&group->lock){-...}-{2:2}, at: snd_pcm_common_ioctl+0xe4e/0xee0 [snd_pcm]

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&group->lock);
  lock(&group->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by pulseaudio/4180:
 #0: ffffffffa1a05190 (snd_pcm_link_rwsem){++++}-{3:3}, at: snd_pcm_common_ioctl+0xca0/0xee0 [snd_pcm]
 #1: ffff8883f7a8cf18 (&group->lock){-...}-{2:2}, at: snd_pcm_common_ioctl+0xe4e/0xee0 [snd_pcm]
[...]

Cc: stable@vger.kernel.org
Fixes: f57f3df03a8e ("ALSA: pcm: More fine-grained PCM link locking")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 sound/core/pcm_native.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 3ad399cb6f30..5b36881f7095 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -138,6 +138,16 @@ void snd_pcm_stream_lock_irq(struct snd_pcm_substream *substream)
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_lock_irq);
 
+static void snd_pcm_stream_lock_nested(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_group *group = &substream->self_group;
+
+	if (substream->pcm->nonatomic)
+		mutex_lock_nested(&group->mutex, SINGLE_DEPTH_NESTING);
+	else
+		spin_lock_nested(&group->lock, SINGLE_DEPTH_NESTING);
+}
+
 /**
  * snd_pcm_stream_unlock_irq - Unlock the PCM stream
  * @substream: PCM substream
@@ -2200,7 +2210,7 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 	snd_pcm_stream_unlock_irq(substream);
 
 	snd_pcm_group_lock_irq(target_group, nonatomic);
-	snd_pcm_stream_lock(substream1);
+	snd_pcm_stream_lock_nested(substream1);
 	snd_pcm_group_assign(substream1, target_group);
 	refcount_inc(&target_group->refs);
 	snd_pcm_stream_unlock(substream1);
@@ -2216,7 +2226,7 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 
 static void relink_to_local(struct snd_pcm_substream *substream)
 {
-	snd_pcm_stream_lock(substream);
+	snd_pcm_stream_lock_nested(substream);
 	snd_pcm_group_assign(substream, &substream->self_group);
 	snd_pcm_stream_unlock(substream);
 }
-- 
2.20.1

