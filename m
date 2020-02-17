Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804F6C3B1BF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 01:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB1320718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 01:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgBQBnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 20:43:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10623 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbgBQBnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 20:43:16 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E7242A1C8C2048FB5443;
        Mon, 17 Feb 2020 09:43:14 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 17 Feb
 2020 09:43:10 +0800
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: add migration count iff migration
 happens
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200214185855.217360-1-jaegeuk@kernel.org>
 <20200214185855.217360-2-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8b66e722-202b-b3b8-1543-e74379319a7f@huawei.com>
Date:   Mon, 17 Feb 2020 09:43:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200214185855.217360-2-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BTW

f2fs: add migration count iff migration happens

typo: iff

On 2020/2/15 2:58, Jaegeuk Kim wrote:
> If first segment is empty and migration_granularity is 1, we can't move this
> at all.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/gc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 65c0687ee2bb..bbf4db3f6bb4 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1233,12 +1233,12 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>  							segno, gc_type);
>  
>  		stat_inc_seg_count(sbi, type, gc_type);
> +		migrated++;
>  
>  freed:
>  		if (gc_type == FG_GC &&
>  				get_valid_blocks(sbi, segno, false) == 0)
>  			seg_freed++;
> -		migrated++;
>  
>  		if (__is_large_section(sbi) && segno + 1 < end_segno)
>  			sbi->next_victim_seg[gc_type] = segno + 1;
> 
