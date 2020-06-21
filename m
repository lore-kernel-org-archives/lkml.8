Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F4AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D81DE251DE
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592750859;
	bh=S87e6iw2gADE5fF4P/mYpr9WJ1jguflXVfGbua8uZcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vqd5Q+CXMuL/E0mI9dnx71X0PcCqMGkpZDrC5icGb4pHieMA9GJSH3OryJ3Y5xf1a
	 Mobo0uezXQMuhu1N/o8VkUztzyLx/r1r8iEX0V9lkm9ZxDoF0uLkeO0xE0qRXghKg/
	 8Ag02L/mJpccbn+2oa7qvZwqNiKpPIHjY3SxTCsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgFUOri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 10:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730154AbgFUOri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 10:47:38 -0400
Received: from kernel.org (unknown [87.70.7.255])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CA502486F;
        Sun, 21 Jun 2020 14:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592750857;
        bh=S87e6iw2gADE5fF4P/mYpr9WJ1jguflXVfGbua8uZcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TaZdrotIJetYwWuE9R2OQijL0u6N39Jmg2CkdrdtS/HAoygzCuS31Rw3h6qeMbUZy
         jYck7qtdNwRiq7MBIwzgplfcr3jjjjEIfR3Ott8qR0QdkyYucy1eSDtMSjnbrbqpyf
         fl0hu8imq/dcooRx8AcoLVMoUvFi2AqsNVUMULT4=
Date:   Sun, 21 Jun 2020 17:47:28 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 2/2] mm/page_alloc: drop nr_free_pagecache_pages()
Message-ID: <20200621144728.GG6571@kernel.org>
References: <20200619132410.23859-1-david@redhat.com>
 <20200619132410.23859-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619132410.23859-3-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 03:24:10PM +0200, David Hildenbrand wrote:
> nr_free_pagecache_pages() isn't used outside page_alloc.c anymore - and
> the name does not really help to understand what's going on. Let's inline
> it instead and add a comment.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/swap.h |  1 -
>  mm/page_alloc.c      | 16 ++--------------
>  2 files changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 124261acd5d0a..9bde6c6b2c045 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -327,7 +327,6 @@ void workingset_update_node(struct xa_node *node);
>  /* linux/mm/page_alloc.c */
>  extern unsigned long totalreserve_pages;
>  extern unsigned long nr_free_buffer_pages(void);
> -extern unsigned long nr_free_pagecache_pages(void);
>  
>  /* Definition of global_zone_page_state not available yet */
>  #define nr_free_pages() global_zone_page_state(NR_FREE_PAGES)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7b0dde69748c1..c38903d1b3b4d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5177,19 +5177,6 @@ unsigned long nr_free_buffer_pages(void)
>  }
>  EXPORT_SYMBOL_GPL(nr_free_buffer_pages);
>  
> -/**
> - * nr_free_pagecache_pages - count number of pages beyond high watermark
> - *
> - * nr_free_pagecache_pages() counts the number of pages which are beyond the
> - * high watermark within all zones.
> - *
> - * Return: number of pages beyond high watermark within all zones.
> - */
> -unsigned long nr_free_pagecache_pages(void)
> -{
> -	return nr_free_zone_pages(gfp_zone(GFP_HIGHUSER_MOVABLE));
> -}
> -
>  static inline void show_node(struct zone *zone)
>  {
>  	if (IS_ENABLED(CONFIG_NUMA))
> @@ -5911,7 +5898,8 @@ void __ref build_all_zonelists(pg_data_t *pgdat)
>  		__build_all_zonelists(pgdat);
>  		/* cpuset refresh routine should be here */
>  	}
> -	vm_total_pages = nr_free_pagecache_pages();
> +	/* Get the number of free pages beyond high watermark in all zones. */
> +	vm_total_pages = nr_free_zone_pages(gfp_zone(GFP_HIGHUSER_MOVABLE));
>  	/*
>  	 * Disable grouping by mobility if the number of pages in the
>  	 * system is too low to allow the mechanism to work. It would be
> -- 
> 2.26.2
> 
> 

-- 
Sincerely yours,
Mike.
