Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F70C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7809920835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgFLQPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:15:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:43150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLQPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:15:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 39361AF4C;
        Fri, 12 Jun 2020 16:15:45 +0000 (UTC)
Subject: Re: [PATCH] mm, page_alloc: skip ->watermark_boost for atomic order-0
 allocations-fix
To:     Charan Teja Kalla <charante@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, linux-mm@kvack.org
Cc:     LKML <linux-kernel@vger.kernel.org>, vinmenon@codeaurora.org
References: <31556793-57b1-1c21-1a9d-22674d9bd938@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1a745bb9-9aca-cdee-e97e-991118b3d2b5@suse.cz>
Date:   Fri, 12 Jun 2020 18:15:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <31556793-57b1-1c21-1a9d-22674d9bd938@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/20 2:09 PM, Charan Teja Kalla wrote:
> When boosting is enabled, it is observed that rate of atomic order-0
> allocation failures are high due to the fact that free levels in the
> system are checked with ->watermark_boost offset. This is not a problem
> for sleepable allocations but for atomic allocations which looks like
> regression.
> 
> This problem is seen frequently on system setup of Android kernel
> running on Snapdragon hardware with 4GB RAM size. When no extfrag event
> occurred in the system, ->watermark_boost factor is zero, thus the
> watermark configurations in the system are:
>    _watermark = (
>           [WMARK_MIN] = 1272, --> ~5MB
>           [WMARK_LOW] = 9067, --> ~36MB
>           [WMARK_HIGH] = 9385), --> ~38MB
>    watermark_boost = 0
> 
> After launching some memory hungry applications in Android which can
> cause extfrag events in the system to an extent that ->watermark_boost
> can be set to max i.e. default boost factor makes it to 150% of high
> watermark.
>    _watermark = (
>           [WMARK_MIN] = 1272, --> ~5MB
>           [WMARK_LOW] = 9067, --> ~36MB
>           [WMARK_HIGH] = 9385), --> ~38MB
>    watermark_boost = 14077, -->~57MB
> 
> With default system configuration, for an atomic order-0 allocation to
> succeed, having free memory of ~2MB will suffice. But boosting makes
> the min_wmark to ~61MB thus for an atomic order-0 allocation to be
> successful system should have minimum of ~23MB of free memory(from
> calculations of zone_watermark_ok(), min = 3/4(min/2)). But failures are
> observed despite system is having ~20MB of free memory. In the testing,
> this is reproducible as early as first 300secs since boot and with
> furtherlowram configurations(<2GB) it is observed as early as first
> 150secs since boot.
> 
> These failures can be avoided by excluding the ->watermark_boost in
> watermark caluculations for atomic order-0 allocations.
> 
> Fix-suggested-by: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>

For the patch+fix:

Acked-by: Vlastimil Babka <vbabka@suse.cz>

The boost and highatomic stuff certainly made the whole thing more subtle.

> ---
> 
> Change in linux-next: https://lore.kernel.org/patchwork/patch/1244272/ 
> 
>  mm/page_alloc.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0c435b2..18f407e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3580,7 +3580,7 @@ bool zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
>  
>  static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
>  				unsigned long mark, int highest_zoneidx,
> -				unsigned int alloc_flags)
> +				unsigned int alloc_flags, gfp_t gfp_mask)
>  {
>  	long free_pages = zone_page_state(z, NR_FREE_PAGES);
>  	long cma_pages = 0;
> @@ -3602,8 +3602,23 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
>  				mark + z->lowmem_reserve[highest_zoneidx])
>  		return true;
>  
> -	return __zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
> -					free_pages);
> +	if (__zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
> +					free_pages))
> +		return true;
> +	/*
> +	 * Ignore watermark boosting for GFP_ATOMIC order-0 allocations
> +	 * when checking the min watermark. The min watermark is the
> +	 * point where boosting is ignored so that kswapd is woken up
> +	 * when below the low watermark.
> +	 */
> +	if (unlikely(!order && (gfp_mask & __GFP_ATOMIC) && z->watermark_boost
> +		&& ((alloc_flags & ALLOC_WMARK_MASK) == WMARK_MIN))) {
> +		mark = z->_watermark[WMARK_MIN];
> +		return __zone_watermark_ok(z, order, mark, highest_zoneidx,
> +					alloc_flags, free_pages);
> +	}
> +
> +	return false;
>  }
>  
>  bool zone_watermark_ok_safe(struct zone *z, unsigned int order,
> @@ -3746,20 +3761,9 @@ static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
>  		}
>  
>  		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
> -		/*
> -		 * Allow GFP_ATOMIC order-0 allocations to exclude the
> -		 * zone->watermark_boost in their watermark calculations.
> -		 * We rely on the ALLOC_ flags set for GFP_ATOMIC requests in
> -		 * gfp_to_alloc_flags() for this.  Reason not to use the
> -		 * GFP_ATOMIC directly is that we want to fall back to slow path
> -		 * thus wake up kswapd.
> -		 */
> -		if (unlikely(!order && !(alloc_flags & ALLOC_WMARK_MASK) &&
> -		     (alloc_flags & (ALLOC_HARDER | ALLOC_HIGH)))) {
> -			mark = zone->_watermark[WMARK_MIN];
> -		}
>  		if (!zone_watermark_fast(zone, order, mark,
> -				       ac->highest_zoneidx, alloc_flags)) {
> +				       ac->highest_zoneidx, alloc_flags,
> +				       gfp_mask)) {
>  			int ret;
>  
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> 

