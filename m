Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04BBC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9378E21741
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgCDOrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:47:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:58874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgCDOrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:47:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BB493B01F;
        Wed,  4 Mar 2020 14:47:44 +0000 (UTC)
Subject: Re: [RFC PATCH] mm: Micro-optimisation: Save two branches on hot -
 page allocation path
To:     mateusznosek0@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, Mel Gorman <mgorman@suse.de>
References: <20200304142230.8753-1-mateusznosek0@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d582336f-6beb-df5e-ddda-b090ea21707b@suse.cz>
Date:   Wed, 4 Mar 2020 15:47:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304142230.8753-1-mateusznosek0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's CC Mel.

On 3/4/20 3:22 PM, mateusznosek0@gmail.com wrote:
> From: Mateusz Nosek <mateusznosek0@gmail.com>
> 
> This patch makes ALLOC_KSWAPD
> equal to __GFP_KSWAPD_RACLAIM (cast to 'int').
> 
> Thanks to that code like:
> ```if (gfp_mask & __GFP_KSWAPD_RECLAIM)
> 		alloc_flags |= ALLOC_KSWAPD;```
> can be changed to:
> ```alloc_flags |= (__force int) (gfp_mask &__GFP_KSWAPD_RECLAIM);```
> Thanks to this one branch less is generated in the assembly.
> 
> In case of ALLOC_KSWAPD flag two branches are saved,
> first one in code that always executes in the beggining of page allocation
> and the second one in loop in page allocator slowpath.
> 
> Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>

I think it's fine and in line with similar optimisations done by Mel in the past.

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Some nits below.

> ---
>  mm/internal.h   |  2 +-
>  mm/page_alloc.c | 23 +++++++++++++++--------
>  2 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 86372d164476..7fb724977743 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -535,7 +535,7 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>  #else
>  #define ALLOC_NOFRAGMENT	  0x0
>  #endif
> -#define ALLOC_KSWAPD		0x200 /* allow waking of kswapd */
> +#define ALLOC_KSWAPD		0x800 /* allow waking of kswapd */

Add a comment that the value has to match the GFP flag?

>  
>  enum ttu_flags;
>  struct tlbflush_unmap_batch;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 79e950d76ffc..73afd883eab5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3609,10 +3609,14 @@ static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
>  static inline unsigned int
>  alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
>  {
> -	unsigned int alloc_flags = 0;
> +	unsigned int alloc_flags;
>  
> -	if (gfp_mask & __GFP_KSWAPD_RECLAIM)
> -		alloc_flags |= ALLOC_KSWAPD;
> +	/*
> +	 * __GFP_KSWAPD_RECLAIM is assumed to be the same as ALLOC_KSWAPD
> +	 * to save a branch.
> +	 */
> +	BUILD_BUG_ON(__GFP_KSWAPD_RECLAIM != (__force gfp_t) ALLOC_KSWAPD);

I think one BUILD_BUG_ON is enough...

> +	alloc_flags = (__force int) (gfp_mask & __GFP_KSWAPD_RECLAIM);
>  
>  #ifdef CONFIG_ZONE_DMA32
>  	if (!zone)
> @@ -4248,8 +4252,13 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
>  {
>  	unsigned int alloc_flags = ALLOC_WMARK_MIN | ALLOC_CPUSET;
>  
> -	/* __GFP_HIGH is assumed to be the same as ALLOC_HIGH to save a branch. */
> +	/*
> +	 * __GFP_HIGH is assumed to be the same as ALLOC_HIGH
> +	 * and __GFP_KSWAPD_RECLAIM is assumed to be the same as ALLOC_KSWAPD
> +	 * to save two branches.
> +	 */
>  	BUILD_BUG_ON(__GFP_HIGH != (__force gfp_t) ALLOC_HIGH);
> +	BUILD_BUG_ON(__GFP_KSWAPD_RECLAIM != (__force gfp_t) ALLOC_KSWAPD);

... and this would be the better one of the two.

Thanks.

>  
>  	/*
>  	 * The caller may dip into page reserves a bit more if the caller
> @@ -4257,7 +4266,8 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
>  	 * policy or is asking for __GFP_HIGH memory.  GFP_ATOMIC requests will
>  	 * set both ALLOC_HARDER (__GFP_ATOMIC) and ALLOC_HIGH (__GFP_HIGH).
>  	 */
> -	alloc_flags |= (__force int) (gfp_mask & __GFP_HIGH);
> +	alloc_flags |= (__force int)
> +		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
>  
>  	if (gfp_mask & __GFP_ATOMIC) {
>  		/*
> @@ -4274,9 +4284,6 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
>  	} else if (unlikely(rt_task(current)) && !in_interrupt())
>  		alloc_flags |= ALLOC_HARDER;
>  
> -	if (gfp_mask & __GFP_KSWAPD_RECLAIM)
> -		alloc_flags |= ALLOC_KSWAPD;
> -
>  #ifdef CONFIG_CMA
>  	if (gfpflags_to_migratetype(gfp_mask) == MIGRATE_MOVABLE)
>  		alloc_flags |= ALLOC_CMA;
> 

