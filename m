Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C14C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22A4020897
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438077AbgE2ALB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 20:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437671AbgE2AKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 20:10:25 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3EEC08C5C7;
        Thu, 28 May 2020 17:10:25 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSbP-00HEZb-Lh; Fri, 29 May 2020 00:10:23 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] pcm_native: result of put_user() needs to be checked
Date:   Fri, 29 May 2020 01:10:23 +0100
Message-Id: <20200529001023.4107547-3-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200529001023.4107547-1-viro@ZenIV.linux.org.uk>
References: <20200529000957.GW23230@ZenIV.linux.org.uk>
 <20200529001023.4107547-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... and no, __put_user() doesn't help here - skipping
access_ok() on the second call does not remove the
possibility of page having become unmapped or r/o
in the meanwhile

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 sound/core/pcm_native.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index aef860256278..47838f57a647 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3093,7 +3093,8 @@ static int snd_pcm_xferi_frames_ioctl(struct snd_pcm_substream *substream,
 		result = snd_pcm_lib_write(substream, xferi.buf, xferi.frames);
 	else
 		result = snd_pcm_lib_read(substream, xferi.buf, xferi.frames);
-	__put_user(result, &_xferi->result);
+	if (put_user(result, &_xferi->result))
+		return -EFAULT;
 	return result < 0 ? result : 0;
 }
 
@@ -3122,7 +3123,8 @@ static int snd_pcm_xfern_frames_ioctl(struct snd_pcm_substream *substream,
 	else
 		result = snd_pcm_lib_readv(substream, bufs, xfern.frames);
 	kfree(bufs);
-	__put_user(result, &_xfern->result);
+	if (put_user(result, &_xfern->result))
+		return -EFAULT;
 	return result < 0 ? result : 0;
 }
 
@@ -3137,7 +3139,8 @@ static int snd_pcm_rewind_ioctl(struct snd_pcm_substream *substream,
 	if (put_user(0, _frames))
 		return -EFAULT;
 	result = snd_pcm_rewind(substream, frames);
-	__put_user(result, _frames);
+	if (put_user(result, _frames))
+		return -EFAULT;
 	return result < 0 ? result : 0;
 }
 
@@ -3152,7 +3155,8 @@ static int snd_pcm_forward_ioctl(struct snd_pcm_substream *substream,
 	if (put_user(0, _frames))
 		return -EFAULT;
 	result = snd_pcm_forward(substream, frames);
-	__put_user(result, _frames);
+	if (put_user(result, _frames))
+		return -EFAULT;
 	return result < 0 ? result : 0;
 }
 
-- 
2.11.0

