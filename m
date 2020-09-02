Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DFCC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D2220829
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgIBOWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:22:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:33372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbgIBOLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:11:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91439B64A;
        Wed,  2 Sep 2020 14:10:59 +0000 (UTC)
Date:   Wed, 2 Sep 2020 16:10:57 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] mm/memory_hotplug: drain per-cpu pages again during
 memory offline
Message-ID: <20200902141057.GK4617@dhcp22.suse.cz>
References: <20200901124615.137200-1-pasha.tatashin@soleen.com>
 <20200902140116.GI4617@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902140116.GI4617@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-09-20 16:01:17, Michal Hocko wrote:
> [Cc Mel and Vlastimil - I am still rummaging]
> 
> On Tue 01-09-20 08:46:15, Pavel Tatashin wrote:
> > There is a race during page offline that can lead to infinite loop:
> > a page never ends up on a buddy list and __offline_pages() keeps
> > retrying infinitely or until a termination signal is received.
> > 
> > Thread#1 - a new process:
> > 
> > load_elf_binary
> >  begin_new_exec
> >   exec_mmap
> >    mmput
> >     exit_mmap
> >      tlb_finish_mmu
> >       tlb_flush_mmu
> >        release_pages
> >         free_unref_page_list
> >          free_unref_page_prepare
> >           set_pcppage_migratetype(page, migratetype);
> >              // Set page->index migration type below  MIGRATE_PCPTYPES
> > 
> > Thread#2 - hot-removes memory
> > __offline_pages
> >   start_isolate_page_range
> >     set_migratetype_isolate
> >       set_pageblock_migratetype(page, MIGRATE_ISOLATE);
> >         Set migration type to MIGRATE_ISOLATE-> set
> >         drain_all_pages(zone);
> >              // drain per-cpu page lists to buddy allocator.
> > 
> > Thread#1 - continue
> >          free_unref_page_commit
> >            migratetype = get_pcppage_migratetype(page);
> >               // get old migration type
> >            list_add(&page->lru, &pcp->lists[migratetype]);
> >               // add new page to already drained pcp list
> > 
> > Thread#2
> > Never drains pcp again, and therefore gets stuck in the loop.
> > 
> > The fix is to try to drain per-cpu lists again after
> > check_pages_isolated_cb() fails.

Still trying to wrap my head around this but I think this is not a
proper fix. It should be the page isolation to make sure no races are
possible with the page freeing path.

> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  mm/memory_hotplug.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index e9d5ab5d3ca0..d6d54922bfce 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1575,6 +1575,15 @@ static int __ref __offline_pages(unsigned long start_pfn,
> >  		/* check again */
> >  		ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
> >  					    NULL, check_pages_isolated_cb);
> > +		/*
> > +		 * per-cpu pages are drained in start_isolate_page_range, but if
> > +		 * there are still pages that are not free, make sure that we
> > +		 * drain again, because when we isolated range we might
> > +		 * have raced with another thread that was adding pages to
> > +		 * pcp list.
> > +		 */
> > +		if (ret)
> > +			drain_all_pages(zone);
> >  	} while (ret);
> >  
> >  	/* Ok, all of our target is isolated.
> > -- 
> > 2.25.1
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
