Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A1CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 911272067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593462447;
	bh=AiODangSG0g8XMTYh4fc4/mILDu9VI7nqiWX6Uw4QIY=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=J210liAXmLrlJoslzV0vCDeu9KBmj/um9FnW9eQ14zzc4HFCtui4gHXD6626siVaZ
	 zZMR5BYSz5v5n6doD7VUQEyKy200fOFWd5Y+krelNLguISvUUNSmTi9ttjMPC+4csk
	 cXrFX/q2Z3SIROxsBnai5I8/nIKe4CVppOT4v74Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388915AbgF2U1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387521AbgF2U1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:27:21 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B39A20656;
        Mon, 29 Jun 2020 20:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593462441;
        bh=AiODangSG0g8XMTYh4fc4/mILDu9VI7nqiWX6Uw4QIY=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=M4xaXqyijf5hqRA6pOQmyLxhsgtUrLbFEV47XEjyOoSbUU+UwpuzS3ws9PE00rr9m
         1hOUs2QfgwyOcT9vVytA2n6gPqwuWXp4hUXxlzeT3rY2oReykmtafFI/l4s/NzA5hr
         Ek12VOxSG5N/uFPHiv1Ks3vqasr8dj0R7zr7pt+k=
Date:   Mon, 29 Jun 2020 13:27:20 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid readahead race condition
Message-ID: <20200629202720.GA230664@google.com>
References: <20200624012148.180050-1-jaegeuk@kernel.org>
 <20200629150323.GA3293033@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629150323.GA3293033@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If two readahead threads having same offset enter in readpages, every read
IOs are split and issued to the disk which giving lower bandwidth.

This patch tries to avoid redundant readahead calls.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v3:
 - use READ|WRITE_ONCE
v2:
  - add missing code to bypass read
 
 fs/f2fs/data.c  | 18 ++++++++++++++++++
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 995cf78b23c5e..360b4c9080d97 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2296,6 +2296,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 	unsigned nr_pages = rac ? readahead_count(rac) : 1;
 	unsigned max_nr_pages = nr_pages;
 	int ret = 0;
+	bool drop_ra = false;
 
 	map.m_pblk = 0;
 	map.m_lblk = 0;
@@ -2306,10 +2307,24 @@ static int f2fs_mpage_readpages(struct inode *inode,
 	map.m_seg_type = NO_CHECK_TYPE;
 	map.m_may_create = false;
 
+	/*
+	 * Two readahead threads for same address range can cause race condition
+	 * which fragments sequential read IOs. So let's avoid each other.
+	 */
+	if (rac && readahead_count(rac)) {
+		if (READ_ONCE(F2FS_I(inode)->ra_offset) == readahead_index(rac))
+			drop_ra = true;
+		else
+			WRITE_ONCE(F2FS_I(inode)->ra_offset,
+						readahead_index(rac));
+	}
+
 	for (; nr_pages; nr_pages--) {
 		if (rac) {
 			page = readahead_page(rac);
 			prefetchw(&page->flags);
+			if (drop_ra)
+				goto next_page;
 		}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -2372,6 +2387,9 @@ static int f2fs_mpage_readpages(struct inode *inode,
 	}
 	if (bio)
 		__submit_bio(F2FS_I_SB(inode), bio, DATA);
+
+	if (rac && readahead_count(rac) && !drop_ra)
+		WRITE_ONCE(F2FS_I(inode)->ra_offset, -1);
 	return ret;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6a655edeb522f..e6e47618a3576 100644
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
2.27.0.212.ge8ba1cc988-goog

