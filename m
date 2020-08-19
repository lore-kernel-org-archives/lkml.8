Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA114C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A3F206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgHSMlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:41:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:49970 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgHSMk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:40:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 16CEBAF92;
        Wed, 19 Aug 2020 12:41:24 +0000 (UTC)
Date:   Wed, 19 Aug 2020 14:40:57 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1 04/11] mm/memory_hotplug: simplify offlining of pages
 in offline_pages()
Message-ID: <20200819124057.GH5422@dhcp22.suse.cz>
References: <20200819101157.12723-1-david@redhat.com>
 <20200819101157.12723-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819101157.12723-5-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-08-20 12:11:50, David Hildenbrand wrote:
> We make sure that we cannot have any memory holes right at the beginning
> of offline_pages(). We no longer need walk_system_ram_range() and can
> call __offline_isolated_pages() directly.
> 
> offlined_pages always corresponds to nr_pages, so we can simplify that.

I would probably fold this into the previous patch as they are dealing
with the same thing.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c | 28 ++++++++--------------------
>  1 file changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index f64478349148d..50aa5df696e9d 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1373,17 +1373,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  	return ret;
>  }
>  
> -/* Mark all sections offline and remove all free pages from the buddy. */
> -static int
> -offline_isolated_pages_cb(unsigned long start, unsigned long nr_pages,
> -			void *data)
> -{
> -	unsigned long *offlined_pages = (unsigned long *)data;
> -
> -	*offlined_pages += __offline_isolated_pages(start, start + nr_pages);
> -	return 0;
> -}
> -
>  static int __init cmdline_parse_movable_node(char *p)
>  {
>  	movable_node_enabled = true;
> @@ -1470,7 +1459,7 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
>  int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  {
>  	const unsigned long end_pfn = start_pfn + nr_pages;
> -	unsigned long pfn, system_ram_pages = 0, offlined_pages = 0;
> +	unsigned long pfn, system_ram_pages = 0;
>  	int ret, node, nr_isolate_pageblock;
>  	unsigned long flags;
>  	struct zone *zone;
> @@ -1570,11 +1559,10 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  		}
>  	} while (test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE));
>  
> -	/* Ok, all of our target is isolated.
> -	   We cannot do rollback at this point. */
> -	walk_system_ram_range(start_pfn, end_pfn - start_pfn,
> -			      &offlined_pages, offline_isolated_pages_cb);
> -	pr_info("Offlined Pages %ld\n", offlined_pages);
> +	/* Mark all sections offline and remove free pages from the buddy. */
> +	__offline_isolated_pages(start_pfn, end_pfn);
> +	pr_info("Offlined Pages %ld\n", nr_pages);
> +
>  	/*
>  	 * Onlining will reset pagetype flags and makes migrate type
>  	 * MOVABLE, so just need to decrease the number of isolated
> @@ -1585,11 +1573,11 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  	spin_unlock_irqrestore(&zone->lock, flags);
>  
>  	/* removal success */
> -	adjust_managed_page_count(pfn_to_page(start_pfn), -offlined_pages);
> -	zone->present_pages -= offlined_pages;
> +	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
> +	zone->present_pages -= nr_pages;
>  
>  	pgdat_resize_lock(zone->zone_pgdat, &flags);
> -	zone->zone_pgdat->node_present_pages -= offlined_pages;
> +	zone->zone_pgdat->node_present_pages -= nr_pages;
>  	pgdat_resize_unlock(zone->zone_pgdat, &flags);
>  
>  	init_per_zone_wmark_min();
> -- 
> 2.26.2
> 

-- 
Michal Hocko
SUSE Labs
