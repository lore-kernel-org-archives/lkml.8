Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DB4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E191420787
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgGJFxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 01:53:55 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50053 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgGJFxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 01:53:55 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06A5rZrH065489;
        Fri, 10 Jul 2020 14:53:35 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp);
 Fri, 10 Jul 2020 14:53:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06A5rVfa065467
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 10 Jul 2020 14:53:35 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+017265e8553724e514e8@syzkaller.appspotmail.com>
Subject: [PATCH] vt: Reject zero-sized screen buffer size.
Date:   Fri, 10 Jul 2020 14:53:29 +0900
Message-Id: <20200710055329.3759-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting general protection fault in do_con_write() [1] caused
by vc->vc_screenbuf == ZERO_SIZE_PTR caused by vc->vc_screenbuf_size == 0
caused by vc->vc_cols == vc->vc_rows == vc->vc_size_row == 0 being passed
to ioctl(FBIOPUT_VSCREENINFO) request on /dev/fb0 , for gotoxy(vc, 0, 0)
 from reset_terminal() from vc_init() from vc_allocate() on such console
causes vc->vc_pos == 0x10000000e due to
((unsigned long) ZERO_SIZE_PTR) + -1U * 0 + (-1U << 1).

I don't think that a console with 0 column and/or 0 row makes sense, and
I think that we can reject such bogus arguments in fb_set_var() from
ioctl(FBIOPUT_VSCREENINFO). Regardless, I think that it is safer to also
check ZERO_SIZE_PTR when allocating vc->vc_screenbuf from vc_allocate()
 from con_install() from tty_init_dev() from tty_open().

[1] https://syzkaller.appspot.com/bug?extid=017265e8553724e514e8

Reported-by: syzbot <syzbot+017265e8553724e514e8@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/tty/vt/vt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 48a8199f7845..8497e9206607 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1126,7 +1126,7 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
 		con_set_default_unimap(vc);
 
 	vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_KERNEL);
-	if (!vc->vc_screenbuf)
+	if (ZERO_OR_NULL_PTR(vc->vc_screenbuf))
 		goto err_free;
 
 	/* If no drivers have overridden us and the user didn't pass a
@@ -1212,7 +1212,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
 		return 0;
 
-	if (new_screen_size > KMALLOC_MAX_SIZE)
+	if (new_screen_size > KMALLOC_MAX_SIZE || !new_screen_size)
 		return -EINVAL;
 	newscreen = kzalloc(new_screen_size, GFP_USER);
 	if (!newscreen)
@@ -3393,6 +3393,7 @@ static int __init con_init(void)
 		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
 		tty_port_init(&vc->port);
 		visual_init(vc, currcons, 1);
+		/* Assuming vc->vc_screenbuf_size is sane here, for this is __init code. */
 		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
 		vc_init(vc, vc->vc_rows, vc->vc_cols,
 			currcons || !vc->vc_sw->con_save_screen);
-- 
2.18.4

