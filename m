Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DC8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B23E2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgG2Fav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 01:30:51 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51150 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgG2Fau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 01:30:50 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06T5UUEP052197;
        Wed, 29 Jul 2020 14:30:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Wed, 29 Jul 2020 14:30:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06T5UOZI052019
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 29 Jul 2020 14:30:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+c37a14770d51a085a520@syzkaller.appspotmail.com>
Subject: [PATCH] vt: Handle recursion in vc_do_resize().
Date:   Wed, 29 Jul 2020 14:30:20 +0900
Message-Id: <1596000620-4075-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting OOB read bug in vc_do_resize() [1] caused by memcpy()
based on outdated old_{rows,row_size} values, for resize_screen() can
recurse into vc_do_resize() which changes vc->vc_{cols,rows} that outdates
old_{rows,row_size} values which were read before calling resize_screen().

Minimal fix might be to read vc->vc_{rows,size_row} after resize_screen().
A different fix might be to forbid recursive vc_do_resize() request.
I can't tell which fix is the better.

But since I guess that new_cols == vc->vc_cols && new_rows == vc->vc_rows
check could become true after returning from resize_screen(), and I assume
that not calling clear_selection() when resize_screen() will return error
is harmless, let's redo the check by moving resize_screen() earlier.

[1] https://syzkaller.appspot.com/bug?id=c70c88cfd16dcf6e1d3c7f0ab8648b3144b5b25e

Reported-by: syzbot <syzbot+c37a14770d51a085a520@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/tty/vt/vt.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 42d8c67..952a067 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1217,7 +1217,24 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 
 	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
 		return 0;
+	if (new_screen_size > KMALLOC_MAX_SIZE || !new_screen_size)
+		return -EINVAL;
 
+	/*
+	 * Since fbcon_resize() from resize_screen() can recurse into
+	 * this function via fb_set_var(), handle recursion now.
+	 */
+	err = resize_screen(vc, new_cols, new_rows, user);
+	if (err)
+		return err;
+	/* Reload values in case recursion changed vc->vc_{cols,rows}. */
+	new_cols = (cols ? cols : vc->vc_cols);
+	new_rows = (lines ? lines : vc->vc_rows);
+	new_row_size = new_cols << 1;
+	new_screen_size = new_row_size * new_rows;
+
+	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
+		return 0;
 	if (new_screen_size > KMALLOC_MAX_SIZE || !new_screen_size)
 		return -EINVAL;
 	newscreen = kzalloc(new_screen_size, GFP_USER);
@@ -1238,13 +1255,6 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	old_rows = vc->vc_rows;
 	old_row_size = vc->vc_size_row;
 
-	err = resize_screen(vc, new_cols, new_rows, user);
-	if (err) {
-		kfree(newscreen);
-		vc_uniscr_free(new_uniscr);
-		return err;
-	}
-
 	vc->vc_rows = new_rows;
 	vc->vc_cols = new_cols;
 	vc->vc_size_row = new_row_size;
-- 
1.8.3.1

