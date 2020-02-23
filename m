Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B039C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 01:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6838D206EF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 01:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgBWBYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 20:24:18 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50238 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgBWBYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 20:24:17 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5g00-00HDlf-QO; Sun, 23 Feb 2020 01:24:07 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v2 27/34] atomic_open(): return the right dentry in FMODE_OPENED case
Date:   Sun, 23 Feb 2020 01:16:19 +0000
Message-Id: <20200223011626.4103706-27-viro@ZenIV.linux.org.uk>
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

->atomic_open() might have used a different alias than the one we'd
passed to it; in "not opened" case we take care of that, in "opened"
one we don't.  Currently we don't care downstream of "opened" case
which alias to return; however, that will change shortly when we
get to unifying may_open() calls.

It's not hard to get right in all cases, anyway.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index a7730bbee162..c2244ee4b2f0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2956,11 +2956,15 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
 	d_lookup_done(dentry);
 	if (!error) {
 		if (file->f_mode & FMODE_OPENED) {
+			int acc_mode = op->acc_mode;
+			if (unlikely(dentry != file->f_path.dentry)) {
+				dput(dentry);
+				dentry = dget(file->f_path.dentry);
+			}
 			/*
 			 * We didn't have the inode before the open, so check open
 			 * permission here.
 			 */
-			int acc_mode = op->acc_mode;
 			if (file->f_mode & FMODE_CREATED) {
 				WARN_ON(!(open_flag & O_CREAT));
 				fsnotify_create(dir, dentry);
-- 
2.11.0

