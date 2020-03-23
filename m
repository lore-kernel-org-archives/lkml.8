Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C8EC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FE720722
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="TeUavIPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgCWRRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:17:48 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42368 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbgCWRRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 13:17:47 -0400
Received: by mail-qt1-f193.google.com with SMTP id t9so8396630qto.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 10:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5UPSbpkPmie9GnveloVGF9xAODR3WB+FmPL6STYIGmc=;
        b=TeUavIPYFPLLqG/YaNLT3tjSeohe+zeYsi+/hQqhjeL3hrswyeziREW5u6eRWYe4Ni
         kJASgeDjr2RVDtA9njTLtIeOWrdov4NpKmJmkWL7HBL2Ra0gqpGNrXV3KUj73gFgzCd9
         /OIxrBwjc0Blky9EdkhAKHS8kvVkpJSpFdZayB18qCSAzPCjhAn7VGgsTbtTUdR/rTjE
         /CqgIMZhscCPLFSLFr10JPMzAFzgpFiHg4gB7VJaOI82SxNYm/8EjtfpkGyT0W5CPxIH
         4Ud0euudcDhHcIFCE//XhdDxajDBWjq84tN/HZBhultz48iEt79YEdP4Trpjbt2izzPi
         UHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5UPSbpkPmie9GnveloVGF9xAODR3WB+FmPL6STYIGmc=;
        b=VEiWDvCunUlVL0scdtWrxi6qYpyfsba3z4qUZ3h0JyoZouPC9MIbCz5autVCgmbOES
         cnMe7fetw6NzwRKCK4gALNtCiiMydt1ZFK3VKzIex36fxqkDIZOuIGMIZytvQi9J8QuU
         GD4BnwnE3UGqEOpPInJxSDmHLuXZi4eHPfh1RoYVvFlDy9zguPBu/AzwjqFQX6DP1byY
         C+kqqDTaOmVk98iYHuaergixC9TQawR1GlcH4OJCXFoqMTMn2yDtlb9iqzzXljVBiNX6
         Knq/RUdc06xMm4A+Fw7rS8xhAVf52kq0nxpi/i4/Mwbu91wuoP+8+ejA5nYPe2MQw6qb
         iNQA==
X-Gm-Message-State: ANhLgQ0wCTjW6CO83OezatmtxtzGOeBM8C0ckEOxt17wygsDruObKe/G
        LndGdDxCdUPWrt/dFJQkIYMblg==
X-Google-Smtp-Source: ADFU+vsAk4UOKfLs+QsERk4rLmrDQwGvdl/zE/znH/FEK9q9YQ2sMzaUTlOvlm0ybx5t1hU5lZWeFQ==
X-Received: by 2002:ac8:4e24:: with SMTP id d4mr22504101qtw.307.1584983866330;
        Mon, 23 Mar 2020 10:17:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a9a9])
        by smtp.gmail.com with ESMTPSA id v126sm11586447qkb.107.2020.03.23.10.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 10:17:45 -0700 (PDT)
Date:   Mon, 23 Mar 2020 13:17:44 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v4 6/8] mm/swap: implement workingset detection for
 anonymous LRU
Message-ID: <20200323171744.GD204561@cmpxchg.org>
References: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584942732-2184-7-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584942732-2184-7-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 02:52:10PM +0900, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> This patch implements workingset detection for anonymous LRU.
> All the infrastructure is implemented by the previous patches so this patch
> just activates the workingset detection by installing/retrieving
> the shadow entry.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  include/linux/swap.h |  6 ++++++
>  mm/memory.c          |  7 ++++++-
>  mm/swap_state.c      | 20 ++++++++++++++++++--
>  mm/vmscan.c          |  7 +++++--
>  4 files changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 273de48..fb4772e 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -408,6 +408,7 @@ extern struct address_space *swapper_spaces[];
>  extern unsigned long total_swapcache_pages(void);
>  extern void show_swap_cache_info(void);
>  extern int add_to_swap(struct page *page);
> +extern void *get_shadow_from_swap_cache(swp_entry_t entry);
>  extern int add_to_swap_cache(struct page *page, swp_entry_t entry,
>  			gfp_t gfp, void **shadowp);
>  extern int __add_to_swap_cache(struct page *page, swp_entry_t entry);
> @@ -566,6 +567,11 @@ static inline int add_to_swap(struct page *page)
>  	return 0;
>  }
>  
> +static inline void *get_shadow_from_swap_cache(swp_entry_t entry)
> +{
> +	return NULL;
> +}
> +
>  static inline int add_to_swap_cache(struct page *page, swp_entry_t entry,
>  					gfp_t gfp_mask, void **shadowp)
>  {
> diff --git a/mm/memory.c b/mm/memory.c
> index 5f7813a..91a2097 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2925,10 +2925,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  			page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma,
>  							vmf->address);
>  			if (page) {
> +				void *shadow;
> +
>  				__SetPageLocked(page);
>  				__SetPageSwapBacked(page);
>  				set_page_private(page, entry.val);
> -				lru_cache_add_anon(page);
> +				shadow = get_shadow_from_swap_cache(entry);
> +				if (shadow)
> +					workingset_refault(page, shadow);

Hm, this is calling workingset_refault() on a page that isn't charged
to a cgroup yet. That means the refault stats and inactive age counter
will be bumped incorrectly in the root cgroup instead of the real one.

> +				lru_cache_add(page);
>  				swap_readpage(page, true);
>  			}
>  		} else {

You need to look up and remember the shadow entry at the top and call
workingset_refault() after mem_cgroup_commit_charge() has run.

It'd be nice if we could do the shadow lookup for everybody in
lookup_swap_cache(), but that's subject to race conditions if multiple
faults on the same swap page happen in multiple vmas concurrently. The
swapcache bypass scenario is only safe because it checks that there is
a single pte under the mmap sem to prevent forking. So it looks like
you have to bubble up the shadow entry through swapin_readahead().
