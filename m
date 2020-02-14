Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B2BC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9887B2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581704655;
	bh=iZIRaUEUsPfVHTOn9MDUDIfCsp4dj78qw/0Z1aF2xFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t6JHR7fuPOwBCbfLhJfWRwzShjcTW9O4e6alzv3ih+Vd07bDui6diGg0apzG/lrg5
	 qYOtRxDIKpo3IVc3Orh1vXM7QTHT7ptvMVsdiLPE2pLNdzTyTIiK/5ivcp01cTlk9u
	 7RiK3OhQpOaQudvr92ggM9A/V9RvjUw7UAQfXadU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgBNPtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:49:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729804AbgBNPtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:49:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 935EF217F4;
        Fri, 14 Feb 2020 15:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695355;
        bh=iZIRaUEUsPfVHTOn9MDUDIfCsp4dj78qw/0Z1aF2xFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y4ohYkayTz73jdjs7vrkuy064rP84Hsd0zgj7WsTZtsqB38K/rdegVvjdeRqz3dIJ
         XHHGiTSt07ejORAtPRPTokmumx/nbHHpRv3pZy1/RgcbJ7aVxHXe1g3BAW2mUCw0tW
         6c3pW52yiC2slniDvzgxmcNcGVYDyhK1Lvk3rTMY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.5 016/542] f2fs: call f2fs_balance_fs outside of locked page
Date:   Fri, 14 Feb 2020 10:40:08 -0500
Message-Id: <20200214154854.6746-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit bdf03299248916640a835a05d32841bb3d31912d ]

Otherwise, we can hit deadlock by waiting for the locked page in
move_data_block in GC.

 Thread A                     Thread B
 - do_page_mkwrite
  - f2fs_vm_page_mkwrite
   - lock_page
                              - f2fs_balance_fs
                                  - mutex_lock(gc_mutex)
                               - f2fs_gc
                                - do_garbage_collect
                                 - ra_data_block
                                  - grab_cache_page
   - f2fs_balance_fs
    - mutex_lock(gc_mutex)

Fixes: 39a8695824510 ("f2fs: refactor ->page_mkwrite() flow")
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 33c412d178f0f..6c4436a5ce797 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -50,7 +50,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct page *page = vmf->page;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct dnode_of_data dn = { .node_changed = false };
+	struct dnode_of_data dn;
 	int err;
 
 	if (unlikely(f2fs_cp_error(sbi))) {
@@ -63,6 +63,9 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		goto err;
 	}
 
+	/* should do out of any locked page */
+	f2fs_balance_fs(sbi, true);
+
 	sb_start_pagefault(inode->i_sb);
 
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
@@ -120,8 +123,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 out_sem:
 	up_read(&F2FS_I(inode)->i_mmap_sem);
 
-	f2fs_balance_fs(sbi, dn.node_changed);
-
 	sb_end_pagefault(inode->i_sb);
 err:
 	return block_page_mkwrite_return(err);
-- 
2.20.1

