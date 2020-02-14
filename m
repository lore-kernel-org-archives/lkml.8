Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB3EC352A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C362187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgBNC0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 21:26:22 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:52924 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727782AbgBNC0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 21:26:22 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AC2E51EC5377813C92A3;
        Fri, 14 Feb 2020 10:26:19 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 14 Feb
 2020 10:26:19 +0800
Subject: Re: [PATCH] f2fs: fix the panic in do_checkpoint()
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1581503665-19914-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <5d5903e6-f089-7ecf-f1ff-ad341c4cef56@huawei.com>
Date:   Fri, 14 Feb 2020 10:26:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1581503665-19914-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sahitya,

On 2020/2/12 18:34, Sahitya Tummala wrote:
> There could be a scenario where f2fs_sync_meta_pages() will not
> ensure that all F2FS_DIRTY_META pages are submitted for IO. Thus,
> resulting in the below panic in do_checkpoint() -
> 
> f2fs_bug_on(sbi, get_pages(sbi, F2FS_DIRTY_META) &&
> 				!f2fs_cp_error(sbi));
> 
> This can happen in a low-memory condition, where shrinker could
> also be doing the writepage operation (stack shown below)
> at the same time when checkpoint is running on another core.
> 
> schedule
> down_write
> f2fs_submit_page_write -> by this time, this page in page cache is tagged
> 			as PAGECACHE_TAG_WRITEBACK and PAGECACHE_TAG_DIRTY
> 			is cleared, due to which f2fs_sync_meta_pages()
> 			cannot sync this page in do_checkpoint() path.
> f2fs_do_write_meta_page
> __f2fs_write_meta_page
> f2fs_write_meta_page
> shrink_page_list
> shrink_inactive_list
> shrink_node_memcg
> shrink_node
> kswapd

IMO, there may be one more simple fix here:

-	f2fs_do_write_meta_page(sbi, page, io_type);
	dec_page_count(sbi, F2FS_DIRTY_META);

+	f2fs_do_write_meta_page(sbi, page, io_type);

If we can remove F2FS_DIRTY_META reference count before we clear
PAGECACHE_TAG_DIRTY, we can avoid this race condition.

- dec_page_count(sbi, F2FS_DIRTY_META);
- f2fs_do_write_meta_page
 - set_page_writeback
  - __test_set_page_writeback
   - xas_clear_mark(&xas, PAGECACHE_TAG_DIRTY);

Thoughts?

> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
>  fs/f2fs/checkpoint.c | 16 ++++++++--------
>  fs/f2fs/f2fs.h       |  2 +-
>  fs/f2fs/super.c      |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index ffdaba0..2b651a3 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1250,14 +1250,14 @@ static void unblock_operations(struct f2fs_sb_info *sbi)
>  	f2fs_unlock_all(sbi);
>  }
>  
> -void f2fs_wait_on_all_pages_writeback(struct f2fs_sb_info *sbi)
> +void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
>  {
>  	DEFINE_WAIT(wait);
>  
>  	for (;;) {
>  		prepare_to_wait(&sbi->cp_wait, &wait, TASK_UNINTERRUPTIBLE);
>  
> -		if (!get_pages(sbi, F2FS_WB_CP_DATA))
> +		if (!get_pages(sbi, type))
>  			break;
>  
>  		if (unlikely(f2fs_cp_error(sbi)))
> @@ -1384,8 +1384,8 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  
>  	/* Flush all the NAT/SIT pages */
>  	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
> -	f2fs_bug_on(sbi, get_pages(sbi, F2FS_DIRTY_META) &&
> -					!f2fs_cp_error(sbi));
> +	/* Wait for all dirty meta pages to be submitted for IO */
> +	f2fs_wait_on_all_pages(sbi, F2FS_DIRTY_META);

I'm afraid calling f2fs_wait_on_all_pages() after we call
f2fs_sync_meta_pages() is low efficient, as we only want to write out
dirty meta pages instead of wait for writebacking them to device cache.

Thanks,

>  
>  	/*
>  	 * modify checkpoint
> @@ -1493,11 +1493,11 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  
>  	/* Here, we have one bio having CP pack except cp pack 2 page */
>  	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
> -	f2fs_bug_on(sbi, get_pages(sbi, F2FS_DIRTY_META) &&
> -					!f2fs_cp_error(sbi));
> +	/* Wait for all dirty meta pages to be submitted for IO */
> +	f2fs_wait_on_all_pages(sbi, F2FS_DIRTY_META);
>  
>  	/* wait for previous submitted meta pages writeback */
> -	f2fs_wait_on_all_pages_writeback(sbi);
> +	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
>  
>  	/* flush all device cache */
>  	err = f2fs_flush_device_cache(sbi);
> @@ -1506,7 +1506,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  
>  	/* barrier and flush checkpoint cp pack 2 page if it can */
>  	commit_checkpoint(sbi, ckpt, start_blk);
> -	f2fs_wait_on_all_pages_writeback(sbi);
> +	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
>  
>  	/*
>  	 * invalidate intermediate page cache borrowed from meta inode
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 5a888a0..b0e0535 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3196,7 +3196,7 @@ bool f2fs_is_dirty_device(struct f2fs_sb_info *sbi, nid_t ino,
>  void f2fs_update_dirty_page(struct inode *inode, struct page *page);
>  void f2fs_remove_dirty_inode(struct inode *inode);
>  int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type);
> -void f2fs_wait_on_all_pages_writeback(struct f2fs_sb_info *sbi);
> +void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type);
>  int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc);
>  void f2fs_init_ino_entry_info(struct f2fs_sb_info *sbi);
>  int __init f2fs_create_checkpoint_caches(void);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 5111e1f..084633b 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1105,7 +1105,7 @@ static void f2fs_put_super(struct super_block *sb)
>  	/* our cp_error case, we can wait for any writeback page */
>  	f2fs_flush_merged_writes(sbi);
>  
> -	f2fs_wait_on_all_pages_writeback(sbi);
> +	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
>  
>  	f2fs_bug_on(sbi, sbi->fsync_node_num);
>  
> 
