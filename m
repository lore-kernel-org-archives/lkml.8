Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BF1C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC54D20848
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbgCDPPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:15:19 -0500
Received: from outbound-smtp31.blacknight.com ([81.17.249.62]:48434 "EHLO
        outbound-smtp31.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726740AbgCDPPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:15:18 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id EC871C0B3B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Mar 2020 15:15:15 +0000 (GMT)
Received: (qmail 18781 invoked from network); 4 Mar 2020 15:15:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Mar 2020 15:15:15 -0000
Date:   Wed, 4 Mar 2020 15:15:13 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     mateusznosek0@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [RFC PATCH] mm: Micro-optimisation: Save two branches on hot -
 page allocation path
Message-ID: <20200304151513.GO3818@techsingularity.net>
References: <20200304142230.8753-1-mateusznosek0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200304142230.8753-1-mateusznosek0@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 03:22:30PM +0100, mateusznosek0@gmail.com wrote:
> From: Mateusz Nosek <mateusznosek0@gmail.com>
> 
> This patch makes ALLOC_KSWAPD
> equal to __GFP_KSWAPD_RACLAIM (cast to 'int').
> 

s/RACLAIM/RECLAIM/

Very strange word wrapping

> Thanks to that code like:
> ```if (gfp_mask & __GFP_KSWAPD_RECLAIM)
> 		alloc_flags |= ALLOC_KSWAPD;```
> can be changed to:
> ```alloc_flags |= (__force int) (gfp_mask &__GFP_KSWAPD_RECLAIM);```

Not sure what the multiple ``` are about. It does not appear to be an
encoding error but I think you can drop them. Maybe some mail readers
render this differently but it looks weird in plain text.

> Thanks to this one branch less is generated in the assembly.
> 
> In case of ALLOC_KSWAPD flag two branches are saved,
> first one in code that always executes in the beggining of page allocation

s/beggining/beginning/

> and the second one in loop in page allocator slowpath.

Also strange word wrapping.

> 
> Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
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
> +	alloc_flags = (__force int) (gfp_mask & __GFP_KSWAPD_RECLAIM);
>  
>  #ifdef CONFIG_ZONE_DMA32
>  	if (!zone)

Ok, that looks reasonable.

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
>  
>  	/*
>  	 * The caller may dip into page reserves a bit more if the caller

As Vlastimil pointed out, you do not need to make two compiler-based
checks. This seems like a reasonable location given that gfp_to_alloc_flags
is the most obvious place to document tricks with the flags.

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

Slightly harder to read but it does potentially generate better code.

If you correct the typos in the changelog, the slightly strange formatting
of the changelog and drop one of the build checks then you can add

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
