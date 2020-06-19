Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADA0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 669D220809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akwekapH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgFSMmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:42:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48430 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725806AbgFSMmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592570539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4KXMic533YcPS5VVo5wuvVYlVuDVU7wg7J/EcjLpt0I=;
        b=akwekapHu9dzStlZ1XDhuNZ6xwsic2nhAotQQ/bPNP4gK7tW63gb0FcezbnNblAjxFYvQn
        s9mQjLN19+oP8aE4uUa4hwphjMlZlkp4gxPFY4gPW+xQTJ9/rIDDJxStr8lLxRseEPKbMU
        LKBmyQQXMbJyiHgKUa9ubnurv8bjsGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-S_vS5Qs9OvKQRZ4NrTyEhg-1; Fri, 19 Jun 2020 08:42:17 -0400
X-MC-Unique: S_vS5Qs9OvKQRZ4NrTyEhg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 607E9184D148;
        Fri, 19 Jun 2020 12:42:15 +0000 (UTC)
Received: from localhost (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EBB6B5BAC7;
        Fri, 19 Jun 2020 12:42:13 +0000 (UTC)
Date:   Fri, 19 Jun 2020 20:42:11 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     vbabka@suse.cz, mgorman@techsingularity.net, minchan@kernel.org,
        mgorman@suse.de, hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, ytk.lee@samsung.com,
        cmlaika.kim@samsung.com
Subject: Re: [PATCH v4] page_alloc: consider highatomic reserve in watermark
 fast
Message-ID: <20200619124211.GE3346@MiWiFi-R3L-srv>
References: <CGME20200619055816epcas1p184da90b01aff559fe3cd690ebcd921ca@epcas1p1.samsung.com>
 <20200619235958.11283-1-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619235958.11283-1-jaewon31.kim@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/20 at 08:59am, Jaewon Kim wrote:
...

> kswapd0-1207  [005] ...1   889.213398: mm_page_alloc: page= (null) pfn=0 order=0 migratetype=1 nr_free=3650 gfp_flags=GFP_NOWAIT|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_MOVABLE
> 
> Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
> Suggested-by: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Baoquan He <bhe@redhat.com>

> ---
> v4: change description only; typo and log
> v3: change log in description to one having reserved_highatomic
>     change comment in code
> v2: factor out common part
> v1: consider highatomic reserve
> ---
>  mm/page_alloc.c | 66 +++++++++++++++++++++++++++----------------------
>  1 file changed, 36 insertions(+), 30 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 48eb0f1410d4..fe83f88ce188 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3487,6 +3487,29 @@ static noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
>  }
>  ALLOW_ERROR_INJECTION(should_fail_alloc_page, TRUE);
>  
> +static inline long __zone_watermark_unusable_free(struct zone *z,
> +				unsigned int order, unsigned int alloc_flags)
> +{
> +	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
> +	long unusable_free = (1 << order) - 1;
> +
> +	/*
> +	 * If the caller does not have rights to ALLOC_HARDER then subtract
> +	 * the high-atomic reserves. This will over-estimate the size of the
> +	 * atomic reserve but it avoids a search.
> +	 */
> +	if (likely(!alloc_harder))
> +		unusable_free += z->nr_reserved_highatomic;
> +
> +#ifdef CONFIG_CMA
> +	/* If allocation can't use CMA areas don't use free CMA pages */
> +	if (!(alloc_flags & ALLOC_CMA))
> +		unusable_free += zone_page_state(z, NR_FREE_CMA_PAGES);
> +#endif
> +
> +	return unusable_free;
> +}
> +
>  /*
>   * Return true if free base pages are above 'mark'. For high-order checks it
>   * will return true of the order-0 watermark is reached and there is at least
> @@ -3502,19 +3525,12 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
>  	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
>  
>  	/* free_pages may go negative - that's OK */
> -	free_pages -= (1 << order) - 1;
> +	free_pages -= __zone_watermark_unusable_free(z, order, alloc_flags);
>  
>  	if (alloc_flags & ALLOC_HIGH)
>  		min -= min / 2;
>  
> -	/*
> -	 * If the caller does not have rights to ALLOC_HARDER then subtract
> -	 * the high-atomic reserves. This will over-estimate the size of the
> -	 * atomic reserve but it avoids a search.
> -	 */
> -	if (likely(!alloc_harder)) {
> -		free_pages -= z->nr_reserved_highatomic;
> -	} else {
> +	if (unlikely(alloc_harder)) {
>  		/*
>  		 * OOM victims can try even harder than normal ALLOC_HARDER
>  		 * users on the grounds that it's definitely going to be in
> @@ -3527,13 +3543,6 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
>  			min -= min / 4;
>  	}
>  
> -
> -#ifdef CONFIG_CMA
> -	/* If allocation can't use CMA areas don't use free CMA pages */
> -	if (!(alloc_flags & ALLOC_CMA))
> -		free_pages -= zone_page_state(z, NR_FREE_CMA_PAGES);
> -#endif
> -
>  	/*
>  	 * Check watermarks for an order-0 allocation request. If these
>  	 * are not met, then a high-order request also cannot go ahead
> @@ -3582,25 +3591,22 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
>  				unsigned long mark, int highest_zoneidx,
>  				unsigned int alloc_flags)
>  {
> -	long free_pages = zone_page_state(z, NR_FREE_PAGES);
> -	long cma_pages = 0;
> +	long free_pages;
> +	long unusable_free;
>  
> -#ifdef CONFIG_CMA
> -	/* If allocation can't use CMA areas don't use free CMA pages */
> -	if (!(alloc_flags & ALLOC_CMA))
> -		cma_pages = zone_page_state(z, NR_FREE_CMA_PAGES);
> -#endif
> +	free_pages = zone_page_state(z, NR_FREE_PAGES);
> +	unusable_free = __zone_watermark_unusable_free(z, order, alloc_flags);
>  
>  	/*
>  	 * Fast check for order-0 only. If this fails then the reserves
> -	 * need to be calculated. There is a corner case where the check
> -	 * passes but only the high-order atomic reserve are free. If
> -	 * the caller is !atomic then it'll uselessly search the free
> -	 * list. That corner case is then slower but it is harmless.
> +	 * need to be calculated.
>  	 */
> -	if (!order && (free_pages - cma_pages) >
> -				mark + z->lowmem_reserve[highest_zoneidx])
> -		return true;
> +	if (!order) {
> +		long fast_free = free_pages - unusable_free;
> +
> +		if (fast_free > mark + z->lowmem_reserve[highest_zoneidx])
> +			return true;
> +	}
>  
>  	return __zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
>  					free_pages);
> -- 
> 2.17.1
> 
> 

