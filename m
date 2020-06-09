Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73274C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59C3E207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgFIM2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 08:28:15 -0400
Received: from outbound-smtp18.blacknight.com ([46.22.139.245]:54191 "EHLO
        outbound-smtp18.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726903AbgFIM2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 08:28:15 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp18.blacknight.com (Postfix) with ESMTPS id 512461C36B9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 13:28:13 +0100 (IST)
Received: (qmail 9958 invoked from network); 9 Jun 2020 12:28:13 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Jun 2020 12:28:13 -0000
Date:   Tue, 9 Jun 2020 13:28:11 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Charan Teja Reddy <charante@codeaurora.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
Subject: Re: [PATCH] mm, page_alloc: skip ->waternark_boost for atomic
 order-0 allocations
Message-ID: <20200609122811.GK3127@techsingularity.net>
References: <1589882284-21010-1-git-send-email-charante@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1589882284-21010-1-git-send-email-charante@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 03:28:04PM +0530, Charan Teja Reddy wrote:
> When boosting is enabled, it is observed that rate of atomic order-0
> allocation failures are high due to the fact that free levels in the
> system are checked with ->watermark_boost offset. This is not a problem
> for sleepable allocations but for atomic allocations which looks like
> regression.
> 

Are high-order allocations in general of interest to this platform? If
not then a potential option is to simply disable boosting. The patch is
still relevant but it's worth thinking about.

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
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
> ---
>  mm/page_alloc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d001d61..5193d7e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3709,6 +3709,18 @@ static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
>  		}
>  
>  		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
> +		/*
> +		 * Allow GFP_ATOMIC order-0 allocations to exclude the
> +		 * zone->watermark_boost in its watermark calculations.
> +		 * We rely on the ALLOC_ flags set for GFP_ATOMIC
> +		 * requests in gfp_to_alloc_flags() for this. Reason not to
> +		 * use the GFP_ATOMIC directly is that we want to fall back
> +		 * to slow path thus wake up kswapd.
> +		 */

The comment is a bit difficult to parse. Maybe this.

	/*
	 * Ignore watermark boosting for GFP_ATOMIC order-0 allocations
	 * when checking the min watermark. The min watermark is the
	 * point where boosting is ignored so that kswapd is woken up
	 * when below the low watermark.
	 */

I left out the ALLOC_ part for reasons that are explained blow.

> +		if (unlikely(!order && !(alloc_flags & ALLOC_WMARK_MASK) &&
> +		     (alloc_flags & (ALLOC_HARDER | ALLOC_HIGH)))) {
> +			mark = zone->_watermark[WMARK_MIN];
> +		}

The second check is a bit more obscure than it needs to be and depends
on WMARK_MIN == 0. That will probably be true forever but it's not
obvious at a glance. I suggest something like
((alloc_flags & ALLOC_WMARK_MASK) == WMARK_MIN).

For detecting atomic alloctions, you rely on the either ALLOC_HARDER or
ALLOC_HIGH being set. ALLOC_HIGH can be set for non-atomic allocations
and ALLOC_HARDER can be set for RT tasks. You probably should just test
the gfp_mask because as it stands non-atomic allocations can ignore the
boost too.

Finally, the patch puts an unlikely check into a relatively fast path even
though watermarks may be fine with or without boosting.  Instead you could
put the checks in zone_watermark_fast() if and only if the watermarks
failed the first time. If the checks pass, the watermarks get checked
a second time. This will be fractionally slower for requests failing
watermark checks but there is no penalty for most allocation requests.
It would need the gfp_mask to be passed into zone_watermark_fast but
as it's an inlined function, there should be no cost to passing in the
arguement i.e. do something like this at the end of zone_watermark_fast

	if (__zone_watermark_ok(z, order, mark, classzone_idx, alloc_flags, free_pages))
		return true;

	/* Ignore watermark boosting for .... */
	if (unlikely(!order .....) {
		mark = ...
		return __zone_watermark_ok(...);
	}

	return false;

-- 
Mel Gorman
SUSE Labs
