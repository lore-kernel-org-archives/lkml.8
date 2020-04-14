Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BB6C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C00E32072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgDNLty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:49:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:56442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729575AbgDNLtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:49:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5522CAD63;
        Tue, 14 Apr 2020 11:49:46 +0000 (UTC)
Subject: Re: [PATCH RFC] mm: compaction: avoid migrating non-cma pages to a
 cma area
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Qian Cai <cai@lca.pw>, Andrea Arcangeli <aarcange@redhat.com>,
        Joonsoo Kim <js1304@gmail.com>
References: <20200408194119.1076232-1-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <225868db-b9b0-3614-de0f-4b264023df2b@suse.cz>
Date:   Tue, 14 Apr 2020 13:49:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200408194119.1076232-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/20 9:41 PM, Roman Gushchin wrote:
> Compaction does treat cma pageblocks on pair with any movable
> pageblocks. It means it can easily move non-cma pages into a cma zone.
> 
> It can create problems for the cma allocator.
> 
> The particular problem I'm looking at is related to btrfs metadata
> pages, which are allocated without __GFP_MOVABLE, but beside that
> are generic pagecache pages. In fact, they are sometimes movable
> and sometimes not, depending on whether they are dirty and also
> on the extent buffer reference counter.

Hm I think I'd rather make such pages really unmovable (by a pin?) than deny the
whole CMA area to compaction. Would it be feasible?

> Compaction moves them to the hugetlb_cma area, and then sometimes
> the cma allocator fails to move them back from the cma area. It
> results in failures of gigantic hugepages allocations.
> 
> Also in general cma areas are reserved close to the end of a zone,
> and it's where compaction tries to migrate pages. It means
> compaction will aggressively fill cma areas, which makes not much
> sense.

So now the free page scanner will have to skip those areas, which is not much
effective. But I suspect a worse problem in __compaction_suitable() which will
now falsely report that there are enough free pages, so compaction will start
but fail to do anytning. Minimally the __zone_watermark_ok() check there would
have to lose ALLOC_CMA, but there might be other similar checks that would need
adjusting.

And long-term what happens if the "CMA using ZONE_MOVABLE" approach is merged
and there are not more CMA migratetypes to test? Might this change actually also
avoid your issue, as said pages without __GFP_MOVABLE won't end up in a
ZONE_MOVABLE?

> So to avoid it, let's preserve non-cma pages from being moved into
> a cma area. Because cma areas are usually quite large and the number
> of areas is small, it should not significantly affect the memory
> fragmentation.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/compaction.c | 6 ++++++
>  mm/internal.h   | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 46f0fcc93081..9b047cbb1c74 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1159,6 +1159,10 @@ static bool suitable_migration_target(struct compact_control *cc,
>  			return false;
>  	}
>  
> +	/* Do not bring pages non-cma pages into a cma area */
> +	if (is_migrate_cma(get_pageblock_migratetype(page)) && !cc->cma)
> +		return false;
> +
>  	if (cc->ignore_block_suitable)
>  		return true;
>  
> @@ -1832,6 +1836,8 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>  		if (!low_pfn)
>  			return ISOLATE_ABORT;
>  
> +		cc->cma = is_migrate_cma(get_pageblock_migratetype(page));
> +
>  		/*
>  		 * Either we isolated something and proceed with migration. Or
>  		 * we failed and compact_zone should decide if we should
> diff --git a/mm/internal.h b/mm/internal.h
> index b5634e78f01d..0ce649da824b 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -232,6 +232,7 @@ struct compact_control {
>  	bool contended;			/* Signal lock or sched contention */
>  	bool rescan;			/* Rescanning the same pageblock */
>  	bool alloc_contig;		/* alloc_contig_range allocation */
> +	bool cma;			/* migratepages contains cma pages */
>  };
>  
>  /*
> 

