Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A59C38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 03:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE54021655
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 03:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgEIDCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 23:02:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60608 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728353AbgEIDCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 23:02:34 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5A6CC335C76B1BBD74F7;
        Sat,  9 May 2020 11:02:32 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.487.0; Sat, 9 May 2020
 11:02:26 +0800
Subject: Re: [PATCH V4] f2fs: Avoid double lock for cp_rwsem during checkpoint
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Sayali Lokhande <sayalil@codeaurora.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <stummala@codeaurora.org>, <linux-kernel@vger.kernel.org>
References: <1588244309-1468-1-git-send-email-sayalil@codeaurora.org>
 <20200508161052.GA49579@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0902037e-998d-812e-53e7-90ea7b9957eb@huawei.com>
Date:   Sat, 9 May 2020 11:02:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200508161052.GA49579@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/9 0:10, Jaegeuk Kim wrote:
> Hi Sayali,
> 
> In order to address the perf regression, how about this?
> 
>>From 48418af635884803ffb35972df7958a2e6649322 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Fri, 8 May 2020 09:08:37 -0700
> Subject: [PATCH] f2fs: avoid double lock for cp_rwsem during checkpoint
> 
> There could be a scenario where f2fs_sync_node_pages gets
> called during checkpoint, which in turn tries to flush
> inline data and calls iput(). This results in deadlock as
> iput() tries to hold cp_rwsem, which is already held at the
> beginning by checkpoint->block_operations().
> 
> Call stack :
> 
> Thread A		Thread B
> f2fs_write_checkpoint()
> - block_operations(sbi)
>  - f2fs_lock_all(sbi);
>   - down_write(&sbi->cp_rwsem);
> 
>                         - open()
>                          - igrab()
>                         - write() write inline data
>                         - unlink()
> - f2fs_sync_node_pages()
>  - if (is_inline_node(page))
>   - flush_inline_data()
>    - ilookup()
>      page = f2fs_pagecache_get_page()
>      if (!page)
>       goto iput_out;
>      iput_out:
> 			-close()
> 			-iput()
>        iput(inode);
>        - f2fs_evict_inode()
>         - f2fs_truncate_blocks()
>          - f2fs_lock_op()
>            - down_read(&sbi->cp_rwsem);
> 
> Fixes: 2049d4fcb057 ("f2fs: avoid multiple node page writes due to inline_data")
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/node.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 1db8cabf727ef..626d7daca09de 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1870,8 +1870,8 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
>  				goto continue_unlock;
>  			}
>  
> -			/* flush inline_data */
> -			if (is_inline_node(page)) {
> +			/* flush inline_data, if it's not sync path. */
> +			if (do_balance && is_inline_node(page)) {

IIRC, this flow was designed to avoid running out of free space issue
during checkpoint:

2049d4fcb057 ("f2fs: avoid multiple node page writes due to inline_data")

The sceanrio is:
1. create fully node blocks
2. flush node blocks
3. write inline_data for all the node blocks again
4. flush node blocks redundantly

I guess this may cause failing one case of fstest.


Since block_operations->f2fs_sync_inode_meta has synced inode cache to
inode page, so in block_operations->f2fs_sync_node_pages, could we
check nlink before flush_inline_data():

if (is_inline_node(page)) {
	if (IS_INODE(page) && raw_inode_page->i_links) {
		flush_inline_data()
	}
}


>  				clear_inline_node(page);
>  				unlock_page(page);
>  				flush_inline_data(sbi, ino_of_node(page));
> 
