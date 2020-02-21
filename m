Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43314C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11748206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582307431;
	bh=rz7YgSt+Rjoriz1tFNPaoOYCJcXR8Ft7UFBVsjnoP0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X8QP3lQiEhY+xxKX+xhjSE/sy7CMuEIMasK4toJxUea/2nd5a3YH1ltrI7cILi0BG
	 4QUAYZvIqSxEl06yU3uy1bjk2wLNPoirOnh0utfwsxIupBecDUkZMFawvgEkYza1nk
	 s7GUsDCuFveqQ9OSvxK/lfXr0DvGfDCSfesKWeYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgBURu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:50:29 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41865 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgBURu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:50:29 -0500
Received: by mail-pl1-f195.google.com with SMTP id t14so1153979plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 09:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BTYBxRjxL6j9jRa5am8wcAfH9hghQz4giKAxNHy2xK4=;
        b=FzTSLxgkZT4cxDaHBStgUqU87ldVzo/bNsdhWZMxTdso97FTZfmxRDZzASr4GMAC5U
         10aX+WUWPsbGFzeWKUukY2TcbDA+wPz8O0wuCuZrO1yBwIyh50cOW1NIMhtyJHJihGZj
         TQdELxqazapE2l4nLK4UcgPEs4v86pzAUojGf5KPPZd15eMs9WGRXo6gV3htuLvA++yR
         R5k+oU7oZmryU7dDL1blPrfAQpj/cGy5ozvZq87NOXC6LRYv/4aI6bT+hjNtPXybnVgt
         xuA3Hl7h+/kr2VPQ2OXdBB4pcrrft++V0M0dvnsVo5J5SEA7Fu/ZraWTUPcN+BzwtUSu
         GPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BTYBxRjxL6j9jRa5am8wcAfH9hghQz4giKAxNHy2xK4=;
        b=L/3Kv4dCZRuH+IMJeSYlvEaD7FJ4NDWbRfpgTowDTOVDGMHBxzulZRZVkfHtKdkfaF
         XpKGWsITYHrKPD8daDjo2FitPfkB949Bszw/7+qIaV0xcgOHCsYbjElu+9RPN9LHg6yi
         2DD4IGHlbtYg65vVk+djfXUBhPWORA7O4YUxX+Rk8UmaDb72sQ4mWLGYbvjF6efeiezf
         faDxdYV+3MJF2JM1PTx1eTF3H5Eje1PIpw2VIP5XUAzBrz1GbcgJYeL8mtbdjC13As5N
         IMXul57pqcjrFKp786oStEI16BCvmFtl+TcNeziIPJvzHaUVtn7SeA0ZtF0JKsbczEwp
         LGOw==
X-Gm-Message-State: APjAAAVc5j50QyOzzLzZSTmsxdma1hDAGLRhOApIK35iqxKSHwIExvnI
        KA9eQa/4fFKOYaBEPheEOb0=
X-Google-Smtp-Source: APXvYqxFGA8qOE0zV8w0G6DGlTadJbX7gGbhCdt+y+ZbsNrPZ8eNdi/7bpZfOZvHh0hccPyg8He0cg==
X-Received: by 2002:a17:90a:e509:: with SMTP id t9mr4217996pjy.110.1582307427862;
        Fri, 21 Feb 2020 09:50:27 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id c26sm3591866pfj.8.2020.02.21.09.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 09:50:26 -0800 (PST)
Date:   Fri, 21 Feb 2020 09:50:24 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 2/2] mm: fix long time stall from mm_populate
Message-ID: <20200221175024.GC226145@google.com>
References: <20200214192951.29430-1-minchan@kernel.org>
 <20200214192951.29430-2-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214192951.29430-2-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bumping up.

On Fri, Feb 14, 2020 at 11:29:51AM -0800, Minchan Kim wrote:
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
> It could be repeated forever so it's livelock. without involving reclaim,
> it could happens if ra_pages become zero by fadvise/other threads who
> have same fd one doing randome while the other one is sequential
> because page_cache_async_readahead has following condition check like
> PageWriteback and ra_pages are never synchrnized with fadvise and
> shrink_readahead_size_eio from other threads.
> 
> void page_cache_async_readahead(struct address_space *mapping,
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
