Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD79AC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 19:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800CF20777
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 19:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584731513;
	bh=WHYaY5JGW4wMqTdBEG+VlqBPEPHmHlXETR+cfjM253g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cmCnNbERHiV7V1aFR9Z4JOBYDZYZ+0u7PbrYo7hr3RTo9U1HnBDo3VyQcmaV058SR
	 i4oG2DJwA61FtZTbrYoehvqukPoHNy0m3DPtr/E7V8auCGhMGumqaJ7Q2cahO9+jlJ
	 eWvRJZeahO4jmNQkCky4dejTdGlVkyoRU9akYtZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgCTTLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 15:11:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgCTTLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 15:11:52 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F43B20767;
        Fri, 20 Mar 2020 19:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584731511;
        bh=WHYaY5JGW4wMqTdBEG+VlqBPEPHmHlXETR+cfjM253g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FhaxDy9UC5o6f2YNJzvSSFRn0Ei8VAm6JOOdrhtb8Z0lbMUGXquZQwKz2pk7GOIq3
         6C+Mts/Mhp1wKCnEyWDz7k4Hv1CsqJE++OZo2HGkIPoyBAfMHv9LydSAu7T49LeP+5
         zss4fx8ZDNio623uelHkIPNIpOrsDqf0F5tOMAhE=
Date:   Fri, 20 Mar 2020 12:11:49 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/4] f2fs: fix NULL pointer dereference in
 f2fs_verity_work()
Message-ID: <20200320191149.GL851@sol.localdomain>
References: <20200319115800.108926-1-yuchao0@huawei.com>
 <20200319115800.108926-3-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319115800.108926-3-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 07:57:59PM +0800, Chao Yu wrote:
> If both compression and fsverity feature is on, generic/572 will
> report below NULL pointer dereference bug.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000018
>  RIP: 0010:f2fs_verity_work+0x60/0x90 [f2fs]
>  #PF: supervisor read access in kernel mode
>  Workqueue: fsverity_read_queue f2fs_verity_work [f2fs]
>  RIP: 0010:f2fs_verity_work+0x60/0x90 [f2fs]
>  Call Trace:
>   process_one_work+0x16c/0x3f0
>   worker_thread+0x4c/0x440
>   ? rescuer_thread+0x350/0x350
>   kthread+0xf8/0x130
>   ? kthread_unpark+0x70/0x70
>   ret_from_fork+0x35/0x40
> 
> There are two issue in f2fs_verity_work():
> - it needs to traverse and verify all pages in bio.
> - if pages in bio belong to non-compressed cluster, accessing
> decompress IO context stored in page private will cause NULL
> pointer dereference.
> 
> Fix them.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/data.c | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 5c5db09324b7..66e49fc1056e 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -187,12 +187,37 @@ static void f2fs_verify_pages(struct page **rpages, unsigned int cluster_size)
>  
>  static void f2fs_verify_bio(struct bio *bio)
>  {
> -	struct page *page = bio_first_page_all(bio);
> -	struct decompress_io_ctx *dic =
> -			(struct decompress_io_ctx *)page_private(page);
> +	struct bio_vec *bv;
> +	struct bvec_iter_all iter_all;
> +	struct decompress_io_ctx *dic, *pdic = NULL;
> +
> +	bio_for_each_segment_all(bv, bio, iter_all) {
> +		struct page *page = bv->bv_page;
> +
> +		dic = (struct decompress_io_ctx *)page_private(page);
> +
> +		if (dic) {
> +			if (dic != pdic) {
> +				f2fs_verify_pages(dic->rpages,
> +							dic->cluster_size);
> +				f2fs_free_dic(dic);
> +				pdic = dic;
> +			}
> +			continue;
> +		}
> +		pdic = dic;
>  
> -	f2fs_verify_pages(dic->rpages, dic->cluster_size);
> -	f2fs_free_dic(dic);
> +		if (bio->bi_status || PageError(page)) {
> +			ClearPageUptodate(page);
> +			ClearPageError(page);
> +		} else {
> +			if (fsverity_verify_page(page))
> +				SetPageUptodate(page);
> +			else
> +				SetPageError(page);
> +		}
> +		unlock_page(page);
> +	}

I'm a bit confused why you added SetPageError() before unlocking the page.
The other error paths actually clear the Error flag, not set it.  I thought
there's a reason for that?

- Eric
