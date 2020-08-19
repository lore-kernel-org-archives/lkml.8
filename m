Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A13AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8DC0205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgHSNZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:25:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:50516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbgHSNQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:16:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 43FAAAB9F;
        Wed, 19 Aug 2020 13:16:43 +0000 (UTC)
Date:   Wed, 19 Aug 2020 15:16:15 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: Re: [PATCH v1 11/11] mm/memory_hotplug: mark pageblocks
 MIGRATE_ISOLATE while onlining memory
Message-ID: <20200819131615.GP5422@dhcp22.suse.cz>
References: <20200819101157.12723-1-david@redhat.com>
 <20200819101157.12723-12-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819101157.12723-12-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-08-20 12:11:57, David Hildenbrand wrote:
> Currently, it can happen that pages are allocated (and freed) via the buddy
> before we finished basic memory onlining.
> 
> For example, pages are exposed to the buddy and can be allocated before
> we actually mark the sections online. Allocated pages could suddenly
> fail pfn_to_online_page() checks. We had similar issues with pcp
> handling, when pages are allocated+freed before we reach
> zone_pcp_update() in online_pages() [1].
> 
> Instead, mark all pageblocks MIGRATE_ISOLATE, such that allocations are
> impossible. Once done with the heavy lifting, use
> undo_isolate_page_range() to move the pages to the MIGRATE_MOVABLE
> freelist, marking them ready for allocation. Similar to offline_pages(),
> we have to manually adjust zone->nr_isolate_pageblock.
> 
> [1] https://lkml.kernel.org/r/1597150703-19003-1-git-send-email-charante@codeaurora.org
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Charan Teja Reddy <charante@codeaurora.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Yes this looks very sensible and we should have done that from the
beginning. I just have one minor comment below
> @@ -816,6 +816,14 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  	if (ret)
>  		goto failed_addition;
>  
> +	/*
> +	 * Fixup the number of isolated pageblocks before marking the sections
> +	 * onlining, such that undo_isolate_page_range() works correctly.
> +	 */
> +	spin_lock_irqsave(&zone->lock, flags);
> +	zone->nr_isolate_pageblock += nr_pages / pageblock_nr_pages;
> +	spin_unlock_irqrestore(&zone->lock, flags);
> +

I am not entirely happy about this. I am wondering whether it would make
more sense to keep the counter in sync already in memmap_init_zone. Sure
we add a branch to the boot time initialization - and it always fails
there - but the code would be cleaner and we wouldn't have to do tricks
like this in caller(s).
-- 
Michal Hocko
SUSE Labs
