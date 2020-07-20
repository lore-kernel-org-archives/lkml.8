Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA75AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5848206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261539;
	bh=tRcWTGEvoCkG7qVu7iz7j3Heu/lnCqZe1Tuh5KAvBcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cJTNc4h7G3OnXsd3ssuwCfmzgl6BBvtDWqk8h27hTIcx9OJ/HwXhS//Crlb83uerj
	 arTHbM/MQgbLbeZaeBGZKnWl+rOGrE6hJHcerTCMEU8fFT7+4/JZkDhvBtMvgg7jOy
	 x95hCC1ftBriJX+qPkybCmcJLyPbrqOZKCac2B7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbgGTQMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387924AbgGTQMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:12:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C6E220684;
        Mon, 20 Jul 2020 16:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261533;
        bh=tRcWTGEvoCkG7qVu7iz7j3Heu/lnCqZe1Tuh5KAvBcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dAAy/jRdGoIYV+43sct9UBQX9BSvahAeKMEvFBbZN9QwDSwuzkX9asNjpXi4JiF4x
         TMAujO6NbbCHqAL7Z2ZcJRzVMnqNPCskwvb87SpskGbP23rByHgU7wh9uNsipKfFpz
         7JH0oJeOkM8ZsdtibyYgWm+byivMgRb8vyPBxlV8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c190f6858a04ea7fbc52@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.7 151/244] ALSA: line6: Perform sanity check for each URB creation
Date:   Mon, 20 Jul 2020 17:37:02 +0200
Message-Id: <20200720152833.034137499@linuxfoundation.org>
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

commit 6e8a914ad619042c5f25a4feb663357c4170fd8d upstream.

LINE6 drivers create stream URBs with a fixed pipe without checking
its validity, and this may lead to a kernel WARNING at the submission
when a malformed USB descriptor is passed.

For avoiding the kernel warning, perform the similar sanity checks for
each pipe type at creating a URB.

Reported-by: syzbot+c190f6858a04ea7fbc52@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/s5hv9iv4hq8.wl-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/line6/capture.c  |    2 ++
 sound/usb/line6/playback.c |    2 ++
 2 files changed, 4 insertions(+)

--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -286,6 +286,8 @@ int line6_create_audio_in_urbs(struct sn
 		urb->interval = LINE6_ISO_INTERVAL;
 		urb->error_count = 0;
 		urb->complete = audio_in_callback;
+		if (usb_urb_ep_type_check(urb))
+			return -EINVAL;
 	}
 
 	return 0;
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -431,6 +431,8 @@ int line6_create_audio_out_urbs(struct s
 		urb->interval = LINE6_ISO_INTERVAL;
 		urb->error_count = 0;
 		urb->complete = audio_out_callback;
+		if (usb_urb_ep_type_check(urb))
+			return -EINVAL;
 	}
 
 	return 0;


