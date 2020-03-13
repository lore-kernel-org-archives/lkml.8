Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8122C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A4420637
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgCMXyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:54:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50118 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgCMXyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:04 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7v-00B6cV-26; Fri, 13 Mar 2020 23:54:03 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 44/69] follow_dotdot{,_rcu}(): lift switching nd->path to parent out of loop
Date:   Fri, 13 Mar 2020 23:53:32 +0000
Message-Id: <20200313235357.2646756-44-viro@ZenIV.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 88e5d7920540..772d82daf3b4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1365,7 +1365,9 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 
 static int follow_dotdot_rcu(struct nameidata *nd)
 {
+	struct dentry *parent = NULL;
 	struct inode *inode = nd->inode;
+	unsigned seq;
 
 	while (1) {
 		if (path_equal(&nd->path, &nd->root)) {
@@ -1375,15 +1377,12 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 		}
 		if (nd->path.dentry != nd->path.mnt->mnt_root) {
 			struct dentry *old = nd->path.dentry;
-			struct dentry *parent = old->d_parent;
-			unsigned seq;
 
+			parent = old->d_parent;
 			inode = parent->d_inode;
 			seq = read_seqcount_begin(&parent->d_seq);
 			if (unlikely(read_seqcount_retry(&old->d_seq, nd->seq)))
 				return -ECHILD;
-			nd->path.dentry = parent;
-			nd->seq = seq;
 			if (unlikely(!path_connected(nd->path.mnt, parent)))
 				return -ECHILD;
 			break;
@@ -1406,6 +1405,10 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 			nd->seq = seq;
 		}
 	}
+	if (likely(parent)) {
+		nd->path.dentry = parent;
+		nd->seq = seq;
+	}
 	while (unlikely(d_mountpoint(nd->path.dentry))) {
 		struct mount *mounted;
 		mounted = __lookup_mnt(nd->path.mnt, nd->path.dentry);
@@ -1442,7 +1445,7 @@ static void follow_mount(struct path *path)
 
 static int follow_dotdot(struct nameidata *nd)
 {
-	struct dentry *parent;
+	struct dentry *parent = NULL;
 	while (1) {
 		if (path_equal(&nd->path, &nd->root)) {
 			if (unlikely(nd->flags & LOOKUP_BENEATH))
@@ -1452,13 +1455,10 @@ static int follow_dotdot(struct nameidata *nd)
 		if (nd->path.dentry != nd->path.mnt->mnt_root) {
 			/* rare case of legitimate dget_parent()... */
 			parent = dget_parent(nd->path.dentry);
-
 			if (unlikely(!path_connected(nd->path.mnt, parent))) {
 				dput(parent);
 				return -ENOENT;
 			}
-			dput(nd->path.dentry);
-			nd->path.dentry = parent;
 			break;
 		}
 		if (!follow_up(&nd->path))
@@ -1466,6 +1466,10 @@ static int follow_dotdot(struct nameidata *nd)
 		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
 			return -EXDEV;
 	}
+	if (likely(parent)) {
+		dput(nd->path.dentry);
+		nd->path.dentry = parent;
+	}
 	follow_mount(&nd->path);
 	nd->inode = nd->path.dentry->d_inode;
 	return 0;
-- 
2.11.0

