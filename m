Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351FCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 06:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C95520760
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 06:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgEOG3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 02:29:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:32978 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726205AbgEOG3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 02:29:39 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C6E49201A20949FFD2BB;
        Fri, 15 May 2020 14:29:37 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 15 May
 2020 14:29:34 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: flush dirty meta pages when flushing
 them
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200515021554.226835-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <9ba6e5ef-068d-a925-1eb9-107b0523666c@huawei.com>
Date:   Fri, 15 May 2020 14:29:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200515021554.226835-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/15 10:15, Jaegeuk Kim wrote:
> Let's guarantee flusing dirty meta pages to avoid infinite loop.

What's the root cause? Race case or meta page flush failure?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 620a386d82c1a..9a7f695d5adb3 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1266,6 +1266,9 @@ void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
>  		if (unlikely(f2fs_cp_error(sbi)))
>  			break;
>  
> +		if (type == F2FS_DIRTY_META)
> +			f2fs_sync_meta_pages(sbi, META, LONG_MAX,
> +							FS_CP_META_IO);
>  		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
>  	}
>  	finish_wait(&sbi->cp_wait, &wait);
> @@ -1493,8 +1496,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	sbi->last_valid_block_count = sbi->total_valid_block_count;
>  	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
>  
> -	/* Here, we have one bio having CP pack except cp pack 2 page */
> -	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
>  	/* Wait for all dirty meta pages to be submitted for IO */
>  	f2fs_wait_on_all_pages(sbi, F2FS_DIRTY_META);
>  
> 
