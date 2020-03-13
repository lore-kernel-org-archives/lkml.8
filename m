Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4E2C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70ED2074F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584134061;
	bh=nmUuYmdYJ4Hoeu1l4UB0tLV2posRqhONVqIEzqvY/K0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hj8tEYz8au5AITaeTxF04+B8UR9U64RuzByfsoACal1oqUUz1DFZBgYxCdgmH+hO6
	 GFHVjaP2e/tK1bTCg1v8iZh5vquwbtck8/RQEIWGlggWe11k1ArfljZE2/DNofQd1e
	 nX9Oc/L4W+1Y+oaQ0u+PhNk2GU4MWyEGTFwJY7ss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgCMVOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 17:14:20 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55815 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgCMVOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 17:14:20 -0400
Received: by mail-pj1-f65.google.com with SMTP id mj6so4634193pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 14:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X1ClGnk418zQDtsXXpsu8O+PIFo4dMXlEJShNPrv2dI=;
        b=U4VhhA+QZbu3+NQokqoZa8RGZflC2HmLxqgDxwCNJBDLEDSRqRRiy17yDKdQLJSaN5
         1GssZLOUMFsc0RlkKotjhppc2uQk7Z+1JXEKyjANSm09CN8kgVbn1G5i/pXnuwm1E2ua
         PpGVT6SQAbt91eDF6odjm3QmDDRKPlb1haKiD40FWAFILs52QXWAcda+am63Fh7kN6Zh
         SwiRVetpHMha6/pTnDf6IsYz8Zg9aD6TY2h3dcuX7rhr0IO9WvilxNiCiP/WyHMNNop3
         pxmM+/3IYtB2+fkjmUR2VsJH+RfaP1FU1NzKLFDDnYM832FTo7+MCwmFeODe3+5p++um
         QbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=X1ClGnk418zQDtsXXpsu8O+PIFo4dMXlEJShNPrv2dI=;
        b=rzgFwLrCStx3f+pWLVfYp9MBOopz87cAqCn++LeK9qBhFta06XprDe04xPfO3sRsns
         FWjEOHAj+vUvcLg7AUsPjLQz+3HIJnecg/KPFJgu7YyiTXZXps5Nyi2P3eVQ0m2Gguwo
         2ZaTbxucT4jJPHdLmu+/HcHeH5KcxmRXH87mMTHXvda9kGWl/Y0E/Ie2OvQLNfoBKKEi
         nTI3PSm2xXO959vGz+wY4d3O0+HExZYKBMWTXG+EugdfPvxLIwbA8J8pvwyEP/jtvjWN
         DtHWwPYBLgkisVl75M2NuVE4JAU1T+vFM3W0fZNSSBzH8AUcby6APOj2Tx1Vfljl/A2g
         xOiw==
X-Gm-Message-State: ANhLgQ3aAjRrmzoTnF629N/hG3OkxZriRdrD8Lcs3hSCDl/ZXaZqEalS
        dCVbc/7vceYwowFvQF2KmGdrVo6l
X-Google-Smtp-Source: ADFU+vv0zyG8qwV8ObaD8BMIvVmgai2eQt7w1MjxMU0z2/bjrkuDVp5qQlPybLAB/JXiIml8i8/wqw==
X-Received: by 2002:a17:902:562:: with SMTP id 89mr715680plf.249.1584134058966;
        Fri, 13 Mar 2020 14:14:18 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id 5sm15300556pfw.98.2020.03.13.14.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:14:17 -0700 (PDT)
Date:   Fri, 13 Mar 2020 14:14:16 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2] mm: fix long time stall from mm_populate
Message-ID: <20200313211416.GC78185@google.com>
References: <20200303002638.206421-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303002638.206421-1-minchan@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Any chance to take a look?

On Mon, Mar 02, 2020 at 04:26:38PM -0800, Minchan Kim wrote:
> Basically, fault handler releases mmap_sem before requesting readahead
> and then it is supposed to retry lookup the page from page cache with
> FAULT_FLAG_TRIED so that it avoids the live lock of infinite retry.
> 
> However, what happens if the fault handler find a page from page
> cache and the page has readahead marker but are waiting under
> writeback? Plus one more condition, it happens under mm_populate
> which repeats faulting unless it encounters error. So let's assemble
> conditions below.
> 
>        CPU 1                                                        CPU 2
> 
> - first loop
>     mm_populate
>      for ()
>        ..
>        ret = populate_vma_page_range
>          __get_user_pages
>            faultin_page
>              handle_mm_fault
>                filemap_fault
>                  do_async_mmap_readahead
>                    if (PageReadahead(pageA))
>                      maybe_unlock_mmap_for_io
>                        up_read(mmap_sem)
> 					                    shrink_page_list
>                                                               pageout
>                                                                 SetPageReclaim(=SetPageReadahead)(pageA)
>                                                                 writepage
>                                                                   SetPageWriteback(pageA)
> 
>                      page_cache_async_readahead()
> 		       ClearPageReadahead(pageA)
>                  do_async_mmap_readahead
> 		 lock_page_maybe_drop_mmap
> 		   goto out_retry
> 
> 					                    the pageA is reclaimed
> 							    and new pageB is populated to the file offset
> 							    and finally has become PG_readahead
> 
> - second loop
> 
> 	  __get_user_pages
>            faultin_page
>              handle_mm_fault
>                filemap_fault
>                  do_async_mmap_readahead
>                    if (PageReadahead(pageB))
>                      maybe_unlock_mmap_for_io
>                        up_read(mmap_sem)
> 					                    shrink_page_list
>                                                               pageout
>                                                                 SetPageReclaim(=SetPageReadahead)(pageB)
>                                                                 writepage
>                                                                   SetPageWriteback(pageB)
> 
>                      page_cache_async_readahead()
> 		       ClearPageReadahead(pageB)
>                  do_async_mmap_readahead
> 		 lock_page_maybe_drop_mmap
> 		   goto out_retry
> 
> It could be repeated forever so it's livelock. Without involving reclaim,
> it could happens if ra_pages become zero by fadvise/other threads who
> have same fd one doing randome while the other one is sequential
> because page_cache_async_readahead has following condition check like
> PageWriteback and ra_pages are never synchrnized with fadvise and
> shrink_readahead_size_eio from other threads.
> 
> page_cache_async_readahead(struct address_space *mapping,
>                            unsigned long req_size)
> {
>         /* no read-ahead */
>         if (!ra->ra_pages)
>                 return;
> 
> Thus, we need to limit fault retry from mm_populate like page
> fault handler.
> 
> Fixes: 6b4c9f446981 ("filemap: drop the mmap_sem for all blocking operations")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  mm/gup.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 1b521e0ac1de..6f6548c63ad5 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1133,7 +1133,7 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
>   *
>   * This takes care of mlocking the pages too if VM_LOCKED is set.
>   *
> - * return 0 on success, negative error code on error.
> + * return number of pages pinned on success, negative error code on error.
>   *
>   * vma->vm_mm->mmap_sem must be held.
>   *
> @@ -1196,6 +1196,7 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
>  	struct vm_area_struct *vma = NULL;
>  	int locked = 0;
>  	long ret = 0;
> +	bool tried = false;
>  
>  	end = start + len;
>  
> @@ -1226,14 +1227,18 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
>  		 * double checks the vma flags, so that it won't mlock pages
>  		 * if the vma was already munlocked.
>  		 */
> -		ret = populate_vma_page_range(vma, nstart, nend, &locked);
> +		ret = populate_vma_page_range(vma, nstart, nend,
> +						tried ? NULL : &locked);
>  		if (ret < 0) {
>  			if (ignore_errors) {
>  				ret = 0;
>  				continue;	/* continue at next VMA */
>  			}
>  			break;
> -		}
> +		} else if (ret == 0)
> +			tried = true;
> +		else
> +			tried = false;
>  		nend = nstart + ret * PAGE_SIZE;
>  		ret = 0;
>  	}
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 
