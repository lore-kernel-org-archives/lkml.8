Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6845FC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 442D422CBB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260937;
	bh=VBfbCXXqdqWlWCplIuAS219MrbV1oelsnaXURMo+0I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZyB56N9zczSJFbTDwaCOheYhLIr6uNNPC3VgXgF1SryA0VFAIJ5qR+M1uXz6Y21j9
	 zmE7zWaeDXTlaqJ8VI5qt9eCU6sU+3CY6Vq3ZUaeFqu0/JcAfgsSFhDnpmTM9SIpzh
	 sxSeJXuXUqigB1mDVzmCCQAmR0+Ja5w2AYv5k3uE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbgGTQCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:02:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732633AbgGTQCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:02:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BA5320773;
        Mon, 20 Jul 2020 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260930;
        bh=VBfbCXXqdqWlWCplIuAS219MrbV1oelsnaXURMo+0I4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cgWE44m92mZ0ezz+1H6aU6lXbD/oOijM6rW4ixDEkTny44z3vFTlT3OYbVDiLUJ3q
         eV3p17MamZ3V1FCxOtSzPJXkHdanqNqU5WrF4huSV9nBQlGhzu7Nyoq218C6ul1HzD
         9fdEJ9usQ4UZvbzxYGeb3K8x3UwrfZ/CJrBEGNAI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+145012a46658ac00fc9e@syzkaller.appspotmail.com,
        Alan Stern <stern@rowland.harvard.edu>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 148/215] ALSA: line6: Sync the pending work cancel at disconnection
Date:   Mon, 20 Jul 2020 17:37:10 +0200
Message-Id: <20200720152827.239641919@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 68359a1ad8447c99732ebeab8c169bfed543667a upstream.

Recently syzkaller reported a UAF in LINE6 driver, and it's likely
because we call cancel_delayed_work() at the disconnect callback
instead of cancel_delayed_work_sync().  Let's use the correct one
instead.

Reported-by: syzbot+145012a46658ac00fc9e@syzkaller.appspotmail.com
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/s5hlfjr4gio.wl-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/line6/driver.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -820,7 +820,7 @@ void line6_disconnect(struct usb_interfa
 	if (WARN_ON(usbdev != line6->usbdev))
 		return;
 
-	cancel_delayed_work(&line6->startup_work);
+	cancel_delayed_work_sync(&line6->startup_work);
 
 	if (line6->urb_listen != NULL)
 		line6_stop_listen(line6);


