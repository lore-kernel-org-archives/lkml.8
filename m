Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A344C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C212074D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgCMX5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:57:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50014 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbgCMXyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:01 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7r-00B6Zu-GP; Fri, 13 Mar 2020 23:53:59 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 18/69] expand the only remaining call of path_lookup_conditional()
Date:   Fri, 13 Mar 2020 23:53:06 +0000
Message-Id: <20200313235357.2646756-18-viro@ZenIV.linux.org.uk>
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
 fs/namei.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 193e076275a3..db55de1b580b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -858,13 +858,6 @@ static int set_root(struct nameidata *nd)
 	return 0;
 }
 
-static void path_put_conditional(struct path *path, struct nameidata *nd)
-{
-	dput(path->dentry);
-	if (path->mnt != nd->path.mnt)
-		mntput(path->mnt);
-}
-
 static inline void path_to_nameidata(const struct path *path,
 					struct nameidata *nd)
 {
@@ -1312,8 +1305,11 @@ static int follow_managed(struct path *path, struct nameidata *nd)
 		ret = 1;
 	if (ret > 0 && unlikely(d_flags_negative(flags)))
 		ret = -ENOENT;
-	if (unlikely(ret < 0))
-		path_put_conditional(path, nd);
+	if (unlikely(ret < 0)) {
+		dput(path->dentry);
+		if (path->mnt != nd->path.mnt)
+			mntput(path->mnt);
+	}
 	return ret;
 }
 
-- 
2.11.0

