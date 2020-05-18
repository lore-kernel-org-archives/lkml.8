Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739DAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E0E20671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824153;
	bh=eDNVAQR9bAqbtW3RfWRqf3JH/mbMza7PvaMw3TiDEdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rfAGvBLirgfcbiQV+8hNFl53kwSqAqWygAf/we+VYRLDnENgILUonrPc+yT5/463a
	 TdCyIg9pdsSVFvbB3XDcAdwnLoVhXLYY5w2Ww/61pfPnyotLvBPbO+55r8Gl7hgIbj
	 v6j9K3Lmx6hE+giJ4GIjaGQwUq5wd7hFL7IjKHJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgERRtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:49:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729669AbgERRtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:49:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F05E120715;
        Mon, 18 May 2020 17:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824147;
        bh=eDNVAQR9bAqbtW3RfWRqf3JH/mbMza7PvaMw3TiDEdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2IZ6UAUQTqUR39T7VhmwJCNgINcAzaEc/S1ht2J2PiiI9jJQIkKcQdhinr3l2WrE/
         IjbjKQX0GmilW6qzrvvesMo2qRZVhwIIrBIsfjq4owxKX0gdNFZ64ZBnVYYayFo44w
         GyxOFwdqefUCwCWDPF14z0mIzN4/V4b/B6Vj5Ctw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+194dffdb8b22fc5d207a@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 091/114] ALSA: rawmidi: Initialize allocated buffers
Date:   Mon, 18 May 2020 19:37:03 +0200
Message-Id: <20200518173518.607030025@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173503.033975649@linuxfoundation.org>
References: <20200518173503.033975649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 5a7b44a8df822e0667fc76ed7130252523993bda upstream.

syzbot reported the uninitialized value exposure in certain situations
using virmidi loop.  It's likely a very small race at writing and
reading, and the influence is almost negligible.  But it's safer to
paper over this just by replacing the existing kvmalloc() with
kvzalloc().

Reported-by: syzbot+194dffdb8b22fc5d207a@syzkaller.appspotmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/rawmidi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -125,7 +125,7 @@ static int snd_rawmidi_runtime_create(st
 		runtime->avail = 0;
 	else
 		runtime->avail = runtime->buffer_size;
-	if ((runtime->buffer = kmalloc(runtime->buffer_size, GFP_KERNEL)) == NULL) {
+	if ((runtime->buffer = kzalloc(runtime->buffer_size, GFP_KERNEL)) == NULL) {
 		kfree(runtime);
 		return -ENOMEM;
 	}
@@ -650,7 +650,7 @@ int snd_rawmidi_output_params(struct snd
 		return -EINVAL;
 	}
 	if (params->buffer_size != runtime->buffer_size) {
-		newbuf = kmalloc(params->buffer_size, GFP_KERNEL);
+		newbuf = kzalloc(params->buffer_size, GFP_KERNEL);
 		if (!newbuf)
 			return -ENOMEM;
 		spin_lock_irq(&runtime->lock);


