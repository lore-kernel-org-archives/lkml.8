Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F8CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3DA20715
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bs17dOkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgHMLTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgHMLTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:19:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C5AC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 04:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tZ4dSaPwhhsxFzT6mKk9i9S+yw6lUP7cNS/nYMzBjsg=; b=Bs17dOkNYuKL6MX/i8oURZEgqN
        6ihWx3b+0VUUs44qNZ0kjNXOps7S7KIzwoA3WAsMfjZ9UwP4lzGFBEeb/OLPANETS79IBRtwJpudC
        Ae1I6Y4I72qcf7PeI5SLXhUir3AFe23SJMxdhgEFw6TImX2pwrpsE6vsfycUZPg9h+28Xnpr1HI7k
        gGPRUjYHA9gt/SaTBHnC11KrFr1sq3nthFK6d64AypGWNmdtZuhoJ64VKn8355lhZPh7fkrYkD1DI
        g0AN6HFJvJgDe93wrMhrQ5aZdsdlm3SjORHQpeeh0qYiwedKasd/UwoYmYqMoCpz2ouVqeOEeDg0P
        F/jhuwrw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6BGW-0001EG-IK; Thu, 13 Aug 2020 11:19:24 +0000
Date:   Thu, 13 Aug 2020 12:19:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Roman Gushchin <klamm@yandex-team.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm : using bdi->ra_pages instead of ra->ra_pages
 within readahead
Message-ID: <20200813111924.GE17456@casper.infradead.org>
References: <1597306282-29927-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597306282-29927-1-git-send-email-zhaoyang.huang@unisoc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 04:11:22PM +0800, Zhaoyang Huang wrote:
> file->f_ra->ra_pages will remain the initialized value since it opend, which may
> be NOT equal to bdi->ra_pages as the latter one is updated somehow(etc,
> echo xxx > /sys/block/dm/queue/read_ahead_kb).So having readahead use
> bdi->ra_pages.

But now it ignores the work done by shrink_readahead_size_eio()
and fadvise(POSIX_FADV_SEQUENTIAL).  And you missed the use of ra_size
on the previous line, miscalculating ra->start.

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/filemap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d78f577..259dcfd 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2499,8 +2499,8 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	 */
>  	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>  	ra->start = max_t(long, 0, offset - ra->ra_pages / 2);
> -	ra->size = ra->ra_pages;
> -	ra->async_size = ra->ra_pages / 4;
> +	ra->size = inode_to_bdi(mapping->host)->ra_pages;
> +	ra->async_size = ra->size / 4;
>  	ra_submit(ra, mapping, file);
>  	return fpin;
>  }
> -- 
> 1.9.1
> 
> 
