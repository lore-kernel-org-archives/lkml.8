Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE58C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B622074E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgCMX4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:56:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50082 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbgCMXyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:02 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7t-00B6bd-Nb; Fri, 13 Mar 2020 23:54:01 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 35/69] do_last(): merge the may_open() calls
Date:   Fri, 13 Mar 2020 23:53:23 +0000
Message-Id: <20200313235357.2646756-35-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
References: <20200313235303.GP23230@ZenIV.linux.org.uk>
 <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

have FMODE_OPENED case rejoin the main path at earlier point

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 7e932d9a71a9..2f8a5d3be784 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3207,10 +3207,7 @@ static const char *do_last(struct nameidata *nd,
 		audit_inode(nd->name, file->f_path.dentry, 0);
 		dput(nd->path.dentry);
 		nd->path.dentry = dentry;
-		error = may_open(&nd->path, acc_mode, open_flag);
-		if (error)
-			goto out;
-		goto opened;
+		goto finish_open_created;
 	}
 
 	if (file->f_mode & FMODE_CREATED) {
@@ -3277,11 +3274,10 @@ static const char *do_last(struct nameidata *nd,
 	error = may_open(&nd->path, acc_mode, open_flag);
 	if (error)
 		goto out;
-	BUG_ON(file->f_mode & FMODE_OPENED); /* once it's opened, it's opened */
-	error = vfs_open(&nd->path, file);
+	if (!(file->f_mode & FMODE_OPENED))
+		error = vfs_open(&nd->path, file);
 	if (error)
 		goto out;
-opened:
 	error = ima_file_check(file, op->acc_mode);
 	if (!error && will_truncate)
 		error = handle_truncate(file);
-- 
2.11.0

