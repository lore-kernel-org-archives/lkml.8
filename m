Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53850C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 339C620855
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgHSNGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:06:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:36084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbgHSNAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:00:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80BE3B007;
        Wed, 19 Aug 2020 13:00:41 +0000 (UTC)
Date:   Wed, 19 Aug 2020 15:00:14 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1 07/11] mm/page_isolation: simplify return value of
 start_isolate_page_range()
Message-ID: <20200819130014.GL5422@dhcp22.suse.cz>
References: <20200819101157.12723-1-david@redhat.com>
 <20200819101157.12723-8-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819101157.12723-8-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-08-20 12:11:53, David Hildenbrand wrote:
> Callers no longer need the number of isolated pageblocks. Let's
> simplify.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c | 2 +-
>  mm/page_alloc.c     | 2 +-
>  mm/page_isolation.c | 7 ++-----
>  3 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 098361fcb4504..0011a1115381c 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1503,7 +1503,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  	ret = start_isolate_page_range(start_pfn, end_pfn,
>  				       MIGRATE_MOVABLE,
>  				       MEMORY_OFFLINE | REPORT_FAILURE);
> -	if (ret < 0) {
> +	if (ret) {
>  		reason = "failure to isolate range";
>  		goto failed_removal;
>  	}
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 03f585f95dc60..848664352dfe2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8456,7 +8456,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  
>  	ret = start_isolate_page_range(pfn_max_align_down(start),
>  				       pfn_max_align_up(end), migratetype, 0);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	/*
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 242c03121d731..b066c860e606e 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -170,8 +170,7 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>   * pageblocks we may have modified and return -EBUSY to caller. This
>   * prevents two threads from simultaneously working on overlapping ranges.
>   *
> - * Return: the number of isolated pageblocks on success and -EBUSY if any part
> - * of range cannot be isolated.
> + * Return: 0 on success and -EBUSY if any part of range cannot be isolated.
>   */
>  int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  			     unsigned migratetype, int flags)
> @@ -179,7 +178,6 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  	unsigned long pfn;
>  	unsigned long undo_pfn;
>  	struct page *page;
> -	int nr_isolate_pageblock = 0;
>  
>  	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
>  	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
> @@ -193,10 +191,9 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  				undo_pfn = pfn;
>  				goto undo;
>  			}
> -			nr_isolate_pageblock++;
>  		}
>  	}
> -	return nr_isolate_pageblock;
> +	return 0;
>  undo:
>  	for (pfn = start_pfn;
>  	     pfn < undo_pfn;
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
