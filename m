Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DECDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C3C92075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589938812;
	bh=vzjx/GG0epcegWe9y4yfSLiBocv5o0cqoYzvBOLTx1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aBl1FAQ4g5HfXSPy75Se+gjwzJMllbu9St6PRUClmYL/kPzV+6A8XIZlpNbZ3ra9f
	 7rGrLAsPwMDlYIxw4k4T1jItPQh2me979/53xCTLp/CS2kjaeYLDV4fgxzj9M2bKuZ
	 6ur+ReiMJwLA1Iqf9cky2ksdGBq2vUr0f256RUrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgETBkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 21:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgETBkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:40:11 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F92F2075F;
        Wed, 20 May 2020 01:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589938810;
        bh=vzjx/GG0epcegWe9y4yfSLiBocv5o0cqoYzvBOLTx1Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K747CHeFDoQ4W6ne6KtAIviU1ur/mXBOwXYIj67Beeb6VcYIGSJbqNyFo6RPBoWux
         +zD3dxY0hQSCoCY/S/mooBdd7DMgA975xp2rq0sR1Swxfbjd/a5hte7WcWt/icTWdW
         mMUK5ON9SvdfRaHhCarZy333oXuqiF2tVn+qQxEw=
Date:   Tue, 19 May 2020 18:40:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Reddy <charante@codeaurora.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
Subject: Re: [PATCH] mm, page_alloc: skip ->waternark_boost for atomic
 order-0 allocations
Message-Id: <20200519184010.e77d25d7f6b853414e760d76@linux-foundation.org>
In-Reply-To: <1589882284-21010-1-git-send-email-charante@codeaurora.org>
References: <1589882284-21010-1-git-send-email-charante@codeaurora.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 15:28:04 +0530 Charan Teja Reddy <charante@codeaurora.org> wrote:

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

Seems sensible.

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

Nice comment, but I don't understand it ;)

Why would testing gfp_mask prevent us from waking kswapd?

> +		 */
> +		if (unlikely(!order && !(alloc_flags & ALLOC_WMARK_MASK) &&
> +		     (alloc_flags & (ALLOC_HARDER | ALLOC_HIGH)))) {
> +			mark = zone->_watermark[WMARK_MIN];
> +		}

Why is this not implemented for higher-order allocation attempts?

>  		if (!zone_watermark_fast(zone, order, mark,
>  				       ac->highest_zoneidx, alloc_flags)) {
>  			int ret;

