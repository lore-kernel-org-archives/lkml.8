Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D529BC35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 01:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A76206EF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 01:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgBWBXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 20:23:01 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50212 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgBWBXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 20:23:01 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5fym-00HDjB-JZ; Sun, 23 Feb 2020 01:22:52 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v2 23/34] merging pick_link() with get_link(), part 6
Date:   Sun, 23 Feb 2020 01:16:15 +0000
Message-Id: <20200223011626.4103706-23-viro@ZenIV.linux.org.uk>
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

move the only remaining call of get_link() into pick_link()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1e8548a547ff..fef2c447219d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1793,14 +1793,14 @@ static inline int handle_dots(struct nameidata *nd, int type)
 	return 0;
 }
 
-static int pick_link(struct nameidata *nd, struct path *link,
+static const char *pick_link(struct nameidata *nd, struct path *link,
 		     struct inode *inode, unsigned seq)
 {
 	int error;
 	struct saved *last;
 	if (unlikely(nd->total_link_count++ >= MAXSYMLINKS)) {
 		path_to_nameidata(link, nd);
-		return -ELOOP;
+		return ERR_PTR(-ELOOP);
 	}
 	if (!(nd->flags & LOOKUP_RCU)) {
 		if (link->mnt == nd->path.mnt)
@@ -1821,7 +1821,7 @@ static int pick_link(struct nameidata *nd, struct path *link,
 		}
 		if (error) {
 			path_put(link);
-			return error;
+			return ERR_PTR(error);
 		}
 	}
 
@@ -1830,7 +1830,7 @@ static int pick_link(struct nameidata *nd, struct path *link,
 	clear_delayed_call(&last->done);
 	nd->link_inode = inode;
 	last->seq = seq;
-	return 1;
+	return get_link(nd);
 }
 
 enum {WALK_FOLLOW = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
@@ -1865,11 +1865,7 @@ static const char *step_into(struct nameidata *nd, int flags,
 		if (read_seqcount_retry(&path.dentry->d_seq, seq))
 			return ERR_PTR(-ECHILD);
 	}
-	err = pick_link(nd, &path, inode, seq);
-	if (err > 0)
-		return get_link(nd);
-	else
-		return ERR_PTR(err);
+	return pick_link(nd, &path, inode, seq);
 }
 
 static const char *walk_component(struct nameidata *nd, int flags)
-- 
2.11.0

