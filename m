Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1889C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C55ED20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593462016;
	bh=Q+nb5q1cvvwhLMQRTlsmjm6i6AodKrYeamR2WgN/o9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XQFkYfxH4vXlnEXoOuP+9d+KyMWLOitvB+LScdLuSS/WdgfRiCUJqV93bd2DM9Jvl
	 ///XOs0O4Zfd53TSbsKZaEfwMhQ4N6WS46/a3uFCzcBB12DSs1z+t8NmiTkS0oYLit
	 jKeImqGQxBl03ra87X2hAqg2gihpnVDQnIVw/s3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732611AbgF2UUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730358AbgF2UTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:19:46 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F40120656;
        Mon, 29 Jun 2020 20:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593461985;
        bh=Q+nb5q1cvvwhLMQRTlsmjm6i6AodKrYeamR2WgN/o9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OfapS9P/M1RT/W0yP+3qKkf31PJT12faFLUknJbUW3G0vqei9SL47icfW/aG1ExQP
         /fsWyiNZXV7T8068iwQ/GDuJwIdgmjm9SY6wmo3ey9AR8Bpq3m/g/BUrvFF6Rop0a0
         gRs3feFy5Ahc5Nu0Dj10yYxE71EWwQPkN5PPS5+Y=
Date:   Mon, 29 Jun 2020 13:19:43 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 1/2] f2fs: split f2fs_allocate_new_segments()
Message-ID: <20200629201943.GB1117827@google.com>
References: <20200622093849.35684-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622093849.35684-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22, Chao Yu wrote:
> to two independent functions:
> - f2fs_allocate_new_segment() for specified type segment allocation
> - f2fs_allocate_new_segments() for all data type segments allocation
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h     |  3 ++-
>  fs/f2fs/file.c     |  2 +-
>  fs/f2fs/recovery.c |  2 +-
>  fs/f2fs/segment.c  | 39 +++++++++++++++++++++++----------------
>  4 files changed, 27 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 70565d81320b..07290943e91d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3327,7 +3327,8 @@ void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
>  int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
>  void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>  					unsigned int start, unsigned int end);
> -void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi, int type);
> +void f2fs_allocate_new_segment(struct f2fs_sb_info *sbi, int type);
> +void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi);
>  int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range);
>  bool f2fs_exist_trim_candidates(struct f2fs_sb_info *sbi,
>  					struct cp_control *cpc);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index f196187159e9..67c65e40b22b 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1659,7 +1659,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
>  		map.m_seg_type = CURSEG_COLD_DATA_PINNED;
>  
>  		f2fs_lock_op(sbi);
> -		f2fs_allocate_new_segments(sbi, CURSEG_COLD_DATA);
> +		f2fs_allocate_new_segment(sbi, CURSEG_COLD_DATA_PINNED);

This should be CURSEG_COLD_DATA. Otherwise it causes the below kernel panic.
I fixed this in the -dev, so let me know, if you have other concern.

  259 Unable to handle kernel NULL pointer dereference at virtual address 00000008
  259 task: 0000000082b4de99 task.stack: 00000000c6b39dbf
  259 pc : f2fs_do_write_data_page+0x2b4/0x794
  259 lr : f2fs_do_write_data_page+0x290/0x794
  259 sp : ffffff800c83b5a0 pstate : 60c00145
  259 Call trace:
  259  f2fs_do_write_data_page+0x2b4/0x794
  259  f2fs_write_single_data_page+0x4a4/0x764
  259  f2fs_write_data_pages+0x4dc/0x968
  259  do_writepages+0x60/0x124
  259  __writeback_single_inode+0xd8/0x490
  259  writeback_sb_inodes+0x3a8/0x6e4
  259  __writeback_inodes_wb+0xa4/0x14c
  259  wb_writeback+0x218/0x434
  259  wb_workfn+0x2bc/0x57c
  259  process_one_work+0x25c/0x440
  259  worker_thread+0x24c/0x480
  259  kthread+0x11c/0x12c
  259  ret_from_fork+0x10/0x18

>  		f2fs_unlock_op(sbi);
>  
>  		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_DIO);
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index ae5310f02e7f..af974ba273b3 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -742,7 +742,7 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
>  		f2fs_put_page(page, 1);
>  	}
>  	if (!err)
> -		f2fs_allocate_new_segments(sbi, NO_CHECK_TYPE);
> +		f2fs_allocate_new_segments(sbi);
>  	return err;
>  }
>  
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 113114f98087..f15711e8ee5b 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2707,28 +2707,35 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>  	up_read(&SM_I(sbi)->curseg_lock);
>  }
>  
> -void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi, int type)
> +void __allocate_new_segment(struct f2fs_sb_info *sbi, int type)
>  {
> -	struct curseg_info *curseg;
> +	struct curseg_info *curseg = CURSEG_I(sbi, type);
>  	unsigned int old_segno;
> -	int i;
>  
> -	down_write(&SIT_I(sbi)->sentry_lock);
> +	if (!curseg->next_blkoff &&
> +		!get_valid_blocks(sbi, curseg->segno, false) &&
> +		!get_ckpt_valid_blocks(sbi, curseg->segno))
> +		return;
>  
> -	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
> -		if (type != NO_CHECK_TYPE && i != type)
> -			continue;
> +	old_segno = curseg->segno;
> +	SIT_I(sbi)->s_ops->allocate_segment(sbi, type, true);
> +	locate_dirty_segment(sbi, old_segno);
> +}
>  
> -		curseg = CURSEG_I(sbi, i);
> -		if (type == NO_CHECK_TYPE || curseg->next_blkoff ||
> -				get_valid_blocks(sbi, curseg->segno, false) ||
> -				get_ckpt_valid_blocks(sbi, curseg->segno)) {
> -			old_segno = curseg->segno;
> -			SIT_I(sbi)->s_ops->allocate_segment(sbi, i, true);
> -			locate_dirty_segment(sbi, old_segno);
> -		}
> -	}
> +void f2fs_allocate_new_segment(struct f2fs_sb_info *sbi, int type)
> +{
> +	down_write(&SIT_I(sbi)->sentry_lock);
> +	__allocate_new_segment(sbi, type);
> +	up_write(&SIT_I(sbi)->sentry_lock);
> +}
>  
> +void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi)
> +{
> +	int i;
> +
> +	down_write(&SIT_I(sbi)->sentry_lock);
> +	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++)
> +		__allocate_new_segment(sbi, i);
>  	up_write(&SIT_I(sbi)->sentry_lock);
>  }
>  
> -- 
> 2.26.2
