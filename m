Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664C5C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A492074E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgCMXz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:55:26 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50170 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbgCMXyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:06 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7x-00B6dy-6n; Fri, 13 Mar 2020 23:54:05 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 57/69] pick_link(): pass it struct path already with normal refcounting rules
Date:   Fri, 13 Mar 2020 23:53:45 +0000
Message-Id: <20200313235357.2646756-57-viro@ZenIV.linux.org.uk>
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

step_into() tries to avoid grabbing and dropping mount references
on the steps that do not involve crossing mountpoints (which is
obviously the majority of cases).  So it uses a local struct path
with unusual refcounting rules - path.mnt is pinned if and only if
it's not equal to nd->path.mnt.

We used to have similar beasts all over the place and we had quite
a few bugs crop up in their handling - it's easy to get confused
when changing e.g. cleanup on failure exits (or adding a new check,
etc.)

Now that's mostly gone - the step_into() instance (which is what
we need them for) is the only one left.  It is exposed to mount
traversal and it's (shortly) seen by pick_link().  Since pick_link()
needs to store it in link stack, where the normal rules apply,
it has to make sure that mount is pinned regardless of nd->path.mnt
value.  That's done on all calls of pick_link() and very early
in those.  Let's do that in the caller (step_into()) instead -
that way the fewer places need to be aware of such struct path
instances.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index a2b5dbe432d6..a94ff3d58b51 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1602,13 +1602,10 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 	int error;
 
 	if (unlikely(nd->total_link_count++ >= MAXSYMLINKS)) {
-		path_to_nameidata(link, nd);
+		if (!(nd->flags & LOOKUP_RCU))
+			path_put(link);
 		return ERR_PTR(-ELOOP);
 	}
-	if (!(nd->flags & LOOKUP_RCU)) {
-		if (link->mnt == nd->path.mnt)
-			mntget(link->mnt);
-	}
 	error = nd_alloc_stack(nd);
 	if (unlikely(error)) {
 		if (error == -ECHILD) {
@@ -1712,10 +1709,13 @@ static const char *step_into(struct nameidata *nd, int flags,
 		nd->seq = seq;
 		return NULL;
 	}
-	/* make sure that d_is_symlink above matches inode */
 	if (nd->flags & LOOKUP_RCU) {
+		/* make sure that d_is_symlink above matches inode */
 		if (read_seqcount_retry(&path.dentry->d_seq, seq))
 			return ERR_PTR(-ECHILD);
+	} else {
+		if (path.mnt == nd->path.mnt)
+			mntget(path.mnt);
 	}
 	return pick_link(nd, &path, inode, seq, flags);
 }
-- 
2.11.0

