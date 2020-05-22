Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1670BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6B0A206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAHAX5QH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbgEVRI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 13:08:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56267 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730306AbgEVRI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590167336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9IMji12+IVauPt4RMXAfaK78dNWxsLHFul+7f9Log58=;
        b=VAHAX5QHb5DUvrobxJMidVwm6EHbpmhE5L8MW1b5tPWhjqQ3Qy0MWymMNV2tr2Llv63t6m
        YOakpoy9dPGkNUDi9v+0X0VODRHzTKgsciiOGnV2plY8N68sv/Q2v2UdO1oUautcGjnb6l
        YYc/lQQ0ICLQjKIH+5pvIlf6zwEGZYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-IMwk-zguPHmznR0wWDoqnA-1; Fri, 22 May 2020 13:08:52 -0400
X-MC-Unique: IMwk-zguPHmznR0wWDoqnA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 534631005510;
        Fri, 22 May 2020 17:08:51 +0000 (UTC)
Received: from optiplex-fbsd (unknown [10.3.128.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 888121059138;
        Fri, 22 May 2020 17:08:47 +0000 (UTC)
Date:   Fri, 22 May 2020 13:08:44 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mmotm] mm/swap: fix livelock in __read_swap_cache_async()
Message-ID: <20200522170844.GA85134@optiplex-fbsd>
References: <alpine.LSU.2.11.2005212246080.8458@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2005212246080.8458@eggly.anvils>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 10:56:20PM -0700, Hugh Dickins wrote:
> I've only seen this livelock on one machine (repeatably, but not to
> order), and not fully analyzed it - two processes seen looping around
> getting -EEXIST from swapcache_prepare(), I guess a third (at lower
> priority? but wanting the same cpu as one of the loopers? preemption
> or cond_resched() not enough to let it back in?) set SWAP_HAS_CACHE,
> then went off into direct reclaim, scheduled away, and somehow could
> not get back to add the page to swap cache and let them all complete.
> 
> Restore the page allocation in __read_swap_cache_async() to before
> the swapcache_prepare() call: "mm: memcontrol: charge swapin pages
> on instantiation" moved it outside the loop, which indeed looks much
> nicer, but exposed this weakness.  We used to allocate new_page once
> and then keep it across all iterations of the loop: but I think that
> just optimizes for a rare case, and complicates the flow, so go with
> the new simpler structure, with allocate+free each time around (which
> is more considerate use of the memory too).
> 
> Fix the comment on the looping case, which has long been inaccurate:
> it's not a racing get_swap_page() that's the problem here.
> 
> Fix the add_to_swap_cache() and mem_cgroup_charge() error recovery:
> not swap_free(), but put_swap_page() to undo SWAP_HAS_CACHE, as was
> done before; but delete_from_swap_cache() already includes it.
> 
> And one more nit: I don't think it makes any difference in practice,
> but remove the "& GFP_KERNEL" mask from the mem_cgroup_charge() call:
> add_to_swap_cache() needs that, to convert gfp_mask from user and page
> cache allocation (e.g. highmem) to radix node allocation (lowmem), but
> we don't need or usually apply that mask when charging mem_cgroup.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> Mostly fixing mm-memcontrol-charge-swapin-pages-on-instantiation.patch
> but now I see that mm-memcontrol-delete-unused-lrucare-handling.patch
> made a further change here (took an arg off the mem_cgroup_charge call):
> as is, this patch is diffed to go on top of both of them, and better
> that I get it out now for Johannes look at; but could be rediffed for
> folding into blah-instantiation.patch later.
> 
> Earlier in the day I promised two patches to __read_swap_cache_async(),
> but find now that I cannot quite justify the second patch: it makes a
> slight adjustment in swapcache_prepare(), then removes the redundant
> __swp_swapcount() && swap_slot_cache_enabled business from blah_async().
> 
> I'd still like to do that, but this patch here brings back the
> alloc_page_vma() in between them, and I don't have any evidence to
> reassure us that I'm not then pessimizing a readahead case by doing
> unnecessary allocation and free. Leave it for some other time perhaps.
> 
>  mm/swap_state.c |   52 +++++++++++++++++++++++++---------------------
>  1 file changed, 29 insertions(+), 23 deletions(-)
> 
> --- 5.7-rc6-mm1/mm/swap_state.c	2020-05-20 12:21:56.149694170 -0700
> +++ linux/mm/swap_state.c	2020-05-21 20:17:50.188773901 -0700
> @@ -392,56 +392,62 @@ struct page *__read_swap_cache_async(swp
>  			return NULL;
>  
>  		/*
> +		 * Get a new page to read into from swap.  Allocate it now,
> +		 * before marking swap_map SWAP_HAS_CACHE, when -EEXIST will
> +		 * cause any racers to loop around until we add it to cache.
> +		 */
> +		page = alloc_page_vma(gfp_mask, vma, addr);
> +		if (!page)
> +			return NULL;
> +
> +		/*
>  		 * Swap entry may have been freed since our caller observed it.
>  		 */
>  		err = swapcache_prepare(entry);
>  		if (!err)
>  			break;
>  
> -		if (err == -EEXIST) {
> -			/*
> -			 * We might race against get_swap_page() and stumble
> -			 * across a SWAP_HAS_CACHE swap_map entry whose page
> -			 * has not been brought into the swapcache yet.
> -			 */
> -			cond_resched();
> -			continue;
> -		}
> +		put_page(page);
> +		if (err != -EEXIST)
> +			return NULL;
>  
> -		return NULL;
> +		/*
> +		 * We might race against __delete_from_swap_cache(), and
> +		 * stumble across a swap_map entry whose SWAP_HAS_CACHE
> +		 * has not yet been cleared.  Or race against another
> +		 * __read_swap_cache_async(), which has set SWAP_HAS_CACHE
> +		 * in swap_map, but not yet added its page to swap cache.
> +		 */
> +		cond_resched();
>  	}
>  
>  	/*
> -	 * The swap entry is ours to swap in. Prepare a new page.
> +	 * The swap entry is ours to swap in. Prepare the new page.
>  	 */
>  
> -	page = alloc_page_vma(gfp_mask, vma, addr);
> -	if (!page)
> -		goto fail_free;
> -
>  	__SetPageLocked(page);
>  	__SetPageSwapBacked(page);
>  
>  	/* May fail (-ENOMEM) if XArray node allocation failed. */
> -	if (add_to_swap_cache(page, entry, gfp_mask & GFP_KERNEL))
> +	if (add_to_swap_cache(page, entry, gfp_mask & GFP_KERNEL)) {
> +		put_swap_page(page, entry);
>  		goto fail_unlock;
> +	}
>  
> -	if (mem_cgroup_charge(page, NULL, gfp_mask & GFP_KERNEL))
> -		goto fail_delete;
> +	if (mem_cgroup_charge(page, NULL, gfp_mask)) {
> +		delete_from_swap_cache(page);
> +		goto fail_unlock;
> +	}
>  
> -	/* Initiate read into locked page */
> +	/* Caller will initiate read into locked page */
>  	SetPageWorkingset(page);
>  	lru_cache_add_anon(page);
>  	*new_page_allocated = true;
>  	return page;
>  
> -fail_delete:
> -	delete_from_swap_cache(page);
>  fail_unlock:
>  	unlock_page(page);
>  	put_page(page);
> -fail_free:
> -	swap_free(entry);
>  	return NULL;
>  }
>  
> 
Acked-by: Rafael Aquini <aquini@redhat.com>

