Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FC1C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E5D2074E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgCMXyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:54:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50210 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbgCMXyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:07 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7y-00B6ex-IU; Fri, 13 Mar 2020 23:54:06 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 67/69] open_last_lookups(): move complete_walk() into do_open()
Date:   Fri, 13 Mar 2020 23:53:55 +0000
Message-Id: <20200313235357.2646756-67-viro@ZenIV.linux.org.uk>
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
 fs/namei.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3e1573373773..88ff59dcfd47 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3127,10 +3127,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 	if (nd->last_type != LAST_NORM) {
 		if (nd->depth)
 			put_link(nd);
-		res = handle_dots(nd, nd->last_type);
-		if (likely(!res))
-			res = ERR_PTR(complete_walk(nd));
-		return res;
+		return handle_dots(nd, nd->last_type);
 	}
 
 	if (!(open_flag & O_CREAT)) {
@@ -3195,13 +3192,9 @@ static const char *open_last_lookups(struct nameidata *nd,
 	if (nd->depth)
 		put_link(nd);
 	res = step_into(nd, WALK_TRAILING, dentry, inode, seq);
-	if (unlikely(res)) {
+	if (unlikely(res))
 		nd->flags &= ~(LOOKUP_OPEN|LOOKUP_CREATE|LOOKUP_EXCL);
-		return res;
-	}
-
-	/* Why this, you ask?  _Now_ we might have grown LOOKUP_JUMPED... */
-	return ERR_PTR(complete_walk(nd));
+	return res;
 }
 
 /*
@@ -3215,6 +3208,11 @@ static int do_open(struct nameidata *nd,
 	int acc_mode;
 	int error;
 
+	if (!(file->f_mode & (FMODE_OPENED | FMODE_CREATED))) {
+		error = complete_walk(nd);
+		if (error)
+			return error;
+	}
 	if (!(file->f_mode & FMODE_CREATED))
 		audit_inode(nd->name, nd->path.dentry, 0);
 	if (open_flag & O_CREAT) {
-- 
2.11.0

