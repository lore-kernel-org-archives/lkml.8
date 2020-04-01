Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6FEC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 02:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0173B2072E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 02:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbgDACyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 22:54:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42446 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731531AbgDACyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 22:54:17 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B3D37C7476AA77FA5ADD;
        Wed,  1 Apr 2020 10:54:06 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 1 Apr 2020
 10:54:01 +0800
Subject: Re: [PATCH] f2fs: prevent meta updates while checkpoint is in
 progress
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Sahitya Tummala <stummala@codeaurora.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1585219019-24831-1-git-send-email-stummala@codeaurora.org>
 <20200331035419.GB79749@google.com> <20200331090608.GZ20234@codeaurora.org>
 <20200331184307.GA198665@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a56deb76-bf7f-dd86-301f-fbe56413ab9b@huawei.com>
Date:   Wed, 1 Apr 2020 10:54:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200331184307.GA198665@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/1 2:43, Jaegeuk Kim wrote:
> On 03/31, Sahitya Tummala wrote:
>> On Mon, Mar 30, 2020 at 08:54:19PM -0700, Jaegeuk Kim wrote:
>>> On 03/26, Sahitya Tummala wrote:
>>>> allocate_segment_for_resize() can cause metapage updates if
>>>> it requires to change the current node/data segments for resizing.
>>>> Stop these meta updates when there is a checkpoint already
>>>> in progress to prevent inconsistent CP data.
>>>
>>> I'd prefer to use f2fs_lock_op() in bigger coverage.
>>
>> Do you mean to cover the entire free_segment_range() function within
>> f2fs_lock_op()? Please clarify.
> 
> I didn't test tho, something like this?
> 
> ---
>  fs/f2fs/checkpoint.c        |  6 ++++--
>  fs/f2fs/f2fs.h              |  2 +-
>  fs/f2fs/gc.c                | 28 ++++++++++++++--------------
>  fs/f2fs/super.c             |  1 -
>  include/trace/events/f2fs.h |  4 +++-
>  5 files changed, 22 insertions(+), 19 deletions(-)
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
> index c84442eefc56d..7c98dca3ec1d6 100644
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
> @@ -1417,7 +1418,6 @@ struct f2fs_sb_info {
>  	unsigned int segs_per_sec;		/* segments per section */
>  	unsigned int secs_per_zone;		/* sections per zone */
>  	unsigned int total_sections;		/* total section count */
> -	struct mutex resize_mutex;		/* for resize exclusion */
>  	unsigned int total_node_count;		/* total node block count */
>  	unsigned int total_valid_node_count;	/* valid node block count */
>  	loff_t max_file_blocks;			/* max block index of file */
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 26248c8936db0..1e5a06fda09d3 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1402,8 +1402,9 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
>  static int free_segment_range(struct f2fs_sb_info *sbi, unsigned int start,
>  							unsigned int end)
>  {
> -	int type;
>  	unsigned int segno, next_inuse;
> +	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
> +	int type;
>  	int err = 0;
>  
>  	/* Move out cursegs from the target range */
> @@ -1417,16 +1418,14 @@ static int free_segment_range(struct f2fs_sb_info *sbi, unsigned int start,
>  			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
>  		};
>  
> -		down_write(&sbi->gc_lock);
>  		do_garbage_collect(sbi, segno, &gc_list, FG_GC);
> -		up_write(&sbi->gc_lock);
>  		put_gc_inode(&gc_list);
>  
>  		if (get_valid_blocks(sbi, segno, true))
>  			return -EAGAIN;
>  	}
>  
> -	err = f2fs_sync_fs(sbi->sb, 1);
> +	err = f2fs_write_checkpoint(sbi, &cpc);
>  	if (err)
>  		return err;
>  
> @@ -1502,6 +1501,7 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
>  int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>  {
>  	__u64 old_block_count, shrunk_blocks;
> +	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
>  	unsigned int secs;
>  	int gc_mode, gc_type;
>  	int err = 0;
> @@ -1538,7 +1538,9 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>  		return -EINVAL;
>  	}
>  
> -	freeze_bdev(sbi->sb->s_bdev);
> +	freeze_super(sbi->sb);

Look at this again, I guess holding freeze lock here may cause potential
hang task issue, imaging that in a low-end storage, shrinking large size
address space, free_segment_range() needs very long time to migrate all
valid blocks in the tail of device, that's why previously we do block
migration with small gc_lock coverage.

Quoted:

Changelog v5 ==> v6:
 - In free_segment_range(), reduce granularity of gc_mutex.

Thanks,

> +	down_write(&sbi->gc_lock);
> +	mutex_lock(&sbi->cp_mutex);
>  
>  	shrunk_blocks = old_block_count - block_count;
>  	secs = div_u64(shrunk_blocks, BLKS_PER_SEC(sbi));
> @@ -1551,11 +1553,12 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>  		sbi->user_block_count -= shrunk_blocks;
>  	spin_unlock(&sbi->stat_lock);
>  	if (err) {
> -		thaw_bdev(sbi->sb->s_bdev, sbi->sb);
> +		mutex_unlock(&sbi->cp_mutex);
> +		up_write(&sbi->gc_lock);
> +		thaw_super(sbi->sb);
>  		return err;
>  	}
>  
> -	mutex_lock(&sbi->resize_mutex);
>  	set_sbi_flag(sbi, SBI_IS_RESIZEFS);
>  
>  	mutex_lock(&DIRTY_I(sbi)->seglist_lock);
> @@ -1587,17 +1590,13 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>  		goto out;
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
> @@ -1612,7 +1611,8 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>  		spin_unlock(&sbi->stat_lock);
>  	}
>  	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
> -	mutex_unlock(&sbi->resize_mutex);
> -	thaw_bdev(sbi->sb->s_bdev, sbi->sb);
> +	mutex_unlock(&sbi->cp_mutex);
> +	up_write(&sbi->gc_lock);
> +	thaw_super(sbi->sb);
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
> index d97adfc327f03..f5eb03c54e96f 100644
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
