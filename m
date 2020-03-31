Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAD5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E452B207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585680191;
	bh=XUefoLQMzwPO6HH1jLASwAgNeiuCX9ErnN1X063RO7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I5uh7N98dqa6Gkkh5ZspBb9VCUKV8ILJk/DboQn7k07RfPL1st83lso0gSDWsAtE3
	 ybBrFxFpOsfTAzvJYOtUUY86M6YCbOUA4ReaTAB8MwONji3nV+uqcNuKSSZ1NhdU7U
	 g5Ils2NY5z316hh9Y6S83hbJJ3opU/E3zVcGoAjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgCaSnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:43:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgCaSnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:43:09 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC7BF20784;
        Tue, 31 Mar 2020 18:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585680188;
        bh=XUefoLQMzwPO6HH1jLASwAgNeiuCX9ErnN1X063RO7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y6f2JwJXh7Isf27Ku0NGbH7S7Fo1jbuWTrOZX5g6UxyUGkteaLgngRALz44vqQzh9
         rcIOySaJWBIS4AgzZ95I3vyNN5GbFsK4f7ZezFB+f/0KE+RcOn396mQJtYSHldPUli
         yRkeGrdOPh1Ss2D99YGbDGz8msC3sJOVOn6EbE/I=
Date:   Tue, 31 Mar 2020 11:43:07 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Sahitya Tummala <stummala@codeaurora.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: prevent meta updates while checkpoint is in
 progress
Message-ID: <20200331184307.GA198665@google.com>
References: <1585219019-24831-1-git-send-email-stummala@codeaurora.org>
 <20200331035419.GB79749@google.com>
 <20200331090608.GZ20234@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331090608.GZ20234@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/31, Sahitya Tummala wrote:
> On Mon, Mar 30, 2020 at 08:54:19PM -0700, Jaegeuk Kim wrote:
> > On 03/26, Sahitya Tummala wrote:
> > > allocate_segment_for_resize() can cause metapage updates if
> > > it requires to change the current node/data segments for resizing.
> > > Stop these meta updates when there is a checkpoint already
> > > in progress to prevent inconsistent CP data.
> > 
> > I'd prefer to use f2fs_lock_op() in bigger coverage.
> 
> Do you mean to cover the entire free_segment_range() function within
> f2fs_lock_op()? Please clarify.

I didn't test tho, something like this?

---
 fs/f2fs/checkpoint.c        |  6 ++++--
 fs/f2fs/f2fs.h              |  2 +-
 fs/f2fs/gc.c                | 28 ++++++++++++++--------------
 fs/f2fs/super.c             |  1 -
 include/trace/events/f2fs.h |  4 +++-
 5 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 852890b72d6ac..531995192b714 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1553,7 +1553,8 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			return 0;
 		f2fs_warn(sbi, "Start checkpoint disabled!");
 	}
-	mutex_lock(&sbi->cp_mutex);
+	if (cpc->reason != CP_RESIZE)
+		mutex_lock(&sbi->cp_mutex);
 
 	if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY) &&
 		((cpc->reason & CP_FASTBOOT) || (cpc->reason & CP_SYNC) ||
@@ -1622,7 +1623,8 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	f2fs_update_time(sbi, CP_TIME);
 	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "finish checkpoint");
 out:
-	mutex_unlock(&sbi->cp_mutex);
+	if (cpc->reason != CP_RESIZE)
+		mutex_unlock(&sbi->cp_mutex);
 	return err;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c84442eefc56d..7c98dca3ec1d6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -193,6 +193,7 @@ enum {
 #define	CP_DISCARD	0x00000010
 #define CP_TRIMMED	0x00000020
 #define CP_PAUSE	0x00000040
+#define CP_RESIZE 	0x00000080
 
 #define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
 #define DEF_MAX_DISCARD_REQUEST		8	/* issue 8 discards per round */
@@ -1417,7 +1418,6 @@ struct f2fs_sb_info {
 	unsigned int segs_per_sec;		/* segments per section */
 	unsigned int secs_per_zone;		/* sections per zone */
 	unsigned int total_sections;		/* total section count */
-	struct mutex resize_mutex;		/* for resize exclusion */
 	unsigned int total_node_count;		/* total node block count */
 	unsigned int total_valid_node_count;	/* valid node block count */
 	loff_t max_file_blocks;			/* max block index of file */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 26248c8936db0..1e5a06fda09d3 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1402,8 +1402,9 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
 static int free_segment_range(struct f2fs_sb_info *sbi, unsigned int start,
 							unsigned int end)
 {
-	int type;
 	unsigned int segno, next_inuse;
+	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
+	int type;
 	int err = 0;
 
 	/* Move out cursegs from the target range */
@@ -1417,16 +1418,14 @@ static int free_segment_range(struct f2fs_sb_info *sbi, unsigned int start,
 			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
 		};
 
-		down_write(&sbi->gc_lock);
 		do_garbage_collect(sbi, segno, &gc_list, FG_GC);
-		up_write(&sbi->gc_lock);
 		put_gc_inode(&gc_list);
 
 		if (get_valid_blocks(sbi, segno, true))
 			return -EAGAIN;
 	}
 
-	err = f2fs_sync_fs(sbi->sb, 1);
+	err = f2fs_write_checkpoint(sbi, &cpc);
 	if (err)
 		return err;
 
@@ -1502,6 +1501,7 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 {
 	__u64 old_block_count, shrunk_blocks;
+	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
 	unsigned int secs;
 	int gc_mode, gc_type;
 	int err = 0;
@@ -1538,7 +1538,9 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 		return -EINVAL;
 	}
 
-	freeze_bdev(sbi->sb->s_bdev);
+	freeze_super(sbi->sb);
+	down_write(&sbi->gc_lock);
+	mutex_lock(&sbi->cp_mutex);
 
 	shrunk_blocks = old_block_count - block_count;
 	secs = div_u64(shrunk_blocks, BLKS_PER_SEC(sbi));
@@ -1551,11 +1553,12 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 		sbi->user_block_count -= shrunk_blocks;
 	spin_unlock(&sbi->stat_lock);
 	if (err) {
-		thaw_bdev(sbi->sb->s_bdev, sbi->sb);
+		mutex_unlock(&sbi->cp_mutex);
+		up_write(&sbi->gc_lock);
+		thaw_super(sbi->sb);
 		return err;
 	}
 
-	mutex_lock(&sbi->resize_mutex);
 	set_sbi_flag(sbi, SBI_IS_RESIZEFS);
 
 	mutex_lock(&DIRTY_I(sbi)->seglist_lock);
@@ -1587,17 +1590,13 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 		goto out;
 	}
 
-	mutex_lock(&sbi->cp_mutex);
 	update_fs_metadata(sbi, -secs);
 	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
-	mutex_unlock(&sbi->cp_mutex);
 
-	err = f2fs_sync_fs(sbi->sb, 1);
+	err = f2fs_write_checkpoint(sbi, &cpc);
 	if (err) {
-		mutex_lock(&sbi->cp_mutex);
 		update_fs_metadata(sbi, secs);
-		mutex_unlock(&sbi->cp_mutex);
 		update_sb_metadata(sbi, secs);
 		f2fs_commit_super(sbi, false);
 	}
@@ -1612,7 +1611,8 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 		spin_unlock(&sbi->stat_lock);
 	}
 	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
-	mutex_unlock(&sbi->resize_mutex);
-	thaw_bdev(sbi->sb->s_bdev, sbi->sb);
+	mutex_unlock(&sbi->cp_mutex);
+	up_write(&sbi->gc_lock);
+	thaw_super(sbi->sb);
 	return err;
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b83b17b54a0a6..1e7b1d21d0177 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3412,7 +3412,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	init_rwsem(&sbi->gc_lock);
 	mutex_init(&sbi->writepages);
 	mutex_init(&sbi->cp_mutex);
-	mutex_init(&sbi->resize_mutex);
 	init_rwsem(&sbi->node_write);
 	init_rwsem(&sbi->node_change);
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index d97adfc327f03..f5eb03c54e96f 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -50,6 +50,7 @@ TRACE_DEFINE_ENUM(CP_RECOVERY);
 TRACE_DEFINE_ENUM(CP_DISCARD);
 TRACE_DEFINE_ENUM(CP_TRIMMED);
 TRACE_DEFINE_ENUM(CP_PAUSE);
+TRACE_DEFINE_ENUM(CP_RESIZE);
 
 #define show_block_type(type)						\
 	__print_symbolic(type,						\
@@ -126,7 +127,8 @@ TRACE_DEFINE_ENUM(CP_PAUSE);
 		{ CP_RECOVERY,	"Recovery" },				\
 		{ CP_DISCARD,	"Discard" },				\
 		{ CP_PAUSE,	"Pause" },				\
-		{ CP_TRIMMED,	"Trimmed" })
+		{ CP_TRIMMED,	"Trimmed" },				\
+		{ CP_RESIZE,	"Resize" })
 
 #define show_fsync_cpreason(type)					\
 	__print_symbolic(type,						\
-- 
2.26.0.rc2.310.g2932bb562d-goog

