Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8352C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 16:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB021208C7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 16:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgGCQSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 12:18:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:40504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgGCQSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 12:18:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CCE0DAB98;
        Fri,  3 Jul 2020 16:18:50 +0000 (UTC)
Subject: Re: [PATCH v3 8/8] mm/page_alloc: remove a wrapper for
 alloc_migration_target()
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-9-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <fe0df827-e9d0-ec92-f4e1-99cfc6a6b9e9@suse.cz>
Date:   Fri, 3 Jul 2020 18:18:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592892828-1934-9-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/20 8:13 AM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> There is a well-defined standard migration target callback.
> Use it directly.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

But you could move this to patch 5/8 to reduce churn. And do the same with
mm/memory-failure.c new_page() there really, to drop the simple wrappers. Only
new_node_page() is complex enough.
Hm wait, new_node_page() is only called by do_migrate_range() which is only
called by __offline_pages() with explicit test that all pages are from a single
zone, so the nmask could also be setup just once and not per each page, making
it possible to remove the wrapper.

But for new_page() you would have to define that mtc->nid == NUMA_NO_NODE means
alloc_migrate_target() does page_to_nid(page) by itself.



> ---
>  mm/page_alloc.c     |  9 +++++++--
>  mm/page_isolation.c | 11 -----------
>  2 files changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9808339..884dfb5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8359,6 +8359,11 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>  	unsigned long pfn = start;
>  	unsigned int tries = 0;
>  	int ret = 0;
> +	struct migration_target_control mtc = {
> +		.nid = zone_to_nid(cc->zone),
> +		.nmask = &node_states[N_MEMORY],
> +		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
> +	};
>  
>  	migrate_prep();
>  
> @@ -8385,8 +8390,8 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>  							&cc->migratepages);
>  		cc->nr_migratepages -= nr_reclaimed;
>  
> -		ret = migrate_pages(&cc->migratepages, alloc_migrate_target,
> -				    NULL, 0, cc->mode, MR_CONTIG_RANGE);
> +		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
> +				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
>  	}
>  	if (ret < 0) {
>  		putback_movable_pages(&cc->migratepages);
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index adba031..242c031 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -306,14 +306,3 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
>  
>  	return pfn < end_pfn ? -EBUSY : 0;
>  }
> -
> -struct page *alloc_migrate_target(struct page *page, unsigned long private)
> -{
> -	struct migration_target_control mtc = {
> -		.nid = page_to_nid(page),
> -		.nmask = &node_states[N_MEMORY],
> -		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
> -	};
> -
> -	return alloc_migration_target(page, (unsigned long)&mtc);
> -}
> 

