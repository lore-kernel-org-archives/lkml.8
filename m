Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87082C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F6620829
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgG2O5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:57:45 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64897 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2O5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:57:45 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06TEvC3h096906;
        Wed, 29 Jul 2020 23:57:12 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp);
 Wed, 29 Jul 2020 23:57:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06TEv5ul096808
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 29 Jul 2020 23:57:12 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+9116ecc1978ca3a12f43@syzkaller.appspotmail.com>
Subject: [PATCH] vt: defer kfree() of vc_screenbuf in vc_do_resize()
Date:   Wed, 29 Jul 2020 23:57:01 +0900
Message-Id: <1596034621-4714-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting UAF bug in set_origin() from vc_do_resize() [1], for
vc_do_resize() calls kfree(vc->vc_screenbuf) before calling set_origin().

Unfortunately, in set_origin(), vc->vc_sw->con_set_origin() might access
vc->vc_pos when scroll is involved in order to manipulate cursor, but
vc->vc_pos refers already released vc->vc_screenbuf until vc->vc_pos gets
updated based on the result of vc->vc_sw->con_set_origin().

Preserving old buffer and tolerating outdated vc members until set_origin()
completes would be easier than preventing vc->vc_sw->con_set_origin() from
accessing outdated vc members.

[1] https://syzkaller.appspot.com/bug?id=6649da2081e2ebdc65c0642c214b27fe91099db3

Reported-by: syzbot <syzbot+9116ecc1978ca3a12f43@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/tty/vt/vt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 42d8c67..c9ee8e9 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1196,7 +1196,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	unsigned int old_rows, old_row_size, first_copied_row;
 	unsigned int new_cols, new_rows, new_row_size, new_screen_size;
 	unsigned int user;
-	unsigned short *newscreen;
+	unsigned short *oldscreen, *newscreen;
 	struct uni_screen *new_uniscr = NULL;
 
 	WARN_CONSOLE_UNLOCKED();
@@ -1294,10 +1294,11 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	if (new_scr_end > new_origin)
 		scr_memsetw((void *)new_origin, vc->vc_video_erase_char,
 			    new_scr_end - new_origin);
-	kfree(vc->vc_screenbuf);
+	oldscreen = vc->vc_screenbuf;
 	vc->vc_screenbuf = newscreen;
 	vc->vc_screenbuf_size = new_screen_size;
 	set_origin(vc);
+	kfree(oldscreen);
 
 	/* do part of a reset_terminal() */
 	vc->vc_top = 0;
-- 
1.8.3.1

