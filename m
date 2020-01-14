Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AA5C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6B224676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgANLhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:37:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbgANLhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:37:06 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C8605A6E80C2610A71DD;
        Tue, 14 Jan 2020 19:37:03 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Tue, 14 Jan 2020 19:36:57 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: change to use rwsem for gc_mutex
Date:   Tue, 14 Jan 2020 19:36:50 +0800
Message-ID: <20200114113650.104881-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mutex lock won't serialize callers, in order to avoid starving of unlucky
caller, let's use rwsem lock instead.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    |  5 ++++-
 fs/f2fs/file.c    | 12 ++++++------
 fs/f2fs/gc.c      | 12 ++++++------
 fs/f2fs/segment.c |  6 +++---
 fs/f2fs/super.c   | 16 ++++++++--------
 5 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e7208442d32a..61d62cd06449 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1391,7 +1391,10 @@ struct f2fs_sb_info {
 	struct f2fs_mount_info mount_opt;	/* mount options */
 
 	/* for cleaning operations */
-	struct mutex gc_mutex;			/* mutex for GC */
+	struct rw_semaphore gc_lock;		/*
+						 * semaphore for GC, avoid
+						 * race between GC and GC or CP
+						 */
 	struct f2fs_gc_kthread	*gc_thread;	/* GC thread */
 	unsigned int cur_victim_sec;		/* current victim section num */
 	unsigned int gc_mode;			/* current GC state */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0dff22566a1d..86ddbb55d2b1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1642,7 +1642,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 next_alloc:
 		if (has_not_enough_free_secs(sbi, 0,
 			GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
-			mutex_lock(&sbi->gc_mutex);
+			down_write(&sbi->gc_lock);
 			err = f2fs_gc(sbi, true, false, NULL_SEGNO);
 			if (err && err != -ENODATA && err != -EAGAIN)
 				goto out_err;
@@ -2450,12 +2450,12 @@ static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
 		return ret;
 
 	if (!sync) {
-		if (!mutex_trylock(&sbi->gc_mutex)) {
+		if (!down_write_trylock(&sbi->gc_lock)) {
 			ret = -EBUSY;
 			goto out;
 		}
 	} else {
-		mutex_lock(&sbi->gc_mutex);
+		down_write(&sbi->gc_lock);
 	}
 
 	ret = f2fs_gc(sbi, sync, true, NULL_SEGNO);
@@ -2493,12 +2493,12 @@ static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
 
 do_more:
 	if (!range.sync) {
-		if (!mutex_trylock(&sbi->gc_mutex)) {
+		if (!down_write_trylock(&sbi->gc_lock)) {
 			ret = -EBUSY;
 			goto out;
 		}
 	} else {
-		mutex_lock(&sbi->gc_mutex);
+		down_write(&sbi->gc_lock);
 	}
 
 	ret = f2fs_gc(sbi, range.sync, true, GET_SEGNO(sbi, range.start));
@@ -2929,7 +2929,7 @@ static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
 	end_segno = min(start_segno + range.segments, dev_end_segno);
 
 	while (start_segno < end_segno) {
-		if (!mutex_trylock(&sbi->gc_mutex)) {
+		if (!down_write_trylock(&sbi->gc_lock)) {
 			ret = -EBUSY;
 			goto out;
 		}
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c43181ef98c4..67eca7c2d983 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -78,18 +78,18 @@ static int gc_thread_func(void *data)
 		 */
 		if (sbi->gc_mode == GC_URGENT) {
 			wait_ms = gc_th->urgent_sleep_time;
-			mutex_lock(&sbi->gc_mutex);
+			down_write(&sbi->gc_lock);
 			goto do_gc;
 		}
 
-		if (!mutex_trylock(&sbi->gc_mutex)) {
+		if (!down_write_trylock(&sbi->gc_lock)) {
 			stat_other_skip_bggc_count(sbi);
 			goto next;
 		}
 
 		if (!is_idle(sbi, GC_TIME)) {
 			increase_sleep_time(gc_th, &wait_ms);
-			mutex_unlock(&sbi->gc_mutex);
+			up_write(&sbi->gc_lock);
 			stat_io_skip_bggc_count(sbi);
 			goto next;
 		}
@@ -1370,7 +1370,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 				reserved_segments(sbi),
 				prefree_segments(sbi));
 
-	mutex_unlock(&sbi->gc_mutex);
+	up_write(&sbi->gc_lock);
 
 	put_gc_inode(&gc_list);
 
@@ -1409,9 +1409,9 @@ static int free_segment_range(struct f2fs_sb_info *sbi, unsigned int start,
 			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
 		};
 
-		mutex_lock(&sbi->gc_mutex);
+		down_write(&sbi->gc_lock);
 		do_garbage_collect(sbi, segno, &gc_list, FG_GC);
-		mutex_unlock(&sbi->gc_mutex);
+		up_write(&sbi->gc_lock);
 		put_gc_inode(&gc_list);
 
 		if (get_valid_blocks(sbi, segno, true))
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 311fe4937f6a..6d03b89242f5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -504,7 +504,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 	 * dir/node pages without enough free segments.
 	 */
 	if (has_not_enough_free_secs(sbi, 0, 0)) {
-		mutex_lock(&sbi->gc_mutex);
+		down_write(&sbi->gc_lock);
 		f2fs_gc(sbi, false, false, NULL_SEGNO);
 	}
 }
@@ -2860,9 +2860,9 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	if (sbi->discard_blks == 0)
 		goto out;
 
-	mutex_lock(&sbi->gc_mutex);
+	down_write(&sbi->gc_lock);
 	err = f2fs_write_checkpoint(sbi, &cpc);
-	mutex_unlock(&sbi->gc_mutex);
+	up_write(&sbi->gc_lock);
 	if (err)
 		goto out;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 593dc3d2b80b..65a7a432dfee 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1238,9 +1238,9 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
 
 		cpc.reason = __get_cp_reason(sbi);
 
-		mutex_lock(&sbi->gc_mutex);
+		down_write(&sbi->gc_lock);
 		err = f2fs_write_checkpoint(sbi, &cpc);
-		mutex_unlock(&sbi->gc_mutex);
+		up_write(&sbi->gc_lock);
 	}
 	f2fs_trace_ios(NULL, 1);
 
@@ -1621,7 +1621,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 	f2fs_update_time(sbi, DISABLE_TIME);
 
 	while (!f2fs_time_over(sbi, DISABLE_TIME)) {
-		mutex_lock(&sbi->gc_mutex);
+		down_write(&sbi->gc_lock);
 		err = f2fs_gc(sbi, true, false, NULL_SEGNO);
 		if (err == -ENODATA) {
 			err = 0;
@@ -1643,7 +1643,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 		goto restore_flag;
 	}
 
-	mutex_lock(&sbi->gc_mutex);
+	down_write(&sbi->gc_lock);
 	cpc.reason = CP_PAUSE;
 	set_sbi_flag(sbi, SBI_CP_DISABLED);
 	err = f2fs_write_checkpoint(sbi, &cpc);
@@ -1655,7 +1655,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 	spin_unlock(&sbi->stat_lock);
 
 out_unlock:
-	mutex_unlock(&sbi->gc_mutex);
+	up_write(&sbi->gc_lock);
 restore_flag:
 	sbi->sb->s_flags = s_flags;	/* Restore MS_RDONLY status */
 	return err;
@@ -1663,12 +1663,12 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 
 static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 {
-	mutex_lock(&sbi->gc_mutex);
+	down_write(&sbi->gc_lock);
 	f2fs_dirty_to_prefree(sbi);
 
 	clear_sbi_flag(sbi, SBI_CP_DISABLED);
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
-	mutex_unlock(&sbi->gc_mutex);
+	up_write(&sbi->gc_lock);
 
 	f2fs_sync_fs(sbi->sb, 1);
 }
@@ -3398,7 +3398,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 	/* init f2fs-specific super block info */
 	sbi->valid_super_block = valid_super_block;
-	mutex_init(&sbi->gc_mutex);
+	init_rwsem(&sbi->gc_lock);
 	mutex_init(&sbi->writepages);
 	mutex_init(&sbi->cp_mutex);
 	mutex_init(&sbi->resize_mutex);
-- 
2.18.0.rc1

