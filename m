Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43763C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2298920637
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgCMX46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:56:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50058 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgCMXyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:02 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7s-00B6b2-US; Fri, 13 Mar 2020 23:54:00 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 29/69] link_path_walk(): simplify stack handling
Date:   Fri, 13 Mar 2020 23:53:17 +0000
Message-Id: <20200313235357.2646756-29-viro@ZenIV.linux.org.uk>
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

We use nd->stack to store two things: pinning down the symlinks
we are resolving and resuming the name traversal when a nested
symlink is finished.

Currently, nd->depth is used to keep track of both.  It's 0 when
we call link_path_walk() for the first time (for the pathname
itself) and 1 on all subsequent calls (for trailing symlinks,
if any).  That's fine, as far as pinning symlinks goes - when
handling a trailing symlink, the string we are interpreting
is the body of symlink pinned down in nd->stack[0].  It's
rather inconvenient with respect to handling nested symlinks,
though - when we run out of a string we are currently interpreting,
we need to decide whether it's a nested symlink (in which case
we need to pick the string saved back when we started to interpret
that nested symlink and resume its traversal) or not (in which
case we are done with link_path_walk()).

Current solution is a bit of a kludge - in handling of trailing symlink
(in lookup_last() and open_last_lookups() we clear nd->stack[0].name.
That allows link_path_walk() to use the following rules when
running out of a string to interpret:
	* if nd->depth is zero, we are at the end of pathname itself.
	* if nd->depth is positive, check the saved string; for
nested symlink it will be non-NULL, for trailing symlink - NULL.

It works, but it's rather non-obvious.  Note that we have two sets:
the set of symlinks currently being traversed and the set of postponed
pathname tails.  The former is stored in nd->stack[0..nd->depth-1].link
and it's valid throught the pathname resolution; the latter is valid only
during an individual call of link_path_walk() and it occupies
nd->stack[0..nd->depth-1].name for the first call of link_path_walk() and
nd->stack[1..nd->depth-1].name for subsequent ones.  The kludge is basically
a way to recognize the second set becoming empty.

The things get simpler if we keep track of the second set's size
explicitly and always store it in nd->stack[0..depth-1].name.
We access the second set only inside link_path_walk(), so its
size can live in a local variable; that way the check becomes
trivial without the need of that kludge.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index ff028f12cb95..04c1d798013f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2120,6 +2120,7 @@ static inline u64 hash_name(const void *salt, const char *name)
  */
 static int link_path_walk(const char *name, struct nameidata *nd)
 {
+	int depth = 0; // depth <= nd->depth
 	int err;
 
 	nd->last_type = LAST_ROOT;
@@ -2182,14 +2183,11 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 		} while (unlikely(*name == '/'));
 		if (unlikely(!*name)) {
 OK:
-			/* pathname body, done */
-			if (!nd->depth)
-				return 0;
-			name = nd->stack[nd->depth - 1].name;
-			/* trailing symlink, done */
-			if (!name)
+			/* pathname or trailing symlink, done */
+			if (!depth)
 				return 0;
 			/* last component of nested symlink */
+			name = nd->stack[--depth].name;
 			link = walk_component(nd, 0);
 		} else {
 			/* not the last component */
@@ -2199,7 +2197,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 			if (IS_ERR(link))
 				return PTR_ERR(link);
 			/* a symlink to follow */
-			nd->stack[nd->depth - 1].name = name;
+			nd->stack[depth++].name = name;
 			name = link;
 			continue;
 		}
@@ -2324,7 +2322,6 @@ static inline const char *lookup_last(struct nameidata *nd)
 	link = walk_component(nd, WALK_TRAILING);
 	if (link) {
 		nd->flags |= LOOKUP_PARENT;
-		nd->stack[0].name = NULL;
 	}
 	return link;
 }
@@ -3280,7 +3277,6 @@ static const char *do_last(struct nameidata *nd,
 	if (unlikely(res)) {
 		nd->flags |= LOOKUP_PARENT;
 		nd->flags &= ~(LOOKUP_OPEN|LOOKUP_CREATE|LOOKUP_EXCL);
-		nd->stack[0].name = NULL;
 		return res;
 	}
 
-- 
2.11.0

