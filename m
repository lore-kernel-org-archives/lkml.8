Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A5BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15964206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466484;
	bh=raL4d33RBba0Q+Amt7jmBy+/u73rlt5v3RwFSVQIRYY=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=hwgnblO0FKjD2yQwF3ihCUrHCbyvMeiuXjv82uWJ6209HIHwFSQLhYdGQF59DmPIg
	 Ea/ZtSeNa2HGSmx2tt9PY3PCBl4qUx9w3NuU98YMMSatxlfFd34Y9vNLm2zj1vYCBv
	 yWu38LEe13c1dzGGbMmHibGa6lBhbmkGm28690YM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgF2Vem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:34:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728598AbgF2Sk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:56 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0108C23E53;
        Mon, 29 Jun 2020 15:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593443004;
        bh=raL4d33RBba0Q+Amt7jmBy+/u73rlt5v3RwFSVQIRYY=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=qYycy74u4p+VrNz3wJU8piFLUBVQZrNd8YIJ2V5+OiyNijLS+DIk3Tysqkxk+ETl4
         Imz+y6ajfoESV+TsNjb06OCNnyFWo/z8TBbUKFh6pk0xAgy28AyOY5XR0uoNod8Oki
         oeTLGo81shimoB2dCesRITTW2XNk8GK8q1B0rTzY=
Date:   Mon, 29 Jun 2020 08:03:23 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [PATCH v2] f2fs: avoid readahead race condition
Message-ID: <20200629150323.GA3293033@google.com>
References: <20200624012148.180050-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624012148.180050-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If two readahead threads having same offset enter in readpages, every read
IOs are split and issued to the disk which giving lower bandwidth.

This patch tries to avoid redundant readahead calls.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v2:
 - add missing code to bypass read

 fs/f2fs/data.c  | 18 +++++++++++++++++-
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d6094b9f3916..9b69a159cc6c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2403,6 +2403,7 @@ int f2fs_mpage_readpages(struct address_space *mapping,
 #endif
 	unsigned max_nr_pages = nr_pages;
 	int ret = 0;
+	bool drop_ra = false;
 
 	map.m_pblk = 0;
 	map.m_lblk = 0;
@@ -2413,13 +2414,25 @@ int f2fs_mpage_readpages(struct address_space *mapping,
 	map.m_seg_type = NO_CHECK_TYPE;
 	map.m_may_create = false;
 
+	/*
+	 * Two readahead threads for same address range can cause race condition
+	 * which fragments sequential read IOs. So let's avoid each other.
+	 */
+	if (pages && is_readahead) {
+		page = list_last_entry(pages, struct page, lru);
+		if (F2FS_I(inode)->ra_offset == page_index(page))
+			drop_ra = true;
+		else
+			F2FS_I(inode)->ra_offset = page_index(page);
+	}
+
 	for (; nr_pages; nr_pages--) {
 		if (pages) {
 			page = list_last_entry(pages, struct page, lru);
 
 			prefetchw(&page->flags);
 			list_del(&page->lru);
-			if (add_to_page_cache_lru(page, mapping,
+			if (drop_ra || add_to_page_cache_lru(page, mapping,
 						  page_index(page),
 						  readahead_gfp_mask(mapping)))
 				goto next_page;
@@ -2484,6 +2497,9 @@ int f2fs_mpage_readpages(struct address_space *mapping,
 	BUG_ON(pages && !list_empty(pages));
 	if (bio)
 		__f2fs_submit_read_bio(F2FS_I_SB(inode), bio, DATA);
+
+	if (pages && is_readahead && !drop_ra)
+		F2FS_I(inode)->ra_offset = -1;
 	return pages ? 0 : ret;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 35afa13124b8..a95f84d72a55 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -806,6 +806,7 @@ struct f2fs_inode_info {
 	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
 	struct task_struct *inmem_task;	/* store inmemory task */
 	struct mutex inmem_lock;	/* lock for inmemory pages */
+	pgoff_t ra_offset;		/* ongoing readahead offset */
 	struct extent_tree *extent_tree;	/* cached extent_tree entry */
 
 	/* avoid racing between foreground op and gc */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0e860186a9c5..6fd2ad43d9e4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1011,6 +1011,8 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
 
+	fi->ra_offset = -1;
+
 	return &fi->vfs_inode;
 }
 
-- 
2.27.0.111.gc72c7da667-goog

