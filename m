Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C639C433F8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D6D720838
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595858802;
	bh=N9rfu8Rm9dG6SIRtmK83SO4PfCqaxsXzeswlY0y/zTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AYwlEYcbUV4864/diEdE2/82le7cTziZR0t+X3IV6OZy7Gp/u1nrZyZYjtKBG4LN/
	 QYtczNAfpYhH1hJIqcYx4LnDE+RsFTvI4HbtGVWwWZk3HASUuOjGKxJuYfvtyjjagu
	 5CCeCpbkEQutsIFGqqKNecc6N7Ck4JRrH59gRHqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgG0OGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:06:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbgG0OGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:06:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 466CA2250E;
        Mon, 27 Jul 2020 14:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595858798;
        bh=N9rfu8Rm9dG6SIRtmK83SO4PfCqaxsXzeswlY0y/zTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wMUKSiJlc0XtDSOKo454tU23IvRMAypJh1vpVVzODLms2dIuUKfMQSRZ+Ky1YUJGP
         DyCFh0prWtFd+Fr7cCZ/XS8TCElcM6qaoobTwnuAnBJHfEJdMKirQMPiexgMM4tnnA
         vRtX+r8tDMC/q93+SuxGKpdBdB4FHTaAfXz4YwMg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+e42d0746c3c3699b6061@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 16/64] ALSA: info: Drop WARN_ON() from buffer NULL sanity check
Date:   Mon, 27 Jul 2020 16:03:55 +0200
Message-Id: <20200727134911.833341128@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134911.020675249@linuxfoundation.org>
References: <20200727134911.020675249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 60379ba08532eca861e933b389526a4dc89e0c42 upstream.

snd_info_get_line() has a sanity check of NULL buffer -- both buffer
itself being NULL and buffer->buffer being NULL.  Basically both
checks are valid and necessary, but the problem is that it's with
snd_BUG_ON() macro that triggers WARN_ON().  The latter condition
(NULL buffer->buffer) can be met arbitrarily by user since the buffer
is allocated at the first write, so it means that user can trigger
WARN_ON() at will.

This patch addresses it by simply moving buffer->buffer NULL check out
of snd_BUG_ON() so that spurious WARNING is no longer triggered.

Reported-by: syzbot+e42d0746c3c3699b6061@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200717084023.5928-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/info.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -634,7 +634,9 @@ int snd_info_get_line(struct snd_info_bu
 {
 	int c = -1;
 
-	if (snd_BUG_ON(!buffer || !buffer->buffer))
+	if (snd_BUG_ON(!buffer))
+		return 1;
+	if (!buffer->buffer)
 		return 1;
 	if (len <= 0 || buffer->stop || buffer->error)
 		return 1;


