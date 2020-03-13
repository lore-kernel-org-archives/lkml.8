Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B9EC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1865820754
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgCMXyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:54:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50074 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbgCMXyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:02 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7t-00B6bR-Gc; Fri, 13 Mar 2020 23:54:01 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 33/69] atomic_open(): return the right dentry in FMODE_OPENED case
Date:   Fri, 13 Mar 2020 23:53:21 +0000
Message-Id: <20200313235357.2646756-33-viro@ZenIV.linux.org.uk>
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
index 40d5f7abfa54..88f985aff4f8 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2949,11 +2949,15 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
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

