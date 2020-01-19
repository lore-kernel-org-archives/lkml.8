Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312E4C32771
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 03:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04629206D5
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 03:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgASDUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 22:20:45 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56770 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgASDUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:20:45 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1it18B-00BFZ1-Ek; Sun, 19 Jan 2020 03:20:15 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 09/17] do_last(): collapse the call of path_to_nameidata()
Date:   Sun, 19 Jan 2020 03:17:21 +0000
Message-Id: <20200119031738.2681033-9-viro@ZenIV.linux.org.uk>
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

... and shift filling struct path to just before the call of
handle_mounts().  All callers of handle_mounts() are
immediately preceded by path->mnt = nd->path.mnt now.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 30503f114142..f66553ef436a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3230,8 +3230,6 @@ static int do_last(struct nameidata *nd,
 		error = PTR_ERR(dentry);
 		goto out;
 	}
-	path.mnt = nd->path.mnt;
-	path.dentry = dentry;
 
 	if (file->f_mode & FMODE_OPENED) {
 		if ((file->f_mode & FMODE_CREATED) ||
@@ -3247,7 +3245,8 @@ static int do_last(struct nameidata *nd,
 		open_flag &= ~O_TRUNC;
 		will_truncate = false;
 		acc_mode = 0;
-		path_to_nameidata(&path, nd);
+		dput(nd->path.dentry);
+		nd->path.dentry = dentry;
 		goto finish_open_created;
 	}
 
@@ -3261,6 +3260,8 @@ static int do_last(struct nameidata *nd,
 		got_write = false;
 	}
 
+	path.mnt = nd->path.mnt;
+	path.dentry = dentry;
 	error = handle_mounts(&path, nd, &inode, &seq);
 	if (unlikely(error < 0))
 		return error;
-- 
2.20.1

