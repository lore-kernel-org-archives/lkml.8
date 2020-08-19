Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E80C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55CD1206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgHSNEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:04:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:37320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728471AbgHSNCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:02:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 89FA0B023;
        Wed, 19 Aug 2020 13:02:57 +0000 (UTC)
Date:   Wed, 19 Aug 2020 15:02:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1 08/11] mm/memory_hotplug: simplify page onlining
Message-ID: <20200819130230.GM5422@dhcp22.suse.cz>
References: <20200819101157.12723-1-david@redhat.com>
 <20200819101157.12723-9-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819101157.12723-9-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-08-20 12:11:54, David Hildenbrand wrote:
> We don't allow to offline memory with holes, all boot memory is online,
> and all hotplugged memory cannot have holes.
> 
> We can now simplify onlining of pages. As we only allow to online/offline
> full sections and sections always span full MAX_ORDER_NR_PAGES, we can just
> process MAX_ORDER - 1 pages without further special handling.
> 
> The number of onlined pages simply corresponds to the number of pages we
> were requested to online.
> 
> While at it, refine the comment regarding the callback not exposing all
> pages to the buddy.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c | 38 ++++++++++----------------------------
>  1 file changed, 10 insertions(+), 28 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 0011a1115381c..3aba0d956f9b1 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -617,31 +617,22 @@ void generic_online_page(struct page *page, unsigned int order)
>  }
>  EXPORT_SYMBOL_GPL(generic_online_page);
>  
> -static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
> -			void *arg)
> +static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
>  {
>  	const unsigned long end_pfn = start_pfn + nr_pages;
>  	unsigned long pfn;
> -	int order;
>  
>  	/*
> -	 * Online the pages. The callback might decide to keep some pages
> -	 * PG_reserved (to add them to the buddy later), but we still account
> -	 * them as being online/belonging to this zone ("present").
> +	 * Online the pages in MAX_ORDER - 1 aligned chunks. The callback might
> +	 * decide to not expose all pages to the buddy (e.g., expose them
> +	 * later). We account all pages as being online and belonging to this
> +	 * zone ("present").
>  	 */
> -	for (pfn = start_pfn; pfn < end_pfn; pfn += 1ul << order) {
> -		order = min(MAX_ORDER - 1, get_order(PFN_PHYS(end_pfn - pfn)));
> -		/* __free_pages_core() wants pfns to be aligned to the order */
> -		if (WARN_ON_ONCE(!IS_ALIGNED(pfn, 1ul << order)))
> -			order = 0;
> -		(*online_page_callback)(pfn_to_page(pfn), order);
> -	}
> +	for (pfn = start_pfn; pfn < end_pfn; pfn += MAX_ORDER_NR_PAGES)
> +		(*online_page_callback)(pfn_to_page(pfn), MAX_ORDER - 1);
>  
>  	/* mark all involved sections as online */
>  	online_mem_sections(start_pfn, end_pfn);
> -
> -	*(unsigned long *)arg += nr_pages;
> -	return 0;
>  }
>  
>  /* check which state of node_states will be changed when online memory */
> @@ -795,7 +786,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  		       int online_type, int nid)
>  {
>  	unsigned long flags;
> -	unsigned long onlined_pages = 0;
>  	struct zone *zone;
>  	int need_zonelists_rebuild = 0;
>  	int ret;
> @@ -831,19 +821,11 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  		setup_zone_pageset(zone);
>  	}
>  
> -	ret = walk_system_ram_range(pfn, nr_pages, &onlined_pages,
> -		online_pages_range);
> -	if (ret) {
> -		/* not a single memory resource was applicable */
> -		if (need_zonelists_rebuild)
> -			zone_pcp_reset(zone);
> -		goto failed_addition;
> -	}
> -
> -	zone->present_pages += onlined_pages;
> +	online_pages_range(pfn, nr_pages);
> +	zone->present_pages += nr_pages;
>  
>  	pgdat_resize_lock(zone->zone_pgdat, &flags);
> -	zone->zone_pgdat->node_present_pages += onlined_pages;
> +	zone->zone_pgdat->node_present_pages += nr_pages;
>  	pgdat_resize_unlock(zone->zone_pgdat, &flags);
>  
>  	/*
> -- 
> 2.26.2
> 

-- 
Michal Hocko
SUSE Labs
