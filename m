Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FDDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 03:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9AF206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 03:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgGIDFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 23:05:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34002 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726107AbgGIDFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 23:05:21 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B75356259D08A9F78B28;
        Thu,  9 Jul 2020 11:05:18 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 9 Jul 2020
 11:05:16 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: ignore when len of range in
 f2fs_sec_trim_file is zero
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20200709015739.1653668-1-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <619af72b-2f8a-4a84-f73e-ac49989ba79f@huawei.com>
Date:   Thu, 9 Jul 2020 11:05:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200709015739.1653668-1-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/9 9:57, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When end_addr comes to zero, it'll trigger different behaviour.
> To prevent this, we need to ignore the case of that range.len is
> zero in the function.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/file.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 368c80f8e2a1..98b0a8dbf669 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3813,15 +3813,14 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
>  	file_start_write(filp);
>  	inode_lock(inode);
>  
> -	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
> +	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode) ||
> +			range.start >= inode->i_size) {
>  		ret = -EINVAL;
>  		goto err;
>  	}
>  
> -	if (range.start >= inode->i_size) {
> -		ret = -EINVAL;
> +	if (range.len == 0)
>  		goto err;
> -	}
>  
>  	if (inode->i_size - range.start < range.len) {
>  		ret = -E2BIG;

How about the case trimming last partial written block?

i_size = 8000
range.start = 4096
range.len = 4096

Do we need to roundup(isize, PAGE_SIZE) before comparison?

Thanks,

> 
