Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE6BC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3EA20637
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgCKIk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:40:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:51106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgCKIk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:40:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 61764B090;
        Wed, 11 Mar 2020 08:40:55 +0000 (UTC)
Subject: Re: [PATCH] mm,cma: remove pfn_range_valid_contig
To:     Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Anshuman Khandual <anshuman.khandual@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Qian Cai <cai@lca.pw>, Roman Gushchin <guro@fb.com>
References: <20200306170647.455a2db3@imladris.surriel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <0f8bf6ad-ab1b-dc1d-259f-bc6deb447ce8@suse.cz>
Date:   Wed, 11 Mar 2020 09:40:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306170647.455a2db3@imladris.surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/20 11:06 PM, Rik van Riel wrote:
> The function pfn_range_valid_contig checks whether all memory in the
> target area is free. This causes unnecessary CMA failures, since
> alloc_contig_range will migrate movable memory out of a target range,
> and has its own sanity check early on in has_unmovable_pages, which
> is called from start_isolate_page_range & set_migrate_type_isolate.
> 
> Relying on that has_unmovable_pages call simplifies the CMA code and
> results in an increased success rate of CMA allocations.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>

Yeah, the page_count and PageHuge checks are harmful. Not sure about
PageReserved. And is anything later in the alloc_contig_range() making sure that
we are always in the same zone?

> ---
>  mm/page_alloc.c | 47 +++--------------------------------------------
>  1 file changed, 3 insertions(+), 44 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0fb3c1719625..75e84907d8c6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8539,32 +8539,6 @@ static int __alloc_contig_pages(unsigned long start_pfn,
>  				  gfp_mask);
>  }
>  
> -static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
> -				   unsigned long nr_pages)
> -{
> -	unsigned long i, end_pfn = start_pfn + nr_pages;
> -	struct page *page;
> -
> -	for (i = start_pfn; i < end_pfn; i++) {
> -		page = pfn_to_online_page(i);
> -		if (!page)
> -			return false;
> -
> -		if (page_zone(page) != z)
> -			return false;
> -
> -		if (PageReserved(page))
> -			return false;
> -
> -		if (page_count(page) > 0)
> -			return false;
> -
> -		if (PageHuge(page))
> -			return false;
> -	}
> -	return true;
> -}
> -
>  static bool zone_spans_last_pfn(const struct zone *zone,
>  				unsigned long start_pfn, unsigned long nr_pages)
>  {
> @@ -8605,28 +8579,13 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
>  	zonelist = node_zonelist(nid, gfp_mask);
>  	for_each_zone_zonelist_nodemask(zone, z, zonelist,
>  					gfp_zone(gfp_mask), nodemask) {
> -		spin_lock_irqsave(&zone->lock, flags);
> -
>  		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
>  		while (zone_spans_last_pfn(zone, pfn, nr_pages)) {
> -			if (pfn_range_valid_contig(zone, pfn, nr_pages)) {
> -				/*
> -				 * We release the zone lock here because
> -				 * alloc_contig_range() will also lock the zone
> -				 * at some point. If there's an allocation
> -				 * spinning on this lock, it may win the race
> -				 * and cause alloc_contig_range() to fail...
> -				 */
> -				spin_unlock_irqrestore(&zone->lock, flags);
> -				ret = __alloc_contig_pages(pfn, nr_pages,
> -							gfp_mask);
> -				if (!ret)
> -					return pfn_to_page(pfn);
> -				spin_lock_irqsave(&zone->lock, flags);
> -			}
> +			ret = __alloc_contig_pages(pfn, nr_pages, gfp_mask);
> +			if (!ret)
> +				return pfn_to_page(pfn);
>  			pfn += nr_pages;
>  		}
> -		spin_unlock_irqrestore(&zone->lock, flags);
>  	}
>  	return NULL;
>  }
> 

