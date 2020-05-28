Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20548C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F02C4207F9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437777AbgE1Xt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437661AbgE1XtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:49:21 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F6CC014D07;
        Thu, 28 May 2020 16:49:21 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSH1-00HDnx-GS; Thu, 28 May 2020 23:49:19 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/6] switch readdir(2) to unsafe_copy_dirent_name()
Date:   Fri, 29 May 2020 00:49:17 +0100
Message-Id: <20200528234919.4104604-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200528234832.GA4103769@ZenIV.linux.org.uk>
References: <20200528234832.GA4103769@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... and the same for its compat counterpart

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/readdir.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index ed6aaad451aa..a9085016a619 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -157,17 +157,18 @@ static int fillonedir(struct dir_context *ctx, const char *name, int namlen,
 	}
 	buf->result++;
 	dirent = buf->dirent;
-	if (!access_ok(dirent,
+	if (!user_write_access_begin(dirent,
 			(unsigned long)(dirent->d_name + namlen + 1) -
 				(unsigned long)dirent))
 		goto efault;
-	if (	__put_user(d_ino, &dirent->d_ino) ||
-		__put_user(offset, &dirent->d_offset) ||
-		__put_user(namlen, &dirent->d_namlen) ||
-		__copy_to_user(dirent->d_name, name, namlen) ||
-		__put_user(0, dirent->d_name + namlen))
-		goto efault;
+	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
+	unsafe_put_user(offset, &dirent->d_offset, efault_end);
+	unsafe_put_user(namlen, &dirent->d_namlen, efault_end);
+	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
+	user_write_access_end();
 	return 0;
+efault_end:
+	user_write_access_end();
 efault:
 	buf->result = -EFAULT;
 	return -EFAULT;
@@ -424,17 +425,18 @@ static int compat_fillonedir(struct dir_context *ctx, const char *name,
 	}
 	buf->result++;
 	dirent = buf->dirent;
-	if (!access_ok(dirent,
+	if (!user_write_access_begin(dirent,
 			(unsigned long)(dirent->d_name + namlen + 1) -
 				(unsigned long)dirent))
 		goto efault;
-	if (	__put_user(d_ino, &dirent->d_ino) ||
-		__put_user(offset, &dirent->d_offset) ||
-		__put_user(namlen, &dirent->d_namlen) ||
-		__copy_to_user(dirent->d_name, name, namlen) ||
-		__put_user(0, dirent->d_name + namlen))
-		goto efault;
+	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
+	unsafe_put_user(offset, &dirent->d_offset, efault_end);
+	unsafe_put_user(namlen, &dirent->d_namlen, efault_end);
+	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
+	user_write_access_end();
 	return 0;
+efault_end:
+	user_write_access_end();
 efault:
 	buf->result = -EFAULT;
 	return -EFAULT;
-- 
2.11.0

