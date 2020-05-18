Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5375C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41E1207BB
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgERCV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 22:21:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42412 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbgERCV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 22:21:26 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7B2F8A7CA5DC1B82FDC8;
        Mon, 18 May 2020 10:21:24 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 18 May
 2020 10:21:21 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: flush dirty meta pages when flushing
 them
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200515021554.226835-1-jaegeuk@kernel.org>
 <9ba6e5ef-068d-a925-1eb9-107b0523666c@huawei.com>
 <20200515144509.GA46028@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <cd964a56-b2a7-48de-97a6-5d89d9a590a3@huawei.com>
Date:   Mon, 18 May 2020 10:21:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200515144509.GA46028@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/15 22:45, Jaegeuk Kim wrote:
> On 05/15, Chao Yu wrote:
>> On 2020/5/15 10:15, Jaegeuk Kim wrote:
>>> Let's guarantee flusing dirty meta pages to avoid infinite loop.
>>
>> What's the root cause? Race case or meta page flush failure?
> 
> Investigating, but at least, this can avoid the inifinite loop there.

Hmm... this fix may cover the root cause..

Thanks,

> 
> V2:
> 
>>From c60ce8e7178004fd6cba96e592247e43b5fd98d8 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Wed, 13 May 2020 21:12:53 -0700
> Subject: [PATCH] f2fs: flush dirty meta pages when flushing them
> 
> Let's guarantee flusing dirty meta pages to avoid infinite loop.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 620a386d82c1a..3dc3ac6fe1432 100644
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
> 
