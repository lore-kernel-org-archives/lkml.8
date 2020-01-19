Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE139C32771
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 03:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C172083E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 03:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgASDXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 22:23:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56908 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgASDXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:23:47 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1it1BA-00BFe0-Gr; Sun, 19 Jan 2020 03:23:20 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/9] merging pick_link() with get_link(), part 1
Date:   Sun, 19 Jan 2020 03:17:30 +0000
Message-Id: <20200119031738.2681033-18-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200119031738.2681033-1-viro@ZenIV.linux.org.uk>
References: <20200119031423.GV8904@ZenIV.linux.org.uk>
 <20200119031738.2681033-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Move restoring LOOKUP_PARENT and zeroing nd->stack.name[0] past
the call of get_link() (nothing _currently_ uses them in there).
That allows to moved the call of may_follow_link() into get_link()
as well, since now the presence of LOOKUP_PARENT distinguishes
the callers from each other (link_path_walk() has it, trailing_symlink()
doesn't).

Preparations for folding trailing_symlink() into callers (lookup_last()
and do_last()) and changing the calling conventions of those.  Next
stage after that will have get_link() call migrate into walk_component(),
then - into step_into().  It's tricky enough to warrant doing that
in stages, unfortunately...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index f9fa8579cf6a..45cedbe267ab 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1114,6 +1114,12 @@ const char *get_link(struct nameidata *nd)
 	int error;
 	const char *res;
 
+	if (!(nd->flags & LOOKUP_PARENT)) {
+		error = may_follow_link(nd);
+		if (unlikely(error))
+			return ERR_PTR(error);
+	}
+
 	if (unlikely(nd->flags & LOOKUP_NO_SYMLINKS))
 		return ERR_PTR(-ELOOP);
 
@@ -2328,13 +2334,9 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 
 static const char *trailing_symlink(struct nameidata *nd)
 {
-	const char *s;
-	int error = may_follow_link(nd);
-	if (unlikely(error))
-		return ERR_PTR(error);
+	const char *s = get_link(nd);
 	nd->flags |= LOOKUP_PARENT;
 	nd->stack[0].name = NULL;
-	s = get_link(nd);
 	return s ? s : "";
 }
 
-- 
2.20.1

