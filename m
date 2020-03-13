Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BE9C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7895420637
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgCMXyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:54:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50122 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbgCMXyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:04 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7v-00B6cb-8j; Fri, 13 Mar 2020 23:54:03 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 45/69] follow_dotdot{,_rcu}(): lift LOOKUP_BENEATH checks out of loop
Date:   Fri, 13 Mar 2020 23:53:33 +0000
Message-Id: <20200313235357.2646756-45-viro@ZenIV.linux.org.uk>
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

Behaviour change: LOOKUP_BENEATH lookup of .. in absolute root
yields an error even if it's not the process' root.  That's
possible only if you'd managed to escape chroot jail by way of
procfs symlinks, but IMO the resulting behaviour is not worse -
more consistent and easier to describe:
	".." in root is "stay where you are", uness LOOKUP_BENEATH
	has been given, in which case it's "fail with EXDEV".

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 772d82daf3b4..577dc541a4d4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1370,11 +1370,8 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 	unsigned seq;
 
 	while (1) {
-		if (path_equal(&nd->path, &nd->root)) {
-			if (unlikely(nd->flags & LOOKUP_BENEATH))
-				return -ECHILD;
+		if (path_equal(&nd->path, &nd->root))
 			break;
-		}
 		if (nd->path.dentry != nd->path.mnt->mnt_root) {
 			struct dentry *old = nd->path.dentry;
 
@@ -1405,7 +1402,10 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 			nd->seq = seq;
 		}
 	}
-	if (likely(parent)) {
+	if (unlikely(!parent)) {
+		if (unlikely(nd->flags & LOOKUP_BENEATH))
+			return -ECHILD;
+	} else {
 		nd->path.dentry = parent;
 		nd->seq = seq;
 	}
@@ -1447,11 +1447,8 @@ static int follow_dotdot(struct nameidata *nd)
 {
 	struct dentry *parent = NULL;
 	while (1) {
-		if (path_equal(&nd->path, &nd->root)) {
-			if (unlikely(nd->flags & LOOKUP_BENEATH))
-				return -EXDEV;
+		if (path_equal(&nd->path, &nd->root))
 			break;
-		}
 		if (nd->path.dentry != nd->path.mnt->mnt_root) {
 			/* rare case of legitimate dget_parent()... */
 			parent = dget_parent(nd->path.dentry);
@@ -1466,7 +1463,10 @@ static int follow_dotdot(struct nameidata *nd)
 		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
 			return -EXDEV;
 	}
-	if (likely(parent)) {
+	if (unlikely(!parent)) {
+		if (unlikely(nd->flags & LOOKUP_BENEATH))
+			return -EXDEV;
+	} else {
 		dput(nd->path.dentry);
 		nd->path.dentry = parent;
 	}
-- 
2.11.0

