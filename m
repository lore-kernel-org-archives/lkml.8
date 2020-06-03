Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664EFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3988920674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgFCG6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 02:58:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5846 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725275AbgFCG6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 02:58:54 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2F0F931527F4F3D44C1C;
        Wed,  3 Jun 2020 14:58:53 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 3 Jun 2020
 14:58:47 +0800
Subject: Re: [PATCH] f2fs: protect new segment allocation in expand_inode_data
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20200601030347.112984-1-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <daed6176-fb7d-bd4d-9662-735cc3cda2e0@huawei.com>
Date:   Wed, 3 Jun 2020 14:58:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200601030347.112984-1-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/1 11:03, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Found a new segemnt allocation without f2fs_lock_op() in
> expand_inode_data(). So, when we do fallocate() for a pinned file
> and trigger checkpoint very frequently and simultaneously. F2FS gets
> stuck in the below code of do_checkpoint() forever.
> 
>   f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
>   /* Wait for all dirty meta pages to be submitted for IO */
>                                                 <= if fallocate() here,
>   f2fs_wait_on_all_pages(sbi, F2FS_DIRTY_META); <= it'll wait forever.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

Daeho,

I guess Jaegeuk could add the tag when merging this patch, we don't have
to resend the patch if there is no updates on code and message.

Thanks,

> ---
>  fs/f2fs/file.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index f7de2a1da528..14ace885baa9 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1660,7 +1660,11 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
>  
>  		down_write(&sbi->pin_sem);
>  		map.m_seg_type = CURSEG_COLD_DATA_PINNED;
> +
> +		f2fs_lock_op(sbi);
>  		f2fs_allocate_new_segments(sbi, CURSEG_COLD_DATA);
> +		f2fs_unlock_op(sbi);
> +
>  		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_DIO);
>  		up_write(&sbi->pin_sem);
>  
> 
