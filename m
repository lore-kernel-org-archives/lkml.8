Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71079C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4701D206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgGADfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 23:35:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50768 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbgGADfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 23:35:53 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4DC499D97A5B2F500D19;
        Wed,  1 Jul 2020 11:35:51 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 1 Jul 2020
 11:35:45 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: add GC_URGENT_LOW mode in gc_urgent
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20200630005422.2389686-1-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a10baad2-350a-ea1b-c338-63b2bc58a26a@huawei.com>
Date:   Wed, 1 Jul 2020 11:35:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200630005422.2389686-1-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/30 8:54, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added a new gc_urgent mode, GC_URGENT_LOW, in which mode
> F2FS will lower the bar of checking idle in order to
> process outstanding discard commands and GC a little bit
> aggressively.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs |  4 +++-
>  fs/f2fs/f2fs.h                          | 10 ++++++++--
>  fs/f2fs/gc.c                            |  6 +++---
>  fs/f2fs/segment.c                       |  4 ++--
>  fs/f2fs/sysfs.c                         |  6 ++++--
>  5 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 4bb93a06d8ab..7f730c4c8df2 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -229,7 +229,9 @@ Date:		August 2017
>  Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
>  Description:	Do background GC agressively when set. When gc_urgent = 1,
>  		background thread starts to do GC by given gc_urgent_sleep_time
> -		interval. It is set to 0 by default.
> +		interval. When gc_urgent = 2, F2FS will lower the bar of
> +		checking idle in order to process outstanding discard commands
> +		and GC a little bit aggressively. It is set to 0 by default.
>  
>  What:		/sys/fs/f2fs/<disk>/gc_urgent_sleep_time
>  Date:		August 2017
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e6e47618a357..4b28fd42fdbc 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1283,7 +1283,8 @@ enum {
>  	GC_NORMAL,
>  	GC_IDLE_CB,
>  	GC_IDLE_GREEDY,
> -	GC_URGENT,
> +	GC_URGENT_HIGH,
> +	GC_URGENT_LOW,
>  };
>  
>  enum {
> @@ -1540,6 +1541,7 @@ struct f2fs_sb_info {
>  	unsigned int cur_victim_sec;		/* current victim section num */
>  	unsigned int gc_mode;			/* current GC state */
>  	unsigned int next_victim_seg[2];	/* next segment in victim section */
> +
>  	/* for skip statistic */
>  	unsigned int atomic_files;              /* # of opened atomic file */
>  	unsigned long long skipped_atomic_files[2];	/* FG_GC and BG_GC */
> @@ -2480,7 +2482,7 @@ static inline void *f2fs_kmem_cache_alloc(struct kmem_cache *cachep,
>  
>  static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
>  {
> -	if (sbi->gc_mode == GC_URGENT)
> +	if (sbi->gc_mode == GC_URGENT_HIGH)
>  		return true;
>  
>  	if (get_pages(sbi, F2FS_RD_DATA) || get_pages(sbi, F2FS_RD_NODE) ||
> @@ -2498,6 +2500,10 @@ static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
>  			atomic_read(&SM_I(sbi)->fcc_info->queued_flush))
>  		return false;
>  
> +	if (sbi->gc_mode == GC_URGENT_LOW &&
> +			(type == DISCARD_TIME || type == GC_TIME))
> +		return true;
> +
>  	return f2fs_time_over(sbi, type);
>  }
>  
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 6eec3b2d606d..3b718da69910 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -82,7 +82,7 @@ static int gc_thread_func(void *data)
>  		 * invalidated soon after by user update or deletion.
>  		 * So, I'd like to wait some time to collect dirty segments.
>  		 */
> -		if (sbi->gc_mode == GC_URGENT) {
> +		if (sbi->gc_mode == GC_URGENT_HIGH) {
>  			wait_ms = gc_th->urgent_sleep_time;
>  			down_write(&sbi->gc_lock);
>  			goto do_gc;
> @@ -176,7 +176,7 @@ static int select_gc_type(struct f2fs_sb_info *sbi, int gc_type)
>  		gc_mode = GC_CB;
>  		break;
>  	case GC_IDLE_GREEDY:
> -	case GC_URGENT:
> +	case GC_URGENT_HIGH:
>  		gc_mode = GC_GREEDY;
>  		break;
>  	}
> @@ -211,7 +211,7 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
>  	 * foreground GC and urgent GC cases.
>  	 */
>  	if (gc_type != FG_GC &&
> -			(sbi->gc_mode != GC_URGENT) &&
> +			(sbi->gc_mode != GC_URGENT_HIGH) &&
>  			p->max_search > sbi->max_victim_search)
>  		p->max_search = sbi->max_victim_search;
>  
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index b45e473508a9..5924b3965ae4 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -174,7 +174,7 @@ bool f2fs_need_SSR(struct f2fs_sb_info *sbi)
>  
>  	if (f2fs_lfs_mode(sbi))
>  		return false;
> -	if (sbi->gc_mode == GC_URGENT)
> +	if (sbi->gc_mode == GC_URGENT_HIGH)
>  		return true;
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
>  		return true;
> @@ -1759,7 +1759,7 @@ static int issue_discard_thread(void *data)
>  			continue;
>  		}
>  
> -		if (sbi->gc_mode == GC_URGENT)
> +		if (sbi->gc_mode == GC_URGENT_HIGH)
>  			__init_discard_policy(sbi, &dpolicy, DPOLICY_FORCE, 1);
>  
>  		sb_start_intwrite(sbi->sb);
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index e877c59b9fdb..ab40e1f89f23 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -350,14 +350,16 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>  		return -EINVAL;
>  
>  	if (!strcmp(a->attr.name, "gc_urgent")) {
> -		if (t >= 1) {
> -			sbi->gc_mode = GC_URGENT;
> +		if (t == 1) {
> +			sbi->gc_mode = GC_URGENT_HIGH;
>  			if (sbi->gc_thread) {
>  				sbi->gc_thread->gc_wake = 1;
>  				wake_up_interruptible_all(
>  					&sbi->gc_thread->gc_wait_queue_head);
>  				wake_up_discard_thread(sbi, true);
>  			}
> +		} else if (t == 2) {
> +			sbi->gc_mode = GC_URGENT_LOW;
>  		} else {
>  			sbi->gc_mode = GC_NORMAL;

As functionality description in sysfs doc, shouldn't it be:

if (t == 0) {
	sbi->gc_mode = GC_NORMAL;
} else if (t == 1) {
	sbi->gc_mode = GC_URGENT_HIGH;
	...
} else if (t == 2) {
	sbi->gc_mode = GC_URGENT_LOW;
} else {
	return -EINVAL;
}
return count;

>  		}
> 
