Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AC7C32771
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 03:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0667F206D5
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 03:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgASDTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 22:19:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56710 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgASDTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:19:32 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1it175-00BFWK-1Z; Sun, 19 Jan 2020 03:19:00 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 05/17] make build_open_flags() treat O_CREAT | O_EXCL as implying O_NOFOLLOW
Date:   Sun, 19 Jan 2020 03:17:17 +0000
Message-Id: <20200119031738.2681033-5-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200119031738.2681033-1-viro@ZenIV.linux.org.uk>
References: <20200119031423.GV8904@ZenIV.linux.org.uk>
 <20200119031738.2681033-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

O_CREAT | O_EXCL means "-EEXIST if we run into a trailing symlink".
As it is, we might or might not have LOOKUP_FOLLOW in op->intent
in that case - that depends upon having O_NOFOLLOW in open flags.
It doesn't matter, since we won't be checking it in that case -
do_last() bails out earlier.

However, making sure it's not set (i.e. acting as if we had an explicit
O_NOFOLLOW) makes the behaviour more explicit and allows to reorder the
check for O_CREAT | O_EXCL in do_last() with the call of step_into()
immediately following it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 15 +++++----------
 fs/open.c  |  4 +++-
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3b6f60c02f8a..c19b458f66da 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3262,22 +3262,17 @@ static int do_last(struct nameidata *nd,
 	if (unlikely(error < 0))
 		return error;
 
-	/*
-	 * create/update audit record if it already exists.
-	 */
-	audit_inode(nd->name, path.dentry, 0);
-
-	if (unlikely((open_flag & (O_EXCL | O_CREAT)) == (O_EXCL | O_CREAT))) {
-		path_to_nameidata(&path, nd);
-		return -EEXIST;
-	}
-
 	seq = 0;	/* out of RCU mode, so the value doesn't matter */
 	inode = d_backing_inode(path.dentry);
 finish_lookup:
 	error = step_into(nd, &path, 0, inode, seq);
 	if (unlikely(error))
 		return error;
+
+	if (unlikely((open_flag & (O_EXCL | O_CREAT)) == (O_EXCL | O_CREAT))) {
+		audit_inode(nd->name, nd->path.dentry, 0);
+		return -EEXIST;
+	}
 finish_open:
 	/* Why this, you ask?  _Now_ we might have grown LOOKUP_JUMPED... */
 	error = complete_walk(nd);
diff --git a/fs/open.c b/fs/open.c
index b62f5c0923a8..ba7009a5dd1a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1014,8 +1014,10 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 
 	if (flags & O_CREAT) {
 		op->intent |= LOOKUP_CREATE;
-		if (flags & O_EXCL)
+		if (flags & O_EXCL) {
 			op->intent |= LOOKUP_EXCL;
+			flags |= O_NOFOLLOW;
+		}
 	}
 
 	if (flags & O_DIRECTORY)
-- 
2.20.1

