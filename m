Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9800C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD0B5206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgHSMsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:48:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:56638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgHSMss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:48:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4116AF92;
        Wed, 19 Aug 2020 12:49:12 +0000 (UTC)
Date:   Wed, 19 Aug 2020 14:48:40 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1 05/11] mm/page_alloc: simplify
 __offline_isolated_pages()
Message-ID: <20200819124840.GI5422@dhcp22.suse.cz>
References: <20200819101157.12723-1-david@redhat.com>
 <20200819101157.12723-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819101157.12723-6-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-08-20 12:11:51, David Hildenbrand wrote:
> offline_pages() is the only user.  __offline_isolated_pages() never gets
> called with ranges that contain memory holes and we no longer care about
> the return value. Drop the return value handling and all pfn_valid()
> checks.
> 
> Update the documentation.
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
>  include/linux/memory_hotplug.h |  4 ++--
>  mm/page_alloc.c                | 27 ++++-----------------------
>  2 files changed, 6 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 375515803cd83..0b461691d1a49 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -103,8 +103,8 @@ extern int online_pages(unsigned long pfn, unsigned long nr_pages,
>  			int online_type, int nid);
>  extern struct zone *test_pages_in_a_zone(unsigned long start_pfn,
>  					 unsigned long end_pfn);
> -extern unsigned long __offline_isolated_pages(unsigned long start_pfn,
> -						unsigned long end_pfn);
> +extern void __offline_isolated_pages(unsigned long start_pfn,
> +				     unsigned long end_pfn);
>  
>  typedef void (*online_page_callback_t)(struct page *page, unsigned int order);
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cf0b25161feae..03f585f95dc60 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8692,35 +8692,21 @@ void zone_pcp_reset(struct zone *zone)
>  
>  #ifdef CONFIG_MEMORY_HOTREMOVE
>  /*
> - * All pages in the range must be in a single zone and isolated
> - * before calling this.
> + * All pages in the range must be in a single zone, must not contain holes,
> + * must span full sections, and must be isolated before calling this function.
>   */
> -unsigned long
> -__offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
> +void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
>  {
> +	unsigned long pfn = start_pfn;
>  	struct page *page;
>  	struct zone *zone;
>  	unsigned int order;
> -	unsigned long pfn;
>  	unsigned long flags;
> -	unsigned long offlined_pages = 0;
> -
> -	/* find the first valid pfn */
> -	for (pfn = start_pfn; pfn < end_pfn; pfn++)
> -		if (pfn_valid(pfn))
> -			break;
> -	if (pfn == end_pfn)
> -		return offlined_pages;
>  
>  	offline_mem_sections(pfn, end_pfn);
>  	zone = page_zone(pfn_to_page(pfn));
>  	spin_lock_irqsave(&zone->lock, flags);
> -	pfn = start_pfn;
>  	while (pfn < end_pfn) {
> -		if (!pfn_valid(pfn)) {
> -			pfn++;
> -			continue;
> -		}
>  		page = pfn_to_page(pfn);
>  		/*
>  		 * The HWPoisoned page may be not in buddy system, and
> @@ -8728,7 +8714,6 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
>  		 */
>  		if (unlikely(!PageBuddy(page) && PageHWPoison(page))) {
>  			pfn++;
> -			offlined_pages++;
>  			continue;
>  		}
>  		/*
> @@ -8739,20 +8724,16 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
>  			BUG_ON(page_count(page));
>  			BUG_ON(PageBuddy(page));
>  			pfn++;
> -			offlined_pages++;
>  			continue;
>  		}
>  
>  		BUG_ON(page_count(page));
>  		BUG_ON(!PageBuddy(page));
>  		order = page_order(page);
> -		offlined_pages += 1 << order;
>  		del_page_from_free_list(page, zone, order);
>  		pfn += (1 << order);
>  	}
>  	spin_unlock_irqrestore(&zone->lock, flags);
> -
> -	return offlined_pages;
>  }
>  #endif
>  
> -- 
> 2.26.2
> 

-- 
Michal Hocko
SUSE Labs
