Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC11C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F36520781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587647636;
	bh=sCzr7jegZyFDnovWPo6SGkC+fWK3YOKcrQa3UVaVFq0=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:List-ID:From;
	b=AwTN2/wK5yL5B6RKJciOxbkgyhC8U7iKFPhDIOGGmlNaIuS8qBnSSeLNBTtQ+CmSq
	 YfVTQTIrzYxqncinhwi6GJr0I5d3/W1Kzb+opTbvs0Z0ggRoIu7AfreDdeOUUU+YQk
	 c/rri4AZO82Q3t2am1kedeOmVd0bhmyTfJ9RXwnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgDWNNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:13:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgDWNNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:13:55 -0400
Received: from [192.168.0.107] (unknown [58.213.200.224])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2ECA2076C;
        Thu, 23 Apr 2020 13:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587647634;
        bh=sCzr7jegZyFDnovWPo6SGkC+fWK3YOKcrQa3UVaVFq0=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=I3MyzsA/KeqgxHnqdOnj/WknM268wrDEcFc0gvdmJ4TpI1p9bFmeY8k8ze8uDR322
         Ne+9PICAq5KVQH46faqKUWzN7nNvblevNA6P+GBx38tiUQXTLHjnZ9A9d65hqw0cTR
         BrKfDDmmejLFS3rsfGNmbs9SKy5bMIOHbqNIvobQ=
Subject: Re: [f2fs-dev] [PATCH] f2fs: Avoid double lock for cp_rwsem
To:     Sayali Lokhande <sayalil@codeaurora.org>, jaegeuk@kernel.org,
        yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
References: <1587636832-17939-1-git-send-email-sayalil@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org
From:   Chao Yu <chao@kernel.org>
Message-ID: <4b1a9995-5c4c-c547-e42a-bc6047dfb7f6@kernel.org>
Date:   Thu, 23 Apr 2020 21:13:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1587636832-17939-1-git-send-email-sayalil@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sayali,

On 2020-4-23 18:13, Sayali Lokhande wrote:
> Call stack :
> f2fs_write_checkpoint()
> -> block_operations(sbi)
>     f2fs_lock_all(sbi);
>      down_write(&sbi->cp_rwsem); => write lock held
> <>

It looks the full race condition should be?

						Thread B
						- open()
						 - igrab()
						- write() write inline data
						- unlink()
> -> f2fs_sync_node_pages()
>     if (is_inline_node(page))
>      flush_inline_data()

	ilookup()

> 	page = f2fs_pagecache_get_page()
>          if (!page)
>            goto iput_out;
> 	iput_out:
						- close()
						 - iput()
> 	 iput(inode);
>           -> f2fs_evict_inode()
> 	      f2fs_truncate_blocks()
> 	       f2fs_lock_op()
> 	        down_read(&sbi->cp_rwsem); => read lock fail
>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> ---
>  fs/f2fs/checkpoint.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 5ba649e..5c504cf 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1219,21 +1219,19 @@ static int block_operations(struct f2fs_sb_info *sbi)
>  		goto retry_flush_quotas;
>  	}
>
> -retry_flush_nodes:
>  	down_write(&sbi->node_write);
>
>  	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
>  		up_write(&sbi->node_write);

Call up_write(&sbi->node_change) here could wake up threads earlier who hang on
this lock, how do you think?

Thanks,

> +		f2fs_unlock_all(sbi);
>  		atomic_inc(&sbi->wb_sync_req[NODE]);
>  		err = f2fs_sync_node_pages(sbi, &wbc, false, FS_CP_NODE_IO);
>  		atomic_dec(&sbi->wb_sync_req[NODE]);
> -		if (err) {
> -			up_write(&sbi->node_change);
> -			f2fs_unlock_all(sbi);
> +		up_write(&sbi->node_change);
> +		if (err)
>  			goto out;
> -		}
>  		cond_resched();
> -		goto retry_flush_nodes;
> +		goto retry_flush_quotas;
>  	}
>
>  	/*
>
