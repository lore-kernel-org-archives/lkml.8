Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A97C433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A6E206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261544;
	bh=VBfbCXXqdqWlWCplIuAS219MrbV1oelsnaXURMo+0I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gHJfXtlBDmtrHwIrTuKw0eBDQsxXplUe9ikyIohnXTbmzMVg1f/Den+r5bQrgG5zP
	 xxY8fh08kU6TEij+BDJPrOQ5gZSPaoPBlbqLWB3KyP9iPtTAwQhWBUn1z+4W3EAZQS
	 GdN0hZ1M5G4MBsGUZzuB+SQQqklOIyM08ogHYk5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbgGTQMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387932AbgGTQMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:12:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20ECF2064B;
        Mon, 20 Jul 2020 16:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261536;
        bh=VBfbCXXqdqWlWCplIuAS219MrbV1oelsnaXURMo+0I4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uhNZoLOPQBlYINLsg8an9Axuxz7Fg11KH0bsj1A+b0Um2z/n2JVouHXXuVxZiq+kg
         ad3Dmg8rktooJKeKd6ceRiUiNxBQhQzDC1yKShDV3ziVK5IHP2ITJyRFnXoapHPZLS
         lMKbTfaZG1INxKvFwrqGllNtCQ59CP3Ob89cLxio=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+145012a46658ac00fc9e@syzkaller.appspotmail.com,
        Alan Stern <stern@rowland.harvard.edu>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.7 152/244] ALSA: line6: Sync the pending work cancel at disconnection
Date:   Mon, 20 Jul 2020 17:37:03 +0200
Message-Id: <20200720152833.079370870@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
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


