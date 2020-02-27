Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61248C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D66E24691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgB0LbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 06:31:05 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:58626 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728895AbgB0LbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:31:04 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ADEEF9AEEC0A57C61D86;
        Thu, 27 Feb 2020 19:30:18 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Feb 2020 19:30:10 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: cover last_disk_size update with spinlock
Date:   Thu, 27 Feb 2020 19:30:03 +0800
Message-ID: <20200227113005.127729-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change solves below hangtask issue:

INFO: task kworker/u16:1:58 blocked for more than 122 seconds.
      Not tainted 5.6.0-rc2-00590-g9983bdae4974e #11
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u16:1   D    0    58      2 0x00000000
Workqueue: writeback wb_workfn (flush-179:0)
Backtrace:
 (__schedule) from [<c0913234>] (schedule+0x78/0xf4)
 (schedule) from [<c017ec74>] (rwsem_down_write_slowpath+0x24c/0x4c0)
 (rwsem_down_write_slowpath) from [<c0915f2c>] (down_write+0x6c/0x70)
 (down_write) from [<c0435b80>] (f2fs_write_single_data_page+0x608/0x7ac)
 (f2fs_write_single_data_page) from [<c0435fd8>] (f2fs_write_cache_pages+0x2b4/0x7c4)
 (f2fs_write_cache_pages) from [<c043682c>] (f2fs_write_data_pages+0x344/0x35c)
 (f2fs_write_data_pages) from [<c0267ee8>] (do_writepages+0x3c/0xd4)
 (do_writepages) from [<c0310cbc>] (__writeback_single_inode+0x44/0x454)
 (__writeback_single_inode) from [<c03112d0>] (writeback_sb_inodes+0x204/0x4b0)
 (writeback_sb_inodes) from [<c03115cc>] (__writeback_inodes_wb+0x50/0xe4)
 (__writeback_inodes_wb) from [<c03118f4>] (wb_writeback+0x294/0x338)
 (wb_writeback) from [<c0312dac>] (wb_workfn+0x35c/0x54c)
 (wb_workfn) from [<c014f2b8>] (process_one_work+0x214/0x544)
 (process_one_work) from [<c014f634>] (worker_thread+0x4c/0x574)
 (worker_thread) from [<c01564fc>] (kthread+0x144/0x170)
 (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)

Reported-and-tested-by: Ondřej Jirman <megi@xff.cz>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 4 ++--
 fs/f2fs/data.c     | 4 ++--
 fs/f2fs/f2fs.h     | 5 +++--
 fs/f2fs/file.c     | 4 ++--
 fs/f2fs/super.c    | 1 +
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 7e220ec8f843..10a8b3b40051 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -897,10 +897,10 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	f2fs_put_dnode(&dn);
 	f2fs_unlock_op(sbi);
 
-	down_write(&fi->i_sem);
+	spin_lock(&fi->i_size_lock);
 	if (fi->last_disk_size < psize)
 		fi->last_disk_size = psize;
-	up_write(&fi->i_sem);
+	spin_unlock(&fi->i_size_lock);
 
 	f2fs_put_rpages(cc);
 	f2fs_destroy_compress_ctx(cc);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 081e172fa130..4249296a71f9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2643,10 +2643,10 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 	if (err) {
 		file_set_keep_isize(inode);
 	} else {
-		down_write(&F2FS_I(inode)->i_sem);
+		spin_lock(&F2FS_I(inode)->i_size_lock);
 		if (F2FS_I(inode)->last_disk_size < psize)
 			F2FS_I(inode)->last_disk_size = psize;
-		up_write(&F2FS_I(inode)->i_sem);
+		spin_unlock(&F2FS_I(inode)->i_size_lock);
 	}
 
 done:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4a02edc2454b..1a8af2020e72 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -701,6 +701,7 @@ struct f2fs_inode_info {
 	struct task_struct *cp_task;	/* separate cp/wb IO stats*/
 	nid_t i_xattr_nid;		/* node id that contains xattrs */
 	loff_t	last_disk_size;		/* lastly written file size */
+	spinlock_t i_size_lock;		/* protect last_disk_size */
 
 #ifdef CONFIG_QUOTA
 	struct dquot *i_dquot[MAXQUOTAS];
@@ -2882,9 +2883,9 @@ static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
 	if (!f2fs_is_time_consistent(inode))
 		return false;
 
-	down_read(&F2FS_I(inode)->i_sem);
+	spin_lock(&F2FS_I(inode)->i_size_lock);
 	ret = F2FS_I(inode)->last_disk_size == i_size_read(inode);
-	up_read(&F2FS_I(inode)->i_sem);
+	spin_unlock(&F2FS_I(inode)->i_size_lock);
 
 	return ret;
 }
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b8f01ee9d698..40ed78026a25 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -931,10 +931,10 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 		if (err)
 			return err;
 
-		down_write(&F2FS_I(inode)->i_sem);
+		spin_lock(&F2FS_I(inode)->i_size_lock);
 		inode->i_mtime = inode->i_ctime = current_time(inode);
 		F2FS_I(inode)->last_disk_size = i_size_read(inode);
-		up_write(&F2FS_I(inode)->i_sem);
+		spin_unlock(&F2FS_I(inode)->i_size_lock);
 	}
 
 	__setattr_copy(inode, attr);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0b16204d3b7d..2d0e5d1269f5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -957,6 +957,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	/* Initialize f2fs-specific inode info */
 	atomic_set(&fi->dirty_pages, 0);
 	init_rwsem(&fi->i_sem);
+	spin_lock_init(&fi->i_size_lock);
 	INIT_LIST_HEAD(&fi->dirty_list);
 	INIT_LIST_HEAD(&fi->gdirty_list);
 	INIT_LIST_HEAD(&fi->inmem_ilist);
-- 
2.18.0.rc1

