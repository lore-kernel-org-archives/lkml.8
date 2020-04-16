Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567C9C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 323D0206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439011AbgDPHQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:16:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2380 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438717AbgDPHQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:16:00 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9916B9C4B29A166B4B0F;
        Thu, 16 Apr 2020 15:15:57 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 16 Apr
 2020 15:15:52 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix quota_sync failure due to
 f2fs_lock_op
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200409173056.229855-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <77e9f2e6-f3f3-8ca9-e6b5-3d57c4d2acc5@huawei.com>
Date:   Thu, 16 Apr 2020 15:15:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200409173056.229855-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/10 1:30, Jaegeuk Kim wrote:
> f2fs_quota_sync() uses f2fs_lock_op() before flushing dirty pages, but
> f2fs_write_data_page() returns EAGAIN.
> Likewise dentry blocks, we can just bypass getting the lock, since quota
> blocks are also maintained by checkpoint.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 358c5f0bd6346..1139d8cf4b8d1 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2707,8 +2707,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
>  			f2fs_available_free_memory(sbi, BASE_CHECK))))
>  		goto redirty_out;
>  
> -	/* Dentry blocks are controlled by checkpoint */
> -	if (S_ISDIR(inode->i_mode)) {
> +	/* Dentry/quota blocks are controlled by checkpoint */
> +	if (S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) {

Should cover multipage write path, in the case of normal quota file
(such as /quota.user or /quota.group) is set as compressed.

Thanks,

>  		fio.need_lock = LOCK_DONE;
>  		err = f2fs_do_write_data_page(&fio);
>  		goto done;
> 
