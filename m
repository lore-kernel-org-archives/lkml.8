Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DF4C35669
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 01:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B182120637
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 01:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgBWB0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 20:26:01 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50298 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgBWB0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 20:26:01 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5g1j-00HDq5-Jw; Sun, 23 Feb 2020 01:25:52 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v2 33/34] do_last(): rejoin the common path even earlier in FMODE_{OPENED,CREATED} case
Date:   Sun, 23 Feb 2020 01:16:25 +0000
Message-Id: <20200223011626.4103706-33-viro@ZenIV.linux.org.uk>
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

... getting may_create_in_sticky() checks in FMODE_OPENED case as well.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index ce6f2864a335..37cbe7806677 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3207,14 +3207,7 @@ static const char *do_last(struct nameidata *nd,
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
 
-	if (file->f_mode & FMODE_OPENED) {
-		audit_inode(nd->name, file->f_path.dentry, 0);
-		dput(nd->path.dentry);
-		nd->path.dentry = dentry;
-		goto finish_open_created;
-	}
-
-	if (file->f_mode & FMODE_CREATED) {
+	if (file->f_mode & (FMODE_OPENED | FMODE_CREATED)) {
 		dput(nd->path.dentry);
 		nd->path.dentry = dentry;
 		goto finish_open_created;
@@ -3238,7 +3231,9 @@ static const char *do_last(struct nameidata *nd,
 	error = complete_walk(nd);
 	if (error)
 		return ERR_PTR(error);
-	audit_inode(nd->name, nd->path.dentry, 0);
+finish_open_created:
+	if (!(file->f_mode & FMODE_CREATED))
+		audit_inode(nd->name, nd->path.dentry, 0);
 	if (open_flag & O_CREAT) {
 		if (d_is_dir(nd->path.dentry))
 			return ERR_PTR(-EISDIR);
@@ -3250,7 +3245,6 @@ static const char *do_last(struct nameidata *nd,
 	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
 		return ERR_PTR(-ENOTDIR);
 
-finish_open_created:
 	do_truncate = false;
 	acc_mode = op->acc_mode;
 	if (file->f_mode & FMODE_CREATED) {
-- 
2.11.0

