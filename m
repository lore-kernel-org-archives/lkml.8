Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E229BC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C01EB20781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgDWJry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 05:47:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46748 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbgDWJry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 05:47:54 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F194E7FF708048E37DEF;
        Thu, 23 Apr 2020 17:47:52 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 23 Apr
 2020 17:47:47 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix quota_sync failure due to
 f2fs_lock_op
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200409173056.229855-1-jaegeuk@kernel.org>
 <77e9f2e6-f3f3-8ca9-e6b5-3d57c4d2acc5@huawei.com>
 <20200416213946.GA196168@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <fd8b116a-7830-809c-70a4-a3a12da1eb14@huawei.com>
Date:   Thu, 23 Apr 2020 17:47:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200416213946.GA196168@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/17 5:39, Jaegeuk Kim wrote:
> f2fs_quota_sync() uses f2fs_lock_op() before flushing dirty pages, but
> f2fs_write_data_page() returns EAGAIN.
> Likewise dentry blocks, we can just bypass getting the lock, since quota
> blocks are also maintained by checkpoint.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> v2:
>  - fix multipage write case
> 
>  fs/f2fs/compress.c | 2 +-
>  fs/f2fs/data.c     | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index df7b2d15eacde..faaa358289010 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -985,7 +985,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  	loff_t psize;
>  	int i, err;
>  
> -	if (!f2fs_trylock_op(sbi))
> +	if (!IS_NOQUOTA(inode) && !f2fs_trylock_op(sbi))
>  		return -EAGAIN;

I encounter deadlock..

Should call f2fs_unlock_op() for non-quota compressed inode later.

Thanks,

>  
>  	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index accd28728642a..5c8d3823d7593 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2656,8 +2656,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
>  			f2fs_available_free_memory(sbi, BASE_CHECK))))
>  		goto redirty_out;
>  
> -	/* Dentry blocks are controlled by checkpoint */
> -	if (S_ISDIR(inode->i_mode)) {
> +	/* Dentry/quota blocks are controlled by checkpoint */
> +	if (S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) {
>  		fio.need_lock = LOCK_DONE;
>  		err = f2fs_do_write_data_page(&fio);
>  		goto done;
> 
