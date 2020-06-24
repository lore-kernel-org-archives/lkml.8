Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DADC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807C42100A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592961716;
	bh=q4Pi3kNmO4FJ+5AKsS68CryMsRDMWC3DAutTzeZ9fAw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iR8VbupYXmquBewR9JKtbCeRQWLY7B1hktTpG0ITteFj7LOS3+zVY2/ooXi+93m28
	 hBapV/qSGCx3jJMXtPGn+b0RFxijG/14vvhBPRrdpktcCgo9XaQQGywkak1M3C+KBi
	 ULP12NQjNeevMcPYBYzX05AToWK28P6pHDPkNTk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388360AbgFXBVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:21:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387842AbgFXBVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:21:51 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A54C72098B;
        Wed, 24 Jun 2020 01:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592961710;
        bh=q4Pi3kNmO4FJ+5AKsS68CryMsRDMWC3DAutTzeZ9fAw=;
        h=From:To:Cc:Subject:Date:From;
        b=PrCwI/LGSBreBr49BTTIywyZJN9Dvn7jpBRbXUfo97cuaDA0tll3lTbCSa8SyErdt
         XuDZKR49M8rDSLypdOALdd8kR/vt0GIEwvgIbUhLmZmbruoNlznbt+oR0advniYmzz
         GeZivfeGLVLerbasPB+phfMIVySvy24cSljoJUSU=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid readahead race condition
Date:   Tue, 23 Jun 2020 18:21:48 -0700
Message-Id: <20200624012148.180050-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If two readahead threads having same offset enter in readpages, every read
IOs are split and issued to the disk which giving lower bandwidth.

This patch tries to avoid redundant readahead calls.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c  | 15 +++++++++++++++
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index dfd3225153570..1886d83bc5f15 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2292,6 +2292,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 	unsigned nr_pages = rac ? readahead_count(rac) : 1;
 	unsigned max_nr_pages = nr_pages;
 	int ret = 0;
+	bool drop_ra = false;
 
 	map.m_pblk = 0;
 	map.m_lblk = 0;
@@ -2302,6 +2303,17 @@ static int f2fs_mpage_readpages(struct inode *inode,
 	map.m_seg_type = NO_CHECK_TYPE;
 	map.m_may_create = false;
 
+	/*
+	 * Two readahead threads for same address range can cause race condition
+	 * which fragments sequential read IOs. So let's avoid each other.
+	 */
+	if (rac && readahead_count(rac)) {
+		if (F2FS_I(inode)->ra_offset == readahead_index(rac))
+			drop_ra = true;
+		else
+			F2FS_I(inode)->ra_offset = readahead_index(rac);
+	}
+
 	for (; nr_pages; nr_pages--) {
 		if (rac) {
 			page = readahead_page(rac);
@@ -2368,6 +2380,9 @@ static int f2fs_mpage_readpages(struct inode *inode,
 	}
 	if (bio)
 		__submit_bio(F2FS_I_SB(inode), bio, DATA);
+
+	if (rac && readahead_count(rac) && !drop_ra)
+		F2FS_I(inode)->ra_offset = -1;
 	return ret;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7fb2a1a334388..753782426feac 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -809,6 +809,7 @@ struct f2fs_inode_info {
 	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
 	struct task_struct *inmem_task;	/* store inmemory task */
 	struct mutex inmem_lock;	/* lock for inmemory pages */
+	pgoff_t ra_offset;		/* ongoing readahead offset */
 	struct extent_tree *extent_tree;	/* cached extent_tree entry */
 
 	/* avoid racing between foreground op and gc */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7326522057378..80cb7cd358f84 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1015,6 +1015,8 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
 
+	fi->ra_offset = -1;
+
 	return &fi->vfs_inode;
 }
 
-- 
2.27.0.111.gc72c7da667-goog

