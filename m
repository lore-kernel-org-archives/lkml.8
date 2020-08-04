Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831F9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9239D206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgHDA4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:56:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43584 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbgHDAz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:55:59 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3580CF61B8946DC49F7E;
        Tue,  4 Aug 2020 08:55:57 +0800 (CST)
Received: from [10.164.122.247] (10.164.122.247) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 4 Aug 2020
 08:55:55 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove a waiter for checkpoint
 completion
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Eric Biggers <ebiggers@kernel.org>
References: <20200803172825.4077289-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <9638d2c5-cfd0-359f-187a-8e23bc6d822d@huawei.com>
Date:   Tue, 4 Aug 2020 08:55:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200803172825.4077289-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.164.122.247]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/4 1:28, Jaegeuk Kim wrote:
> It doesn't need to wait for checkpoint being completed triggered by end_io.
> 
> [   20.157753] ------------[ cut here ]------------
> [   20.158393] do not call blocking ops when !TASK_RUNNING; state=2 set at [<0000000096354225>] prepare_to_wait+0xcd/0x430
> [   20.159858] WARNING: CPU: 1 PID: 1152 at kernel/sched/core.c:7142 __might_sleep+0x149/0x1a0
> ...
> [   20.176110]  __submit_merged_write_cond+0x191/0x310
> [   20.176739]  f2fs_submit_merged_write+0x18/0x20
> [   20.177323]  f2fs_wait_on_all_pages+0x269/0x2d0
> [   20.177899]  ? block_operations+0x980/0x980
> [   20.178441]  ? __kasan_check_read+0x11/0x20
> [   20.178975]  ? finish_wait+0x260/0x260
> [   20.179488]  ? percpu_counter_set+0x147/0x230
> [   20.180049]  do_checkpoint+0x1757/0x2a50
> [   20.180558]  f2fs_write_checkpoint+0x840/0xaf0
> [   20.181126]  f2fs_sync_fs+0x287/0x4a0
> 
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/checkpoint.c | 6 +-----
>   fs/f2fs/data.c       | 4 ----
>   fs/f2fs/f2fs.h       | 1 -
>   fs/f2fs/super.c      | 1 -
>   4 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 99c8061da55b9..2bdddc725e677 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1255,11 +1255,7 @@ static void unblock_operations(struct f2fs_sb_info *sbi)
>   
>   void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
>   {
> -	DEFINE_WAIT(wait);
> -
>   	for (;;) {
> -		prepare_to_wait(&sbi->cp_wait, &wait, TASK_UNINTERRUPTIBLE);

Wouldn't that case high cpu usage before io end?

> -
>   		if (!get_pages(sbi, type))
>   			break;
>   
> @@ -1271,9 +1267,9 @@ void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
>   							FS_CP_META_IO);
>   		else if (type == F2FS_WB_CP_DATA)
>   			f2fs_submit_merged_write(sbi, DATA);
> +
>   		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
>   	}
> -	finish_wait(&sbi->cp_wait, &wait);
>   }
>   
>   static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index c1b676be67b9a..588d2871bbe69 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -383,10 +383,6 @@ static void f2fs_write_end_io(struct bio *bio)
>   		clear_cold_data(page);
>   		end_page_writeback(page);
>   	}
> -	if (!get_pages(sbi, F2FS_WB_CP_DATA) &&
> -				wq_has_sleeper(&sbi->cp_wait))
> -		wake_up(&sbi->cp_wait);
> -
>   	bio_put(bio);
>   }
>   
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 02811ce15059b..a036539363030 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1437,7 +1437,6 @@ struct f2fs_sb_info {
>   	struct rw_semaphore cp_rwsem;		/* blocking FS operations */
>   	struct rw_semaphore node_write;		/* locking node writes */
>   	struct rw_semaphore node_change;	/* locking node change */
> -	wait_queue_head_t cp_wait;
>   	unsigned long last_time[MAX_TIME];	/* to store time in jiffies */
>   	long interval_time[MAX_TIME];		/* to store thresholds */
>   
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 83bf9a02f83f2..5f4d9abc079d6 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3540,7 +3540,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>   
>   	init_rwsem(&sbi->cp_rwsem);
>   	init_rwsem(&sbi->quota_sem);
> -	init_waitqueue_head(&sbi->cp_wait);
>   	init_sb_info(sbi);
>   
>   	err = init_percpu_info(sbi);
> 
