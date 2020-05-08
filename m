Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FE5C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982FD20870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgEHGuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:50:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33446 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbgEHGuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:50:21 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D6EC0D4A70CC61C5C7D9;
        Fri,  8 May 2020 14:50:15 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 8 May 2020
 14:50:11 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove race condition in releasing
 cblocks
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20200508042506.143395-1-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4dfb73d9-03a0-bb2f-a112-1dd42db4d7bb@huawei.com>
Date:   Fri, 8 May 2020 14:50:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200508042506.143395-1-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/8 12:25, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Now, if writing pages and releasing compress blocks occur
> simultaneously, and releasing cblocks is executed more than one time
> to a file, then total block count of filesystem and block count of the
> file could be incorrect and damaged.
> 
> We have to execute releasing compress blocks only one time for a file
> without being interfered by writepages path.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/file.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 4aab4b42d8ba..a92bc51b9b28 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3488,6 +3488,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
>  	pgoff_t page_idx = 0, last_idx;
>  	unsigned int released_blocks = 0;
>  	int ret;
> +	int writecount;
>  
>  	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
>  		return -EOPNOTSUPP;

Before inode_lock(), there is one case we may jump to out label, in
this case, we may unlock inode incorrectly.

	if (!F2FS_I(inode)->i_compr_blocks)
		goto out;

> -
> -	inode_unlock(inode);
>  out:
> +	inode_unlock(inode);
> +
>  	mnt_drop_write_file(filp);

Thanks,
