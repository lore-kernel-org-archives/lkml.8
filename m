Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9F8C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 21:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD810246B7
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 21:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgCAVz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 16:55:58 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41574 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgCAVwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:43 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WVt-003fMY-OG; Sun, 01 Mar 2020 21:52:41 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 09/55] do_last(): collapse the call of path_to_nameidata()
Date:   Sun,  1 Mar 2020 21:51:54 +0000
Message-Id: <20200301215240.873899-9-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301215240.873899-1-viro@ZenIV.linux.org.uk>
References: <20200301215125.GA873525@ZenIV.linux.org.uk>
 <20200301215240.873899-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... and shift filling struct path to just before the call of
handle_mounts().  All callers of handle_mounts() are
immediately preceded by path->mnt = nd->path.mnt now.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4946d006ba20..f26af0559abf 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3364,8 +3364,6 @@ static int do_last(struct nameidata *nd,
 		error = PTR_ERR(dentry);
 		goto out;
 	}
-	path.mnt = nd->path.mnt;
-	path.dentry = dentry;
 
 	if (file->f_mode & FMODE_OPENED) {
 		if ((file->f_mode & FMODE_CREATED) ||
@@ -3382,7 +3380,8 @@ static int do_last(struct nameidata *nd,
 		open_flag &= ~O_TRUNC;
 		will_truncate = false;
 		acc_mode = 0;
-		path_to_nameidata(&path, nd);
+		dput(nd->path.dentry);
+		nd->path.dentry = dentry;
 		goto finish_open_created;
 	}
 
@@ -3396,6 +3395,8 @@ static int do_last(struct nameidata *nd,
 		got_write = false;
 	}
 
+	path.mnt = nd->path.mnt;
+	path.dentry = dentry;
 	error = handle_mounts(&path, nd, &inode, &seq);
 	if (unlikely(error < 0))
 		return error;
-- 
2.11.0

