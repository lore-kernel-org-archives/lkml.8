Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188FFC2BB84
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA381216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgIGH1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:27:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:41022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgIGH1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:27:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C9F43ACF2;
        Mon,  7 Sep 2020 07:27:01 +0000 (UTC)
Date:   Mon, 7 Sep 2020 09:27:00 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, osalvador@suse.de, richard.weiyang@gmail.com,
        david@redhat.com, vbabka@suse.cz, rientjes@google.com
Subject: Re: [PATCH v3 1/2] mm/memory_hotplug: drain per-cpu pages again
 during memory offline
Message-ID: <20200907072700.GF30144@dhcp22.suse.cz>
References: <20200904151448.100489-1-pasha.tatashin@soleen.com>
 <20200904151448.100489-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904151448.100489-2-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-09-20 11:14:47, Pavel Tatashin wrote:
> There is a race during page offline that can lead to infinite loop:
> a page never ends up on a buddy list and __offline_pages() keeps
> retrying infinitely or until a termination signal is received.
> 
> Thread#1 - a new process:
> 
> load_elf_binary
>  begin_new_exec
>   exec_mmap
>    mmput
>     exit_mmap
>      tlb_finish_mmu
>       tlb_flush_mmu
>        release_pages
>         free_unref_page_list
>          free_unref_page_prepare
>           set_pcppage_migratetype(page, migratetype);
>              // Set page->index migration type below  MIGRATE_PCPTYPES
> 
> Thread#2 - hot-removes memory
> __offline_pages
>   start_isolate_page_range
>     set_migratetype_isolate
>       set_pageblock_migratetype(page, MIGRATE_ISOLATE);
>         Set migration type to MIGRATE_ISOLATE-> set
>         drain_all_pages(zone);
>              // drain per-cpu page lists to buddy allocator.
> 
> Thread#1 - continue
>          free_unref_page_commit
>            migratetype = get_pcppage_migratetype(page);
>               // get old migration type
>            list_add(&page->lru, &pcp->lists[migratetype]);
>               // add new page to already drained pcp list
> 
> Thread#2
> Never drains pcp again, and therefore gets stuck in the loop.
> 
> The fix is to try to drain per-cpu lists again after
> check_pages_isolated_cb() fails.
> 
> Fixes: c52e75935f8d ("mm: remove extra drain pages on pcp list")
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: stable@vger.kernel.org
> Acked-by: David Rientjes <rientjes@google.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Already acked the mmotm version but let's add it here as well.
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c | 14 ++++++++++++++
>  mm/page_isolation.c |  8 ++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index e9d5ab5d3ca0..b11a269e2356 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1575,6 +1575,20 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  		/* check again */
>  		ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
>  					    NULL, check_pages_isolated_cb);
> +		/*
> +		 * per-cpu pages are drained in start_isolate_page_range, but if
> +		 * there are still pages that are not free, make sure that we
> +		 * drain again, because when we isolated range we might
> +		 * have raced with another thread that was adding pages to pcp
> +		 * list.
> +		 *
> +		 * Forward progress should be still guaranteed because
> +		 * pages on the pcp list can only belong to MOVABLE_ZONE
> +		 * because has_unmovable_pages explicitly checks for
> +		 * PageBuddy on freed pages on other zones.
> +		 */
> +		if (ret)
> +			drain_all_pages(zone);
>  	} while (ret);
>  
>  	/* Ok, all of our target is isolated.
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 242c03121d73..63a3db10a8c0 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -170,6 +170,14 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>   * pageblocks we may have modified and return -EBUSY to caller. This
>   * prevents two threads from simultaneously working on overlapping ranges.
>   *
> + * Please note that there is no strong synchronization with the page allocator
> + * either. Pages might be freed while their page blocks are marked ISOLATED.
> + * In some cases pages might still end up on pcp lists and that would allow
> + * for their allocation even when they are in fact isolated already. Depending
> + * on how strong of a guarantee the caller needs drain_all_pages might be needed
> + * (e.g. __offline_pages will need to call it after check for isolated range for
> + * a next retry).
> + *
>   * Return: the number of isolated pageblocks on success and -EBUSY if any part
>   * of range cannot be isolated.
>   */
> -- 
> 2.25.1
> 

-- 
Michal Hocko
SUSE Labs
