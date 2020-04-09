Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD58C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6EE20771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586453459;
	bh=6bcDf97ASpJTxAYOqpWx0e2gOIt5ERptaNd2MAMPc4I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=N8XjejuNJwZPiogq/mqbqsJ8VJfbcc18shtCcQtZjthV5rojwqYt5MTm9tri8p83H
	 vvQR55YPoXh542QDKErSxAjb+YamOE6eM7TtwCmPmdnabXmvnrWbRjyJjPItd/Deyq
	 IMDKrgUU3dsbrYkpCZ6smuqHsL92WumWGhRncULI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgDIRa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbgDIRa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:30:57 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D81E720753;
        Thu,  9 Apr 2020 17:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586453458;
        bh=6bcDf97ASpJTxAYOqpWx0e2gOIt5ERptaNd2MAMPc4I=;
        h=From:To:Cc:Subject:Date:From;
        b=W9ng68913sTnRs3JV8IUWA2y7YIqCEESBXw8Fzj6WYmIshTp0myEQVRELhV3IEHIT
         m1Wl8ZC4cMOL6xMjdNoLXUyeDdHWtw3lhrjyfG/8zUQlPQSFqaSQWNRqnPgybJ1Zzv
         C3Q3BHx1Ox5Ubs11vi2IsgysrtsZmWCpsJENmY00=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix quota_sync failure due to f2fs_lock_op
Date:   Thu,  9 Apr 2020 10:30:56 -0700
Message-Id: <20200409173056.229855-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs_quota_sync() uses f2fs_lock_op() before flushing dirty pages, but
f2fs_write_data_page() returns EAGAIN.
Likewise dentry blocks, we can just bypass getting the lock, since quota
blocks are also maintained by checkpoint.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 358c5f0bd6346..1139d8cf4b8d1 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2707,8 +2707,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 			f2fs_available_free_memory(sbi, BASE_CHECK))))
 		goto redirty_out;
 
-	/* Dentry blocks are controlled by checkpoint */
-	if (S_ISDIR(inode->i_mode)) {
+	/* Dentry/quota blocks are controlled by checkpoint */
+	if (S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) {
 		fio.need_lock = LOCK_DONE;
 		err = f2fs_do_write_data_page(&fio);
 		goto done;
-- 
2.26.0.110.g2183baf09c-goog

