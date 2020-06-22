Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78444C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F21206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592817075;
	bh=W+2fOTalXcH+BFU6IMu+lI82IOLgmPJcKGlWx4JFkrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jQKEJ7aSpgy01ZU0rK/Re1udMrJ5HlwE9QIdgH1z8pWytgFCyntfO/gYtoKXwi5a8
	 eACSo5FEQfx+AZ62/u0lhgku1TF8Jzjd+Fdk+kYMFV81XvC3PHVbL7Nze9ACkNIS5z
	 iKBpm08Sd2j6ZvNm0Ii1uq/UmuBcw7bVwDDNFUas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgFVJLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:11:14 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:34943 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgFVJLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:11:13 -0400
Received: by mail-ej1-f65.google.com with SMTP id rk21so871929ejb.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9/+aOAfZgXui7cSklavAcs2VaIRNoYeZzPEiqozaFt4=;
        b=MVNn/Gp1txtUERpJF27Fjo3pA/5lC5aOW4VFGtkWvrnqJX6BH4mIyVasE2EYkV0RdU
         d83YyeduvVJ6EnAwvg9BKyqh6cEBrCsueFWnPtwgQPjKnC+HDglwVhErXYcv7Wh8nI0O
         wI6sGlP0iPJEWVxMCnDJ3cDe9jcbICzq0X2jIuYVjka0JLdrD6kG+5qOr/R+pW+pIFND
         YgAC+8evinuGjVR0HKYTH1lvUceJPtxsISl9vvCl43I77EYCFcr99CS0jC5xww8OJciO
         ChPbVqIJoHQq0AUqeFV+d+7RwPLCMEEiLPox6GoXv4XjuAP1mDbe3VB8c+yj3H3xbzWe
         FSgg==
X-Gm-Message-State: AOAM533lENvfVXcOSUw83M4k3ROLK7hWjTy36TX8PUehF1QSaw/gtMle
        qNDhI5+KkG32uJQF8xJ7MRo=
X-Google-Smtp-Source: ABdhPJyX3qvBAqhH7CUaP2WbSDBYBZjOngkM2TgbzwevZSibP9vNVRV5TQimWNm/ZNotvqD4cdIU6g==
X-Received: by 2002:a17:906:1394:: with SMTP id f20mr6249593ejc.114.1592817070665;
        Mon, 22 Jun 2020 02:11:10 -0700 (PDT)
Received: from localhost (ip-37-188-173-135.eurotel.cz. [37.188.173.135])
        by smtp.gmail.com with ESMTPSA id f17sm12280462edj.32.2020.06.22.02.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 02:11:09 -0700 (PDT)
Date:   Mon, 22 Jun 2020 11:11:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     vbabka@suse.cz, bhe@redhat.com, mgorman@techsingularity.net,
        minchan@kernel.org, mgorman@suse.de, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com,
        ytk.lee@samsung.com, cmlaika.kim@samsung.com
Subject: Re: [PATCH v4] page_alloc: consider highatomic reserve in watermark
 fast
Message-ID: <20200622091107.GC31426@dhcp22.suse.cz>
References: <CGME20200619055816epcas1p184da90b01aff559fe3cd690ebcd921ca@epcas1p1.samsung.com>
 <20200619235958.11283-1-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619235958.11283-1-jaewon31.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat 20-06-20 08:59:58, Jaewon Kim wrote:
[...]
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
[...]
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

There is no user of unusable_free for order > 0. With you current code
__zone_watermark_unusable_free would be called twice for high order
allocations unless compiler tries to be clever..

But more importantly, I have hard time to follow why we need both
zone_watermark_fast and zone_watermark_ok now. They should be
essentially the same for anything but order == 0. For order 0 the
only difference between the two is that zone_watermark_ok checks for
ALLOC_HIGH resp ALLOC_HARDER, ALLOC_OOM. So what is exactly fast about
the former and why do we need it these days?

> 
>  	return __zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
>  					free_pages);
> -- 
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs
