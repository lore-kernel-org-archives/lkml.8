Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A54C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F0E82080C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599589997;
	bh=ClG/J2D28CSekcsEzvDrVhqfY9dWzpT8JjtNaDePcb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mQq3piQ7IAhhiuLilOc+BRbJsmi4GHaCKVgTMcy+0VfJIUK1dye7sJ1S9guMZRFxj
	 DVBHQhQPOkEnrAhDHuwHz/T4F1T4jLGQTmV5NOiLiccDjk5W92KjkK3j8fDw4SGhX3
	 zRrjPTPHndOAI9Ohad3jGrv4YQaAWlheAAsWYNKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbgIHScu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:32:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731376AbgIHQJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:09:35 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBE602463C;
        Tue,  8 Sep 2020 15:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580194;
        bh=ClG/J2D28CSekcsEzvDrVhqfY9dWzpT8JjtNaDePcb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZhnRetBX7O+lQRdOxYYKWUoCrqsDMv8zn0Orp4R7SjIykNaRhleYQDK0I+PKBy1v
         YYTjXZWBAC3tJsAXApUYcw24+76C8PegvhUBxPXJ/z1AYmoW+V232/9ciL+FQezQPI
         yfetfik8z+HsvC5GeLTMWe2t/hPwVokfKnFqMrfg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+23b22dc2e0b81cbfcc95@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 67/88] ALSA: pcm: oss: Remove superfluous WARN_ON() for mulaw sanity check
Date:   Tue,  8 Sep 2020 17:26:08 +0200
Message-Id: <20200908152224.511519032@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152221.082184905@linuxfoundation.org>
References: <20200908152221.082184905@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 949a1ebe8cea7b342085cb6a4946b498306b9493 upstream.

The PCM OSS mulaw plugin has a check of the format of the counter part
whether it's a linear format.  The check is with snd_BUG_ON() that
emits WARN_ON() when the debug config is set, and it confuses
syzkaller as if it were a serious issue.  Let's drop snd_BUG_ON() for
avoiding that.

While we're at it, correct the error code to a more suitable, EINVAL.

Reported-by: syzbot+23b22dc2e0b81cbfcc95@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200901131802.18157-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/oss/mulaw.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/core/oss/mulaw.c
+++ b/sound/core/oss/mulaw.c
@@ -329,8 +329,8 @@ int snd_pcm_plugin_build_mulaw(struct sn
 		snd_BUG();
 		return -EINVAL;
 	}
-	if (snd_BUG_ON(!snd_pcm_format_linear(format->format)))
-		return -ENXIO;
+	if (!snd_pcm_format_linear(format->format))
+		return -EINVAL;
 
 	err = snd_pcm_plugin_build(plug, "Mu-Law<->linear conversion",
 				   src_format, dst_format,


