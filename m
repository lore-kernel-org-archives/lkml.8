Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663DCC33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 16:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4210E206F0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 16:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgBAQ0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 11:26:49 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:60144 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgBAQ0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 11:26:47 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixvbZ-005myN-UK; Sat, 01 Feb 2020 16:26:46 +0000
Date:   Sat, 1 Feb 2020 16:26:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix do_last() regression
Message-ID: <20200201162645.GJ23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brown paperbag time: fetching ->i_uid/->i_mode really should've been
done from nd->inode.  I even suggested that, but the reason for that
has slipped through the cracks and I went for dir->d_inode instead -
made for more "obvious" patch.

Analysis:
	at the entry into do_last() and all the way to step_into(): dir
(aka nd->path.dentry) is known not to have been freed; so's nd->inode
and it's equal to dir->d_inode unless we are already doomed to -ECHILD.
inode of the file to get opened is not known.
	after step_into(): inode of the file to get opened is known;
dir might be pointing to freed memory/be negative/etc.
	at the call of may_create_in_sticky(): guaranteed to be out of
RCU mode; inode of the file to get opened is known and pinned;
dir might be garbage.

The last was the reason for the original patch.  Except that at the do_last()
entry we can be in RCU mode and it is possible that nd->path.dentry->d_inode
has already changed under us.  In that case we are going to fail with -ECHILD,
but we need to be careful; nd->inode is pointing to valid struct inode and
it's the same as nd->path.dentry->d_inode in "won't fail with -ECHILD"
case, so we should use that.

Reported-by: "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Reported-by: syzbot+190005201ced78a74ad6@syzkaller.appspotmail.com
Wearing-brown-paperbag: Al Viro <viro@zeniv.linux.org.uk>
Cc: stable@kernel.org
Fixes: d0cb50185ae9 (do_last(): fetch directory ->i_mode and ->i_uid before it's too late)
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namei.c b/fs/namei.c
index 4167109297e0..db6565c99825 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3333,8 +3333,8 @@ static int do_last(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
 	struct dentry *dir = nd->path.dentry;
-	kuid_t dir_uid = dir->d_inode->i_uid;
-	umode_t dir_mode = dir->d_inode->i_mode;
+	kuid_t dir_uid = nd->inode->i_uid;
+	umode_t dir_mode = nd->inode->i_mode;
 	int open_flag = op->open_flag;
 	bool will_truncate = (open_flag & O_TRUNC) != 0;
 	bool got_write = false;
