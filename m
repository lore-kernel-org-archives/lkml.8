Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D43C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E8C208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582140936;
	bh=RDjJ5dVglO5BdqvAvb/CkjrRRvovnXn/JiPmVDhEobY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AoA7u18Lq+9g6LIOwC1sjMYKD29J+YVPDUq2aSL3fIYMqpZdbeYl6ZPlyWwP3kZ5+
	 hHoP9Hag3YBlwvOf7DNokd1oUIuIjLpPyN7ZtGK852t9L9SF7622TFUJYH+C1Qr0Ep
	 4HeQFq9SAWR33iUk7dvoxfk4CFIX5BJrTX6OLyu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgBSTff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:35:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37302 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgBSTfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:35:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so1946352wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 11:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sju9vDe1bFh3XeOgGZeyRjwaJ6+Sv2HseVKq5/BaUPE=;
        b=CTYzYSRMGOEaLUetqs4w4wxVbekHDqu0+Azy4pkZoCxah9WYLz2ER9pwdQExIskRh/
         gZi64vUKEZNIXJl29wP04OJD2PkEWYKCqF4rcuimlBHxl/iehXHXWGLDn0GeK7m+12CM
         0ZblGhkJs+/jr1hRqSmekTK83UTH0CIGRDTE/7O1aUjClAjoDEAiTJoEAWq6MLiD+ux1
         VF6cRAxTOCf1Uv5YCjfn8juS47oBIXfSc6HC7cEA1+yKnywsHI7BhZJCwMJidjZN+Yfy
         OzkWFv1b4WBde4c1NfPUyaRF83t/uW9Xv08ez/js1GD19OQSEiZWXKxT5vCmtuSm5iv9
         T97A==
X-Gm-Message-State: APjAAAVW7oEQZBuVK/QetwMco3FsBuGfONxdRV3uTNI5JV7tKbOx5gQB
        mgguTaVrCUjRfIFEB3YrJ0/wT4Z5
X-Google-Smtp-Source: APXvYqw/Jvq4ocKxBvyJA8fZN1KBOpjCNSEjn/drMdFxgjVxLO6W3q9W6FWzTqlU1DZIq3IQKKYetA==
X-Received: by 2002:adf:b198:: with SMTP id q24mr38718990wra.188.1582140931664;
        Wed, 19 Feb 2020 11:35:31 -0800 (PST)
Received: from localhost (ip-37-188-133-21.eurotel.cz. [37.188.133.21])
        by smtp.gmail.com with ESMTPSA id 2sm921194wrq.31.2020.02.19.11.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 11:35:30 -0800 (PST)
Date:   Wed, 19 Feb 2020 20:35:29 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
Message-ID: <20200219193529.GD11847@dhcp22.suse.cz>
References: <20200219182522.1960-1-sultan@kerneltoast.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219182522.1960-1-sultan@kerneltoast.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Mel and Johannes]

On Wed 19-02-20 10:25:22, Sultan Alsawaf wrote:
> From: Sultan Alsawaf <sultan@kerneltoast.com>
> 
> Keeping kswapd running when all the failed allocations that invoked it
> are satisfied incurs a high overhead due to unnecessary page eviction
> and writeback, as well as spurious VM pressure events to various
> registered shrinkers. When kswapd doesn't need to work to make an
> allocation succeed anymore, stop it prematurely to save resources.

I do not think this patch is correct. kswapd is supposed to balance a
node and get it up to the high watermark. The number of contexts which
woke it up is not really relevant. If for no other reasons then each
allocation request might be of a different size.

Could you be more specific about the problem you are trying to address
please?

> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> ---
>  include/linux/mmzone.h |  2 ++
>  mm/page_alloc.c        | 17 ++++++++++++++---
>  mm/vmscan.c            |  3 ++-
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 462f6873905a..49c922abfb90 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -20,6 +20,7 @@
>  #include <linux/atomic.h>
>  #include <linux/mm_types.h>
>  #include <linux/page-flags.h>
> +#include <linux/refcount.h>
>  #include <asm/page.h>
>  
>  /* Free memory management - zoned buddy allocator.  */
> @@ -735,6 +736,7 @@ typedef struct pglist_data {
>  	unsigned long node_spanned_pages; /* total size of physical page
>  					     range, including holes */
>  	int node_id;
> +	refcount_t kswapd_waiters;
>  	wait_queue_head_t kswapd_wait;
>  	wait_queue_head_t pfmemalloc_wait;
>  	struct task_struct *kswapd;	/* Protected by
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3c4eb750a199..2d4caacfd2fc 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4401,6 +4401,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	int no_progress_loops;
>  	unsigned int cpuset_mems_cookie;
>  	int reserve_flags;
> +	pg_data_t *pgdat = ac->preferred_zoneref->zone->zone_pgdat;
> +	bool woke_kswapd = false;
>  
>  	/*
>  	 * We also sanity check to catch abuse of atomic reserves being used by
> @@ -4434,8 +4436,13 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	if (!ac->preferred_zoneref->zone)
>  		goto nopage;
>  
> -	if (alloc_flags & ALLOC_KSWAPD)
> +	if (alloc_flags & ALLOC_KSWAPD) {
> +		if (!woke_kswapd) {
> +			refcount_inc(&pgdat->kswapd_waiters);
> +			woke_kswapd = true;
> +		}
>  		wake_all_kswapds(order, gfp_mask, ac);
> +	}
>  
>  	/*
>  	 * The adjusted alloc_flags might result in immediate success, so try
> @@ -4640,9 +4647,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  		goto retry;
>  	}
>  fail:
> -	warn_alloc(gfp_mask, ac->nodemask,
> -			"page allocation failure: order:%u", order);
>  got_pg:
> +	if (woke_kswapd)
> +		refcount_dec(&pgdat->kswapd_waiters);
> +	if (!page)
> +		warn_alloc(gfp_mask, ac->nodemask,
> +				"page allocation failure: order:%u", order);
>  	return page;
>  }
>  
> @@ -6711,6 +6721,7 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
>  	pgdat_page_ext_init(pgdat);
>  	spin_lock_init(&pgdat->lru_lock);
>  	lruvec_init(&pgdat->__lruvec);
> +	pgdat->kswapd_waiters = (refcount_t)REFCOUNT_INIT(0);
>  }
>  
>  static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx, int nid,
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c05eb9efec07..e795add372d1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3694,7 +3694,8 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
>  		__fs_reclaim_release();
>  		ret = try_to_freeze();
>  		__fs_reclaim_acquire();
> -		if (ret || kthread_should_stop())
> +		if (ret || kthread_should_stop() ||
> +		    !refcount_read(&pgdat->kswapd_waiters))
>  			break;
>  
>  		/*
> -- 
> 2.25.1
> 

-- 
Michal Hocko
SUSE Labs
