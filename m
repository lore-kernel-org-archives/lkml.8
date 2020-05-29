Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EBBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D9C2075F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437955AbgE2AE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 20:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437912AbgE2AEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 20:04:22 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D18C08C5C7;
        Thu, 28 May 2020 17:04:21 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSVY-00HELm-49; Fri, 29 May 2020 00:04:20 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] dlmfs: convert dlmfs_file_read() to copy_to_user()
Date:   Fri, 29 May 2020 01:04:19 +0100
Message-Id: <20200529000419.4106697-2-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200529000419.4106697-1-viro@ZenIV.linux.org.uk>
References: <20200529000345.GV23230@ZenIV.linux.org.uk>
 <20200529000419.4106697-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ocfs2/dlmfs/dlmfs.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 8e4f1ace467c..92f0a3bc3ac5 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -227,7 +227,7 @@ static ssize_t dlmfs_file_read(struct file *filp,
 			       loff_t *ppos)
 {
 	int bytes_left;
-	ssize_t readlen, got;
+	ssize_t got;
 	char *lvb_buf;
 	struct inode *inode = file_inode(filp);
 
@@ -237,36 +237,31 @@ static ssize_t dlmfs_file_read(struct file *filp,
 	if (*ppos >= i_size_read(inode))
 		return 0;
 
+	/* don't read past the lvb */
+	if (count > i_size_read(inode) - *ppos)
+		count = i_size_read(inode) - *ppos;
+
 	if (!count)
 		return 0;
 
-	if (!access_ok(buf, count))
-		return -EFAULT;
-
-	/* don't read past the lvb */
-	if ((count + *ppos) > i_size_read(inode))
-		readlen = i_size_read(inode) - *ppos;
-	else
-		readlen = count;
-
-	lvb_buf = kmalloc(readlen, GFP_NOFS);
+	lvb_buf = kmalloc(count, GFP_NOFS);
 	if (!lvb_buf)
 		return -ENOMEM;
 
-	got = user_dlm_read_lvb(inode, lvb_buf, readlen);
+	got = user_dlm_read_lvb(inode, lvb_buf, count);
 	if (got) {
-		BUG_ON(got != readlen);
-		bytes_left = __copy_to_user(buf, lvb_buf, readlen);
-		readlen -= bytes_left;
+		BUG_ON(got != count);
+		bytes_left = copy_to_user(buf, lvb_buf, count);
+		count -= bytes_left;
 	} else
-		readlen = 0;
+		count = 0;
 
 	kfree(lvb_buf);
 
-	*ppos = *ppos + readlen;
+	*ppos = *ppos + count;
 
-	mlog(0, "read %zd bytes\n", readlen);
-	return readlen;
+	mlog(0, "read %zu bytes\n", count);
+	return count;
 }
 
 static ssize_t dlmfs_file_write(struct file *filp,
-- 
2.11.0

