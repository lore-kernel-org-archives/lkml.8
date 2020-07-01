Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16612C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A5C20809
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593620074;
	bh=2TWjWcBOdWkh1PkJpBcH2H9+m+ze9nMuqw5lH2ZVuK0=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=vckjKXjVQ4/c6P12ipvhb2p7IoKQ3k1qJ79cYSRFQlPeHkhN8a8p7BTH0oBjVEkYp
	 Q4XCyt1ucg/HNR5jlRHOwFlgIdGUat3MyJnL+3XdoI/+oy5M/QGBFijkKV/bgISATd
	 8yAhwcvIu5+nqTZZQ6++Yw0PaDNbgHm+ZIyct1f0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732278AbgGAQOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:14:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730645AbgGAQOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:14:30 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A38B207FB;
        Wed,  1 Jul 2020 16:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593620069;
        bh=2TWjWcBOdWkh1PkJpBcH2H9+m+ze9nMuqw5lH2ZVuK0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=QRgPYJk/XijGeI9UguT9sCw0ics6U013OjmRO2k7KAAVGO/fivH+8vmNXjqJy2BDv
         /zc4dJXjwwDyA2rV2IVEGXmtExOT4Z2MYzyYidq7VOcmsP3Y6tzE2W1rfWdiUx9XPf
         2agg5PLwN0DXvHj0L69G3o+KUVh0e0Z5qZtrDL9k=
Date:   Wed, 1 Jul 2020 09:14:29 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: avoid readahead race condition
Message-ID: <20200701161429.GA1724572@google.com>
References: <20200624012148.180050-1-jaegeuk@kernel.org>
 <20200629150323.GA3293033@google.com>
 <20200629202720.GA230664@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200629202720.GA230664@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From 3634864095bd1aafbb60ff49dac7d13ce157b658 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 22 Jun 2020 23:01:05 -0700
Subject: [PATCH] f2fs: avoid readahead race condition
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If two readahead threads having same offset enter in readpages, every read
IOs are split and issued to the disk which giving lower bandwidth.

This patch tries to avoid redundant readahead calls.

Fixes one build error reported by Randy.
Fix build error when F2FS_FS_COMPRESSION is not set/enabled.
This label is needed in either case.

../fs/f2fs/data.c: In function ‘f2fs_mpage_readpages’:
../fs/f2fs/data.c:2327:5: error: label ‘next_page’ used but not defined
     goto next_page;

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 v4:
  - fix missing unlock_page
 v3:
  - use READ|WRITE_ONCE
 v2:
   - add missing code to bypass read

 fs/f2fs/data.c  | 20 ++++++++++++++++++++
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 995cf78b23c5e..066d29938c03a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2296,6 +2296,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 	unsigned nr_pages = rac ? readahead_count(rac) : 1;
 	unsigned max_nr_pages = nr_pages;
 	int ret = 0;
+	bool drop_ra = false;
 
 	map.m_pblk = 0;
 	map.m_lblk = 0;
@@ -2306,10 +2307,26 @@ static int f2fs_mpage_readpages(struct inode *inode,
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
+			if (drop_ra) {
+				f2fs_put_page(page, 1);
+				continue;
+			}
 		}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -2372,6 +2389,9 @@ static int f2fs_mpage_readpages(struct inode *inode,
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
