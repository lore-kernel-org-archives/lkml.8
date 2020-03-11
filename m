Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB2EC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7866E20637
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgCKIvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:51:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:57294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKIvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:51:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DABCEAF2F;
        Wed, 11 Mar 2020 08:51:08 +0000 (UTC)
Subject: Re: [PATCH] mm,page_alloc,cma: conditionally prefer cma pageblocks
 for movable allocations
To:     Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>,
        Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20200306150102.3e77354b@imladris.surriel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8e67d88f-3ec8-4795-35dc-47e3735e530e@suse.cz>
Date:   Wed, 11 Mar 2020 09:51:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306150102.3e77354b@imladris.surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/20 9:01 PM, Rik van Riel wrote:
> Posting this one for Roman so I can deal with any upstream feedback and
> create a v2 if needed, while scratching my head over the next piece of
> this puzzle :)
> 
> ---8<---
> 
> From: Roman Gushchin <guro@fb.com>
> 
> Currently a cma area is barely used by the page allocator because
> it's used only as a fallback from movable, however kswapd tries
> hard to make sure that the fallback path isn't used.

Few years ago Joonsoo wanted to fix these kinds of weird MIGRATE_CMA corner
cases by using ZONE_MOVABLE instead [1]. Unfortunately it was reverted due to
unresolved bugs. Perhaps the idea could be resurrected now?

[1]
https://lore.kernel.org/linux-mm/1512114786-5085-1-git-send-email-iamjoonsoo.kim@lge.com/

> This results in a system evicting memory and pushing data into swap,
> while lots of CMA memory is still available. This happens despite the
> fact that alloc_contig_range is perfectly capable of moving any movable
> allocations out of the way of an allocation.
> 
> To effectively use the cma area let's alter the rules: if the zone
> has more free cma pages than the half of total free pages in the zone,
> use cma pageblocks first and fallback to movable blocks in the case of
> failure.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Co-developed-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/page_alloc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3c4eb750a199..0fb3c1719625 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2711,6 +2711,18 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
>  {
>  	struct page *page;
>  
> +	/*
> +	 * Balance movable allocations between regular and CMA areas by
> +	 * allocating from CMA when over half of the zone's free memory
> +	 * is in the CMA area.
> +	 */
> +	if (migratetype == MIGRATE_MOVABLE &&
> +	    zone_page_state(zone, NR_FREE_CMA_PAGES) >
> +	    zone_page_state(zone, NR_FREE_PAGES) / 2) {
> +		page = __rmqueue_cma_fallback(zone, order);
> +		if (page)
> +			return page;
> +	}
>  retry:
>  	page = __rmqueue_smallest(zone, order, migratetype);
>  	if (unlikely(!page)) {
> 

