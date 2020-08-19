Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B177C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 126792065F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgHSNGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:06:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:41006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbgHSNFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:05:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 09CA8AEE8;
        Wed, 19 Aug 2020 13:06:14 +0000 (UTC)
Date:   Wed, 19 Aug 2020 15:05:46 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v1 09/11] mm/page_alloc: drop stale pageblock comment in
 memmap_init_zone*()
Message-ID: <20200819130546.GN5422@dhcp22.suse.cz>
References: <20200819101157.12723-1-david@redhat.com>
 <20200819101157.12723-10-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819101157.12723-10-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-08-20 12:11:55, David Hildenbrand wrote:
> Commit ac5d2539b238 ("mm: meminit: reduce number of times pageblocks are
> set during struct page init") moved the actual zone range check, leaving
> only the alignment check for pageblocks.
> 
> Let's drop the stale comment and make the pageblock check easier to read.

I do agree athat IS_ALIGNED is easier to read in this case.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Mel Gorman <mgorman@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 848664352dfe2..5db0b35f95e20 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6022,13 +6022,8 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>  		 * to reserve their blocks rather than leaking throughout
>  		 * the address space during boot when many long-lived
>  		 * kernel allocations are made.
> -		 *
> -		 * bitmap is created for zone's valid pfn range. but memmap
> -		 * can be created for invalid pages (for alignment)
> -		 * check here not to call set_pageblock_migratetype() against
> -		 * pfn out of zone.
>  		 */
> -		if (!(pfn & (pageblock_nr_pages - 1))) {
> +		if (IS_ALIGNED(pfn, pageblock_nr_pages)) {
>  			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
>  			cond_resched();
>  		}
> @@ -6091,15 +6086,10 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  		 * the address space during boot when many long-lived
>  		 * kernel allocations are made.
>  		 *
> -		 * bitmap is created for zone's valid pfn range. but memmap
> -		 * can be created for invalid pages (for alignment)
> -		 * check here not to call set_pageblock_migratetype() against
> -		 * pfn out of zone.
> -		 *
>  		 * Please note that MEMMAP_HOTPLUG path doesn't clear memmap
>  		 * because this is done early in section_activate()
>  		 */
> -		if (!(pfn & (pageblock_nr_pages - 1))) {
> +		if (IS_ALIGNED(pfn, pageblock_nr_pages)) {
>  			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
>  			cond_resched();
>  		}
> -- 
> 2.26.2
> 

-- 
Michal Hocko
SUSE Labs
