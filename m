Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4413FC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 02:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA8B206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 02:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgDGCea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 22:34:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60472 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgDGCe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 22:34:29 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4E1C6AEAD2CAE43C0EFE;
        Tue,  7 Apr 2020 10:34:22 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 7 Apr 2020
 10:34:19 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: prevent meta updates while checkpoint is
 in progress
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Sahitya Tummala <stummala@codeaurora.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <1585219019-24831-1-git-send-email-stummala@codeaurora.org>
 <20200331035419.GB79749@google.com> <20200331090608.GZ20234@codeaurora.org>
 <20200331184307.GA198665@google.com> <20200401050801.GA20234@codeaurora.org>
 <20200403171727.GB68460@google.com> <20200403172750.GD68460@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8ab6c209-8fbf-eadb-17cb-d96cc10f868d@huawei.com>
Date:   Tue, 7 Apr 2020 10:34:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200403172750.GD68460@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/4 1:27, Jaegeuk Kim wrote:
> On 04/03, Jaegeuk Kim wrote:
>> On 04/01, Sahitya Tummala wrote:
>>> Hi Jaegeuk,
>>>
>>> Got it.
>>> The diff below looks good to me.
>>> Would you like me to test it and put a patch for this?
>>
>> Sahitya, Chao,
>>
>> Could you please take a look at this patch and test intensively?
>>
>> Thanks,
> 
> v2:
> 
>>From 6bf7d5b227d466b0fe90d4957af29bd184fb646e Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Tue, 31 Mar 2020 11:43:07 -0700
> Subject: [PATCH] f2fs: refactor resize_fs to avoid meta updates in progress
> 
> Sahitya raised an issue:
> - prevent meta updates while checkpoint is in progress
> 
> allocate_segment_for_resize() can cause metapage updates if
> it requires to change the current node/data segments for resizing.
> Stop these meta updates when there is a checkpoint already
> in progress to prevent inconsistent CP data.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c        |   6 +-
>  fs/f2fs/f2fs.h              |   2 +-
>  fs/f2fs/file.c              |   5 +-
>  fs/f2fs/gc.c                | 107 +++++++++++++++++++-----------------
>  fs/f2fs/super.c             |   1 -
>  include/trace/events/f2fs.h |   4 +-
>  6 files changed, 67 insertions(+), 58 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 852890b72d6ac..531995192b714 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1553,7 +1553,8 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  			return 0;
>  		f2fs_warn(sbi, "Start checkpoint disabled!");
>  	}
> -	mutex_lock(&sbi->cp_mutex);
> +	if (cpc->reason != CP_RESIZE)
> +		mutex_lock(&sbi->cp_mutex);
>  
>  	if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY) &&
>  		((cpc->reason & CP_FASTBOOT) || (cpc->reason & CP_SYNC) ||
> @@ -1622,7 +1623,8 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	f2fs_update_time(sbi, CP_TIME);
>  	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "finish checkpoint");
>  out:
> -	mutex_unlock(&sbi->cp_mutex);
> +	if (cpc->reason != CP_RESIZE)
> +		mutex_unlock(&sbi->cp_mutex);
>  	return err;
>  }
>  
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index be02a5cadd944..f9b2caa2135bd 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -193,6 +193,7 @@ enum {
>  #define	CP_DISCARD	0x00000010
>  #define CP_TRIMMED	0x00000020
>  #define CP_PAUSE	0x00000040
> +#define CP_RESIZE 	0x00000080
>  
>  #define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
>  #define DEF_MAX_DISCARD_REQUEST		8	/* issue 8 discards per round */
> @@ -1421,7 +1422,6 @@ struct f2fs_sb_info {
>  	unsigned int segs_per_sec;		/* segments per section */
>  	unsigned int secs_per_zone;		/* sections per zone */
>  	unsigned int total_sections;		/* total section count */
> -	struct mutex resize_mutex;		/* for resize exclusion */
>  	unsigned int total_node_count;		/* total node block count */
>  	unsigned int total_valid_node_count;	/* valid node block count */
>  	loff_t max_file_blocks;			/* max block index of file */
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 257e61d0afffb..b4c12370bb3d6 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3305,7 +3305,6 @@ static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
>  	__u64 block_count;
> -	int ret;
>  
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
> @@ -3317,9 +3316,7 @@ static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
>  			   sizeof(block_count)))
>  		return -EFAULT;
>  
> -	ret = f2fs_resize_fs(sbi, block_count);
> -
> -	return ret;
> +	return f2fs_resize_fs(sbi, block_count);
>  }
>  
>  static int f2fs_ioc_enable_verity(struct file *filp, unsigned long arg)
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 26248c8936db0..46c75ecb64a2e 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1399,12 +1399,29 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
>  				GET_SEGNO(sbi, FDEV(0).end_blk) + 1;
>  }
>  
> -static int free_segment_range(struct f2fs_sb_info *sbi, unsigned int start,
> -							unsigned int end)
> +static int free_segment_range(struct f2fs_sb_info *sbi,
> +				unsigned int secs, bool gc_only)
>  {
> -	int type;
> -	unsigned int segno, next_inuse;
> +	unsigned int segno, next_inuse, start, end;
> +	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
> +	int gc_mode, gc_type;
>  	int err = 0;
> +	int type;
> +
> +	/* Force block allocation for GC */
> +	MAIN_SECS(sbi) -= secs;
> +	start = MAIN_SECS(sbi) * sbi->segs_per_sec;
> +	end = MAIN_SEGS(sbi) - 1;
> +
> +	mutex_lock(&DIRTY_I(sbi)->seglist_lock);
> +	for (gc_mode = 0; gc_mode < MAX_GC_POLICY; gc_mode++)
> +		if (SIT_I(sbi)->last_victim[gc_mode] >= start)
> +			SIT_I(sbi)->last_victim[gc_mode] = 0;
> +
> +	for (gc_type = BG_GC; gc_type <= FG_GC; gc_type++)
> +		if (sbi->next_victim_seg[gc_type] >= start)
> +			sbi->next_victim_seg[gc_type] = NULL_SEGNO;
> +	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
>  
>  	/* Move out cursegs from the target range */
>  	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++)
> @@ -1417,18 +1434,20 @@ static int free_segment_range(struct f2fs_sb_info *sbi, unsigned int start,
>  			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
>  		};
>  
> -		down_write(&sbi->gc_lock);
>  		do_garbage_collect(sbi, segno, &gc_list, FG_GC);
> -		up_write(&sbi->gc_lock);
>  		put_gc_inode(&gc_list);
>  
> -		if (get_valid_blocks(sbi, segno, true))
> -			return -EAGAIN;
> +		if (!gc_only && get_valid_blocks(sbi, segno, true)) {
> +			err = -EAGAIN;
> +			goto out;
> +		}
>  	}
> +	if (gc_only)
> +		goto out;
>  
> -	err = f2fs_sync_fs(sbi->sb, 1);
> +	err = f2fs_write_checkpoint(sbi, &cpc);
>  	if (err)
> -		return err;
> +		goto out;
>  
>  	next_inuse = find_next_inuse(FREE_I(sbi), end + 1, start);
>  	if (next_inuse <= end) {
> @@ -1436,6 +1455,8 @@ static int free_segment_range(struct f2fs_sb_info *sbi, unsigned int start,
>  			 next_inuse);
>  		f2fs_bug_on(sbi, 1);
>  	}
> +out:
> +	MAIN_SECS(sbi) -= secs;
>  	return err;
>  }
>  
> @@ -1481,6 +1502,7 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
>  
>  	SM_I(sbi)->segment_count = (int)SM_I(sbi)->segment_count + segs;
>  	MAIN_SEGS(sbi) = (int)MAIN_SEGS(sbi) + segs;
> +	MAIN_SECS(sbi) += secs;
>  	FREE_I(sbi)->free_sections = (int)FREE_I(sbi)->free_sections + secs;
>  	FREE_I(sbi)->free_segments = (int)FREE_I(sbi)->free_segments + segs;
>  	F2FS_CKPT(sbi)->user_block_count = cpu_to_le64(user_block_count + blks);
> @@ -1502,8 +1524,8 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
>  int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>  {
>  	__u64 old_block_count, shrunk_blocks;
> +	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
>  	unsigned int secs;
> -	int gc_mode, gc_type;
>  	int err = 0;
>  	__u32 rem;
>  
> @@ -1538,10 +1560,22 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>  		return -EINVAL;
>  	}
>  
> -	freeze_bdev(sbi->sb->s_bdev);
> -
>  	shrunk_blocks = old_block_count - block_count;
>  	secs = div_u64(shrunk_blocks, BLKS_PER_SEC(sbi));
> +
> +	/* protect MAIN_SEC in free_segment_range */
> +	f2fs_lock_op(sbi);
> +	err = free_segment_range(sbi, secs, true);

For this path, we break the rule that we need hold gc_lock during
do_garbage_collect().

One other concern is that still the granularity of lock_op is too large,
to avoid potential hang if it triggers heavy gc migration, how about using
a timeout mechanism in free_segment_range() like we did in
f2fs_disable_checkpoint()?

> +	f2fs_unlock_op(sbi);
> +	if (err)
> +		return err;
> +
> +	set_sbi_flag(sbi, SBI_IS_RESIZEFS);
> +
> +	freeze_super(sbi->sb);
> +	down_write(&sbi->gc_lock);
> +	mutex_lock(&sbi->cp_mutex);
> +
>  	spin_lock(&sbi->stat_lock);
>  	if (shrunk_blocks + valid_user_blocks(sbi) +
>  		sbi->current_reserved_blocks + sbi->unusable_block_count +
> @@ -1550,69 +1584,44 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>  	else
>  		sbi->user_block_count -= shrunk_blocks;
>  	spin_unlock(&sbi->stat_lock);
> -	if (err) {
> -		thaw_bdev(sbi->sb->s_bdev, sbi->sb);
> -		return err;
> -	}
> -
> -	mutex_lock(&sbi->resize_mutex);
> -	set_sbi_flag(sbi, SBI_IS_RESIZEFS);
> -
> -	mutex_lock(&DIRTY_I(sbi)->seglist_lock);
> -
> -	MAIN_SECS(sbi) -= secs;
> -
> -	for (gc_mode = 0; gc_mode < MAX_GC_POLICY; gc_mode++)
> -		if (SIT_I(sbi)->last_victim[gc_mode] >=
> -					MAIN_SECS(sbi) * sbi->segs_per_sec)
> -			SIT_I(sbi)->last_victim[gc_mode] = 0;
> -
> -	for (gc_type = BG_GC; gc_type <= FG_GC; gc_type++)
> -		if (sbi->next_victim_seg[gc_type] >=
> -					MAIN_SECS(sbi) * sbi->segs_per_sec)
> -			sbi->next_victim_seg[gc_type] = NULL_SEGNO;
> -
> -	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
> +	if (err)
> +		goto out_err;
>  
> -	err = free_segment_range(sbi, MAIN_SECS(sbi) * sbi->segs_per_sec,
> -			MAIN_SEGS(sbi) - 1);
> +	err = free_segment_range(sbi, secs, false);

Lock coverage is still large here, what about just checking the resize condition
with find_next_inuse(, end + 1, start), if the migration finished, then let's call
write_checkpoint(), otherwise, returning -EAGAIN.

>  	if (err)
> -		goto out;
> +		goto recover_out;
>  
>  	update_sb_metadata(sbi, -secs);
>  
>  	err = f2fs_commit_super(sbi, false);
>  	if (err) {
>  		update_sb_metadata(sbi, secs);
> -		goto out;
> +		goto recover_out;
>  	}
>  
> -	mutex_lock(&sbi->cp_mutex);
>  	update_fs_metadata(sbi, -secs);
>  	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
>  	set_sbi_flag(sbi, SBI_IS_DIRTY);
> -	mutex_unlock(&sbi->cp_mutex);
>  
> -	err = f2fs_sync_fs(sbi->sb, 1);
> +	err = f2fs_write_checkpoint(sbi, &cpc);
>  	if (err) {
> -		mutex_lock(&sbi->cp_mutex);
>  		update_fs_metadata(sbi, secs);
> -		mutex_unlock(&sbi->cp_mutex);
>  		update_sb_metadata(sbi, secs);
>  		f2fs_commit_super(sbi, false);
>  	}
> -out:
> +recover_out:
>  	if (err) {
>  		set_sbi_flag(sbi, SBI_NEED_FSCK);
>  		f2fs_err(sbi, "resize_fs failed, should run fsck to repair!");
>  
> -		MAIN_SECS(sbi) += secs;
>  		spin_lock(&sbi->stat_lock);
>  		sbi->user_block_count += shrunk_blocks;
>  		spin_unlock(&sbi->stat_lock);
>  	}
> +out_err:
> +	mutex_unlock(&sbi->cp_mutex);
> +	up_write(&sbi->gc_lock);
> +	thaw_super(sbi->sb);
>  	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
> -	mutex_unlock(&sbi->resize_mutex);
> -	thaw_bdev(sbi->sb->s_bdev, sbi->sb);
>  	return err;
>  }
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index b83b17b54a0a6..1e7b1d21d0177 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3412,7 +3412,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  	init_rwsem(&sbi->gc_lock);
>  	mutex_init(&sbi->writepages);
>  	mutex_init(&sbi->cp_mutex);
> -	mutex_init(&sbi->resize_mutex);
>  	init_rwsem(&sbi->node_write);
>  	init_rwsem(&sbi->node_change);
>  
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index 4d7d4c391879d..5d1a72001fdb4 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -50,6 +50,7 @@ TRACE_DEFINE_ENUM(CP_RECOVERY);
>  TRACE_DEFINE_ENUM(CP_DISCARD);
>  TRACE_DEFINE_ENUM(CP_TRIMMED);
>  TRACE_DEFINE_ENUM(CP_PAUSE);
> +TRACE_DEFINE_ENUM(CP_RESIZE);
>  
>  #define show_block_type(type)						\
>  	__print_symbolic(type,						\
> @@ -126,7 +127,8 @@ TRACE_DEFINE_ENUM(CP_PAUSE);
>  		{ CP_RECOVERY,	"Recovery" },				\
>  		{ CP_DISCARD,	"Discard" },				\
>  		{ CP_PAUSE,	"Pause" },				\
> -		{ CP_TRIMMED,	"Trimmed" })
> +		{ CP_TRIMMED,	"Trimmed" },				\
> +		{ CP_RESIZE,	"Resize" })
>  
>  #define show_fsync_cpreason(type)					\
>  	__print_symbolic(type,						\
> 
