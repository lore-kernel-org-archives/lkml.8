Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE3DC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 946FD20775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860317;
	bh=lCDe1J0ta32mUjIq8S4kkhH1ff10RVyb7a8ebk1b54g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f0LvZH+IVdNNoI8YIXA76hFAYX+pPnNWHrQl6Y/HHFAnU0KOgtBOjnH33pFlneBUG
	 WyNK146Hi1Gmeh2JVhuOPElZel9VcGXd0aONswHMMs3IUuUPBBKr3HEy9Eqgol5diU
	 n99afMadySilWGS0BPtknyBchWG8sMoPEVU/OeKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732807AbgG0Ob4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730910AbgG0OUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:20:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 717AE2070A;
        Mon, 27 Jul 2020 14:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859600;
        bh=lCDe1J0ta32mUjIq8S4kkhH1ff10RVyb7a8ebk1b54g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ScG+8CUkpqOOs0aRgtmP2anI5SwcWmTu/iXYg+GKGq7caPxNElwRvN6r6ZZCVEU+v
         zL96iQnWdVvlbw6lHjTkxhF5YUsfm0hgmAAE3SejVMsKqaztBUItqUOhAwmLwgwAqa
         aW/AahXjYIUrt949EQGVyiIv0qVo/W9Y0l7Gw4Wc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+e42d0746c3c3699b6061@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.7 034/179] ALSA: info: Drop WARN_ON() from buffer NULL sanity check
Date:   Mon, 27 Jul 2020 16:03:29 +0200
Message-Id: <20200727134934.332168171@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
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
@@ -606,7 +606,9 @@ int snd_info_get_line(struct snd_info_bu
 {
 	int c;
 
-	if (snd_BUG_ON(!buffer || !buffer->buffer))
+	if (snd_BUG_ON(!buffer))
+		return 1;
+	if (!buffer->buffer)
 		return 1;
 	if (len <= 0 || buffer->stop || buffer->error)
 		return 1;


