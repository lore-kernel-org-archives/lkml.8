Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDA7C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD1B20637
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgCMXyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:54:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50214 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgCMXyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:07 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7y-00B6f3-MU; Fri, 13 Mar 2020 23:54:06 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 68/69] atomic_open(): no need to pass struct open_flags anymore
Date:   Fri, 13 Mar 2020 23:53:56 +0000
Message-Id: <20200313235357.2646756-68-viro@ZenIV.linux.org.uk>
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

argument had been unused since 1643b43fbd052 (lookup_open(): lift the
"fallback to !O_CREAT" logics from atomic_open()) back in 2016

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 88ff59dcfd47..36b15f5b09bd 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2932,7 +2932,6 @@ static int may_o_create(const struct path *dir, struct dentry *dentry, umode_t m
  */
 static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
 				  struct file *file,
-				  const struct open_flags *op,
 				  int open_flag, umode_t mode)
 {
 	struct dentry *const DENTRY_NOT_SET = (void *) -1UL;
@@ -3065,7 +3064,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	}
 
 	if (dir_inode->i_op->atomic_open) {
-		dentry = atomic_open(nd, dentry, file, op, open_flag, mode);
+		dentry = atomic_open(nd, dentry, file, open_flag, mode);
 		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
 			dentry = ERR_PTR(create_error);
 		return dentry;
-- 
2.11.0

