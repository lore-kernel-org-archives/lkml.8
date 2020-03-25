Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69F2C54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A962D20740
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585151416;
	bh=Qc+lueq98MrFHqfASz6/dsAD2vvazTjCL6wnKN7LNls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JUYYfbmoc9vfw9TZ94ZhN/EMI1qmdCU027i/r9rkNpUdY0qo3hms/GZIPw0/Q5iUZ
	 NrrzRkymDVSd9TX+YoAfpug8RCdvrUqixvGiJxR3SxINuGMdvxmt6OM9rP6452vkpW
	 uGWktImGsrvZW8fkIeEjY7zIoj26JjBbHB4oxZvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgCYPuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbgCYPuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:50:15 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE17620719;
        Wed, 25 Mar 2020 15:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585151414;
        bh=Qc+lueq98MrFHqfASz6/dsAD2vvazTjCL6wnKN7LNls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LD8m9jlhLcMakKgtin97JBf2XNfXsnSTrsqZMF/LAlhDAdpi/ITpe5K8r242NJPgV
         QT0g5P1o+BQe8/+MzOI7ev3bv9TitGtvSFmdQYLobauqmReoNQ9w7hiuSmTsI9yEeA
         gwEiTsVRCygqBzOgDXJNx2r+hnbyY57pVW+tdEF0=
Date:   Wed, 25 Mar 2020 08:50:14 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH v2 3/5] f2fs: fix to avoid NULL pointer dereference
Message-ID: <20200325155014.GB65658@google.com>
References: <20200325091811.60725-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325091811.60725-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

I don't want to rebase old commit at this moment, so applied on top of the tree.

Thanks,

On 03/25, Chao Yu wrote:
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> PC is at f2fs_free_dic+0x60/0x2c8
> LR is at f2fs_decompress_pages+0x3c4/0x3e8
> f2fs_free_dic+0x60/0x2c8
> f2fs_decompress_pages+0x3c4/0x3e8
> __read_end_io+0x78/0x19c
> f2fs_post_read_work+0x6c/0x94
> process_one_work+0x210/0x48c
> worker_thread+0x2e8/0x44c
> kthread+0x110/0x120
> ret_from_fork+0x10/0x18
> 
> In f2fs_free_dic(), we can not use f2fs_put_page(,1) to release dic->tpages[i],
> as the page's mapping is NULL.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2:
> - fix to skip release tpages[i] if it is NULL in error path.
>  fs/f2fs/compress.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index ef7dd04312fe..6e10800729b6 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1137,7 +1137,10 @@ void f2fs_free_dic(struct decompress_io_ctx *dic)
>  		for (i = 0; i < dic->cluster_size; i++) {
>  			if (dic->rpages[i])
>  				continue;
> -			f2fs_put_page(dic->tpages[i], 1);
> +			if (!dic->tpages[i])
> +				continue;
> +			unlock_page(dic->tpages[i]);
> +			put_page(dic->tpages[i]);
>  		}
>  		kfree(dic->tpages);
>  	}
> -- 
> 2.18.0.rc1
