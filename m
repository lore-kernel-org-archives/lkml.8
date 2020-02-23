Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79506C35669
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 01:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56614206EF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 01:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgBWBYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 20:24:35 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50244 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgBWBYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 20:24:34 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5g0G-00HDmI-IU; Sun, 23 Feb 2020 01:24:23 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v2 28/34] atomic_open(): lift the call of may_open() into do_last()
Date:   Sun, 23 Feb 2020 01:16:20 +0000
Message-Id: <20200223011626.4103706-28-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
 <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

there we'll be able to merge it with its counterparts in other
cases, and there's no reason to do it before the parent has
been unlocked

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c2244ee4b2f0..16786be13050 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2956,23 +2956,12 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
 	d_lookup_done(dentry);
 	if (!error) {
 		if (file->f_mode & FMODE_OPENED) {
-			int acc_mode = op->acc_mode;
 			if (unlikely(dentry != file->f_path.dentry)) {
 				dput(dentry);
 				dentry = dget(file->f_path.dentry);
 			}
-			/*
-			 * We didn't have the inode before the open, so check open
-			 * permission here.
-			 */
-			if (file->f_mode & FMODE_CREATED) {
-				WARN_ON(!(open_flag & O_CREAT));
+			if (file->f_mode & FMODE_CREATED)
 				fsnotify_create(dir, dentry);
-				acc_mode = 0;
-			}
-			error = may_open(&file->f_path, acc_mode, open_flag);
-			if (WARN_ON(error > 0))
-				error = -EINVAL;
 		} else if (WARN_ON(file->f_path.dentry == DENTRY_NOT_SET)) {
 			error = -EIO;
 		} else {
@@ -3216,12 +3205,19 @@ static const char *do_last(struct nameidata *nd,
 	}
 
 	if (file->f_mode & FMODE_OPENED) {
-		if ((file->f_mode & FMODE_CREATED) ||
-		    !S_ISREG(file_inode(file)->i_mode))
+		if (file->f_mode & FMODE_CREATED) {
+			open_flag &= ~O_TRUNC;
+			will_truncate = false;
+			acc_mode = 0;
+		} else if (!S_ISREG(file_inode(file)->i_mode))
 			will_truncate = false;
 
 		audit_inode(nd->name, file->f_path.dentry, 0);
-		dput(dentry);
+		dput(nd->path.dentry);
+		nd->path.dentry = dentry;
+		error = may_open(&nd->path, acc_mode, open_flag);
+		if (error)
+			goto out;
 		goto opened;
 	}
 
-- 
2.11.0

