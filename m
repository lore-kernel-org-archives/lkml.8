Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0599C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D1820637
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgCMX5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:57:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50030 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbgCMXyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:01 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7s-00B6aI-0v; Fri, 13 Mar 2020 23:54:00 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 22/69] merging pick_link() with get_link(), part 4
Date:   Fri, 13 Mar 2020 23:53:10 +0000
Message-Id: <20200313235357.2646756-22-viro@ZenIV.linux.org.uk>
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

Move the call of get_link() into walk_component().  Change the
calling conventions for walk_component() to returning the link
body to follow (if any).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 59 ++++++++++++++++++++++++++---------------------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index edb37272f2cc..a05de97e6893 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1866,7 +1866,7 @@ static int step_into(struct nameidata *nd, int flags,
 	return pick_link(nd, &path, inode, seq);
 }
 
-static int walk_component(struct nameidata *nd, int flags)
+static const char *walk_component(struct nameidata *nd, int flags)
 {
 	struct dentry *dentry;
 	struct inode *inode;
@@ -1881,19 +1881,24 @@ static int walk_component(struct nameidata *nd, int flags)
 		if (!(flags & WALK_MORE) && nd->depth)
 			put_link(nd);
 		err = handle_dots(nd, nd->last_type);
-		return err;
+		return ERR_PTR(err);
 	}
 	dentry = lookup_fast(nd, &inode, &seq);
 	if (IS_ERR(dentry))
-		return PTR_ERR(dentry);
+		return ERR_CAST(dentry);
 	if (unlikely(!dentry)) {
 		dentry = lookup_slow(&nd->last, nd->path.dentry, nd->flags);
 		if (IS_ERR(dentry))
-			return PTR_ERR(dentry);
+			return ERR_CAST(dentry);
 	}
 	if (!(flags & WALK_MORE) && nd->depth)
 		put_link(nd);
-	return step_into(nd, flags, dentry, inode, seq);
+	err = step_into(nd, flags, dentry, inode, seq);
+	if (!err)
+		return NULL;
+	if (err > 0)
+		return get_link(nd);
+	return ERR_PTR(err);
 }
 
 /*
@@ -2145,6 +2150,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 
 	/* At this point we know we have a real path component. */
 	for(;;) {
+		const char *link;
 		u64 hash_len;
 		int type;
 
@@ -2202,24 +2208,18 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 			if (!name)
 				return 0;
 			/* last component of nested symlink */
-			err = walk_component(nd, WALK_FOLLOW);
+			link = walk_component(nd, WALK_FOLLOW);
 		} else {
 			/* not the last component */
-			err = walk_component(nd, WALK_FOLLOW | WALK_MORE);
+			link = walk_component(nd, WALK_FOLLOW | WALK_MORE);
 		}
-		if (err < 0)
-			return err;
-
-		if (err) {
-			const char *s = get_link(nd);
-
-			if (IS_ERR(s))
-				return PTR_ERR(s);
-			if (likely(s)) {
-				nd->stack[nd->depth - 1].name = name;
-				name = s;
-				continue;
-			}
+		if (unlikely(link)) {
+			if (IS_ERR(link))
+				return PTR_ERR(link);
+			/* a symlink to follow */
+			nd->stack[nd->depth - 1].name = name;
+			name = link;
+			continue;
 		}
 		if (unlikely(!d_can_lookup(nd->path.dentry))) {
 			if (nd->flags & LOOKUP_RCU) {
@@ -2335,24 +2335,17 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 
 static inline const char *lookup_last(struct nameidata *nd)
 {
-	int err;
+	const char *link;
 	if (nd->last_type == LAST_NORM && nd->last.name[nd->last.len])
 		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 
 	nd->flags &= ~LOOKUP_PARENT;
-	err = walk_component(nd, 0);
-	if (unlikely(err)) {
-		const char *s;
-		if (err < 0)
-			return PTR_ERR(err);
-		s = get_link(nd);
-		if (s) {
-			nd->flags |= LOOKUP_PARENT;
-			nd->stack[0].name = NULL;
-			return s;
-		}
+	link = walk_component(nd, 0);
+	if (link) {
+		nd->flags |= LOOKUP_PARENT;
+		nd->stack[0].name = NULL;
 	}
-	return NULL;
+	return link;
 }
 
 static int handle_lookup_down(struct nameidata *nd)
-- 
2.11.0

