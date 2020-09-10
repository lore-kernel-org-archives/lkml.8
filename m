Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D1AC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A6821556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgIJW5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:57:12 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50302 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgIJW5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 18:57:10 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 08AMv8qc089110;
        Fri, 11 Sep 2020 07:57:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Fri, 11 Sep 2020 07:57:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 08AMv7Ii089106
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 11 Sep 2020 07:57:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: [PATCH] fbcon: Fix user font detection test at fbcon_resize().
To:     syzbot <syzbot+b38b1ef6edf0c74a8d97@syzkaller.appspotmail.com>,
        george.kennedy@oracle.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000024be1505ad487cbb@google.com>
Cc:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, natechancellor@gmail.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <f6e3e611-8704-1263-d163-f52c906a4f06@I-love.SAKURA.ne.jp>
Date:   Fri, 11 Sep 2020 07:57:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <00000000000024be1505ad487cbb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting OOB read at fbcon_resize() [1], for
commit 39b3cffb8cf31117 ("fbcon: prevent user font height or width change
 from causing potential out-of-bounds access") is by error using
registered_fb[con2fb_map[vc->vc_num]]->fbcon_par->p->userfont (which was
set to non-zero) instead of fb_display[vc->vc_num].userfont (which remains
zero for that display).

We could remove tricky userfont flag [2], for we can determine it by
comparing address of the font data and addresses of built-in font data.
But since that commit is failing to fix the original OOB read [3], this
patch keeps the change minimal in case we decide to revert altogether.

[1] https://syzkaller.appspot.com/bug?id=ebcbbb6576958a496500fee9cf7aa83ea00b5920
[2] https://syzkaller.appspot.com/text?tag=Patch&x=14030853900000
[3] https://syzkaller.appspot.com/bug?id=6fba8c186d97cf1011ab17660e633b1cc4e080c9

Reported-by: syzbot <syzbot+b38b1ef6edf0c74a8d97@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 39b3cffb8cf31117 ("fbcon: prevent user font height or width change from causing potential out-of-bounds access")
Cc: George Kennedy <george.kennedy@oracle.com>
---
 drivers/video/fbdev/core/fbcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 66167830fefd..dae7ae7f225a 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2203,7 +2203,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 	struct fb_var_screeninfo var = info->var;
 	int x_diff, y_diff, virt_w, virt_h, virt_fw, virt_fh;
 
-	if (ops->p && ops->p->userfont && FNTSIZE(vc->vc_font.data)) {
+	if (p->userfont && FNTSIZE(vc->vc_font.data)) {
 		int size;
 		int pitch = PITCH(vc->vc_font.width);
 
-- 
2.18.4


