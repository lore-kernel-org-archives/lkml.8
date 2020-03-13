Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5BEC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F802074D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgCMX5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:57:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50026 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbgCMXyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:01 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7r-00B6aC-S8; Fri, 13 Mar 2020 23:53:59 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 21/69] merging pick_link() with get_link(), part 3
Date:   Fri, 13 Mar 2020 23:53:09 +0000
Message-Id: <20200313235357.2646756-21-viro@ZenIV.linux.org.uk>
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

After a pure jump ("/" or procfs-style symlink) we don't need to
hold the link anymore.  link_path_walk() dropped it if such case
had been detected, lookup_last/do_last() (i.e. old trailing_symlink())
left it on the stack - it ended up calling terminate_walk() shortly
anyway, which would've purged the entire stack.

Do it in get_link() itself instead.  Simpler logics that way...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c4678f81113a..edb37272f2cc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1154,7 +1154,9 @@ const char *get_link(struct nameidata *nd)
 		} else {
 			res = get(dentry, inode, &last->done);
 		}
-		if (IS_ERR_OR_NULL(res))
+		if (!res)
+			goto all_done;
+		if (IS_ERR(res))
 			return res;
 	}
 	if (*res == '/') {
@@ -1164,9 +1166,11 @@ const char *get_link(struct nameidata *nd)
 		while (unlikely(*++res == '/'))
 			;
 	}
-	if (!*res)
-		res = NULL;
-	return res;
+	if (*res)
+		return res;
+all_done: // pure jump
+	put_link(nd);
+	return NULL;
 }
 
 /*
@@ -2211,11 +2215,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 
 			if (IS_ERR(s))
 				return PTR_ERR(s);
-			err = 0;
-			if (unlikely(!s)) {
-				/* jumped */
-				put_link(nd);
-			} else {
+			if (likely(s)) {
 				nd->stack[nd->depth - 1].name = name;
 				name = s;
 				continue;
-- 
2.11.0

