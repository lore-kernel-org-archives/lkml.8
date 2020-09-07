Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9985AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E90221789
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgIGHcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:32:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:44270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgIGHck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:32:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AB77AB691;
        Mon,  7 Sep 2020 07:32:39 +0000 (UTC)
Date:   Mon, 7 Sep 2020 09:32:37 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, osalvador@suse.de, richard.weiyang@gmail.com,
        david@redhat.com, vbabka@suse.cz, rientjes@google.com
Subject: Re: [PATCH v3 2/2] mm: drain per-cpu pages outside of
 isolate_migratepages_range
Message-ID: <20200907073237.GG30144@dhcp22.suse.cz>
References: <20200904151448.100489-1-pasha.tatashin@soleen.com>
 <20200904151448.100489-3-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904151448.100489-3-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-09-20 11:14:48, Pavel Tatashin wrote:
> It is expensive to drain per-cpu page lists as a thread is started on each
> CPU, and we are waiting for them to complete.
> 
> Currently, we drain on every block of pages that is isolated. Instead lets
> drain once after pages are isolated.
> 
> For example, when 2G of memory is hot-removed drain is called 16 times,
> with this change it will be done only one time on average.

I do agree that the current implementation is much less effective than
it could be but I disagree we should be pushing the burden to all
callers as already stated
(http://lkml.kernel.org/r/20200907072608.GE30144@dhcp22.suse.cz).

I believe it should be perfectly fine to start_isolate_page_range would
improve the situation considerably. There are some minor details to sort
out (multizone pfn span which we do not allow but probably should be
enforcing somehow).

> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>

I believe we should be going an opposite direction and define a more
understandable and usable semantic for start_isolate_page_range. We do
not want callers to scratch their heads to call all caches they might
need to flush.

> ---
>  mm/memory_hotplug.c | 15 +--------------
>  mm/page_alloc.c     |  2 ++
>  mm/page_isolation.c | 40 ++++++++++++----------------------------
>  3 files changed, 15 insertions(+), 42 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index b11a269e2356..5a2ed1a94555 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1536,6 +1536,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  	}
>  
>  	do {
> +		drain_all_pages(zone);
>  		pfn = start_pfn;
>  		do {
>  			if (signal_pending(current)) {
> @@ -1575,20 +1576,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  		/* check again */
>  		ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
>  					    NULL, check_pages_isolated_cb);
> -		/*
> -		 * per-cpu pages are drained in start_isolate_page_range, but if
> -		 * there are still pages that are not free, make sure that we
> -		 * drain again, because when we isolated range we might
> -		 * have raced with another thread that was adding pages to pcp
> -		 * list.
> -		 *
> -		 * Forward progress should be still guaranteed because
> -		 * pages on the pcp list can only belong to MOVABLE_ZONE
> -		 * because has_unmovable_pages explicitly checks for
> -		 * PageBuddy on freed pages on other zones.
> -		 */
> -		if (ret)
> -			drain_all_pages(zone);
>  	} while (ret);
>  
>  	/* Ok, all of our target is isolated.
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fab5e97dc9ca..6d6a501a103e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8462,6 +8462,8 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  	if (ret < 0)
>  		return ret;
>  
> +	drain_all_pages(cc.zone);
> +
>  	/*
>  	 * In case of -EBUSY, we'd like to know which page causes problem.
>  	 * So, just fall through. test_pages_isolated() has a tracepoint
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 63a3db10a8c0..8dfa6c6c668d 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -19,8 +19,8 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>  {
>  	struct page *unmovable = NULL;
>  	struct zone *zone;
> -	unsigned long flags;
> -	int ret = -EBUSY;
> +	unsigned long flags, nr_pages;
> +	int ret = -EBUSY, mt;
>  
>  	zone = page_zone(page);
>  
> @@ -39,24 +39,18 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>  	 * We just check MOVABLE pages.
>  	 */
>  	unmovable = has_unmovable_pages(zone, page, migratetype, isol_flags);
> -	if (!unmovable) {
> -		unsigned long nr_pages;
> -		int mt = get_pageblock_migratetype(page);
> -
> -		set_pageblock_migratetype(page, MIGRATE_ISOLATE);
> -		zone->nr_isolate_pageblock++;
> -		nr_pages = move_freepages_block(zone, page, MIGRATE_ISOLATE,
> -									NULL);
> -
> -		__mod_zone_freepage_state(zone, -nr_pages, mt);
> -		ret = 0;
> -	}
> +	if (unmovable)
> +		goto out;
>  
> +	mt = get_pageblock_migratetype(page);
> +	set_pageblock_migratetype(page, MIGRATE_ISOLATE);
> +	zone->nr_isolate_pageblock++;
> +	nr_pages = move_freepages_block(zone, page, MIGRATE_ISOLATE, NULL);
> +	__mod_zone_freepage_state(zone, -nr_pages, mt);
> +	ret = 0;
>  out:
>  	spin_unlock_irqrestore(&zone->lock, flags);
> -	if (!ret) {
> -		drain_all_pages(zone);
> -	} else {
> +	if (ret) {
>  		WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
>  
>  		if ((isol_flags & REPORT_FAILURE) && unmovable)
> @@ -170,14 +164,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>   * pageblocks we may have modified and return -EBUSY to caller. This
>   * prevents two threads from simultaneously working on overlapping ranges.
>   *
> - * Please note that there is no strong synchronization with the page allocator
> - * either. Pages might be freed while their page blocks are marked ISOLATED.
> - * In some cases pages might still end up on pcp lists and that would allow
> - * for their allocation even when they are in fact isolated already. Depending
> - * on how strong of a guarantee the caller needs drain_all_pages might be needed
> - * (e.g. __offline_pages will need to call it after check for isolated range for
> - * a next retry).
> - *
>   * Return: the number of isolated pageblocks on success and -EBUSY if any part
>   * of range cannot be isolated.
>   */
> @@ -192,9 +178,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
>  	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
>  
> -	for (pfn = start_pfn;
> -	     pfn < end_pfn;
> -	     pfn += pageblock_nr_pages) {
> +	for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages) {
>  		page = __first_valid_page(pfn, pageblock_nr_pages);
>  		if (page) {
>  			if (set_migratetype_isolate(page, migratetype, flags)) {
> -- 
> 2.25.1
> 

-- 
Michal Hocko
SUSE Labs
